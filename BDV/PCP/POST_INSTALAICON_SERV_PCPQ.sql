--POST_INSTALACIÓN_PCPQ

******************************************************************************************************
REVISAR_DISCOS_DISKGROUPS
******************************************************************************************************
SET LINESIZE 1000
col PATH for a40
col DG_NAME for a20
col DG_STATE for a10
col FAILGROUP for a30
COL STATE FORMAT A10
SELECT dg.name dg_name, dg.state dg_state, dg.type, d.disk_number dsk_no,
d.path, d.mount_status, d.FAILGROUP, d.state 
FROM v$asm_diskgroup dg, v$asm_disk d
WHERE dg.group_number=d.group_number
--AND dg.name LIKE '%%'
ORDER BY dg_name, dsk_no;


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
AGREGAR_LOG_FILE
******************************************************************************************************


alter database add logfile thread 1 group 101 ('+REDO01_PCP','+REDO02_PCP') size 2048M; 
alter database add logfile thread 1 group 102 ('+REDO01_PCP','+REDO02_PCP') size 2048M; 
alter database add logfile thread 1 group 103 ('+REDO01_PCP','+REDO02_PCP') size 2048M; 


alter database add logfile thread 2 group 201 ('+REDO01_PCP','+REDO02_PCP') size 2048M; 
alter database add logfile thread 2 group 202 ('+REDO01_PCP','+REDO02_PCP') size 2048M; 
alter database add logfile thread 2 group 203 ('+REDO01_PCP','+REDO02_PCP') size 2048M; 

--
--
--alter database add logfile thread 3 group 301 ('+REDO01_RENTA','+REDO02_RENTA') size 2048M; 
--alter database add logfile thread 3 group 302 ('+REDO01_RENTA','+REDO02_RENTA') size 2048M; 
--alter database add logfile thread 3 group 303 ('+REDO01_RENTA','+REDO02_RENTA') size 2048M; 
--alter database add logfile thread 3 group 304 ('+REDO01_RENTA','+REDO02_RENTA') size 2048M; 

**CUANDO ES SINGLE SOLO SE AGREGA UN thread.

******************************************************************************************************
SWITCH_DE_REDOS
******************************************************************************************************

alter system switch logfile;
alter system checkpoint;

******************************************************************************************************
BORRAR_GRUPOS_DE_REDOS_VIEJOS --(CON ESTADO INACTIVO)
******************************************************************************************************
alter database drop logfile group 1;
--alter database drop logfile group 2;
alter database drop logfile group 3;
--alter database drop logfile group 4;


******************************************************************************************************
MODIFICAR_ARCHIVE_LOG_LIST
******************************************************************************************************

--alter system set log_archive_dest_1='LOCATION=USE_DB_RECOVERY_FILE_DEST valid_for=(ALL_LOGFILES,ALL_ROLES) MAX_FAILURE=1 REOPEN=5 DB_UNIQUE_NAME=PCPQ ALTERNATE=LOG_ARCHIVE_DEST_10';
--
--alter system set log_archive_dest_10='location=+DATA_PCP valid_for=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME=PCPQ ALTERNATE=LOG_ARCHIVE_DEST_1';
--
--alter system set log_archive_dest_state_1='ENABLE';
--alter system set log_archive_dest_state_10='ALTERNATE';
--alter system set db_create_online_log_dest_1='+REDO01_PCP';
--alter system set db_create_online_log_dest_2='+REDO02_PCP';
--



alter system set log_archive_dest_1='LOCATION=USE_DB_RECOVERY_FILE_DEST valid_for=(ALL_LOGFILES,ALL_ROLES) MAX_FAILURE=1 REOPEN=5 DB_UNIQUE_NAME=DOMICQ ALTERNATE=LOG_ARCHIVE_DEST_10';

alter system set log_archive_dest_10='location=+DATA_DOMIC valid_for=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME=DOMICQ ALTERNATE=LOG_ARCHIVE_DEST_1';

