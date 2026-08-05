EXPORT
ssh -legacy oracle12@sun2006p

Buenos dias,

En la importación de data se pueden ignorar las siguientes tablas.

PCP.AUDI_PROGRAMS
PCP.LOG
PCP_DOMIC.EN_PAY_HOME_MESSAGES_BK

EXCLUDE=TABLE:"IN ('LOG', 'AUDI_PROGRAMS')"
EXCLUDE=TABLE:"='NM36398'"

******************************************************************************************************************************************

_VERIFICAR_CREAR_DIRECTORY_ORIGEN_DESTINO

set pagesize 100
set linesize 400
col OWNER for a15
col DIRECTORY_NAME for a40
col DIRECTORY_PATH for a70
select OWNER, DIRECTORY_NAME, DIRECTORY_PATH from all_directories;


CREATE OR REPLACE DIRECTORY MIGRACION AS '/migracion2/PCP_restore2025';
GRANT READ,WRITE ON DIRECTORY MIGRACION TO SYSTEM;

/migracion2/PCP_restore2025

**************************************************************************************************************************************

Prueba para la verificación del espacio necesitado.
PARFILE
vi EXP_PCP_ESTIMATE.par

DIRECTORY=MIGRACION
SCHEMAS=PCP
EXCLUDE=TABLE:"IN ('LOG', 'AUDI_PROGRAMS')"
--DUMPFILE=EXP_FULL_PCP_ESTIMATE.dmp
ESTIMATE_ONLY=YES
CLUSTER=N
--EXCLUDE=AUDIT_TRAILS
EXCLUDE=STATISTICS
------------------------------------

nohup expdp SYSTEM/k3r3p4kup41 PARFILE=EXP_PCP_ESTIMATE.par &
expdp system/k3r3p4kup41 ATTACH=SYS_EXPORT_FULL_01
--Total estimation using BLOCKS method: 135.4 GB
--Job "SYSTEM"."SYS_EXPORT_SCHEMA_01" successfully completed at Mon Apr 27 10:51:04 2026 elapsed 0 00:00:13

PARFILE
vi EXP_PCP_DOMIC_ESTIMATE.par

DIRECTORY=MIGRACION
SCHEMAS=PCP_DOMIC
EXCLUDE=TABLE:"IN ('EN_PAY_HOME_MESSAGES_BK')"
--DUMPFILE=EXP_FULL_PCP_DOMIC_ESTIMATE.dmp
ESTIMATE_ONLY=YES
CLUSTER=N
--EXCLUDE=AUDIT_TRAILS
EXCLUDE=STATISTICS
------------------------------------

nohup expdp SYSTEM/k3r3p4kup41 PARFILE=EXP_PCP_DOMIC_ESTIMATE.par &
expdp system/k3r3p4kup41 ATTACH=SYS_EXPORT_FULL_01

**************************************************************************************************************************************

PARFILE_EXPORTS

vi EXP_SCHEMA_PCP.par

DIRECTORY=MIGRACION
SCHEMAS=PCP
LOGFILE=EXPORT_PCP.log
DUMPFILE=EXPORT_PCP_%T_%L.dmp
CLUSTER=N
PARALLEL=10
LOGTIME=ALL
EXCLUDE=TABLE:"IN ('LOG', 'AUDI_PROGRAMS')"
EXCLUDE=STATISTICS

nohup expdp SYSTEM/k3r3p4kup41 PARFILE=EXP_SCHEMA_PCP.par &
expdp system/k3r3p4kup41 ATTACH=SYS_EXPORT_FULL_01

