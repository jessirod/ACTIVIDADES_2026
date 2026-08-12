-- =============================================================================
-- DIAGNOSTICO ORACLE 19c - Checklist inicial de salud / baseline
-- Ruta: ORACLE/DIAGNOSTIC/diagnostico_oracle.sql
-- Compatible: 18c / 19c+ (usa VERSION_FULL, V$DATAGUARD_PROCESS, ORACLE_MAINTAINED)
-- Para 12.1 / 12.2 usar: diagnostico_oracle_12c.sql
-- Ejecutar como SYSDBA o usuario con privilegios DBA_* / V$ / ASM
-- Multitenant: conectado a CDB$ROOT las vistas DBA_* solo cubren el root.
--              Ejecutar tambien en cada PDB (ALTER SESSION SET CONTAINER=<pdb>)
-- Nota: en BDs upgradeadas desde 11g, ORACLE_MAINTAINED puede venir mal
--       poblado ('N' en schemas de Oracle) y filtrar de menos.
-- =============================================================================
-- Uso:
--   sqlplus / as sysdba
--   SPOOL diagnostico_19c_<host>.txt
--   @diagnostico_oracle.sql
--   SPOOL OFF
-- =============================================================================

SET LINESIZE 300
SET PAGESIZE 200
SET FEEDBACK ON
SET VERIFY OFF
SET TRIMSPOOL ON
SET TRIMOUT ON
SET SERVEROUTPUT ON SIZE 1000000
SET DEFINE OFF
SET SQLBLANKLINES ON
SET TIMING ON
WHENEVER SQLERROR CONTINUE
WHENEVER OSERROR CONTINUE

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
PROMPT  DIAGNOSTICO ORACLE 19c - INICIO
PROMPT  Host / Instancia / Fecha
PROMPT ######################################################################

SELECT i.host_name,
       i.instance_name,
       d.name AS db_name,
       TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AS fecha_ejecucion
  FROM v$instance i
 CROSS JOIN v$database d;

-- =============================================================================
-- 0. CONTEXTO MULTITENANT (CDB / PDB)
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  0. CONTEXTO MULTITENANT (CDB / PDB)
PROMPT ######################################################################

COL es_cdb   FORMAT A6
COL con_name FORMAT A25
COL con_id   FORMAT A6
COL pdb_name FORMAT A25

SELECT d.cdb AS es_cdb,
       SYS_CONTEXT('USERENV', 'CON_NAME') AS con_name,
       SYS_CONTEXT('USERENV', 'CON_ID') AS con_id
  FROM v$database d;

PROMPT
PROMPT PDBs de la instancia (V$PDBS):
SELECT con_id,
       name AS pdb_name,
       open_mode,
       restricted,
       ROUND(total_size / 1024 / 1024 / 1024, 2) AS total_gb
  FROM v$pdbs
 ORDER BY con_id;

PROMPT
PROMPT NOTA: Si CON_NAME = CDB$ROOT, las vistas DBA_* de este reporte solo
PROMPT cubren el root. Para diagnostico de aplicacion ejecutar este script
PROMPT conectado a cada PDB (ALTER SESSION SET CONTAINER = <pdb>).

-- =============================================================================
-- 1. VERSION DE BASE DE DATOS Y EDICION
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  1. VERSION DE BASE DE DATOS Y EDICION
PROMPT ######################################################################

SELECT i.version AS version_instance,
       i.version_full,
       CASE
         WHEN EXISTS (SELECT 1 FROM v$version WHERE UPPER(banner) LIKE '%ENTERPRISE EDITION%') THEN 'EE'
         WHEN EXISTS (SELECT 1 FROM v$version WHERE UPPER(banner) LIKE '%STANDARD EDITION 2%') THEN 'SE2'
         WHEN EXISTS (SELECT 1 FROM v$version WHERE UPPER(banner) LIKE '%STANDARD EDITION%') THEN 'SE'
         WHEN EXISTS (SELECT 1 FROM v$version WHERE UPPER(banner) LIKE '%EXPRESS EDITION%') THEN 'XE'
         ELSE 'OTHER'
       END AS edition,
       d.platform_name,
       d.log_mode,
       d.force_logging,
       d.open_mode
  FROM v$instance i
 CROSS JOIN v$database d;

PROMPT
PROMPT Banner completo:
SELECT banner FROM v$version;

