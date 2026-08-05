--DROP TABLE PCP.TRACK_ORDEN_NEW CASCADE CONSTRAINTS;

CREATE TABLE PCP.TRACK_ORDEN_NEW
(
  ID_TRACK_ORDEN        NUMBER(18) DEFAULT PCP.ISEQ$$_78641.nextval NOT NULL,
  ID_ORDEN              VARCHAR2(50 BYTE)       NOT NULL,
  STATUS                NUMBER(2),
  BUSINESS_STATUS_CODE  VARCHAR2(8 BYTE),
  DESCRIPTION           VARCHAR2(255 BYTE),
  RECORD_ENTRY_DATE     DATE                    DEFAULT sysdate,
  PAYMENT_TYPE          VARCHAR2(3 BYTE),
  USUARIO               VARCHAR2(70 BYTE),
  TIPO_PAGO             VARCHAR2(2 BYTE),
  DESC_TIPO_PAGO        VARCHAR2(40 BYTE)
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
PARTITION BY RANGE (RECORD_ENTRY_DATE)
INTERVAL (NUMTOYMINTERVAL(1, 'MONTH'))
(
    PARTITION TRACK_ORDEN_inicial VALUES LESS THAN (TO_DATE('01-01-2020', 'DD-MM-YYYY'))
);


ALTER TABLE PCP.TRACK_ORDEN_NEW ADD (
  PRIMARY KEY
  (ID_TRACK_ORDEN)
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


--DROP SEQUENCE PCP.ISEQ$$_78641;

-- Sequence ISEQ$$_78641 is created automatically by Oracle for use with an Identity column


--  There is no statement for index PCP.SYS_C008468.
--  The object is created when the parent object is created.

CREATE INDEX PCP.TRACK_ORDEN_NEW_N1 ON PCP.TRACK_ORDEN_NEW
(ID_ORDEN)
LOGGING
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
