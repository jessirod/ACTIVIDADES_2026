INSTALACION - OPICS

******************************************************************************************************
TAMAÑO_BD
******************************************************************************************************

DATABASE SIZE IN GB USED SPACE IN GB FREE SPACE IN GB
------------------- ---------------- ----------------
                203               97              106

******************************************************************************************************
SOLICITUD DE  DISCOS
******************************************************************************************************

2 discos de 100GB --DATA
2 discos de 50GB  --FRA
2 discos de 10GB   --ASM
4 discos de 10GB  --REDOS

******************************************************************************************************
******************************************************************************************************

Ejemplo del rango sdb al sdg
lsblk -fm `ls -1 /dev/sd[e-n]` | sort -k1

for i in `ls -1 /dev/sd[e-n]`
do
  echo -e "o\nn\np\n1\n\n\nw" | fdisk $i
done

sde----   100G 
sdf----   100G 

sdg----   50G 
sdh----   50G 


sdi----   10G 
sdj----   10G 

sdk----   10G 
sdl----   10G 
sdm----   10G 
sdn----   10G 


/usr/sbin/oracleasm createdisk DATA_OPICS_01 /dev/sde1
/usr/sbin/oracleasm createdisk DATA_OPICS_02 /dev/sdf1

/usr/sbin/oracleasm createdisk FRA_OPICS_01 /dev/sdg1
/usr/sbin/oracleasm createdisk FRA_OPICS_02 /dev/sdh1


/usr/sbin/oracleasm createdisk ASM_01 /dev/sdi1
/usr/sbin/oracleasm createdisk ASM_02 /dev/sdj1

/usr/sbin/oracleasm createdisk REDO01_OPICS_01 /dev/sdk1
/usr/sbin/oracleasm createdisk REDO01_OPICS_02 /dev/sdl1
/usr/sbin/oracleasm createdisk REDO02_OPICS_01 /dev/sdm1
/usr/sbin/oracleasm createdisk REDO02_OPICS_02 /dev/sdn1

******************************************************************************************************
MOVER AHF
******************************************************************************************************

FILE_PATH=/opt/oracle.ahf/data/plbdopc01/orachk/user_root/output/orachk_plbdopc01_OPICSP_030526_115024.zip
FILE_NAME=$(basename ${FILE_PATH} | cut -d'.' -f1)
unzip -q -d /tmp -j ${FILE_PATH} "${FILE_NAME}/${FILE_NAME}.html" && chmod 777 /tmp/${FILE_NAME}.html && cd /tmp

orachk_plbdopc01_OPICSP_030426_145715.html

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

alter database add logfile thread 1 group 101 ('+REDO01_OPICS','+REDO02_OPICS') size 2048M; 
alter database add logfile thread 1 group 102 ('+REDO01_OPICS','+REDO02_OPICS') size 2048M; 
alter database add logfile thread 1 group 103 ('+REDO01_OPICS','+REDO02_OPICS') size 2048M; 
alter database add logfile thread 1 group 104 ('+REDO01_OPICS','+REDO02_OPICS') size 2048M;

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
alter system set log_archive_dest_1='LOCATION=USE_DB_RECOVERY_FILE_DEST valid_for=(ALL_LOGFILES,ALL_ROLES) MAX_FAILURE=1 REOPEN=5 DB_UNIQUE_NAME=OPICSP ALTERNATE=LOG_ARCHIVE_DEST_10';
alter system set log_archive_dest_10='location=+DATA_OPICS valid_for=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME=OPICSP ALTERNATE=LOG_ARCHIVE_DEST_1';

alter system set log_archive_dest_state_1='ENABLE';
alter system set log_archive_dest_state_10='ALTERNATE';
alter system set db_create_online_log_dest_1='+REDO01_OPICS';
alter system set db_create_online_log_dest_2='+REDO02_OPICS';

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
cursor_obsolete_threshold hidden parameter
******************************************************************************************************

alter system set "_cursor_obsolete_threshold"=1024 scope=spfile;

******************************************************************************************************
VERIFICAR_MODIFICAR_PARAMETROS_RMAN
******************************************************************************************************

rman target /
rman> show all;

Los parámetros deben ser similares a los siguientes:

using target database control file instead of recovery catalog
RMAN configuration parameters for database with db_unique_name OPICSP are:
CONFIGURE RETENTION POLICY TO REDUNDANCY 1; # default
CONFIGURE BACKUP OPTIMIZATION OFF; # default
CONFIGURE DEFAULT DEVICE TYPE TO DISK; # default
CONFIGURE CONTROLFILE AUTOBACKUP ON; # default
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
CONFIGURE SNAPSHOT CONTROLFILE NAME TO '/oracle/app/oracle/product/19c/db1/dbs/snapcf_OPICSP.f'; # default



Para configurar un parámetro:
Ejemplo de configurar el snapshot controlfile:

CONFIGURE BACKUP OPTIMIZATION ON;
CONFIGURE CONTROLFILE AUTOBACKUP ON;
CONFIGURE SNAPSHOT CONTROLFILE NAME TO '+FRA_OPICS/snapcf_OPICSP.f';


******************************************************************************************************
REMEDIACIONES ORACHK --version 26.10
******************************************************************************************************
HUGEPAGES -- Crear archivo en tmp y correr para conocer valor y agregarlo a /etc/sysctl.conf
VMIN_FREE -- Crear archivo en tmp y correr para conocer valor y agregarlo a /etc/sysctl.conf


******************************************************************************************************
Table AUD$[FGA_LOG$] should use Automatic Segment Space Management
******************************************************************************************************
Verificacion: El siguiente query debe devolver AUTO

col TABLE_NAME format a30
select t.table_name
      ,ts.segment_space_management 
  from dba_tables t
      ,dba_tablespaces ts 
 where ts.tablespace_name = t.tablespace_name and t.table_name in ('AUD$','FGA_LOG$');

------------------------------------------------------------------------------------------------------
crear TBS

CREATE TABLESPACE DATA_AUDIT DATAFILE
  SIZE 1024M
  AUTOEXTEND ON NEXT 2048M MAXSIZE 32767M
  LOGGING FORCE LOGGING ONLINE PERMANENT BLOCKSIZE 8192
  EXTENT MANAGEMENT LOCAL AUTOALLOCATE DEFAULT
 NOCOMPRESS  SEGMENT SPACE MANAGEMENT AUTO;

------------------------------------------------------------------------------------------------------

BEGIN
  DBMS_AUDIT_MGMT.set_audit_trail_location(audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD, --this moves table AUD$ 
  audit_trail_location_value => 'DATA_AUDIT');

  DBMS_AUDIT_MGMT.set_audit_trail_location(audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_FGA_STD,--this moves table FGA_LOG$ 
  audit_trail_location_value => 'DATA_AUDIT');

  DBMS_AUDIT_MGMT.SET_AUDIT_TRAIL_LOCATION(AUDIT_TRAIL_TYPE => DBMS_AUDIT_MGMT.AUDIT_TRAIL_UNIFIED,
  AUDIT_TRAIL_LOCATION_VALUE => 'DATA_AUDIT');
END;  
/

------------------------------------------------------------------------------------------------------

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
------------------------------------------------------------------------------------------------------

Compilar objetos invalidos:

@?/rdbms/admin/utlrp

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
IP_FRAGMENTS_IS_NOT_CONFIGURE_AT_RECOMMENDED_VALUE
******************************************************************************************************

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
Verify kernel-space and user-space core dumps configuration
******************************************************************************************************

systemctl enable kdump.service
systemctl start kdump.service
systemctl disable --now systemd-coredump.socket
systemctl mask systemd-coredump.socket

vi /etc/systemd/coredump.conf
    Storage=none y ProcessSizeMax=0

vi /etc/sysctl.conf
    kernel.core_pattern = |/bin/false

sysctl --system

vi /etc/security/limits.conf
    *               hard    core            0

******************************************************************************************************
Verify number of inactive patches for database home
******************************************************************************************************
List inactive patches:
    opatch util listorderedinactivepatches
Delete inactive patches:
    opatch util deleteinactivepatches



******************************************************************************************************
Crear TBS index y data
******************************************************************************************************



CREATE TABLESPACE DATA
DATAFILE
'+DATA_OPICS' SIZE 2048M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;



CREATE TABLESPACE INDX
DATAFILE 
  '+DATA_OPICS' SIZE 2048M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED
LOGGING
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;



******************************************************************************************************
Modificar LOCAL_LISTENER
******************************************************************************************************

ALTER SYSTEM SET LOCAL_LISTENER='(ADDRESS = (PROTOCOL = TCP)(HOST = plbdopc01)(PORT = 1560))' SCOPE=BOTH;
ALTER SYSTEM REGISTER;