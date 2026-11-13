Remediaciones_ULTSECD.sql


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


alter database add logfile thread 1 group 101 ('+REDO01','+REDO02') size 4096M; 
alter database add logfile thread 1 group 102 ('+REDO01','+REDO02') size 4096M; 
alter database add logfile thread 1 group 103 ('+REDO01','+REDO02') size 4096M; 
alter database add logfile thread 1 group 104 ('+REDO01','+REDO02') size 4096M;



**CUANDO ES SINGLE SOLO SE AGREGA UN GRUPO.

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



--alter database drop logfile group 201;
--alter database drop logfile group 202;
--alter database drop logfile group 203;
--alter database drop logfile group 204;
--alter database drop logfile group 301;
--alter database drop logfile group 302;
--alter database drop logfile group 303;
--alter database drop logfile group 304;


******************************************************************************************************
MODIFICAR_ARCHIVE_LOG_LIST
******************************************************************************************************

alter system set log_archive_dest_1='LOCATION=USE_DB_RECOVERY_FILE_DEST valid_for=(ALL_LOGFILES,ALL_ROLES) MAX_FAILURE=1 REOPEN=5 DB_UNIQUE_NAME=ULTSECD ALTERNATE=LOG_ARCHIVE_DEST_10';

alter system set log_archive_dest_10='location=+DATA valid_for=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME=ULTSECD ALTERNATE=LOG_ARCHIVE_DEST_1';

alter system set log_archive_dest_state_1='ENABLE';
alter system set log_archive_dest_state_10='ALTERNATE';
alter system set db_create_online_log_dest_1='+REDO01';
alter system set db_create_online_log_dest_2='+REDO02';

******************************************************************************************************
REVISAR_PARAMETRO_REDOS
******************************************************************************************************
show parameter LOG

******************************************************************************************************
CONFIGURAR_REDOS_POR_DEFAULT
******************************************************************************************************
alter system set db_create_online_log_dest_1='+REDO01';
alter system set db_create_online_log_dest_2='+REDO02';
show parameter online

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
VERIFICAR_DBA_REGISTRY
******************************************************************************************************

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

******************************************************************************************************
VERIFICAR_MODIFICAR_PARAMETROS_RMAN
******************************************************************************************************

rman target /
show all;

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
CONFIGURE SNAPSHOT CONTROLFILE NAME TO '+FRA/snapcf_ULTSECD.f';


Para configurar un parámetro:
Ejemplo de configurar el snapshot controlfile:

CONFIGURE BACKUP OPTIMIZATION ON;
CONFIGURE CONTROLFILE AUTOBACKUP ON;
CONFIGURE SNAPSHOT CONTROLFILE NAME TO '+FRA/snapcf_ULTSECD.f';


******************************************************************************************************
REGISTRAR_BD_CATALOGO_RMAN
******************************************************************************************************
EN QA Y DEV - SOLICITAR RUTA ESTATICA POR VLAN DE BACKUP PREVIAMENTE.

-- Backup del tnsnames 
cp -p $ORACLE_HOME/network/admin/tnsnames.ora $ORACLE_HOME/network/admin/tnsnames.ora.jr.$(date +'%Y%m%d')

-- Agregar string de conexion del servidor de catalog de rman

RMAN19 =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = sun1122p.banvenez.corp)(PORT = 1536))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = RMAN19.banvenez.corp)
    )
  )

-- Verificar conexion

tnsping RMAN19

--Conectarse al catalog

bash
rman target / catalog rman/rmanexport@RMAN19


-- Registrar BD

upgrade catalog;
upgrade catalog;

register database;


-- Cuando se instala networker se debe configurar la libreria
ln -s /usr/lib/libnsrora.so $ORACLE_HOME/lib/libobk.so


--Add in etc/hosts


# RMAN 19 PRODUCCION (BACKUPS)
# 172.27.52.86 sun1122p_b sun1122p_b.banvenez.corp


******************************************************************************************************
INSTALAR_AHF
******************************************************************************************************
Desinstalar el ahf que viene por defecto:

Con el usuario root

ahfctl uninstall -deleterepo -silent

Con el usuario root

1.-Ir al directorio donde está descargado el AHF y descomprimir

