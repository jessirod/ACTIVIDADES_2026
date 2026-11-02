DECLARE
    v_action CLOB;
BEGIN
    -- Eliminar el job si ya existe
    BEGIN
        DBMS_SCHEDULER.DROP_JOB(
            job_name => 'PCP.JOB_SWAP_TABLAS_PCP',
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
            
            -- Lista de tablas de producción que serán renombradas a _OLD
            -- Orden: de más dependiente a más independiente (hijas primero)
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
            
            -- Lista de tablas _NEW que se renombrarán a producción (orden inverso: padres primero)
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
                WHERE b.table_name = p_table
                  AND a.constraint_type = 'R';
            
            PROCEDURE exec_alter(p_sql VARCHAR2) IS
            BEGIN
                DBMS_OUTPUT.PUT_LINE('  ' || p_sql);
                EXECUTE IMMEDIATE p_sql;
            END exec_alter;
            
            PROCEDURE adjust_identity(p_table_name VARCHAR2, p_column_name VARCHAR2) IS
                v_seq_name VARCHAR2(30);
                v_max_val  NUMBER;
                v_curr_val NUMBER;
                v_diff     NUMBER;
            BEGIN
                BEGIN
                    SELECT sequence_name INTO v_seq_name
                    FROM user_tab_identity_cols
                    WHERE table_name = p_table_name AND column_name = p_column_name;
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        DBMS_OUTPUT.PUT_LINE('  No se encontró identity para ' || p_table_name || '.' || p_column_name);
                        RETURN;
                END;
                
                EXECUTE IMMEDIATE 'SELECT NVL(MAX(' || p_column_name || '), 0) FROM PCP.' || p_table_name INTO v_max_val;
                EXECUTE IMMEDIATE 'SELECT ' || v_seq_name || '.NEXTVAL FROM DUAL' INTO v_curr_val;
                v_curr_val := v_curr_val - 1;
                
                v_diff := v_max_val - v_curr_val;
                
                IF v_diff > 0 THEN
                    EXECUTE IMMEDIATE 'ALTER SEQUENCE ' || v_seq_name || ' INCREMENT BY ' || v_diff;
                    EXECUTE IMMEDIATE 'SELECT ' || v_seq_name || '.NEXTVAL FROM DUAL' INTO v_curr_val;
                    EXECUTE IMMEDIATE 'ALTER SEQUENCE ' || v_seq_name || ' INCREMENT BY 1';
                    DBMS_OUTPUT.PUT_LINE('  Secuencia ' || v_seq_name || ' ajustada a ' || (v_max_val + 1));
                ELSE
                    DBMS_OUTPUT.PUT_LINE('  Secuencia ' || v_seq_name || ' ya está en el valor correcto');
                END IF;
            EXCEPTION
                WHEN OTHERS THEN
                    DBMS_OUTPUT.PUT_LINE('  Error en ' || p_table_name || '.' || p_column_name || ': ' || SQLERRM);
            END adjust_identity;
            
        BEGIN
            DBMS_OUTPUT.PUT_LINE('=== INICIANDO SWAP SEGURO DE TABLAS PCP ===');

            -- PASO 1: Deshabilitar FK
            v_step := 'Deshabilitando Foreign Keys';
            DBMS_OUTPUT.PUT_LINE(v_step || '...');
            FOR i IN 1..v_old_tables.COUNT LOOP
                FOR fk IN c_fk(v_old_tables(i)) LOOP
                    v_sql := 'ALTER TABLE ' || fk.table_name || ' DISABLE CONSTRAINT ' || fk.constraint_name;
                    exec_alter(v_sql);
                END LOOP;
            END LOOP;

            -- PASO 2: Renombrar producción a _OLD
            v_step := 'Renombrando producción a _OLD';
            DBMS_OUTPUT.PUT_LINE(v_step || '...');
            FOR i IN 1..v_old_tables.COUNT LOOP
                v_sql := 'ALTER TABLE ' || v_old_tables(i) || ' RENAME TO ' || v_old_tables(i) || '_OLD';
                exec_alter(v_sql);
            END LOOP;

            -- PASO 3: Renombrar _NEW a producción
            v_step := 'Renombrando _NEW a producción';
            DBMS_OUTPUT.PUT_LINE(v_step || '...');
            FOR i IN 1..v_new_tables.COUNT LOOP
                v_sql := 'ALTER TABLE ' || v_new_tables(i) || '_NEW RENAME TO ' || v_new_tables(i);
                exec_alter(v_sql);
            END LOOP;

            -- PASO 4: Habilitar FK con NOVALIDATE
            v_step := 'Habilitando Foreign Keys con NOVALIDATE';
            DBMS_OUTPUT.PUT_LINE(v_step || '...');
            FOR i IN 1..v_new_tables.COUNT LOOP
                FOR fk IN c_fk(v_new_tables(i)) LOOP
                    v_sql := 'ALTER TABLE ' || fk.table_name || ' ENABLE NOVALIDATE CONSTRAINT ' || fk.constraint_name;
                    exec_alter(v_sql);
                END LOOP;
            END LOOP;

            -- PASO 5: Ajustar secuencias identity
            v_step := 'Ajustando secuencias identity';
            DBMS_OUTPUT.PUT_LINE(v_step || '...');
            
            adjust_identity('ORDEN', 'ID_ORDEN');
            adjust_identity('DEBITS', 'ID_DEBITS');
            adjust_identity('TRACK_ORDEN', 'ID_TRACK_ORDEN');
            adjust_identity('ORDEN_DETAIL', 'ID_ORDEN_DETAIL');
            adjust_identity('TORDEN', 'ID_TORDEN');
            adjust_identity('TORDEN_ALTA', 'ID_TORDEN');
            adjust_identity('TORDEN_DETAIL', 'ID_TDETAIL');
            adjust_identity('TORDEN_DETAIL_ALTA', 'ID_TDETAIL');
            adjust_identity('TRACK_LOTE', 'ID_TRACK');

            -- PASO 6: Reconstruir índices de CREDITS
            v_step := 'Reconstruyendo índices de CREDITS';
            DBMS_OUTPUT.PUT_LINE(v_step || '...');

            FOR idx IN (SELECT index_name FROM user_indexes 
                        WHERE table_name = 'CREDITS' 
                          AND partitioned = 'NO' 
                          AND status = 'UNUSABLE') LOOP
                v_sql := 'ALTER INDEX ' || idx.index_name || ' REBUILD NOLOGGING';
                exec_alter(v_sql);
            END LOOP;

            FOR idx IN (SELECT index_name FROM user_indexes 
                        WHERE table_name = 'CREDITS' 
                          AND partitioned = 'YES' 
                          AND status = 'UNUSABLE') LOOP
                FOR part IN (SELECT partition_name 
                             FROM user_ind_partitions 
                             WHERE index_name = idx.index_name 
                               AND status = 'UNUSABLE') LOOP
                    v_sql := 'ALTER INDEX ' || idx.index_name || 
                             ' REBUILD PARTITION ' || part.partition_name || ' NOLOGGING';
                    exec_alter(v_sql);
                END LOOP;
            END LOOP;

            DBMS_OUTPUT.PUT_LINE('  Índices de CREDITS reconstruidos');
            DBMS_OUTPUT.PUT_LINE('=== SWAP COMPLETADO EXITOSAMENTE ===');
            
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('ERROR en paso: ' || v_step);
                DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
                RAISE;
        END;
    ]';
    
    -- Crear job con el bloque CLOB
    DBMS_SCHEDULER.CREATE_JOB (
        job_name        => 'PCP.JOB_SWAP_TABLAS_PCP',
        job_type        => 'PLSQL_BLOCK',
        job_action      => v_action,
        start_date      => SYSTIMESTAMP,
        repeat_interval => NULL,
        enabled         => TRUE,
        auto_drop       => TRUE,
        comments        => 'Swap de tablas PCP (incluye nuevas tablas) + Reconstrucción de índices de CREDITS'
    );
    
    DBMS_OUTPUT.PUT_LINE('Job creado: JOB_SWAP_TABLAS_PCP');
    DBMS_OUTPUT.PUT_LINE('El job se ejecutará inmediatamente y se eliminará automáticamente al finalizar.');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error al crear job: ' || SQLERRM);
        RAISE;
END;
/