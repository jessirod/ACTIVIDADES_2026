DBMS_SQLTUNE.REPORT_TUNING_TASK('AKU8HWWR8NXYA_TUNING_TASK1')
---------------------------------------------------------------------------------                         
---------------------------------------------------------------------------------
GENERAL INFORMATION SECTION
-------------------------------------------------------------------------------
Tuning Task Name   : aku8hwwr8nxya_tuning_task1
Tuning Task Owner  : SYS
Workload Type      : Single SQL Statement
Scope              : COMPREHENSIVE
Time Limit(seconds): 20000
Completion Status  : COMPLETED
Started at         : 07/17/2026 10:11:33
Completed at       : 07/17/2026 10:12:02

-------------------------------------------------------------------------------
Schema Name: PCP
SQL ID     : aku8hwwr8nxya
SQL Text   : DELETE FROM ORDEN WHERE ID_ORDEN = :B1
Bind Variables :
 1 -  (NUMBER):17417099

-------------------------------------------------------------------------------
There are no recommendations to improve the statement.

-------------------------------------------------------------------------------








*******************************************************************************************************************************************************
DBMS_SQLTUNE.REPORT_TUNING_TASK('5U25YKJ7NT02T_TUNING_TASK1')
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
GENERAL INFORMATION SECTION
-------------------------------------------------------------------------------
Tuning Task Name   : 5u25ykj7nt02t_tuning_task1
Tuning Task Owner  : SYS
Workload Type      : Single SQL Statement
Scope              : COMPREHENSIVE
Time Limit(seconds): 20000
Completion Status  : COMPLETED
Started at         : 07/17/2026 10:21:44
Completed at       : 07/17/2026 10:21:44
-------------------------------------------------------------------------------
Schema Name: PCP
SQL ID     : 5u25ykj7nt02t
SQL Text   : DECLARE job BINARY_INTEGER := :job;  next_date TIMESTAMP WITH TIME ZONE := :mydate;  broken BOOLEAN := FALSE;  job_name
             VARCHAR2(128) := :job_name;  job_subname VARCHAR2(128) := :job_subname;  job_owner VARCHAR2(128) := :job_owner;  job_start
             TIMESTAMP WITH TIME ZONE := :job_start;  job_scheduled_start TIMESTAMP WITH TIME ZONE := :job_scheduled_start;  window_start
             TIMESTAMP WITH TIME ZONE := :window_start;  window_end TIMESTAMP WITH TIME ZONE := :window_end;  chain_id VARCHAR2(14) :=
             :chainid;  credential_owner VARCHAR2(128) := :credown; credential_name  VARCHAR2(128) := :crednam;  destination_owner
             VARCHAR2(128) := :destown;  destination_name VARCHAR2(128) :=   :destnam;  job_dest_id varchar2(14) := :jdestid;  log_id number
             := :log_id;  BEGIN
                         DECLARE
                             v_out           VARCHAR2(4000);
                             v_start         TIMESTAMP := SYSTIMESTAMP;
                             v_ok_migracion  BOOLEAN := FALSE;
                         BEGIN
                             -- ============================================================
                             -- PASO 1: Migracion unificada (ORDEN + TORDEN/ALTAS + TRACK_LOTE)
                             -- ============================================================
                             DBMS_OUTPUT.PUT_LINE('=== INICIO MIGRACION UNIFICADA (ORDEN + TORDEN) ===');
                             PCP.MANTENIMIENTO_TABLAS_PCP_HIST_PKG.MANTENIMIEN TO_PCP_HIST_DIARIO(
                                 P_MONTHS_RETENTION_H   => 28,
                                 P_OUT_DATA             => v_out,
                                 P_ID_ORDEN             => NULL,
                                 P_START_DATE           => NULL,
                                 P_END_DATE             => NULL,
                                 P_SKIP_ORDEN_MIGRATION => 'N',   -- Por defecto, ejecuta ambos
                                 P_ID_TORDEN            => NULL      -- Migra todos los que correspondan
                             );
                             DBMS_OUTPUT.PUT_LINE('Resultado migracion: ' || v_out);

                             -- Verificar si la migracion fue exitosa (codigo 00 o 02, o cualquier que no sea 99)
                             IF SUBSTR(v_out, 1, 2) NOT IN ('99') THEN
                                 v_ok_migracion := TRUE;
                             END IF;

                             -- ============================================================
                             -- PASO 2: Eliminar particiones vacias (solo si la migracion no dio error grave)
                             -- ============================================================
                             IF v_ok_migracion THEN
                                 DBMS_OUTPUT.PUT_LINE('=== INICIO ELIMINACION DE PARTICIONES VACIAS ===');
                                 PCP.MANTENIMIENTO_TABLAS_PCP_HIST_PKG.ELIMINA R_PARTICIONES_VACIAS;
                                 DBMS_OUTPUT.PUT_LINE('=== ELIMINACION DE PARTICIONES COMPLETADA ===');
                             ELSE
                                 DBMS_OUTPUT.PUT_LINE('No se ejecuta limpieza de particiones debido a error grave en la migracion.');
                             END IF;

                             DBMS_OUTPUT.PUT_LINE('=== PROCESO COMPLETADO.Duracion total: ' ||
                                 EXTRACT(SECOND FROM (SYSTIMESTAMP -  v_start)) || ' segundos ===');

                         EXCEPTION
                             WHEN OTHERS THEN
                                 DBMS_OUTPUT.PUT_LINE('ERROR GLOBAL: ' || SQLERRM);
                                 -- No se ejecuta limpieza si hay error global
                                 RAISE;
                         END;
                       :mydate := next_date; IF broken THEN :b := 1; ELSE :b
             := 0; END IF; END;

