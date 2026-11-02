 ssh oracle19@CLBDHPCPDOM01.banvenqa.com


------------------------------
 CONNECT TO DATABASE
------------------------------

 1. DOMICHQ      = dbdomichq
 2. DOMICQ       = dbdomicq
 3. PCPHQ        = dbpcphq
 4. PCPQ         = dbpcpq


******************************************************************
******************************************************************
PCPQ
******************************************************************
******************************************************************
export ORACLE_SID=PCPQ1
sqlplus / as sysdba

--------------------------------------------------------------------------------------------------------------------------------------

1. Tablespaces .- 
CREATE TABLESPACE DATA
DATAFILE SIZE 10M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED
LOGGING
DEFAULT 
  NO INMEMORY
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

--------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLESPACE INDX
DATAFILE SIZE 10M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED,
LOGGING
FORCE LOGGING
DEFAULT 
  NO INMEMORY
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

--------------------------------------------------------------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------------------------------------------------------------


CREATE USER PCP
  IDENTIFIED BY password
  DEFAULT TABLESPACE DATA
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

--------------------------------------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------



_DESACTIVAR_FLASHBACK_NOARCHIVELOG

 --FLASHBACK OFF
SELECT flashback_on FROM v$database;
ALTER DATABASE FLASHBACK OFF;

--------------------------------------------------------------------------------------------------------------------------------------

 --ARCHIVELOG DISABLED
 
srvctl stop DATABASE -d PAGOFP

sqlplus / as sysdba

startup mount;
alter database noarchivelog;
alter database open;
archive log list;

srvctl start DATABASE -d PAGOFP

--------------------------------------------------------------------------------------------------------------------------------------

create pfile='/home/oracle19/initPCPQ_jr.ora' from spfile;
--respaldar el pfile original.
--------------------------------------------------------------------------------------------------------------------------------------

_VERIFICAR_CREAR_DIRECTORY_ORIGEN_DESTINO

set pagesize 100
set linesize 400
col OWNER for a15
col DIRECTORY_NAME for a40
col DIRECTORY_PATH for a70
select OWNER, DIRECTORY_NAME, DIRECTORY_PATH from all_directories;

--------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE DIRECTORY MIGRACION AS '/migracion2/PCP_2026/';
GRANT READ,WRITE ON DIRECTORY MIGRACION TO SYSTEM;


--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
export NLS_DATE_FORMAT='DD-MON-RRRR HH24:MI:SS';

rman target /

list backup summary;
crosscheck backup;
delete backup;
list backup summary;

/exportdb/PCPQ/BK_TABLESPACES_FULL

srvctl status database -d PCPQ
srvctl stop database -d PCPQ

rman target /

startup mount

run { 
allocate channel d1 type disk; 
allocate channel d2 type disk;
allocate channel d3 type disk;
allocate channel d4 type disk;
backup current controlfile
       tag RESPALDO_CTL_PCPQ_LIMPIO_PREP
       format '/exportdb/PCPQ/BK_TABLESPACES_FULL/Control_%d_%u_%s';
backup database
       filesperset 5
       tag RESPALDO_DBF_PCPQ_LIMPIO_PREP
       format '/exportdb/PCPQ/BK_TABLESPACES_FULL/datafiles_%d_%u_%s';  
backup spfile 
       format '/exportdb/PCPQ/BK_TABLESPACES_FULL/SPfile_%d_%u_%s' 
       tag RESPALDO_SPF_PCPQ_LIMPIO_PREP; 
release channel d1; 
release channel d2;
release channel d3;
release channel d4;
}

shutdown immediate;

srvctl start database -d PCPQ

--srvctl status instance -d PCPQ -i PCPQ1

--------------------------------------------------------------------------------------------------------------------------------------

srvctl add service \
-db PCPQ \
-service PCPQ_APP \
-preferred PCPQ1,PCPQ2 \
-tafpolicy BASIC \
-failover_restore LEVEL1 \
-failovertype SELECT \
-failoverretry 3 \
-failoverdelay 10 \
-clbgoal LONG \
-notification TRUE \
-drain_timeout 180 \
-stopoption IMMEDIATE



srvctl start service -db PCPQ -service PCPQ_APP
srvctl status service -db PCPQ -service PCPQ_APP -verbose
--------------------------------------------------------------------------------------------------------------------------------------

cat <<EOF >> $ORACLE_HOME/network/admin/tnsnames.ora
PCPQ_APP_TAF =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = LX010QSCAN)(PORT = 1560))
    (TRANSPORT_CONNECT_TIMEOUT=3) (RETRY_COUNT=6)
    (LOAD_BALANCE = on)
    (FAILOVER=on)
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = PCPQ_APP)
      (FAILOVER_MODE =
         (TYPE = select)
         (METHOD = basic)
      )
    )
  )