alter system set log_archive_dest_state_1='ENABLE';
alter system set log_archive_dest_state_10='ALTERNATE';
alter system set db_create_online_log_dest_1='+REDO01_DOMIC';
alter system set db_create_online_log_dest_2='+REDO02_DOMIC';





alter system set log_archive_dest_1='LOCATION=USE_DB_RECOVERY_FILE_DEST valid_for=(ALL_LOGFILES,ALL_ROLES) MAX_FAILURE=1 REOPEN=5 DB_UNIQUE_NAME=DOMICHQ ALTERNATE=LOG_ARCHIVE_DEST_10';

alter system set log_archive_dest_10='location=+DATA_DOMICH valid_for=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME=DOMICHQ ALTERNATE=LOG_ARCHIVE_DEST_1';

alter system set log_archive_dest_state_1='ENABLE';
alter system set log_archive_dest_state_10='ALTERNATE';
alter system set db_create_online_log_dest_1='+REDO01_DOMICH';
alter system set db_create_online_log_dest_2='+REDO02_DOMICH';





******************************************************************************************************
REVISAR_PARAMETRO_REDOS
******************************************************************************************************
show parameter LOG

******************************************************************************************************
CONFIGURAR_PARAMETROS_AWR
******************************************************************************************************

Retención:
execute dbms_workload_repository.modify_snapshot_settings (interval => 15,retention => 11520);

Statistics level:
ALTER SYSTEM SET statistics_level=all;


******************************************************************************************************
CONFIGURAR_FAST_START_MTTR_TARGET
******************************************************************************************************

show parameter fast_start_mttr_target;

alter system set fast_start_mttr_target=300 Comment='Recomendation AHF' scope=both;

******************************************************************************************************
ESTABLECER_DB_BLOCK_CHECKING_DB_LOST_WRITE_PROTECT
******************************************************************************************************

alter system set db_block_checking=MEDIUM Comment='Recomendation AHF';
alter system set db_lost_write_protect=TYPICAL Comment='Recomendation AHF';

show parameter DB_BLOCK_CHECKING;
show parameter DB_LOST_WRITE_PROTECT;


******************************************************************************************************
MODIFICAR_PROMPT_SQLPLUS
******************************************************************************************************
cp -p $ORACLE_HOME/sqlplus/admin/glogin.sql $ORACLE_HOME/sqlplus/admin/glogin.sql.original

cat <<EOT >>$ORACLE_HOME/sqlplus/admin/glogin.sql 

SET TIMI ON
SET TIME ON
SET LINE 240
SET SQLPROMPT '&_USER.@&_CONNECT_IDENTIFIER.> '
EOT


******************************************************************************************************
VERIFICAR_MODIFICAR_PARAMETROS_RMAN
******************************************************************************************************

rman target /
rman> show all;

Los parámetros deben ser similares a los siguientes:

CONFIGURE RETENTION POLICY TO REDUNDANCY 1; # default 
CONFIGURE BACKUP OPTIMIZATION OFF; # default 
CONFIGURE DEFAULT DEVICE TYPE TO DISK; # default 
CONFIGURE CONTROLFILE AUTOBACKUP ON;
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '%F'; # default 
CONFIGURE DEVICE TYPE DISK PARALLELISM 1 BACKUP TYPE TO BACKUPSET; # default 
CONFIGURE DATAFILE BACKUP COPIES FOR DEVICE TYPE DISK TO 1; # default 
CONFIGURE ARCHIVELOG BACKUP COPIES FOR DEVICE TYPE DISK TO 1; # default 
CONFIGURE MAXSETSIZE TO UNLIMITED; # default 
CONFIGURE ENCRYPTION FOR DATABASE OFF; # default 
CONFIGURE ENCRYPTION ALGORITHM 'AES128'; # default 
CONFIGURE COMPRESSION ALGORITHM 'BASIC' AS OF RELEASE 'DEFAULT' OPTIMIZE FOR LOAD TRUE ; # default 
CONFIGURE RMAN OUTPUT TO KEEP FOR 7 DAYS; # default 
CONFIGURE ARCHIVELOG DELETION POLICY TO NONE; # default 
CONFIGURE SNAPSHOT CONTROLFILE NAME TO '+FRA_RORA/snapcf_RORA.f';


