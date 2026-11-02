DECLARE
    v_action CLOB;
BEGIN
    -- Eliminar el job si ya existe
    BEGIN
        DBMS_SCHEDULER.DROP_JOB(
            job_name => 'PCP.JOB_REVERT_SWAP_TABLAS_PCP',
            force    => TRUE
        );
        DBMS_OUTPUT.PUT_LINE('Job anterior eliminado');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE != -27475 THEN
                DBMS_OUTPUT.PUT_LINE('Nota: ' || SQLERRM);
            END IF;
    END;
    
    -- Definir el bloque PL/SQL completo como CLOB
    v_action := q'[
        DECLARE
            v_step VARCHAR2(100);
            v_sql  VARCHAR2(4000);
            
            TYPE t_tab_list IS TABLE OF VARCHAR2(30);
            
            v_old_tables t_tab_list := t_tab_list(
                'CREDITS_CREDITO_INMEDIATO',
                'TRACK_ORDEN',
                'ORDEN_DETAIL',
                'CREDITS',
                'DEBITS',
                'ORDEN',
                'TORDEN_DETAIL',
                'TORDEN_DETAIL_ALTA',
                'TRACK_LOTE',
                'TORDEN',
                'TORDEN_ALTA'
            );
            
            v_new_tables t_tab_list := t_tab_list(
                'ORDEN',
                'DEBITS',
                'CREDITS',
                'ORDEN_DETAIL',
                'TRACK_ORDEN',
                'CREDITS_CREDITO_INMEDIATO',
                'TORDEN',
                'TORDEN_ALTA',
                'TORDEN_DETAIL',
                'TORDEN_DETAIL_ALTA',
                'TRACK_LOTE'
            );
            
            CURSOR c_fk(p_table VARCHAR2) IS
                SELECT a.constraint_name, a.table_name
                FROM user_constraints a
                JOIN user_constraints b ON a.r_constraint_name = b.constraint_name
                WHERE b.table_name = p_table AND a.constraint_type = 'R';
            
            PROCEDURE exec_alter(p_sql VARCHAR2) IS
            BEGIN
                DBMS_OUTPUT.PUT_LINE('  ' || p_sql);
                EXECUTE IMMEDIATE p_sql;
            END exec_alter;
            
        BEGIN
            DBMS_OUTPUT.PUT_LINE('=== INICIANDO REVERSIÓN DE SWAP ===');

            v_step := 'Deshabilitando Foreign Keys';
            DBMS_OUTPUT.PUT_LINE(v_step || '...');
            FOR i IN 1..v_old_tables.COUNT LOOP
                FOR fk IN c_fk(v_old_tables(i)) LOOP
                    exec_alter('ALTER TABLE ' || fk.table_name || ' DISABLE CONSTRAINT ' || fk.constraint_name);
                END LOOP;
            END LOOP;

            v_step := 'Renombrando producción (nuevas) a _NEW';
            DBMS_OUTPUT.PUT_LINE(v_step || '...');
            FOR i IN 1..v_old_tables.COUNT LOOP
                exec_alter('ALTER TABLE ' || v_old_tables(i) || ' RENAME TO ' || v_old_tables(i) || '_NEW');
            END LOOP;

            v_step := 'Renombrando _OLD a producción (originales)';
            DBMS_OUTPUT.PUT_LINE(v_step || '...');
            FOR i IN 1..v_new_tables.COUNT LOOP
                exec_alter('ALTER TABLE ' || v_new_tables(i) || '_OLD RENAME TO ' || v_new_tables(i));
            END LOOP;

            v_step := 'Habilitando FK con NOVALIDATE';
            DBMS_OUTPUT.PUT_LINE(v_step || '...');
            FOR i IN 1..v_new_tables.COUNT LOOP
                FOR fk IN c_fk(v_new_tables(i)) LOOP
                    exec_alter('ALTER TABLE ' || fk.table_name || ' ENABLE NOVALIDATE CONSTRAINT ' || fk.constraint_name);
                END LOOP;
            END LOOP;

            -- Reconstruir índices de CREDITS (igual que en el swap)
            v_step := 'Reconstruyendo índices de CREDITS';
            DBMS_OUTPUT.PUT_LINE(v_step || '...');

            FOR idx IN (SELECT index_name FROM user_indexes 
                        WHERE table_name = 'CREDITS' 
                          AND partitioned = 'NO' 
                          AND status = 'UNUSABLE') LOOP
                exec_alter('ALTER INDEX ' || idx.index_name || ' REBUILD NOLOGGING');
            END LOOP;

            FOR idx IN (SELECT index_name FROM user_indexes 
                        WHERE table_name = 'CREDITS' 
                          AND partitioned = 'YES' 
                          AND status = 'UNUSABLE') LOOP
                FOR part IN (SELECT partition_name 
                             FROM user_ind_partitions 
                             WHERE index_name = idx.index_name 
                               AND status = 'UNUSABLE') LOOP
                    exec_alter('ALTER INDEX ' || idx.index_name || 
                               ' REBUILD PARTITION ' || part.partition_name || ' NOLOGGING');
                END LOOP;
            END LOOP;

            DBMS_OUTPUT.PUT_LINE('  Índices de CREDITS reconstruidos');
            DBMS_OUTPUT.PUT_LINE('=== REVERSIÓN COMPLETADA EXITOSAMENTE ===');
            
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('ERROR en paso: ' || v_step);
                DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
                RAISE;
        END;
    ]';
    
    -- Crear job con el bloque CLOB
    DBMS_SCHEDULER.CREATE_JOB (
        job_name        => 'PCP.JOB_REVERT_SWAP_TABLAS_PCP',
        job_type        => 'PLSQL_BLOCK',
        job_action      => v_action,
        start_date      => SYSTIMESTAMP,
        repeat_interval => NULL,
        enabled         => TRUE,
        auto_drop       => TRUE,
        comments        => 'Reversión de Swap de tablas PCP (incluye nuevas tablas)'
    );
    
    DBMS_OUTPUT.PUT_LINE('Job creado: JOB_REVERT_SWAP_TABLAS_PCP');
    DBMS_OUTPUT.PUT_LINE('El job se ejecutará inmediatamente y se eliminará automáticamente al finalizar.');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al crear job: ' || SQLERRM);
        RAISE;
END;
/