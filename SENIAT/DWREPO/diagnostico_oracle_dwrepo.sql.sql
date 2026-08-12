AGNOSTICO ORACLE - Checklist inicial de salud / baseline
-- Ruta: ORACLE/DIAGNOSTIC/diagnostico_oracle.sql
-- Ejecutar como SYSDBA o usuario con privilegios DBA_* / V$ / ASM
-- =============================================================================
-- Uso:
--   sqlplus / as sysdba
--   @diagnostico_oracle.sql
--   spool diagnostico_<host>_<fecha>.txt
-- =============================================================================

SET LINESIZE 300
SET PAGESIZE 200
SET FEEDBACK ON
SET VERIFY OFF
SET TRIMSPOOL ON
SET TRIMOUT ON
SET SERVEROUTPUT ON SIZE UNLIMITED
SET DEFINE OFF

COL host_name       FORMAT A30
COL instance_name   FORMAT A20
COL db_name         FORMAT A20
COL version_full    FORMAT A20
COL edition         FORMAT A10
COL patch_info      FORMAT A80
COL owner           FORMAT A20
COL table_name      FORMAT A35
COL index_name      FORMAT A35
COL object_name     FORMAT A40
COL object_type     FORMAT A25
COL status          FORMAT A15
COL tablespace_name FORMAT A30
COL segment_type    FORMAT A20
COL physical_name   FORMAT A60
COL diskgroup_name  FORMAT A20
COL disk_name       FORMAT A30
COL path            FORMAT A50
COL comp_name       FORMAT A45
COL version         FORMAT A20
COL username        FORMAT A30
COL default_tablespace FORMAT A30
COL partition_name  FORMAT A30
COL subpartition_name FORMAT A30

PROMPT
PROMPT ######################################################################
PROMPT  DIAGNOSTICO ORACLE - INICIO
PROMPT  Host / Instancia / Fecha
PROMPT ######################################################################

SELECT i.host_name,
       i.instance_name,
       d.name AS db_name,
       TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AS fecha_ejecucion
  FROM v$instance i
 CROSS JOIN v$database d;

-- =============================================================================
-- 1. VERSION DE BASE DE DATOS Y EDICION
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  1. VERSION DE BASE DE DATOS Y EDICION
PROMPT ######################################################################

SELECT i.version AS version_instance,
       NVL((SELECT p.version_full
              FROM product_component_version p
             WHERE p.product LIKE 'Oracle Database%'
               AND p.version_full IS NOT NULL
               AND ROWNUM = 1), i.version) AS version_full,
       CASE
         WHEN EXISTS (SELECT 1 FROM v$version WHERE UPPER(banner) LIKE '%ENTERPRISE EDITION%') THEN 'EE'
         WHEN EXISTS (SELECT 1 FROM v$version WHERE UPPER(banner) LIKE '%STANDARD EDITION 2%') THEN 'SE2'
         WHEN EXISTS (SELECT 1 FROM v$version WHERE UPPER(banner) LIKE '%STANDARD EDITION%') THEN 'SE'
         WHEN EXISTS (SELECT 1 FROM v$version WHERE UPPER(banner) LIKE '%EXPRESS EDITION%') THEter WHERE name = 'db_files'), 0), 2) AS pct_uso
  FROM dual;

-- =============================================================================
-- 11. FRAGMENTACION DE TABLAS E INDICES (estimacion por estadisticas)
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  11. FRAGMENTACION DE TABLAS E INDICES (estimacion)
PROMPT  Tablas: compara blocks vs espacio real (num_rows * avg_row_len)
PROMPT  Indices: del_lf_rows / lf_rows via INDEX_STATS (requiere ANALYZE INDEX)
PROMPT  Nota: valores dependen de estadisticas actualizadas
PROMPT ######################################################################

PROMPT
PROMPT 11a. Tablas con posible fragmentacion (>30% espacio liberable, >10MB)
SELECT owner,
       table_name,
       blocks,
       num_rows,
       avg_row_len,
       ROUND(blocks * 8 / 1024, 2) AS size_mb,
       ROUND(num_rows * avg_row_len / 1024 / 1024, 2) AS actual_mb,
       ROUND((blocks * 8 / 1024) - (num_rows * avg_row_len / 1024 / 1024), 2) AS fragmented_mb,
       ROUND(
         (((blocks * 8 / 1024) - (num_rows * avg_row_len / 1024 / 1024))
           / NULLIF(blocks * 8 / 1024, 0)) * 100, 2
       ) AS pct_liberar
  FROM dba_tables
 WHERE owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y')
   AND NVL(blocks, 0) > 0
   AND NVL(num_rows, 0) > 0
   AND NVL(avg_row_len, 0) > 0
   AND ROUND(blocks * 8 / 1024, 2) > 10
   AND ROUND(
         (((blocks * 8 / 1024) - (num_rows * avg_row_len / 1024 / 1024))
           / NULLIF(blocks * 8 / 1024, 0)) * 100, 2
       ) > 30
 ORDER BY pct_liberar DESC, size_mb DESC;