unzip -q /u01/binarios/tools/AHF-LINUX_v22.3.2.zip

2.-Instalar

su  root
./ahf_setup -ahf_loc /opt -data_dir /opt/oracle.ahf


3.-Validar status

tfactl status
cd /opt/oracle.ahf/bin
ls -ltr



******************************************************************************************************
CONFIGURAR_ORACHK
******************************************************************************************************

orachk -id autostart_client_oratier1 -set "AUTORUN_SCHEDULE=3 2 1 * *"   

orachk -id autostart_client_oratier1 -set "AUTORUN_FLAGS=-usediscovery -profile oratier1 -dball -showpass -tag autostart_client_oratier1 -readenvconfig"

orachk -id autostart_client_oratier1 -set "COLLECTION_RETENTION=7"

orachk -id autostart_client -set "AUTORUN_SCHEDULE=3 3 1 * *"	

orachk -id autostart_client -set "AUTORUN_FLAGS=-usediscovery -tag autostart_client -readenvconfig"

orachk -id autostart_client -set "COLLECTION_RETENTION=7"

orachk -autostatus


******************************************************************************************************
EJECUTAR_ORACHK
******************************************************************************************************

cd /opt/oracle.ahf/bin
./orachk -nodaemon


******************************************************************************************************
REMEDIACIONES ORACHK --version 26.9
******************************************************************************************************
HUGEPAGES -- Crear archivo en tmp y correr para conocer valor y agregarlo a /etc/sysctl.conf

#!/bin/bash
# 
# hugepages_settings.sh 
# 
# Linux bash script to compute values for the 
# recommended HugePages/HugeTLB configuration 
# on Oracle Linux 
# 
# Note: This script does calculation for all shared memory 
# segments available when the script is run, no matter it 
# is an Oracle RDBMS shared memory segment or not. 
# 
# This script is provided by KB151310 from My Oracle Support 
# http://support.oracle.com 

