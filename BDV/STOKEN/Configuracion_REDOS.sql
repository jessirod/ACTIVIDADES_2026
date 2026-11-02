alter system set log_archive_dest_1='LOCATION=USE_DB_RECOVERY_FILE_DEST valid_for=(ALL_LOGFILES,ALL_ROLES) MAX_FAILURE=1 REOPEN=5 DB_UNIQUE_NAME=STOKENP ALTERNATE=LOG_ARCHIVE_DEST_10';

alter system set log_archive_dest_10='location=+DATA_STOK valid_for=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME=STOKENP ALTERNATE=LOG_ARCHIVE_DEST_1';

alter system set log_archive_dest_state_1='ENABLE';
alter system set log_archive_dest_state_10='ALTERNATE';
alter system set db_create_online_log_dest_1='+REDO01_STOK';
alter system set db_create_online_log_dest_2='+REDO02_STOK';


******************************************************************************************************
AGREGAR_LOG_FILE
******************************************************************************************************

alter database add logfile thread 1 group 100 ('+REDO01_STOK','+REDO02_STOK') size 2048M; 

--alter database add logfile thread 1 group 101 ('+REDO01_STOK','+REDO02_STOK') size 2048M; 
--alter database add logfile thread 1 group 102 ('+REDO01_STOK','+REDO02_STOK') size 2048M; 
--alter database add logfile thread 1 group 103 ('+REDO01_STOK','+REDO02_STOK') size 2048M; 
--alter database add logfile thread 1 group 104 ('+REDO01_STOK','+REDO02_STOK') size 2048M;
--alter database add logfile thread 1 group 105 ('+REDO01_STOK','+REDO02_STOK') size 2048M;


alter database add logfile thread 2 group 200 ('+REDO01_STOK','+REDO02_STOK') size 2048M; 

--alter database add logfile thread 2 group 201 ('+REDO01_STOK','+REDO02_STOK') size 2048M; 
--alter database add logfile thread 2 group 202 ('+REDO01_STOK','+REDO02_STOK') size 2048M; 
--alter database add logfile thread 2 group 203 ('+REDO01_STOK','+REDO02_STOK') size 2048M; 
--alter database add logfile thread 2 group 204 ('+REDO01_STOK','+REDO02_STOK') size 2048M; 
--alter database add logfile thread 2 group 205 ('+REDO01_STOK','+REDO02_STOK') size 2048M; 


alter database add logfile thread 3 group 300 ('+REDO01_STOK','+REDO02_STOK') size 2048M; 

--alter database add logfile thread 3 group 301 ('+REDO01_STOK','+REDO02_STOK') size 2048M; 
--alter database add logfile thread 3 group 302 ('+REDO01_STOK','+REDO02_STOK') size 2048M; 
--alter database add logfile thread 3 group 303 ('+REDO01_STOK','+REDO02_STOK') size 2048M; 
--alter database add logfile thread 3 group 304 ('+REDO01_STOK','+REDO02_STOK') size 2048M; 
--alter database add logfile thread 3 group 305 ('+REDO01_STOK','+REDO02_STOK') size 2048M; 


******************************************************************************************************
CONSULTAR_REDOS_STATUS
******************************************************************************************************
set line 380
set pagesize 300
col redolog_file_name format a60
select a.group#
         ,a.thread#
         ,a.sequence#
         ,a.archived
         ,a.status
         ,b.member as redolog_file_name
         ,(a.bytes/1024/1024) as size_mb
 from v$log a
  join v$logfile b on a.group#=b.group#
order by a.group# asc;  

******************************************************************************************************

set line 380 PAGES 500
col redolog_file_name format a60
select 
  a.group#
  , a.thread#
  , a.sequence#
  , a.archived
  , a.status
  , b.member as redolog_file_name
  , (a.bytes/1024/1024) as size_mb 
from v$log a 
join v$logfile b 
on a.group#=b.group#
order by a.group# asc;



******************************************************************************************************
SWITCH_DE_REDOS
******************************************************************************************************

alter system switch logfile;
alter system checkpoint;

******************************************************************************************************
BORRAR_GRUPOS_DE_REDOS_VIEJOS --(CON ESTADO INACTIVO)
******************************************************************************************************
alter database drop logfile group 100;
alter database drop logfile group 101;
alter database drop logfile group 102;
alter database drop logfile group 103;

alter database drop logfile group 200;
alter database drop logfile group 201;
alter database drop logfile group 202;
alter database drop logfile group 203;


alter database drop logfile group 300;
alter database drop logfile group 301;
alter database drop logfile group 302;
alter database drop logfile group 303;