-------------------------------------------------------------------------------
ADDITIONAL INFORMATION SECTION
-------------------------------------------------------------------------------
- Type of SQL statement not supported.
-------------------------------------------------------------------------------
*******************************************************************************************************************************************************






*******************************************************************************************************************************************************
DBMS_SQLTUNE.REPORT_TUNING_TASK('36WYU7VTFB8TD_TUNING_TASK1')
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
GENERAL INFORMATION SECTION
-------------------------------------------------------------------------------
Tuning Task Name   : 36wyu7vtfb8td_tuning_task1
Tuning Task Owner  : SYS
Workload Type      : Single SQL Statement
Scope              : COMPREHENSIVE
Time Limit(seconds): 20000
Completion Status  : COMPLETED
Started at         : 07/17/2026 10:27:16
Completed at       : 07/17/2026 10:27:30

-------------------------------------------------------------------------------
Schema Name: SYS
SQL ID     : 36wyu7vtfb8td
SQL Text   :  delete from "PCP"."CREDITS_CREDITO_INMEDIATO" where "ID_ORDEN"
             = :1
Bind Variables :
 1 -  (NUMBER):17417099

-------------------------------------------------------------------------------
FINDINGS SECTION (1 finding)
-------------------------------------------------------------------------------

1- Index Finding (see explain plans section below)
--------------------------------------------------
  The execution plan of this statement can be improved by creating one or more
  indices.

  Recommendation (estimated benefit: 99.97%)
  ------------------------------------------
  - Consider running the Access Advisor to improve the physical schema design
    or creating the recommended index.
    create index PCP.IDX$$_10270001 on PCP.CREDITS_CREDITO_INMEDIATO("ID_ORDEN"
    );

  Rationale
  ---------
    Creating the recommended indices significantly improves the execution plan
    of this statement. However, it might be preferable to run "Access Advisor"
    using a representative SQL workload as opposed to a single statement. This
    will allow to get comprehensive index recommendations which takes into
    account index maintenance overhead and additional space consumption.

-------------------------------------------------------------------------------
EXPLAIN PLANS SECTION
-------------------------------------------------------------------------------

1- Original
-----------
Plan hash value: 3487852520

------------------------------------------------------------------------------------------------------------------
| Id  | Operation            | Name                      | Rows  | Bytes | Cost (%CPU)| Time     | Pstart| Pstop |
------------------------------------------------------------------------------------------------------------------
|   0 | DELETE STATEMENT     |                           |     2 |    80 | 14895   (1)| 00:00:01 |       |       |
|   1 |  DELETE              | CREDITS_CREDITO_INMEDIATO |       |       |            |          |       |       |
|   2 |   PARTITION RANGE ALL|                           |     2 |    80 | 14895   (1)| 00:00:01 |     1 |1048575|
|*  3 |    TABLE ACCESS FULL | CREDITS_CREDITO_INMEDIATO |     2 |    80 | 14895   (1)| 00:00:01 |     1 |1048575|
------------------------------------------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   3 - filter("ID_ORDEN"=:1)

2- Using New Indices
--------------------
Plan hash value: 3372589731

