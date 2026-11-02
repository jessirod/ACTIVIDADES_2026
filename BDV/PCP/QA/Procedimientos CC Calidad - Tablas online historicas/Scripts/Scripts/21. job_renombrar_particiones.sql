BEGIN
    BEGIN
        DBMS_SCHEDULER.DROP_JOB(
            job_name => 'PCP.JOB_RENOMBRAR_PARTICIONES',
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
        job_name        => 'PCP.JOB_RENOMBRAR_PARTICIONES',
        job_type        => 'STORED_PROCEDURE',
        job_action      => 'PCP.RENOMBRAR_PARTICIONES',
        start_date      => SYSTIMESTAMP,
        repeat_interval => 'FREQ=HOURLY; INTERVAL=6',
        enabled         => TRUE,
        comments        => 'Renombra particiones SYS_Pxxx de tablas PCP'
    );
    
    DBMS_OUTPUT.PUT_LINE('? Job creado: JOB_RENOMBRAR_PARTICIONES (cada 6 horas)');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('? Error al crear job: ' || SQLERRM);
        RAISE;
END;
/
