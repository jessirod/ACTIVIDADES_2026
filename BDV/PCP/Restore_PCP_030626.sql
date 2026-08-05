RESTORE 030625

********************************************************************************************************************************************
Se crea el init.ora basado en la instancia original
********************************************************************************************************************************************

vi initPCP.ora

*.__data_transfer_cache_size=0
PCP.__data_transfer_cache_size=0
*.__db_cache_size=40G
PCP.__db_cache_size=107105746944
*.__inmemory_ext_roarea=0
PCP.__inmemory_ext_roarea=0
*.__inmemory_ext_rwarea=0
PCP.__inmemory_ext_rwarea=0
*.__java_pool_size=896M
PCP.__java_pool_size=1610612736
*.__large_pool_size=384M
PCP.__large_pool_size=268435456
*.__oracle_base='/oracle/app/oracle12'# ORACLE_BASE set from environment
*.__pga_aggregate_target=2304M
PCP.__pga_aggregate_target=42949672960
*.__sga_target=46848M
PCP.__sga_target=118111600640
*.__shared_io_pool_size=128M
PCP.__shared_io_pool_size=268435456
*.__shared_pool_size=4224M
PCP.__shared_pool_size=8053063680
*.__streams_pool_size=128M
PCP.__streams_pool_size=536870912
PCP._ash_enable=TRUE
PCP._bsln_adaptive_thresholds_enabled=TRUE
PCP._column_tracking_level=21
PCP._cursor_bind_capture_area_size=400
PCP._dbop_enabled=1
PCP._disable_streams_pool_auto_tuning=FALSE
PCP._disable_txn_alert=0
PCP._dml_monitoring_enabled=TRUE
PCP._enable_automatic_maintenance=1
PCP._gc_cpu_time=TRUE
PCP._gc_statistics='TRUE'
PCP._io_statistics=TRUE
PCP._library_cache_advice=TRUE
PCP._longops_enabled=TRUE
PCP._object_statistics=TRUE
PCP._olap_row_load_time_precision='DEFAULT'
PCP._rowsource_execution_statistics=TRUE
PCP._rowsource_profiling_statistics=TRUE
PCP._smm_advice_enabled=TRUE
PCP._sqlmon_threshold=5
PCP._threshold_alerts_enable=1
PCP._timemodel_collection=TRUE
PCP._ultrafast_latch_statistics=TRUE
*.audit_file_dest='/oracle/app/oracle12/admin/PCP/adump'
*.audit_trail='DB','EXTENDED'
*.backup_tape_io_slaves=FALSE
*.compatible='12.2.0'
*.connection_brokers='((TYPE=DEDICATED)(BROKERS=1))','((TYPE=EMON)(BROKERS=1))'# connection_brokers default value
## *.control_files='+DG_REDO1/PCP/CONTROLFILE/current.256.1018885357','+DG_REDO2/PCP/CONTROLFILE/current.256.1018885357','+DG_REDO3/PCP/CONTROLFILE/current.256.1018885357'
*.core_dump_dest='/oracle/app/oracle12/diag/rdbms/pcp/PCP/cdump'
*.db_block_size=8192
PCP.db_cache_advice='ON'
*.db_cache_size=0
*.db_create_file_dest='+DG_DATA'
*.db_create_online_log_dest_1='+REDO1'
*.db_create_online_log_dest_2='+REDO2'
*.db_domain='BANVENEZ.CORP'
*.db_files=1000
*.db_name='PCP'
*.db_recovery_file_dest='+FRA'
*.db_recovery_file_dest_size=429496729600
*.diagnostic_dest='/oracle/app/oracle12'
*.dispatchers='(PROTOCOL=TCP) (SERVICE=PCPXDB)'
*.enable_ddl_logging=TRUE
*.fast_start_mttr_target=300
*.java_pool_size=0
*.job_queue_processes=0
*.large_pool_size=0
## *.local_listener='(ADDRESS=(PROTOCOL=TCP)(HOST=sun2317p)(PORT=1560))'
*.log_archive_dest_1='LOCATION=USE_DB_RECOVERY_FILE_DEST valid_for=(ALL_LOGFILES,ALL_ROLES) MAX_FAILURE=1 REOPEN=5 DB_UNIQUE_NAME=PCP ALTERNATE=LOG_ARCHIVE_DEST_3'
*.log_archive_dest_3='LOCATION=+DG_DATA'
*.log_archive_dest_state_3='ALTERNATE'
*.log_archive_format='%t_%s_%r.dbf'
*.log_buffer=98728K# log buffer update
*.memory_max_target=150G
*.memory_target=150G
*.nls_language='AMERICAN'
*.nls_territory='AMERICA'
*.open_cursors=300
*.optimizer_dynamic_sampling=2
*.optimizer_mode='ALL_ROWS'
*.parallel_max_servers=160
*.parallel_servers_target=256
*.pga_aggregate_target=34359738368
*.plsql_warnings='DISABLE:ALL'# PL/SQL warnings at init.ora
*.processes=10000
*.query_rewrite_enabled='TRUE'
*.remote_login_passwordfile='EXCLUSIVE'
*.result_cache_max_size=23616K
*.session_cached_cursors=100
*.sessions=15040
*.sga_max_size=118111600640
*.sga_target=118111600640
*.shared_pool_size=2304M
*.skip_unusable_indexes=TRUE
*.statistics_level='ALL'
*.streams_pool_size=0
PCP.timed_os_statistics=60
PCP.timed_statistics=TRUE
*.transactions=12105
*.undo_tablespace='UNDOTBS1'
*.workarea_size_policy='AUTO'