-- =============================================================================
-- 2. NIVEL DE PARCHE
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  2. NIVEL DE PARCHE
PROMPT ######################################################################

PROMPT
PROMPT 2a. Ultimo(s) parche(s) SQL aplicados (DBA_REGISTRY_SQLPATCH)
SELECT TO_CHAR(action_time, 'YYYY-MM-DD HH24:MI:SS') AS action_time,
       action,
       status,
       description,
       source_version,
       target_version,
       patch_id
  FROM (
        SELECT action_time, action, status, description,
               source_version, target_version, patch_id
          FROM dba_registry_sqlpatch
         ORDER BY action_time DESC
       )
 WHERE ROWNUM <= 20;

PROMPT
PROMPT 2b. Version parcheada (PRODUCT_COMPONENT_VERSION)
SELECT product,
       version,
       version_full,
       status
  FROM product_component_version
 WHERE product LIKE 'Oracle Database%'
 ORDER BY product;

-- =============================================================================
-- 3. TABLAS CON MAS DE 7 INDICES
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  3. TABLAS CON MAS DE 7 INDICES
PROMPT ######################################################################

SELECT i.table_owner AS owner,
       i.table_name,
       COUNT(*) AS cant_indices
  FROM dba_indexes i
 WHERE i.table_owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y')
   AND i.index_type NOT IN ('LOB', 'IOT - TOP')
 GROUP BY i.table_owner, i.table_name
HAVING COUNT(*) > 7
 ORDER BY cant_indices DESC, i.table_owner, i.table_name;

-- =============================================================================
-- 4. CANTIDAD DE OBJETOS EN RECYCLEBIN
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  4. CANTIDAD DE OBJETOS EN RECYCLEBIN
PROMPT ######################################################################

SELECT COUNT(*) AS cant_objetos_recyclebin
  FROM dba_recyclebin;

PROMPT
PROMPT Detalle por owner (top):
SELECT r.owner,
       COUNT(*) AS cant_objetos,
       ROUND(SUM(NVL(r.space, 0)) * p.blk / 1024 / 1024, 2) AS mb_aprox
  FROM dba_recyclebin r
 CROSS JOIN (SELECT TO_NUMBER(value) AS blk
               FROM v$parameter
              WHERE name = 'db_block_size') p
 GROUP BY r.owner, p.blk
 ORDER BY cant_objetos DESC;

-- =============================================================================
-- 5. OBJETOS INVALIDOS
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  5. OBJETOS INVALIDOS
PROMPT ######################################################################

SELECT COUNT(*) AS cant_objetos_invalidos
  FROM dba_objects
 WHERE status <> 'VALID'
   AND owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y');

PROMPT
PROMPT Detalle:
SELECT owner,
       object_type,
       object_name,
       status
  FROM dba_objects
 WHERE status <> 'VALID'
   AND owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y')
 ORDER BY owner, object_type, object_name;

PROMPT
PROMPT Resumen por owner / tipo:
SELECT owner,
       object_type,
       COUNT(*) AS cant
  FROM dba_objects
 WHERE status <> 'VALID'
   AND owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y')
 GROUP BY owner, object_type
 ORDER BY cant DESC, owner, object_type;

-- =============================================================================
-- 6. OBJETOS CON PROPIEDAD NOLOGGING
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  6. OBJETOS CON PROPIEDAD NOLOGGING
PROMPT ######################################################################

PROMPT
PROMPT 6a. Tablas NOLOGGING
SELECT owner,
       table_name,
       logging,
       partitioned,
       tablespace_name
  FROM dba_tables
 WHERE logging = 'NO'
   AND owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y')
 ORDER BY owner, table_name;

PROMPT
PROMPT 6b. Particiones de tabla NOLOGGING
SELECT table_owner AS owner,
       table_name,
       partition_name,
       logging,
       tablespace_name
  FROM dba_tab_partitions
 WHERE logging = 'NO'
   AND table_owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y')
 ORDER BY table_owner, table_name, partition_name;

PROMPT
PROMPT 6c. Indices NOLOGGING
SELECT owner,
       index_name,
       table_owner,
       table_name,
       logging,
       partitioned,
       tablespace_name
  FROM dba_indexes
 WHERE logging = 'NO'
   AND owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y')
 ORDER BY owner, index_name;

