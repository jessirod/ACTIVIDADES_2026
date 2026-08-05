******************************************************************************************************************************************

******************************************************************************************************************************************

set pagesize 100
set lines 300
SELECT username, created 
FROM dba_users 
ORDER BY username;


PCP           
PCP_CALL      
PCP_DOMIC 
******************************************************************************************************************************************
******************************************************************************************************************************************

SELECT 
    owner AS "Esquema",
    ROUND(SUM(bytes) / 1024 / 1024, 2) AS "Tamaño (MB)",
    ROUND(SUM(bytes) / 1024 / 1024 / 1024, 2) AS "Tamaño (GB)"
FROM dba_segments
WHERE owner = 'PCP_DOMIC'
GROUP BY owner;

Esquema                                                                                                     Tama??o (MB) Tama??o (GB)
----------------------------------------------------------------------------------------------------------- ------------ ------------
PCP                                                                                                            532671.19       520.19


Esquema                                                                                   Tama??o (MB) Tama??o (GB)
----------------------------------------------------------------------------------------- ------------ ------------
PCP_DOMIC                                                                                   3578286.75      3494.42




******************************************************************************************************************************************
******************************************************************************************************************************************

SELECT 
    segment_type AS "Tipo de Objeto",
    COUNT(*) AS "Cantidad",
    ROUND(SUM(bytes) / 1024 / 1024, 2) AS "Tamaño (MB)"
FROM dba_segments
WHERE owner = 'PCP_DOMIC'
GROUP BY segment_type
ORDER BY 3 DESC;

PCP

Tipo de Objeto       Cantidad Tama??o (MB)
------------------ ---------- ------------
INDEX                     123    180103.63
TABLE                      97    175993.13
TABLE PARTITION            64    103246.81
INDEX PARTITION            60     73304.44
LOBSEGMENT                 14        22.31
LOBINDEX                   14          .88

PCP_DOMIC

Tipo de Objeto       Cantidad Tama??o (MB)
------------------ ---------- ------------
TABLE                      51      2162219
INDEX                     119   1302202.56
TABLE PARTITION           180       110014
LOB PARTITION             240         3836
INDEX PARTITION           240           15
LOBSEGMENT                  1          .13
LOBINDEX                    1          .06


******************************************************************************************************************************************
******************************************************************************************************************************************


col TABLE_NAME format a50
col OWNER format a20
break on report
compute sum label "TOTAL_SAVE:" of SIZE_MB on report
SELECT
  t.table_name AS table_name,
  t.owner AS owner,
  ROUND(NVL(SUM(s.bytes) / 1024 / 1024, 0), 2) AS size_mb,
  t.partitioned
FROM
  dba_tables t
LEFT JOIN
  dba_segments s ON t.table_name = s.segment_name AND t.owner = s.owner
WHERE
  t.owner = 'PCP_DOMIC'
GROUP BY
  t.table_name, t.owner, t.partitioned
ORDER BY
  size_mb ASC;



******************************************************************************************************************************************
******************************************************************************************************************************************



OWNER                          OBJECT_TYPE             OBJECT_NAME                                        STATUS
------------------------------ ----------------------- -------------------------------------------------- -------
PCP                            PACKAGE BODY            PKG_OPS_MANAGEMENT                                 INVALID
PCP_DOMIC                      MATERIALIZED VIEW       EN_PAY_HOME_NOVAK_VW                               INVALID
PCP_DOMIC                      PACKAGE BODY            PKG_CST_AFILIACION_DOMIC                           INVALID
PCP_DOMIC                      PROCEDURE               GET_OPS_CONFIG                                     INVALID
PCP_DOMIC                      PROCEDURE               UPDATE_RESP_OPS_FROM_HOST                          INVALID




OWNER                          OBJECT_TYPE             OBJECT_NAME                                        STATUS
------------------------------ ----------------------- -------------------------------------------------- -------
PCP_DOMIC                      PROCEDURE               GET_OPS_CONFIG                                     INVALID
PCP_DOMIC                      PROCEDURE               PROCESAMIENTO_MASIVO1                              INVALID
PCP_DOMIC                      PROCEDURE               UPDATE_RESP_OPS_FROM_HOST                          INVALID




SET LONG 500000;
set pagesize 5000
SELECT DBMS_METADATA.GET_DDL('PROCEDURE', 'PROCESAMIENTO_MASIVO1', 'PCP_DOMIC') FROM DUAL;



BAnC0#03T8WA