-----------------------------------------------------------------------------------------------
| Id  | Operation         | Name                      | Rows  | Bytes | Cost (%CPU)| Time     |
-----------------------------------------------------------------------------------------------
|   0 | DELETE STATEMENT  |                           |     2 |   218 |     3   (0)| 00:00:01 |
|   1 |  DELETE           | CREDITS_CREDITO_INMEDIATO |       |       |            |          |
|*  2 |   INDEX RANGE SCAN| IDX$$_10270001            |     2 |   218 |     3   (0)| 00:00:01 |
-----------------------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("ID_ORDEN"=:1)

-------------------------------------------------------------------------------

*******************************************************************************************************************************************************






*******************************************************************************************************************************************************
DBMS_SQLTUNE.REPORT_TUNING_TASK('6HNHQAHPHPK8N_TUNING_TASK1')
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
GENERAL INFORMATION SECTION
-------------------------------------------------------------------------------
Tuning Task Name   : 6hnhqahphpk8n_tuning_task1
Tuning Task Owner  : SYS
Workload Type      : Single SQL Statement
Scope              : COMPREHENSIVE
Time Limit(seconds): 20000
Completion Status  : COMPLETED
Started at         : 07/17/2026 10:30:12
Completed at       : 07/17/2026 10:30:12

-------------------------------------------------------------------------------
Schema Name: SYS
SQL ID     : 6hnhqahphpk8n
SQL Text   : select free_mb from v$asm_diskgroup_stat where name=:1
Bind Variables :
 1 -  (VARCHAR2(32)):DATA_PCP

-------------------------------------------------------------------------------
There are no recommendations to improve the statement.
-------------------------------------------------------------------------------
*******************************************************************************************************************************************************






*******************************************************************************************************************************************************

DBMS_SQLTUNE.REPORT_TUNING_TASK('1MN41T2B1KN3M_TUNING_TASK1')
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
GENERAL INFORMATION SECTION
-------------------------------------------------------------------------------
Tuning Task Name   : 1mn41t2b1kn3m_tuning_task1
Tuning Task Owner  : SYS
Workload Type      : Single SQL Statement
Scope              : COMPREHENSIVE
Time Limit(seconds): 20000
Completion Status  : COMPLETED
Started at         : 07/17/2026 10:36:32
Completed at       : 07/17/2026 10:39:50

-------------------------------------------------------------------------------
Schema Name: PCP
SQL ID     : 1mn41t2b1kn3m
SQL Text   : DELETE FROM DEBITS WHERE ID_ORDEN = :B1
Bind Variables :
 1 -  (NUMBER):17416612

-------------------------------------------------------------------------------
There are no recommendations to improve the statement.

-------------------------------------------------------------------------------
*******************************************************************************************************************************************************




*******************************************************************************************************************************************************

DBMS_SQLTUNE.REPORT_TUNING_TASK('1KMRD5CF2RD90_TUNING_TASK1')
--------------------------------------------------------------------------------
GENERAL INFORMATION SECTION
-------------------------------------------------------------------------------
Tuning Task Name   : 1kmrd5cf2rd90_tuning_task1
Tuning Task Owner  : SYS
Workload Type      : Single SQL Statement
Scope              : COMPREHENSIVE
Time Limit(seconds): 20000
Completion Status  : COMPLETED
Started at         : 07/17/2026 10:44:35
Completed at       : 07/17/2026 10:45:15

-------------------------------------------------------------------------------
Schema Name: SYS
SQL ID     : 1kmrd5cf2rd90
SQL Text   :  delete from "PCP"."CREDITS" where "ID_DEBITS" = :1
Bind Variables :
 1 -  (NUMBER):51319637

-------------------------------------------------------------------------------
There are no recommendations to improve the statement.
-------------------------------------------------------------------------------
*******************************************************************************************************************************************************






*******************************************************************************************************************************************************
DBMS_SQLTUNE.REPORT_TUNING_TASK('7MMQV53T358P9_TUNING_TASK1')
--------------------------------------------------------------------------------
GENERAL INFORMATION SECTION
-------------------------------------------------------------------------------
Tuning Task Name   : 7mmqv53t358p9_tuning_task1
Tuning Task Owner  : SYS
Workload Type      : Single SQL Statement
Scope              : COMPREHENSIVE
Time Limit(seconds): 20000
Completion Status  : COMPLETED
Started at         : 07/17/2026 10:48:52
Completed at       : 07/17/2026 10:49:24

-------------------------------------------------------------------------------
Schema Name: PCP
SQL ID     : 7mmqv53t358p9
SQL Text   : SELECT DISTINCT ID_ORDEN FROM DEBITS WHERE ID_ORDEN IS NOT NULL
             GROUP BY ID_ORDEN HAVING MAX(PROCESS_DATE) <=
             ADD_MONTHS(SYSDATE, -:B1 )