PROMPT
PROMPT 6d. Particiones de indice NOLOGGING
SELECT index_owner AS owner,
       index_name,
       partition_name,
       logging,
       tablespace_name,
       status
  FROM dba_ind_partitions
 WHERE logging = 'NO'
   AND index_owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y')
 ORDER BY index_owner, index_name, partition_name;

-- =============================================================================
-- 7. DBA_REGISTRY
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  7. DBA_REGISTRY (componentes instalados)
PROMPT ######################################################################

SELECT comp_id,
       comp_name,
       version,
       status,
       modified
  FROM dba_registry
 ORDER BY comp_id;

-- =============================================================================
-- 8. TABLESPACE vs SEGMENT_TYPE (tablas e indices no deben compartir TBS)
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  8. TABLESPACE / SEGMENT_TYPE / CANTIDAD DE OBJETOS
PROMPT  (Revisar tablespaces con TABLE e INDEX juntos)
PROMPT ######################################################################

SELECT tablespace_name,
       segment_type,
       COUNT(*) AS cant_objetos,
       ROUND(SUM(bytes)/1024/1024, 2) AS size_mb
  FROM dba_segments
 WHERE owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y')
   AND segment_type IN ('TABLE','TABLE PARTITION','TABLE SUBPARTITION',
                        'INDEX','INDEX PARTITION','INDEX SUBPARTITION',
                        'LOBSEGMENT','LOBINDEX','LOB PARTITION')
 GROUP BY tablespace_name, segment_type
 ORDER BY tablespace_name, segment_type;

PROMPT
PROMPT ALERTA: Tablespaces compartidos por TABLE e INDEX
SELECT tablespace_name,
       SUM(CASE WHEN segment_type LIKE 'TABLE%' THEN 1 ELSE 0 END) AS cant_table,
       SUM(CASE WHEN segment_type LIKE 'INDEX%' THEN 1 ELSE 0 END) AS cant_index
  FROM dba_segments
 WHERE owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y')
   AND (segment_type LIKE 'TABLE%' OR segment_type LIKE 'INDEX%')
 GROUP BY tablespace_name
HAVING SUM(CASE WHEN segment_type LIKE 'TABLE%' THEN 1 ELSE 0 END) > 0
   AND SUM(CASE WHEN segment_type LIKE 'INDEX%' THEN 1 ELSE 0 END) > 0
 ORDER BY tablespace_name;

-- =============================================================================
-- 9. INDICES UNUSABLE (particionados y no particionados)
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  9. INDICES UNUSABLE
PROMPT ######################################################################

PROMPT
PROMPT 9a. Indices no particionados UNUSABLE
SELECT owner,
       index_name,
       table_owner,
       table_name,
       status,
       tablespace_name
  FROM dba_indexes
 WHERE status = 'UNUSABLE'
   AND partitioned = 'NO'
   AND owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y')
 ORDER BY owner, index_name;

PROMPT
PROMPT 9b. Indices particionados - particion UNUSABLE
SELECT index_owner AS owner,
       index_name,
       partition_name,
       status,
       tablespace_name
  FROM dba_ind_partitions
 WHERE status = 'UNUSABLE'
   AND index_owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y')
 ORDER BY index_owner, index_name, partition_name;

PROMPT
PROMPT 9c. Indices particionados - subparticion UNUSABLE
SELECT index_owner AS owner,
       index_name,
       partition_name,
       subpartition_name,
       status,
       tablespace_name
  FROM dba_ind_subpartitions
 WHERE status = 'UNUSABLE'
   AND index_owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y')
 ORDER BY index_owner, index_name, partition_name, subpartition_name;

PROMPT
PROMPT 9d. Resumen UNUSABLE
SELECT 'INDEX' AS tipo, COUNT(*) AS cant
  FROM dba_indexes
 WHERE status = 'UNUSABLE'
   AND partitioned = 'NO'
   AND owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y')
UNION ALL
SELECT 'INDEX PARTITION', COUNT(*)
  FROM dba_ind_partitions
 WHERE status = 'UNUSABLE'
   AND index_owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y')
UNION ALL
SELECT 'INDEX SUBPARTITION', COUNT(*)
  FROM dba_ind_subpartitions
 WHERE status = 'UNUSABLE'
   AND index_owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y');

-- =============================================================================
-- 10. DATAFILES vs DB_FILES
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  10. CANTIDAD DE DATAFILES vs DB_FILES
PROMPT ######################################################################

