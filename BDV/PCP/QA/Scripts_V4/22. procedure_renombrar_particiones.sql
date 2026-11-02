CREATE OR REPLACE PROCEDURE PCP.RENOMBRAR_PARTICIONES IS
    /*
    Propósito: Renombra automáticamente las particiones SYS_Pxxxx de las tablas principales.
    Ahora con extracción robusta de HIGH_VALUE para fechas (TO_DATE y TIMESTAMP) y números.
    */
    
    TYPE t_tables IS TABLE OF VARCHAR2(30);
    v_tables t_tables := t_tables('CREDITS',
                                   'CREDITS_CREDITO_INMEDIATO',
                                   'ORDEN_DETAIL',
                                   'ORDEN',
                                   'DEBITS',
                                   'TRACK_ORDEN',
                                   'TORDEN',
                                   'TORDEN_ALTA',
                                   'TORDEN_DETAIL',
                                   'TORDEN_DETAIL_ALTA',
                                   'TRACK_LOTE');
    
    v_nuevo_nombre VARCHAR2(100);
    v_contador_total NUMBER := 0;
    v_contador_tabla NUMBER;
    v_high_value VARCHAR2(4000);
    v_cursor NUMBER;
    v_ignore NUMBER;
    v_fecha DATE;
    v_valor_numerico NUMBER;
    
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
    
    -- =====================================================
    -- FUNCIÓN MEJORADA PARA EXTRAER FECHA (TO_DATE y TIMESTAMP)
    -- =====================================================
    FUNCTION extraer_fecha_from_high_value(p_high_value VARCHAR2) RETURN DATE IS
        v_fecha      DATE;
        v_fecha_str  VARCHAR2(200);
        v_pos        NUMBER;
        v_date_part  VARCHAR2(20);
        v_tipo       VARCHAR2(20);
    BEGIN
        IF p_high_value IS NULL THEN
            RETURN NULL;
        END IF;

        -- Detectar si es TO_DATE o TIMESTAMP
        v_tipo := UPPER(REGEXP_SUBSTR(p_high_value, '^(TO_DATE|TIMESTAMP)'));
        
        IF v_tipo IN ('TO_DATE', 'TIMESTAMP') THEN
            -- Extraer la cadena entre comillas simples
            v_pos := INSTR(p_high_value, '''');
            IF v_pos > 0 THEN
                v_fecha_str := SUBSTR(p_high_value, v_pos + 1);
                v_pos := INSTR(v_fecha_str, '''');
                IF v_pos > 0 THEN
                    v_fecha_str := SUBSTR(v_fecha_str, 1, v_pos - 1);
                    
                    -- Intentar extraer solo la parte de fecha (YYYY-MM-DD)
                    v_date_part := REGEXP_SUBSTR(v_fecha_str, '^\d{4}-\d{2}-\d{2}');
                    IF v_date_part IS NOT NULL THEN
                        BEGIN
                            v_fecha := TO_DATE(v_date_part, 'YYYY-MM-DD');
                            RETURN v_fecha;
                        EXCEPTION WHEN OTHERS THEN NULL;
                        END;
                    END IF;

                    -- Intentar con formato completo (YYYY-MM-DD HH24:MI:SS)
                    BEGIN
                        v_fecha := TO_DATE(v_fecha_str, 'YYYY-MM-DD HH24:MI:SS');
                        RETURN v_fecha;
                    EXCEPTION WHEN OTHERS THEN NULL;
                    END;

                    -- Intentar con DD-MM-YYYY
                    BEGIN
                        v_fecha := TO_DATE(v_fecha_str, 'DD-MM-YYYY');
                        RETURN v_fecha;
                    EXCEPTION WHEN OTHERS THEN NULL;
                    END;

                    -- Intentar con DD/MM/YYYY
                    BEGIN
                        v_fecha := TO_DATE(v_fecha_str, 'DD/MM/YYYY');
                        RETURN v_fecha;
                    EXCEPTION WHEN OTHERS THEN NULL;
                    END;

                    -- Si es TIMESTAMP, extraer la parte de fecha/hora sin zona
                    IF v_tipo = 'TIMESTAMP' THEN
                        BEGIN
                            v_fecha := TO_DATE(REGEXP_SUBSTR(v_fecha_str, '\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}'), 'YYYY-MM-DD HH24:MI:SS');
                            RETURN v_fecha;
                        EXCEPTION WHEN OTHERS THEN NULL;
                        END;
                    END IF;
                END IF;
            END IF;
        END IF;

        -- Fallback: intentar convertir directamente
        BEGIN
            v_fecha := TO_DATE(p_high_value, 'YYYY-MM-DD');
            RETURN v_fecha;
        EXCEPTION WHEN OTHERS THEN
            RETURN NULL;
        END;
    END extraer_fecha_from_high_value;
    -- =====================================================

    -- =====================================================
    -- FUNCIÓN MEJORADA PARA EXTRAER NÚMERO (robusta)
    -- =====================================================
    FUNCTION extraer_numero_from_high_value(p_high_value VARCHAR2) RETURN NUMBER IS
        v_num_str   VARCHAR2(100);
        v_pos       NUMBER;
        v_clean_num VARCHAR2(100);
    BEGIN
        IF p_high_value IS NULL THEN
            RETURN NULL;
        END IF;

        v_num_str := TRIM(p_high_value);

        -- 1) TO_NUMBER('123456') o TO_NUMBER(123456)
        v_pos := INSTR(UPPER(v_num_str), 'TO_NUMBER');
        IF v_pos > 0 THEN
            -- Buscar el primer número dentro
            v_num_str := REGEXP_SUBSTR(v_num_str, '[0-9]+');
            IF v_num_str IS NOT NULL THEN
                RETURN TO_NUMBER(v_num_str);
            END IF;
        END IF;

        -- 2) Número directo (puede tener comillas o no)
        v_clean_num := REGEXP_REPLACE(v_num_str, '[^0-9\-]', '');
        IF v_clean_num IS NOT NULL AND v_clean_num NOT IN ('-', '') THEN
            RETURN TO_NUMBER(v_clean_num);
        END IF;

        -- 3) Fallback: cualquier número en la cadena
        v_num_str := REGEXP_SUBSTR(p_high_value, '[0-9]+');
        IF v_num_str IS NOT NULL THEN
            RETURN TO_NUMBER(v_num_str);
        END IF;

        RETURN NULL;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN NULL;
    END extraer_numero_from_high_value;
    -- =====================================================

    -- Función para determinar si la tabla es por fecha o por número
    FUNCTION es_tabla_fecha(p_table_name VARCHAR2) RETURN BOOLEAN IS
    BEGIN
        IF p_table_name IN ('CREDITS_CREDITO_INMEDIATO',
                            'ORDEN',
                            'DEBITS',
                            'TORDEN',
                            'TORDEN_ALTA') THEN
            RETURN TRUE;
        ELSIF p_table_name IN ('CREDITS',
                               'ORDEN_DETAIL',
                               'TRACK_ORDEN',
                               'TORDEN_DETAIL',
                               'TORDEN_DETAIL_ALTA',
                               'TRACK_LOTE') THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    END es_tabla_fecha;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== INICIANDO RENOMBRADO DE PARTICIONES (PCP) ===');
    DBMS_OUTPUT.PUT_LINE('Fecha/Hora: ' || TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('Esquema: PCP');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    
    FOR i IN 1..v_tables.COUNT LOOP
        v_contador_tabla := 0;
        DBMS_OUTPUT.PUT_LINE('Procesando tabla: ' || v_tables(i));
        
        FOR part IN (SELECT PARTITION_NAME, PARTITION_POSITION
                     FROM USER_TAB_PARTITIONS
                     WHERE TABLE_NAME = v_tables(i)
                       AND PARTITION_NAME LIKE 'SYS_P%'
                     ORDER BY PARTITION_POSITION) LOOP
            
            BEGIN
                v_high_value := get_high_value(v_tables(i), part.PARTITION_NAME);
                
                IF es_tabla_fecha(v_tables(i)) THEN
                    v_fecha := extraer_fecha_from_high_value(v_high_value);
                    IF v_fecha IS NOT NULL THEN
                        v_nuevo_nombre := v_tables(i) || '_' || TO_CHAR(v_fecha, 'YYYYMM');
                    ELSE
                        v_nuevo_nombre := v_tables(i) || '_' || part.PARTITION_POSITION;
                        -- Mensaje de depuración si falla
                        DBMS_OUTPUT.PUT_LINE('  ⚠ No se pudo extraer fecha de ' || part.PARTITION_NAME || 
                                             ' (HIGH_VALUE: ' || NVL(v_high_value, 'NULL') || '), usando posición.');
                    END IF;
                ELSE
                    v_valor_numerico := extraer_numero_from_high_value(v_high_value);
                    IF v_valor_numerico IS NOT NULL THEN
                        IF v_tables(i) = 'ORDEN_DETAIL' THEN
                            v_nuevo_nombre := v_tables(i) || '_' || TO_CHAR(v_valor_numerico - 1000000);
                        ELSIF v_tables(i) = 'TRACK_ORDEN' THEN
                            v_nuevo_nombre := v_tables(i) || '_' || TO_CHAR(v_valor_numerico - 100000);
                        ELSE
                            v_nuevo_nombre := v_tables(i) || '_' || TO_CHAR(v_valor_numerico);
                        END IF;
                    ELSE
                        v_nuevo_nombre := v_tables(i) || '_' || part.PARTITION_POSITION;
                        DBMS_OUTPUT.PUT_LINE('  ⚠ No se pudo extraer número de ' || part.PARTITION_NAME || 
                                             ' (HIGH_VALUE: ' || NVL(v_high_value, 'NULL') || '), usando posición.');
                    END IF;
                END IF;
                
                IF part.PARTITION_NAME != v_nuevo_nombre THEN
                    EXECUTE IMMEDIATE 'ALTER TABLE PCP.' || v_tables(i) || 
                                      ' RENAME PARTITION ' || part.PARTITION_NAME || 
                                      ' TO ' || v_nuevo_nombre;
                    
                    DBMS_OUTPUT.PUT_LINE('  ✔ Renombrada: ' || RPAD(part.PARTITION_NAME, 25) || 
                                         ' -> ' || v_nuevo_nombre);
                    v_contador_tabla := v_contador_tabla + 1;
                END IF;
                
            EXCEPTION
                WHEN OTHERS THEN
                    DBMS_OUTPUT.PUT_LINE('  ✗ Error en ' || part.PARTITION_NAME || ': ' || SQLERRM);
            END;
        END LOOP;
        
        DBMS_OUTPUT.PUT_LINE('  ✓ Renombradas en ' || v_tables(i) || ': ' || v_contador_tabla);
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
        DBMS_OUTPUT.PUT_LINE('✗ ERROR: ' || SQLERRM);
        RAISE;
END RENOMBRAR_PARTICIONES;
/