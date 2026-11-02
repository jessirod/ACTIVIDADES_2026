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