SELECT (SELECT COUNT(*) FROM v$datafile) AS cant_datafiles,
       (SELECT TO_NUMBER(value) FROM v$parameter WHERE name = 'db_files') AS db_files_param,
       (SELECT TO_NUMBER(value) FROM v$parameter WHERE name = 'db_files')
         - (SELECT COUNT(*) FROM v$datafile) AS margen_disponible,
       ROUND( (SELECT COUNT(*) FROM v$datafile) * 100.0
            / NULLIF((SELECT TO_NUMBER(value) FROM v$parameter WHERE name = 'db_files'), 0), 2) AS pct_uso
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
SELECT t.owner,
       t.table_name,
       t.blocks,
       t.num_rows,
       t.avg_row_len,
       ROUND(t.blocks * p.blk / 1024 / 1024, 2) AS size_mb,
       ROUND(t.num_rows * t.avg_row_len / 1024 / 1024, 2) AS actual_mb,
       ROUND((t.blocks * p.blk / 1024 / 1024)
             - (t.num_rows * t.avg_row_len / 1024 / 1024), 2) AS fragmented_mb,
       ROUND(
         (((t.blocks * p.blk / 1024 / 1024) - (t.num_rows * t.avg_row_len / 1024 / 1024))
           / NULLIF(t.blocks * p.blk / 1024 / 1024, 0)) * 100, 2
       ) AS pct_liberar
  FROM dba_tables t
 CROSS JOIN (SELECT TO_NUMBER(value) AS blk
               FROM v$parameter
              WHERE name = 'db_block_size') p
 WHERE t.owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y')
   AND NVL(t.blocks, 0) > 0
   AND NVL(t.num_rows, 0) > 0
   AND NVL(t.avg_row_len, 0) > 0
   AND t.blocks * p.blk / 1024 / 1024 > 10
   AND (((t.blocks * p.blk / 1024 / 1024) - (t.num_rows * t.avg_row_len / 1024 / 1024))
         / NULLIF(t.blocks * p.blk / 1024 / 1024, 0)) * 100 > 30
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
       TO_CHAR(last_analyzed, 'YYYY-MM-DD HH24:MI:SS') AS last_analyzed,
       ROUND(SYSDATE - last_analyzed) AS dias_sin_stats,
       stale_stats
  FROM dba_tab_statistics
 WHERE object_type = 'TABLE'
   AND owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y')
   AND (last_analyzed IS NULL OR last_analyzed < SYSDATE - 7 OR stale_stats = 'YES')
 ORDER BY NVL(last_analyzed, DATE '1900-01-01'), owner, table_name;

PROMPT
PROMPT 15b. Indices (LAST_ANALYZED > 7 dias o NULL)
SELECT owner,
       index_name,
       table_name,
       num_rows,
       TO_CHAR(last_analyzed, 'YYYY-MM-DD HH24:MI:SS') AS last_analyzed,
       ROUND(SYSDATE - last_analyzed) AS dias_sin_stats,
       stale_stats
  FROM dba_ind_statistics
 WHERE object_type = 'INDEX'
   AND owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y')
   AND (last_analyzed IS NULL OR last_analyzed < SYSDATE - 7 OR stale_stats = 'YES')
 ORDER BY NVL(last_analyzed, DATE '1900-01-01'), owner, index_name;

PROMPT
PROMPT 15c. Resumen estadisticas stale / viejas
SELECT 'TABLE' AS tipo,
       COUNT(*) AS cant
  FROM dba_tab_statistics
 WHERE object_type = 'TABLE'
   AND owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y')
   AND (last_analyzed IS NULL OR last_analyzed < SYSDATE - 7 OR stale_stats = 'YES')
UNION ALL
SELECT 'INDEX',
       COUNT(*)
  FROM dba_ind_statistics
 WHERE object_type = 'INDEX'
   AND owner NOT IN (SELECT username FROM dba_users WHERE oracle_maintained = 'Y')
   AND (last_analyzed IS NULL OR last_analyzed < SYSDATE - 7 OR stale_stats = 'YES');

-- =============================================================================
-- 16. DISKGROUPS ASM - ESPACIO ASIGNADO / USADO / LIBRE
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  16. DISKGROUPS ASM - ESPACIO ASIGNADO, USADO Y LIBRE
PROMPT ######################################################################