Para configurar un parámetro:
Ejemplo de configurar el snapshot controlfile:

CONFIGURE BACKUP OPTIMIZATION ON;
CONFIGURE CONTROLFILE AUTOBACKUP ON;
CONFIGURE SNAPSHOT CONTROLFILE NAME TO '+FRA/snapcf_PCP.f';

CONFIGURE SNAPSHOT CONTROLFILE NAME TO '+FRA/snapcf_DOMICQ.f';
CONFIGURE SNAPSHOT CONTROLFILE NAME TO '+FRA/snapcf_DOMICHQ.f';



******************************************************************************************************
CONFIGURAR_ORACHK
******************************************************************************************************

./ahf_setup -ahf_loc /opt -data_dir /opt/oracle.ahf

orachk -id autostart_client_oratier1 -set "AUTORUN_SCHEDULE=3 2 1 * *"   

orachk -id autostart_client_oratier1 -set "AUTORUN_FLAGS=-usediscovery -profile oratier1 -dball -showpass -tag autostart_client_oratier1 -readenvconfig"

orachk -id autostart_client_oratier1 -set "COLLECTION_RETENTION=7"

orachk -id autostart_client -set "AUTORUN_SCHEDULE=3 3 1 * *"	

orachk -id autostart_client -set "AUTORUN_FLAGS=-usediscovery -tag autostart_client -readenvconfig"

orachk -id autostart_client -set "COLLECTION_RETENTION=7"

orachk -autostatus

******************************************************************************************************
REMEDIACIONES ORACHK --version 25
******************************************************************************************************
HUGEPAGES -- Crear archivo en tmp y correr para conocer valor y agregarlo a /etc/sysctl.conf
VMIN_FREE -- Crear archivo en tmp y correr para conocer valor y agregarlo a /etc/sysctl.conf



******************************************************************************************************

alter system set session_cached_cursors=<value> scope=spfile sid='*';

******************************************************************************************************
IP_FRAGMENTS_IS_NOT_CONFIGURE_AT_RECOMMENDED_VALUE

Agregar al archivo /etc/sysctl.conf

net.ipv4.ipfrag_low_thresh=15728640 
net.ipv4.ipfrag_high_thresh=16777216


Establecer los valores de los parametros temporalmente:

sysctl -w net.ipv4.ipfrag_low_thresh=15728640
sysctl -w net.ipv4.ipfrag_high_thresh=16777216

echo 15728640 > /proc/sys/net/ipv4/ipfrag_low_thresh 
echo 16777216 > /proc/sys/net/ipv4/ipfrag_high_thresh

Verificar: 

cat /proc/sys/net/ipv4/ipfrag_low_thresh 
cat /proc/sys/net/ipv4/ipfrag_high_thresh

******************************************************************************************************
Table AUD$[FGA_LOG$] should use Automatic Segment Space Management

Verificacion: El siguiente query debe devolver AUTO

col TABLE_NAME format a30
select t.table_name
      ,ts.segment_space_management 
  from dba_tables t
      ,dba_tablespaces ts 
 where ts.tablespace_name = t.tablespace_name and t.table_name in ('AUD$','FGA_LOG$');

******************************************************************************************************
crear TBS

CREATE TABLESPACE DATA_AUDIT DATAFILE
  SIZE 10M
  AUTOEXTEND ON NEXT 2048M MAXSIZE 32767M
  LOGGING FORCE LOGGING ONLINE PERMANENT BLOCKSIZE 8192
  EXTENT MANAGEMENT LOCAL AUTOALLOCATE DEFAULT
 NOCOMPRESS  SEGMENT SPACE MANAGEMENT AUTO;

******************************************************************************************************

