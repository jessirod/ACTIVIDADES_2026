-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
APIM_DB
SHARED_DB


vi parfile_esquema_APIM_DB.par


LOGFILE=EXPORT:EXPDP_SCHEMA_APIM_DB.log
DUMPFILE=EXPORT:EXPDP_SCHEMA_APIM_DB.dmp
SCHEMAS=APIM_DB
METRICS=Y
EXCLUDE=STATISTICS
PARALLEL=4
CLUSTER=N


********************

vi parfile_esquema_SHARED_DB.par


LOGFILE=EXPORT:EXPDP_SCHEMA_SHARED_DB.log
DUMPFILE=EXPORT:EXPDP_SCHEMA_SHARED_DB.dmp
SCHEMAS=SHARED_DB
METRICS=Y
EXCLUDE=STATISTICS
PARALLEL=4
CLUSTER=N

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

nohup expdp SYSTEM/bqsmt7aral8 PARFILE=parfile_esquema_SHARED_DB.par &

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DROP USER SHARED_DB CASCADE;
DROP USER APIM_DB CASCADE;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

MIGRACION




*********************************************************************
CREATE USER APIM_DB
  IDENTIFIED BY password
  DEFAULT TABLESPACE DATA_APIM_DB
  TEMPORARY TABLESPACE TEMP
  PROFILE APPS
  ACCOUNT UNLOCK;

-- 2 Roles for APIM_DB 
GRANT CONNECT TO APIM_DB;
GRANT RESOURCE TO APIM_DB;
ALTER USER APIM_DB DEFAULT ROLE ALL;

-- 2 Tablespace Quotas for APIM_DB 
ALTER USER APIM_DB QUOTA UNLIMITED ON DATA_APIM_DB;
ALTER USER APIM_DB QUOTA UNLIMITED ON INDEX_APIM_DB;

********************************************************************

ALTER USER APIM_DB IDENTIFIED BY values 'S:D8EF15F3355AA90FE4E86CD4928A000C9F318897AE7FC0C16B56251F065E;T:A9D74D0DE9F9C84302AC6E94DE2B0161669166A03DAF1AEB31F241D0E033AFB6488F8040BC9040D6BD759EDA35D2ECE1EF5780B1746FB16A3FB51665DA508704DE8C8627FA6B780BD8B86DC6ABD6657D';

********************************************************************

CREATE USER SHARED_DB
  IDENTIFIED BY password
  DEFAULT TABLESPACE DATA_SHARED_DB
  TEMPORARY TABLESPACE TEMP
  PROFILE APPS
  ACCOUNT UNLOCK;

-- 2 Roles for SHARED_DB 
GRANT CONNECT TO SHARED_DB;
GRANT RESOURCE TO SHARED_DB;
ALTER USER SHARED_DB DEFAULT ROLE ALL;

-- 2 Tablespace Quotas for SHARED_DB 
ALTER USER SHARED_DB QUOTA UNLIMITED ON DATA_SHARED_DB;
ALTER USER SHARED_DB QUOTA UNLIMITED ON INDEX_SHARED_DB;

********************************************************************

ALTER USER SHARED_DB IDENTIFIED BY values 'S:72AA7FF5191EB23E9DDD9E339F90966E9DCA9E2398FF47CAFB8B756325B7;T:3EE983D23CA9840AF5FE7ACE41E0AD9DE05255FF14B1527B681E1D9E62C84C1DADF386925BD6352653B3E1852C9714F7ABDB175B309B5133745986F7D3D0B06D80FDBB7971DFF592AF344549F5FC6E04';

********************************************************************




-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

vi parfile_esquema_APIM_DB.par

LOGFILE=MIGRACION:IMPDP_SCHEMA_APIM_DB.log
DUMPFILE=MIGRACION:EXPDP_SCHEMA_APIM_DB.dmp
SCHEMAS=APIM_DB
METRICS=Y
EXCLUDE=STATISTICS
LOGTIME=ALL
PARALLEL=8
CLUSTER=N

nohup impdp SYSTEM/oracle1 PARFILE=parfile_esquema_APIM_DB.par &

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

vi parfile_esquema_SHARED_DB.par

LOGFILE=MIGRACION:IMPDP_SCHEMA_SHARED_DB.log
DUMPFILE=MIGRACION:EXPDP_SCHEMA_SHARED_DB.dmp
SCHEMAS=SHARED_DB
METRICS=Y
LOGTIME=ALL
EXCLUDE=STATISTICS
PARALLEL=8
CLUSTER=N

nohup impdp SYSTEM/oracle1 PARFILE=parfile_esquema_SHARED_DB.par &