********************************************************************************************************************************************
Iniciar la BD en mount con el pfile
********************************************************************************************************************************************

startup nomount pfile='/export/home/oracle12/initPCP.ora';

********************************************************************************************************************************************
Se crea el spfile a partir del pfile
********************************************************************************************************************************************

create spfile='+DG_DATA' from pfile='/export/home/oracle12/initPCP.ora';

********************************************************************************************************************************************
Se modifica el archivo spfile - 
********************************************************************************************************************************************
Modificamos el init para que solo apunte al spfile, borramos el contenido y colocamos la siguiente linea:

vi initPCP.ora
spfile='+DG_DATA/PCP/PARAMETERFILE/spfile.256.1231078955'

********************************************************************************************************************************************
********************************************************************************************************************************************
5.-Le seteamos los parametros del control file al spfile, importante multiplexarlo.
alter system set control_files='+DG_DATA','+FRA' scope=spfile;
--Bajamos la BD y hacemos nomount nuevamente
startup nomount;


Setearse a rman y buscar los controlfile del dia especifico que quieras restaurar, es preferible usar el ultimo control del día.

--Seteo
rman target / catalog rmanp/rmanexport@RMAN12
set dbid 2447070573
export NLS_DATE_FORMAT='DD-MON-RRRR HH24:MI:SS';
---Sirven para listar todos los backups
list backup summary;
list backup;
---Se le especifica el rango de la fecha.
--list backup summary completed between "to_date('01/03/2023','DD/MM/YYYY')" and "to_date('20/04/2023','DD/MM/YYYY')";
list backup of database completed between "to_date('01/03/2026','DD/MM/YYYY')" and "to_date('30/03/2026','DD/MM/YYYY')";
LIST BACKUP OF CONTROLFILE COMPLETED BETWEEN  "to_date('01/03/2026','DD/MM/YYYY')" AND "to_date('30/03/2026','DD/MM/YYYY')";
---Identificar la fecha y el control mas reciente de ese para que la BD pueda abrir sin problemas.




********************************************************************************************************************************************
********************************************************************************************************************************************

send 'SBT_PARMS=(NSR_SERVER=cpprwnetworkerp,NSR_STORAGE_NODE=plsnwk01,NSR_DATA_VOLUME_POOL=PCP_ONL_MENSUAL,NSR_CLIENT=sun2317p)';



7.-Validar Datafile a Restaurar

RMAN> report schema;
-- NOTA: Esta procedimiento es necesario, para conocer el nombre que poseeia el DISKGROUP, y por consecuente 
-- crear los diskgroups con el mismo nombre que aparecen en el catalogo.

********************************************************************************************************************************************
********************************************************************************************************************************************
8.-Restauracion de ControlFile.