BEGIN
  DBMS_AUDIT_MGMT.set_audit_trail_location(audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD, --this moves table AUD$ 
  audit_trail_location_value => 'DATA_AUDIT');

  DBMS_AUDIT_MGMT.set_audit_trail_location(audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_FGA_STD,--this moves table FGA_LOG$ 
  audit_trail_location_value => 'DATA_AUDIT');

  DBMS_AUDIT_MGMT.SET_AUDIT_TRAIL_LOCATION(AUDIT_TRAIL_TYPE => DBMS_AUDIT_MGMT.AUDIT_TRAIL_UNIFIED,
  AUDIT_TRAIL_LOCATION_VALUE => 'DATA_AUDIT');
END;  
/

******************************************************************************************************
Verificar que no exista objetos invalidos:

COLUMN object_name FORMAT A50
column OWNER format a30
set pagesize 1000
SELECT owner
      ,object_type
      ,object_name
      ,status
 FROM dba_objects
WHERE status = 'INVALID'
ORDER BY owner, object_type, object_name;

Compilar objetos invalidos:

@?/rdbms/admin/utlrp

******************************************************************************************************

free -k 64BG

90% de la memoria
modificar archivos 

oracle-database-preinstall-19c.conf

# oracle-database-preinstall-19c setting for memlock hard limit is maximum of 128GB on x86_64 or 3GB on x86 OR 90 % of RAM
oracle   hard   memlock    59350118

# oracle-database-preinstall-19c setting for memlock soft limit is maximum of 128GB on x86_64 or 3GB on x86 OR 90% of RAM
oracle   soft   memlock    59350118


oracle-grid-user-preinstall-19c.conf

# oracle-database-preinstall-19c setting for memlock hard limit is maximum of 128GB on x86_64 or 3GB on x86 OR 90 % of RAM
grid   hard   memlock    59350118

# oracle-database-preinstall-19c setting for memlock soft limit is maximum of 128GB on x86_64 or 3GB on x86 OR 90% of RAM
grid   soft   memlock    59350118



***************************************************
ACTIVAR_FLASHBACK

--VERIFICAR FLASHBACK
SELECT FLASHBACK_ON FROM V$DATABASE;

-- FLASHBACK_ON
-- ------------------
-- NO

-- Verificar archivelog
ARCHIVE LOG LIST;

-- Definir FRA (ejemplo de ruta y tamaño)
--ALTER SYSTEM SET db_recovery_file_dest='/ruta/FRA' SCOPE=BOTH;
ALTER SYSTEM SET db_recovery_file_dest_size=40G SCOPE=BOTH;

SELECT 
  name,
  ceil(space_limit/1024/1024) as size_mb,
  ceil(space_used/1024/1024) as used_mb,
  ceil((space_used/space_limit)*100) as pct_used
FROM v$recovery_file_dest;

-- NAME               SIZE_MB    USED_MB   PCT_USED
-- --------------- ---------- ---------- ----------
-- +FRA_RENTA          102400        499          1

-- Ver uso detallado de FRA (incluye archivelogs)
SELECT 
  file_type,
  percent_space_used,
  percent_space_reclaimable,
  NUMBER_OF_FILES
FROM v$flash_recovery_area_usage
ORDER BY percent_space_used DESC;

-- FILE_TYPE               PERCENT_SPACE_USED PERCENT_SPACE_RECLAIMABLE NUMBER_OF_FILES
-- ----------------------- ------------------ ------------------------- ---------------
-- ARCHIVED LOG                           .42                         0               6
-- BACKUP PIECE                           .05                         0               3
-- CONTROL FILE                           .02                         0               1
-- AUXILIARY DATAFILE COPY                  0                         0               0
-- IMAGE COPY                               0                         0               0
-- FLASHBACK LOG                            0                         0               0
-- FOREIGN ARCHIVED LOG                     0                         0               0
-- REDO LOG                                 0                         0               0


-- Ver tamaño redologs actuales
SELECT group#, bytes/1024/1024 as size_mb, status 
FROM v$log;


**************************************

MODIFICAR_FLASHBACK_ON

