INTTEGRIO QA
********************************************************************************************************************************************
TUCITRANSACCIONESDIA
********************************************************************************************************************************************

CREATE TABLE "INTTEGRIOBDV"."TUCITRANSACCIONESDIA"
   (    "NUMEROMENSAJE" VARCHAR2(30) NOT NULL ENABLE,
        "FREAL" TIMESTAMP (6) DEFAULT Systimestamp,
        "FCONTABLE" DATE,
        "CPERSONA_COMPANIA" NUMBER(8,0),
        "COFICINA" NUMBER(4,0),
        "CSUCURSAL" NUMBER(4,0),
        "CUSUARIO" VARCHAR2(12),
        "CCUENTA" VARCHAR2(20),
        "NUMERODOCUMENTO" VARCHAR2(30),
        "VALOR" NUMBER(19,6),
        "CSUBSISTEMA" VARCHAR2(2),
        "CTRANSACCION" VARCHAR2(4),
        "VERSIONTRANSACCION" VARCHAR2(2),
        "REVERSADA_DESTINO" VARCHAR2(1) DEFAULT '0',
        "REVERSADA_COPIA" VARCHAR2(1) DEFAULT '0',
        "REVERSO" VARCHAR2(1) DEFAULT '0',
        "AUTORIZAREVERSO" VARCHAR2(1) DEFAULT '0',
        "CUSUARIO_AUTORIZA" VARCHAR2(19),
        "CMONEDA" VARCHAR2(3),
        "DETALLEREVERSO" VARCHAR2(60),
        "CUSUARIO_NIEGA" VARCHAR2(19),
        "DETALLENEGARREVERSO" VARCHAR2(60),
        "NEGARREVERSO" VARCHAR2(1),
        "FACCIONREVERSO" TIMESTAMP (6),
         CONSTRAINT "CKREVERSADA_DESTINOUCITRAN" CHECK (REVERSADA_DESTINO is null or (REVERSADA_DESTINO = upper(REVERSADA_DESTINO) and REVERSADA_DESTINO in ('1','0'))) ENABLE NOVALIDATE,
         CONSTRAINT "CKREVERSOUCITRAN" CHECK (REVERSO is null or (REVERSO = upper(REVERSO) and REVERSO in ('1','0'))) ENABLE NOVALIDATE,
         CONSTRAINT "CKAUTORIZAREVERSO" CHECK (AUTORIZAREVERSO is null or (AUTORIZAREVERSO = upper(AUTORIZAREVERSO) and AUTORIZAREVERSO in ('1','0'))) ENABLE NOVALIDATE,
         CONSTRAINT "CKREVERSADA_COPIAUCITRAN" CHECK (REVERSADA_COPIA is null or (REVERSADA_COPIA = upper(REVERSADA_COPIA) and REVERSADA_COPIA in ('1','0'))) ENABLE NOVALIDATE,
         CONSTRAINT "FKUCITRADIAMON" FOREIGN KEY ("CMONEDA")
          REFERENCES "INTTEGRIOBDV"."TMONEDASID" ("CMONEDA") ENABLE,
         CONSTRAINT "FKUCITRADIACTA" FOREIGN KEY ("CCUENTA", "CPERSONA_COMPANIA")
          REFERENCES "INTTEGRIOBDV"."TCUENTAID" ("CCUENTA", "CPERSONA_COMPANIA") ENABLE,
         CONSTRAINT "FKUCITRADIAOFISUC" FOREIGN KEY ("CPERSONA_COMPANIA", "COFICINA", "CSUCURSAL")
          REFERENCES "INTTEGRIOBDV"."TOFICINASSUCURSAL" ("CPERSONA_COMPANIA", "COFICINA", "CSUCURSAL") ENABLE
   ) SEGMENT CREATION IMMEDIATE
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 262144 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TRANSACTIONS"  ENABLE ROW MOVEMENT ;
  CREATE UNIQUE INDEX "INTTEGRIOBDV"."IPKUCITRANDIA" ON "INTTEGRIOBDV"."TUCITRANSACCIONESDIA" ("NUMEROMENSAJE")
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
  STORAGE(INITIAL 196608 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TRANSACTIONS_IDX" ;
ALTER TABLE "INTTEGRIOBDV"."TUCITRANSACCIONESDIA" ADD CONSTRAINT "IPKUCITRANDIA" PRIMARY KEY ("NUMEROMENSAJE")
  USING INDEX "INTTEGRIOBDV"."IPKUCITRANDIA"  ENABLE;

********************************************************************************************************************************************
TLOTEMENSAJES
********************************************************************************************************************************************

CREATE TABLE "INTTEGRIOBDV"."TLOTEMENSAJES"
   (    "FECHALOTE" DATE NOT NULL ENABLE,
        "NUMEROLOTE" NUMBER(10,0) NOT NULL ENABLE,
        "CPERSONA_COMPANIA" NUMBER(8,0) NOT NULL ENABLE,
        "CUSUARIO_PROCESO" VARCHAR2(12),
        "FPROCESO" DATE,
        "NUMEROERRORESPROCESO" NUMBER(5,0),
        "ESTATUS" VARCHAR2(1),
        "COMENTARIOS" VARCHAR2(500),
        "CSUBSISTEMA" VARCHAR2(2) NOT NULL ENABLE,
        "CTRANSACCION" VARCHAR2(4) NOT NULL ENABLE,
        "VERSIONTRANSACCION" VARCHAR2(2) NOT NULL ENABLE,
        "CPERSONA_COMPANIAORIGEN" NUMBER(8,0) CONSTRAINT "CK_CPERSONA_COMPANIAORIGEN" NOT NULL ENABLE,
        "CSUCURSAL_ORIGEN" NUMBER(4,0) CONSTRAINT "CK_CSUCURSAL_ORIGEN" NOT NULL ENABLE,
        "COFICINA_ORIGEN" NUMBER(4,0) CONSTRAINT "CK_COFICINA_ORIGEN" NOT NULL ENABLE,
        "CESTRUCTURA" VARCHAR2(20) NOT NULL ENABLE,
        "CTIPOLOTE" VARCHAR2(4),
        "NUMEROREGISTROSPROCESADOS" NUMBER(5,0),
        "VERSIONCONTROL" NUMBER(22,0) DEFAULT 0,
        "IDENTIFICADOR" VARCHAR2(100),
         CONSTRAINT "CKESTATUSTLOTEMEN" CHECK (ESTATUS is null or (ESTATUS in ('P','N','E'))) ENABLE,
         CONSTRAINT "CKESTATUSLOTEMSG" CHECK (ESTATUS is null or ( ESTATUS in ('P','N','E'))) ENABLE NOVALIDATE,
         CONSTRAINT "FKLOTMSGENCAB" FOREIGN KEY ("CPERSONA_COMPANIAORIGEN", "COFICINA_ORIGEN", "CSUCURSAL_ORIGEN")
          REFERENCES "INTTEGRIOBDV"."TOFICINASSUCURSAL" ("CPERSONA_COMPANIA", "COFICINA", "CSUCURSAL") ENABLE,
         CONSTRAINT "FKLOTMENTIPLOT" FOREIGN KEY ("CPERSONA_COMPANIA", "CTIPOLOTE")
          REFERENCES "INTTEGRIOBDV"."TTIPOSLOTEID" ("CPERSONA_COMPANIA", "CTIPOLOTE") ENABLE
   ) SEGMENT CREATION IMMEDIATE
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "INTTEGRIO_DATA"  ENABLE ROW MOVEMENT ;
  CREATE UNIQUE INDEX "INTTEGRIOBDV"."IPKLOTEMSG" ON "INTTEGRIOBDV"."TLOTEMENSAJES" ("FECHALOTE", "NUMEROLOTE")
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "INTTEGRIO_IDX" ;
ALTER TABLE "INTTEGRIOBDV"."TLOTEMENSAJES" ADD CONSTRAINT "IPKLOTEMENSAJES" PRIMARY KEY ("FECHALOTE", "NUMEROLOTE")
  USING INDEX "INTTEGRIOBDV"."IPKLOTEMSG"  ENABLE;


********************************************************************************************************************************************
TLOTEVALIDACAMPOSDETALLE
********************************************************************************************************************************************

  CREATE TABLE "INTTEGRIOBDV"."TLOTEVALIDACAMPOSDETALLE"
   (    "NUMEROLOTE" NUMBER(4,0) NOT NULL ENABLE,
        "FECHALOTE" DATE NOT NULL ENABLE,
        "STRANSACCION" NUMBER(7,0) NOT NULL ENABLE,
        "SVALIDACAMPOSDETALLE" NUMBER(4,0) CONSTRAINT "CK_SVALIDACAMPOSDETALLE" NOT NULL ENABLE,
        "CODIGORESULTADO" VARCHAR2(80),
        "TEXTOERROR" VARCHAR2(200),
         CONSTRAINT "FKLOTVALCAMPDET" FOREIGN KEY ("NUMEROLOTE", "FECHALOTE", "STRANSACCION")
          REFERENCES "INTTEGRIOBDV"."TLOTEMENSAJESDETALLE" ("NUMEROLOTE", "FECHALOTE", "STRANSACCION") ENABLE
   ) SEGMENT CREATION IMMEDIATE
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "INTTEGRIO_DATA"  ENABLE ROW MOVEMENT ;
  CREATE UNIQUE INDEX "INTTEGRIOBDV"."IPKLOTVALCAMPDET" ON "INTTEGRIOBDV"."TLOTEVALIDACAMPOSDETALLE" ("NUMEROLOTE", "FECHALOTE", "STRANSACCION", "SVALIDACAMPOSDETALLE")
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "INTTEGRIO_IDX" ;
ALTER TABLE "INTTEGRIOBDV"."TLOTEVALIDACAMPOSDETALLE" ADD CONSTRAINT "IPKLOTVALCAMPDET" PRIMARY KEY ("NUMEROLOTE", "FECHALOTE", "STRANSACCION", "SVALIDACAMPOSDETALLE")
  USING INDEX "INTTEGRIOBDV"."IPKLOTVALCAMPDET"  ENABLE;





********************************************************************************************************************************************
TAMAÑO_TBS
********************************************************************************************************************************************
Name                                                                                        Size_(MB)  Used_(MB)  Free_(MB)     %_Free
------------------------------------------------------------------------------------------ ---------- ---------- ---------- ----------
MSGDETAILDEVICE_IDX                                                                         425974.94  418722.88    7252.06        1.7
MOVIMIENTOS                                                                                 425973.95  287253.14  138720.81      32.57
MOVIMIENTOS_IDX                                                                             423924.98  285446.11  138478.88      32.67
SYSAUX                                                                                      349411.91  106194.72  243217.19      69.61
TRANSACTIONS                                                                                294911.86  256495.36    38416.5      13.03
MSGDETAILDEVICE                                                                             262139.94  252890.63    9249.31       3.53
INTTEGRIO_DATA                                                                              260093.97  247678.16   12415.81       4.77
UNDOTBS1                                                                                    233465.98    4621.36  228844.63      98.02
SALDOS_IDX                                                                                     196602  129445.06   67156.94      34.16
INTTEGRIO_IDX                                                                               163837.95  163508.45      329.5         .2
SALDOS                                                                                       98301.98   75497.05   22804.94       23.2
PERSONAS                                                                                        98301      64686      33615       34.2
CUENTAS                                                                                         98301      61296      37005      37.64
LOGMSG                                                                                          65534      51032      14502      22.13
UNDOTBS2                                                                                        45056    7018.88   38037.13      84.42
PERSONAS_IDX                                                                                    44032   41234.94    2797.06       6.35
LOGMSG_IDX                                                                                      38912   36582.44    2329.56       5.99
CUENTAS_IDX                                                                                     31744   29789.19    1954.81       6.16
NATURAL                                                                                         31744      29392       2352       7.41
JURIDICO                                                                                        23552      22202       1350       5.73
COEXISTENCIA                                                                                    22528       6266      16262      72.19
ID_IDX                                                                                          13312   11838.44    1473.56      11.07
COEXISTENCIA_IDX                                                                                 8192     133.63    8058.38      98.37
NATURAL_IDX                                                                                      7168       6155       1013      14.13
IDTBS                                                                                            7168    5469.38    1698.63       23.7
SYSTEM                                                                                           6144    1961.88    4182.13      68.07
TRANSACTIONS_IDX                                                                                 4096       3017       1079      26.34
TBSFECHAS_IDX                                                                                    3072    1031.31    2040.69      66.43
CTASALPROMEDIO                                                                                   2048       2.44    2045.56      99.88
TBSFECHAS                                                                                        2048     732.69    1315.31      64.22
CTASALPROMEDIO_IDX                                                                               2048       2.13    2045.88       99.9
JURIDICO_IDX                                                                                     1124     157.94     966.06      85.95
INTTEGRIOBDV_TABLES_Q                                                                             300         30        270         90
INTTEGRIOBDV_INDEX_Q                                                                              180         18        162         90
THISTORICOTECLEO                                                                                  100          1         99         99
USERS                                                                                               5       2.69       2.31      46.25


********************************************************************************************************************************************
INDEX_TUCITRANSACCIONESDIA
********************************************************************************************************************************************

OWNER                INDEX_NAME                               INDEX_TYPE      TABLESPACE_NAME                          STATUS
-------------------- ---------------------------------------- --------------- ---------------------------------------- --------------------
INTTEGRIOBDV         IPKUCITRANDIA                            NORMAL          TRANSACTIONS_IDX                         VALID


COLUMN_NAME                              INDEX_NAME                               COLUMN_POSITION
---------------------------------------- ---------------------------------------- ---------------
NUMEROMENSAJE                            IPKUCITRANDIA                                          1


********************************************************************************************************************************************
INDEX_TLOTEMENSAJES
********************************************************************************************************************************************


OWNER                INDEX_NAME                               INDEX_TYPE      TABLESPACE_NAME                          STATUS
-------------------- ---------------------------------------- --------------- ---------------------------------------- --------------------
INTTEGRIOBDV         IPKLOTEMSG                               NORMAL          INTTEGRIO_IDX                            VALID


COLUMN_NAME                              INDEX_NAME                               COLUMN_POSITION
---------------------------------------- ---------------------------------------- ---------------
FECHALOTE                                IPKLOTEMSG                                             1
NUMEROLOTE                               IPKLOTEMSG                                             2



********************************************************************************************************************************************
INDEX_TLOTEVALIDACAMPOSDETALLE
********************************************************************************************************************************************

OWNER                INDEX_NAME                               INDEX_TYPE      TABLESPACE_NAME                          STATUS
-------------------- ---------------------------------------- --------------- ---------------------------------------- --------------------
INTTEGRIOBDV         IPKLOTVALCAMPDET                         NORMAL          INTTEGRIO_IDX                            VALID


COLUMN_NAME                              INDEX_NAME                               COLUMN_POSITION
---------------------------------------- ---------------------------------------- ---------------
FECHALOTE                                IPKLOTVALCAMPDET                                       2
NUMEROLOTE                               IPKLOTVALCAMPDET                                       1
STRANSACCION                             IPKLOTVALCAMPDET                                       3
SVALIDACAMPOSDETALLE                     IPKLOTVALCAMPDET                                       4


********************************************************************************************************************************************
CONSTRAINT_TUCITRANSACCIONESDIA
********************************************************************************************************************************************

OWNER                CONSTRAINT_NAME                          INDEX_NAME      TABLE_NAME                               STATUS               CON
-------------------- ---------------------------------------- --------------- ---------------------------------------- -------------------- ---
INTTEGRIOBDV         FKUCITRADIAMON                                           TUCITRANSACCIONESDIA                     ENABLED              R
INTTEGRIOBDV         FKUCITRADIACTA                                           TUCITRANSACCIONESDIA                     ENABLED              R
INTTEGRIOBDV         FKUCITRADIAOFISUC                                        TUCITRANSACCIONESDIA                     ENABLED              R
INTTEGRIOBDV         CKREVERSADA_DESTINOUCITRAN                               TUCITRANSACCIONESDIA                     ENABLED              C
INTTEGRIOBDV         CKREVERSOUCITRAN                                         TUCITRANSACCIONESDIA                     ENABLED              C
INTTEGRIOBDV         CKAUTORIZAREVERSO                                        TUCITRANSACCIONESDIA                     ENABLED              C
INTTEGRIOBDV         CKREVERSADA_COPIAUCITRAN                                 TUCITRANSACCIONESDIA                     ENABLED              C
INTTEGRIOBDV         SYS_C0074910                                             TUCITRANSACCIONESDIA                     ENABLED              C
INTTEGRIOBDV         IPKUCITRANDIA                            IPKUCITRANDIA   TUCITRANSACCIONESDIA                     ENABLED              P

********************************************************************************************************************************************
CONSTRAINT_TLOTEMENSAJES
********************************************************************************************************************************************

OWNER                CONSTRAINT_NAME                          INDEX_NAME      TABLE_NAME                               STATUS               CON
-------------------- ---------------------------------------- --------------- ---------------------------------------- -------------------- ---
INTTEGRIOBDV         FKLOTMSGENCAB                                            TLOTEMENSAJES                            ENABLED              R
INTTEGRIOBDV         FKLOTMENTIPLOT                                           TLOTEMENSAJES                            ENABLED              R
INTTEGRIOBDV         CKESTATUSTLOTEMEN                                        TLOTEMENSAJES                            ENABLED              C
INTTEGRIOBDV         CKESTATUSLOTEMSG                                         TLOTEMENSAJES                            ENABLED              C
INTTEGRIOBDV         SYS_C0068573                                             TLOTEMENSAJES                            ENABLED              C
INTTEGRIOBDV         SYS_C0068574                                             TLOTEMENSAJES                            ENABLED              C
INTTEGRIOBDV         SYS_C0068575                                             TLOTEMENSAJES                            ENABLED              C
INTTEGRIOBDV         SYS_C0068576                                             TLOTEMENSAJES                            ENABLED              C
INTTEGRIOBDV         SYS_C0068577                                             TLOTEMENSAJES                            ENABLED              C
INTTEGRIOBDV         SYS_C0068578                                             TLOTEMENSAJES                            ENABLED              C
INTTEGRIOBDV         CK_CPERSONA_COMPANIAORIGEN                               TLOTEMENSAJES                            ENABLED              C
INTTEGRIOBDV         CK_CSUCURSAL_ORIGEN                                      TLOTEMENSAJES                            ENABLED              C
INTTEGRIOBDV         CK_COFICINA_ORIGEN                                       TLOTEMENSAJES                            ENABLED              C
INTTEGRIOBDV         SYS_C0068582                                             TLOTEMENSAJES                            ENABLED              C
INTTEGRIOBDV         IPKLOTEMENSAJES                          IPKLOTEMSG      TLOTEMENSAJES                            ENABLED              P

********************************************************************************************************************************************
CONSTRAINT_TLOTEVALIDACAMPOSDETALLE
********************************************************************************************************************************************

OWNER                CONSTRAINT_NAME                          INDEX_NAME      TABLE_NAME                               STATUS               CON
-------------------- ---------------------------------------- --------------- ---------------------------------------- -------------------- ---
INTTEGRIOBDV         FKLOTVALCAMPDET                                          TLOTEVALIDACAMPOSDETALLE                 ENABLED              R
INTTEGRIOBDV         SYS_C0068047                                             TLOTEVALIDACAMPOSDETALLE                 ENABLED              C
INTTEGRIOBDV         SYS_C0068048                                             TLOTEVALIDACAMPOSDETALLE                 ENABLED              C
INTTEGRIOBDV         SYS_C0068049                                             TLOTEVALIDACAMPOSDETALLE                 ENABLED              C
INTTEGRIOBDV         CK_SVALIDACAMPOSDETALLE                                  TLOTEVALIDACAMPOSDETALLE                 ENABLED              C
INTTEGRIOBDV         IPKLOTVALCAMPDET                         IPKLOTVALCAMPDE TLOTEVALIDACAMPOSDETALLE                 ENABLED              P


********************************************************************************************************************************************
TAMAÑO_TABLAS
********************************************************************************************************************************************

OWNER                          SEGMENT_NAME                        SEGMENT_TYPE                                           SEG_SIZE_GB
------------------------------ ----------------------------------- ------------------------------------------------------ -----------
INTTEGRIOBDV                   TLOTEMENSAJES                       TABLE                                                   .001953125
INTTEGRIOBDV                   TUCITRANSACCIONESDIA                TABLE                                                   2.72857666
INTTEGRIOBDV                   TLOTEVALIDACAMPOSDETALLE            TABLE                                                   .000061035

********************************************************************************************************************************************




INTTEGRIO PRD
********************************************************************************************************************************************

********************************************************************************************************************************************

OWNER                TABLE_NAME                               COLUMN_NAME                              SEGMENT_NAME                             INDEX_NAME
-------------------- ---------------------------------------- ---------------------------------------- ---------------------------------------- ----------------------------------------
INTTEGRIOBDV         TDISPOSITIVOMENSAJES                     MENSAJE                                  SYS_LOB0000432740C00011$$                SYS_IL0000432740C00011$$
INTTEGRIOBDV         TTRANSACCIONESRUTEADAS                   TRAMA_DESTINO                            SYS_LOB0000432798C00012$$                SYS_IL0000432798C00012$$
