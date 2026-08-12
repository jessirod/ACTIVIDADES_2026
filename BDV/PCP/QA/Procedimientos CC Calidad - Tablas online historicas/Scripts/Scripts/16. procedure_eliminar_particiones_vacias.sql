CREATE OR REPLACE PROCEDURE PCP.ELIMINAR_PARTICIONES_VACIAS IS
    TYPE t_tables IS TABLE OF VARCHAR2(30);
    v_tables t_tables := t_tables('CREDITS', 'CREDITS_CREDITO_INMEDIATO', 'ORDEN_DETAIL', 
                                   'ORDEN', 'DEBITS', 'TRACK_ORDEN', 'LOGS_RESP_PROC_PCP1', 'DATOS_MOVIMIENTOS');
    
    TYPE t_initial_partitions IS TABLE OF VARCHAR2(30);
    v_initial_partitions t_initial_partitions := t_initial_partitions('CREDITS_INICIAL', 'CREDITO_INMEDIATO_inicial', 
                                                                        'ORDEN_DETAIL_inicial', 'ORDEN_inicial', 
                                                                        'DEBITS_inicial', 'TRACK_ORDEN_inicial', 
                                                                        'LOGS_RESP_PROC_PCP1', 'DATOS_MOVIMIENTOS');

    v_sql VARCHAR2(1000);
    v_num_rows NUMBER;
BEGIN
    FOR i IN 1..v_tables.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('--- Procesando tabla: ' || v_tables(i) || ' ---');
        
        FOR part IN (SELECT PARTITION_NAME FROM USER_TAB_PARTITIONS 
                     WHERE TABLE_NAME = v_tables(i) 
                     AND PARTITION_NAME != v_initial_partitions(i) 
                     AND PARTITION_NAME NOT LIKE '%INICIAL%' 
                     ORDER BY PARTITION_POSITION) LOOP
            
            -- Verificar si est  vac a
            v_sql := 'SELECT COUNT(1) FROM PCP.' || v_tables(i) || ' PARTITION (' || part.PARTITION_NAME || ')';
            EXECUTE IMMEDIATE v_sql INTO v_num_rows;
            
            IF v_num_rows = 0 THEN
                DBMS_OUTPUT.PUT_LINE('Eliminando: ' || part.PARTITION_NAME);
                
                -- DROP con actualizaci n de globales
                EXECUTE IMMEDIATE 'ALTER TABLE PCP.' || v_tables(i) || ' DROP PARTITION ' || part.PARTITION_NAME || ' UPDATE GLOBAL INDEXES';
                
                -- BLOQUE DE REPARACI N AUTOM TICA (REBUILD)
                -- Escanea  ndices locales y globales que hayan quedado en estado UNUSABLE
                FOR idx IN (SELECT index_name, partitioned 
                            FROM user_indexes 
                            WHERE table_name = v_tables(i) 
                            AND status = 'UNUSABLE') LOOP
                    
                    DBMS_OUTPUT.PUT_LINE('Reparando  ndice: ' || idx.index_name);
                    
                    IF idx.partitioned = 'YES' THEN
                        -- Para  ndices particionados (locales), rebuild de la partici n espec fica
                        FOR part_idx IN (SELECT partition_name FROM user_ind_partitions 
                                         WHERE index_name = idx.index_name AND status = 'UNUSABLE') LOOP
                            EXECUTE IMMEDIATE 'ALTER INDEX ' || idx.index_name || ' REBUILD PARTITION ' || part_idx.partition_name;
                        END LOOP;
                    ELSE
                        -- Para  ndices globales (no particionados)
                        EXECUTE IMMEDIATE 'ALTER INDEX ' || idx.index_name || ' REBUILD';
                    END IF;
                END LOOP;
            END IF;
        END LOOP;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('=== PROCESO COMPLETADO Y CELDAS DE  NDICES REPARADAS ===');
END ELIMINAR_PARTICIONES_VACIAS;
/
