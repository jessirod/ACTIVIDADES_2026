
cd /etc/security/limits.d/
grid - oracle

systemctl disable avahi-daemon.socket avahi-daemon.service
systemctl mask avahi-daemon.socket avahi-daemon.service
systemctl stop avahi-daemon.socket avahi-daemon.service


systemctl status firewalld
systemctl disable firewalld

etc/hosts
180.183.172.86 dlbdro01 dlbdro01.banvendes.corp


grep X11Forwarding /etc/ssh/sshd_config

mkdir -p /oracle/app/oraInventory
mkdir -p /oracle/app/grid
mkdir -p /oracle/app/product/19c/grid
mkdir -p /oracle/app/oracle/product/19c/db1

chown -R grid:oinstall /oracle/
chown -R oracle19:oinstall /oracle/app/oracle 
chmod -R 775 /oracle/

/usr/sbin/oracleasm init
echo -e "grid\nasmadmin\ny\ny\n" | oracleasm configure -i


unzip -q /exportdb/instalacion/V982068-01-grid.zip
unzip -q /exportdb/instalacion/V982063-01-oracle.zip


rpm -Uvh /oracle/app/product/19c/grid/cv/rpm/cvuqdisk-1.0.10-1.rpm

export CV_ASSUME_DISTID=OL7 
$ORACLE_HOME/runcluvfy.sh stage -pre hacfg



******************************************************************************************************




FILE_PATH=/opt/oracle.ahf/data/dlbdro01/orachk/user_root/output/orachk_dlbdro01_RORAIMAD_012626_225041.zip
FILE_NAME=$(basename ${FILE_PATH} | cut -d'.' -f1)
unzip -q -d /tmp -j ${FILE_PATH} "${FILE_NAME}/${FILE_NAME}.html" && chmod 777 /tmp/${FILE_NAME}.html && cd /tmp


cd /opt/oracle.ahf/common/cvu
unzip -q /exportdb/cvupack_linux_ol7_x86_64.zip




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

DG_NAME              DG_STATE   TYPE       DSK_NO PATH                                     MOUNT_S FAILGROUP                      STATE
-------------------- ---------- ------ ---------- ---------------------------------------- ------- ------------------------------ ----------
ASM                  MOUNTED    EXTERN          0 /dev/oracleasm/disks/ASM_01              CACHED  ASM_0000                       NORMAL
ASM                  MOUNTED    EXTERN          1 /dev/oracleasm/disks/ASM_02              CACHED  ASM_0001                       NORMAL
DATA_RORA            CONNECTED  EXTERN          0 /dev/oracleasm/disks/DATA_RORA_01        CACHED  DATA_RORA_0000                 NORMAL
DATA_RORA            CONNECTED  EXTERN          1 /dev/oracleasm/disks/DATA_RORA_02        CACHED  DATA_RORA_0001                 NORMAL
FRA_RORA             CONNECTED  EXTERN          0 /dev/oracleasm/disks/FRA_RORA_01         CACHED  FRA_RORA_0000                  NORMAL
FRA_RORA             CONNECTED  EXTERN          1 /dev/oracleasm/disks/FRA_RORA_02         CACHED  FRA_RORA_0001                  NORMAL
REDO01_RORA          MOUNTED    EXTERN          0 /dev/oracleasm/disks/REDO01_RORA_01      CACHED  REDO01_RORA_0000               NORMAL
REDO01_RORA          MOUNTED    EXTERN          1 /dev/oracleasm/disks/REDO01_RORA_02      CACHED  REDO01_RORA_0001               NORMAL
REDO02_RORA          MOUNTED    EXTERN          0 /dev/oracleasm/disks/REDO02_RORA_01      CACHED  REDO02_RORA_0000               NORMAL
REDO02_RORA          MOUNTED    EXTERN          1 /dev/oracleasm/disks/REDO02_RORA_02      CACHED  REDO02_RORA_0001               NORMAL


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


