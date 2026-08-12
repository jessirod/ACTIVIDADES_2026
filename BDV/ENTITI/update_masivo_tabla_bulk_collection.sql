SET SERVEROUTPUT ON 
DECLARE

----* Collection para rowids
TYPE t_rowid_tab IS TABLE OF ROWID INDEX BY PLS_INTEGER;
m_tmp t_rowid_tab;

----* Variables de parametros
v_rvauan VARCHAR2(10) := '2026';
v_rvaues VARCHAR2(1)  := 'A';
v_rvoff  VARCHAR2(1)  := 'S';
v_owner VARCHAR2(30)  := 'EICDATOSBASE';
v_table_name VARCHAR2(30) := 'E2CPSOAUF';
-- v_limit PLS_INTEGER   := 10000;
v_limit PLS_INTEGER   := 10;

----* Variables de control
v_total_updated PLS_INTEGER := 0;
v_batch_count   PLS_INTEGER := 0;
v_start_time    TIMESTAMP   := SYSTIMESTAMP;
v_total_records PLS_INTEGER := 0;
v_elapsed       INTERVAL DAY TO SECOND;
v_start_total_time NUMBER := DBMS_UTILITY.get_time;
v_end_total_time   NUMBER;
----* Cursor para obtener rowids a actualizar
CURSOR cur_rowid IS
SELECT rowid
FROM EICDATOSBASE.E2CPSOAUF
WHERE RVAUES = v_rvaues AND RVOFF = v_rvoff;

BEGIN


  SELECT COUNT(1)
  INTO v_total_records
  FROM EICDATOSBASE.E2CPSOAUF
  WHERE RVAUES = v_rvaues 
  AND RVOFF = v_rvoff;

  DBMS_OUTPUT.PUT_LINE('');
  DBMS_OUTPUT.PUT_LINE('');
  DBMS_OUTPUT.PUT_LINE('===========================================');
  DBMS_OUTPUT.PUT_LINE('INICIO DE UPDATE MASIVO');
  DBMS_OUTPUT.PUT_LINE('===========================================');
  DBMS_OUTPUT.PUT_LINE(RPAD('Tabla: ',20)||v_owner||'.'||v_table_name);
  DBMS_OUTPUT.PUT_LINE(RPAD('Nueva fecha RVAUAN: ',20)||v_rvauan);
  DBMS_OUTPUT.PUT_LINE(RPAD('Condiciones: ',20)||'RVAUES=' || v_rvaues || ', RVOFF=' || v_rvoff);
  DBMS_OUTPUT.PUT_LINE(RPAD('Total de registros: ',20)||v_total_records);
  DBMS_OUTPUT.PUT_LINE(RPAD('Batch size limit: ',20)||v_limit);
  DBMS_OUTPUT.PUT_LINE(RPAD('Lotes estimados: ',20)||CEIL(v_total_records / v_limit));
  DBMS_OUTPUT.PUT_LINE(RPAD('Hora inicio: ',20)||TO_CHAR(v_start_time, 'DD/MM/YYYY HH24:MI:SS'));
  DBMS_OUTPUT.PUT_LINE('===========================================');
  DBMS_OUTPUT.PUT_LINE('');

  OPEN cur_rowid;
  LOOP
     ----* Limpiar colllection
    m_tmp.DELETE;
    FETCH cur_rowid BULK COLLECT INTO m_tmp LIMIT v_limit;

    EXIT WHEN m_tmp.COUNT = 0;

    FORALL i IN 1 .. m_tmp.COUNT
      UPDATE EICDATOSBASE.E2CPSOAUF
      SET RVAUAN = v_rvauan
      WHERE rowid = m_tmp(i);

    ----* Actualizar contadores
    v_batch_count   := v_batch_count + 1;
    v_total_updated := v_total_updated + SQL%ROWCOUNT;

    v_elapsed := SYSTIMESTAMP - v_start_time;
    
    ----* COMMIT después de cada lote
    COMMIT;

    ----* Ver lotes procesados
    DBMS_OUTPUT.PUT_LINE(
      'Lote #' || LPAD(v_batch_count, 5, '0') || 
      ' | Total acumulado: ' || LPAD(v_total_updated, 10) ||
      ' | Tiempo: ' || EXTRACT(MINUTE FROM v_elapsed) || 'm ' || 
        ROUND(EXTRACT(SECOND FROM v_elapsed)) || 's'
    );

  END LOOP;
  CLOSE cur_rowid;

  v_end_total_time := DBMS_UTILITY.get_time;
  DBMS_OUTPUT.PUT_LINE('');
  DBMS_OUTPUT.PUT_LINE('===========================================');
  DBMS_OUTPUT.PUT_LINE('PROCESO COMPLETADO');
  DBMS_OUTPUT.PUT_LINE('===========================================');
  DBMS_OUTPUT.PUT_LINE(RPAD('Total actualizados: ',20)||v_total_updated);
  DBMS_OUTPUT.PUT_LINE(RPAD('Lotes procesados: ',20)||v_batch_count);
  DBMS_OUTPUT.PUT_LINE(RPAD('Tiempo total: ',20)|| (v_end_total_time - v_start_total_time) || ' segundos'
  );

  EXCEPTION 
    WHEN OTHERS THEN
      IF cur_rowid%ISOPEN THEN
        CLOSE cur_rowid;
      END IF;

      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
      DBMS_OUTPUT.PUT_LINE('Registros procesados antes del error: ' || v_total_updated);
      RAISE;

END;
/