Bind Variables :
 1 -  (NUMBER):28

-------------------------------------------------------------------------------
FINDINGS SECTION (1 finding)
-------------------------------------------------------------------------------

1- SQL Profile Finding (see explain plans section below)
--------------------------------------------------------
  A potentially better execution plan was found for this statement.

  Recommendation (estimated benefit: 85.53%)
  ------------------------------------------
  - Consider accepting the recommended SQL profile to use parallel execution
    for this statement.
    execute dbms_sqltune.accept_sql_profile(task_name =>
            '7mmqv53t358p9_tuning_task1', task_owner => 'SYS', replace =>
            TRUE, profile_type => DBMS_SQLTUNE.PX_PROFILE);

  Executing this query parallel with DOP 8 will improve its response time
  85.53% over the original plan. However, this will increase the statements
  resource consumption by an estimated 15.75% which may result in a reduction
  of system throughput. Also, because these resources are consumed over a much
  smaller duration, the response time of concurrent statements might be
  negatively impacted.

  The following data shows some sampled statistics for this SQL from the past
  week and projected weekly values when parallel execution is enabled.

                                 Past week sampled statistics for this SQL
                                 -----------------------------------------
  Number of executions                                                   0
  Percent of total activity                                              0
  Percent of samples with #Active Sessions > 2*CPU                       0
  Weekly DB time (in sec)                                                0

                              Projected statistics with Parallel Execution
                              --------------------------------------------
  Weekly DB time (in sec)                                                0

-------------------------------------------------------------------------------
EXPLAIN PLANS SECTION
-------------------------------------------------------------------------------

1- Original
-----------
Plan hash value: 2590073571

--------------------------------------------------------------------------------------------------
| Id  | Operation              | Name            | Rows  | Bytes |TempSpc| Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT       |                 |   531K|  7261K|       |   122K  (1)| 00:00:05 |
|*  1 |  FILTER                |                 |       |       |       |            |          |
|   2 |   HASH GROUP BY        |                 |   531K|  7261K|   700M|   122K  (1)| 00:00:05 |
|*  3 |    INDEX FAST FULL SCAN| DEBITS_NEW_1_N5 |    30M|   407M|       | 67228   (1)| 00:00:03 |
--------------------------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   1 - filter(MAX("PROCESS_DATE")<=ADD_MONTHS(SYSDATE@!,(-:B1)))
   3 - filter("ID_ORDEN" IS NOT NULL)

2- Using Parallel Execution
---------------------------
Plan hash value: 1817897201

-------------------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                    | Name            | Rows  | Bytes |TempSpc| Cost (%CPU)| Time     |    TQ  |IN-OUT| PQ Distrib |
-------------------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT             |                 |   531K|  7261K|       | 17719   (1)| 00:00:01 |        |      |            |
|   1 |  PX COORDINATOR              |                 |       |       |       |            |          |        |      |            |
|   2 |   PX SEND QC (RANDOM)        | :TQ10001        |   531K|  7261K|       | 17719   (1)| 00:00:01 |  Q1,01 | P->S | QC (RAND)  |
|*  3 |    FILTER                    |                 |       |       |       |            |          |  Q1,01 | PCWC |            |
|   4 |     HASH GROUP BY            |                 |   531K|  7261K|   700M| 17719   (1)| 00:00:01 |  Q1,01 | PCWP |            |
|   5 |      PX RECEIVE              |                 |   531K|  7261K|       | 17719   (1)| 00:00:01 |  Q1,01 | PCWP |            |
|   6 |       PX SEND HASH           | :TQ10000        |   531K|  7261K|       | 17719   (1)| 00:00:01 |  Q1,00 | P->P | HASH       |
|   7 |        HASH GROUP BY         |                 |   531K|  7261K|   700M| 17719   (1)| 00:00:01 |  Q1,00 | PCWP |            |
|   8 |         PX BLOCK ITERATOR    |                 |    30M|   407M|       |  9337   (1)| 00:00:01 |  Q1,00 | PCWC |            |
|*  9 |          INDEX FAST FULL SCAN| DEBITS_NEW_1_N5 |    30M|   407M|       |  9337   (1)| 00:00:01 |  Q1,00 | PCWP |            |
-------------------------------------------------------------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   3 - filter(MAX()<=ADD_MONTHS(SYSDATE@!,(-:B1)))
   9 - filter("ID_ORDEN" IS NOT NULL)

-------------------------------------------------------------------------------

*******************************************************************************************************************************************************
