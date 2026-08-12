SET LINESIZE 200 PAGESIZE 500 TRIMSPOOL ON FEEDBACK OFF VERIFY OFF SERVEROUTPUT ON SIZE 1000000
WHENEVER SQLERROR CONTINUE
ALTER SESSION SET NLS_DATE_FORMAT='DD-MON-YYYY HH24:MI:SS';

COLUMN spoolname NEW_VALUE v_spool NOPRINT
SELECT 'dg_collect_'||instance_name||'_'||TO_CHAR(SYSDATE,'YYYYMMDD_HH24MI')||'.txt' spoolname
FROM v$instance;
SPOOL &v_spool

PROMPT ============================================================================
PROMPT  1. INSTANCIA, VERSION Y ROL
PROMPT ============================================================================
COLUMN host_name FORMAT A25
COLUMN instance_name FORMAT A12
COLUMN version FORMAT A12
SELECT instance_name, host_name, version, status, startup_time FROM v$instance;

COLUMN name FORMAT A12
COLUMN database_role FORMAT A18
COLUMN protection_mode FORMAT A22
COLUMN protection_level FORMAT A22
COLUMN open_mode FORMAT A20
COLUMN force_logging FORMAT A6
SELECT name, database_role, protection_mode, protection_level, open_mode, force_logging
FROM v$database;

DECLARE
  c SYS_REFCURSOR; v1 VARCHAR2(60); v2 VARCHAR2(60);
BEGIN
  BEGIN
    OPEN c FOR 'SELECT flashback_on, switchover_status FROM v$database';
    FETCH c INTO v1, v2; CLOSE c;
    DBMS_OUTPUT.PUT_LINE('FLASHBACK_ON      : '||v1);
    DBMS_OUTPUT.PUT_LINE('SWITCHOVER_STATUS : '||v2);
  EXCEPTION WHEN OTHERS THEN
    BEGIN
      OPEN c FOR 'SELECT switchover_status FROM v$database';
      FETCH c INTO v2; CLOSE c;
      DBMS_OUTPUT.PUT_LINE('FLASHBACK_ON      : N/A (9i)');
      DBMS_OUTPUT.PUT_LINE('SWITCHOVER_STATUS : '||v2);
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('SWITCHOVER_STATUS : no disponible');
    END;
  END;
END;
/

DECLARE
  c SYS_REFCURSOR; v VARCHAR2(10);
BEGIN
  OPEN c FOR 'SELECT cdb FROM v$database';
  FETCH c INTO v; CLOSE c;
  DBMS_OUTPUT.PUT_LINE('CDB (multitenant) : '||v);
EXCEPTION WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('CDB (multitenant) : N/A (< 12c)');
END;
/

PROMPT
PROMPT ============================================================================
PROMPT  2. PARAMETROS DE DATA GUARD
PROMPT ============================================================================
COLUMN pname FORMAT A32
COLUMN pvalue FORMAT A130 WORD_WRAPPED
SELECT name pname, value pvalue
FROM v$parameter
WHERE name IN ('dg_broker_start','dg_broker_config_file1','dg_broker_config_file2',
               'log_archive_config','log_archive_max_processes','archive_lag_target',
               'fal_server','fal_client','standby_file_management','db_unique_name',
               'db_file_name_convert','log_file_name_convert','remote_login_passwordfile',
               'log_archive_min_succeed_dest')
   OR (name LIKE 'log_archive_dest__' AND value IS NOT NULL)
   OR name LIKE 'log_archive_dest_state__'
ORDER BY name;

PROMPT
PROMPT ============================================================================
PROMPT  3. DESTINOS DE ARCHIVADO Y ERRORES DE TRANSPORTE
PROMPT ============================================================================
COLUMN dest_name FORMAT A20
COLUMN destination FORMAT A30
COLUMN error FORMAT A50
SELECT dest_id, dest_name, status, type, database_mode, recovery_mode, error
FROM v$archive_dest_status
WHERE status <> 'INACTIVE';

SELECT dest_id, status, target, archiver, transmit_mode, affirm, error
FROM v$archive_dest
WHERE status <> 'INACTIVE' AND dest_id > 1;

PROMPT
PROMPT ============================================================================
PROMPT  4. SECUENCIAS: ARCHIVADAS Y APLICADAS (por thread)
PROMPT ============================================================================
PROMPT --- Ultima secuencia archivada:
SELECT thread#, MAX(sequence#) ultima_archivada
FROM v$archived_log
WHERE resetlogs_change# = (SELECT resetlogs_change# FROM v$database)
GROUP BY thread# ORDER BY thread#;

