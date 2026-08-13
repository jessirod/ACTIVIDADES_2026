TAMAÑOS_TBS_ITEM_DECL
******************************************************************************************
PRD
******************************************************************************************

SELECT 
    DISTINCT TABLESPACE_NAME
FROM 
    DBA_SEGMENTS 
WHERE 
    SEGMENT_NAME = 'ITEM_DECLARACION' 
ORDER BY 
    TABLESPACE_NAME;


TABLESPACE_NAME
------------------------------
'TB_PT_VARIOS_01'
,'TB_PT_VARIOS_02'
,'TB_PT_VARIOS_03'
,'TB_PT_VARIOS_04'
,'TB_PT_VARIOS_05'
,'TB_PT_VARIOS_06'
,'TB_PT_VARIOS_07'
,'TB_PT_VARIOS_08'
,'TB_PT_VARIOS_09'
,'TB_PT_VARIOS_10'
,'TB_PT_VARIOS_11'
,'TB_PT_VARIOS_12'
,'TS_D_MEDIUM'
,'TS_D_MEDIUM_01'
,'TS_D_REL_FACTURA'
,'TS_D_SMALL'


******************************************************************************************


SET PAGES 999
COL TABLESPACE_NAME FORMAT A40
COL "SIZE MB" FORMAT 999,999,999
COL "FREE MB" FORMAT 99,999,999
COL "% USED" FORMAT 999
SELECT TSU.TABLESPACE_NAME, CEIL(TSU.USED_MB) "SIZE MB"
, DECODE(CEIL(TSF.FREE_MB), NULL,0,CEIL(TSF.FREE_MB)) "FREE MB"
, DECODE(100 - CEIL(TSF.FREE_MB/TSU.USED_MB*100), NULL, 100,
               100 - CEIL(TSF.FREE_MB/TSU.USED_MB*100)) "% USED"
FROM (SELECT TABLESPACE_NAME, SUM(BYTES)/1024/1024 USED_MB
FROM DBA_DATA_FILES GROUP BY TABLESPACE_NAME UNION ALL
SELECT TABLESPACE_NAME || '  **TEMP**'
, SUM(BYTES)/1024/1024 USED_MB
FROM DBA_TEMP_FILES GROUP BY TABLESPACE_NAME) TSU
, (SELECT TABLESPACE_NAME, SUM(BYTES)/1024/1024 FREE_MB
FROM DBA_FREE_SPACE GROUP BY TABLESPACE_NAME) TSF
WHERE TSU.TABLESPACE_NAME = TSF.TABLESPACE_NAME (+)
and TSU.TABLESPACE_NAME in ('TB_PT_VARIOS_01'
,'TB_PT_VARIOS_02'
,'TB_PT_VARIOS_03'
,'TB_PT_VARIOS_04'
,'TB_PT_VARIOS_05'
,'TB_PT_VARIOS_06'
,'TB_PT_VARIOS_07'
,'TB_PT_VARIOS_08'
,'TB_PT_VARIOS_09'
,'TB_PT_VARIOS_10'
,'TB_PT_VARIOS_11'
,'TB_PT_VARIOS_12'
,'TS_D_MEDIUM'
,'TS_D_MEDIUM_01'
,'TS_D_REL_FACTURA'
,'TS_D_SMALL'
)
ORDER BY 1
/


TABLESPACE_NAME                               SIZE MB     FREE MB % USED
---------------------------------------- ------------ ----------- ------
TB_PT_VARIOS_01                               145,088       2,898     98
TB_PT_VARIOS_02                               116,472       4,114     96
TB_PT_VARIOS_03                                39,172       1,547     96
TB_PT_VARIOS_04                                29,956       1,655     94
TB_PT_VARIOS_05                               454,912      11,422     97
TB_PT_VARIOS_06                               158,804       4,905     96
TB_PT_VARIOS_07                               104,304      15,292     85
TB_PT_VARIOS_08                                57,460       2,929     94
TB_PT_VARIOS_09                                49,152      15,171     69
TB_PT_VARIOS_10                               161,360      20,224     87
TB_PT_VARIOS_11                                82,800       5,857     92
TB_PT_VARIOS_12                                42,460       4,847     88
TS_D_MEDIUM                                   206,504      80,296     61
TS_D_MEDIUM_01                                 35,806       8,756     75
TS_D_REL_FACTURA                              136,112      14,720     89
TS_D_SMALL                                    422,646     315,755     25


******************************************************************************************

set linesize 4000
set pages 999
col FILE_NAME format a70
col FILE_ID format 999,990
col TABLESPACE_NAME format a35
col RELATIVE_FNO format 9999
select FILE_NAME,FILE_ID,TABLESPACE_NAME, bytes/1024/1024 MB, RELATIVE_FNO,AUTOEXTENSIBLE, status
from dba_data_files
where TABLESPACE_NAME in ('TB_PT_VARIOS_01')
/