# Welcome text 
echo " 
This script is provided by KB151310 from My Oracle Support 
(http://support.oracle.com) where it is intended to compute values for 
the recommended HugePages/HugeTLB configuration for the current shared 
memory segments on Oracle Linux. Before proceeding with the execution please note following: 
 * For ASM instance, it needs to configure ASMM instead of AMM. 
 * The 'pga_aggregate_target' is outside the SGA and 
   you should accommodate this while calculating the overall size. 
 * In case you changes the DB SGA size, 
   as the new SGA will not fit in the previous HugePages configuration, 
   it had better disable the whole HugePages, 
   start the DB with new SGA size and run the script again. 
And make sure that: 
 * Oracle Database instance(s) are up and running 
 * Oracle Database Automatic Memory Management (AMM) is not setup 
   (See KB83222) 
 * The shared memory segments can be listed by command: 
     # ipcs -m 


Press Enter to proceed..." 

read 

# Check for the kernel version 
KERN=`uname -r | awk -F. '{ printf("%d.%d\n",$1,$2); }'` 

# Find out the HugePage size 
HPG_SZ=`grep Hugepagesize /proc/meminfo | awk '{print $2}'` 
if [ -z "$HPG_SZ" ];then 
    echo "The hugepages may not be supported in the system where the script is being executed." 
    exit 1 
fi 

# Initialize the counter 
NUM_PG=0 

# Cumulative number of pages required to handle the running shared memory segments 
for SEG_BYTES in `ipcs -m | cut -c44-300 | awk '{print $1}' | grep "[0-9][0-9]*"` 
do 
    MIN_PG=`echo "$SEG_BYTES/($HPG_SZ*1024)" | bc -q` 
    if [ $MIN_PG -gt 0 ]; then 
        NUM_PG=`echo "$NUM_PG+$MIN_PG+1" | bc -q` 
    fi 
done 

RES_BYTES=`echo "$NUM_PG * $HPG_SZ * 1024" | bc -q` 

# An SGA less than 100MB does not make sense 
# Bail out if that is the case 
if [ $RES_BYTES -lt 100000000 ]; then 
    echo "***********" 
    echo "** ERROR **" 
    echo "***********" 
    echo "Sorry! There are not enough total of shared memory segments allocated for 
HugePages configuration. HugePages can only be used for shared memory segments 
that you can list by command: 

    # ipcs -m 

of a size that can match an Oracle Database SGA. Please make sure that: 
 * Oracle Database instance is up and running 
 * Oracle Database Automatic Memory Management (AMM) is not configured" 
    exit 1 
fi 

# Finish with results 
    echo "Recommended setting: vm.nr_hugepages = $NUM_PG"; 

# End

--Cambiar permisos
chmod +x /tmp/hugepages_settings.sh

--Ejecutar
/tmp/hugepages_settings.sh

--Verificar Archivo
grep "vm.nr_hugepages" /etc/sysctl.conf

-- Modificar Valor
vi /etc/sysctl.conf

#REMEDIACIONES ORACHK
vm.nr_hugepages = 3581 

sysctl -w vm.nr_hugepages=3583
sysctl -p


*********
*********

VMIN_FREE -- Crear archivo en tmp y correr para conocer valor y agregarlo a /etc/sysctl.conf

vi /tmp/min_free_kbytes_settings.sh

#!/bin/bash

MIN_FREE_KBYTES_SYSCTL=$(egrep ^vm.min_free_kbytes /etc/sysctl.conf | awk -F'=' '{print $2}' | tr -d ' ')
MIN_FREE_KBYTES_MEMORY=$(cat /proc/sys/vm/min_free_kbytes)
NUMA_NODE_COUNT=$(numactl --hardware | grep available: | awk '{print $2}')
TOTAL_MEMORY_KBYTES=$(free -k | awk '/Mem:/ {print $2}')
NUMA_BASED=$(( $NUMA_NODE_COUNT * 1048576 ))
MEMORY_BASED=$(( $TOTAL_MEMORY_KBYTES / 200 ))
if [[ $NUMA_BASED -ge $MEMORY_BASED ]]
then
  RECOMMEND_VALUE=$NUMA_BASED
else
  RECOMMEND_VALUE=$MEMORY_BASED
fi
OFFSET=$(echo $RECOMMEND_VALUE*.05 | bc | cut -d"." -f1)
LOWER_BOUND=$(echo $RECOMMEND_VALUE-$OFFSET | bc)
UPPER_BOUND=$(echo $RECOMMEND_VALUE+$OFFSET | bc)
if [[ $MIN_FREE_KBYTES_SYSCTL -ge LOWER_BOUND && $MIN_FREE_KBYTES_SYSCTL -le UPPER_BOUND ]]
then
  SYSCTL_IN_RANGE=YES
else
  SYSCTL_IN_RANGE=NO
fi
#sysctl in range?
if [[ $MIN_FREE_KBYTES_MEMORY -ge LOWER_BOUND && $MIN_FREE_KBYTES_MEMORY -le UPPER_BOUND ]]
then
  MEMORY_IN_RANGE=YES
else
  MEMORY_IN_RANGE=NO
fi
DETAIL=$(
echo -e "Total Memory:       $TOTAL_MEMORY_KBYTES";
echo -e "NUMA node count:    $NUMA_NODE_COUNT";
echo -e "NUMA calculated:    $NUMA_BASED";
echo -e "memory calculated:  $MEMORY_BASED";
echo -e "recommended value:  $RECOMMEND_VALUE";
echo -e "permitted range:    $LOWER_BOUND to $UPPER_BOUND";
echo -e "in sysctl.conf:     $MIN_FREE_KBYTES_SYSCTL";
echo -e "sysctl in range?:   $SYSCTL_IN_RANGE";
echo -e "in active memory:   $MIN_FREE_KBYTES_MEMORY";
echo -e "memory in range?:   $MEMORY_IN_RANGE";
)
if [[ $SYSCTL_IN_RANGE = YES && $MEMORY_IN_RANGE = YES ]]
then
  echo -e "SUCCESS: vm.min_free_kbytes is configured as recommended.  Details:\n\n$DETAIL"
elif [[ $MIN_FREE_KBYTES_SYSCTL -lt $LOWER_BOUND || $MIN_FREE_KBYTES_MEMORY -lt $LOWER_BOUND ]]
then
  echo -e "FAILURE: vm.min_free_kbytes is not configured as recommended.  Details:\n\n$DETAIL"
elif  [[ $MIN_FREE_KBYTES_SYSCTL -gt $UPPER_BOUND && $MIN_FREE_KBYTES_MEMORY -gt $UPPER_BOUND ]]
then
  echo -e "WARNING: vm.min_free_kbytes is not configured as recommended.  Details:\n\n$DETAIL"
else
  echo -e "ERROR: Inconsistent results.  Details:\n\n$DETAILS"
fi

# End

--Cambiar permisos
chmod +x /tmp/min_free_kbytes_settings.sh

--Ejecutar
/tmp/min_free_kbytes_settings.sh

--FAILURE: vm.min_free_kbytes is not configured as recommended.  Details:
--Total Memory:       65318276
--NUMA node count:    1
--NUMA calculated:    1048576
--memory calculated:  326591
--recommended value:  1048576
--permitted range:    996148 to 1101004
--in sysctl.conf:
--sysctl in range?:   NO
--in active memory:   32276
--memory in range?:   NO

--Modificar archivo
vi /etc/sysctl.conf
vm.min_free_kbytes = 1048576

--Setear parametro
sysctl -p

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

CREATE TABLESPACE DATA_AUDITORIA
DATAFILE 
  '+DATA' SIZE 1024M AUTOEXTEND OFF
LOGGING
DEFAULT 
  NO INMEMORY
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;
******************************************************************************************************

BEGIN
DBMS_AUDIT_MGMT.set_audit_trail_location(audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD, --this moves table AUD$ 
audit_trail_location_value => 'DATA_AUDITORIA');
END;  
/

BEGIN
DBMS_AUDIT_MGMT.set_audit_trail_location(audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_FGA_STD,--this moves table FGA_LOG$ 
audit_trail_location_value => 'DATA_AUDITORIA');
END;
/  

BEGIN
DBMS_AUDIT_MGMT.set_audit_trail_location(
audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_UNIFIED,--this moves table Unified Audit
audit_trail_location_value => 'DATA_AUDITORIA');
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
--
--free -k 64BG
--
--90% de la memoria
--modificar archivos 
--
--oracle-database-preinstall-19c.conf
--
--# oracle-database-preinstall-19c setting for memlock hard limit is maximum of 128GB on x86_64 or 3GB on x86 OR 90 % of RAM
--oracle   hard   memlock    59350118
--
--# oracle-database-preinstall-19c setting for memlock soft limit is maximum of 128GB on x86_64 or 3GB on x86 OR 90% of RAM
--oracle   soft   memlock    59350118
--
--
--oracle-grid-user-preinstall-19c.conf
--
--# oracle-database-preinstall-19c setting for memlock hard limit is maximum of 128GB on x86_64 or 3GB on x86 OR 90 % of RAM
--grid   hard   memlock    59350118
--
--# oracle-database-preinstall-19c setting for memlock soft limit is maximum of 128GB on x86_64 or 3GB on x86 OR 90% of RAM
--grid   soft   memlock    59350118
--
--
--
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
ALTER SYSTEM SET db_recovery_file_dest_size=100G SCOPE=BOTH;

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

********************************************************************************
********************************************************************************

Verify kernel-space and user-space core dumps configuration

PASS - Kernel-space core dump configuration is correct:

--1.1) PASS - kdump service configuration:	enabled
--1.2) PASS - kdump service status:		active
--
--FAIL - User-space core dump configuration is incorrect:
--
--2.1) FAIL - Core dump socket status:		active
--2.2) FAIL - Core dump socket configuration:	static
--2.3) PASS - Core dump storage:			False
--2.4) PASS - Core dump limits for users:		Disabled
--2.5) PASS - Core dump backtraces:		False
--



2.1) If the core dump socket status is active, execute the following command:

        # systemctl disable --now systemd-coredump.socket
2.2) If the core dump socket configuration is not masked, execute the following command:

        # systemctl mask systemd-coredump.socket        


********************************************************************************
session_cached_cursors parameter

SESSION_CACHED_CURSORS: Current Value =    50                Usage =    50                  Percentage Usage = 100%

ALTER SYSTEM SET session_cached_cursors=150 SCOPE=SPFILE;


********************************************************************************
cursor_obsolete_threshold hidden parameter

alter system set "_cursor_obsolete_threshold"=1024 scope=spfile;
********************************************************************************



********************************************************************************


