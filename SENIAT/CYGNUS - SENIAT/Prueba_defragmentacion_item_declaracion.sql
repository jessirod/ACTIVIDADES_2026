Pruebas_desgragmentacion_tabla_item_declara

************************************************************************************************
TBS_ASOCIADOS_A_PARTITIONS
************************************************************************************************

SET PAGES 999
COL TABLESPACE_NAME FORMAT A25
COL "TOTAL SIZE MB" FORMAT 999,999,999
COL "OCCUPIED MB" FORMAT 999,999,999
COL "FREE MB" FORMAT 99,999,999
COL "% REAL USED" FORMAT 999

SELECT 
    TSU.TABLESPACE_NAME, 
    CEIL(TSU.ALLOCATED_MB) AS "TOTAL SIZE MB",
    CEIL(TSU.ALLOCATED_MB - NVL(TSF.FREE_MB, 0)) AS "OCCUPIED MB",
    CEIL(NVL(TSF.FREE_MB, 0)) AS "FREE MB",
    CEIL(((TSU.ALLOCATED_MB - NVL(TSF.FREE_MB, 0)) / TSU.ALLOCATED_MB) * 100) AS "% REAL USED"
FROM 
    (
        SELECT TABLESPACE_NAME, SUM(BYTES)/1024/1024 ALLOCATED_MB
        FROM DBA_DATA_FILES 
        GROUP BY TABLESPACE_NAME 
        UNION ALL
        SELECT TABLESPACE_NAME || '  **TEMP**', SUM(BYTES)/1024/1024 ALLOCATED_MB
        FROM DBA_TEMP_FILES 
        GROUP BY TABLESPACE_NAME
    ) TSU, 
    (
        SELECT TABLESPACE_NAME, SUM(BYTES)/1024/1024 FREE_MB
        FROM DBA_FREE_SPACE 
        GROUP BY TABLESPACE_NAME
    ) TSF
WHERE 
    TSU.TABLESPACE_NAME = TSF.TABLESPACE_NAME (+)
    AND TSU.TABLESPACE_NAME IN (
        'TB_PT_VARIOS_01', 'TB_PT_VARIOS_02', 'TB_PT_VARIOS_03', 'TB_PT_VARIOS_04',
        'TB_PT_VARIOS_05', 'TB_PT_VARIOS_06', 'TB_PT_VARIOS_07', 'TB_PT_VARIOS_08',
        'TB_PT_VARIOS_09', 'TB_PT_VARIOS_10', 'TB_PT_VARIOS_11', 'TB_PT_VARIOS_12',
        'TS_D_MEDIUM', 'TS_D_MEDIUM_01', 'TS_D_REL_FACTURA', 'TS_D_SMALL'
    )
ORDER BY 1
/


TABLESPACE_NAME           TOTAL SIZE MB  OCCUPIED MB     FREE MB % REAL USED
------------------------- ------------- ------------ ----------- -----------
TB_PT_VARIOS_01                 145,088      142,191       2,898          99
TB_PT_VARIOS_02                 116,472      112,359       4,114          97
TB_PT_VARIOS_03                  39,172       37,626       1,547          97
TB_PT_VARIOS_04                  29,956       28,302       1,655          95
TB_PT_VARIOS_05                 454,912      443,491      11,422          98
TB_PT_VARIOS_06                 158,804      153,900       4,905          97
TB_PT_VARIOS_07                 104,304       89,021      15,284          86
TB_PT_VARIOS_08                  57,460       54,532       2,929          95
TB_PT_VARIOS_09                  49,152       33,990      15,163          70
TB_PT_VARIOS_10                 161,360      141,137      20,224          88
TB_PT_VARIOS_11                  82,800       76,944       5,857          93
TB_PT_VARIOS_12                  42,460       37,614       4,847          89
TS_D_MEDIUM                     206,504      126,208      80,296          62
TS_D_MEDIUM_01                   35,806       27,050       8,756          76
TS_D_REL_FACTURA                136,112      121,392      14,720          90
TS_D_SMALL                      422,646      106,892     315,755          26


************************************************************************************************
TBS_ASOCIADOS_A_PARTITIONS
************************************************************************************************

select * 
from (
select 
owner
,table_name
,round((blocks*8),2)/1024 "size (MB)" 
,round((num_rows*avg_row_len/1024),2)/1024 "actual_data (MB)"
,(round((blocks*8),2) - round((num_rows*avg_row_len/1024),2))/1024 "wasted_space (MB)"
, ((round((blocks * 8), 2) - round((num_rows * avg_row_len / 1024), 2)) / round((blocks * 8), 2)) * 100 - 10 "reclaimable space % "
,(round(((blocks*8/1024)-(num_rows*avg_row_len/1024/1024)),2)/round(((blocks*8/1024)),2))*100 "percentage fragmented"
from dba_tables
WHERE 
OWNER = 'DBO'
and (round((blocks*8),2) > round((num_rows*avg_row_len/1024),2))
and TABLE_NAME='ITEM_DECLARACION'
order by "wasted_space (MB)" desc 
)
/


OWNER                TABLE_NAME                      size (MB) actual_data (MB) wasted_space (MB) reclaimable space %  percentage fragmented
-------------------- ------------------------------ ---------- ---------------- ----------------- -------------------- ---------------------
DBO                  ITEM_DECLARACION               202533.305       145346.667        57186.6377            18.235671            28.2356728





************************************************************************************************
TBS_ASOCIADOS_A_PARTITIONS
************************************************************************************************



SELECT 'ALTER TABLE ' || TABLE_OWNER || '.' || TABLE_NAME || ' MOVE PARTITION ' || PARTITION_NAME || ' UPDATE INDEXES PARALLEL 60;' AS COMANDO
FROM DBA_TAB_PARTITIONS
WHERE TABLE_OWNER = 'DBO'
AND   TABLE_NAME = 'ITEM_DECLARACION'
ORDER BY PARTITION_POSITION;