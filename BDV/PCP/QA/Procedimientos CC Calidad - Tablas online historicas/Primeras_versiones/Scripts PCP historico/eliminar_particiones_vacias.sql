-- =====================================================
-- SCRIPT: Eliminación automática de particiones vacías
-- Esquema: PCP
-- Tablas: CREDITS, CREDITS_CREDITO_INMEDIATO, ORDEN_DETAIL,
--         ORDEN, DEBITS, TRACK_ORDEN
-- Descripción: Elimina particiones que no contienen registros
-- =====================================================

SET SERVEROUTPUT ON;
SET FEEDBACK ON;

-- =====================================================
-- 1. Creación del Procedure
-- =====================================================

CREATE OR REPLACE PROCEDURE PCP.ELIMINAR_PARTICIONES_VACIAS IS
    TYPE t_tables IS TABLE OF VARCHAR2(30);
    v_tables t_tables := t_tables('CREDITS', 'CREDITS_CREDITO_INMEDIATO', 'ORDEN_DETAIL', 
                                   'ORDEN', 'DEBITS', 'TRACK_ORDEN', 'LOGS_RESP_PROC_PCP1', 'DATOS_MOVIMIENTOS');
    
    TYPE t_initial_partitions IS TABLE OF VARCHAR2(30);
    v_initial_partitions t_initial_partitions := t_initial_partitions('CREDITS_INICIAL', 'CREDITO_INMEDIATO_inicial', 
                                                                        'ORDEN_DETAIL_inicial', 'ORDEN_inicial', 
                                                                        'DEBITS_inicial', 'TRACK_ORDEN_inicial', 
                                                                        'LOGS_RESP_PROC_PCP1', 'DATOS_MOVIMIENTOS');

    v_sql VARCHAR2(1000);
    v_num_rows NUMBER;
BEGIN
    FOR i IN 1..v_tables.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('--- Procesando tabla: ' || v_tables(i) || ' ---');
        
        FOR part IN (SELECT PARTITION_NAME FROM USER_TAB_PARTITIONS 
                     WHERE TABLE_NAME = v_tables(i) 
                     AND PARTITION_NAME != v_initial_partitions(i) 
                     AND PARTITION_NAME NOT LIKE '%INICIAL%' 
                     ORDER BY PARTITION_POSITION) LOOP
            
            -- Verificar si está vacía
            v_sql := 'SELECT COUNT(*) FROM PCP.' || v_tables(i) || ' PARTITION (' || part.PARTITION_NAME || ')';
            EXECUTE IMMEDIATE v_sql INTO v_num_rows;
            
            IF v_num_rows = 0 THEN
                DBMS_OUTPUT.PUT_LINE('Eliminando: ' || part.PARTITION_NAME);
                
                -- DROP con actualización de globales
                EXECUTE IMMEDIATE 'ALTER TABLE PCP.' || v_tables(i) || ' DROP PARTITION ' || part.PARTITION_NAME || ' UPDATE GLOBAL INDEXES';
                
                -- BLOQUE DE REPARACIÓN AUTOMÁTICA (REBUILD)
                -- Escanea índices locales y globales que hayan quedado en estado UNUSABLE
                FOR idx IN (SELECT index_name, partitioned 
                            FROM user_indexes 
                            WHERE table_name = v_tables(i) 
                            AND status = 'UNUSABLE') LOOP
                    
                    DBMS_OUTPUT.PUT_LINE('Reparando índice: ' || idx.index_name);
                    
                    IF idx.partitioned = 'YES' THEN
                        -- Para índices particionados (locales), rebuild de la partición específica
                        FOR part_idx IN (SELECT partition_name FROM user_ind_partitions 
                                         WHERE index_name = idx.index_name AND status = 'UNUSABLE') LOOP
                            EXECUTE IMMEDIATE 'ALTER INDEX ' || idx.index_name || ' REBUILD PARTITION ' || part_idx.partition_name;
                        END LOOP;
                    ELSE
                        -- Para índices globales (no particionados)
                        EXECUTE IMMEDIATE 'ALTER INDEX ' || idx.index_name || ' REBUILD';
                    END IF;
                END LOOP;
            END IF;
        END LOOP;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('=== PROCESO COMPLETADO Y CELDAS DE ÍNDICES REPARADAS ===');