--Ultimo autobackup del control file
RUN
{
    ALLOCATE CHANNEL ch1 DEVICE TYPE sbt_tape ;
	send 'SBT_PARMS=(NSR_SERVER=cpprwnetworkerp,NSR_STORAGE_NODE=plsnwk01,NSR_DATA_VOLUME_POOL=PCP_ONL_MENSUAL,NSR_CLIENT=sun2317p)';
    RESTORE CONTROLFILE FROM AUTOBACKUP
    UNTIL TIME "to_date('06-MAR-2025 00:00:00','dd-mon-yyyy hh24:mi:ss')";
    RELEASE CHANNEL ch1;
}


--RMAN> RUN
--{
--    ALLOCATE CHANNEL ch1 DEVICE TYPE sbt_tape ;
--        send 'SBT2> 3> 4> _PARMS=(NSR_SERVER=cpprwnetworkerp,NSR_STORAGE_NODE=plsnwk01,NSR_DATA_VOLUME_POOL=PCP_ONL_MENSUAL,NSR_CLIENT=sun2317p)';
--    RESTORE CONTROLFILE FROM AUTOBACKUP5>
--    UNTIL TIME "to_date('06-MAR-2025 00:00:00','dd-mon-yyyy hh26> 4:mi:ss')";
--    RELEASE CHANNEL ch1;
--}7> 8>
--
--allocated channel: ch1
--channel ch1: SID=3765 device type=SBT_TAPE
--channel ch1: NMDA Oracle v19.2.1.3
--
--sent command to channel: ch1
--
--Starting restore at 20-APR-2026 15:10:56
--
--channel ch1: looking for AUTOBACKUP on day: 20250306
--channel ch1: AUTOBACKUP found: c-2447070573-20250306-00
--channel ch1: restoring control file from AUTOBACKUP c-2447070573-20250306-00
--
--
--channel ch1: control file restore from AUTOBACKUP complete
--output file name=+DG_DATA/PCP/CONTROLFILE/current.257.1231083601
--output file name=+FRA/PCP/CONTROLFILE/current.256.1231083611
--Finished restore at 20-APR-2026 15:40:18
--
--released channel: ch1



********************************************************************************************************************************************
Montar la BD.
********************************************************************************************************************************************

---Una vez restaurado los control file se debe montar la BD
shutdown immediate;
startup mount;

********************************************************************************************************************************************
Restauracion de los datafiles
********************************************************************************************************************************************

export NLS_DATE_FORMAT='DD-MON-RRRR HH24:MI:SS';

--Conectarse a otra sesion con Oracle y abrir rman (Sin el Catalogo)

rman target /
List backup summary;

---En otra pestaña iniciar la restauracion de datafiles

RUN
{
    allocate channel ch1 device type sbt_tape ;
    allocate channel ch2 device type sbt_tape ;
    allocate channel ch3 device type sbt_tape ;
    allocate channel ch4 device type sbt_tape ;
    SET UNTIL TIME "to_date('06-MAR-2025 15:46:07','dd-mm-yyyy hh24:mi:ss')";
	send 'SBT_PARMS=(NSR_SERVER=cpprwnetworkerp,NSR_STORAGE_NODE=plsnwk01,NSR_DATA_VOLUME_POOL=PCP_ONL_MENSUAL,NSR_CLIENT=sun2317p)';
    RESTORE database;
    release channel ch1 ;
    release channel ch2 ;
    release channel ch3 ;
    release channel ch4 ;
}


********************************************************************************************************************************************

********************************************************************************************************************************************
Verificar 

SELECT COUNT(1)
, ERROR
, TIME
FROM V$RECOVER_FILE
GROUP BY ERROR,TIME;

