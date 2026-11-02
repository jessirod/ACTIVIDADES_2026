CREATE TABLE PCP.LOG
(
  ID_LOG        NUMBER(18) GENERATED ALWAYS AS IDENTITY ( START WITH 14671179 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER NOKEEP NOSCALE) NOT NULL,
  LOG_DATE      DATE                            NOT NULL,
  LOG_MESSAGES  VARCHAR2(350 BYTE)
)
TABLESPACE DATA
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOLOGGING 
NOCOMPRESS 
NOCACHE;


CREATE UNIQUE INDEX PCP.ID_LOG_IDX ON PCP.LOG
(ID_LOG)
NOLOGGING
TABLESPACE INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );

ALTER TABLE PCP.LOG ADD (
  CONSTRAINT ID_LOG_IDX
  PRIMARY KEY
  (ID_LOG)
  USING INDEX PCP.ID_LOG_IDX
  ENABLE VALIDATE);


DROP SEQUENCE PCP.ISEQ$$_160223;

-- Sequence ISEQ$$_160223 is created automatically by Oracle for use with an Identity column


CREATE TABLE PCP.LOG_CCE
(
  ID_LOG        NUMBER(18) GENERATED ALWAYS AS IDENTITY ( START WITH 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER NOKEEP NOSCALE) NOT NULL,
  LOG_DATE      DATE                            NOT NULL,
  LOG_MESSAGES  VARCHAR2(200 BYTE)
)
TABLESPACE DATA
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOLOGGING 
NOCOMPRESS 
NOCACHE;


CREATE UNIQUE INDEX PCP.SYS_C0027699 ON PCP.LOG_CCE
(ID_LOG)
NOLOGGING
TABLESPACE INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );

ALTER TABLE PCP.LOG_CCE ADD (
  CONSTRAINT SYS_C0027699
  PRIMARY KEY
  (ID_LOG)
  USING INDEX
    TABLESPACE INDX
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE);


DROP SEQUENCE PCP.ISEQ$$_160230;

-- Sequence ISEQ$$_160230 is created automatically by Oracle for use with an Identity column




CREATE TABLE PCP.AUDI_PROGRAMS
(
  ID_AUDI_PROGRAMS    NUMBER(18) GENERATED ALWAYS AS IDENTITY ( START WITH 887122581 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER NOKEEP NOSCALE) NOT NULL,
  ID_NUM_REQUEST      VARCHAR2(58 BYTE),
  PROGRAM_NAME        VARCHAR2(65 BYTE)         NOT NULL,
  EXCEPTION_MENSSAGE  VARCHAR2(1026 BYTE),
  INFO_MENSSAGE       VARCHAR2(3000 BYTE),
  CODE                NUMBER(10),
  RECORD_ENTRY_DATE   DATE                      DEFAULT sysdate
)
TABLESPACE DATA
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
NOLOGGING 
NOCOMPRESS 
NOCACHE;


ALTER TABLE PCP.AUDI_PROGRAMS ADD (
  PRIMARY KEY
  (ID_AUDI_PROGRAMS)
  USING INDEX
    TABLESPACE INDX
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE);


DROP SEQUENCE PCP.ISEQ$$_160236;

-- Sequence ISEQ$$_160236 is created automatically by Oracle for use with an Identity column


CREATE INDEX PCP.AUDI_PROGRAMS_CODE ON PCP.AUDI_PROGRAMS
(CODE)
NOLOGGING
TABLESPACE INDX
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           );

--  There is no statement for index PCP.SYS_C0014321.
--  The object is created when the parent object is created.
**************************

CREATE TABLE PCP.EXCLUSIVE_CHANNEL_REG
(
  ID_EXCLUSIVE_CHANNEL_REG  NUMBER(18) GENERATED ALWAYS AS IDENTITY ( START WITH 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER NOKEEP NOSCALE) NOT NULL,
  CUSTOMER_ID               VARCHAR2(20 BYTE)   NOT NULL,
  IS_ACTIVE                 NUMBER(1)           DEFAULT 1,
  RECORD_ENTRY_DATE         DATE                DEFAULT SYSDATE
)
TABLESPACE DATA
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE;




