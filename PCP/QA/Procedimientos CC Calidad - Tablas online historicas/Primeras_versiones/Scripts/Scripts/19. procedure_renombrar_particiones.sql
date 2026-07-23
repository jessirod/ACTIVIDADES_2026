CREATE OR REPLACE PROCEDURE PCP.RENOMBRAR_PARTICIONES IS
    /*
    Propósito: Renombra automáticamente las particiones con nombres genéricos (SYS_Pxxxx)
    de las tablas especificadas.
    
    Para tablas por FECHA: usa PARTITION_POSITION para generar nombre secuencial
    Para CREDITS: usa HIGH_VALUE (numérico) para el nombre
    
    NOTA: HIGH_VALUE es tipo LONG, por lo que se maneja con DBMS_SQL
    */
    
    TYPE t_tables IS TABLE OF VARCHAR2(30);
    v_tables t_tables := t_tables('CREDITS',
                                   'CREDITS_CREDITO_INMEDIATO',
                                   'ORDEN_DETAIL',
                                   'ORDEN',
                                   'DEBITS',
                                   'TRACK_ORDEN');
    
    v_nuevo_nombre VARCHAR2(100);
    v_contador_total NUMBER := 0;
    v_contador_tabla NUMBER;
    v_high_value VARCHAR2(4000);
    v_cursor NUMBER;
    v_ignore NUMBER;
    
    -- Función para obtener HIGH_VALUE como VARCHAR2
    FUNCTION get_high_value(p_table_name VARCHAR2, p_partition_name VARCHAR2) RETURN VARCHAR2 IS
        v_high_value VARCHAR2(4000);
        v_cursor NUMBER;
        v_ignore NUMBER;
    BEGIN
        v_cursor := DBMS_SQL.OPEN_CURSOR;
        DBMS_SQL.PARSE(v_cursor, 'SELECT HIGH_VALUE FROM USER_TAB_PARTITIONS 
                                  WHERE TABLE_NAME = :T AND PARTITION_NAME = :P', DBMS_SQL.NATIVE);
        DBMS_SQL.BIND_VARIABLE(v_cursor, ':T', p_table_name);
        DBMS_SQL.BIND_VARIABLE(v_cursor, ':P', p_partition_name);
        DBMS_SQL.DEFINE_COLUMN(v_cursor, 1, v_high_value, 4000);
        v_ignore := DBMS_SQL.EXECUTE_AND_FETCH(v_cursor);
        DBMS_SQL.COLUMN_VALUE(v_cursor, 1, v_high_value);
        DBMS_SQL.CLOSE_CURSOR(v_cursor);
        RETURN v_high_value;
    EXCEPTION
        WHEN OTHERS THEN
            IF DBMS_SQL.IS_OPEN(v_cursor) THEN
                DBMS_SQL.CLOSE_CURSOR(v_cursor);
            END IF;
            RETURN NULL;
    END get_high_value;
    
    -- Función para extraer el valor numérico del HIGH_VALUE (para CREDITS)
    FUNCTION extraer_numero_from_high_value(p_high_value VARCHAR2) RETURN NUMBER IS
        v_num_str VARCHAR2(100);
        v_pos NUMBER;
        v_result NUMBER;
    BEGIN
        IF p_high_value IS NULL THEN
            RETURN NULL;
        END IF;
        
        -- Buscar el número dentro del HIGH_VALUE
        -- Ejemplo: "PARTITION CREDITS_INICIAL VALUES LESS THAN (10000001)"
        v_pos := INSTR(p_high_value, 'VALUES LESS THAN (');
        IF v_pos > 0 THEN
            v_num_str := SUBSTR(p_high_value, v_pos + 19);
            v_pos := INSTR(v_num_str, ')');
            IF v_pos > 0 THEN
                v_num_str := SUBSTR(v_num_str, 1, v_pos - 1);
                v_num_str := REPLACE(v_num_str, ' ', '');
                v_num_str := REPLACE(v_num_str, 'TO_DATE', '');
                -- Limpiar caracteres no numéricos
                v_num_str := REGEXP_SUBSTR(v_num_str, '[0-9]+');
                IF v_num_str IS NOT NULL THEN
                    RETURN TO_NUMBER(v_num_str);
                END IF;
            END IF;
        END IF;
        RETURN NULL;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN NULL;
    END extraer_numero_from_high_value;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== INICIANDO RENOMBRADO DE PARTICIONES ===');
    DBMS_OUTPUT.PUT_LINE('Fecha/Hora: ' || TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('Esquema: PCP');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    
    FOR i IN 1..v_tables.COUNT LOOP
        v_contador_tabla := 0;
        DBMS_OUTPUT.PUT_LINE('Procesando tabla: ' || v_tables(i));
        
        -- Para cada partición SYS_P% de la tabla
        FOR part IN (SELECT PARTITION_NAME, PARTITION_POSITION
                     FROM USER_TAB_PARTITIONS
                     WHERE TABLE_NAME = v_tables(i)
                       AND PARTITION_NAME LIKE 'SYS_P%'
                     ORDER BY PARTITION_POSITION) LOOP
            
            BEGIN
                -- Caso especial para CREDITS (partición numérica)
                IF v_tables(i) = 'CREDITS' THEN
                    v_high_value := get_high_value(v_tables(i), part.PARTITION_NAME);
                    v_nuevo_nombre := extraer_numero_from_high_value(v_high_value);
                    
                    IF v_nuevo_nombre IS NOT NULL THEN
                        v_nuevo_nombre := v_tables(i) || '_' || TO_CHAR(v_nuevo_nombre);
                    ELSE
                        -- Fallback: usar posición
                        v_nuevo_nombre := v_tables(i) || '_' || part.PARTITION_POSITION;
                    END IF;
                ELSE
                    -- Para tablas por FECHA: usar posición secuencial
                    v_nuevo_nombre := v_tables(i) || '_' || part.PARTITION_POSITION;
                END IF;
                
                -- Renombrar partición
                IF part.PARTITION_NAME != v_nuevo_nombre THEN
                    EXECUTE IMMEDIATE 'ALTER TABLE PCP.' || v_tables(i) || 
                                      ' RENAME PARTITION ' || part.PARTITION_NAME || 
                                      ' TO ' || v_nuevo_nombre;
                    
                    DBMS_OUTPUT.PUT_LINE('  ? Renombrada: ' || RPAD(part.PARTITION_NAME, 25) || 
                                         ' -> ' || v_nuevo_nombre);
                    v_contador_tabla := v_contador_tabla + 1;
                END IF;
                
            EXCEPTION
                WHEN OTHERS THEN
                    DBMS_OUTPUT.PUT_LINE('  ? Error en ' || part.PARTITION_NAME || ': ' || SQLERRM);
            END;
        END LOOP;
        
        DBMS_OUTPUT.PUT_LINE('  ?? Renombradas en ' || v_tables(i) || ': ' || v_contador_tabla);
        v_contador_total := v_contador_total + v_contador_tabla;
        DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('=== PROCESO COMPLETADO ===');
    DBMS_OUTPUT.PUT_LINE('Total particiones renombradas: ' || v_contador_total);
    
    IF v_contador_total = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No se encontraron particiones SYS_P% para renombrar.');
    END IF;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('? ERROR: ' || SQLERRM);
        RAISE;
END RENOMBRAR_PARTICIONES;
/