--  COUNT(1) ERROR                                                             TIME
------------ ----------------------------------------------------------------- --------------------
--        11                                                                   06-mar-2025 13:40:06
--         2                                                                   06-mar-2025 13:42:41
--         1                                                                   06-mar-2025 13:42:48
--         1                                                                   06-mar-2025 13:44:24
--         2                                                                   06-mar-2025 13:45:19
--         1                                                                   06-mar-2025 13:45:26
--         1                                                                   06-mar-2025 13:47:11
--         1                                                                   06-mar-2025 13:47:46
--         1                                                                   06-mar-2025 13:48:02
--         1                                                                   06-mar-2025 13:48:37
--         1                                                                   06-mar-2025 13:49:32
--         1                                                                   06-mar-2025 13:50:07
--         1                                                                   06-mar-2025 13:50:22
--         1                                                                   06-mar-2025 13:50:57
--         1                                                                   06-mar-2025 13:51:53
--         1                                                                   06-mar-2025 13:52:28
--         1                                                                   06-mar-2025 13:52:43
--         1                                                                   06-mar-2025 13:53:18
--         1                                                                   06-mar-2025 13:54:13
--         1                                                                   06-mar-2025 13:54:48
--         1                                                                   06-mar-2025 13:55:04
--         1                                                                   06-mar-2025 13:55:39
--         1                                                                   06-mar-2025 13:56:44
--         1                                                                   06-mar-2025 13:57:19
--         1                                                                   06-mar-2025 13:57:26
--         1                                                                   06-mar-2025 13:58:02
--         1                                                                   06-mar-2025 13:59:07
--         1                                                                   06-mar-2025 13:59:42
--         1                                                                   06-mar-2025 13:59:49
--         1                                                                   06-mar-2025 14:00:34
--         1                                                                   06-mar-2025 14:01:29
--         2                                                                   06-mar-2025 14:02:15
--         1                                                                   06-mar-2025 14:03:00
--         1                                                                   06-mar-2025 14:03:55
--         2                                                                   06-mar-2025 14:04:40
--         1                                                                   06-mar-2025 14:05:26
--         1                                                                   06-mar-2025 14:06:21
--         2                                                                   06-mar-2025 14:07:06
--         1                                                                   06-mar-2025 14:07:51
--         1                                                                   06-mar-2025 14:08:46
--         2                                                                   06-mar-2025 14:09:32
--         1                                                                   06-mar-2025 14:10:17
--         1                                                                   06-mar-2025 14:11:12
--         2                                                                   06-mar-2025 14:11:57
--         1                                                                   06-mar-2025 14:12:43
--         1                                                                   06-mar-2025 14:13:38
--         2                                                                   06-mar-2025 14:14:23
--         1                                                                   06-mar-2025 14:15:08
--         1                                                                   06-mar-2025 14:16:04
--         2                                                                   06-mar-2025 14:16:49
--         1                                                                   06-mar-2025 14:17:34
--         1                                                                   06-mar-2025 14:18:29
--         1                                                                   06-mar-2025 14:19:04
--         1                                                                   06-mar-2025 14:19:12
--         1                                                                   06-mar-2025 14:19:57
--         1                                                                   06-mar-2025 14:20:52
--         1                                                                   06-mar-2025 14:21:27
--         1                                                                   06-mar-2025 14:21:42
--         1                                                                   06-mar-2025 14:22:27
--         1                                                                   06-mar-2025 14:23:23
--         1                                                                   06-mar-2025 14:23:58
--         1                                                                   06-mar-2025 14:24:13
--         1                                                                   06-mar-2025 14:24:58
--         1                                                                   06-mar-2025 14:25:53
--         1                                                                   06-mar-2025 14:26:28
--         1                                                                   06-mar-2025 14:26:44
--         1                                                                   06-mar-2025 14:27:29
--         1                                                                   06-mar-2025 14:28:24
--         1                                                                   06-mar-2025 14:28:59
--         1                                                                   06-mar-2025 14:29:14
--         1                                                                   06-mar-2025 14:29:59
--         1                                                                   06-mar-2025 14:30:55
--         1                                                                   06-mar-2025 14:31:30
--         1                                                                   06-mar-2025 14:31:45
--         1                                                                   06-mar-2025 14:32:30
--         1                                                                   06-mar-2025 14:33:25
--         1                                                                   06-mar-2025 14:34:01
--         1                                                                   06-mar-2025 14:34:16
--         1                                                                   06-mar-2025 14:35:01
--         1                                                                   06-mar-2025 14:35:56
--         1                                                                   06-mar-2025 14:36:31
--         1                                                                   06-mar-2025 14:36:56
--         1                                                                   06-mar-2025 14:37:32
--         1                                                                   06-mar-2025 14:38:27
--         1                                                                   06-mar-2025 14:39:02
--         1                                                                   06-mar-2025 14:39:27
--         1                                                                   06-mar-2025 14:40:02
--         1                                                                   06-mar-2025 14:40:58
--         1                                                                   06-mar-2025 14:41:23
--         1                                                                   06-mar-2025 14:41:58
--         1                                                                   06-mar-2025 14:42:23
--         1                                                                   06-mar-2025 14:43:28
--         1                                                                   06-mar-2025 14:43:53
--         1                                                                   06-mar-2025 14:44:29
--         1                                                                   06-mar-2025 14:44:44
--         1                                                                   06-mar-2025 14:45:59
--         1                                                                   06-mar-2025 14:46:14
--         1                                                                   06-mar-2025 14:46:49
--         1                                                                   06-mar-2025 14:47:05
--         1                                                                   06-mar-2025 14:48:10
--         1                                                                   06-mar-2025 14:48:25
--         2                                                                   06-mar-2025 14:49:00
--         1                                                                   06-mar-2025 14:50:05
--         1                                                                   06-mar-2025 14:50:21
--         2                                                                   06-mar-2025 14:50:56
--         1                                                                   06-mar-2025 14:52:01
--         1                                                                   06-mar-2025 14:52:26
--         1                                                                   06-mar-2025 14:52:33
--         1                                                                   06-mar-2025 14:52:59
--         2                                                                   06-mar-2025 14:53:54
--         1                                                                   06-mar-2025 14:54:01
--         1                                                                   06-mar-2025 14:54:08
--         1                                                                   06-mar-2025 14:55:04
--         1                                                                   06-mar-2025 14:55:59
--         3                                                                   06-mar-2025 14:56:24
--         1                                                                   06-mar-2025 14:58:19
--         2                                                                   06-mar-2025 14:58:55
--         1                                                                   06-mar-2025 14:59:10
--         1                                                                   06-mar-2025 15:00:55
--         2                                                                   06-mar-2025 15:01:30
--         1                                                                   06-mar-2025 15:01:46
--         1                                                                   06-mar-2025 15:03:31
--         2                                                                   06-mar-2025 15:03:56
--         1                                                                   06-mar-2025 15:04:11
--         1                                                                   06-mar-2025 15:06:17
--         1                                                                   06-mar-2025 15:06:20
--         1                                                                   06-mar-2025 15:06:21
--         1                                                                   06-mar-2025 15:06:36
--         2                                                                   06-mar-2025 15:08:41
--         1                                                                   06-mar-2025 15:08:49
--         1                                                                   06-mar-2025 15:09:04
--         2                                                                   06-mar-2025 15:11:09
--         1                                                                   06-mar-2025 15:11:24
--         1                                                                   06-mar-2025 15:11:27
--         2                                                                   06-mar-2025 15:13:43
--         1                                                                   06-mar-2025 15:13:46
--         1                                                                   06-mar-2025 15:14:01
--         1                                                                   06-mar-2025 15:14:36
--         1                                                                   06-mar-2025 15:15:42
--         1                                                                   06-mar-2025 15:16:17
--         1                                                                   06-mar-2025 15:16:32
--         1                                                                   06-mar-2025 15:17:07
--         1                                                                   06-mar-2025 15:18:12
--         1                                                                   06-mar-2025 15:19:07
--         1                                                                   06-mar-2025 15:19:43
--         1                                                                   06-mar-2025 15:19:58
--         1                                                                   06-mar-2025 15:20:43
--         1                                                                   06-mar-2025 15:21:28
--         1                                                                   06-mar-2025 15:21:53
--         1                                                                   06-mar-2025 15:22:09
--         1                                                                   06-mar-2025 15:23:04
--         1                                                                   06-mar-2025 15:23:49
--         1                                                                   06-mar-2025 15:24:04
--         1                                                                   06-mar-2025 15:24:29
--         2                                                                   06-mar-2025 15:25:35
--         1                                                                   06-mar-2025 15:26:30
--         2                                                                   06-mar-2025 15:27:15
--         2                                                                   06-mar-2025 15:28:01
--         2                                                                   06-mar-2025 15:28:46
--         1                                                                   06-mar-2025 15:29:01
--         1                                                                   06-mar-2025 15:29:17
--         1                                                                   06-mar-2025 15:29:24
--         1                                                                   06-mar-2025 15:29:31
--         1                                                                   06-mar-2025 15:29:38
--         3                                                                   06-mar-2025 15:29:53
--         7                                                                   06-mar-2025 15:30:09
--         4                                                                   06-mar-2025 15:31:44
--         4                                                                   06-mar-2025 15:32:10
--         2                                                                   06-mar-2025 15:33:25
--         2                                                                   06-mar-2025 15:33:32
--         2                                                                   06-mar-2025 15:33:36
--         3                                                                   06-mar-2025 15:33:51
--         3                                                                   06-mar-2025 15:35:06
--         2                                                                   06-mar-2025 15:35:21
--         4                                                                   06-mar-2025 15:35:37
--         1                                                                   06-mar-2025 15:36:52
--         1                                                                   06-mar-2025 15:37:17
--         1                                                                   06-mar-2025 15:37:24
--         1                                                                   06-mar-2025 15:37:25
--         1                                                                   06-mar-2025 15:38:11
--         1                                                                   06-mar-2025 15:38:56
--         1                                                                   06-mar-2025 15:39:03
--         1                                                                   06-mar-2025 15:39:10
--         1                                                                   06-mar-2025 15:39:17
--         2                                                                   06-mar-2025 15:39:33
         1 FILE NOT FOUND