**************************




CREATE TABLE PCP.OPS_DEBITS_TYPE
(
  ID_REGISTRO         VARCHAR2(15 BYTE),
  ID_LOTE             VARCHAR2(15 BYTE),
  NRO_LOTE            VARCHAR2(15 BYTE),
  REF_DEB_CLIENT      VARCHAR2(8 BYTE),
  REF_CRE_CLIENT      VARCHAR2(8 BYTE),
  TRANSACTION         VARCHAR2(1 BYTE),
  FECHA               VARCHAR2(10 BYTE),
  CEDULA              VARCHAR2(12 BYTE),
  TIPO_CUENTA         VARCHAR2(2 BYTE),
  NUM_CUENTA          VARCHAR2(20 BYTE),
  SERIAL_BANCO        VARCHAR2(5 BYTE),
  AMOUNT              VARCHAR2(17 BYTE),
  TIPO_OPS            VARCHAR2(1 BYTE),
  REGISTRO_RECHAZADO  VARCHAR2(2 BYTE),
  REGISTRO_VALIDADO   VARCHAR2(2 BYTE),
  FILLER              VARCHAR2(87 BYTE),
  PAYMENT_TYPE        VARCHAR2(2 BYTE),
  PRODUCT_TYPE        VARCHAR2(10 BYTE),
  TOTAL_CREDITS       VARCHAR2(12 BYTE),
  STATUS_ANTES        VARCHAR2(3 BYTE),
  B_STATUS_ANTES      VARCHAR2(3 BYTE),
  FECHA_APROBACION    VARCHAR2(25 BYTE),
  CANAL               VARCHAR2(5 BYTE),
  CURRENCY            VARCHAR2(3 BYTE)
)
TABLESPACE DATA
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE;




CREATE TABLE PCP.OPS_CRED_TYPE
(
  ID_REGISTRO     VARCHAR2(15 BYTE),
  REF_CRE_CLIENT  VARCHAR2(8 BYTE),
  TRANSACTION     VARCHAR2(1 BYTE),
  FECHA           VARCHAR2(8 BYTE),
  CEDULA          VARCHAR2(12 BYTE),
  TIPO_CUENTA     VARCHAR2(2 BYTE),
  NUM_CUENTA      VARCHAR2(20 BYTE),
  AMOUNT          VARCHAR2(17 BYTE),
  ESTATUS         NUMBER(5)
)
TABLESPACE DATA
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE;



******************************



CREATE TABLE PCP.ORDEN_REPROCESS
(
  ID_ORDEN_REPROCESS    NUMBER(18) GENERATED ALWAYS AS IDENTITY ( START WITH 1 MAXVALUE 9999999999999999999999999999 MINVALUE 1 NOCYCLE CACHE 20 NOORDER NOKEEP NOSCALE) NOT NULL,
  ID_ORDEN              NUMBER(18),
  ORIGINAL_DATE_VALUE   DATE,
  REPROCESS_DATE_VALUE  DATE
)
TABLESPACE DATA
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
           )
LOGGING 
NOCOMPRESS 
NOCACHE;


ALTER TABLE PCP.ORDEN_REPROCESS ADD (
  PRIMARY KEY
  (ID_ORDEN_REPROCESS)
  USING INDEX
    TABLESPACE INDX
    PCTFREE    10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               )
  ENABLE VALIDATE);


DROP SEQUENCE PCP.ISEQ$$_118545;

-- Sequence ISEQ$$_118545 is created automatically by Oracle for use with an Identity column


--  There is no statement for index PCP.SYS_C0013773.
--  The object is created when the parent object is created.

ALTER TABLE PCP.ORDEN_REPROCESS ADD (
  CONSTRAINT FK_ORDEN_RP 
  FOREIGN KEY (ID_ORDEN) 
  REFERENCES PCP.ORDEN (ID_ORDEN)
  ON DELETE CASCADE
  ENABLE VALIDATE);




CREATE OR REPLACE PROCEDURE PCP.ADD_EXCLUSIVE_CH_TO_CUSTOMER (p_customer_id IN  VARCHAR)
AS
BEGIN

  INSERT INTO exclusive_channel_reg (customer_id, is_active) VALUES (p_customer_id, 1);
  commit;