--alter database add logfile thread 1 group 101 ('+REDO01_RORAIMA','+REDO02_RORAIMA') size 2048M; 
--alter database add logfile thread 1 group 102 ('+REDO01_RORAIMA','+REDO02_RORAIMA') size 2048M; 
--alter database add logfile thread 1 group 103 ('+REDO01_RORAIMA','+REDO02_RORAIMA') size 2048M; 
alter database add logfile thread 1 group 104 ('+REDO01_RORAIMA','+REDO02_RORAIMA') size 2048M; 
alter database add logfile thread 1 group 105 ('+REDO01_RORAIMA','+REDO02_RORAIMA') size 2048M; 


******************************************************************************************************
SWITCH_DE_REDOS
******************************************************************************************************

alter system switch logfile;
alter system checkpoint;

******************************************************************************************************
BORRAR_GRUPOS_DE_REDOS_VIEJOS --(CON ESTADO INACTIVO)
******************************************************************************************************
alter database drop logfile group 1;
alter database drop logfile group 2;
alter database drop logfile group 3;

******************************************************************************************************
MODIFICAR_ARCHIVE_LOG_LIST
******************************************************************************************************

alter system set log_archive_dest_1='LOCATION=USE_DB_RECOVERY_FILE_DEST valid_for=(ALL_LOGFILES,ALL_ROLES) MAX_FAILURE=1 REOPEN=5 DB_UNIQUE_NAME=ROMAIRAD ALTERNATE=LOG_ARCHIVE_DEST_10';

alter system set log_archive_dest_10='location=+DATA_RORAIMA valid_for=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME=ROMAIRAD ALTERNATE=LOG_ARCHIVE_DEST_1';

alter system set log_archive_dest_state_1='ENABLE';
alter system set log_archive_dest_state_10='ALTERNATE';

alter system set db_create_online_log_dest_1='+REDO01_RORAIMA';
alter system set db_create_online_log_dest_2='+REDO02_RORAIMA';



*******************



cp -p $ORACLE_HOME/sqlplus/admin/glogin.sql $ORACLE_HOME/sqlplus/admin/glogin.sql.jr.$(date +'%Y%m%d')
cat <<EOF >> $ORACLE_HOME/sqlplus/admin/glogin.sql
SET TIMI ON
SET TIME ON
SET LINE 180 PAGES 300
--ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-RRRR HH24:MI:SS';
SET SQLPROMPT '&_USER.@&_CONNECT_IDENTIFIER.> '
EOF


	CSS log file size

/oracle/app/product/19c/grid/bin/crsctl get tracefileopts css
/oracle/app/product/19c/grid/bin/crsctl set tracefileopts css -filesize 157286400





FILE_PATH=/opt/oracle.ahf/data/dlbdro01/orachk/user_root/output/orachk_dlbdro01_RORAIMAD_012726_000429.zip
FILE_NAME=$(basename ${FILE_PATH} | cut -d'.' -f1)
unzip -q -d /tmp -j ${FILE_PATH} "${FILE_NAME}/${FILE_NAME}.html" && chmod 777 /tmp/${FILE_NAME}.html && cd /tmp


*******************************

execute dbms_workload_repository.modify_snapshot_settings (interval => 15,retention => 11520);

ALTER SYSTEM SET statistics_level=all;

set timi on
set time on
set line 380
set pagesize 50
col comp_name format a50
col status format a10
select 
  comp_name
  , version
  , VERSION_FULL
  , status
from dba_registry;

show parameter fast_start_mttr_target;
alter system set fast_start_mttr_target=300 Comment='Recomendation AHF' scope=both;

alter system set db_block_checking=MEDIUM;
alter system set db_lost_write_protect=TYPICAL;
show parameter DB_BLOCK_CHECKING;
show parameter DB_LOST_WRITE_PROTECT;

CONFIGURE BACKUP OPTIMIZATION ON;
CONFIGURE CONTROLFILE AUTOBACKUP ON;
CONFIGURE SNAPSHOT CONTROLFILE NAME TO '+FRA_RORAIMA/snapcf_RORAIMA.f';


*******************


archive log list;
shutdown immediate;
startup mount;
alter database archivelog;
alter database open;
archive log list;
configurar el destination principal y secundario


alter system set db_flashback_retention_target=1440;
alter database flashback on;





ALTER SYSTEM SET processes=7000 SCOPE=SPFILE;