SHUTDOWN IMMEDIATE;
STARTUP MOUNT;
ALTER DATABASE FLASHBACK ON;
ALTER DATABASE OPEN;


**************************************

VERIFICAR_NUEVAMENTE --YES

SELECT FLASHBACK_ON FROM V$DATABASE;

-- FLASHBACK_ON
-- ------------------
-- YES

**************************************
MODIFICAR LISTENER

ps -fea | grep tns
root          69       2  0  2025 ?        00:00:00 [netns]
grid       87347       1  0 Jan06 ?        00:00:04 /oracle/app/oracle/product/19c/db1/bin/tnslsnr PCPQ -no_crs_notify -inherit
grid      329197       1  0 14:54 ?        00:00:00 /oracle/app/product/19c/grid/bin/tnslsnr LISTENER -no_crs_notify -inherit

-- el listener estaba con el home de oracle - Abrir NETCA en oracle y borrar el listener PCPQ - Abrir netca con grid y modificar el puerto. 
-- ir al tnsnames.ora y modificar el archivo

lsnrctl status LISTENER
.
crsctl stop has
.
crsctl start has

sqlplus system/oracle1@PCPQ



--POST_INSTALACIÓN_PCPHQ

******************************************************************************************************
REVISAR_DISCOS_DISKGROUPS
******************************************************************************************************
SET LINESIZE 1000
col PATH for a40
col DG_NAME for a20
col DG_STATE for a10
col FAILGROUP for a30
COL STATE FORMAT A10
SELECT dg.name dg_name, dg.state dg_state, dg.type, d.disk_number dsk_no,
d.path, d.mount_status, d.FAILGROUP, d.state 
FROM v$asm_diskgroup dg, v$asm_disk d
WHERE dg.group_number=d.group_number
--AND dg.name LIKE '%%'
ORDER BY dg_name, dsk_no;


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
AGREGAR_LOG_FILE
******************************************************************************************************


alter database add logfile thread 1 group 101 ('+REDO01_PCPH','+REDO02_PCPH') size 2048M; 
alter database add logfile thread 1 group 102 ('+REDO01_PCPH','+REDO02_PCPH') size 2048M; 
alter database add logfile thread 1 group 103 ('+REDO01_PCPH','+REDO02_PCPH') size 2048M; 


alter database add logfile thread 2 group 201 ('+REDO01_PCPH','+REDO02_PCPH') size 2048M; 
alter database add logfile thread 2 group 202 ('+REDO01_PCPH','+REDO02_PCPH') size 2048M; 
alter database add logfile thread 2 group 203 ('+REDO01_PCPH','+REDO02_PCPH') size 2048M; 

--
--
--alter database add logfile thread 3 group 301 ('+REDO01_RENTA','+REDO02_RENTA') size 2048M; 
--alter database add logfile thread 3 group 302 ('+REDO01_RENTA','+REDO02_RENTA') size 2048M; 
--alter database add logfile thread 3 group 303 ('+REDO01_RENTA','+REDO02_RENTA') size 2048M; 
--alter database add logfile thread 3 group 304 ('+REDO01_RENTA','+REDO02_RENTA') size 2048M; 

**CUANDO ES SINGLE SOLO SE AGREGA UN thread.

******************************************************************************************************
SWITCH_DE_REDOS
******************************************************************************************************

alter system switch logfile;
alter system checkpoint;

******************************************************************************************************
BORRAR_GRUPOS_DE_REDOS_VIEJOS --(CON ESTADO INACTIVO)
******************************************************************************************************
alter database drop logfile group 1;
--alter database drop logfile group 2;
alter database drop logfile group 3;
--alter database drop logfile group 4;


******************************************************************************************************
MODIFICAR_ARCHIVE_LOG_LIST
******************************************************************************************************

alter system set log_archive_dest_1='LOCATION=USE_DB_RECOVERY_FILE_DEST valid_for=(ALL_LOGFILES,ALL_ROLES) MAX_FAILURE=1 REOPEN=5 DB_UNIQUE_NAME=PCPHQ ALTERNATE=LOG_ARCHIVE_DEST_10';

