CREATE OR REPLACE PACKAGE PCP.MANTENIMIENTO_TABLAS_PCP_HIST_PKG AS
    TYPE t_credit_ids IS TABLE OF NUMBER;
    
    PROCEDURE MANTENIMIENTO_PCP_HIST_DIARIO (
        P_MONTHS_RETENTION_H   IN NUMBER,
        P_OUT_DATA             OUT VARCHAR2,
        P_ID_ORDEN             IN NUMBER DEFAULT NULL,
        P_START_DATE           IN DATE DEFAULT NULL,
        P_END_DATE             IN DATE DEFAULT NULL,
        P_SKIP_ORDEN_MIGRATION IN VARCHAR2 DEFAULT 'N',
        P_ID_TORDEN            IN NUMBER DEFAULT NULL
    );
    
    PROCEDURE ELIMINAR_PARTICIONES_VACIAS;
    
END MANTENIMIENTO_TABLAS_PCP_HIST_PKG;
/


CREATE OR REPLACE PACKAGE BODY PCP.MANTENIMIENTO_TABLAS_PCP_HIST_PKG AS

    MANTENIMIENTO_PROCESS_NAME VARCHAR2(30) := 'MANTENIMIENTO_PCP_HIST_DIARIO';
    T_MONTHS_RETENTION_H      VARCHAR2(30) := 'T_MONTHS_RETENTION_PCP_HIST';
    yes                       VARCHAR2(1)  := 'Y';
    V_NO                      VARCHAR2(1)  := 'N';
    V_MM                      VARCHAR2(2)  := 'MM';    

    c_debug CONSTANT BOOLEAN := true;
    c_db_link CONSTANT VARCHAR2(30) := 'PCPHD_DBLINK';
    c_batch_size CONSTANT NUMBER := 50000;

    FUNCTION is_process_active RETURN VARCHAR2 IS
        v_active VARCHAR2(1);
    BEGIN
        BEGIN
            SELECT IS_ACTIVE INTO v_active
            FROM PROCESS_CONTROL
            WHERE PROCESS_NAME = MANTENIMIENTO_PROCESS_NAME
            FOR UPDATE;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RETURN 'N';
        END;
        RETURN v_active;
    END is_process_active;

    PROCEDURE MANTENIMIENTO_PCP_HIST_DIARIO (
        P_MONTHS_RETENTION_H   IN NUMBER,
        P_OUT_DATA             OUT VARCHAR2,
        P_ID_ORDEN             IN NUMBER DEFAULT NULL,
        P_START_DATE           IN DATE DEFAULT NULL,
        P_END_DATE             IN DATE DEFAULT NULL,
        P_SKIP_ORDEN_MIGRATION IN VARCHAR2 DEFAULT 'N',
        P_ID_TORDEN            IN NUMBER DEFAULT NULL
    ) IS
        -- Todas las variables originales se mantienen igual
        l_count_orden_success  NUMBER := 0;
        l_count_orden_error    NUMBER := 0;
        l_count_debits         NUMBER := 0;
        l_count_credits        NUMBER := 0;
        l_count_credits_inm    NUMBER := 0;
        l_count_datos_mov      NUMBER := 0;
        l_count_logs           NUMBER := 0;
        l_count_details        NUMBER := 0;
        l_count_track          NUMBER := 0;
        l_start_time           TIMESTAMP;
        l_minutes              NUMBER;
        V_MONTHS_RETENTION_H   NUMBER;
        
        l_t_orden    NUMBER := 0;
        l_t_debits   NUMBER := 0;
        l_t_credits  NUMBER := 0;
        
        l_err_duplicado        NUMBER := 0;
        l_err_particion        NUMBER := 0;
        l_err_otros            NUMBER := 0;
        
        TYPE orden_id_table IS TABLE OF NUMBER;
        l_orden_ids orden_id_table;
        
        -- Variables nuevas para la migración de TORDEN
        l_count_torden_ok    NUMBER := 0;
        l_count_torden_err   NUMBER := 0;
        l_count_talta_ok     NUMBER := 0;
        l_count_talta_err    NUMBER := 0;
        l_count_track_lote   NUMBER := 0;
        l_count_detail       NUMBER := 0;
        l_count_detail_alta  NUMBER := 0;
        v_months_retention   NUMBER;
        TYPE t_id_table IS TABLE OF NUMBER;
        l_torden_ids   t_id_table;
        l_talta_ids    t_id_table;
        
        PROCEDURE debug(p_msg VARCHAR2) IS
        BEGIN
            IF c_debug THEN
                DBMS_OUTPUT.PUT_LINE(p_msg);
            END IF;
        END debug;
        
        FUNCTION elapsed_sec(p_start TIMESTAMP, p_end TIMESTAMP) RETURN NUMBER IS
        BEGIN
            RETURN EXTRACT(SECOND FROM (p_end - p_start)) +
                   EXTRACT(MINUTE FROM (p_end - p_start)) * 60 +
                   EXTRACT(HOUR   FROM (p_end - p_start)) * 3600;
        END elapsed_sec;
        
    BEGIN 
        l_start_time := SYSTIMESTAMP;
        
        IF is_process_active = V_NO THEN    
            UPDATE PROCESS_CONTROL 
            SET IS_ACTIVE = yes, DATE_ACTIVE = SYSDATE
            WHERE PROCESS_NAME = MANTENIMIENTO_PROCESS_NAME;
            
            IF P_ID_ORDEN IS NULL AND P_START_DATE IS NULL AND P_END_DATE IS NULL THEN
                IF P_MONTHS_RETENTION_H > 0 THEN
                    V_MONTHS_RETENTION_H := P_MONTHS_RETENTION_H;
                ELSE
                    BEGIN
                        SELECT NVL(P.VALOR, 12) INTO V_MONTHS_RETENTION_H 
                        FROM PARAMETROS_PCP P WHERE P.NOMBRE_CAMPO = T_MONTHS_RETENTION_H;
                    EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                            V_MONTHS_RETENTION_H := 12;
                    END;
                END IF;
            END IF;
            
        IF P_SKIP_ORDEN_MIGRATION = 'N' THEN
            -- ============================================================
            -- BLOQUE ORIGINAL: Migración de ORDEN, DEBITS, CREDITS (NO MODIFICADO)
            -- ============================================================
            IF P_ID_ORDEN IS NOT NULL THEN
                debug('DEBUG: Buscando orden específica ' || P_ID_ORDEN);
                SELECT ID_ORDEN 
                BULK COLLECT INTO l_orden_ids
                FROM ORDEN 
                WHERE ID_ORDEN = P_ID_ORDEN;
                
                IF l_orden_ids.COUNT = 0 THEN
                    P_OUT_DATA := '04 No existe la orden con ID: ' || P_ID_ORDEN;
                    UPDATE PROCESS_CONTROL SET IS_ACTIVE = V_NO WHERE PROCESS_NAME = MANTENIMIENTO_PROCESS_NAME;
                    COMMIT;
                    --RETURN;
                END IF;
            ELSE
                IF P_START_DATE IS NOT NULL AND P_END_DATE IS NOT NULL THEN
                    debug('DEBUG: Buscando órdenes para la semana ' || TO_CHAR(P_START_DATE,'YYYY-MM-DD') || ' a ' || TO_CHAR(P_END_DATE,'YYYY-MM-DD'));
                    SELECT DISTINCT ID_ORDEN
                    BULK COLLECT INTO l_orden_ids
                    FROM DEBITS
                    WHERE ID_ORDEN IS NOT NULL
                    GROUP BY ID_ORDEN
                    HAVING MAX(PROCESS_DATE) >= P_START_DATE
                       AND MAX(PROCESS_DATE) <  P_END_DATE + 1;
                ELSE
                    debug('DEBUG: Buscando órdenes con antigüedad de ' || V_MONTHS_RETENTION_H || ' meses');
                    SELECT DISTINCT ID_ORDEN
                    BULK COLLECT INTO l_orden_ids
                    FROM DEBITS
                    WHERE ID_ORDEN IS NOT NULL
                    GROUP BY ID_ORDEN
                    HAVING MAX(PROCESS_DATE) <= ADD_MONTHS(SYSDATE, -V_MONTHS_RETENTION_H);
                END IF;
                
                IF l_orden_ids.COUNT = 0 THEN
                    P_OUT_DATA := '04 No hay registros para el mantenimiento de ORDEN';
                    UPDATE PROCESS_CONTROL SET IS_ACTIVE = V_NO WHERE PROCESS_NAME = MANTENIMIENTO_PROCESS_NAME;
                    COMMIT;
                   -- RETURN;
                END IF;
            END IF;
            
            debug('DEBUG: Total órdenes a procesar: ' || l_orden_ids.COUNT);
            
            -- BUCLE DE PROCESAMIENTO DE ÓRDENES (NO MODIFICADO)
            FOR idx IN 1..l_orden_ids.COUNT
            LOOP
                SAVEPOINT sp_orden;
                DECLARE
                    v_orden_id NUMBER := l_orden_ids(idx);
                    v_debit_ids SYS.ODCINUMBERLIST;
                    v_credits_count NUMBER := 0;
                    v_credits_inm_count NUMBER := 0;
                    v_datos_mov_count NUMBER := 0;
                    v_logs_count NUMBER := 0;
                    v_details_count NUMBER := 0;
                    v_track_count NUMBER := 0;
                    v_max_debit_date DATE;
                    v_debits_count NUMBER := 0;
                    
                    v_start_orden  TIMESTAMP;
                    v_start_debits TIMESTAMP;
                    v_start_credits TIMESTAMP;
                    
                    v_min_credit_id NUMBER;
                    v_max_credit_id NUMBER;
                    v_current_min NUMBER;
                    v_current_max NUMBER;
                BEGIN
                    debug('DEBUG: Iniciando procesamiento de orden ' || v_orden_id);
                    
                    -- Fecha máxima del débito
                    BEGIN
                        SELECT MAX(PROCESS_DATE)
                        INTO v_max_debit_date
                        FROM DEBITS
                        WHERE ID_ORDEN = v_orden_id;
                        
                        IF v_max_debit_date IS NULL THEN
                            v_max_debit_date := SYSDATE;
                        END IF;
                        debug('DEBUG: v_max_debit_date = ' || TO_CHAR(v_max_debit_date, 'YYYY-MM-DD HH24:MI:SS'));
                    EXCEPTION
                        WHEN OTHERS THEN
                            debug('ERROR al obtener v_max_debit_date: ' || SQLERRM);
                            RAISE;
                    END;
                    
                    -- PASO 1: Insertar ORDEN y ORDEN_DETAIL en HIST
                    v_start_orden := SYSTIMESTAMP;
                    BEGIN
                        debug('DEBUG: Insertando ORDEN_HIST para orden ' || v_orden_id);
                        EXECUTE IMMEDIATE '
                            INSERT INTO ORDEN_HIST@' || c_db_link || '
                                (ID_ORDEN, ID_NUM_REQUEST, REFERENCE_NUMBER_LOTE, CUSTOMER_DESCRIPTION, CUSTOMER_ID,
                                 ACCOUNT_NUMBER, TOTAL_NUM_DEBITS, TOTAL_NUM_CREDITS, TOTAL_AMOUNT, STATUS,
                                 DATE_VALUE, RECORD_ENTRY_DATE, IS_LOADED_FROM_STG, PRODUCT_NAME, BUSINESS_STATUS_CODE,
                                 NUMERO_TICKET, ENVIADO_EMPRESA, TOTAL_DEBITOS_PROCESADOS, TOTAL_DEBITOS_RECHAZADOS,
                                 TOTAL_CREDITOS_PROCESADOS, TOTAL_CREDITOS_RECHAZADOS, FECHA_APROBACION,
                                 FECHA_ENVIO_MONITOR, FECHA_RECEPCION_MONITOR, RESPUESTA_MONITOR, EXPIRADO_MONITOR, 
                                 ENVIADO_MONITOR)
                            SELECT 
                                ID_ORDEN, ID_NUM_REQUEST, REFERENCE_NUMBER_LOTE, CUSTOMER_DESCRIPTION, CUSTOMER_ID,
                                ACCOUNT_NUMBER, TOTAL_NUM_DEBITS, TOTAL_NUM_CREDITS, TOTAL_AMOUNT, STATUS,
                                DATE_VALUE, RECORD_ENTRY_DATE, IS_LOADED_FROM_STG, PRODUCT_NAME, BUSINESS_STATUS_CODE,
                                NUMERO_TICKET, ENVIADO_EMPRESA, TOTAL_DEBITOS_PROCESADOS, TOTAL_DEBITOS_RECHAZADOS,
                                TOTAL_CREDITOS_PROCESADOS, TOTAL_CREDITOS_RECHAZADOS, FECHA_APROBACION,
                                FECHA_ENVIO_MONITOR, FECHA_RECEPCION_MONITOR, RESPUESTA_MONITOR, EXPIRADO_MONITOR, 
                                ENVIADO_MONITOR
                            FROM ORDEN
                            WHERE ID_ORDEN = :1'
                        USING v_orden_id;
                        
                        EXECUTE IMMEDIATE '
                            INSERT INTO ORDEN_DETAIL_HIST@' || c_db_link || '
                                (ID_ORDEN_DETAIL, ID_ORDEN, DATE_EXECUTED, REVERT_ORDEN, CLAVE_ORIGEN,
                                 AGREEMENT, REVERT_ORDEN_ROOT, MESSAGE_TYPE, REF_AVISO, MESSAGE_REFERENCE,
                                 URI_FILE, TOTAL_DEBIT_REJECTS, TOTAL_CREDIT_REJECTS, TOTAL_AMOUNT_ORI,
                                 SUBCHANNEL, SIZE_FILE, SITE_NUMBER, SIP_NEG_NUMBER, PROV_ID_DEBITS,
                                 SENT_DATE, SEND_CHANNEL, REQUEST_DATE, NEG_NUMBER, LAST_MODIFICATION_DATE,
                                 HOST_PROC_DATE, PROV_ID_ORDEN_ROOT, FORCE_DEBIT, FORCE_AUTHORIZATION,
                                 BRANCH, BRANCH_DESC, BUSINESS_STATUS_DESC, URI_FILE_APPROVED, URI_FILE_RSPHOST,
                                 MAIL, MAIL_APROBADOR, IP, CERTIFY_COMMENT, REVERSE_COMMENT, REPROCES_COMMENT,
                                 CUENTA_COMISIONES, ENVIO_RESPUESTA_TRANSPORTE, ENVIO_RESPUESTA_PASAJE,
                                 MENSAJEERROR, NUMERO_INTERCAMBIO, RESPUESTA_BANSTA)
                            SELECT 
                                ID_ORDEN_DETAIL, ID_ORDEN, DATE_EXECUTED, REVERT_ORDEN, CLAVE_ORIGEN,
                                AGREEMENT, REVERT_ORDEN_ROOT, MESSAGE_TYPE, REF_AVISO, MESSAGE_REFERENCE,
                                URI_FILE, TOTAL_DEBIT_REJECTS, TOTAL_CREDIT_REJECTS, TOTAL_AMOUNT_ORI,
                                SUBCHANNEL, SIZE_FILE, SITE_NUMBER, SIP_NEG_NUMBER, PROV_ID_DEBITS,
                                SENT_DATE, SEND_CHANNEL, REQUEST_DATE, NEG_NUMBER, LAST_MODIFICATION_DATE,
                                HOST_PROC_DATE, PROV_ID_ORDEN_ROOT, FORCE_DEBIT, FORCE_AUTHORIZATION,
                                BRANCH, BRANCH_DESC, BUSINESS_STATUS_DESC, URI_FILE_APPROVED, URI_FILE_RSPHOST,
                                MAIL, MAIL_APROBADOR, IP, CERTIFY_COMMENT, REVERSE_COMMENT, REPROCES_COMMENT,
                                CUENTA_COMISIONES, ENVIO_RESPUESTA_TRANSPORTE, ENVIO_RESPUESTA_PASAJE,
                                MENSAJEERROR, NUMERO_INTERCAMBIO, RESPUESTA_BANSTA
                            FROM ORDEN_DETAIL
                            WHERE ID_ORDEN = :1'
                        USING v_orden_id;
                        v_details_count := SQL%ROWCOUNT;
                        
                    EXCEPTION
                        WHEN DUP_VAL_ON_INDEX THEN
                            l_err_duplicado := l_err_duplicado + 1;
                            debug('DEBUG: Orden ' || v_orden_id || ' ya existe. Se omite.');
                            ROLLBACK TO sp_orden;
                            CONTINUE;
                        WHEN OTHERS THEN
                            debug('ERROR en inserción ORDEN_HIST: ' || SQLERRM);
                            RAISE;
                    END;
                    
                    -- PASO 1.5: Migrar TRACK_ORDEN
                    BEGIN
                        debug('DEBUG: Migrando TRACK_ORDEN para orden ' || v_orden_id);
                        EXECUTE IMMEDIATE '
                            INSERT INTO TRACK_ORDEN_HIST@' || c_db_link || '
                                (ID_TRACK_ORDEN, ID_ORDEN, STATUS, BUSINESS_STATUS_CODE, DESCRIPTION,
                                 RECORD_ENTRY_DATE, PAYMENT_TYPE, USUARIO, TIPO_PAGO, DESC_TIPO_PAGO)
                            SELECT 
                                ID_TRACK_ORDEN, TO_NUMBER(ID_ORDEN), STATUS, BUSINESS_STATUS_CODE, DESCRIPTION,
                                RECORD_ENTRY_DATE, PAYMENT_TYPE, USUARIO, TIPO_PAGO, DESC_TIPO_PAGO
                            FROM TRACK_ORDEN
                            WHERE ID_ORDEN = TO_CHAR(:1)'
                        USING v_orden_id;
                        v_track_count := SQL%ROWCOUNT;
                        DELETE FROM TRACK_ORDEN WHERE ID_ORDEN = TO_CHAR(v_orden_id);
                        debug('DEBUG: TRACK_ORDEN migrado. Filas: ' || v_track_count);
                    EXCEPTION
                        WHEN OTHERS THEN
                            debug('ERROR en migración TRACK_ORDEN: ' || SQLERRM);
                            RAISE;
                    END;
                    
                    -- PASO 2: Obtener débitos
                    v_start_debits := SYSTIMESTAMP;
                    BEGIN
                        SELECT ID_DEBITS 
                        BULK COLLECT INTO v_debit_ids
                        FROM DEBITS 
                        WHERE ID_ORDEN = v_orden_id;
                        debug('DEBUG: Se encontraron ' || v_debit_ids.COUNT || ' débitos');
                    EXCEPTION
                        WHEN OTHERS THEN
                            debug('ERROR al obtener débitos: ' || SQLERRM);
                            RAISE;
                    END;
                    
                    -- PASO 3: Mover DEBITS a HIST
                    v_start_debits := SYSTIMESTAMP;
                    IF v_debit_ids.COUNT > 0 THEN
                        BEGIN
                            FOR k IN 1..v_debit_ids.COUNT LOOP
                                EXECUTE IMMEDIATE '
                                    INSERT INTO DEBITS_HIST@' || c_db_link || '
                                        (ID_DEBITS, ID_ORDEN, REFERENCE_NUMBER, CUSTOMER_ID, RECORD_ENTRY_DATE,
                                         CUSTOMER_DESC, PROCESS_DATE, ACCOUNT_NUMBER, ACCOUNT_TYPE, AMOUNT,
                                         CURRENCY, PAYMENT_TYPE, IS_PAYROLL, STATUS, BUSINESS_STATUS_CODE,
                                         MONTO_ACTUALIZADO, VERIFICACION_SALDO, ID_DEBITS_ROOT, RETRY,
                                         BUSINESS_STATUS_DESC, ID_CREDITS_REVERSO, TOTAL_CREDITOS_RECHAZADOS,
                                         TOTAL_CREDITOS_ACEPTADOS, PAGO_POSTERIOR, SERIAL, ES_TRANSPORT,
                                         STATUS_COMIS_TRANSPORT, COD_MENSAJE_OPS, OPS, DATE_UPDATE,
                                         STATUS_PATRIA, ES_ACTULIZADO)
                                    SELECT 
                                        ID_DEBITS, ID_ORDEN, REFERENCE_NUMBER, CUSTOMER_ID, RECORD_ENTRY_DATE,
                                        CUSTOMER_DESC, PROCESS_DATE, ACCOUNT_NUMBER, ACCOUNT_TYPE, AMOUNT,
                                        CURRENCY, PAYMENT_TYPE, IS_PAYROLL, STATUS, BUSINESS_STATUS_CODE,
                                        MONTO_ACTUALIZADO, VERIFICACION_SALDO, ID_DEBITS_ROOT, RETRY,
                                        BUSINESS_STATUS_DESC, ID_CREDITS_REVERSO, TOTAL_CREDITOS_RECHAZADOS,
                                        TOTAL_CREDITOS_ACEPTADOS, PAGO_POSTERIOR, SERIAL, ES_TRANSPORT,
                                        STATUS_COMIS_TRANSPORT, COD_MENSAJE_OPS, OPS, DATE_UPDATE,
                                        STATUS_PATRIA, ES_ACTULIZADO
                                    FROM DEBITS
                                    WHERE ID_DEBITS = :1'
                                USING v_debit_ids(k);
                                v_debits_count := v_debits_count + SQL%ROWCOUNT;
                            END LOOP;
                            DELETE FROM DEBITS WHERE ID_ORDEN = v_orden_id;
                        EXCEPTION
                            WHEN OTHERS THEN
                                debug('ERROR en migración DEBITS: ' || SQLERRM);
                                RAISE;
                        END;
                    END IF;
                    l_t_debits := l_t_debits + elapsed_sec(v_start_debits, SYSTIMESTAMP);
                    
                    -- PASO 4: Migrar CRÉDITOS por rangos
                    v_start_credits := SYSTIMESTAMP;
                    FOR i IN 1..v_debit_ids.COUNT LOOP
                        DECLARE
                            v_debit_id NUMBER := v_debit_ids(i);
                        BEGIN
                            debug('DEBUG: Procesando débito ' || v_debit_id);
                            
                            -- Obtener rango de créditos
                            BEGIN
                                SELECT MIN(ID_CREDITS), MAX(ID_CREDITS)
                                INTO v_min_credit_id, v_max_credit_id
                                FROM CREDITS
                                WHERE ID_DEBITS = v_debit_id;
                                
                                IF v_min_credit_id IS NULL THEN
                                    debug('DEBUG: No hay créditos para débito ' || v_debit_id);
                                    CONTINUE;
                                END IF;
                                debug('DEBUG: Rango de créditos: ' || v_min_credit_id || ' - ' || v_max_credit_id);
                            EXCEPTION
                                WHEN OTHERS THEN
                                    debug('ERROR obteniendo rango de créditos: ' || SQLERRM);
                                    RAISE;
                            END;
                            
                            -- Procesar por lotes
                            v_current_min := v_min_credit_id;
                            WHILE v_current_min <= v_max_credit_id LOOP
                                v_current_max := LEAST(v_current_min + c_batch_size - 1, v_max_credit_id);
                                debug('DEBUG: Procesando lote de créditos ' || v_current_min || ' a ' || v_current_max);
                                
                                -- Insertar CREDITS_HIST
                                EXECUTE IMMEDIATE '
                                    INSERT INTO CREDITS_HIST@' || c_db_link || '
                                        (ID_CREDITS, ID_DEBITS, RECORD_ENTRY_DATE, REFERENCE_NUMBER, CUSTOMER_ID,
                                         CUSTOMER_DESC, PROCESS_DATE, ACCOUNT_NUMBER, ACCOUNT_TYPE, AMOUNT,
                                         PAYMENT_TYPE, EMAIL, STATUS, IS_DOMICILIATION, BUSINESS_STATUS_CODE,
                                         CUSTOMER_ID_OPS, ID_ORDEN, BUSINESS_STATUS_DESC, STATUS_OPS_CCE,
                                         COMISION_TRANSPORTISTA, SITE_CODE_CREDITOR, COD_MENSAJE_OPS,
                                         DIG_CUSTOMER_ID, STATUS_OPS_BCV, MOVED_DATE)
                                    SELECT 
                                        ID_CREDITS, ID_DEBITS, RECORD_ENTRY_DATE, REFERENCE_NUMBER, CUSTOMER_ID,
                                        CUSTOMER_DESC, PROCESS_DATE, ACCOUNT_NUMBER, ACCOUNT_TYPE, AMOUNT,
                                        PAYMENT_TYPE, EMAIL, STATUS, IS_DOMICILIATION, BUSINESS_STATUS_CODE,
                                        CUSTOMER_ID_OPS, :1, BUSINESS_STATUS_DESC, STATUS_OPS_CCE,
                                        COMISION_TRANSPORTISTA, SITE_CODE_CREDITOR, COD_MENSAJE_OPS,
                                        DIG_CUSTOMER_ID, STATUS_OPS_BCV, :2
                                    FROM CREDITS
                                    WHERE ID_DEBITS = :3
                                      AND ID_CREDITS BETWEEN :4 AND :5'
                                USING v_orden_id, v_max_debit_date, v_debit_id, v_current_min, v_current_max;
                                v_credits_count := v_credits_count + SQL%ROWCOUNT;
                                
                                -- Insertar CREDITS_CREDITO_INMEDIATO_HIST
                                EXECUTE IMMEDIATE '
                                    INSERT INTO CREDITS_CREDITO_INMEDIATO_HIST@' || c_db_link || '
                                        (ID_CREDITS, ENDTOEND, FECHA_REGISTRO, DESC_RESPUESTA_ENVIO,
                                         DESC_RESPUESTA_RECEPCION, ID_ORDEN, FECHA_RECIBIDO)
                                    SELECT 
                                        ID_CREDITS, ENDTOEND, FECHA_REGISTRO, DESC_RESPUESTA_ENVIO,
                                        DESC_RESPUESTA_RECEPCION, :1, FECHA_RECIBIDO
                                    FROM CREDITS_CREDITO_INMEDIATO
                                    WHERE ID_CREDITS IN (
                                        SELECT ID_CREDITS FROM CREDITS 
                                        WHERE ID_DEBITS = :2 AND ID_CREDITS BETWEEN :3 AND :4
                                    )'
                                USING v_orden_id, v_debit_id, v_current_min, v_current_max;
                                v_credits_inm_count := v_credits_inm_count + SQL%ROWCOUNT;
                                
                                -- Insertar DATOS_MOVIMIENTOS_HIST
                                EXECUTE IMMEDIATE '
                                    INSERT INTO DATOS_MOVIMIENTOS_HIST@' || c_db_link || '
                                        (ID_RESPUESTA, ID_ORDEN, ID_DEBITO, ID_COMISION, ID_CREDITO,
                                         NIO_DEBITO, NRO_MOV_DEBITO, NIO_COMISION, NRO_MOV_COMISION,
                                         NIO_CREDITO, NRO_MOV_CREDITO, FECHA_REGISTRO, IS_COMISION,
                                         APLICA_REVERSO, APLICA_ANULACION, FECHA_REVER_ANU)
                                    SELECT 
                                        ID_RESPUESTA, :1, ID_DEBITO, ID_COMISION, ID_CREDITO,
                                        NIO_DEBITO, NRO_MOV_DEBITO, NIO_COMISION, NRO_MOV_COMISION,
                                        NIO_CREDITO, NRO_MOV_CREDITO, FECHA_REGISTRO, IS_COMISION,
                                        APLICA_REVERSO, APLICA_ANULACION, FECHA_REVER_ANU
                                    FROM DATOS_MOVIMIENTOS
                                    WHERE ID_CREDITO IN (
                                        SELECT ID_CREDITS FROM CREDITS 
                                        WHERE ID_DEBITS = :2 AND ID_CREDITS BETWEEN :3 AND :4
                                    )'
                                USING v_orden_id, v_debit_id, v_current_min, v_current_max;
                                v_datos_mov_count := v_datos_mov_count + SQL%ROWCOUNT;
                                
                                -- Insertar LOGS_RESP_PROC_PCP1_HIST
                                EXECUTE IMMEDIATE '
                                    INSERT INTO LOGS_RESP_PROC_PCP1_HIST@' || c_db_link || '
                                        (ID_DATOS_RES, ID_ORDEN, ID_DEBITO, ID_COMISION, ID_CREDITO,
                                         COD_RESP, DESCRIPCION, FECHA_REGISTRO)
                                    SELECT 
                                        ID_DATOS_RES, :1, ID_DEBITO, ID_COMISION, ID_CREDITO,
                                        COD_RESP, DESCRIPCION, FECHA_REGISTRO
                                    FROM LOGS_RESP_PROC_PCP1
                                    WHERE ID_CREDITO IN (
                                        SELECT ID_CREDITS FROM CREDITS 
                                        WHERE ID_DEBITS = :2 AND ID_CREDITS BETWEEN :3 AND :4
                                    )'
                                USING v_orden_id, v_debit_id, v_current_min, v_current_max;
                                v_logs_count := v_logs_count + SQL%ROWCOUNT;
                                
                                -- Eliminar locales
                                DELETE FROM CREDITS_CREDITO_INMEDIATO
                                WHERE ID_CREDITS IN (
                                    SELECT ID_CREDITS FROM CREDITS 
                                    WHERE ID_DEBITS = v_debit_id AND ID_CREDITS BETWEEN v_current_min AND v_current_max
                                );
                                DELETE FROM DATOS_MOVIMIENTOS
                                WHERE ID_CREDITO IN (
                                    SELECT ID_CREDITS FROM CREDITS 
                                    WHERE ID_DEBITS = v_debit_id AND ID_CREDITS BETWEEN v_current_min AND v_current_max
                                );
                                DELETE FROM LOGS_RESP_PROC_PCP1
                                WHERE ID_CREDITO IN (
                                    SELECT ID_CREDITS FROM CREDITS 
                                    WHERE ID_DEBITS = v_debit_id AND ID_CREDITS BETWEEN v_current_min AND v_current_max
                                );
                                DELETE FROM CREDITS
                                WHERE ID_DEBITS = v_debit_id AND ID_CREDITS BETWEEN v_current_min AND v_current_max;
                                
                                v_current_min := v_current_max + 1;
                            END LOOP;
                            
                            DELETE FROM DEBITS WHERE ID_DEBITS = v_debit_id;
                            debug('DEBUG: Débito ' || v_debit_id || ' procesado. Créditos migrados: ' || v_credits_count);
                        EXCEPTION
                            WHEN OTHERS THEN
                                RAISE;
                        END;
                    END LOOP;
                    l_t_credits := l_t_credits + elapsed_sec(v_start_credits, SYSTIMESTAMP);
                    
                    -- PASO 5: Eliminar ORDEN_DETAIL y ORDEN
                    BEGIN
                        DELETE FROM ORDEN_DETAIL WHERE ID_ORDEN = v_orden_id;
                        DELETE FROM ORDEN WHERE ID_ORDEN = v_orden_id;
                        l_t_orden := l_t_orden + elapsed_sec(v_start_orden, SYSTIMESTAMP);
                    EXCEPTION
                        WHEN OTHERS THEN
                            debug('ERROR eliminando ORDEN: ' || SQLERRM);
                            RAISE;
                    END;
                    
                    -- Acumular totales
                    l_count_orden_success := l_count_orden_success + 1;
                    l_count_debits := l_count_debits + v_debits_count;
                    l_count_credits := l_count_credits + v_credits_count;
                    l_count_credits_inm := l_count_credits_inm + v_credits_inm_count;
                    l_count_datos_mov := l_count_datos_mov + v_datos_mov_count;
                    l_count_logs := l_count_logs + v_logs_count;
                    l_count_details := l_count_details + v_details_count;
                    l_count_track := l_count_track + v_track_count;
                    
                    COMMIT;
                    debug('Orden ' || v_orden_id || ' OK. Debits: ' || v_debits_count || ', Credits: ' || v_credits_count || ', Track: ' || v_track_count);
                    
                EXCEPTION
                    WHEN OTHERS THEN
                        ROLLBACK TO sp_orden;
                        l_count_orden_error := l_count_orden_error + 1;
                        IF SQLCODE = -1 THEN
                            l_err_duplicado := l_err_duplicado + 1;
                        ELSIF SQLCODE = -14300 THEN
                            l_err_particion := l_err_particion + 1;
                        ELSE
                            l_err_otros := l_err_otros + 1;
                        END IF;
                        debug('Error en orden ' || v_orden_id || ': ' || SQLERRM);
                END;
            END LOOP;
            
            l_minutes := (EXTRACT(SECOND FROM (SYSTIMESTAMP - l_start_time)) + 
                         EXTRACT(MINUTE FROM (SYSTIMESTAMP - l_start_time)) * 60 +
                         EXTRACT(HOUR FROM (SYSTIMESTAMP - l_start_time)) * 3600) / 60;
            
        END IF;
        
            -- ============================================================
            -- NUEVO BLOQUE: Migración de TORDEN, TORDEN_ALTA y TRACK_LOTE
            -- (SIEMPRE SE EJECUTA, INDEPENDIENTEMENTE DE P_ID_ORDEN)
            -- ============================================================
            BEGIN
                debug('===== INICIANDO MIGRACIÓN DE TORDEN Y TORDEN_ALTA =====');
                
                -- Determinar meses de retención para las nuevas tablas
                IF P_MONTHS_RETENTION_H > 0 THEN
                    v_months_retention := P_MONTHS_RETENTION_H;
                ELSE
                    BEGIN
                        SELECT NVL(P.VALOR, 12) INTO v_months_retention 
                        FROM PARAMETROS_PCP P 
                        WHERE P.NOMBRE_CAMPO = 'T_MONTHS_RETENTION_PCP_HIST';
                    EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                            v_months_retention := 12;
                    END;
                END IF;
                
                -- Obtener IDs de TORDEN
                IF P_ID_TORDEN IS NOT NULL THEN
                    SELECT ID_TORDEN
                    BULK COLLECT INTO l_torden_ids
                    FROM TORDEN
                    WHERE ID_TORDEN = P_ID_TORDEN;
                ELSE
                    IF P_START_DATE IS NOT NULL AND P_END_DATE IS NOT NULL THEN
                        SELECT ID_TORDEN
                        BULK COLLECT INTO l_torden_ids
                        FROM TORDEN
                        WHERE DATE_VALUE >= P_START_DATE
                          AND DATE_VALUE <  P_END_DATE + 1;
                    ELSE
                        SELECT ID_TORDEN
                        BULK COLLECT INTO l_torden_ids
                        FROM TORDEN
                        WHERE DATE_VALUE <= ADD_MONTHS(SYSDATE, -v_months_retention);
                    END IF;
                END IF;

                -- Obtener IDs de TORDEN_ALTA
                IF P_ID_TORDEN IS NOT NULL THEN
                    SELECT ID_TORDEN
                    BULK COLLECT INTO l_talta_ids
                    FROM TORDEN_ALTA
                    WHERE ID_TORDEN = P_ID_TORDEN;
                ELSE
                    IF P_START_DATE IS NOT NULL AND P_END_DATE IS NOT NULL THEN
                        SELECT ID_TORDEN
                        BULK COLLECT INTO l_talta_ids
                        FROM TORDEN_ALTA
                        WHERE RECORD_ENTRY_DATE >= P_START_DATE
                          AND RECORD_ENTRY_DATE <  P_END_DATE + 1;
                    ELSE
                        SELECT ID_TORDEN
                        BULK COLLECT INTO l_talta_ids
                        FROM TORDEN_ALTA
                        WHERE RECORD_ENTRY_DATE <= ADD_MONTHS(SYSDATE, -v_months_retention);
                    END IF;
                END IF;
                
                debug('IDs de TORDEN a procesar: ' || l_torden_ids.COUNT);
                debug('IDs de TORDEN_ALTA a procesar: ' || l_talta_ids.COUNT);
                
                -- ============================================================
                -- PASO 1: Migrar TORDEN (padre) y TORDEN_DETAIL (hijo)
                -- ============================================================
                FOR idx IN 1..l_torden_ids.COUNT LOOP
                    SAVEPOINT sp_torden;
                    DECLARE
                        v_id         NUMBER := l_torden_ids(idx);
                        v_detail_cnt NUMBER := 0;
                    BEGIN
                        debug('Migrando TORDEN ID: ' || v_id);
                        
                        -- Insertar TORDEN (padre)
                        EXECUTE IMMEDIATE '
                            INSERT INTO TORDEN_HIST@' || c_db_link || ' (
                                ID_TORDEN, CUSTOMER_DESCRIPTION, ACCOUNT_NUMBER, DATE_VALUE, TOTAL_AMOUNT,
                                TOTAL_COMISSION, CENTRO_OPER, CUSTOMER_ID, DIG_CUSTOMER_ID, TOTAL_NUM_RECORD,
                                TIPO_NOMINA, CODIGO_PLAN, FECHA_PROCESO, HORA_PROCESO, NOM_ARCHIVO,
                                NUMERO_TICKET, NUMERO_ASIGNADO_PAMPA, RECORD_ENTRY_DATE, PRODUCT_TYPE, PRODUCT,
                                COD_RETORNO_PAMPA, STATUS, BUSINESS_STATUS_CODE, TOTAL_OK, TOTAL_REJECTS,
                                TOTAL_AMOUNT_REJECTS, DATE_APPROVE, URI_FILE, SIZE_FILE, SUBCHANNEL,
                                SENT_DATE, SEND_CHANNEL, REQUEST_DATE, LAST_MODIFICATION_DATE, BUSINESS_STATUS_DESC,
                                IP, IMPFIJO, COMISION_PORC, MONTO_MIN_COMI, MONTO_MAX_COMI,
                                SUBSTATUS, AMOUNT_ACTUAL, COMISION_COBRADA, MENSAJEERROR, IS_LOADED_FROM_STG,
                                ID_NUM_REQUEST, REFERENCE_NUMBER_LOTE, CERTIFY_COMMENT, REPROCES_COMMENT,
                                DATE_SEND_HOST, DATE_RESPONSE_HOST
                            ) SELECT 
                                ID_TORDEN, CUSTOMER_DESCRIPTION, ACCOUNT_NUMBER, DATE_VALUE, TOTAL_AMOUNT,
                                TOTAL_COMISSION, CENTRO_OPER, CUSTOMER_ID, DIG_CUSTOMER_ID, TOTAL_NUM_RECORD,
                                TIPO_NOMINA, CODIGO_PLAN, FECHA_PROCESO, HORA_PROCESO, NOM_ARCHIVO,
                                NUMERO_TICKET, NUMERO_ASIGNADO_PAMPA, RECORD_ENTRY_DATE, PRODUCT_TYPE, PRODUCT,
                                COD_RETORNO_PAMPA, STATUS, BUSINESS_STATUS_CODE, TOTAL_OK, TOTAL_REJECTS,
                                TOTAL_AMOUNT_REJECTS, DATE_APPROVE, URI_FILE, SIZE_FILE, SUBCHANNEL,
                                SENT_DATE, SEND_CHANNEL, REQUEST_DATE, LAST_MODIFICATION_DATE, BUSINESS_STATUS_DESC,
                                IP, IMPFIJO, COMISION_PORC, MONTO_MIN_COMI, MONTO_MAX_COMI,
                                SUBSTATUS, AMOUNT_ACTUAL, COMISION_COBRADA, MENSAJEERROR, IS_LOADED_FROM_STG,
                                ID_NUM_REQUEST, REFERENCE_NUMBER_LOTE, CERTIFY_COMMENT, REPROCES_COMMENT,
                                DATE_SEND_HOST, DATE_RESPONSE_HOST
                            FROM TORDEN
                            WHERE ID_TORDEN = :1'
                        USING v_id;
                        
                        -- Insertar TORDEN_DETAIL (hijo)
                        EXECUTE IMMEDIATE '
                            INSERT INTO TORDEN_DETAIL_HIST@' || c_db_link || ' (
                                ID_TORDEN, ID_TDETAIL, RECORD_ENTRY_DATE, CUSTOMER_ID, DIG_CUSTOMER_ID,
                                CUSTOMER_DESC, TRANS_TYPE, CARD_NUMBER, ACCOUNT_NUMBER, AMOUNT,
                                STATUS, BUSINESS_STATUS_CODE, BUSINESS_STATUS_DESC, COD_MENSAJE_OPS,
                                CURRENCY, DESC_MENSAJE_OPS1, DESC_MENSAJE_OPS2, DESC_MENSAJE_OPS3
                            ) SELECT 
                                ID_TORDEN, ID_TDETAIL, RECORD_ENTRY_DATE, CUSTOMER_ID, DIG_CUSTOMER_ID,
                                CUSTOMER_DESC, TRANS_TYPE, CARD_NUMBER, ACCOUNT_NUMBER, AMOUNT,
                                STATUS, BUSINESS_STATUS_CODE, BUSINESS_STATUS_DESC, COD_MENSAJE_OPS,
                                CURRENCY, DESC_MENSAJE_OPS1, DESC_MENSAJE_OPS2, DESC_MENSAJE_OPS3
                            FROM TORDEN_DETAIL
                            WHERE ID_TORDEN = :1'
                        USING v_id;
                        v_detail_cnt := SQL%ROWCOUNT;
                        
                        -- Eliminar hijos y padre (en orden inverso a la inserción)
                        DELETE FROM TORDEN_DETAIL WHERE ID_TORDEN = v_id;
                        DELETE FROM TORDEN WHERE ID_TORDEN = v_id;
                        
                        l_count_torden_ok := l_count_torden_ok + 1;
                        l_count_detail := l_count_detail + v_detail_cnt;
                        
                        COMMIT;
                        debug('TORDEN ' || v_id || ' OK. Detalles: ' || v_detail_cnt);
                        
                    EXCEPTION
                        WHEN DUP_VAL_ON_INDEX THEN
                            ROLLBACK TO sp_torden;
                            l_count_torden_err := l_count_torden_err + 1;
                            debug('TORDEN ' || v_id || ' ya existe en HIST. Omitido.');
                        WHEN OTHERS THEN
                            ROLLBACK TO sp_torden;
                            l_count_torden_err := l_count_torden_err + 1;
                            debug('ERROR en TORDEN ' || v_id || ': ' || SQLERRM);
                    END;
                END LOOP;
                
                -- ============================================================
                -- PASO 2: Migrar TORDEN_ALTA (padre) y TORDEN_DETAIL_ALTA (hijo)
                -- ============================================================
                FOR idx IN 1..l_talta_ids.COUNT LOOP
                    SAVEPOINT sp_talta;
                    DECLARE
                        v_id         NUMBER := l_talta_ids(idx);
                        v_detail_cnt NUMBER := 0;
                    BEGIN
                        debug('Migrando TORDEN_ALTA ID: ' || v_id);
                        
                        -- Insertar TORDEN_ALTA (padre)
                        EXECUTE IMMEDIATE '
                            INSERT INTO TORDEN_ALTA_HIST@' || c_db_link || ' (
                                ID_TORDEN, CUSTOMER_DESCRIPTION, TOTAL_COMISSION, CUSTOMER_ID, DIG_CUSTOMER_ID,
                                TOTAL_NUM_RECORD, TIPO_ALTA, CODIGO_PLAN, FECHA_PROCESO, HORA_PROCESO,
                                NOM_ARCHIVO, REFERENCE_NUMBER_LOTE, NUMERO_TICKET, RECORD_ENTRY_DATE,
                                PRODUCT_TYPE, PRODUCT, COD_RETORNO_PAMPA, STATUS, BUSINESS_STATUS_CODE,
                                TOTAL_OK, TOTAL_REJECTS, DATE_APPROVE, URI_FILE, SIZE_FILE,
                                SUBCHANNEL, SENT_DATE, SEND_CHANNEL, LAST_MODIFICATION_DATE, BUSINESS_STATUS_DESC,
                                IP, SUBSTATUS, COMISION_COBRADA, MENSAJEERROR, IS_LOADED_FROM_STG,
                                ID_NUM_REQUEST, CERTIFY_COMMENT, REPROCES_COMMENT, DATE_SEND_HOST,
                                DATE_RESPONSE_HOST, DATE_RESPONSE_HOST_EMI, CREATOR, APPROVING, FECHA_ALTA
                            ) SELECT 
                                ID_TORDEN, CUSTOMER_DESCRIPTION, TOTAL_COMISSION, CUSTOMER_ID, DIG_CUSTOMER_ID,
                                TOTAL_NUM_RECORD, TIPO_ALTA, CODIGO_PLAN, FECHA_PROCESO, HORA_PROCESO,
                                NOM_ARCHIVO, REFERENCE_NUMBER_LOTE, NUMERO_TICKET, RECORD_ENTRY_DATE,
                                PRODUCT_TYPE, PRODUCT, COD_RETORNO_PAMPA, STATUS, BUSINESS_STATUS_CODE,
                                TOTAL_OK, TOTAL_REJECTS, DATE_APPROVE, URI_FILE, SIZE_FILE,
                                SUBCHANNEL, SENT_DATE, SEND_CHANNEL, LAST_MODIFICATION_DATE, BUSINESS_STATUS_DESC,
                                IP, SUBSTATUS, COMISION_COBRADA, MENSAJEERROR, IS_LOADED_FROM_STG,
                                ID_NUM_REQUEST, CERTIFY_COMMENT, REPROCES_COMMENT, DATE_SEND_HOST,
                                DATE_RESPONSE_HOST, DATE_RESPONSE_HOST_EMI, CREATOR, APPROVING, FECHA_ALTA
                            FROM TORDEN_ALTA
                            WHERE ID_TORDEN = :1'
                        USING v_id;
                        
                        -- Insertar TORDEN_DETAIL_ALTA (hijo)
                        EXECUTE IMMEDIATE '
                            INSERT INTO TORDEN_DETAIL_ALTA_HIST@' || c_db_link || ' (
                                ID_TORDEN, ID_TDETAIL, RECORD_ENTRY_DATE, CUSTOMER_ID, DIG_CUSTOMER_ID,
                                APELLIDO1, APELLIDO2, NOMBRE, PEDIDO, FAMILIA,
                                CIUDAD, ESTADO, COD_OFI, SEXO, COD_AREA,
                                NRO_TELF, DESC_TELF, FEC_NAC, DESC_CUSTOMER, CARD_NUMBER,
                                FECH_VENCIM, STATUS, BUSINESS_STATUS_CODE, BUSINESS_STATUS_DESC,
                                COD_MENSAJE_OPS, DESC_MENSAJE_OPS, CURRENCY
                            ) SELECT 
                                ID_TORDEN, ID_TDETAIL, RECORD_ENTRY_DATE, CUSTOMER_ID, DIG_CUSTOMER_ID,
                                APELLIDO1, APELLIDO2, NOMBRE, PEDIDO, FAMILIA,
                                CIUDAD, ESTADO, COD_OFI, SEXO, COD_AREA,
                                NRO_TELF, DESC_TELF, FEC_NAC, DESC_CUSTOMER, CARD_NUMBER,
                                FECH_VENCIM, STATUS, BUSINESS_STATUS_CODE, BUSINESS_STATUS_DESC,
                                COD_MENSAJE_OPS, DESC_MENSAJE_OPS, CURRENCY
                            FROM TORDEN_DETAIL_ALTA
                            WHERE ID_TORDEN = :1'
                        USING v_id;
                        v_detail_cnt := SQL%ROWCOUNT;
                        
                        -- Eliminar hijos y padre (en orden inverso a la inserción)
                        DELETE FROM TORDEN_DETAIL_ALTA WHERE ID_TORDEN = v_id;
                        DELETE FROM TORDEN_ALTA WHERE ID_TORDEN = v_id;
                        
                        l_count_talta_ok := l_count_talta_ok + 1;
                        l_count_detail_alta := l_count_detail_alta + v_detail_cnt;
                        
                        COMMIT;
                        debug('TORDEN_ALTA ' || v_id || ' OK. Detalles: ' || v_detail_cnt);
                        
                    EXCEPTION
                        WHEN DUP_VAL_ON_INDEX THEN
                            ROLLBACK TO sp_talta;
                            l_count_talta_err := l_count_talta_err + 1;
                            debug('TORDEN_ALTA ' || v_id || ' ya existe en HIST. Omitido.');
                        WHEN OTHERS THEN
                            ROLLBACK TO sp_talta;
                            l_count_talta_err := l_count_talta_err + 1;
                            debug('ERROR en TORDEN_ALTA ' || v_id || ': ' || SQLERRM);
                    END;
                END LOOP;
                
                -- ============================================================
                -- PASO 3: Migrar TRACK_LOTE usando las colecciones de IDs
                -- ============================================================
                DECLARE
                    v_track_cnt NUMBER := 0;
                    v_lote_id   NUMBER;
                    TYPE t_processed_ids IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
                    v_processed t_processed_ids;
                BEGIN
                    debug('===== INICIANDO MIGRACIÓN DE TRACK_LOTE (USANDO COLECCIONES) =====');
                    
                    -- 1. Migrar TRACK_LOTE para los TORDEN migrados
                    FOR i IN 1..l_torden_ids.COUNT LOOP
                        v_lote_id := l_torden_ids(i);
                        
                        -- Verificar si ya fue procesado (evita duplicados si el mismo ID aparece en ambas colecciones)
                        IF NOT v_processed.EXISTS(v_lote_id) THEN
                            BEGIN
                                -- Verificar si existe TRACK_LOTE para este ID
                                DECLARE
                                    v_exists NUMBER;
                                BEGIN
                                    SELECT COUNT(1) INTO v_exists FROM TRACK_LOTE WHERE ID_LOTE = v_lote_id;
                                    IF v_exists = 0 THEN
                                        CONTINUE;
                                    END IF;
                                END;
                                
                                debug('Migrando TRACK_LOTE para ID_LOTE (TORDEN): ' || v_lote_id);
                                
                                EXECUTE IMMEDIATE '
                                    INSERT INTO TRACK_LOTE_HIST@' || c_db_link || ' (
                                        ID_TRACK, ID_LOTE, STATUS, BUSINESS_STATUS_CODE, DESCRIPTION,
                                        RECORD_ENTRY_DATE, PRODUCT, PRODUCT_TYPE, USUARIO
                                    ) SELECT 
                                        ID_TRACK, ID_LOTE, STATUS, BUSINESS_STATUS_CODE, DESCRIPTION,
                                        RECORD_ENTRY_DATE, PRODUCT, PRODUCT_TYPE, USUARIO
                                    FROM TRACK_LOTE
                                    WHERE ID_LOTE = :1'
                                USING v_lote_id;
                                v_track_cnt := v_track_cnt + SQL%ROWCOUNT;
                                
                                DELETE FROM TRACK_LOTE WHERE ID_LOTE = v_lote_id;
                                COMMIT;
                                debug('TRACK_LOTE migrado para ID_LOTE: ' || v_lote_id);
                                
                                -- Marcar como procesado
                                v_processed(v_lote_id) := 1;
                                
                            EXCEPTION
                                WHEN DUP_VAL_ON_INDEX THEN
                                    ROLLBACK;
                                    debug('TRACK_LOTE para ID_LOTE ' || v_lote_id || ' ya existe en HIST. Omitido.');
                                WHEN OTHERS THEN
                                    ROLLBACK;
                                    debug('ERROR en TRACK_LOTE para ID_LOTE ' || v_lote_id || ': ' || SQLERRM);
                            END;
                        END IF;
                    END LOOP;
                    
                    -- 2. Migrar TRACK_LOTE para los TORDEN_ALTA migrados
                    FOR i IN 1..l_talta_ids.COUNT LOOP
                        v_lote_id := l_talta_ids(i);
                        
                        -- Verificar si ya fue procesado
                        IF NOT v_processed.EXISTS(v_lote_id) THEN
                            BEGIN
                                DECLARE
                                    v_exists NUMBER;
                                BEGIN
                                    SELECT COUNT(1) INTO v_exists FROM TRACK_LOTE WHERE ID_LOTE = v_lote_id;
                                    IF v_exists = 0 THEN
                                        CONTINUE;
                                    END IF;
                                END;
                                
                                debug('Migrando TRACK_LOTE para ID_LOTE (TORDEN_ALTA): ' || v_lote_id);
                                
                                EXECUTE IMMEDIATE '
                                    INSERT INTO TRACK_LOTE_HIST@' || c_db_link || ' (
                                        ID_TRACK, ID_LOTE, STATUS, BUSINESS_STATUS_CODE, DESCRIPTION,
                                        RECORD_ENTRY_DATE, PRODUCT, PRODUCT_TYPE, USUARIO
                                    ) SELECT 
                                        ID_TRACK, ID_LOTE, STATUS, BUSINESS_STATUS_CODE, DESCRIPTION,
                                        RECORD_ENTRY_DATE, PRODUCT, PRODUCT_TYPE, USUARIO
                                    FROM TRACK_LOTE
                                    WHERE ID_LOTE = :1'
                                USING v_lote_id;
                                v_track_cnt := v_track_cnt + SQL%ROWCOUNT;
                                
                                DELETE FROM TRACK_LOTE WHERE ID_LOTE = v_lote_id;
                                COMMIT;
                                debug('TRACK_LOTE migrado para ID_LOTE: ' || v_lote_id);
                                
                                v_processed(v_lote_id) := 1;
                                
                            EXCEPTION
                                WHEN DUP_VAL_ON_INDEX THEN
                                    ROLLBACK;
                                    debug('TRACK_LOTE para ID_LOTE ' || v_lote_id || ' ya existe en HIST. Omitido.');
                                WHEN OTHERS THEN
                                    ROLLBACK;
                                    debug('ERROR en TRACK_LOTE para ID_LOTE ' || v_lote_id || ': ' || SQLERRM);
                            END;
                        END IF;
                    END LOOP;
                    
                    l_count_track_lote := l_count_track_lote + v_track_cnt;
                    debug('===== TRACK_LOTE MIGRADOS (USANDO COLECCIONES): ' || v_track_cnt || ' =====');
                END;
                
                debug('===== MIGRACIÓN DE TORDEN Y TORDEN_ALTA COMPLETADA =====');
                debug('TORDEN OK: ' || l_count_torden_ok || ', TORDEN_ALTA OK: ' || l_count_talta_ok);
                debug('Track_Lote migrados: ' || l_count_track_lote);
                
            EXCEPTION
                WHEN OTHERS THEN
                    debug('ERROR en migración de TORDEN: ' || SQLERRM);
                    -- No se propaga para no detener el proceso principal
                    NULL;
            END;
            
            -- ============================================================
            -- FIN DEL NUEVO BLOQUE
            -- ============================================================
            
            -- Insertar log de migración semanal
            IF P_ID_ORDEN IS NULL THEN
                BEGIN
                    INSERT INTO PCP.MIGRATION_WEEK_LOG (
                        fecha_inicio, fecha_fin, semana_inicio, semana_fin,
                        ordenes_ok, ordenes_error, debits, credits, credits_inm,
                        datos_mov, num_logs, num_details, num_track, total_creditos, tiempo_por_credito,
                        segundos_total, t_orden_seg, t_debits_seg, t_credits_seg,
                        -- Nuevas columnas para TORDEN
                        torden_ok, torden_err, torden_alta_ok, torden_alta_err,
                        track_lote, torden_detalles, torden_detalles_alta,
                        estado
                    ) VALUES (
                        l_start_time, SYSTIMESTAMP, P_START_DATE, P_END_DATE,
                        l_count_orden_success, l_count_orden_error, l_count_debits, l_count_credits,
                        l_count_credits_inm, l_count_datos_mov, l_count_logs, l_count_details,
                        l_count_track, l_count_credits,
                        CASE WHEN l_count_credits > 0 THEN (l_minutes * 60) / l_count_credits END,
                        l_minutes * 60,
                        l_t_orden, l_t_debits, l_t_credits,
                        -- Nuevos valores
                        l_count_torden_ok, l_count_torden_err,
                        l_count_talta_ok, l_count_talta_err,
                        l_count_track_lote,
                        l_count_detail,
                        l_count_detail_alta,
                        'COMPLETADO'
                    );
                    COMMIT;
                EXCEPTION
                    WHEN OTHERS THEN
                        ROLLBACK;
                        NULL;
                END;
            END IF;
            
            -- ============================================================
            -- CONSTRUIR MENSAJE DE SALIDA (ACTUALIZADO CON ESTADÍSTICAS DE TORDEN)
            -- ============================================================
            DECLARE
                l_msg CLOB;
                v_resumen VARCHAR2(4000);
            BEGIN
                -- Construir mensaje según el modo de ejecución
                IF P_SKIP_ORDEN_MIGRATION = 'Y' THEN
                    -- Modo solo TORDEN
                    l_msg := '00 Migración TORDEN completada. ' ||
                             'TORDEN_OK: ' || l_count_torden_ok || ', TORDEN_ERR: ' || l_count_torden_err || ', ' ||
                             'TORDEN_ALTA_OK: ' || l_count_talta_ok || ', TORDEN_ALTA_ERR: ' || l_count_talta_err || ', ' ||
                             'Detalles: ' || (l_count_detail + l_count_detail_alta) || ', Track_Lote: ' || l_count_track_lote ||
                             '. Tiempo: ' || ROUND(l_minutes, 2) || ' minutos';
                ELSE
                    -- Modo completo: órdenes + TORDEN
                    v_resumen := 'Procesadas: ' || (l_count_orden_success + l_count_orden_error) || ' órdenes (' ||
                                 l_count_orden_success || ' OK, ' || l_count_orden_error || ' con error)';
                    IF l_err_duplicado > 0 OR l_err_particion > 0 OR l_err_otros > 0 THEN
                        v_resumen := v_resumen || '. Errores: ';
                        IF l_err_duplicado > 0 THEN
                            v_resumen := v_resumen || l_err_duplicado || ' duplicada, ';
                        END IF;
                        IF l_err_particion > 0 THEN
                            v_resumen := v_resumen || l_err_particion || ' partición, ';
                        END IF;
                        IF l_err_otros > 0 THEN
                            v_resumen := v_resumen || l_err_otros || ' otros, ';
                        END IF;
                        v_resumen := RTRIM(v_resumen, ', ');
                    END IF;
                    v_resumen := v_resumen || '. Totales: débitos: ' || l_count_debits ||
                                 ', créditos: ' || l_count_credits || ', créditos_inm: ' || l_count_credits_inm ||
                                 ', datos_mov: ' || l_count_datos_mov || ', logs: ' || l_count_logs ||
                                 ', detalles: ' || l_count_details || ', track: ' || l_count_track ||
                                 '. Tiempo: ' || ROUND(l_minutes, 2) || ' minutos';
                                 
                    l_msg := CASE WHEN l_count_orden_error = 0 THEN '00 ' ELSE '02 ' END || v_resumen ||
                             ' | TORDEN_OK: ' || l_count_torden_ok || ', TORDEN_ALTA_OK: ' || l_count_talta_ok ||
                             ', Track_Lote: ' || l_count_track_lote;
                END IF;
                
                -- Truncar a 4000 caracteres para evitar ORA-06502
                P_OUT_DATA := DBMS_LOB.SUBSTR(l_msg, 4000, 1);
            EXCEPTION
                WHEN OTHERS THEN
                    -- Si falla la construcción, asignar mensaje de error corto
                    P_OUT_DATA := '99 Error al construir mensaje: ' || SUBSTR(SQLERRM, 1, 200);
            END;
            
            UPDATE PROCESS_CONTROL SET IS_ACTIVE = V_NO WHERE PROCESS_NAME = MANTENIMIENTO_PROCESS_NAME;
            COMMIT;
            
        ELSE
            P_OUT_DATA := '06 Proceso MANTENIMIENTO_PCP_HIST_DIARIO está ocupado';
        END IF;
        
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            BEGIN
                UPDATE PROCESS_CONTROL SET IS_ACTIVE = V_NO WHERE PROCESS_NAME = MANTENIMIENTO_PROCESS_NAME;
                COMMIT;
            EXCEPTION
                WHEN OTHERS THEN NULL;
            END;
            P_OUT_DATA := '99 Error: ' || SQLCODE || ' - ' || SQLERRM;
