CREATE OR REPLACE PROCEDURE PCPH.RENOMBRAR_PARTICIONES_HIST IS
    /*
    Propósito: Renombra automáticamente las particiones con nombres genéricos (SYS_Pxxxx)
    de las tablas especificadas en el esquema PCPH.
    
    Tablas procesadas:
      - CREDITS_HIST (fecha mensual por PROCESS_DATE)
      - CREDITS_CREDITO_INMEDIATO_HIST (fecha mensual por FECHA_REGISTRO)
      - ORDEN_DETAIL_HIST (numérico por ID_ORDEN - intervalo 1,000,000)
      - ORDEN_HIST (fecha mensual por DATE_VALUE)
      - DEBITS_HIST (fecha mensual por PROCESS_DATE)
      - TRACK_ORDEN_HIST (numérico por ID_TRACK_ORDEN - intervalo 100,000)
      - DATOS_MOVIMIENTOS_HIST (fecha mensual por FECHA_REGISTRO)
      - LOGS_RESP_PROC_PCPH1_HIST (fecha mensual por FECHA_REGISTRO)
      - TORDEN_HIST (fecha mensual por DATE_VALUE)             -- NUEVA
      - TORDEN_ALTA_HIST (fecha mensual por RECORD_ENTRY_DATE) -- NUEVA
      - TORDEN_DETAIL_HIST (numérico por ID_TDETAIL)           -- NUEVA
      - TORDEN_DETAIL_ALTA_HIST (numérico por ID_TDETAIL)      -- NUEVA
      - TRACK_LOTE_HIST (numérico por ID_TRACK)                -- NUEVA
    */
    
    TYPE t_tables IS TABLE OF VARCHAR2(35);
    v_tables t_tables := t_tables('CREDITS_HIST',
                                   'CREDITS_CREDITO_INMEDIATO_HIST',
                                   'ORDEN_DETAIL_HIST',
                                   'ORDEN_HIST',
                                   'DEBITS_HIST',
                                   'TRACK_ORDEN_HIST',
                                   'DATOS_MOVIMIENTOS_HIST',
                                   'LOGS_RESP_PROC_PCPH1_HIST',
                                   -- Nuevas tablas históricas
                                   'TORDEN_HIST',
                                   'TORDEN_ALTA_HIST',
                                   'TORDEN_DETAIL_HIST',
                                   'TORDEN_DETAIL_ALTA_HIST',
                                   'TRACK_LOTE_HIST');
    
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
    
    -- Función para extraer fecha del HIGH_VALUE
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

                    -- Si tiene formato TIMESTAMP con hora y zona, intentamos quitar la zona
                    IF v_tipo = 'TIMESTAMP' THEN
                        -- Intentar extraer 'YYYY-MM-DD HH24:MI:SS' de un TIMESTAMP
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
    
    -- Función para extraer valor numérico del HIGH_VALUE
    FUNCTION extraer_numero_from_high_value(p_high_value VARCHAR2) RETURN NUMBER IS
        v_num_str VARCHAR2(100);
        v_pos NUMBER;
        v_num NUMBER;
    BEGIN
        IF p_high_value IS NULL THEN
            RETURN NULL;
        END IF;
        
        v_num_str := TRIM(p_high_value);
        
        -- 1) Si es TO_NUMBER('123456') o TO_NUMBER(123456)
        v_pos := INSTR(UPPER(v_num_str), 'TO_NUMBER');
        IF v_pos > 0 THEN
            -- Buscar el primer número dentro de TO_NUMBER
            v_num_str := REGEXP_SUBSTR(v_num_str, '[0-9]+');
            IF v_num_str IS NOT NULL THEN
                RETURN TO_NUMBER(v_num_str);
            END IF;
        END IF;
        
        -- 2) Si es número directo (puede tener comillas o no)
        -- Elimina todo excepto dígitos y signo menos
        v_num_str := REGEXP_REPLACE(v_num_str, '[^0-9\-]', '');
        IF v_num_str IS NOT NULL AND v_num_str NOT IN ('-', '') THEN
            RETURN TO_NUMBER(v_num_str);
        END IF;
        
        -- 3) Fallback: buscar cualquier número en la cadena
        v_num_str := REGEXP_SUBSTR(p_high_value, '[0-9]+');
        IF v_num_str IS NOT NULL THEN
            RETURN TO_NUMBER(v_num_str);
        END IF;
        
        RETURN NULL;
    EXCEPTION
        WHEN OTHERS THEN
            RETURN NULL;
    END extraer_numero_from_high_value;
    
    -- Función para determinar si la partición es por fecha o numérica según la tabla
    FUNCTION es_tabla_fecha(p_table_name VARCHAR2) RETURN BOOLEAN IS
    BEGIN
        -- Tablas particionadas por FECHA
        IF p_table_name IN ('CREDITS_HIST', 
                            'CREDITS_CREDITO_INMEDIATO_HIST',
                            'ORDEN_HIST', 
                            'DEBITS_HIST',
                            'DATOS_MOVIMIENTOS_HIST',
                            'LOGS_RESP_PROC_PCPH1_HIST',
                            -- Nuevas tablas por fecha
                            'TORDEN_HIST',
                            'TORDEN_ALTA_HIST') THEN
            RETURN TRUE;
        -- Tablas particionadas por NÚMERO
        ELSIF p_table_name IN ('ORDEN_DETAIL_HIST', 
                               'TRACK_ORDEN_HIST',
                               -- Nuevas tablas por número
                               'TORDEN_DETAIL_HIST',
                               'TORDEN_DETAIL_ALTA_HIST',
                               'TRACK_LOTE_HIST') THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE; -- Por defecto asumir fecha
        END IF;
    END es_tabla_fecha;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== INICIANDO RENOMBRADO DE PARTICIONES (PCPH) ===');
    DBMS_OUTPUT.PUT_LINE('Fecha/Hora: ' || TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('Esquema: PCPH');
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
                -- Obtener HIGH_VALUE
                v_high_value := get_high_value(v_tables(i), part.PARTITION_NAME);
                
                IF es_tabla_fecha(v_tables(i)) THEN
                    -- Tabla por FECHA: extraer fecha y formatear como YYYYMM
                    v_fecha := extraer_fecha_from_high_value(v_high_value);
                    
                    IF v_fecha IS NOT NULL THEN
                        v_nuevo_nombre := v_tables(i) || '_' || TO_CHAR(v_fecha, 'YYYYMM');
                    ELSE
                        -- Fallback: usar posición
                        v_nuevo_nombre := v_tables(i) || '_' || part.PARTITION_POSITION;
                    END IF;
                ELSE
                    -- Tabla por NÚMERO: extraer valor numérico
                    v_valor_numerico := extraer_numero_from_high_value(v_high_value);
                    
                    IF v_valor_numerico IS NOT NULL THEN
                        -- Para ORDEN_DETAIL_HIST: intervalo 1,000,000
                        IF v_tables(i) = 'ORDEN_DETAIL_HIST' THEN
                            v_nuevo_nombre := v_tables(i) || '_' || TO_CHAR(v_valor_numerico - 1000000);
                        -- Para TRACK_ORDEN_HIST: intervalo 100,000
                        ELSIF v_tables(i) = 'TRACK_ORDEN_HIST' THEN
                            v_nuevo_nombre := v_tables(i) || '_' || TO_CHAR(v_valor_numerico - 100000);
                        ELSE
                            -- Para nuevas tablas numéricas, usar el valor directamente
                            v_nuevo_nombre := v_tables(i) || '_' || TO_CHAR(v_valor_numerico);
                        END IF;
                    ELSE
                        -- Fallback: usar posición
                        v_nuevo_nombre := v_tables(i) || '_' || part.PARTITION_POSITION;
                    END IF;
                END IF;
                
                -- Renombrar partición
                IF part.PARTITION_NAME != v_nuevo_nombre THEN
                    EXECUTE IMMEDIATE 'ALTER TABLE PCPH.' || v_tables(i) || 
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
END RENOMBRAR_PARTICIONES_HIST;
/