PROMPT --- Ultima secuencia con APPLIED='YES':
SELECT thread#, MAX(sequence#) ultima_aplicada
FROM v$archived_log
WHERE applied = 'YES'
  AND resetlogs_change# = (SELECT resetlogs_change# FROM v$database)
GROUP BY thread# ORDER BY thread#;

PROMPT --- Secuencia actual del redo online:
SELECT thread#, sequence# secuencia_actual FROM v$log WHERE status = 'CURRENT';

PROMPT --- v$archive_gap:
SELECT * FROM v$archive_gap;

PROMPT
PROMPT ============================================================================
PROMPT  5. PROCESOS DE TRANSPORTE Y APLICACION
PROMPT ============================================================================
PROMPT --- v$managed_standby:
COLUMN process FORMAT A9
COLUMN client_process FORMAT A10
SELECT process, status, client_process, thread#, sequence#, block#
FROM v$managed_standby
ORDER BY process, thread#;

PROMPT --- v$dataguard_process (solo 12.2+):
DECLARE
  c SYS_REFCURSOR;
  v_name VARCHAR2(30); v_role VARCHAR2(64); v_action VARCHAR2(64); v_info VARCHAR2(200);
  n NUMBER := 0;
BEGIN
  OPEN c FOR 'SELECT name, role, action, info FROM v$dataguard_process ORDER BY role';
  LOOP
    FETCH c INTO v_name, v_role, v_action, v_info;
    EXIT WHEN c%NOTFOUND;
    n := n + 1;
    DBMS_OUTPUT.PUT_LINE(RPAD(v_name,8)||RPAD(v_role,28)||RPAD(v_action,15)||NVL(v_info,''));
  END LOOP;
  CLOSE c;
  IF n = 0 THEN DBMS_OUTPUT.PUT_LINE('(sin filas)'); END IF;
EXCEPTION WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('N/A (version < 12.2)');
END;
/

PROMPT
PROMPT ============================================================================
PROMPT  6. LAG DE TRANSPORTE Y APLICACION (v$dataguard_stats, 10g+)
PROMPT ============================================================================
DECLARE
  c SYS_REFCURSOR;
  v_name VARCHAR2(64); v_val VARCHAR2(64); v_unit VARCHAR2(64); v_time VARCHAR2(64);
  n NUMBER := 0;
BEGIN
  OPEN c FOR 'SELECT name, NVL(value,''(null)''), NVL(unit,''''), TO_CHAR(time_computed) FROM v$dataguard_stats';
  LOOP
    FETCH c INTO v_name, v_val, v_unit, v_time;
    EXIT WHEN c%NOTFOUND;
    n := n + 1;
    DBMS_OUTPUT.PUT_LINE(RPAD(v_name,28)||RPAD(v_val,22)||RPAD(v_unit,32)||v_time);
  END LOOP;
  CLOSE c;
  IF n = 0 THEN DBMS_OUTPUT.PUT_LINE('(sin filas)'); END IF;
EXCEPTION WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE('N/A (9i)');
END;
/

PROMPT
PROMPT ============================================================================
PROMPT  7. ONLINE REDO LOGS Y STANDBY REDO LOGS
PROMPT ============================================================================
PROMPT --- Online redo logs:
SELECT thread#, group#, bytes/1024/1024 mb, members, status
FROM v$log ORDER BY thread#, group#;

PROMPT --- Standby redo logs:
SELECT thread#, group#, bytes/1024/1024 mb, status, used
FROM v$standby_log ORDER BY thread#, group#;

PROMPT
PROMPT ============================================================================
PROMPT  8. SWITCHES DE REDO POR HORA (ultimas 48h)
PROMPT ============================================================================
SELECT TO_CHAR(first_time,'DD-MON HH24')||':00' hora, COUNT(*) switches
FROM v$log_history
WHERE first_time > SYSDATE - 2
GROUP BY TO_CHAR(first_time,'DD-MON HH24')
ORDER BY 1;

PROMPT
PROMPT ============================================================================
PROMPT  9. MENSAJES DE DATA GUARD ULTIMOS 3 DIAS (v$dataguard_status)
PROMPT ============================================================================
COLUMN message FORMAT A120 WORD_WRAPPED
SELECT timestamp, severity, error_code, message
FROM v$dataguard_status
WHERE timestamp > SYSDATE - 3
ORDER BY timestamp;

SPOOL OFF
PROMPT
PROMPT Recoleccion finalizada. Archivo generado: &v_spool
SET FEEDBACK ON VERIFY ON
