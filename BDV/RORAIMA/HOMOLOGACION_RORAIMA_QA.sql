**************************************************************************************************************************************

set pagesize 100
set linesize 400
col OWNER for a15
col DIRECTORY_NAME for a40
col DIRECTORY_PATH for a70
select OWNER, DIRECTORY_NAME, DIRECTORY_PATH from all_directories;

--------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE DIRECTORY EXPORT AS '/exportdb/RORAIMAQ';
CREATE OR REPLACE DIRECTORY IMPORT AS '/exportdb/RORAIMAQ';


CREATE OR REPLACE DIRECTORY EXPORT AS '/exportdb/RORAIMAD';
CREATE OR REPLACE DIRECTORY IMPORT AS '/exportdb/RORAIMAD';

GRANT READ,WRITE ON DIRECTORY EXPORT TO SYSTEM;
GRANT READ,WRITE ON DIRECTORY IMPORT TO SYSTEM;

**************************************************************************************************************************************

EXPORT RORAIMAD 

vi EXPDP_RORAIMA.par

FULL=Y
LOGFILE=EXPORT:EXPDP_RORAIMA.log
DUMPFILE=EXPORT:EXPDP_RORAIMA.dmp
METRICS=Y
LOGTIME=ALL
EXCLUDE=STATISTICS, INDE
PARALLEL=2
CLUSTER=N

nohup expdp SYSTEM/oracle1 PARFILE=EXPDP_RORAIMA.par &

**************************************************************************************************************************************
IMPORT RORAIMAQ
Hacer Bk de la BD 

01_BACKUP_OFFLINE


ssh oracle19@CLPAGOFBD01.banvenqa.com

rman target /


 list backup summary;
 crosscheck backup;
 delete backup;
 list backup summary;


/exportdb/RORAIMAQ/BK_TABLESPACES_FULL

srvctl status database -d RORAIMAQ
srvctl stop database -d RORAIMAQ

rman target /

startup mount


run { 
allocate channel d1 type disk; 
allocate channel d2 type disk;
allocate channel d3 type disk;
allocate channel d4 type disk;
backup current controlfile
       tag RESP_CTL_RORAIMAQ_PREP
       format '/exportdb/RORAIMAQ/BK_TABLESPACES_FULL/Control_%d_%u_%s';
backup database
       filesperset 5
       tag RESP_DBF_RORAIMAQ_PREP
       format '/exportdb/RORAIMAQ/BK_TABLESPACES_FULL/datafiles_%d_%u_%s';  
backup spfile 
       format '/exportdb/RORAIMAQ/BK_TABLESPACES_FULL/SPfile_%d_%u_%s' 
       tag RESP_SPF_RORAIMAQ_PREP; 
release channel d1; 
release channel d2;
release channel d3;
release channel d4; 
}


shutdown immediate;

srvctl start database -d RORAIMAQ
--------------------------------------------------------------------------------------------------------------------------------------


vi IMPDP_SCHEMAS_RORAIMA.par

SCHEMAS=RORAIMA,RORAIMA_AUDITORIA
LOGFILE=IMPORT:IMPDP_RORAIMA.log
DUMPFILE=IMPORT:EXPDP_RORAIMA.dmp
METRICS=Y
LOGTIME=ALL
EXCLUDE=AUDIT_TRAILS
EXCLUDE=STATISTICS
PARALLEL=2
CLUSTER=N

nohup impdp SYSTEM/oracle1 PARFILE=IMPDP_SCHEMAS_RORAIMA.par &


**************************************************************************************************************************************


02.1.- Bajar Base de Datos 
	ORACLE:
srvctl status database -d RORAIMAQ
srvctl stop database -d RORAIMAQ


02.2.- Limpiar ASM
	GRID:
asmcmd
lsdg

	02.2.1 Limpiar +DATA_RORAIMAQ
	
		02.2.1.1 Borrar DATAFILE

cd +DATA_RORAIMA/RORAIMAQ/DATAFILE
pwd
rm *

		02.2.1.2 Borrar CONTROLFILE
	
cd +DATA_RORAIMA/RORAIMAQ/CONTROLFILE
pwd
rm *

		02.2.1.3 Borrar TEMFILE
	
cd +DATA_RORAIMA/RORAIMAQ/TEMPFILE
pwd
rm *


	02.2.2 Limpiar +FRA_RORAIMA/
		02.2.2.1  Borrar AUTOBACKUP