******************************************************************************************
QA
******************************************************************************************

TABLESPACE_NAME
------------------------------
TB_PT_VARIOS_01
TB_PT_VARIOS_02
TB_PT_VARIOS_03
TB_PT_VARIOS_04
TB_PT_VARIOS_05
TB_PT_VARIOS_06
TB_PT_VARIOS_07
TB_PT_VARIOS_08
TB_PT_VARIOS_09
TB_PT_VARIOS_10
TB_PT_VARIOS_11
TB_PT_VARIOS_12
TS_D_MEDIUM
TS_D_MEDIUM_01
TS_D_REL_FACTURA
TS_D_SMALL




TABLESPACE_NAME                               SIZE MB     FREE MB % USED
---------------------------------------- ------------ ----------- ------
TB_PT_VARIOS_01                               118,608      48,509     59
TB_PT_VARIOS_02                               111,472      38,240     65
TB_PT_VARIOS_03                                28,672      14,211     50
TB_PT_VARIOS_04                                19,456       5,851     69
TB_PT_VARIOS_05                               111,440      33,374     70
TB_PT_VARIOS_06                               111,440      37,822     66
TB_PT_VARIOS_07                               104,304      41,789     59
TB_PT_VARIOS_08                                14,336       5,893     58
TB_PT_VARIOS_09                                14,336       4,795     66
TB_PT_VARIOS_10                                97,120      20,123     79
TB_PT_VARIOS_11                                82,800      23,285     71
TB_PT_VARIOS_12                                20,480       5,800     71
TS_D_MEDIUM                                   206,504      94,264     54
TS_D_MEDIUM_01                                 35,806       9,176     74
TS_D_REL_FACTURA                              121,776      13,824     88
TS_D_SMALL                                    422,646     317,897     24



select /*+PARALLEL (8) */  count(1)
from 
dbo.item_declaracion;



select /*+PARALLEL (8) */  count(1)
from 
dbo.item_declaracion partition (P202606);



select /*+PARALLEL (8) */  count(1)
from 
dbo.item_declaracion partition (P202607);



CREATE TABLE dbo.item_declaracion_06 AS 
SELECT *
FROM dbo.item_declaracion 
partition (P202606);


select /*+PARALLEL (8) */  count(1)
from 
dbo.item_declaracion_06;


CREATE TABLE dbo.item_declaracion_07 AS 
SELECT *
FROM dbo.item_declaracion 
partition (P202607);


select /*+PARALLEL (8) */  count(1)
from 
dbo.item_declaracion_07;



ALTER TABLE dbo.item_declaracion TRUNCATE PARTITION P202606 UPDATE GLOBAL INDEXES;

ALTER TABLE dbo.item_declaracion TRUNCATE PARTITION P202607 UPDATE GLOBAL INDEXES;


******************************************************************************************

******************************************************************************************

******************************************************************************************


/rman3/ITEM_DECL_07_06_2026

CREATE OR REPLACE DIRECTORY IMPORT AS '/rman3/EXP_DBO_ITM_2026';
GRANT READ,WRITE ON DIRECTORY IMPORT TO SYS;



******************************************************************************************

******************************************************************************************


-- 1. Objetos de código que dependen de la tabla (Vistas, Paquetes, Funciones, etc.)
SELECT OWNER, NAME AS OBJETO, TYPE AS TIPO, 'NA' as STATUS 
FROM DBA_DEPENDENCIES
WHERE REFERENCED_NAME = 'ITEM_DECLARACION' AND REFERENCED_TYPE = 'TABLE'
UNION ALL
-- 2. Índices asociados a la tabla
SELECT OWNER, INDEX_NAME AS OBJETO, 'INDEX' AS TIPO, STATUS 
FROM DBA_INDEXES
WHERE TABLE_NAME = 'ITEM_DECLARACION'
UNION ALL
-- 3. Triggers asociados a la tabla
SELECT OWNER, TRIGGER_NAME AS OBJETO, 'TRIGGER' AS TIPO, STATUS 
FROM DBA_TRIGGERS
WHERE TABLE_NAME = 'ITEM_DECLARACION'
UNION ALL
-- 4. Constraints / Restricciones (Llaves primarias, foráneas, etc.)
SELECT OWNER, CONSTRAINT_NAME AS OBJETO, 'CONSTRAINT ('||CONSTRAINT_TYPE||')' AS TIPO, STATUS 
FROM DBA_CONSTRAINTS
WHERE TABLE_NAME = 'ITEM_DECLARACION'
ORDER BY TIPO, OBJETO;