END ELIMINAR_PARTICIONES_VACIAS;
/

-- Verificar que el procedimiento se creó correctamente
SHOW ERRORS PROCEDURE PCP.ELIMINAR_PARTICIONES_VACIAS;

-- =====================================================
-- 2. Creación del Job programado (ejecución diaria a las 3:00 AM)
-- =====================================================

BEGIN
    -- Eliminar el job si ya existe
    BEGIN
        DBMS_SCHEDULER.DROP_JOB(
            job_name => 'PCP.JOB_ELIMINAR_PARTICIONES_VACIAS',
            force    => TRUE
        );
        DBMS_OUTPUT.PUT_LINE('Job anterior eliminado (si existía)');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE != -27475 THEN
                DBMS_OUTPUT.PUT_LINE('Nota: ' || SQLERRM);
            END IF;
    END;
    
    -- Crear el nuevo job con frecuencia diaria a las 3:00 AM
    DBMS_SCHEDULER.CREATE_JOB (
        job_name        => 'PCP.JOB_ELIMINAR_PARTICIONES_VACIAS',
        job_type        => 'STORED_PROCEDURE',
        job_action      => 'PCP.ELIMINAR_PARTICIONES_VACIAS',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'FREQ=DAILY; BYHOUR=3; BYMINUTE=0; BYSECOND=0',
        enabled         => TRUE,
        comments        => 'Elimina particiones vacías de las tablas principales PCP'
    );
    
    DBMS_OUTPUT.PUT_LINE('? Job creado exitosamente: JOB_ELIMINAR_PARTICIONES_VACIAS');
    DBMS_OUTPUT.PUT_LINE('   - Frecuencia: Diaria a las 03:00 AM');
    DBMS_OUTPUT.PUT_LINE('   - Próxima ejecución: ' || TO_CHAR(TRUNC(SYSDATE) + 3/24, 'YYYY-MM-DD HH24:MI:SS'));
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('? Error al crear el job: ' || SQLERRM);
        RAISE;
END;
/

-- =====================================================
-- 3. Verificación de la instalación
-- =====================================================

-- Verificar que el procedimiento existe
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM USER_PROCEDURES
    WHERE OBJECT_NAME = 'ELIMINAR_PARTICIONES_VACIAS';
    
    IF v_count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('? Procedimiento ELIMINAR_PARTICIONES_VACIAS instalado correctamente');
    ELSE
        DBMS_OUTPUT.PUT_LINE('? Error: Procedimiento no encontrado');
    END IF;
END;
/

-- Verificar que el job existe y está activo
SELECT 
    JOB_NAME,
    STATE,
    ENABLED,
    TO_CHAR(NEXT_RUN_DATE, 'YYYY-MM-DD HH24:MI:SS') AS PROXIMA_EJECUCION,
    REPEAT_INTERVAL
FROM USER_SCHEDULER_JOBS
WHERE JOB_NAME = 'JOB_ELIMINAR_PARTICIONES_VACIAS';

-- =====================================================
-- 4. Análisis de particiones vacías (para verificar antes de eliminar)
-- =====================================================

PROMPT
PROMPT =====================================================
PROMPT ANÁLISIS DE PARTICIONES VACÍAS
PROMPT =====================================================

DECLARE
    v_sql VARCHAR2(1000);
    v_count NUMBER;