SELECT name AS diskgroup_name,
       state,
       type,
       ROUND(total_mb / 1024, 2) AS total_gb,
       ROUND(usable_file_mb / 1024, 2) AS usable_gb,
       ROUND((total_mb - free_mb) / 1024, 2) AS used_gb,
       ROUND(free_mb / 1024, 2) AS free_gb,
       ROUND((total_mb - free_mb) * 100.0 / NULLIF(total_mb, 0), 2) AS pct_used,
       ROUND(free_mb * 100.0 / NULLIF(total_mb, 0), 2) AS pct_free
  FROM v$asm_diskgroup
 ORDER BY name;

-- =============================================================================
-- 17. CANTIDAD DE DISCOS POR DISKGROUP
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  17. CANTIDAD DE DISCOS POR DISKGROUP
PROMPT ######################################################################

SELECT NVL(g.name, '[SIN GROUP / CANDIDATO]') AS diskgroup_name,
       COUNT(*) AS cant_discos,
       ROUND(SUM(d.total_mb) / 1024, 2) AS total_gb,
       ROUND(SUM(d.free_mb) / 1024, 2) AS free_gb
  FROM v$asm_disk d
  LEFT JOIN v$asm_diskgroup g
    ON g.group_number = d.group_number
 GROUP BY NVL(g.name, '[SIN GROUP / CANDIDATO]')
 ORDER BY diskgroup_name;

-- =============================================================================
-- 18. DISCOS ASIGNADOS A CADA DISKGROUP CON SUS TAMANOS
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  18. DISCOS ASIGNADOS A CADA DISKGROUP (DETALLE)
PROMPT ######################################################################

SELECT NVL(g.name, '[CANDIDATO]') AS diskgroup_name,
       d.name AS disk_name,
       d.path,
       d.header_status,
       d.mode_status,
       d.state,
       ROUND(d.total_mb / 1024, 2) AS total_gb,
       ROUND(d.free_mb / 1024, 2) AS free_gb,
       ROUND(d.os_mb / 1024, 2) AS os_gb
  FROM v$asm_disk d
  LEFT JOIN v$asm_diskgroup g
    ON g.group_number = d.group_number
 ORDER BY g.name, d.name;

-- =============================================================================
-- 19. RECOVERY AREA (FRA) - TAMANO Y USO
-- Basado en: ARCHIVELOG/Aumentar_recovery_file_dest.sql
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  19. RECOVERY AREA (FRA) - TAMANO Y USO
PROMPT ######################################################################

PROMPT
PROMPT 19a. Parametros db_recovery (V$PARAMETER)
SELECT name, value
  FROM v$parameter
 WHERE name LIKE 'db_recovery%'
 ORDER BY name;

PROMPT
PROMPT 19b. Status del RECOVERY_FILE_DEST
COL "Name"         FORMAT A20
COL "Status"       FORMAT A10
COL "%Used"        FORMAT 999.99
COL "Size GB"      FORMAT 999,999,999.99
COL "Used GB"      FORMAT 999,999,999.99
COL "Free GB"      FORMAT 999,999,999.99
COL "Num Archives" FORMAT 999,999

SELECT NAME "Name"
, ROUND(SPACE_LIMIT/1024/1024/1024,2) "Size GB"
, ROUND((SPACE_LIMIT-SPACE_USED)/1024/1024/1024,2) "Free GB"
, ROUND(SPACE_USED/1024/1024/1024,2) "Used GB"
, ROUND(SPACE_USED*100/NULLIF(SPACE_LIMIT,0),2) "%Used"
, NUMBER_OF_FILES "Num Archives"
, CASE WHEN NVL(SPACE_LIMIT,0) = 0 THEN 'N/A'
       WHEN (SPACE_USED*100/SPACE_LIMIT < 80) THEN 'NORMAL'
       WHEN (SPACE_USED*100/SPACE_LIMIT BETWEEN 80 AND 90) THEN 'WARNING'
       ELSE 'CRITICAL' END "Status"
FROM V$RECOVERY_FILE_DEST;

-- =============================================================================
-- 20. PARAMETROS CRITICOS (V$PARAMETER)
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  20. PARAMETROS CRITICOS (V$PARAMETER)
PROMPT ######################################################################

COL name        FORMAT A40
COL value       FORMAT A80
COL isdefault   FORMAT A10
COL ismodified  FORMAT A12

