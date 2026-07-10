BEGIN
    -- Eliminar el job si ya existe
    BEGIN
        DBMS_SCHEDULER.DROP_JOB(
            job_name => 'PCP.JOB_MANTENIMIENTO_HIST',
            force    => TRUE
        );
        DBMS_OUTPUT.PUT_LINE('Job anterior eliminado');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE != -27475 THEN
                DBMS_OUTPUT.PUT_LINE('Nota: ' || SQLERRM);
            END IF;
    END;
    
    -- Crear job con dos pasos secuenciales (migración unificada + limpieza)
    DBMS_SCHEDULER.CREATE_JOB (
        job_name        => 'PCP.JOB_MANTENIMIENTO_HIST',
        job_type        => 'PLSQL_BLOCK',
        job_action      => '
            DECLARE
                v_out           VARCHAR2(4000);
                v_start         TIMESTAMP := SYSTIMESTAMP;
                v_ok_migracion  BOOLEAN := FALSE;
            BEGIN
                -- ============================================================
                -- PASO 1: Migración unificada (ORDEN + TORDEN/ALTAS + TRACK_LOTE)
                -- ============================================================
                DBMS_OUTPUT.PUT_LINE(''=== INICIO MIGRACIÓN UNIFICADA (ORDEN + TORDEN) ==='');
                PCP.MANTENIMIENTO_TABLAS_PCP_HIST_PKG.MANTENIMIENTO_PCP_HIST_DIARIO(
                    P_MONTHS_RETENTION_H   => 28,
                    P_OUT_DATA             => v_out,
                    P_ID_ORDEN             => NULL,
                    P_START_DATE           => NULL,
                    P_END_DATE             => NULL,
                    P_SKIP_ORDEN_MIGRATION => ''N'',   -- Por defecto, ejecuta ambos
                    P_ID_TORDEN            => NULL      -- Migra todos los que correspondan
                );
                DBMS_OUTPUT.PUT_LINE(''Resultado migración: '' || v_out);
                
                -- Verificar si la migración fue exitosa (código 00 o 02, o cualquier que no sea 99)
                IF SUBSTR(v_out, 1, 2) NOT IN (''99'') THEN
                    v_ok_migracion := TRUE;
                END IF;
                
                -- ============================================================
                -- PASO 2: Eliminar particiones vacías (solo si la migración no dio error grave)
                -- ============================================================
                IF v_ok_migracion THEN
                    DBMS_OUTPUT.PUT_LINE(''=== INICIO ELIMINACIÓN DE PARTICIONES VACÍAS ==='');
                    PCP.MANTENIMIENTO_TABLAS_PCP_HIST_PKG.ELIMINAR_PARTICIONES_VACIAS;
                    DBMS_OUTPUT.PUT_LINE(''=== ELIMINACIÓN DE PARTICIONES COMPLETADA ==='');
                ELSE
                    DBMS_OUTPUT.PUT_LINE(''No se ejecuta limpieza de particiones debido a error grave en la migración.'');
                END IF;
                
                DBMS_OUTPUT.PUT_LINE(''=== PROCESO COMPLETADO. Duración total: '' || 
                    EXTRACT(SECOND FROM (SYSTIMESTAMP - v_start)) || '' segundos ==='');
                    
            EXCEPTION
                WHEN OTHERS THEN
                    DBMS_OUTPUT.PUT_LINE(''ERROR GLOBAL: '' || SQLERRM);
                    -- No se ejecuta limpieza si hay error global
                    RAISE;
            END;
        ',
        start_date => TRUNC(SYSDATE) + 1 + (30 / 1440),   -- mañana a las 12:30 AM
        repeat_interval => 'FREQ=DAILY; BYHOUR=0; BYMINUTE=30; BYSECOND=0',
        enabled         => TRUE,
        comments        => 'Migración diaria unificada (ORDEN + TORDEN/ALTAS) + limpieza de particiones vacías'
    );
    
    DBMS_OUTPUT.PUT_LINE('Job creado: JOB_MANTENIMIENTO_HIST (todos los días a las 12:30 AM)');
    DBMS_OUTPUT.PUT_LINE('Secuencia: 1) Migración unificada (ORDEN + TORDEN/ALTAS), 2) Limpieza de particiones vacías');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al crear job: ' || SQLERRM);
        RAISE;
END;
/