END MANTENIMIENTO_PCP_HIST_DIARIO;

    
    -- ========================================================================
    -- PROCEDIMIENTO ELIMINAR_PARTICIONES_VACIAS (ACTUALIZADO CON NUEVAS TABLAS)
    -- ========================================================================
       PROCEDURE ELIMINAR_PARTICIONES_VACIAS IS
        TYPE t_tables IS TABLE OF VARCHAR2(30);
        v_tables t_tables := t_tables(
            'CREDITS', 'CREDITS_CREDITO_INMEDIATO', 'ORDEN_DETAIL', 
            'ORDEN', 'DEBITS', 'TRACK_ORDEN', 'LOGS_RESP_PROC_PCP1', 'DATOS_MOVIMIENTOS',
            'TORDEN', 'TORDEN_ALTA', 'TORDEN_DETAIL', 'TORDEN_DETAIL_ALTA', 'TRACK_LOTE'
        );

        v_sql VARCHAR2(1000);
        v_num_rows NUMBER;
        v_count_dropped NUMBER := 0;
        v_count_checked NUMBER := 0;
        v_count_skipped_by_stats NUMBER := 0;
        v_start_time TIMESTAMP := SYSTIMESTAMP;
        v_partition_count NUMBER := 0;
        
        -- Cursor que obtiene todas las particiones EXCEPTO la primera (PARTITION_POSITION = 1)
        CURSOR c_partitions(p_table VARCHAR2) IS
            SELECT PARTITION_NAME, NUM_ROWS, LAST_ANALYZED
            FROM USER_TAB_PARTITIONS 
            WHERE TABLE_NAME = p_table 
              AND PARTITION_POSITION > 1
              AND PARTITION_NAME NOT LIKE 'SYS_P%'
            ORDER BY PARTITION_POSITION;
        
    BEGIN
        DBMS_OUTPUT.PUT_LINE('=== INICIANDO ELIMINACIÓN DE PARTICIONES VACÍAS (DINÁMICO) ===');
        DBMS_OUTPUT.PUT_LINE('Hora inicio: ' || TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD HH24:MI:SS'));
        DBMS_OUTPUT.PUT_LINE('Excluyendo automáticamente la primera partición de cada tabla (PARTITION_POSITION = 1)');
        
        FOR i IN 1..v_tables.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE('--- Procesando tabla: ' || v_tables(i) || ' ---');
            v_partition_count := 0;
            
            FOR part IN c_partitions(v_tables(i)) LOOP
                v_partition_count := v_partition_count + 1;
                
                BEGIN
                    IF part.LAST_ANALYZED IS NOT NULL AND part.LAST_ANALYZED >= SYSDATE - 1 THEN
                        IF part.NUM_ROWS = 0 OR part.NUM_ROWS IS NULL THEN
                            v_sql := 'SELECT COUNT(1) FROM PCP.' || v_tables(i) || ' PARTITION (' || part.PARTITION_NAME || ')';
                            EXECUTE IMMEDIATE v_sql INTO v_num_rows;
                            v_count_checked := v_count_checked + 1;
                            
                            IF v_num_rows = 0 THEN
                                DBMS_OUTPUT.PUT_LINE('  Eliminando: ' || part.PARTITION_NAME || ' (confirmado vacía)');
                                EXECUTE IMMEDIATE 'ALTER TABLE PCP.' || v_tables(i) || ' DROP PARTITION ' || part.PARTITION_NAME || ' UPDATE GLOBAL INDEXES';
                                v_count_dropped := v_count_dropped + 1;
                                COMMIT;
                            ELSE
                                DBMS_OUTPUT.PUT_LINE('  Saltando: ' || part.PARTITION_NAME || ' (tiene ' || v_num_rows || ' filas)');
                            END IF;
                        ELSE
                            v_count_skipped_by_stats := v_count_skipped_by_stats + 1;
                        END IF;
                    ELSE
                        v_sql := 'SELECT COUNT(1) FROM PCP.' || v_tables(i) || ' PARTITION (' || part.PARTITION_NAME || ')';
                        EXECUTE IMMEDIATE v_sql INTO v_num_rows;
                        v_count_checked := v_count_checked + 1;
                        
                        IF v_num_rows = 0 THEN
                            DBMS_OUTPUT.PUT_LINE('  Eliminando: ' || part.PARTITION_NAME || ' (sin stats, verificada vacía)');
                            EXECUTE IMMEDIATE 'ALTER TABLE PCP.' || v_tables(i) || ' DROP PARTITION ' || part.PARTITION_NAME || ' UPDATE GLOBAL INDEXES';
                            v_count_dropped := v_count_dropped + 1;
                            COMMIT;
                        ELSE
                            DBMS_OUTPUT.PUT_LINE('  Saltando: ' || part.PARTITION_NAME || ' (tiene ' || v_num_rows || ' filas)');
                        END IF;
                    END IF;
                    
                EXCEPTION
                    WHEN OTHERS THEN
                        DBMS_OUTPUT.PUT_LINE('  Error en ' || part.PARTITION_NAME || ': ' || SQLERRM);
                        ROLLBACK;
                END;
            END LOOP;
            
            DBMS_OUTPUT.PUT_LINE('  Particiones evaluadas en ' || v_tables(i) || ': ' || v_partition_count);
        END LOOP;
        
        -- ============================================================
        -- RECONSTRUCCIÓN DE ÍNDICES (ADAPTADO PARA ORACLE 12c)
        -- ============================================================
        DBMS_OUTPUT.PUT_LINE('=== RECONSTRUYENDO ÍNDICES GLOBALES (Oracle 12c) ===');
        
        -- 1. Reconstruir índices NO particionados (status = 'UNUSABLE')
        FOR idx IN (SELECT index_name, table_name 
                    FROM user_indexes 
                    WHERE status = 'UNUSABLE' 
                      AND partitioned = 'NO') LOOP
            BEGIN
                DBMS_OUTPUT.PUT_LINE('  Reconstruyendo índice no particionado: ' || idx.index_name);
                EXECUTE IMMEDIATE 'ALTER INDEX ' || idx.index_name || ' REBUILD NOLOGGING';
                COMMIT;
            EXCEPTION
                WHEN OTHERS THEN
                    DBMS_OUTPUT.PUT_LINE('    Error en ' || idx.index_name || ': ' || SQLERRM);
                    ROLLBACK;
            END;
        END LOOP;
        
        -- 2. Reconstruir índices PARTICIONADOS (particiones UNUSABLE en USER_IND_PARTITIONS)
        FOR idx IN (SELECT index_name, table_name 
                    FROM user_indexes 
                    WHERE partitioned = 'YES') LOOP
            
            FOR part IN (SELECT partition_name 
                         FROM user_ind_partitions 
                         WHERE index_name = idx.index_name 
                           AND status = 'UNUSABLE') LOOP
                BEGIN
                    DBMS_OUTPUT.PUT_LINE('  Reconstruyendo partición ' || part.partition_name || 
                                         ' del índice particionado ' || idx.index_name);
                    EXECUTE IMMEDIATE 'ALTER INDEX ' || idx.index_name || 
                                      ' REBUILD PARTITION ' || part.partition_name || ' NOLOGGING';
                    COMMIT;
                EXCEPTION
                    WHEN OTHERS THEN
                        DBMS_OUTPUT.PUT_LINE('    Error en ' || idx.index_name || 
                                             ' (' || part.partition_name || '): ' || SQLERRM);
                        ROLLBACK;
                END;
            END LOOP;
        END LOOP;
        
        -- 3. Índices NO particionados que estén en estado UNUSABLE pero con partitioned = 'N/A' (caso raro)
        FOR idx IN (SELECT index_name, table_name 
                    FROM user_indexes 
                    WHERE status = 'UNUSABLE' 
                      AND partitioned = 'N/A') LOOP
            BEGIN
                DBMS_OUTPUT.PUT_LINE('  Reconstruyendo índice (N/A): ' || idx.index_name);
                EXECUTE IMMEDIATE 'ALTER INDEX ' || idx.index_name || ' REBUILD NOLOGGING';
                COMMIT;
            EXCEPTION
                WHEN OTHERS THEN
                    DBMS_OUTPUT.PUT_LINE('    Error en ' || idx.index_name || ': ' || SQLERRM);
                    ROLLBACK;
            END;
        END LOOP;
        
        DBMS_OUTPUT.PUT_LINE('=== PROCESO COMPLETADO ===');
        DBMS_OUTPUT.PUT_LINE('Particiones eliminadas: ' || v_count_dropped);
        DBMS_OUTPUT.PUT_LINE('Particiones verificadas con COUNT(1): ' || v_count_checked);
        DBMS_OUTPUT.PUT_LINE('Particiones saltadas por estadísticas (tienen datos): ' || v_count_skipped_by_stats);
        DBMS_OUTPUT.PUT_LINE('Duración total: ' || EXTRACT(SECOND FROM (SYSTIMESTAMP - v_start_time)) || ' segundos');
        
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR GLOBAL: ' || SQLERRM);
            ROLLBACK;
            RAISE;
    END ELIMINAR_PARTICIONES_VACIAS;
    
END MANTENIMIENTO_TABLAS_PCP_HIST_PKG;
/