PROMPT
PROMPT 20a. Parametros solicitados / Data Guard / convert / archive
SELECT name,
       value,
       isdefault,
       ismodified
  FROM v$parameter
 WHERE name IN (
         'db_files',
         'db_block_size',
         'db_name',
         'db_unique_name',
         'db_file_name_convert',
         'log_file_name_convert',
         'log_archive_dest',
         'log_archive_dest_1',
         'log_archive_dest_2',
         'log_archive_dest_3',
         'log_archive_dest_state_1',
         'log_archive_dest_state_2',
         'log_archive_dest_state_3',
         'log_archive_config',
         'log_archive_format',
         'log_archive_max_processes',
         'log_archive_min_succeed_dest',
         'fast_start_mttr_target',
         'dg_broker_start',
         'dg_broker_config_file1',
         'dg_broker_config_file2',
         'fal_server',
         'fal_client',
         'standby_file_management',
         'standby_archive_dest'
       )
 ORDER BY name;

PROMPT
PROMPT 20b. Otros parametros importantes (memoria, procesos, cluster, undo, audit)
SELECT name,
       value,
       isdefault,
       ismodified
  FROM v$parameter
 WHERE name IN (
         'compatible',
         'cluster_database',
         'control_files',
         'processes',
         'sessions',
         'open_cursors',
         'session_cached_cursors',
         'sga_target',
         'sga_max_size',
         'pga_aggregate_target',
         'memory_target',
         'memory_max_target',
         'undo_tablespace',
         'undo_retention',
         'db_recovery_file_dest',
         'db_recovery_file_dest_size',
         'archive_lag_target',
         'remote_login_passwordfile',
         'audit_trail',
         'diagnostic_dest',
         'spfile',
         'instance_name',
         'instance_number',
         'thread',
         'cpu_count',
         'parallel_max_servers',
         'job_queue_processes',
         'resource_manager_plan',
         'optimizer_mode',
         'optimizer_index_cost_adj',
         'cursor_sharing',
         'recyclebin'
       )
 ORDER BY name;

PROMPT
PROMPT 20c. Todos los log_archive_dest_* configurados (no vacios)
SELECT name,
       value,
       isdefault,
       ismodified
  FROM v$parameter
 WHERE name LIKE 'log_archive_dest%'
   AND value IS NOT NULL
 ORDER BY name;

-- =============================================================================
-- 21. REDO LOGS (GRUPOS, ARCHIVOS, ONLINE, STANDBY)
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  21. REDO LOGS - GRUPOS, ARCHIVOS, ONLINE Y STANDBY
PROMPT ######################################################################

COL member       FORMAT A60
COL status       FORMAT A12
COL type         FORMAT A12
COL group#       FORMAT 999
COL thread#      FORMAT 999

PROMPT
PROMPT 21a. Resumen por tipo / status (V$LOGFILE)
SELECT type,
       status,
       COUNT(*) AS cant_miembros
  FROM v$logfile
 GROUP BY type, status
 ORDER BY type, status;

PROMPT
PROMPT 21b. Cantidades: ONLINE vs STANDBY
SELECT SUM(CASE WHEN type = 'ONLINE'  THEN 1 ELSE 0 END) AS cant_online,
       SUM(CASE WHEN type = 'STANDBY' THEN 1 ELSE 0 END) AS cant_standby,
       COUNT(*) AS cant_total_miembros
  FROM v$logfile;

PROMPT
PROMPT 21c. Grupos de redo (V$LOG)
SELECT group#,
       thread#,
       sequence#,
       ROUND(bytes/1024/1024, 2) AS size_mb,
       members,
       archived,
       status,
       first_change#,
       TO_CHAR(first_time, 'YYYY-MM-DD HH24:MI:SS') AS first_time
  FROM v$log
 ORDER BY thread#, group#;

PROMPT
PROMPT 21d. Miembros de cada grupo (V$LOGFILE)
SELECT group#,
       status,
       type,
       member,
       is_recovery_dest_file
  FROM v$logfile
 ORDER BY type, group#, member;

PROMPT
PROMPT 21e. Standby redo logs (si existen) - V$STANDBY_LOG
SELECT group#,
       thread#,
       sequence#,
       ROUND(bytes/1024/1024, 2) AS size_mb,
       used,
       archived,
       status,
       first_change#,
       TO_CHAR(first_time, 'YYYY-MM-DD HH24:MI:SS') AS first_time
  FROM v$standby_log
 ORDER BY thread#, group#;

