KERUX

• Parametros de statistick level

show parameter statistics_level

• Tabla de switcheos de redo

col h0 format 9999
col h1 format 9999
col h2 format 9999
col h3 format 9999
col h4 format 9999
col h5 format 9999
col h6 format 9999
col h7 format 9999
col h8 format 9999
col h9 format 9999
col h10 format 9999
col h11 format 9999
col h12 format 9999
col h13 format 9999
col h14 format 9999
col h15 format 9999
col h16 format 9999
col h17 format 9999
col h18 format 9999
col h19 format 9999
col h20 format 9999
col h21 format 9999
col h22 format 9999
col h23 format 9999
col DAY format a12
set lin 380
set pagesize 100
alter session set nls_date_format='dd-mm-rr';


select * from (
SELECT TRUNC (first_time) "Date", TO_CHAR  (first_time , 'Dy') "Day",
COUNT (1) "Total",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '00', 1, 0)) "h0",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '01', 1, 0)) "h1",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '02', 1, 0)) "h2",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '03', 1, 0)) "h3",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '04', 1, 0)) "h4",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '05', 1, 0)) "h5",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '06', 1, 0)) "h6",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '07', 1, 0)) "h7",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '08', 1, 0)) "h8",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '09', 1, 0)) "h9",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '10', 1, 0)) "h10",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '11', 1, 0)) "h11",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '12', 1, 0)) "h12",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '13', 1, 0)) "h13",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '14', 1, 0)) "h14",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '15', 1, 0)) "h15",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '16', 1, 0)) "h16",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '17', 1, 0)) "h17",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '18', 1, 0)) "h18",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '19', 1, 0)) "h19",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '20', 1, 0)) "h20",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '21', 1, 0)) "h21",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '22', 1, 0)) "h22",
SUM (DECODE (TO_CHAR (first_time, 'hh24'), '23', 1, 0)) "h23"
FROM V$log_history
where thread#=nvl('&1',thread#)
GROUP BY TRUNC (first_time), TO_CHAR (first_time, 'Dy')
ORDER BY 1 desc
)
where rownum<=50;

• Parametros configurados del dataguard

PARAMETROS DE DATAGUARD

show parameter standby_file_management
show parameter log_archive_config
show parameter log_archive_dest_2
show parameter log_archive_dest_state_2
show parameter db_file_name_convert
show parameter log_file_name_convert
show parameter log_archive_max_processes
show parameter fal_server
show parameter fal_client
show parameter db_create_online_log_dest_1
show parameter db_create_online_log_dest_2

col member format a80
select * from v$logfile;

• Configuracion del dgbroker
PARAMETROS DE DGBROKER

show parameter DG_BROKER_CONFIG_FILE1
show parameter DG_BROKER_CONFIG_FILE2
show parameter DG_BROKER_START

dgmgrl / as sysdba
show configuration verbose;
show database verbose <db_unique_name>;
validate database verbose <db_unique_name>;



• Evidencias de comoe estan las rutas de oracle para los trace

• Tamaño del alertog

• Parametros de la resource limit

col RESOURCE_NAME format a40
select * from v$resource_limit;


• Conteo de objetos de aplicaciones que tienen owners administrativos


DB_NAME: KERUX
SNAP: 153068-153069

-- Ejecutar sqltuning y ASH

88ca6bcyuq9u9
5g1stt5djns5r
a3jhjn8gnfqz4
csrytu9tsrar1
7a4nvt7583q49
555kx5k1784af
9f6kjyd25ax45

SNAP: 153091-153092

1u3rhcnsuh7r8
acz6v08rwm7v8
g8u3j6mugvqm1
b3vbmg2tjmxyz

SNAP: 153110-153111


2589n219txwuh
gb349dqubucyw


SNAP: 153087-153088

4z9yww8nxwbs6
acz6v08rwm7v8
gn3fhkm1h8tzt

SNAP: 153088-153089

g8d895vwsswju
3xjy3g1c71p7f
csrytu9tsrar1


DECLARE
l_sql_tune_task_id VARCHAR2(100);
BEGIN
l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
begin_snap => 153068, 
end_snap => 153069,
sql_id => 'a3jhjn8gnfqz4',
scope => DBMS_SQLTUNE.scope_comprehensive,
time_limit => 20000,
task_name => 'a3jhjn8gnfqz4_tuning_task01',
description => 'Tuning task1 for statement a3jhjn8gnfqz4');
DBMS_OUTPUT.put_line('l_sql_tune_task_id: ' || l_sql_tune_task_id);
END;
/


2. EJECUTAR EL TUNING TASK

EXEC DBMS_SQLTUNE.execute_tuning_task(task_name => 'a3jhjn8gnfqz4_tuning_task01');


3. OBTENER EL REPORTE DEL TUNING ADVISOR

set long 65536
set longchunksize 65536
set linesize 240
set pagesize 500
select dbms_sqltune.report_tuning_task('a3jhjn8gnfqz4_tuning_task01') from dual;



sqlplus / as sysdba

SQL> @$ORACLE_HOME/rdbms/admin/ashrpt.sql