PROMPT
PROMPT 11b. Indices - candidatos a rebuild (alto clustering_factor vs num_rows)
SELECT i.owner,
       i.index_name,
       i.table_name,
       i.num_rows,
       i.clustering_factor,
       i.leaf_blocks,
       ROUND(s.bytes / 1024 / 1024, 2) AS size_mb,
       CASE WHEN NVL(i.num_rows, 0) = 0 THEN NULL
            ELSE ROUND(i.clustering_factor / NULLIF(i.num_rows, 0), 2)
       END AS cf_ratio
  FROM dba_indexes i
  JOIN dba_segments s
    ON s.owner = i.owner
   AND s.segment_name = i.index_name
   AND s.segment_type LIKE 'INDEX%'
 WHERE i.owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y')
   AND i.index_type = 'NORMAL'
   AND NVL(i.num_rows, 0) > 10000
   AND NVL(i.clustering_factor, 0) > NVL(i.num_rows, 0) * 2
 ORDER BY cf_ratio DESC NULLS LAST, size_mb DESC;

PROMPT
PROMPT 11c. Chained / migrated rows (>1%)
SELECT owner,
       table_name,
       num_rows,
       chain_cnt,
       ROUND(chain_cnt * 100.0 / NULLIF(num_rows, 0), 2) AS pct_chained
  FROM dba_tables
 WHERE owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y')
   AND NVL(num_rows, 0) > 0
   AND NVL(chain_cnt, 0) > 0
   AND chain_cnt / num_rows > 0.01
 ORDER BY pct_chained DESC;

-- =============================================================================
-- 12. TABLESPACES: ASIGNADO / USADO / LIBRE
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  12. TABLESPACES - ESPACIO ASIGNADO, USADO Y LIBRE
PROMPT ######################################################################

SELECT df.tablespace_name,
       ROUND(df.bytes_alloc / 1024 / 1024, 2) AS allocated_mb,
       ROUND((df.bytes_alloc - NVL(fs.bytes_free, 0)) / 1024 / 1024, 2) AS used_mb,
       ROUND(NVL(fs.bytes_free, 0) / 1024 / 1024, 2) AS free_mb,
       ROUND((df.bytes_alloc - NVL(fs.bytes_free, 0)) * 100.0
             / NULLIF(df.bytes_alloc, 0), 2) AS pct_used,
       ROUND(NVL(fs.bytes_free, 0) * 100.0
             / NULLIF(df.bytes_alloc, 0), 2) AS pct_free,
       df.autoextensible
  FROM (
        SELECT tablespace_name,
               SUM(bytes) AS bytes_alloc,
               MAX(autoextensible) AS autoextensible
          FROM dba_data_files
         GROUP BY tablespace_name
       ) df
  LEFT JOIN (
        SELECT tablespace_name,
               SUM(bytes) AS bytes_free
          FROM dba_free_space
         GROUP BY tablespace_name
       ) fs
    ON fs.tablespace_name = df.tablespace_name
 ORDER BY pct_used DESC NULLS LAST, df.tablespace_name;

PROMPT
PROMPT TEMP tablespaces:
SELECT tablespace_name,
       ROUND(SUM(bytes_used) / 1024 / 1024, 2) AS used_mb,
       ROUND(SUM(bytes_free) / 1024 / 1024, 2) AS free_mb
  FROM v$temp_space_header
 GROUP BY tablespace_name
 ORDER BY tablespace_name;

-- =============================================================================
-- 13. USUARIOS CON DEFAULT TABLESPACE = USERS
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  13. USUARIOS CON DEFAULT TABLESPACE EN USERS
PROMPT ######################################################################

SELECT username,
       default_tablespace,
       temporary_tablespace,
       account_status,
       created
  FROM dba_users
 WHERE UPPER(default_tablespace) = 'USERS'
   AND oracle_maintained = 'N'
 ORDER BY username;