EOF
******************************************************************
******************************************************************
PCPHQ
******************************************************************
******************************************************************

export ORACLE_SID=PCPHQ1
sqlplus / as sysdba

--------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLESPACE DATA
DATAFILE SIZE 10M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED
LOGGING
DEFAULT 
  NO INMEMORY
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

--------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLESPACE INDX
DATAFILE SIZE 10M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED,
LOGGING
FORCE LOGGING
DEFAULT 
  NO INMEMORY
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;
--------------------------------------------------------------------------------------------------------------------------------------

_DESACTIVAR_FLASHBACK_NOARCHIVELOG

 --FLASHBACK OFF
SELECT flashback_on FROM v$database;
ALTER DATABASE FLASHBACK OFF;

--------------------------------------------------------------------------------------------------------------------------------------

 --ARCHIVELOG DISABLED
 
srvctl stop DATABASE -d PCPHQ

sqlplus / as sysdba

startup mount;
alter database noarchivelog;
alter database open;
archive log list;

srvctl start DATABASE -d PCPHQ

--------------------------------------------------------------------------------------------------------------------------------------

create pfile='/home/oracle19/initPCPHQ_jr.ora' from spfile;
--respaldar el pfile original.
--------------------------------------------------------------------------------------------------------------------------------------

_VERIFICAR_CREAR_DIRECTORY_ORIGEN_DESTINO

set pagesize 100
set linesize 400
col OWNER for a15
col DIRECTORY_NAME for a40
col DIRECTORY_PATH for a70
select OWNER, DIRECTORY_NAME, DIRECTORY_PATH from all_directories;

--------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE DIRECTORY MIGRACION AS '/migracion2/PCP_2026/';
GRANT READ,WRITE ON DIRECTORY MIGRACION TO SYSTEM;


--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------------------------------------------------------------


CREATE USER PCP
  IDENTIFIED BY password
  DEFAULT TABLESPACE DATA
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


--falta la quota en los tbs indx

--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
export NLS_DATE_FORMAT='DD-MON-RRRR HH24:MI:SS';

rman target /

list backup summary;
crosscheck backup;
delete backup;
list backup summary;

/exportdb/PCPHQ/BK_TABLESPACES_FULL

srvctl status database -d PCPHQ
srvctl stop database -d PCPHQ

rman target /

startup mount

run { 
allocate channel d1 type disk; 
allocate channel d2 type disk;
allocate channel d3 type disk;
allocate channel d4 type disk;
backup current controlfile
       tag RESPALDO_CTL_PCPHQ_LIMPIO_PREP
       format '/exportdb/PCPHQ/BK_TABLESPACES_FULL/Control_%d_%u_%s';
backup database
       filesperset 5
       tag RESPALDO_DBF_PCPHQ_LIMPIO_PREP
       format '/exportdb/PCPHQ/BK_TABLESPACES_FULL/datafiles_%d_%u_%s';  
backup spfile 
       format '/exportdb/PCPHQ/BK_TABLESPACES_FULL/SPfile_%d_%u_%s' 
       tag RESPALDO_SPF_PCPHQ_LIMPIO_PREP; 
release channel d1; 
release channel d2;
release channel d3;
release channel d4;
}

shutdown immediate;

srvctl start database -d PCPHQ

--srvctl status instance -d PCPHQ -i PCPHQ1


--------------------------------------------------------------------------------------------------------------------------------------

srvctl add service \
-db PCPHQ \
-service PCPHQ_APP \
-preferred PCPHQ1,PCPHQ2 \
-tafpolicy BASIC \
-failover_restore LEVEL1 \
-failovertype SELECT \
-failoverretry 3 \
-failoverdelay 10 \
-clbgoal LONG \
-notification TRUE \
-drain_timeout 180 \
-stopoption IMMEDIATE




srvctl start service -db PCPHQ -service PCPHQ_APP
srvctl status service -db PCPHQ -service PCPHQ_APP -verbose
--------------------------------------------------------------------------------------------------------------------------------------

cat <<EOF >> $ORACLE_HOME/network/admin/tnsnames.ora


PCPHQ_APP_TAF =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = LX010QSCAN)(PORT = 1560))
    (TRANSPORT_CONNECT_TIMEOUT=3) (RETRY_COUNT=6)
    (LOAD_BALANCE = on)
    (FAILOVER=on)
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = PCPHQ_APP)
      (FAILOVER_MODE =
         (TYPE = select)
         (METHOD = basic)
      )
    )
  )