********************************************************************************************************************************************

rman target /

channel ch1: starting datafile backup set restore
channel ch1: specifying datafile(s) to restore from backup set
channel ch1: restoring datafile 00004 to +DG_DATA/PCP/DATAFILE/undotbs1.258.1018885305
channel ch1: reading from backup piece t73jlulm_1_1

********************************************************************************************************************************************


set line 500
set pages 100
COLUMN EVENT_S FORMAT a40 
COLUMN EVENT_SW FORMAT a40      
COLUMN SECONDS_IN_WAIT FORMAT 999       
COLUMN STATE FORMAT a20       
COLUMN CLIENT_INFO FORMAT a30   
SELECT 
p.SPID, 
s.EVENT EVENT_S, 
sw.EVENT EVENT_SW, 
s.SECONDS_IN_WAIT AS SEC_WAIT_S,
sw.SECONDS_IN_WAIT AS SEC_WAIT_SW,
s.STATE, 
s.CLIENT_INFO       
FROM V$SESSION_WAIT sw, V$SESSION s, V$PROCESS p      
WHERE sw.EVENT LIKE '%MML%'              
AND s.SID=sw.SID              
AND s.PADDR=p.ADDR
;



--SPID                     EVENT_S                                  EVENT_SW                                 SEC_WAIT_S SEC_WAIT_SW STATE                CLIENT_INFO
-------------------------- ---------------------------------------- ---------------------------------------- ---------- ----------- -------------------- ------------------------------
--9526                     Backup: MML restore backup piece         Backup: MML restore backup piece             188749      188749 WAITING              rman channel=ch1

