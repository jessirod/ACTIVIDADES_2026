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
        P_MONTHS_RETENTION_H IN NUMBER,
        P_OUT_DATA OUT VARCHAR2,
        P_ID_ORDEN IN NUMBER DEFAULT NULL,
        P_START_DATE IN DATE DEFAULT NULL,
        P_END_DATE IN DATE DEFAULT NULL
    ) IS
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
                    RETURN;
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
                    HAVING MAX(PROCESS_DATE) < ADD_MONTHS(TRUNC(SYSDATE, 'MM'), -V_MONTHS_RETENTION_H);
                END IF;
                
                IF l_orden_ids.COUNT = 0 THEN
                    P_OUT_DATA := '04 No hay registros para el mantenimiento de ORDEN';
                    UPDATE PROCESS_CONTROL SET IS_ACTIVE = V_NO WHERE PROCESS_NAME = MANTENIMIENTO_PROCESS_NAME;
                    COMMIT;
                    RETURN;
                END IF;
            END IF;
            
            debug('DEBUG: Total órdenes a procesar: ' || l_orden_ids.COUNT);
            
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
                    
                    -- ============================================================
                    -- PASO 1: Insertar ORDEN y ORDEN_DETAIL en HIST (remoto) SIN PROCESS_DATE
                    -- ============================================================
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
                    
                    -- ============================================================
                    -- PASO 1.5: Migrar TRACK_ORDEN (con conversión explícita a VARCHAR2)
                    -- ============================================================
                    BEGIN
                        debug('DEBUG: Migrando TRACK_ORDEN para orden ' || v_orden_id);
                        
                        -- INSERT remoto - usando TO_CHAR para que coincida con VARCHAR2
                        EXECUTE IMMEDIATE '
                            INSERT INTO TRACK_ORDEN_HIST@' || c_db_link || '
                                (ID_TRACK_ORDEN, ID_ORDEN, STATUS, BUSINESS_STATUS_CODE, DESCRIPTION,
                                 RECORD_ENTRY_DATE, PAYMENT_TYPE, USUARIO, TIPO_PAGO, DESC_TIPO_PAGO)
                            SELECT 
                                ID_TRACK_ORDEN, ID_ORDEN, STATUS, BUSINESS_STATUS_CODE, DESCRIPTION,
                                RECORD_ENTRY_DATE, PAYMENT_TYPE, USUARIO, TIPO_PAGO, DESC_TIPO_PAGO
                            FROM TRACK_ORDEN
                            WHERE ID_ORDEN = TO_CHAR(:1)'
                        USING v_orden_id;
                        v_track_count := SQL%ROWCOUNT;
                        
                        -- DELETE local - también debe usar TO_CHAR
                        DELETE FROM TRACK_ORDEN WHERE ID_ORDEN = TO_CHAR(v_orden_id);
                        
                        debug('DEBUG: TRACK_ORDEN migrado. Filas: ' || v_track_count);
                        
                    EXCEPTION
                        WHEN OTHERS THEN
                            debug('ERROR en migración TRACK_ORDEN: ' || SQLERRM);
                            RAISE;
                    END;
                    
                    -- ============================================================
                    -- PASO 2: Obtener débitos de la orden
                    -- ============================================================
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
                    
                    -- ============================================================
                    -- PASO 3: Migrar CRÉDITOS por rangos (masivo y rápido)
                    -- ============================================================
                    v_start_credits := SYSTIMESTAMP;
                    
                    FOR i IN 1..v_debit_ids.COUNT LOOP
                        debug('DEBUG: Procesando débito ' || v_debit_ids(i));
                        
                        -- Obtener rango de IDs de créditos para este débito
                        BEGIN
                            SELECT MIN(ID_CREDITS), MAX(ID_CREDITS)
                            INTO v_min_credit_id, v_max_credit_id
                            FROM CREDITS
                            WHERE ID_DEBITS = v_debit_ids(i);
                            
                            IF v_min_credit_id IS NULL THEN
                                debug('DEBUG: No hay créditos para débito ' || v_debit_ids(i));
                                CONTINUE;
                            END IF;
                            
                            debug('DEBUG: Rango de créditos: ' || v_min_credit_id || ' - ' || v_max_credit_id);
                        EXCEPTION
                            WHEN OTHERS THEN
                                debug('ERROR obteniendo rango de créditos: ' || SQLERRM);
                                RAISE;
                        END;
                        
                        -- Procesar por lotes usando rangos de IDs
                        v_current_min := v_min_credit_id;
                        WHILE v_current_min <= v_max_credit_id LOOP
                            v_current_max := LEAST(v_current_min + c_batch_size - 1, v_max_credit_id);
                            
                            debug('DEBUG: Procesando lote de créditos ' || v_current_min || ' a ' || v_current_max);
                            
                            -- 1. INSERT remoto CREDITS_HIST (conserva PROCESS_DATE)
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
                            USING v_orden_id, v_max_debit_date, v_debit_ids(i), v_current_min, v_current_max;
                            v_credits_count := v_credits_count + SQL%ROWCOUNT;
                            
                            -- 2. INSERT remoto CREDITS_CREDITO_INMEDIATO_HIST (SIN PROCESS_DATE)
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
                            USING v_orden_id, v_debit_ids(i), v_current_min, v_current_max;
                            v_credits_inm_count := v_credits_inm_count + SQL%ROWCOUNT;
                            
                            -- 3. INSERT remoto DATOS_MOVIMIENTOS_HIST (SIN PROCESS_DATE)
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
                            USING v_orden_id, v_debit_ids(i), v_current_min, v_current_max;
                            v_datos_mov_count := v_datos_mov_count + SQL%ROWCOUNT;
                            
                            -- 4. INSERT remoto LOGS_RESP_PROC_PCP1_HIST (SIN PROCESS_DATE)
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
                            USING v_orden_id, v_debit_ids(i), v_current_min, v_current_max;
                            v_logs_count := v_logs_count + SQL%ROWCOUNT;
                            
                            -- 5. DELETE local CREDITS_CREDITO_INMEDIATO
                            DELETE FROM CREDITS_CREDITO_INMEDIATO
                            WHERE ID_CREDITS IN (
                                SELECT ID_CREDITS FROM CREDITS 
                                WHERE ID_DEBITS = v_debit_ids(i) AND ID_CREDITS BETWEEN v_current_min AND v_current_max
                            );
                            
                            -- 6. DELETE local DATOS_MOVIMIENTOS
                            DELETE FROM DATOS_MOVIMIENTOS
                            WHERE ID_CREDITO IN (
                                SELECT ID_CREDITS FROM CREDITS 
                                WHERE ID_DEBITS = v_debit_ids(i) AND ID_CREDITS BETWEEN v_current_min AND v_current_max
                            );
                            
                            -- 7. DELETE local LOGS_RESP_PROC_PCP1
                            DELETE FROM LOGS_RESP_PROC_PCP1
                            WHERE ID_CREDITO IN (
                                SELECT ID_CREDITS FROM CREDITS 
                                WHERE ID_DEBITS = v_debit_ids(i) AND ID_CREDITS BETWEEN v_current_min AND v_current_max
                            );
                            
                            -- 8. DELETE local CREDITS
                            DELETE FROM CREDITS
                            WHERE ID_DEBITS = v_debit_ids(i) AND ID_CREDITS BETWEEN v_current_min AND v_current_max;
                            
                            v_current_min := v_current_max + 1;
                        END LOOP;
                        
                        debug('DEBUG: Débito ' || v_debit_ids(i) || ' procesado. Créditos migrados: ' || v_credits_count);
                    END LOOP;
                    
                    l_t_credits := l_t_credits + elapsed_sec(v_start_credits, SYSTIMESTAMP);
                    
                    -- ============================================================
                    -- PASO 4: Mover DEBITS a HIST
                    -- ============================================================
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
                    
                    -- ============================================================
                    -- PASO 5: Eliminar ORDEN_DETAIL y ORDEN
                    -- ============================================================
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
            
            -- Insertar log de migración semanal
            IF P_ID_ORDEN IS NULL AND P_START_DATE IS NOT NULL AND P_END_DATE IS NOT NULL THEN
                BEGIN
                    INSERT INTO migration_week_log (
                        fecha_inicio, fecha_fin, semana_inicio, semana_fin,
                        ordenes_ok, ordenes_error, debits, credits, credits_inm,
                        datos_mov, num_logs, num_details, total_creditos, tiempo_por_credito,
                        segundos_total, t_orden_seg, t_debits_seg, t_credits_seg,
                        estado
                    ) VALUES (
                        l_start_time, SYSTIMESTAMP, P_START_DATE, P_END_DATE,
                        l_count_orden_success, l_count_orden_error, l_count_debits, l_count_credits,
                        l_count_credits_inm, l_count_datos_mov, l_count_logs, l_count_details,
                        l_count_credits,
                        CASE WHEN l_count_credits > 0 THEN (l_minutes * 60) / l_count_credits END,
                        l_minutes * 60,
                        l_t_orden, l_t_debits, l_t_credits,
                        'COMPLETADO'
                    );
                    COMMIT;
                EXCEPTION
                    WHEN OTHERS THEN
                        ROLLBACK;
                        NULL;
                END;
            END IF;
            
            -- Construir mensaje de salida
            IF P_ID_ORDEN IS NOT NULL THEN
                IF l_count_orden_success = 1 THEN
                    P_OUT_DATA := '00 Orden ' || P_ID_ORDEN || ' procesada exitosamente. ' ||
                                 'Debits: ' || l_count_debits || ', Credits: ' || l_count_credits ||
                                 ', Credits_Inmediato: ' || l_count_credits_inm || 
                                 ', Datos_Mov: ' || l_count_datos_mov || ', Logs: ' || l_count_logs ||
                                 ', Details: ' || l_count_details || ', Track: ' || l_count_track ||
                                 '. Tiempo: ' || ROUND(l_minutes, 2) || ' minutos';
                ELSE
                    P_OUT_DATA := '02 Error al procesar la orden ' || P_ID_ORDEN;
                END IF;
            ELSE
                DECLARE
                    v_resumen VARCHAR2(4000);
                BEGIN
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
                    P_OUT_DATA := CASE WHEN l_count_orden_error = 0 THEN '00 ' ELSE '02 ' END || v_resumen;
                END;
            END IF;
            
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

END MANTENIMIENTO_TABLAS_PCP_HIST_PKG;
/