EOF

******************************************************************
******************************************************************
DOMICHQ
******************************************************************
******************************************************************

export ORACLE_SID=DOMICHQ1
sqlplus / as sysdba

--------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLESPACE DATA
DATAFILE SIZE 10M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED
LOGGING
DEFAULT 
  NO INMEMORY
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;
--------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLESPACE INDX
DATAFILE SIZE 10M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED,
LOGGING
FORCE LOGGING
DEFAULT 
  NO INMEMORY
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;
--------------------------------------------------------------------------------------------------------------------------------------

_DESACTIVAR_FLASHBACK_NOARCHIVELOG

 --FLASHBACK OFF
SELECT flashback_on FROM v$database;
ALTER DATABASE FLASHBACK OFF;

--------------------------------------------------------------------------------------------------------------------------------------

 --ARCHIVELOG DISABLED
 
srvctl stop DATABASE -d PAGOFP

sqlplus / as sysdba

startup mount;
alter database noarchivelog;
alter database open;
archive log list;

srvctl start DATABASE -d PAGOFP

--------------------------------------------------------------------------------------------------------------------------------------

create pfile='/home/oracle19/initDOMICHQ_jr.ora' from spfile;
--respaldar el pfile original.

--------------------------------------------------------------------------------------------------------------------------------------

_VERIFICAR_CREAR_DIRECTORY_ORIGEN_DESTINO

set pagesize 100
set linesize 400
col OWNER for a15
col DIRECTORY_NAME for a40
col DIRECTORY_PATH for a70
select OWNER, DIRECTORY_NAME, DIRECTORY_PATH from all_directories;

--------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE DIRECTORY MIGRACION AS '/migracion2/PCP_2026/';
GRANT READ,WRITE ON DIRECTORY MIGRACION TO SYSTEM;
--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------------------------------------------------------------

CREATE USER PCP_DOMIC
  IDENTIFIED BY password
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
ALTER USER PCP_DOMIC QUOTA UNLIMITED ON INDX;




--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
export NLS_DATE_FORMAT='DD-MON-RRRR HH24:MI:SS';

rman target /

list backup summary;
crosscheck backup;
delete backup;
list backup summary;

/exportdb/DOMICHQ/BK_TABLESPACES_FULL

srvctl status database -d DOMICHQ
srvctl stop database -d DOMICHQ

rman target /

startup mount

run { 
allocate channel d1 type disk; 
allocate channel d2 type disk;
allocate channel d3 type disk;
allocate channel d4 type disk;
backup current controlfile
       tag RESPALDO_CTL_DOMCHQ_LIMPIO_PREP
       format '/exportdb/DOMICHQ/BK_TABLESPACES_FULL/Control_%d_%u_%s';
backup database
       filesperset 5
       tag RESPALDO_DBF_DOMCHQ_LIMPIO_PREP
       format '/exportdb/DOMICHQ/BK_TABLESPACES_FULL/datafiles_%d_%u_%s';  
backup spfile 
       format '/exportdb/DOMICHQ/BK_TABLESPACES_FULL/SPfile_%d_%u_%s' 
       tag RESPALDO_SPF_DOMCHQ_LIMPIO_PREP; 
release channel d1; 
release channel d2;
release channel d3;
release channel d4;
}

shutdown immediate;

srvctl start database -d DOMICHQ

--srvctl status instance -d DOMICHQ -i DOMICHQ1

--------------------------------------------------------------------------------------------------------------------------------------

srvctl add service \
-db DOMICHQ \
-service DOMICHQ_APP \
-preferred DOMICHQ1,DOMICHQ2 \
-tafpolicy BASIC \
-failover_restore LEVEL1 \
-failovertype SELECT \
-failoverretry 3 \
-failoverdelay 10 \
-clbgoal LONG \
-notification TRUE \
-drain_timeout 180 \
-stopoption IMMEDIATE




srvctl start service -db DOMICHQ -service DOMICHQ_APP
srvctl status service -db DOMICHQ -service DOMICHQ_APP -verbose
--------------------------------------------------------------------------------------------------------------------------------------

cat <<EOF >> $ORACLE_HOME/network/admin/tnsnames.ora

DOMICHQ_TAF_TAF =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = LX010QSCAN)(PORT = 1560))
    (TRANSPORT_CONNECT_TIMEOUT=3) (RETRY_COUNT=6)
    (LOAD_BALANCE = on)
    (FAILOVER=on)
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = DOMICHQ_APP)
      (FAILOVER_MODE =
         (TYPE = select)
         (METHOD = basic)
      )
    )
  )