END;
/



******************************


set line 1000
SELECT 
    (SELECT COUNT(1) FROM dba_indexes     where owner = 'PCP') AS total_indices,
    (SELECT COUNT(1) FROM dba_constraints   where owner = 'PCP') AS total_constraints,
    (SELECT COUNT(1) FROM dba_tables    where owner = 'PCP') AS total_tables,
    (SELECT COUNT(1) FROM dba_procedures  where owner = 'PCP') AS total_procedures,
    (SELECT COUNT(1) FROM dba_objects     where owner = 'PCP' AND object_type = 'PACKAGE') AS total_packages,
    (SELECT COUNT(1) FROM dba_objects     where owner = 'PCP' and object_type = 'PACKAGE BODY') AS total_package_bodies,
    (SELECT COUNT(1) FROM dba_synonyms    where owner = 'PCP') AS total_synonyms,
    (SELECT COUNT(1) FROM dba_sequences   where SEQUENCE_OWNER = 'PCP') AS total_sequences
FROM dual;



PCPD-LINUX
TOTAL_INDICES TOTAL_CONSTRAINTS TOTAL_TABLES TOTAL_PROCEDURES TOTAL_PACKAGES TOTAL_PACKAGE_BODIES TOTAL_SYNONYMS TOTAL_SEQUENCES
------------- ----------------- ------------ ---------------- -------------- -------------------- -------------- ---------------
          157               266          118              608             15                   16              8              65


PCP_REST
TOTAL_INDICES TOTAL_CONSTRAINTS TOTAL_TABLES TOTAL_PROCEDURES TOTAL_PACKAGES TOTAL_PACKAGE_BODIES TOTAL_SYNONYMS TOTAL_SEQUENCES
------------- ----------------- ------------ ---------------- -------------- -------------------- -------------- ---------------
          150               264          117              605             14                   15              0              62


******************************

CYCLOPS_IDENTITY


COL DEFAULT_COLLATION FOR A10
COL EDITION_NAME FOR A5
COL OBJECT_NAME FOR A35
COL LAST_DDL_TIME FOR A35
COL TIMESTAMP FOR A35


SELECT * from DBA_OBJECTS where OBJECT_NAME='OPS_DEBITS_TYPE';

******************************

INDEX
TABLE
SEQUENCE
PACKAGE
PACKAGE BODY
PROCEDURE
FUNCTION
TRIGGER
LOB

INDICES
set line 300
set pagesize 300
COL OWNER FOR A15
COL OBJECT_NAME FOR A70
select OWNER, OBJECT_NAME, OBJECT_TYPE from DBA_OBJECTS where OWNER='PCP' and OBJECT_TYPE='INDEX' and OBJECT_NAME not like '%SYS%' order by OBJECT_NAME;


TABLES
set line 300
set pagesize 300
COL OWNER FOR A15
COL OBJECT_NAME FOR A60

select OWNER, OBJECT_NAME, OBJECT_TYPE from DBA_OBJECTS where OWNER='PCP' and OBJECT_TYPE='TABLE' order by OBJECT_NAME;




set line 300
set pagesize 300
COL OWNER FOR A15
COL OBJECT_NAME FOR A60
select OWNER, OBJECT_NAME, OBJECT_TYPE from DBA_OBJECTS where OWNER='PCP' and OBJECT_TYPE='PACKAGE BODY' order by OBJECT_NAME;



set line 300
set pagesize 300
COL OWNER FOR A15
COL OBJECT_NAME FOR A60
select OWNER, OBJECT_NAME, OBJECT_TYPE from DBA_OBJECTS where OWNER='PCP' and OBJECT_TYPE='CONSTRAINT' order by OBJECT_NAME;