*********************
**********************
BLOQUES CORRUPTOS
--27-APR-26 11:16:35.322: ORA-31693: Table data object "PCP"."STG_PROVIDER":"P1" failed to load/unload and is being skipped due to error:
--ORA-02354: error in exporting/importing data
--ORA-01578: ORACLE data block corrupted (file # 8, block # 153477)
--ORA-01110: data file 8: '+DG_DATA/PCP/DATAFILE/ts_entry.261.1231157717'
--ORA-26040: Data block was loaded using the NOLOGGING option
--
--27-APR-26 11:16:44.278: . . exported "PCP"."ORDEN_DETAIL"                        3.432 GB 27898665 rows
--27-APR-26 11:16:50.976: ORA-31693: Table data object "PCP"."STG_PROVIDER":"P3" failed to load/unload and is being skipped due to error:
--ORA-02354: error in exporting/importing data
--ORA-01578: ORACLE data block corrupted (file # 8, block # 151941)
--ORA-01110: data file 8: '+DG_DATA/PCP/DATAFILE/ts_entry.261.1231157717'
--ORA-26040: Data block was loaded using the NOLOGGING option
--
--27-APR-26 11:16:54.148: ORA-31693: Table data object "PCP"."STG_PROVIDER":"P6" failed to load/unload and is being skipped due to error:
--ORA-02354: error in exporting/importing data
--ORA-01578: ORACLE data block corrupted (file # 8, block # 151813)
--ORA-01110: data file 8: '+DG_DATA/PCP/DATAFILE/ts_entry.261.1231157717'
--ORA-26040: Data block was loaded using the NOLOGGING option
--
--27-APR-26 11:16:54.248: . . exported "PCP"."TORDEN_ALTA"                         256.4 KB     790 rows
--27-APR-26 11:16:58.936: . . exported "PCP"."BUSINESS_RULES"                      764.0 MB  206652 rows
--27-APR-26 11:17:06.229: ORA-31693: Table data object "PCP"."STG_PROVIDER":"P8" failed to load/unload and is being skipped due to error:
--ORA-02354: error in exporting/importing data
--ORA-01578: ORACLE data block corrupted (file # 8, block # 151557)
--ORA-01110: data file 8: '+DG_DATA/PCP/DATAFILE/ts_entry.261.1231157717'
--ORA-26040: Data block was loaded using the NOLOGGING option
--
--27-APR-26 11:17:06.294: . . exported "PCP"."MIX_NUMBER_ACCOUNTS"                 203.0 KB    2320 rows
--27-APR-26 11:17:18.188: ORA-31693: Table data object "PCP"."STG_PROVIDER":"P5" failed to load/unload and is being skipped due to error:
--ORA-02354: error in exporting/importing data
--ORA-01578: ORACLE data block corrupted (file # 8, block # 156549)
--ORA-01110: data file 8: '+DG_DATA/PCP/DATAFILE/ts_entry.261.1231157717'
--ORA-26040: Data block was loaded using the NOLOGGING option
--
--27-APR-26 11:17:18.377: ORA-31693: Table data object "PCP"."STG_PROVIDER":"P2" failed to load/unload and is being skipped due to error:
--ORA-02354: error in exporting/importing data
--ORA-01578: ORACLE data block corrupted (file # 8, block # 155397)
--ORA-01110: data file 8: '+DG_DATA/PCP/DATAFILE/ts_entry.261.1231157717'
--ORA-26040: Data block was loaded using the NOLOGGING option
--
--27-APR-26 11:17:18.435: . . exported "PCP"."CORRECT_NUMBER_ACCOUNTS"             160.0 KB    4524 rows
--27-APR-26 11:17:18.632: ORA-31693: Table data object "PCP"."STG_PROVIDER":"P7" failed to load/unload and is being skipped due to error:
--ORA-02354: error in exporting/importing data
--ORA-01578: ORACLE data block corrupted (file # 8, block # 152069)
--ORA-01110: data file 8: '+DG_DATA/PCP/DATAFILE/ts_entry.261.1231157717'
--ORA-26040: Data block was loaded using the NOLOGGING option
--
--27-APR-26 11:17:18.694: . . exported "PCP"."EXECUTIVE"                           125.6 KB    1299 rows
--27-APR-26 11:17:18.775: . . exported "PCP"."TRANSFER_ACCOUNTS"                   108.2 KB     680 rows
--27-APR-26 11:17:18.827: . . exported "PCP"."TMP_CTAS_COMISION_C"                 109.8 KB    2656 rows
--27-APR-26 11:17:18.991: ORA-31693: Table data object "PCP"."STG_PAYROLL":"PR7" failed to load/unload and is being skipped due to error:
--ORA-02354: error in exporting/importing data
--ORA-01578: ORACLE data block corrupted (file # 8, block # 153093)
--ORA-01110: data file 8: '+DG_DATA/PCP/DATAFILE/ts_entry.261.1231157717'
--ORA-26040: Data block was loaded using the NOLOGGING option
--
--27-APR-26 11:17:19.045: . . exported "PCP"."TEMPORAL_BANCA_2"                    94.01 KB    2666 rows
--27-APR-26 11:17:19.196: ORA-31693: Table data object "PCP"."STG_PAYROLL":"PR1" failed to load/unload and is being skipped due to error:
--ORA-02354: error in exporting/importing data
--ORA-01578: ORACLE data block corrupted (file # 8, block # 152965)
--ORA-01110: data file 8: '+DG_DATA/PCP/DATAFILE/ts_entry.261.1231157717'
--ORA-26040: Data block was loaded using the NOLOGGING option
--
--27-APR-26 11:17:19.351: ORA-31693: Table data object "PCP"."STG_PAYROLL":"PR6" failed to load/unload and is being skipped due to error:
--ORA-02354: error in exporting/importing data
--ORA-01578: ORACLE data block corrupted (file # 8, block # 151685)
--ORA-01110: data file 8: '+DG_DATA/PCP/DATAFILE/ts_entry.261.1231157717'
--ORA-26040: Data block was loaded using the NOLOGGING option
--
--27-APR-26 11:17:19.720: ORA-31693: Table data object "PCP"."STG_PROVIDER":"P4" failed to load/unload and is being skipped due to error:
--ORA-02354: error in exporting/importing data
--ORA-01578: ORACLE data block corrupted (file # 8, block # 152453)
--ORA-01110: data file 8: '+DG_DATA/PCP/DATAFILE/ts_entry.261.1231157717'
--ORA-26040: Data block was loaded using the NOLOGGING option
--
--27-APR-26 11:17:19.775: . . exported "PCP"."TMP_CTAS_COMISION_G"                 54.69 KB    1427 rows
--27-APR-26 11:17:19.892: ORA-31693: Table data object "PCP"."STG_PAYROLL":"PR3" failed to load/unload and is being skipped due to error:
--ORA-02354: error in exporting/importing data
--ORA-01578: ORACLE data block corrupted (file # 8, block # 152197)
--ORA-01110: data file 8: '+DG_DATA/PCP/DATAFILE/ts_entry.261.1231157717'
--ORA-26040: Data block was loaded using the NOLOGGING option
--
--27-APR-26 11:17:20.041: ORA-31693: Table data object "PCP"."STG_PAYROLL":"PR5" failed to load/unload and is being skipped due to error:
--ORA-02354: error in exporting/importing data
--ORA-01578: ORACLE data block corrupted (file # 8, block # 153221)
--ORA-01110: data file 8: '+DG_DATA/PCP/DATAFILE/ts_entry.261.1231157717'
--ORA-26040: Data block was loaded using the NOLOGGING option
--
--27-APR-26 11:17:20.170: ORA-31693: Table data object "PCP"."STG_PAYROLL":"PR2" failed to load/unload and is being skipped due to error:
--ORA-02354: error in exporting/importing data
--ORA-01578: ORACLE data block corrupted (file # 8, block # 152837)
--ORA-01110: data file 8: '+DG_DATA/PCP/DATAFILE/ts_entry.261.1231157717'
--ORA-26040: Data block was loaded using the NOLOGGING option
--
--27-APR-26 11:17:20.318: ORA-31693: Table data object "PCP"."STG_PAYROLL":"PR4" failed to load/unload and is being skipped due to error:
--ORA-02354: error in exporting/importing data
--ORA-01578: ORACLE data block corrupted (file # 8, block # 154117)
--ORA-01110: data file 8: '+DG_DATA/PCP/DATAFILE/ts_entry.261.1231157717'
--ORA-26040: Data block was loaded using the NOLOGGING option
--
--27-APR-26 11:17:20.467: ORA-31693: Table data object "PCP"."STG_PAYROLL":"PR8" failed to load/unload and is being skipped due to error:
--ORA-02354: error in exporting/importing data
--ORA-01578: ORACLE data block corrupted (file # 8, block # 152581)
--ORA-01110: data file 8: '+DG_DATA/PCP/DATAFILE/ts_entry.261.1231157717'
--ORA-26040: Data block was loaded using the NOLOGGING option


select count(1) from PCP.STG_PAYROLL;
select count(1) from PCP.STG_PROVIDER;
--no puede leerse la tabla

SELECT owner, segment_name, segment_type, partition_name
FROM dba_extents
WHERE file_id = 8
AND 153477 BETWEEN block_id AND block_id + blocks - 1;
--indica el datafile corrupto

col OWNER format a20
select OWNER, TABLE_NAME, LOGGING from dba_tables
where TABLE_NAME in ('STG_PAYROLL','STG_PROVIDER');

***************************
--Salta los bloques corruptos - puede hacer el count pero no hace el export
BEGIN
  DBMS_REPAIR.SKIP_CORRUPT_BLOCKS (
    SCHEMA_NAME => 'PCP',
    OBJECT_NAME => 'STG_PROVIDER',
    FLAGS       => DBMS_REPAIR.SKIP_FLAG
  );
END;
/

BEGIN
  DBMS_REPAIR.SKIP_CORRUPT_BLOCKS (
    SCHEMA_NAME => 'PCP',
    OBJECT_NAME => 'STG_PAYROLL',
    FLAGS       => DBMS_REPAIR.SKIP_FLAG
  );
END;
/

**********************************************************
--Otra solucion - mover las tablas

--Crear el tbs

CREATE TABLESPACE TS_ENTRY_NEW
DATAFILE 
  '+DG_DATA' SIZE 10G AUTOEXTEND ON NEXT 1G MAXSIZE 20G
LOGGING
DEFAULT 
  NO INMEMORY
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;


--SELECT 'ALTER TABLE ' || owner || '.' || table_name || ' MOVE TABLESPACE TS_ENTRY_NEW;'
--FROM dba_tables
--WHERE owner = 'PCP' 
--AND table_name = 'STG_PAYROLL';
--
--ALTER TABLE PCP.STG_PROVIDER MOVE TABLESPACE TS_ENTRY_NEW;
--ALTER TABLE PCP.STG_PAYROLL MOVE TABLESPACE TS_ENTRY_NEW;


SELECT 'ALTER TABLE ' || table_owner || '.' || table_name || 
       ' MOVE PARTITION ' || partition_name || ' TABLESPACE TS_ENTRY_NEW;'
FROM dba_tab_partitions
WHERE table_owner = 'PCP' AND table_name = 'STG_PAYROLL';


ALTER TABLE PCP.STG_PROVIDER MOVE PARTITION P1 TABLESPACE TS_ENTRY_NEW;
ALTER TABLE PCP.STG_PROVIDER MOVE PARTITION P2 TABLESPACE TS_ENTRY_NEW;
ALTER TABLE PCP.STG_PROVIDER MOVE PARTITION P3 TABLESPACE TS_ENTRY_NEW;
ALTER TABLE PCP.STG_PROVIDER MOVE PARTITION P4 TABLESPACE TS_ENTRY_NEW;
ALTER TABLE PCP.STG_PROVIDER MOVE PARTITION P5 TABLESPACE TS_ENTRY_NEW;
ALTER TABLE PCP.STG_PROVIDER MOVE PARTITION P6 TABLESPACE TS_ENTRY_NEW;
ALTER TABLE PCP.STG_PROVIDER MOVE PARTITION P7 TABLESPACE TS_ENTRY_NEW;
ALTER TABLE PCP.STG_PROVIDER MOVE PARTITION P8 TABLESPACE TS_ENTRY_NEW;


ALTER TABLE PCP.STG_PAYROLL MOVE PARTITION PR1 TABLESPACE TS_ENTRY_NEW;
ALTER TABLE PCP.STG_PAYROLL MOVE PARTITION PR2 TABLESPACE TS_ENTRY_NEW;
ALTER TABLE PCP.STG_PAYROLL MOVE PARTITION PR3 TABLESPACE TS_ENTRY_NEW;
ALTER TABLE PCP.STG_PAYROLL MOVE PARTITION PR4 TABLESPACE TS_ENTRY_NEW;
ALTER TABLE PCP.STG_PAYROLL MOVE PARTITION PR5 TABLESPACE TS_ENTRY_NEW;
ALTER TABLE PCP.STG_PAYROLL MOVE PARTITION PR6 TABLESPACE TS_ENTRY_NEW;
ALTER TABLE PCP.STG_PAYROLL MOVE PARTITION PR7 TABLESPACE TS_ENTRY_NEW;
ALTER TABLE PCP.STG_PAYROLL MOVE PARTITION PR8 TABLESPACE TS_ENTRY_NEW;

ALTER TABLE PCP.STG_PROVIDER MOVE PARTITION P1 TABLESPACE TS_ENTRY;
ALTER TABLE PCP.STG_PROVIDER MOVE PARTITION P2 TABLESPACE TS_ENTRY;
ALTER TABLE PCP.STG_PROVIDER MOVE PARTITION P3 TABLESPACE TS_ENTRY;
ALTER TABLE PCP.STG_PROVIDER MOVE PARTITION P4 TABLESPACE TS_ENTRY;
ALTER TABLE PCP.STG_PROVIDER MOVE PARTITION P5 TABLESPACE TS_ENTRY;
ALTER TABLE PCP.STG_PROVIDER MOVE PARTITION P6 TABLESPACE TS_ENTRY;
ALTER TABLE PCP.STG_PROVIDER MOVE PARTITION P7 TABLESPACE TS_ENTRY;
ALTER TABLE PCP.STG_PROVIDER MOVE PARTITION P8 TABLESPACE TS_ENTRY;


ALTER TABLE PCP.STG_PAYROLL MOVE PARTITION PR1 TABLESPACE TS_ENTRY;
ALTER TABLE PCP.STG_PAYROLL MOVE PARTITION PR2 TABLESPACE TS_ENTRY;
ALTER TABLE PCP.STG_PAYROLL MOVE PARTITION PR3 TABLESPACE TS_ENTRY;
ALTER TABLE PCP.STG_PAYROLL MOVE PARTITION PR4 TABLESPACE TS_ENTRY;
ALTER TABLE PCP.STG_PAYROLL MOVE PARTITION PR5 TABLESPACE TS_ENTRY;
ALTER TABLE PCP.STG_PAYROLL MOVE PARTITION PR6 TABLESPACE TS_ENTRY;
ALTER TABLE PCP.STG_PAYROLL MOVE PARTITION PR7 TABLESPACE TS_ENTRY;
ALTER TABLE PCP.STG_PAYROLL MOVE PARTITION PR8 TABLESPACE TS_ENTRY;

vi EXP_SCHEMA_PCP_tablas.par

DIRECTORY=MIGRACION
LOGFILE=EXPORT_PCP_tablas.log
DUMPFILE=EXPORT_PCP_tablas_%T_%L.dmp
CLUSTER=N
PARALLEL=10
LOGTIME=ALL
TABLES=PCP.STG_PROVIDER, PCP.STG_PAYROLL
EXCLUDE=STATISTICS


TABLES=esquema.tabla1, esquema.tabla2
nohup expdp SYSTEM/k3r3p4kup41 PARFILE=EXP_SCHEMA_PCP_tablas.par &
expdp system/k3r3p4kup41 ATTACH=SYS_EXPORT_FULL_01


***************************

vi EXP_SCHEMA_PCP_DOMIC.par
DIRECTORY=MIGRACION
SCHEMAS=PCP_DOMIC
EXCLUDE=TABLE:"IN ('EN_PAY_HOME_MESSAGES_BK')"
LOGFILE=EXPORT_PCP_DOMIC.log
DUMPFILE=EXPORT_PCP_DOMIC_%T_%L.dmp
CLUSTER=N
PARALLEL=10
METRICS=YES
LOGTIME=ALL
EXCLUDE=STATISTICS

nohup expdp SYSTEM/k3r3p4kup41 PARFILE=EXP_SCHEMA_PCP_DOMIC.par &
expdp system/k3r3p4kup41 ATTACH=SYS_EXPORT_FULL_01



***********************************************************************************************
***********************************************************************************************

IMPORT

_VERIFICAR_CREAR_DIRECTORY_ORIGEN_DESTINO

set pagesize 100
set linesize 400
col OWNER for a15
col DIRECTORY_NAME for a40
col DIRECTORY_PATH for a70
select OWNER, DIRECTORY_NAME, DIRECTORY_PATH from all_directories;


CREATE OR REPLACE DIRECTORY MIGRACION AS '/migracion2/PCP_restore2025';
GRANT READ,WRITE ON DIRECTORY MIGRACION TO SYSTEM;

/migracion2/PCP_restore2025


**********************************************************************

--CREATE TABLESPACE TS_USER
DATAFILE 
  '+DATA_PCP' SIZE 32767M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED
LOGGING
DEFAULT 
NO INMEMORY
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;


--CREATE TABLESPACE TS_TX
DATAFILE 
  '+DATA_PCP' SIZE 32767M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED,
  '+DATA_PCP' SIZE 32767M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED,
  '+DATA_PCP' SIZE 32767M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED,
  '+DATA_PCP' SIZE 32767M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED,
  '+DATA_PCP' SIZE 32767M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED,
  '+DATA_PCP' SIZE 32767M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED
LOGGING
DEFAULT 
  NO INMEMORY
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;



--CREATE TABLESPACE TS_HISTORY
DATAFILE 
  '+DATA_PCP' SIZE 32767M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED,
  '+DATA_PCP' SIZE 32767M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED,
  '+DATA_PCP' SIZE 32767M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED
LOGGING
DEFAULT 
  NO INMEMORY
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;




CREATE TABLESPACE TS_ENTRY_NEW
DATAFILE 
  '+DATA_PCP' SIZE 1G AUTOEXTEND ON NEXT 2G MAXSIZE 20G
LOGGING
DEFAULT 
  NO INMEMORY
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;


CREATE TABLESPACE TS_ENTRY
DATAFILE 
  '+DATA_PCP' SIZE 1G AUTOEXTEND ON NEXT 1G MAXSIZE 20G
LOGGING
DEFAULT 
  NO INMEMORY
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;


CREATE TABLESPACE INDX_USER
DATAFILE 
  '+DATA_PCP' SIZE 32767M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED
LOGGING
DEFAULT 
  NO INMEMORY
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;


CREATE TABLESPACE INDX_TX
DATAFILE 
  '+DATA_PCP' SIZE 20G AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED
LOGGING
DEFAULT 
  NO INMEMORY
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;


CREATE TABLESPACE INDX_HISTORY
DATAFILE 
  '+DATA_PCP' SIZE 32767M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED,
  '+DATA_PCP' SIZE 32767M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED,
  '+DATA_PCP' SIZE 32767M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED,
  '+DATA_PCP' SIZE 20G AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED
LOGGING
DEFAULT 
  NO INMEMORY
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

**********************************************************************
**********************************************************************


CREATE PROFILE APPS LIMIT
  SESSIONS_PER_USER 4000
  CPU_PER_SESSION DEFAULT
  CPU_PER_CALL DEFAULT
  CONNECT_TIME UNLIMITED
  IDLE_TIME UNLIMITED
  LOGICAL_READS_PER_SESSION DEFAULT
  LOGICAL_READS_PER_CALL DEFAULT
  COMPOSITE_LIMIT DEFAULT
  PRIVATE_SGA DEFAULT
  FAILED_LOGIN_ATTEMPTS 10
  INACTIVE_ACCOUNT_TIME DEFAULT
  PASSWORD_LIFE_TIME UNLIMITED
  PASSWORD_REUSE_TIME UNLIMITED
  PASSWORD_REUSE_MAX 20
  PASSWORD_LOCK_TIME UNLIMITED
  PASSWORD_GRACE_TIME UNLIMITED
  PASSWORD_VERIFY_FUNCTION NULL;

**********************************************************************


CREATE USER PCP
  IDENTIFIED BY password
  DEFAULT TABLESPACE TS_USER
  TEMPORARY TABLESPACE TEMP
  PROFILE APPS
  ACCOUNT UNLOCK;

-- 18 System Privileges for PCP 
GRANT ALTER SESSION TO PCP;
GRANT ALTER TABLESPACE TO PCP;
GRANT CREATE DATABASE LINK TO PCP;
GRANT CREATE MATERIALIZED VIEW TO PCP;
GRANT CREATE PROCEDURE TO PCP;
GRANT CREATE PUBLIC SYNONYM TO PCP;
GRANT CREATE ROLE TO PCP;
GRANT CREATE SEQUENCE TO PCP;
GRANT CREATE SESSION TO PCP;
GRANT CREATE SYNONYM TO PCP;
GRANT CREATE TABLE TO PCP;
GRANT CREATE TABLESPACE TO PCP;
GRANT CREATE TRIGGER TO PCP;
GRANT CREATE TYPE TO PCP;
GRANT CREATE VIEW TO PCP;
GRANT EXECUTE ANY PROCEDURE TO PCP;
GRANT SELECT ANY TABLE TO PCP;
GRANT UNLIMITED TABLESPACE TO PCP;

**********************************************************************


vi IMP_SCHEMA_PCP.par


DIRECTORY=MIGRACION
SCHEMAS=PCP
LOGFILE=IMP_SCHEMA_PCP.LOG
DUMPFILE=EXPORT_PCP_20260427_%L.dmp
PARALLEL=4
LOGTIME=ALL



nohup impdp SYSTEM/k3r3p4kup41 PARFILE=IMP_SCHEMA_PCP.par &
impdp SYSTEM/oracle1 ATTACH=SYS_IMPORT_SCHEMA_01
**********************************************************************

PCP                            ADD_AUDI_PROGRAM                                   INVALID ALTER PROCEDURE PCP.ADD_AUDI_PROGRAM COMPILE;
PCP                            ADD_ORDEN_FROM_FRONT_3                             INVALID ALTER PROCEDURE PCP.ADD_ORDEN_FROM_FRONT_3 COMPILE;
PCP                            CAMBIO_SERIAL_REINTEGRO                            INVALID ALTER PROCEDURE PCP.CAMBIO_SERIAL_REINTEGRO COMPILE;
PCP                            CANCEL_ORDEN_DATE_VALUE                            INVALID ALTER PROCEDURE PCP.CANCEL_ORDEN_DATE_VALUE COMPILE;
PCP                            GEN_FILES_OPS                                      INVALID ALTER PROCEDURE PCP.GEN_FILES_OPS COMPILE;
PCP                            GEN_FILES_OPS_DIVISA                               INVALID ALTER PROCEDURE PCP.GEN_FILES_OPS_DIVISA COMPILE;
PCP                            GEN_FILES_OPS_EXCLUSIVA                            INVALID ALTER PROCEDURE PCP.GEN_FILES_OPS_EXCLUSIVA COMPILE;
PCP                            MOVE_PAYROLL_TO_TXMODEL                            INVALID ALTER PROCEDURE PCP.MOVE_PAYROLL_TO_TXMODEL COMPILE;
PCP                            MOVE_PAYROLL_TO_TXMODEL_C                          INVALID ALTER PROCEDURE PCP.MOVE_PAYROLL_TO_TXMODEL_C COMPILE;
PCP                            MOVE_PROVIDER_TO_TXMODEL                           INVALID ALTER PROCEDURE PCP.MOVE_PROVIDER_TO_TXMODEL COMPILE;
PCP                            MOVE_PROVIDER_TO_TXMODEL_C                         INVALID ALTER PROCEDURE PCP.MOVE_PROVIDER_TO_TXMODEL_C COMPILE;
PCP                            MOVE_PROVIDER_TO_TXMODEL_EDI                       INVALID ALTER PROCEDURE PCP.MOVE_PROVIDER_TO_TXMODEL_EDI COMPILE;
PCP                            MOVE_PROVIDER_TO_TXMODEL_FIDEC                     INVALID ALTER PROCEDURE PCP.MOVE_PROVIDER_TO_TXMODEL_FIDEC COMPILE;
PCP                            MOVE_PROVIDER_TO_TXMODEL_ZTE                       INVALID ALTER PROCEDURE PCP.MOVE_PROVIDER_TO_TXMODEL_ZTE COMPILE;
PCP                            RETRY_COMMISSION_FORHOST                           INVALID ALTER PROCEDURE PCP.RETRY_COMMISSION_FORHOST COMPILE;
PCP                            UPDATE_ACOUNT_NUMBER_PN_COMISION                   INVALID ALTER PROCEDURE PCP.UPDATE_ACOUNT_NUMBER_PN_COMISION COMPILE;
PCP                            UPDATE_ACOUNT_NUMBER_PP_COMISION                   INVALID ALTER PROCEDURE PCP.UPDATE_ACOUNT_NUMBER_PP_COMISION COMPILE;
PCP                            UPDATE_ACOUNT_NUMBER_PP_COMISION_2                 INVALID ALTER PROCEDURE PCP.UPDATE_ACOUNT_NUMBER_PP_COMISION_2 COMPILE;
PCP                            UPDATE_ACOUN_NUM_PP_COMISION_2                     INVALID ALTER PROCEDURE PCP.UPDATE_ACOUN_NUM_PP_COMISION_2 COMPILE;
PCP                            UPDATE_RESP_CCE_V2                                 INVALID ALTER PROCEDURE PCP.UPDATE_RESP_CCE_V2 COMPILE;
PCP                            UPDATE_STATUS_BY_ORDER                             INVALID ALTER PROCEDURE PCP.UPDATE_STATUS_BY_ORDER COMPILE;

21 rows selected.

SQL> ALTER PROCEDURE PCP.ADD_AUDI_PROGRAM COMPILE;

Warning: Procedure altered with compilation errors.

SQL> show errors
Errors for PROCEDURE PCP.ADD_AUDI_PROGRAM:

LINE/COL ERROR
-------- -----------------------------------------------------------------
11/1     PL/SQL: SQL Statement ignored
11/13    PL/SQL: ORA-00942: table or view does not exist


SET LONG 500000;
set pagesize 5000
SELECT DBMS_METADATA.GET_DDL('PROCEDURE', 'GET_EXCLUSIVE_CH_CUSTOMER', 'PCP') FROM DUAL;



--- Los objetos quedaron invalidos porque utilizan una de las tablas que se excluyeron del import por la solicitud realizada por la sra. Amarilis.
--LOG
******************************************

PCP_DOMIC

--sdai    500G root  disk  brw-rw----
--sdaj    500G root  disk  brw-rw----
--sdak    500G root  disk  brw-rw----
--sdal    500G root  disk  brw-rw----
--sdam    500G root  disk  brw-rw----
--sdan    500G root  disk  brw-rw----
--sdao    500G root  disk  brw-rw----
--sdap    500G root  disk  brw-rw----
--
--
--echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/


echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/sdai
echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/sdaj
echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/sdak
echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/sdal
echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/sdam
echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/sdan
echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/sdao
echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/sdap


/usr/sbin/oracleasm createdisk DATA_PAGOF_001 /dev/mapper/asm_62p1


lsblk -fms
DATA_DOMIC_001



/usr/sbin/oracleasm createdisk DATA_DOMIC_01 /dev/sdai1
/usr/sbin/oracleasm createdisk DATA_DOMIC_02 /dev/sdaj1
/usr/sbin/oracleasm createdisk DATA_DOMIC_03 /dev/sdak1
/usr/sbin/oracleasm createdisk DATA_DOMIC_04 /dev/sdal1
/usr/sbin/oracleasm createdisk DATA_DOMIC_05 /dev/sdam1
/usr/sbin/oracleasm createdisk DATA_DOMIC_06 /dev/sdan1
/usr/sbin/oracleasm createdisk DATA_DOMIC_07 /dev/sdao1
/usr/sbin/oracleasm createdisk DATA_DOMIC_08 /dev/sdap1


*************************************

Borrar y crear esquema pcp_domic

DROP USER PCP_DOMIC CASCADE;

CREATE USER PCP_DOMIC
  IDENTIFIED BY password
  HTTP DIGEST DISABLE
  DEFAULT TABLESPACE DATA
  TEMPORARY TABLESPACE TEMP
  PROFILE APPS
  ACCOUNT UNLOCK;

-- 9 System Privileges for PCP_DOMIC 
GRANT CREATE MATERIALIZED VIEW TO PCP_DOMIC;
GRANT CREATE PROCEDURE TO PCP_DOMIC;
GRANT CREATE SEQUENCE TO PCP_DOMIC;
GRANT CREATE SESSION TO PCP_DOMIC;
GRANT CREATE SYNONYM TO PCP_DOMIC;
GRANT CREATE TABLE TO PCP_DOMIC;
GRANT CREATE TRIGGER TO PCP_DOMIC;
GRANT CREATE TYPE TO PCP_DOMIC;
GRANT CREATE VIEW TO PCP_DOMIC;

-- 3 Tablespace Quotas for PCP_DOMIC 
ALTER USER PCP_DOMIC QUOTA UNLIMITED ON DATA;
ALTER USER PCP_DOMIC QUOTA UNLIMITED ON INDX_PCP;
ALTER USER PCP_DOMIC QUOTA UNLIMITED ON LOGS_PAYHOME;

*************************************

ALTER TABLESPACE DATA ADD DATAFILE '+DATA_DOMIC' SIZE 32767M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED;

*************************************

ALTER TABLESPACE INDX_PCP ADD DATAFILE '+DATA_DOMIC' SIZE 32767M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED;

*************************************




_VERIFICAR_CREAR_DIRECTORY_ORIGEN_DESTINO

set pagesize 100
set linesize 400
col OWNER for a15
col DIRECTORY_NAME for a40
col DIRECTORY_PATH for a70
select OWNER, DIRECTORY_NAME, DIRECTORY_PATH from all_directories;


CREATE OR REPLACE DIRECTORY MIGRACION AS '/migracion2/PCP_restore2025';
GRANT READ,WRITE ON DIRECTORY MIGRACION TO SYSTEM;

/migracion2/PCP_restore2025

*************************************



vi IMP_SCHEMA_PCP_DOMIC.par


DIRECTORY=MIGRACION
SCHEMAS=PCP_DOMIC
LOGFILE=IMP_SCHEMA_PCP_DOMIC.LOG
DUMPFILE=EXPORT_PCP_DOMIC_20260427_%L.dmp
PARALLEL=4
LOGTIME=ALL



nohup impdp SYSTEM/oracle1 PARFILE=IMP_SCHEMA_PCP_DOMIC.par &
impdp SYSTEM/oracle1 ATTACH=SYS_IMPORT_SCHEMA_01







N1
BAnc0#03T8WA

N2 
QTR82$frdg974L

