cd +FRA_RORAIMA/RORAIMAQ/AUTOBACKUP
pwd
rm *

		02.2.2.3 Borrar CONTROLFILE

cd +FRA_RORAIMA/RORAIMAQ/CONTROLFILE
pwd
rm *

	02.2.3 Limpiar +REDO01_RORAIMA / +REDO02_RORAIMA

		2.3.1 Borrar ONLINELOG REDO01_RORAIMA

cd +REDO01_RORAIMA/RORAIMAQ
rm -fr ONLINELOG 

		2.3.2 Borrar ONLINELOG REDO02_RORAIMA

cd +REDO02_RORAIMA/RORAIMAQ
rm -fr ONLINELOG

02.3.- Hacer RESTORE RMAN

	ORACLE:

	3.1 Entrar a RMAN
	
		rman target /


	3.1.1 Subir BD NO MOUNT

		startup nomount 

	3.1.2 Correr Restore del CONTROLFILE

		restore controlfile from '/exportdb/RORAIMAQ/BK_TABLESPACES_FULL/Control_RORAIMAQ_014jn8ku_1';

	3.1.3 Pasar BD a MOUNT

		alter database mount;

02.3.2 Correr Restore de DATAFILES

run {
allocate channel d1 type disk; 
allocate channel d2 type disk;
allocate channel d3 type disk;
allocate channel d4 type disk;
catalog start with '/exportdb/RORAIMAQ/BK_TABLESPACES_FULL/';
restore database;
recover database;
release channel d1; 
release channel d2;
release channel d3; 
release channel d4;
}


	02.3.2.1 Abrir BD

		alter database open resetlogs;
		



**************************************************************************************************************************************


BEGIN
  DBMS_AUDIT_MGMT.set_audit_trail_location(audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD, --this moves table AUD$ 
  audit_trail_location_value => 'DATA_AUDIT');

  DBMS_AUDIT_MGMT.set_audit_trail_location(audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_FGA_STD,--this moves table FGA_LOG$ 
  audit_trail_location_value => 'DATA_AUDIT');

  DBMS_AUDIT_MGMT.SET_AUDIT_TRAIL_LOCATION(AUDIT_TRAIL_TYPE => DBMS_AUDIT_MGMT.AUDIT_TRAIL_UNIFIED,
  AUDIT_TRAIL_LOCATION_VALUE => 'DATA_AUDIT');
END;  
/


TBS AUDITORIA 

CREATE TABLESPACE DATA_AUDIT
DATAFILE 
  '+DATA_RORAIMA' SIZE 670M AUTOEXTEND ON NEXT 670M MAXSIZE 32767M
LOGGING
FORCE LOGGING
DEFAULT 
  NO INMEMORY
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;


BEGIN
  DBMS_AUDIT_MGMT.SET_AUDIT_TRAIL_LOCATION(
    audit_trail_type            => DBMS_AUDIT_MGMT.AUDIT_TRAIL_UNIFIED,
    audit_trail_location_value  => 'DATA_AUDIT' -- O el tablespace 'DATA_AUDIT' que creamos
  );
END;
/

ALTER USER AUDSYS QUOTA UNLIMITED ON DATA_AUDIT;

SELECT partition_name, tablespace_name 
FROM dba_tab_partitions 
WHERE table_name = 'AUD$UNIFIED';


BEGIN
DBMS_AUDIT_MGMT.set_audit_trail_location(
audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_UNIFIED,
audit_trail_location_value => 'DATA_AUDIT');
END;
/


BEGIN
  DBMS_AUDIT_MGMT.SET_AUDIT_TRAIL_LOCATION(
    audit_trail_type            => DBMS_AUDIT_MGMT.AUDIT_TRAIL_UNIFIED,
    audit_trail_location_value  => 'DATA_AUDIT'
  );
END;
/

--channel d2: restoring datafile 00002 to +DATA/RORAIMAQ/DATAFILE/auditoria.275.1224328135

 Mover objetos de auditoria al tablespace separado 

BEGIN
DBMS_AUDIT_MGMT.set_audit_trail_location(
 audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_UNIFIED, --this moves table Unified Audit
 audit_trail_location_value => 'DATA_AUDIT');
END;
/