origen 
PCP             GEN_FILES_OPS_TDA_TCP               PACKAGE BODY
PCP             TORDEN_PKG                          PACKAGE BODY
PCP             CONSULTAS_TLOTES_PKG                PACKAGE BODY
PCP             PKG_WEB_LIST                        PACKAGE BODY
PCP             CONSULTAS_LOTES_PKG                 PACKAGE BODY
PCP             PKG_CHANNELS                        PACKAGE BODY
PCP             PKG_PRODUCTS                        PACKAGE BODY
PCP             PKG_OPS_MANAGEMENT                  PACKAGE BODY
PCP             PKG_REVIEW                          PACKAGE BODY
PCP             PKG_TRANSFER_ACCOUNTS_CANAL         PACKAGE BODY
PCP             PKG_TRANSFER_ACCOUNTS_WEB           PACKAGE BODY
PCP             REPORTES_PCP_WEB                    PACKAGE BODY
PCP             PKG_TCPTDA_ALTAS_PCPWEB             PACKAGE BODY
PCP             GEN_FILES_ALTA_TDA_TCP              PACKAGE BODY
PCP             CONSULTAS_TLOTES_EMISION_PKG        PACKAGE BODY

dest 

OWNER           OBJECT_NAME                         OBJECT_TYPE
--------------- ----------------------------------- -----------------------
PCP             PKG_WEB_LIST                        PACKAGE BODY
PCP             PKG_PRODUCTS                        PACKAGE BODY
PCP             PKG_TRANSFER_ACCOUNTS_CANAL         PACKAGE BODY
PCP             GEN_FILES_ALTA_TDA_TCP              PACKAGE BODY
PCP             PKG_TRANSFER_ACCOUNTS_WEB           PACKAGE BODY
PCP             CONSULTAS_TLOTES_PKG                PACKAGE BODY
PCP             REPORTES_PCP_WEB                    PACKAGE BODY
PCP             PKG_OPS_MANAGEMENT                  PACKAGE BODY
PCP             CONSULTAS_TLOTES_EMISION_PKG        PACKAGE BODY
PCP             PKG_REVIEW                          PACKAGE BODY
PCP             TORDEN_PKG                          PACKAGE BODY
PCP             PKG_CHANNELS                        PACKAGE BODY
PCP             PKG_TCPTDA_ALTAS_PCPWEB             PACKAGE BODY
PCP             GEN_FILES_OPS_TDA_TCP               PACKAGE BODY
PCP             CONSULTAS_LOTES_PKG                 PACKAGE BODY
--PCP             MANTENIMIENTO_TABLAS_PCP_HIST_PKG   PACKAGE BODY



SELECT COUNT(1) FROM dba_constraints   where owner = 'PCP'


col CONSTRAINT_NAME format a30
col TABLE_NAME format a30
SELECT OWNER, CONSTRAINT_NAME, TABLE_NAME FROM dba_constraints where owner = 'PCP' and CONSTRAINT_NAME not like '%SYS%' order by CONSTRAINT_NAME;


dest 
OWNER           CONSTRAINT_NAME                TABLE_NAME
--------------- ------------------------------ ------------------------------
PCP             BANKING_PK                     BANKING
PCP             CHECK_TYPE_RULE_MIG            BUSINESS_RULES
PCP             COMMISSION_CONF_UK1            COMMISSION_CONF
PCP             CONSTRAINT_ADD_BENEF           BENEF
PCP             CUSTOMER_ID_CST_TEMP           ENTERPRISE_DETAIL_BACKUP
PCP             EXECUTIVE_PK                   EXECUTIVE
PCP             FK_CREDITS                     CREDITS_CHECKS_D
PCP             FK_CREDITS_DOCS_D              CREDITS_DOCS_D_AJUST
PCP             FK_CREDITS_II                  CREDITS_EXTRAS_D
PCP             FK_CREDITS_III                 CREDITS_DOCS_D
PCP             FK_DEBITS                      DEBITS_PAYROLLS_D
PCP             FK_DEBITS_II                   DEBITS_EXTRAS_D
PCP             FK_DEBITS_III                  CREDITS
PCP             FK_DEBITS_III_NEW              CREDITS_NEW
PCP             FK_ID_TORDEN_DETAIL            TORDEN_DETAIL
PCP             FK_ID_TORDEN_DETAIL_ALTA       TORDEN_DETAIL_ALTA
PCP             FK_MQ_I                        MQ_INOUT_HOST_DETAIL
PCP             FK_ORDEN                       ORDEN_DETAIL
PCP             FK_ORDEN_II                    DEBITS
PCP             FK_ORDEN_RP                    ORDEN_REPROCESS
PCP             ID_AUTH_PCP_PK                 AUTH_PCP
PCP             ID_LOG_IDX                     LOG
PCP             ID_OPS_PK                      OPS_PLANIFICATION
PCP             INDX_TRANSFERACCOUNTCUSTOMER   TRANSFER_ACCOUNTS
PCP             MESSAGES_PK                    MESSAGES
PCP             PK_COMMISSION_CONF_ID          COMMISSION_CONF
PCP             PK_ENTERPRISE_DETAIL_ID_TEMP   ENTERPRISE_DETAIL_BACKUP
PCP             PK_TORDEN_DETAIL               TORDEN_DETAIL
PCP             PK_TORDEN_DETAIL_ALTA          TORDEN_DETAIL_ALTA
PCP             PK_TRANSFER_ACCOUNT            TRANSFER_ACCOUNTS
PCP             PRODUCTSERIAL                  PRODUCTS
PCP             SEGMENTS_BANKING_ID_FK         SEGMENTS
PCP             SEGMENTS_PK                    SEGMENTS
PCP             STATUS_ID_CONVERSION_ID_PK     STATUS_CONVERSION

