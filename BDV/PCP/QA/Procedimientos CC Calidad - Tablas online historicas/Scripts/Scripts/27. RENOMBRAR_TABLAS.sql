CREATE OR REPLACE PROCEDURE PCP.SWAP_TABLAS_PCP IS
    v_step VARCHAR2(100);
    v_sql  VARCHAR2(4000);
    
    -- Lista de tablas de producción que serán renombradas a _OLD
    -- Orden: de más dependiente a más independiente (hijas primero)
    TYPE t_tab_list IS TABLE OF VARCHAR2(30);
    v_old_tables t_tab_list := t_tab_list('CREDITS_CREDITO_INMEDIATO',  -- depende de CREDITS
                                          'TRACK_ORDEN',                 -- depende de ORDEN (varchar2)
                                          'ORDEN_DETAIL',                -- depende de ORDEN
                                          'CREDITS',                     -- depende de DEBITS
                                          'DEBITS',                      -- depende de ORDEN
                                          'ORDEN');                      -- padre
    
    -- Lista de tablas _NEW que se renombrarán a producción (orden inverso: padres primero)
    v_new_tables t_tab_list := t_tab_list('ORDEN',
                                          'DEBITS',
                                          'CREDITS',
                                          'ORDEN_DETAIL',
                                          'TRACK_ORDEN',
                                          'CREDITS_CREDITO_INMEDIATO');
    
    -- Cursores para obtener las FK que apuntan a una tabla dada
    CURSOR c_fk(p_table VARCHAR2) IS
        SELECT a.constraint_name, a.table_name
        FROM user_constraints a
        JOIN user_constraints b ON a.r_constraint_name = b.constraint_name
        WHERE b.table_name = p_table
          AND a.constraint_type = 'R';
    
    -- Procedimiento local para ejecutar un ALTER y mostrar mensaje
    PROCEDURE exec_alter(p_sql VARCHAR2) IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('  ' || p_sql);
        EXECUTE IMMEDIATE p_sql;
    END exec_alter;
    
    -- Procedimiento para ajustar una secuencia identity al máximo valor de la columna + 1
    PROCEDURE adjust_identity(p_table_name VARCHAR2, p_column_name VARCHAR2) IS
        v_seq_name VARCHAR2(30);
        v_max_val  NUMBER;
        v_curr_val NUMBER;
        v_diff     NUMBER;
    BEGIN
        -- Obtener el nombre de la secuencia asociada a la columna identity
        BEGIN
            SELECT sequence_name INTO v_seq_name
            FROM user_tab_identity_cols
            WHERE table_name = p_table_name AND column_name = p_column_name;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('  No se encontró identity para ' || p_table_name || '.' || p_column_name);
                RETURN;
        END;
        
        -- Obtener el máximo valor actual de la columna
        EXECUTE IMMEDIATE 'SELECT NVL(MAX(' || p_column_name || '), 0) FROM PCP.' || p_table_name INTO v_max_val;
        
        -- Obtener el valor actual de la secuencia (nextval sin incrementar)
        EXECUTE IMMEDIATE 'SELECT ' || v_seq_name || '.NEXTVAL FROM DUAL' INTO v_curr_val;
        v_curr_val := v_curr_val - 1; -- porque NEXTVAL avanza, pero ya lo tenemos
        
        -- Calcular la diferencia necesaria
        v_diff := v_max_val - v_curr_val;
        
        IF v_diff > 0 THEN
            -- Ajustar la secuencia incrementando en v_diff para que el próximo NEXTVAL dé el valor deseado
            EXECUTE IMMEDIATE 'ALTER SEQUENCE ' || v_seq_name || ' INCREMENT BY ' || v_diff;
            -- Forzar un avance (no es necesario, pero lo hacemos para que quede en el valor correcto)
            EXECUTE IMMEDIATE 'SELECT ' || v_seq_name || '.NEXTVAL FROM DUAL' INTO v_curr_val;
            -- Restablecer el incremento a 1
            EXECUTE IMMEDIATE 'ALTER SEQUENCE ' || v_seq_name || ' INCREMENT BY 1';
            DBMS_OUTPUT.PUT_LINE('  Secuencia ' || v_seq_name || ' ajustada a ' || (v_max_val + 1));
        ELSE
            DBMS_OUTPUT.PUT_LINE('  Secuencia ' || v_seq_name || ' ya está en el valor correcto (máximo=' || v_max_val || ')');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('  Error al ajustar identity para ' || p_table_name || '.' || p_column_name || ': ' || SQLERRM);
    END adjust_identity;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== INICIANDO SWAP SEGURO DE TABLAS PCP ===');

    -- =====================================================
    -- PASO 1: Deshabilitar TODAS las FK que apuntan a las tablas a renombrar
    -- =====================================================
    v_step := 'Deshabilitando Foreign Keys';
    DBMS_OUTPUT.PUT_LINE(v_step || '...');
    
    FOR i IN 1..v_old_tables.COUNT LOOP
        FOR fk IN c_fk(v_old_tables(i)) LOOP
            v_sql := 'ALTER TABLE ' || fk.table_name || ' DISABLE CONSTRAINT ' || fk.constraint_name;
            exec_alter(v_sql);
        END LOOP;
    END LOOP;

    -- =====================================================
    -- PASO 2: Renombrar tablas de producción a _OLD
    -- =====================================================
    v_step := 'Renombrando producción a _OLD';
    DBMS_OUTPUT.PUT_LINE(v_step || '...');
    
    FOR i IN 1..v_old_tables.COUNT LOOP
        v_sql := 'ALTER TABLE ' || v_old_tables(i) || ' RENAME TO ' || v_old_tables(i) || '_OLD';
        exec_alter(v_sql);
    END LOOP;

    -- =====================================================
    -- PASO 3: Renombrar tablas _NEW a producción
    -- =====================================================
    v_step := 'Renombrando _NEW a producción';
    DBMS_OUTPUT.PUT_LINE(v_step || '...');
    
    FOR i IN 1..v_new_tables.COUNT LOOP
        v_sql := 'ALTER TABLE ' || v_new_tables(i) || '_NEW RENAME TO ' || v_new_tables(i);
        exec_alter(v_sql);
    END LOOP;

    -- =====================================================
    -- PASO 4: Habilitar las FK con NOVALIDATE
    -- =====================================================
    v_step := 'Habilitando Foreign Keys con NOVALIDATE';
    DBMS_OUTPUT.PUT_LINE(v_step || '...');
    
    FOR i IN 1..v_new_tables.COUNT LOOP
        FOR fk IN c_fk(v_new_tables(i)) LOOP
            v_sql := 'ALTER TABLE ' || fk.table_name || ' ENABLE NOVALIDATE CONSTRAINT ' || fk.constraint_name;
            exec_alter(v_sql);
        END LOOP;
    END LOOP;

    -- =====================================================
    -- PASO 5: Ajustar secuencias identity (para Oracle 12c)
    -- =====================================================
    v_step := 'Ajustando secuencias identity';
    DBMS_OUTPUT.PUT_LINE(v_step || '...');
    
    -- Ajustar las tablas que tienen identity column
    adjust_identity('ORDEN', 'ID_ORDEN');
    adjust_identity('DEBITS', 'ID_DEBITS');
    adjust_identity('TRACK_ORDEN', 'ID_TRACK_ORDEN');
    adjust_identity('ORDEN_DETAIL', 'ID_ORDEN_DETAIL');


    DBMS_OUTPUT.PUT_LINE('=== SWAP COMPLETADO EXITOSAMENTE ===');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR en paso: ' || v_step);
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
        RAISE;
END SWAP_TABLAS_PCP;
/