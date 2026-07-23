CREATE OR REPLACE PROCEDURE PCP.MOVE_CREDITS_LOCAL AS
   v_start TIMESTAMP;
   v_end   TIMESTAMP;
   v_rows  NUMBER;
   v_diff  INTERVAL DAY TO SECOND;
   v_secs  NUMBER;
BEGIN
   v_start := SYSTIMESTAMP;

   -- 1. Poner la tabla destino en modo carga masiva
   EXECUTE IMMEDIATE 'ALTER TABLE CREDITS_NEW NOLOGGING';
   
   -- 2. Deshabilitar todos los índices y constraints FK
   FOR idx IN (SELECT index_name FROM user_indexes WHERE table_name = 'CREDITS_NEW') LOOP
      EXECUTE IMMEDIATE 'ALTER INDEX ' || idx.index_name || ' UNUSABLE';
   END LOOP;
   EXECUTE IMMEDIATE 'ALTER TABLE CREDITS_NEW MODIFY CONSTRAINT FK_DEBITS_IIII DISABLE';

   -- 3. Insert único con APPEND
   INSERT /*+ APPEND */ INTO CREDITS_NEW
   SELECT * FROM CREDITS
   WHERE ID_CREDITS >= 582760564;

   v_rows := SQL%ROWCOUNT;
   COMMIT;

   -- 4. Reconstruir índices globales únicamente (los locales se pueden omitir o hacer después)
   FOR idx IN (SELECT index_name FROM user_indexes 
               WHERE table_name = 'CREDITS_NEW' 
                 AND partitioned = 'NO' 
                 AND status = 'UNUSABLE') LOOP
      EXECUTE IMMEDIATE 'ALTER INDEX ' || idx.index_name || ' REBUILD NOLOGGING';
   END LOOP;
   
   -- Reconstruir índices locales solo si es imprescindible (puede omitirse temporalmente)
   -- FOR idx IN (SELECT index_name FROM user_indexes 
   --             WHERE table_name = 'CREDITS_NEW' 
   --               AND partitioned = 'YES' 
   --               AND status = 'UNUSABLE') LOOP
   --    EXECUTE IMMEDIATE 'ALTER INDEX ' || idx.index_name || ' REBUILD NOLOGGING';
   -- END LOOP;

   EXECUTE IMMEDIATE 'ALTER TABLE CREDITS_NEW MODIFY CONSTRAINT FK_DEBITS_IIII ENABLE NOVALIDATE';
   
   -- 5. Restaurar logging
   EXECUTE IMMEDIATE 'ALTER TABLE CREDITS_NEW LOGGING';
   COMMIT;

   v_end := SYSTIMESTAMP;
   v_diff := v_end - v_start;
   v_secs := EXTRACT(DAY    FROM v_diff) * 86400
           + EXTRACT(HOUR   FROM v_diff) * 3600
           + EXTRACT(MINUTE FROM v_diff) * 60
           + EXTRACT(SECOND FROM v_diff);
   
   DBMS_OUTPUT.PUT_LINE('Filas insertadas: ' || v_rows);
   DBMS_OUTPUT.PUT_LINE('Duración (segundos): ' || v_secs);
EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      EXECUTE IMMEDIATE 'ALTER TABLE CREDITS_NEW LOGGING';
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
      RAISE;
END MOVE_CREDITS_LOCAL;
/