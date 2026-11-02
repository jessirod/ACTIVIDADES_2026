BEGIN
    -- Eliminar el job si ya existe
    BEGIN
        DBMS_SCHEDULER.DROP_JOB(
            job_name => 'PCP.JOB_MIGRACION_DIARIA_HIST',
            force    => TRUE
        );
        DBMS_OUTPUT.PUT_LINE('Job anterior eliminado');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE != -27475 THEN
                DBMS_OUTPUT.PUT_LINE('Nota: ' || SQLERRM);
            END IF;
    END;
    
    DBMS_SCHEDULER.CREATE_JOB (
        job_name        => 'PCP.JOB_MIGRACION_DIARIA_HIST',
        job_type        => 'STORED_PROCEDURE',
        job_action      => 'PCP.MIGRACION_AUTOMATICA_DIARIA',
        start_date      => TRUNC(SYSDATE) + 2/24,   -- mañana a las 2 AM (si hoy ya pasó, empezará mañana)
        repeat_interval => 'FREQ=DAILY; BYHOUR=2; BYMINUTE=0; BYSECOND=0',
        enabled         => TRUE,
        comments        => 'Migración diaria automática (12 meses de antigüedad) a las 2 AM'
    );
    
    DBMS_OUTPUT.PUT_LINE('Job creado: JOB_MIGRACION_DIARIA_HIST (todos los días 2 AM)');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al crear job: ' || SQLERRM);
        RAISE;
END;
/