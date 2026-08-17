***********************************************************************
EXPORT
***********************************************************************

vi exp_seniat_full_v1.par

DIRECTORY=EXPORT_BDTEMP
FULL=YES
LOGFILE=EXP_FULL_SENIAT_01.log
DUMPFILE=EXP_FULL_SENIAT_%U.dmp
METRICS=Y
EXCLUDE=PROCACT_SYSTEM,STATISTICS
EXCLUDE=TABLE:"='DBO.ITEM_DECLARACION'"
CLUSTER=N
PARALLEL=12
EXCLUDE=SCHEMA:"='REPOSITORIO'"
COMPRESSION=ALL


nohup expdp \' / as sysdba \' parfile=exp_seniat_full.par &
expdp \' / as sysdba \' ATTACH=SYS_EXPORT_SCHEMA_01




SELECT job_name, operation, state, degree, attached_sessions, 
       (SELECT count(*) FROM dba_objects WHERE status = 'VALID') -- Ejemplo de metadatos
FROM dba_datapump_jobs;

***********************************************************************
Que están haciendo los workers
***********************************************************************
SELECT sid, sql_id, event, p1text, p1, p2text, p2
FROM v$session
WHERE program LIKE '%DW%';

SELECT 
    job_name, 
    operation, 
    job_mode, 
    state, 
    degree, 
    attached_sessions
FROM dba_datapump_jobs
WHERE job_name = 'SYS_EXPORT_FULL_01';


SELECT owner, table_name 
FROM dba_tables 
WHERE table_name IN ('SYS_EXPORT_TABLE_02', 'SYS_EXPORT_TABLE_03');

DROP TABLE sys.SYS_EXPORT_TABLE_02 PURGE;
DROP TABLE sys.SYS_EXPORT_TABLE_03 PURGE;





--FLASHBACK_TIME=N


vi exp_seniat_schema_REPOSITORIO.par
 DIRECTORY=EXPORT_BDTEMP LOGFILE=EXP_schema_REPOSITORIO.log DUMPFILE=EXP_schema_REPOSITORIO_%U.dmp METRICS=Y EXCLUDE=PROCACT_SYSTEM,STATISTICS SCHEMAS=REPOSITORIO CLUSTER=N PARALLEL=5 COMPRESSION=ALL

exp_seniat_schema_REPOSITORIO.par


nohup expdp \' / as sysdba \' parfile=exp_seniat_schema_REPOSITORIO.par &


nohup expdp \' / as sysdba \' DIRECTORY=EXPORT_BDTEMP LOGFILE=EXP_schema_REPOSITORIO.log DUMPFILE=EXP_schema_REPOSITORIO_%U.dmp METRICS=Y EXCLUDE=PROCACT_SYSTEM,STATISTICS SCHEMAS=REPOSITORIO CLUSTER=N PARALLEL=5 COMPRESSION=ALL &