OWNER                          OBJETO                         TIPO               STATUS
------------------------------ ------------------------------ ------------------ --------
DBO                            SYS_C0051920                   CONSTRAINT (C)     ENABLED
DBO                            SYS_C0051921                   CONSTRAINT (C)     ENABLED
SERVICIOWEB                    BUSCA_MONTO_ITEM               FUNCTION           NA
DISCOV                         FN_BUSCA_VALOR_ITEM            FUNCTION           NA
DBO                            F_CALCULA_21M                  FUNCTION           NA
DBO                            F_CALCULA_22M                  FUNCTION           NA
DBO                            IDX_PERIODO_DECLARACION        INDEX              N/A
DBO                            PK_ITEM_DECLARACION_P          INDEX              VALID
ETAMARA                        DEC_NATURAL_ORG                MATERIALIZED VIEW  NA
DATOSCONTRIBUYENTE             ITEMS_DEC_2008_HOY             MATERIALIZED VIEW  NA
DBO                            ITEM_711_143                   MATERIALIZED VIEW  NA
DATOSCONTRIBUYENTE             VM_DESGRAVAMEN                 MATERIALIZED VIEW  NA
DBO                            VM_ITEMS_IMP_25                MATERIALIZED VIEW  NA
RARENAS                        VM_ITEMS_IMP_25                MATERIALIZED VIEW  NA
RARENAS                        VM_ITEMS_IMP_25_1              MATERIALIZED VIEW  NA
DATOSCONTRIBUYENTE             VM_ITEM_135                    MATERIALIZED VIEW  NA
DATOSCONTRIBUYENTE             VM_ITEM_137                    MATERIALIZED VIEW  NA
CONSULTORPAR                   VM_ITEM_DICOM1                 MATERIALIZED VIEW  NA
DBO                            PKG_MIGRA_IVA_BSF              PACKAGE            NA
DBO                            PKG_MIGRA_SIVIT_25_NUEVO       PACKAGE            NA
DBO                            PKG_MIGRA_SIVIT_26_NUEVO       PACKAGE            NA
DBO                            PKG_CESIONES_UTILIZADAS        PACKAGE BODY       NA
DBO                            PKG_CONSULTA_IVA               PACKAGE BODY       NA
DBO                            PKG_CONSULTA_NOTIF_CONTRIB     PACKAGE BODY       NA
DBO                            PKG_CORRIGE_DEC_IVA            PACKAGE BODY       NA
DBO                            PKG_DECLARACION                PACKAGE BODY       NA
DBO                            PKG_DECLARACION2               PACKAGE BODY       NA
DBO                            PKG_DECLARACION_IVA            PACKAGE BODY       NA
DBO                            PKG_ESTADISTICAS               PACKAGE BODY       NA
DBO                            PKG_ITF                        PACKAGE BODY       NA
ITF                            PKG_ITF                        PACKAGE BODY       NA
ITFRESPALDO                    PKG_ITF                        PACKAGE BODY       NA
DBO                            PKG_IVA                        PACKAGE BODY       NA
DBO                            PKG_MIGRA_DECLARACIONES        PACKAGE BODY       NA
DBO                            PKG_MIGRA_DECLARACIONES_BSF    PACKAGE BODY       NA
DBO                            PKG_MIGRA_ISLR_SIVIT_25        PACKAGE BODY       NA
DBO                            PKG_MIGRA_ISLR_SIVIT_251       PACKAGE BODY       NA
DBO                            PKG_MIGRA_ISLR_SIVIT_26        PACKAGE BODY       NA
DBO                            PKG_MIGRA_IVA_BFUERTE          PACKAGE BODY       NA
DBO                            PKG_MIGRA_IVA_BSF              PACKAGE BODY       NA
DBO                            PKG_MIGRA_IVA_BSF_NUEVO        PACKAGE BODY       NA
DBO                            PKG_MIGRA_IVA_CE               PACKAGE BODY       NA
DBO                            PKG_MIGRA_IVA_D                PACKAGE BODY       NA
DBO                            PKG_MIGRA_IVA_D1               PACKAGE BODY       NA
DBO                            PKG_MIGRA_IVA_MR               PACKAGE BODY       NA
DBO                            PKG_MIGRA_RET_SIVIT_11         PACKAGE BODY       NA
DBO                            PKG_MIGRA_RET_SIVIT_11P        PACKAGE BODY       NA
DBO                            PKG_MIGRA_SIVIT_25_NUEVO       PACKAGE BODY       NA
DBO                            PKG_MIGRA_SIVIT_25_PORCION     PACKAGE BODY       NA
DBO                            PKG_MIGRA_SIVIT_26_NUEVO       PACKAGE BODY       NA
DBO                            PKG_MIGRA_SIVIT_26_PORCION     PACKAGE BODY       NA
DBO                            PKG_NOTIFICACION_CONTRIBUYENTE PACKAGE BODY       NA
DBO                            PKG_PROCESO_TRANSACCIONAL      PACKAGE BODY       NA
DBO                            PKG_PRUEBA                     PACKAGE BODY       NA
DBO                            PKG_REPORTES_IVA               PACKAGE BODY       NA
DBO                            PKG_SALDO_RECUPERA_IVA         PACKAGE BODY       NA
DBO                            PKG_SALDO_RECUPERA_IVA_B       PACKAGE BODY       NA
DBO                            PKG_SALDO_RECUPERA_IVA_PRU     PACKAGE BODY       NA
DBO                            PKG_SALDO_RECUPERA_IVA_R       PACKAGE BODY       NA
DBO                            PKG_SELECCION_PREVIA           PACKAGE BODY       NA
DBO                            PKG_SORTEO                     PACKAGE BODY       NA
DBO                            PKG_TRANSACCION                PACKAGE BODY       NA
DBO                            PKG_UTILITY_CESIONES           PACKAGE BODY       NA
DBO                            PKG_WEB_SERVICES_DECLARACION   PACKAGE BODY       NA
DBO                            ACTUALIZA_PERIODO              PROCEDURE          NA
DBO                            ACTUALIZA_PERIODO2             PROCEDURE          NA
DBO                            CALCULAR_ITEM_90               PROCEDURE          NA
DBO                            CONSULTA_ING_BRUTOS_IRR        PROCEDURE          NA
DBO                            INSERTAESCENA                  PROCEDURE          NA
DBO                            P_ACTUALIZA_74R_0_Y_90_0       PROCEDURE          NA
DBO                            P_ACTUALIZA_74_0_Y_90_0        PROCEDURE          NA
DBO                            P_ACTUALIZA_74_200606          PROCEDURE          NA
DBO                            P_ACTUALIZA_74_MAYORY90        PROCEDURE          NA
DBO                            P_ACTUALIZA_74_MENOR_55        PROCEDURE          NA
DBO                            P_ACTUALIZA_ITEM_N             PROCEDURE          NA
DBO                            P_ACT_ITEM_BSF                 PROCEDURE          NA
DBO                            P_BORRA_DEC_INCONSISTENTE      PROCEDURE          NA
DBO                            P_BORRA_DEC_INCONSISTENTE_ANT  PROCEDURE          NA
DBO                            P_CONS_BORRA_PROCESA_DEC       PROCEDURE          NA
DBO                            P_CORRIGE_DEC_IVA_BSF          PROCEDURE          NA
DBO                            P_CORRIGE_DEC_IVA_BSF_1        PROCEDURE          NA
DBO                            P_CORRIGE_DEC_IVA_FORMAL       PROCEDURE          NA
DBO                            P_CORRIGE_ITEM_20              PROCEDURE          NA
DBO                            P_GENERA_66BSF                 PROCEDURE          NA
DBO                            P_GENERA_66NUEVO               PROCEDURE          NA
DBO                            P_GENERA_OMISOS_DEC_ETAMARA    PROCEDURE          NA
DBO                            P_GENERA_OMISOS_DEC_RARENAS    PROCEDURE          NA
DBO                            P_INSERTA_ITEM                 PROCEDURE          NA
DBO                            P_PROC_ITEM_CORRIGE_IVA        PROCEDURE          NA
DBO                            P_PROC_ITEM_CORRIGE_IVA_FORMAL PROCEDURE          NA
DBO                            P_PRUEBA10_FPENA               PROCEDURE          NA
DBO                            P_PRUEBA11_FPENA               PROCEDURE          NA
DBO                            P_PRUEBA12_FPENA               PROCEDURE          NA
DBO                            P_RECONV_ITEM_DEC              PROCEDURE          NA
DBO                            P_REGISTRA_DECLARACION30       PROCEDURE          NA
DBO                            P_REPARA_66N                   PROCEDURE          NA
PENTAHO                        TOPENTAHO_DBO_ITEM_DECLA       PROCEDURE          NA
PUBLIC                         ITEM_DECLARACION               SYNONYM            NA
DBO                            TRG_ACT_PERIODO_ITEM_DEC_DEC   TRIGGER            NA
AIRFLOW                        TRG_CDC_ITEM_DECLARACION       TRIGGER            ENABLED
AIRFLOW                        TRG_CDC_ITEM_DECLARACION       TRIGGER            NA
IMPEX                          TRG_ITEM_DEC_BE_IMPEX          TRIGGER            NA
IMPEX                          TRG_ITEM_DEC_BE_IMPEX          TRIGGER            ENABLED
DBO                            TRG_VERIFICA_ACT_DECLARACION   TRIGGER            NA
DBO                            ITEM_DECLARACION_ISLR          VIEW               NA


******************************************************************************************
******************************************************************************************