alter system set log_archive_dest_10='location=+DATA_PCP valid_for=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME=PCPHQ ALTERNATE=LOG_ARCHIVE_DEST_1';

alter system set log_archive_dest_state_1='ENABLE';
alter system set log_archive_dest_state_10='ALTERNATE';
alter system set db_create_online_log_dest_1='+REDO01_PCPH';
alter system set db_create_online_log_dest_2='+REDO02_PCPH';

******************************************************************************************************
REVISAR_PARAMETRO_REDOS
******************************************************************************************************
show parameter LOG

******************************************************************************************************
CONFIGURAR_PARAMETROS_AWR
******************************************************************************************************

Retención:
execute dbms_workload_repository.modify_snapshot_settings (interval => 15,retention => 11520);

Statistics level:
ALTER SYSTEM SET statistics_level=all;


******************************************************************************************************
CONFIGURAR_FAST_START_MTTR_TARGET
******************************************************************************************************

show parameter fast_start_mttr_target;

alter system set fast_start_mttr_target=300 Comment='Recomendation AHF' scope=both;

******************************************************************************************************
ESTABLECER_DB_BLOCK_CHECKING_DB_LOST_WRITE_PROTECT
******************************************************************************************************

alter system set db_block_checking=MEDIUM Comment='Recomendation AHF';
alter system set db_lost_write_protect=TYPICAL Comment='Recomendation AHF';

show parameter DB_BLOCK_CHECKING;
show parameter DB_LOST_WRITE_PROTECT;


******************************************************************************************************
MODIFICAR_PROMPT_SQLPLUS
******************************************************************************************************
cp -p $ORACLE_HOME/sqlplus/admin/glogin.sql $ORACLE_HOME/sqlplus/admin/glogin.sql.original

cat <<EOT >>$ORACLE_HOME/sqlplus/admin/glogin.sql 

SET TIMI ON
SET TIME ON
SET LINE 240
SET SQLPROMPT '&_USER.@&_CONNECT_IDENTIFIER.> '
EOT


******************************************************************************************************
VERIFICAR_MODIFICAR_PARAMETROS_RMAN
******************************************************************************************************

rman target /
rman> show all;

Los parámetros deben ser similares a los siguientes:

CONFIGURE RETENTION POLICY TO REDUNDANCY 1; # default 
CONFIGURE BACKUP OPTIMIZATION OFF; # default 
CONFIGURE DEFAULT DEVICE TYPE TO DISK; # default 
CONFIGURE CONTROLFILE AUTOBACKUP ON;
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '%F'; # default 
CONFIGURE DEVICE TYPE DISK PARALLELISM 1 BACKUP TYPE TO BACKUPSET; # default 
CONFIGURE DATAFILE BACKUP COPIES FOR DEVICE TYPE DISK TO 1; # default 
CONFIGURE ARCHIVELOG BACKUP COPIES FOR DEVICE TYPE DISK TO 1; # default 
CONFIGURE MAXSETSIZE TO UNLIMITED; # default 
CONFIGURE ENCRYPTION FOR DATABASE OFF; # default 
CONFIGURE ENCRYPTION ALGORITHM 'AES128'; # default 
CONFIGURE COMPRESSION ALGORITHM 'BASIC' AS OF RELEASE 'DEFAULT' OPTIMIZE FOR LOAD TRUE ; # default 
CONFIGURE RMAN OUTPUT TO KEEP FOR 7 DAYS; # default 
CONFIGURE ARCHIVELOG DELETION POLICY TO NONE; # default 
CONFIGURE SNAPSHOT CONTROLFILE NAME TO '+FRA_RORA/snapcf_RORA.f';


Para configurar un parámetro:
Ejemplo de configurar el snapshot controlfile:

CONFIGURE BACKUP OPTIMIZATION ON;
CONFIGURE CONTROLFILE AUTOBACKUP ON;
CONFIGURE SNAPSHOT CONTROLFILE NAME TO '+FRA/snapcf_PCPQ.f';