********************************************************************************************************************************************


ORA-15012: ASM file '+DG_DATA/PCP/DATAFILE/undotbs1.258.1018885305' does not exist

********************************************************************************************************************************************

COLUMN EVENT FORMAT a40       
SELECT inst_id 
    ,event 
    ,TOTAL_WAITS
    ,TOTAL_TIMEOUTS
    ,TIME_WAITED
    ,AVERAGE_WAIT
    ,TIME_WAITED_MICRO
    ,sysdate as SNAPSHOT_TIME  
FROM gv$system_event 
WHERE event LIKE 'Backup%';


--   INST_ID EVENT                                    TOTAL_WAITS TOTAL_TIMEOUTS TIME_WAITED AVERAGE_WAIT TIME_WAITED_MICRO SNAPSHOT_
------------ ---------------------------------------- ----------- -------------- ----------- ------------ ----------------- ---------
--         1 Backup: MML initialization                         4              0           1          .23              9097 23-APR-26
--         1 Backup: MML commit backup piece                  217              0     1133769      5224.74        1.1338E+10 23-APR-26
--         1 Backup: MML command to channel                     4              0           0          .02               989 23-APR-26
--         1 Backup: MML obtain textual error                 217              0           1            0              6604 23-APR-26
--         1 Backup: MML query backup piece                     1              0         132       131.77           1317650 23-APR-26
--         1 Backup: MML extended initialization                4              0          21         5.29            211719 23-APR-26
--         1 Backup: MML read backup piece               22926652              0     7704939          .34        7.7049E+10 23-APR-26
--         1 Backup: MML restore backup piece                 217              0    45121210    207931.84        4.5121E+11 23-APR-26