EOF
******************************************************************
******************************************************************
DOMICQ
******************************************************************
******************************************************************


export ORACLE_SID=DOMICQ1
sqlplus / as sysdba

--------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLESPACE DATA
DATAFILE SIZE 10M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED
LOGGING
DEFAULT 
  NO INMEMORY
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;
--------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLESPACE INDX
DATAFILE SIZE 10M AUTOEXTEND ON NEXT 2G MAXSIZE UNLIMITED,
LOGGING
FORCE LOGGING
DEFAULT 
  NO INMEMORY
ONLINE
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;
--------------------------------------------------------------------------------------------------------------------------------------

_DESACTIVAR_FLASHBACK_NOARCHIVELOG

 --FLASHBACK OFF
SELECT flashback_on FROM v$database;
ALTER DATABASE FLASHBACK OFF;

--------------------------------------------------------------------------------------------------------------------------------------
 --ARCHIVELOG DISABLED
 
srvctl stop DATABASE -d DOMICQ

sqlplus / as sysdba

startup mount;
alter database noarchivelog;
alter database open;
archive log list;

srvctl start DATABASE -d DOMICQ

--------------------------------------------------------------------------------------------------------------------------------------

create pfile='/home/oracle19/initDOMICQ_jr.ora' from spfile;
--respaldar el pfile original.
--------------------------------------------------------------------------------------------------------------------------------------

_VERIFICAR_CREAR_DIRECTORY_ORIGEN_DESTINO

set pagesize 100
set linesize 400
col OWNER for a15
col DIRECTORY_NAME for a40
col DIRECTORY_PATH for a70
select OWNER, DIRECTORY_NAME, DIRECTORY_PATH from all_directories;

--------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE DIRECTORY MIGRACION AS '/migracion2/PCP_2026/';
GRANT READ,WRITE ON DIRECTORY MIGRACION TO SYSTEM;

--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------------------------------------------------------------


CREATE USER PCP_DOMIC
  IDENTIFIED BY password
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
ALTER USER PCP_DOMIC QUOTA UNLIMITED ON INDX;


--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
export NLS_DATE_FORMAT='DD-MON-RRRR HH24:MI:SS';

rman target /

list backup summary;
crosscheck backup;
delete backup;
list backup summary;

/exportdb/DOMICQ/BK_TABLESPACES_FULL

srvctl status database -d DOMICQ
srvctl stop database -d DOMICQ

rman target /

startup mount

run { 
allocate channel d1 type disk; 
allocate channel d2 type disk;
allocate channel d3 type disk;
allocate channel d4 type disk;
backup current controlfile
       tag RESPALDO_CTL_DOMICQ_LIMPIO_PREP
       format '/exportdb/DOMICQ/BK_TABLESPACES_FULL/Control_%d_%u_%s';
backup database
       filesperset 5
       tag RESPALDO_DBF_DOMICQ_LIMPIO_PREP
       format '/exportdb/DOMICQ/BK_TABLESPACES_FULL/datafiles_%d_%u_%s';  
backup spfile 
       format '/exportdb/DOMICQ/BK_TABLESPACES_FULL/SPfile_%d_%u_%s' 
       tag RESPALDO_SPF_DOMICQ_LIMPIO_PREP; 
release channel d1; 
release channel d2;
release channel d3;
release channel d4;
}

shutdown immediate;

srvctl start database -d DOMICQ

--srvctl status instance -d DOMICQ -i DOMICQ1


--------------------------------------------------------------------------------------------------------------------------------------
srvctl add service \
-db DOMICQ \
-service DOMICQ_APP \
-preferred DOMICQ1,DOMICQ2 \
-tafpolicy BASIC \
-failover_restore LEVEL1 \
-failovertype SELECT \
-failoverretry 3 \
-failoverdelay 10 \
-clbgoal LONG \
-notification TRUE \
-drain_timeout 180 \
-stopoption IMMEDIATE

srvctl start service -db DOMICQ -service DOMICQ_APP
srvctl status service -db DOMICQ -service DOMICQ_APP -verbose
--------------------------------------------------------------------------------------------------------------------------------------

cat <<EOF >> $ORACLE_HOME/network/admin/tnsnames.ora


DOMICQQ_APP_TAF =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = LX010QSCAN)(PORT = 1560))
    (TRANSPORT_CONNECT_TIMEOUT=3) (RETRY_COUNT=6)
    (LOAD_BALANCE = on)
    (FAILOVER=on)
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = DOMICQ_APP)
      (FAILOVER_MODE =
         (TYPE = select)
         (METHOD = basic)
      )
    )
  )


EOF