34 rows selected.


OWNER           CONSTRAINT_NAME                TABLE_NAME
--------------- ------------------------------ ------------------------------
PCP             BANKING_PK                     BANKING
PCP             CHECK_TYPE_RULE_MIG            BUSINESS_RULES
PCP             COMMISSION_CONF_UK1            COMMISSION_CONF
PCP             CONSTRAINT_ADD_BENEF           BENEF
PCP             CUSTOMER_ID_CST_TEMP           ENTERPRISE_DETAIL_BACKUP
PCP             EXECUTIVE_PK                   EXECUTIVE
PCP             FK_CREDITS                     CREDITS_CHECKS_D
PCP             FK_CREDITS_DOCS_D              CREDITS_DOCS_D_AJUST
PCP             FK_CREDITS_II                  CREDITS_EXTRAS_D
PCP             FK_CREDITS_III                 CREDITS_DOCS_D
PCP             FK_DEBITS                      DEBITS_PAYROLLS_D
PCP             FK_DEBITS_II                   DEBITS_EXTRAS_D
PCP             FK_DEBITS_III                  CREDITS
PCP             FK_DEBITS_IIII                 DOMIC_CREDITS
PCP             FK_ID_TORDEN_DETAIL            TORDEN_DETAIL
PCP             FK_ID_TORDEN_DETAIL_ALTA       TORDEN_DETAIL_ALTA
PCP             FK_MQ_I                        MQ_INOUT_HOST_DETAIL
PCP             FK_ORDEN                       ORDEN_DETAIL
PCP             FK_ORDEN_II                    DEBITS
PCP             FK_ORDEN_RP                    ORDEN_REPROCESS
PCP             ID_AUTH_PCP_PK                 AUTH_PCP
PCP             ID_LOG_IDX                     LOG
PCP             ID_OPS_PK                      OPS_PLANIFICATION
PCP             INDX_TRANSFERACCOUNTCUSTOMER   TRANSFER_ACCOUNTS
PCP             MESSAGES_PK                    MESSAGES
PCP             PK_COMMISSION_CONF_ID          COMMISSION_CONF
PCP             PK_ENTERPRISE_DETAIL_ID_TEMP   ENTERPRISE_DETAIL_BACKUP
PCP             PK_TORDEN_DETAIL               TORDEN_DETAIL
PCP             PK_TORDEN_DETAIL_ALTA          TORDEN_DETAIL_ALTA
PCP             PK_TRANSFER_ACCOUNT            TRANSFER_ACCOUNTS
PCP             PRODUCTSERIAL                  PRODUCTS
PCP             SEGMENTS_BANKING_ID_FK         SEGMENTS
PCP             SEGMENTS_PK                    SEGMENTS
PCP             STATUS_ID_CONVERSION_ID_PK     STATUS_CONVERSION

34 rows selected.