BEGIN
    FOR part IN (SELECT TABLE_NAME, PARTITION_NAME
                 FROM USER_TAB_PARTITIONS
                 WHERE TABLE_NAME IN ('CREDITS', 'CREDITS_CREDITO_INMEDIATO', 
                                      'ORDEN_DETAIL', 'ORDEN', 'DEBITS', 'TRACK_ORDEN',
				      'LOGS_RESP_PROC_PCP1', 'DATOS_MOVIMIENTOS')
                   AND PARTITION_NAME NOT LIKE '%INICIAL%'
                 ORDER BY TABLE_NAME, PARTITION_POSITION) LOOP
        
        v_sql := 'SELECT COUNT(*) FROM PCP.' || part.TABLE_NAME || 
                 ' PARTITION (' || part.PARTITION_NAME || ')';
        EXECUTE IMMEDIATE v_sql INTO v_count;
        
        IF v_count = 0 THEN
            DBMS_OUTPUT.PUT_LINE('???  Vacía: ' || part.TABLE_NAME || '.' || part.PARTITION_NAME);
        ELSE
            DBMS_OUTPUT.PUT_LINE('?? Con datos: ' || part.TABLE_NAME || '.' || part.PARTITION_NAME || 
                                 ' (' || v_count || ' registros)');
        END IF;
    END LOOP;
END;
/

-- =====================================================
-- 5. Prueba manual (opcional - descomentar para probar)
-- =====================================================

/*
-- Ejecutar manualmente para probar el procedimiento
BEGIN
    PCP.ELIMINAR_PARTICIONES_VACIAS;
END;
/

-- Verificar resultado
SELECT TABLE_NAME, PARTITION_NAME, NUM_ROWS
FROM USER_TAB_PARTITIONS
WHERE TABLE_NAME IN ('CREDITS', 'CREDITS_CREDITO_INMEDIATO', 
                     'ORDEN_DETAIL', 'ORDEN', 'DEBITS', 'TRACK_ORDEN',
		     'LOGS_RESP_PROC_PCP1', 'DATOS_MOVIMIENTOS')
ORDER BY TABLE_NAME, PARTITION_POSITION;
*/

-- =====================================================
-- FIN DEL SCRIPT PRINCIPAL
-- =====================================================
PROMPT
PROMPT =====================================================
PROMPT INSTALACIÓN COMPLETADA
PROMPT =====================================================
PROMPT Procedimiento: PCP.ELIMINAR_PARTICIONES_VACIAS
PROMPT Job: PCP.JOB_ELIMINAR_PARTICIONES_VACIAS (diario a las 03:00 AM)
PROMPT =====================================================
PROMPT 
PROMPT Para ejecutar manualmente:
PROMPT EXEC PCP.ELIMINAR_PARTICIONES_VACIAS;
PROMPT 
PROMPT Para ver particiones vacías antes de eliminar:
PROMPT (El script ya muestra el análisis en la sección 4)
PROMPT =====================================================

-- =====================================================
-- 6. DESINSTALACIÓN (OPCIONAL)
-- =====================================================

/*
PROMPT
PROMPT =====================================================
PROMPT INICIANDO DESINSTALACIÓN
PROMPT =====================================================

BEGIN
    -- Eliminar el job programado
    BEGIN
        DBMS_SCHEDULER.DROP_JOB(
            job_name => 'PCP.JOB_ELIMINAR_PARTICIONES_VACIAS',
            force    => TRUE
        );
        DBMS_OUTPUT.PUT_LINE('? Job JOB_ELIMINAR_PARTICIONES_VACIAS eliminado');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -27475 THEN
                DBMS_OUTPUT.PUT_LINE('??  El job no existía');
            ELSE
                DBMS_OUTPUT.PUT_LINE('? Error al eliminar job: ' || SQLERRM);
            END IF;
    END;
    
    -- Eliminar el procedimiento
    BEGIN
        EXECUTE IMMEDIATE 'DROP PROCEDURE PCP.ELIMINAR_PARTICIONES_VACIAS';
        DBMS_OUTPUT.PUT_LINE('? Procedimiento ELIMINAR_PARTICIONES_VACIAS eliminado');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -4043 THEN
                DBMS_OUTPUT.PUT_LINE('??  El procedimiento no existía');
            ELSE
                DBMS_OUTPUT.PUT_LINE('? Error al eliminar procedimiento: ' || SQLERRM);
            END IF;
    END;
    
    DBMS_OUTPUT.PUT_LINE('=========================================');
    DBMS_OUTPUT.PUT_LINE('DESINSTALACIÓN COMPLETADA');
    DBMS_OUTPUT.PUT_LINE('=========================================');
END;
/
*/

-- =====================================================
-- FIN DEL SCRIPT COMPLETO
-- =====================================================