-- =============================================================================
-- 22. DATAGUARD - ESTADO DE REPLICACION / APLICACION
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  22. DATAGUARD
PROMPT ######################################################################

ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MON/YYYY HH24:MI:SS';

COL "Fecha Ultimo Archive"   FORMAT A25
COL "Aplicado"               FORMAT A10
COL "Sincronizacion Archived" FORMAT A25
COL process                  FORMAT A10
COL status                   FORMAT A15
COL database_role            FORMAT A20
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
PROMPT 22.3 Archived logs pendientes por aplicar (ultimos 100)
SELECT sequence#,
       thread#,
       completion_time,
       name
  FROM (
        SELECT sequence#,
               thread#,
               completion_time,
               name
          FROM v$archived_log
         WHERE applied = 'NO'
         ORDER BY completion_time DESC
       )
 WHERE ROWNUM <= 100
 ORDER BY thread#, sequence#;

PROMPT
PROMPT 22.3b Conteo total pendientes APPLIED=NO
SELECT COUNT(*) AS cant_applied_no
  FROM v$archived_log
 WHERE applied = 'NO';

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
PROMPT 22.5 Proceso de apply MRP (V$DATAGUARD_PROCESS, 12.2+)
PROMPT Nota: V$MANAGED_STANDBY esta deprecada desde 12.2
COL dg_name     FORMAT A8
COL role        FORMAT A24
COL action      FORMAT A18
COL client_role FORMAT A18
SELECT name AS dg_name,
       role,
       action,
       thread#,
       sequence#,
       block#
  FROM v$dataguard_process
 WHERE name LIKE 'MRP%'
    OR role LIKE '%apply%';

PROMPT
PROMPT 22.6 Procesos Data Guard (todos)
SELECT name AS dg_name,
       role,
       action,
       client_role,
       thread#,
       sequence#,
       block#
  FROM v$dataguard_process
 ORDER BY name;

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

-- =============================================================================
-- 23. DIMENSIONAMIENTO DE UNDO
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  23. DIMENSIONAMIENTO DE UNDO
PROMPT ######################################################################

COL "ACTUAL UNDO SIZE [MByte]"       FORMAT 99999999
COL "UNDO RETENTION [Sec]"           FORMAT A20
COL "OPTIMAL UNDO RETENTION [Sec]"   FORMAT 999999999
COL "ACTUAL_UNDO_SIZE_MB"            FORMAT 99999999
COL "UNDO_RETENTION_SEC"             FORMAT A20
COL "NEEDED_UNDO_SIZE_MB"            FORMAT 99999999

PROMPT
PROMPT 23a. Retencion optima estimada para el UNDO actualmente asignado
SELECT ROUND(d.undo_size / (1024 * 1024), 2) "ACTUAL UNDO SIZE [MByte]",
       SUBSTR(e.value, 1, 25) "UNDO RETENTION [Sec]",
       CASE
         WHEN NVL(g.undo_block_per_sec, 0) = 0 THEN NULL
         ELSE ROUND(d.undo_size /
                    (TO_NUMBER(f.value) * g.undo_block_per_sec))
       END "OPTIMAL UNDO RETENTION [Sec]"
  FROM (
        SELECT SUM(a.bytes) undo_size
          FROM v$datafile a,
               v$tablespace b,
               dba_tablespaces c
         WHERE c.contents = 'UNDO'
           AND c.status = 'ONLINE'
           AND b.name = c.tablespace_name
           AND a.ts# = b.ts#
       ) d,
       v$parameter e,
       v$parameter f,
       (
        SELECT MAX(undoblks /
                   NULLIF((end_time - begin_time) * 86400, 0))
               undo_block_per_sec
          FROM v$undostat
       ) g
 WHERE e.name = 'undo_retention'
   AND f.name = 'db_block_size';