-- =============================================================================
-- 14. OBJETOS DE USUARIOS EN TABLESPACE USERS
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  14. OBJETOS DE USUARIOS EN TABLESPACE USERS
PROMPT ######################################################################

SELECT owner,
       segment_type,
       COUNT(*) AS cant_objetos,
       ROUND(SUM(bytes) / 1024 / 1024, 2) AS size_mb
  FROM dba_segments
 WHERE UPPER(tablespace_name) = 'USERS'
   AND owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y')
 GROUP BY owner, segment_type
 ORDER BY size_mb DESC, owner, segment_type;

PROMPT
PROMPT Detalle de segmentos en USERS:
SELECT owner,
       segment_name,
       segment_type,
       ROUND(bytes / 1024 / 1024, 2) AS size_mb
  FROM dba_segments
 WHERE UPPER(tablespace_name) = 'USERS'
   AND owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y')
 ORDER BY size_mb DESC, owner, segment_name;

-- =============================================================================
-- 15. ESTADISTICAS DESACTUALIZADAS (> 7 DIAS)
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  15. ESTADISTICAS DE TABLAS E INDICES DESACTUALIZADAS (> 7 DIAS)
PROMPT ######################################################################

PROMPT
PROMPT 15a. Tablas (LAST_ANALYZED > 7 dias o NULL)
SELECT owner,
       table_name,
       num_rows,
       TO_CHAR(last_analyzed, 'YYYY-MM-DD HH2   FORMAT A20
COL protection_mode          FORMAT A25
COL protection_level         FORMAT A25
COL switchover_status        FORMAT A20

PROMPT
PROMPT 22a. Rol / proteccion / switchover (V$DATABASE)
SELECT name,
       db_unique_name,
       database_role,
       open_mode,
       log_mode,
       protection_mode,
       protection_level,
       switchover_status,
       force_logging,
       dataguard_broker
  FROM v$database;

PROMPT
PROMPT 22.1 Modo de operacion actual (Si esta MOUNTED debe estar en recuperacion)
SELECT open_mode,
       log_mode
  FROM v$database;

PROMPT
PROMPT 22.2 Fecha de ultimo archive registrado y aplicado
SELECT sequence#,
       completion_time AS "Fecha Ultimo Archive",
       applied AS "Aplicado"
  FROM v$archived_log
 WHERE completion_time IN (
         SELECT MAX(completion_time)
           FROM v$archived_log
          WHERE applied = 'YES'
       );

PROMPT
PROMPT 22.3 Archived logs pendientes por aplicar
SELECT sequence#,
       thread#,
       completion_time,
       name
  FROM v$archived_log
 WHERE applied = 'NO'
 ORDER BY thread#, sequence#;

PROMPT
PROMPT 22.4 Gaps en aplicacion de archived redo logs
SELECT * FROM v$archive_gap;

PROMPT
PROMPT 22.4b Sincronizacion Primary vs Dataguard (por thread)
SELECT 'Thread '||a.thread# AS "Sincronizacion Archived",
       MAX(a.sequence#) AS primary,
       MAX(b.sequence#) AS dataguard,
       MAX(a.sequence#) - MAX(b.sequence#) AS "Cant. Gap"
  FROM v$archived_log a,
       v$archived_log b
 WHERE a.archived = 'YES'
   AND b.applied = 'YES'
   AND a.thread# = b.thread#
 GROUP BY a.thread#
 ORDER BY a.thread#;

PROMPT
PROMPT 22.5 Proceso MRP / MRP0 (V$MANAGED_STANDBY)
SELECT process,
       status,
       thread#,
       sequence#,
       block#,
       blocks
  FROM v$managed_standby
 WHERE process LIKE '%MRP%';

PROMPT
PROMPT 22.6 Procesos Data Guard (todos los relevantes)
SELECT process,
       status,
       thread#,
       sequence#,
       block#,
       blocks,
       client_process,
       delay_mins
  FROM v$managed_standby
 ORDER BY process;

PROMPT
PROMPT 22.7 Destinos de archive (V$ARCHIVE_DEST_STATUS) - si aplica
SELECT dest_id,
       status,
       type,
       database_mode,
       recovery_mode,
       protection_mode,
       destination,
       gap_status,
       error
  FROM v$archive_dest_status
 WHERE status <> 'INACTIVE'
 ORDER BY dest_id;

PROMPT
PROMPT ######################################################################
PROMPT  DIAGNOSTICO ORACLE - FIN
PROMPT ######################################################################