********************************************************************************************************************************************


--Especificacion de la pieza
--RUN 
--{
--    ALLOCATE CHANNEL ch1 DEVICE TYPE sbt_tape 
--    send 'SBT_PARMS=(NSR_SERVER=cpprwnetworkerp,NSR_STORAGE_NODE=plsnwk01,NSR_DATA_VOLUME_POOL=PCP_ONL_MENSUAL,NSR_CLIENT=sun2317p)';
--    RESTORE FROM BACKUPPIECE 't73jlulm_1_1';
--    RELEASE CHANNEL ch1;
--}
--
--
--RUN {
--    ALLOCATE CHANNEL ch1 DEVICE TYPE sbt_tape
--    SEND 'SBT_PARMS=(NSR_SERVER=cpprwnetwo4rkerp,NSR_STORAGE_NODE=plsnwk01,NSR_DATA_VOLUME_POOL=PCP_ONL_MENSUAL,NSR_CLIENT=sun2317p)';
--    RESTORE DATAFILE 1 FROM 't73jlulm_1_1';
--    RELEASE CHANNEL ch1;
--}
--
--
--
--RUN {
--    ALLOCATE CHANNEL ch1 DEVICE TYPE sbt_tape
--    SEND 'SBT_PARMS=(NSR_SERVER=cpprwnetworkerp,NSR_STORAGE_NODE=plsnwk01,NSR_DATA_VOLUME_POOL=PCP_ONL_MENSUAL,NSR_CLIENT=sun2317p)';
--    
--    # Esto registra la pieza en el archivo de control
--    CATALOG BACKUPPIECE 't73jlulm_1_1';
--    
--    # Ahora RMAN sabe que esta pieza contiene los archivos de la base de datos
--    RESTORE DATABASE;
--    
--    RELEASE CHANNEL ch1;
--}
--
--
--
--RUN {
--    ALLOCATE CHANNEL ch1 DEVICE TYPE sbt_tape
--    SEND 'SBT_PARMS=(NSR_SERVER=cpprwnetworkerp,NSR_STORAGE_NODE=plsnwk01,NSR_DATA_VOLUME_POOL=PCP_ONL_MENSUAL,NSR_CLIENT=sun2317p)';
--    
--    # Se añade DEVICE TYPE SBT para que no busque en disco
--    CATALOG DEVICE TYPE sbt_tape BACKUPPIECE 't73jlulm_1_1';
--    
--    RESTORE DATABASE;
--    
--    RELEASE CHANNEL ch1;
--}
--

********************************************************************************************************************************************
RMAN> LIST BACKUPPIECE 't73jlulm_1_1';

 
List of Backup Pieces
BP Key  BS Key  Pc# Cp# Status      Device Type Piece Name
------- ------- --- --- ----------- ----------- ----------
18050792 18050572 1   1   AVAILABLE   SBT_TAPE    t73jlulm_1_1
 
RMAN> LIST BACKUPSET 18050572;
 
 
List of Backup Sets
===================
 
 
BS Key  Type LV Size       Device Type Elapsed Time Completion Time
------- ---- -- ---------- ----------- ------------ ---------------
18050572 Full    32.00G     SBT_TAPE    00:02:30     06-MAR-25
        BP Key: 18050792   Status: AVAILABLE  Compressed: NO  Tag: PCP_ONL_MENSUAL
        Handle: t73jlulm_1_1   Media: DDBDV5BK10A.002
        Keep: BACKUP_LOGS        Until: 04-MAR-35
  List of Datafiles in backup set 18050572
  File LV Type Ckp SCN    Ckp Time  Abs Fuz SCN Sparse Name
  ---- -- ---- ---------- --------- ----------- ------ ----
  4       Full 23203895855 06-MAR-25 23203895860  NO    +DG_DATA/PCP/DATAFILE/undotbs1.258.1018885305


********************************************************************************************************************************************
RECOVER
********************************************************************************************************************************************

