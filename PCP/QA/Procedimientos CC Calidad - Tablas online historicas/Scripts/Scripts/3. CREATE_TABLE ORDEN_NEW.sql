--DROP TABLE orden_new PURGE;

CREATE TABLE PCP.ORDEN_NEW
(
  ID_ORDEN                   NUMBER(18) DEFAULT PCP.ISEQ$$_78822.nextval NOT NULL ,
  ID_NUM_REQUEST             VARCHAR2(58 BYTE),
  REFERENCE_NUMBER_LOTE      NUMBER(16),
  CUSTOMER_DESCRIPTION       VARCHAR2(150 BYTE),
  CUSTOMER_ID                VARCHAR2(20 BYTE),
  ACCOUNT_NUMBER             VARCHAR2(20 BYTE),
  TOTAL_NUM_DEBITS           NUMBER(12),
  TOTAL_NUM_CREDITS          NUMBER(12),
  TOTAL_AMOUNT               NUMBER(20,2),
  STATUS                     NUMBER(2),
  DATE_VALUE                 DATE,
  RECORD_ENTRY_DATE          DATE               DEFAULT SYSDATE,
  IS_LOADED_FROM_STG         VARCHAR2(1 BYTE)   DEFAULT 'N',
  PRODUCT_NAME               VARCHAR2(23 BYTE),
  BUSINESS_STATUS_CODE       VARCHAR2(8 BYTE),
  NUMERO_TICKET              VARCHAR2(20 BYTE),
  ENVIADO_EMPRESA            INTEGER            DEFAULT 1,
  TOTAL_DEBITOS_PROCESADOS   NUMBER(20),
  TOTAL_DEBITOS_RECHAZADOS   NUMBER(20),
  TOTAL_CREDITOS_PROCESADOS  NUMBER(20),
  TOTAL_CREDITOS_RECHAZADOS  NUMBER(20),
  FECHA_APROBACION           DATE,
  FECHA_ENVIO_MONITOR        DATE,
  FECHA_RECEPCION_MONITOR    DATE,
  RESPUESTA_MONITOR          VARCHAR2(5 BYTE),
  EXPIRADO_MONITOR           VARCHAR2(1 BYTE),
  ENVIADO_MONITOR            VARCHAR2(1 BYTE)
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
PARTITION BY RANGE (DATE_VALUE)
INTERVAL (NUMTOYMINTERVAL(1, 'MONTH'))
(
    PARTITION ORDEN_inicial VALUES LESS THAN (TO_DATE('01-01-2020', 'DD-MM-YYYY'))
);

COMMENT ON COLUMN PCP.ORDEN_NEW.NUMERO_TICKET IS 'Con tiene el valor del ticket generado en EMPRESA, si el lote es creado desde PCP WEB el numero_ticket es NULL';

COMMENT ON COLUMN PCP.ORDEN_NEW.ENVIADO_EMPRESA IS 'Indica si la informacion del estado del lote fue notificada a empresa. Si es 1 indica que aun no se ha enviado, 0 indica que ya fue notificada';

COMMENT ON COLUMN PCP.ORDEN_NEW.TOTAL_DEBITOS_PROCESADOS IS 'se refiere al total de debitos procesados de la orden';

COMMENT ON COLUMN PCP.ORDEN_NEW.TOTAL_DEBITOS_RECHAZADOS IS 'se refiere al total de debitos rechazados de la orden';

COMMENT ON COLUMN PCP.ORDEN_NEW.TOTAL_CREDITOS_PROCESADOS IS 'se refiere al total de creditos procesados de la orden';

COMMENT ON COLUMN PCP.ORDEN_NEW.TOTAL_CREDITOS_RECHAZADOS IS 'se refiere al total de creditos rezachazados de la orden';

COMMENT ON COLUMN PCP.ORDEN_NEW.FECHA_APROBACION IS 'Con tiene la fecha y hora de aprobacion de un lote';

COMMENT ON COLUMN PCP.ORDEN_NEW.FECHA_ENVIO_MONITOR IS 'contiene la fecha y hora de envio a monitor';

COMMENT ON COLUMN PCP.ORDEN_NEW.FECHA_RECEPCION_MONITOR IS 'contiene la fecha y hora de la recepcion de monitor';

COMMENT ON COLUMN PCP.ORDEN_NEW.RESPUESTA_MONITOR IS 'contiene la respuesta de monitor';

COMMENT ON COLUMN PCP.ORDEN_NEW.EXPIRADO_MONITOR IS 'Se refiere a si fue expirado por monitor. null y Y=expirado o N= no expirado';

COMMENT ON COLUMN PCP.ORDEN_NEW.ENVIADO_MONITOR IS 'Se refiere a si la orden fue enviada a monitor Y=enviado correctamente N= fallo el envio null= no enviado';


ALTER TABLE PCP.ORDEN_NEW ADD (
  PRIMARY KEY
  (ID_ORDEN)
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


----DROP SEQUENCE PCP.ISEQ$$_78822;

-- Sequence ISEQ$$_78822 is created automatically by Oracle for use with an Identity column


CREATE INDEX PCP.ORDEN_NEW_N1 ON PCP.ORDEN_NEW
(CUSTOMER_ID, DATE_VALUE)
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

CREATE INDEX PCP.ORDEN_NEW_N2 ON PCP.ORDEN_NEW
(ID_NUM_REQUEST)
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

CREATE INDEX PCP.ORDEN_NEW_N3 ON PCP.ORDEN_NEW
(ID_ORDEN, CUSTOMER_ID, DATE_VALUE)
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

CREATE INDEX PCP.ORDEN_NEW_N4 ON PCP.ORDEN_NEW
(ID_ORDEN, PRODUCT_NAME)
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

CREATE INDEX PCP.ORDEN_NEW_N5 ON PCP.ORDEN_NEW
(ID_ORDEN, CUSTOMER_ID)
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

CREATE INDEX PCP.ORDEN_NEW_N6 ON PCP.ORDEN_NEW
(TOTAL_AMOUNT, REFERENCE_NUMBER_LOTE)
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

CREATE INDEX PCP.ORDEN_NEW_N7 ON PCP.ORDEN_NEW
(DATE_VALUE)
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

CREATE INDEX PCP.ORDEN_NEW_N8 ON PCP.ORDEN_NEW
(STATUS)
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

--  There is no statement for index PCP.SYS_C008471.
--  The object is created when the parent object is created.