PROMPT
PROMPT 23b. Tamano UNDO estimado para la retencion actualmente configurada
SELECT ROUND(d.undo_size / (1024 * 1024), 2) "ACTUAL_UNDO_SIZE_MB",
       SUBSTR(e.value, 1, 25) "UNDO_RETENTION_SEC",
       ROUND((TO_NUMBER(e.value) * TO_NUMBER(f.value) *
              NVL(g.undo_block_per_sec, 0)) / (1024 * 1024), 2)
              "NEEDED_UNDO_SIZE_MB"
  FROM (
        SELECT SUM(a.bytes) undo_size
          FROM v$datafile a,
               v$tablespace b,
               dba_tablespaces c
         WHERE c.contents = 'UNDO'
           AND c.status = 'ONLINE'
           AND b.name = c.tablespace_name
           AND a.ts# = b.ts#
       ) d,
       v$parameter e,
       v$parameter f,
       (
        SELECT MAX(undoblks /
                   NULLIF((end_time - begin_time) * 86400, 0))
               undo_block_per_sec
          FROM v$undostat
       ) g
 WHERE e.name = 'undo_retention'
   AND f.name = 'db_block_size';

-- =============================================================================
-- 24. ALMACENAMIENTO TOTAL ASIGNADO VS USADO
-- =============================================================================
PROMPT
PROMPT ######################################################################
PROMPT  24. ALMACENAMIENTO TOTAL ASIGNADO VS USADO
PROMPT  Incluye DATAFILES + TEMPFILES + REDO (sin FRA ni backups)
PROMPT ######################################################################

COL component   FORMAT A15
COL assigned_gb FORMAT 999999999.99
COL used_gb     FORMAT 999999999.99
COL free_gb     FORMAT 999999999.99
COL pct_used    FORMAT 999.99

PROMPT
PROMPT 24a. Desglose por componente
SELECT component,
       ROUND(assigned_bytes / POWER(1024, 3), 2) assigned_gb,
       ROUND(used_bytes / POWER(1024, 3), 2) used_gb,
       ROUND(free_bytes / POWER(1024, 3), 2) free_gb,
       ROUND(used_bytes * 100 / NULLIF(assigned_bytes, 0), 2) pct_used
  FROM (
        SELECT 'DATAFILES' component,
               d.allocated_bytes assigned_bytes,
               d.allocated_bytes - NVL(f.free_bytes, 0) used_bytes,
               NVL(f.free_bytes, 0) free_bytes
          FROM (SELECT SUM(bytes) allocated_bytes FROM dba_data_files) d,
               (SELECT SUM(bytes) free_bytes FROM dba_free_space) f
        UNION ALL
        SELECT 'TEMPFILES',
               NVL(SUM(bytes_used), 0) + NVL(SUM(bytes_free), 0),
               NVL(SUM(bytes_used), 0),
               NVL(SUM(bytes_free), 0)
          FROM v$temp_space_header
        UNION ALL
        SELECT 'REDO',
               NVL(SUM(bytes), 0),
               NVL(SUM(bytes), 0),
               0
          FROM v$log
       )
 ORDER BY component;

PROMPT
PROMPT 24b. Total general asignado vs usado
SELECT ROUND((d.allocated_bytes + t.allocated_bytes + r.allocated_bytes)
             / POWER(1024, 3), 2) "DATABASE_SIZE_GB",
       ROUND(((d.allocated_bytes - NVL(f.free_bytes, 0)) +
               t.used_bytes + r.allocated_bytes)
             / POWER(1024, 3), 2) "USED_SPACE_GB",
       ROUND((NVL(f.free_bytes, 0) + t.free_bytes)
             / POWER(1024, 3), 2) "FREE_SPACE_GB",
       ROUND(((d.allocated_bytes - NVL(f.free_bytes, 0)) +
               t.used_bytes + r.allocated_bytes) * 100 /
             NULLIF(d.allocated_bytes + t.allocated_bytes +
                    r.allocated_bytes, 0), 2) "PCT_USED"
  FROM (SELECT NVL(SUM(bytes), 0) allocated_bytes
          FROM dba_data_files) d,
       (SELECT NVL(SUM(bytes), 0) free_bytes
          FROM dba_free_space) f,
       (SELECT NVL(SUM(bytes_used), 0) + NVL(SUM(bytes_free), 0)
                    allocated_bytes,
               NVL(SUM(bytes_used), 0) used_bytes,
               NVL(SUM(bytes_free), 0) free_bytes
          FROM v$temp_space_header) t,
       (SELECT NVL(SUM(bytes), 0) allocated_bytes
          FROM v$log) r;

PROMPT
PROMPT ######################################################################
PROMPT  DIAGNOSTICO ORACLE 19c - FIN
PROMPT ######################################################################