RUN
{
    allocate channel ch1 device type sbt_tape ;
    allocate channel ch2 device type sbt_tape ;
    allocate channel ch3 device type sbt_tape ;
    allocate channel ch4 device type sbt_tape ;
    SET UNTIL TIME "to_date('06-MAR-2025 15:46:07','dd-mm-yyyy hh24:mi:ss')";
	send 'SBT_PARMS=(NSR_SERVER=cpprwnetworkerp,NSR_STORAGE_NODE=plsnwk01,NSR_DATA_VOLUME_POOL=PCP_ONL_MENSUAL,NSR_CLIENT=sun2317p)';
    RECOVER database;
    release channel ch1 ;
    release channel ch2 ;
    release channel ch3 ;
    release channel ch4 ;
}


********************************************************************************************************************************************
Error al abrir la BD 
********************************************************************************************************************************************
--Error al setear los online logs - Se realizó un alter para modificar el nombre de los REDOS

alter system set db_create_online_log_dest_1='+REDO01';
alter system set db_create_online_log_dest_2='+REDO02';

--Esta instancia single se creo en el nodo dos y los Redos creados por defecto estaban en el nodo uno, se añadieron grupos de redos correspondientes al nodo 2

alter database add logfile thread 2 group 201 ('+REDO01','+REDO02') size 2048M; 
alter database add logfile thread 2 group 202 ('+REDO01','+REDO02') size 2048M; 
alter database add logfile thread 2 group 203 ('+REDO01','+REDO02') size 2048M; 



--    GROUP#    THREAD#  SEQUENCE# ARC STATUS           REDOLOG_FILE_NAME                                               SIZE_MB
------------ ---------- ---------- --- ---------------- ------------------------------------------------------------ ----------
--         1          1          0 NO  CLEARING_CURRENT +REDO2                                                             5120
--         1          1          0 NO  CLEARING_CURRENT +REDO1                                                             5120
--         2          1          0 YES CLEARING         +REDO1                                                             5120
--         2          1          0 YES CLEARING         +REDO2                                                             5120
--         3          1          0 YES CLEARING         +REDO1                                                             5120
--         3          1          0 YES CLEARING         +REDO2                                                             5120
--       201          2          0 YES UNUSED           +REDO02/PCP/ONLINELOG/group_201.256.1231409263                     2048
--       201          2          0 YES UNUSED           +REDO01/PCP/ONLINELOG/group_201.256.1231409241                     2048
--       202          2          0 YES UNUSED           +REDO01/PCP/ONLINELOG/group_202.257.1231409273                     2048
--       202          2          0 YES UNUSED           +REDO02/PCP/ONLINELOG/group_202.257.1231409285                     2048
--       203          2          0 YES UNUSED           +REDO02/PCP/ONLINELOG/group_203.258.1231409309                     2048
--       203          2          0 YES UNUSED           +REDO01/PCP/ONLINELOG/group_203.258.1231409297                     2048


--Para limpiar los redos en estado clearing se utilizó, luego se pudieron borrar los redos que no serian usados.
-- Haz esto para cada grupo de redo log (1, 2, 3...)

ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 1;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 2;
ALTER DATABASE CLEAR UNARCHIVED LOGFILE GROUP 3;

alter database drop logfile group 2;



********************************************************************************************************************************************
Abrir la BD
********************************************************************************************************************************************

Abrir la BD.
---Si restauraste el control utiliza para sincronizar ese control

alter database open resetlogs;

********************************************************************************************************************************************
Modificar tnsnames.ora con el string de conexión de la instancia nueva
********************************************************************************************************************************************

PCP_restored =
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = sun008scan)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = PCP.BANVENEZ.CORP)
    )
  )

--setear el local listener con la vip del nodo
ALTER SYSTEM SET local_listener='(ADDRESS=(PROTOCOL=tcp)(HOST=172.27.56.162)(PORT=1521))' SCOPE=BOTH;
SHUTDOWN IMMEDIATE;
STARTUP;




********************************************************************************************************************************************
Añadir la BD a srvctl
********************************************************************************************************************************************
--La BD no se veia configurada en crsctl y srvctl por lo que hubo que se añadida con el siguiente comando.
srvctl add database -db PCP -o /oracle/app/oracle12/product/12.2.0/db_1 -p +DG_DATA/PCP/PARAMETERFILE/spfile.256.1231078955 -dbtype SINGLE -node sun2006p

