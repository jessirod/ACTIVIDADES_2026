DROP TABLE DBO.ITEM_DECLARACION CASCADE CONSTRAINTS;

CREATE TABLE DBO.ITEM_DECLARACION
(
  NUMERO_ITEM_DECLARACION_I_D    VARCHAR2(8 BYTE) NOT NULL,
  ID_DECLARACION_I_D             NUMBER(20)     NOT NULL,
  VALOR_ITEM_DECLARACION_I_D     VARCHAR2(245 BYTE),
  VALOR_ITEM_NORMALIZADO         VARCHAR2(40 BYTE),
  COD_SITUACION_I_D              CHAR(2 BYTE),
  ID_ITEM_FORMULARIO_I_D         NUMBER(20),
  PERIODO_DECLARACION            NUMBER(8),
  VALOR_ITEM_DECLARACION_I_D_BS  VARCHAR2(245 BYTE),
  VALOR_ITEM_NORMALIZADO_BS      VARCHAR2(245 BYTE)
)
NOCOMPRESS 
TABLESPACE TB_PT_VARIOS_08
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            BUFFER_POOL      DEFAULT
           )
PARTITION BY LIST (PERIODO_DECLARACION)
(  
  PARTITION P199312 VALUES (199312)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199408 VALUES (199408)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199409 VALUES (199409)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199410 VALUES (199410)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199411 VALUES (199411)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199412 VALUES (199412)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199501 VALUES (199501)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199502 VALUES (199502)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199503 VALUES (199503)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199504 VALUES (199504)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199505 VALUES (199505)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199506 VALUES (199506)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199507 VALUES (199507)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199508 VALUES (199508)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199509 VALUES (199509)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199510 VALUES (199510)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199511 VALUES (199511)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199512 VALUES (199512)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199601 VALUES (199601)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199602 VALUES (199602)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199603 VALUES (199603)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199604 VALUES (199604)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199605 VALUES (199605)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199606 VALUES (199606)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199607 VALUES (199607)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199608 VALUES (199608)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199609 VALUES (199609)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199610 VALUES (199610)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199611 VALUES (199611)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199612 VALUES (199612)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199701 VALUES (199701)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199702 VALUES (199702)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199703 VALUES (199703)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199704 VALUES (199704)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199705 VALUES (199705)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199706 VALUES (199706)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199707 VALUES (199707)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199708 VALUES (199708)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199709 VALUES (199709)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199710 VALUES (199710)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199711 VALUES (199711)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199712 VALUES (199712)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199801 VALUES (199801)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199802 VALUES (199802)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199803 VALUES (199803)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199804 VALUES (199804)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199805 VALUES (199805)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199806 VALUES (199806)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199807 VALUES (199807)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199808 VALUES (199808)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199809 VALUES (199809)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199810 VALUES (199810)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199811 VALUES (199811)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199812 VALUES (199812)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199901 VALUES (199901)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199902 VALUES (199902)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199903 VALUES (199903)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199904 VALUES (199904)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199905 VALUES (199905)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199906 VALUES (199906)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199907 VALUES (199907)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199908 VALUES (199908)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199909 VALUES (199909)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199910 VALUES (199910)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199911 VALUES (199911)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199912 VALUES (199912)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200001 VALUES (200001)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200002 VALUES (200002)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200003 VALUES (200003)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200004 VALUES (200004)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200005 VALUES (200005)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200006 VALUES (200006)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200007 VALUES (200007)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200008 VALUES (200008)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200009 VALUES (200009)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200010 VALUES (200010)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200011 VALUES (200011)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200012 VALUES (200012)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200101 VALUES (200101)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200102 VALUES (200102)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200103 VALUES (200103)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200104 VALUES (200104)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200105 VALUES (200105)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200106 VALUES (200106)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200107 VALUES (200107)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200108 VALUES (200108)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200109 VALUES (200109)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200110 VALUES (200110)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200111 VALUES (200111)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200112 VALUES (200112)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200201 VALUES (200201)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200202 VALUES (200202)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200203 VALUES (200203)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200204 VALUES (200204)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200205 VALUES (200205)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200206 VALUES (200206)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200207 VALUES (200207)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200208 VALUES (200208)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200209 VALUES (200209)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200210 VALUES (200210)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200211 VALUES (200211)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200212 VALUES (200212)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200301 VALUES (200301)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200302 VALUES (200302)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200303 VALUES (200303)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200304 VALUES (200304)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200305 VALUES (200305)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200306 VALUES (200306)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200307 VALUES (200307)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200308 VALUES (200308)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200309 VALUES (200309)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200310 VALUES (200310)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200311 VALUES (200311)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200312 VALUES (200312)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200401 VALUES (200401)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200402 VALUES (200402)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200403 VALUES (200403)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200404 VALUES (200404)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200405 VALUES (200405)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200406 VALUES (200406)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200407 VALUES (200407)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200408 VALUES (200408)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200409 VALUES (200409)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200410 VALUES (200410)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200411 VALUES (200411)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200412 VALUES (200412)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200501 VALUES (200501)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200502 VALUES (200502)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200503 VALUES (200503)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200504 VALUES (200504)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200505 VALUES (200505)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200506 VALUES (200506)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200507 VALUES (200507)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200508 VALUES (200508)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200509 VALUES (200509)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200510 VALUES (200510)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200511 VALUES (200511)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200512 VALUES (200512)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200601 VALUES (200601)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200602 VALUES (200602)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200603 VALUES (200603)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200604 VALUES (200604)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200605 VALUES (200605)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200606 VALUES (200606)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200607 VALUES (200607)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200608 VALUES (200608)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200609 VALUES (200609)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200610 VALUES (200610)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200611 VALUES (200611)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200612 VALUES (200612)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200701 VALUES (200701)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200702 VALUES (200702)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200703 VALUES (200703)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200704 VALUES (200704)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200705 VALUES (200705)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200706 VALUES (200706)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200707 VALUES (200707)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200708 VALUES (200708)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200709 VALUES (200709)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200710 VALUES (200710)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200711 VALUES (200711)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200712 VALUES (200712)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200801 VALUES (200801)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200802 VALUES (200802)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200803 VALUES (200803)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200804 VALUES (200804)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200805 VALUES (200805)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200806 VALUES (200806)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200807 VALUES (200807)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200808 VALUES (200808)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200809 VALUES (200809)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200810 VALUES (200810)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200811 VALUES (200811)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200812 VALUES (200812)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200901 VALUES (200901)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200902 VALUES (200902)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200903 VALUES (200903)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200904 VALUES (200904)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200905 VALUES (200905)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200906 VALUES (200906)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200907 VALUES (200907)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200908 VALUES (200908)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200909 VALUES (200909)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200910 VALUES (200910)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200911 VALUES (200911)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200912 VALUES (200912)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201001 VALUES (201001)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201002 VALUES (201002)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201003 VALUES (201003)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201004 VALUES (201004)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201005 VALUES (201005)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201006 VALUES (201006)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201007 VALUES (201007)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201008 VALUES (201008)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201009 VALUES (201009)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201010 VALUES (201010)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201011 VALUES (201011)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201012 VALUES (201012)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201101 VALUES (201101)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201102 VALUES (201102)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201103 VALUES (201103)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201104 VALUES (201104)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201105 VALUES (201105)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201106 VALUES (201106)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201107 VALUES (201107)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201108 VALUES (201108)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201109 VALUES (201109)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201110 VALUES (201110)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201111 VALUES (201111)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201112 VALUES (201112)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201201 VALUES (201201)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201202 VALUES (201202)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201203 VALUES (201203)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201204 VALUES (201204)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201205 VALUES (201205)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201206 VALUES (201206)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201207 VALUES (201207)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201208 VALUES (201208)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201209 VALUES (201209)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201210 VALUES (201210)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201211 VALUES (201211)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201212 VALUES (201212)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201231 VALUES (201231)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201301 VALUES (201301)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201302 VALUES (201302)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201303 VALUES (201303)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201304 VALUES (201304)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201305 VALUES (201305)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201306 VALUES (201306)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201307 VALUES (201307)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201308 VALUES (201308)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201309 VALUES (201309)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201310 VALUES (201310)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201311 VALUES (201311)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201312 VALUES (201312)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201401 VALUES (201401)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201402 VALUES (201402)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201403 VALUES (201403)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201404 VALUES (201404)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201405 VALUES (201405)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201406 VALUES (201406)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201407 VALUES (201407)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201408 VALUES (201408)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201409 VALUES (201409)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201410 VALUES (201410)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201411 VALUES (201411)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201412 VALUES (201412)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201501 VALUES (201501)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201502 VALUES (201502)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201503 VALUES (201503)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201504 VALUES (201504)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201505 VALUES (201505)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201506 VALUES (201506)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201507 VALUES (201507)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201508 VALUES (201508)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201509 VALUES (201509)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201510 VALUES (201510)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201511 VALUES (201511)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201512 VALUES (201512)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201601 VALUES (201601)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201602 VALUES (201602)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201603 VALUES (201603)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201604 VALUES (201604)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201605 VALUES (201605)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201606 VALUES (201606)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201607 VALUES (201607)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201608 VALUES (201608)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201609 VALUES (201609)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201610 VALUES (201610)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201611 VALUES (201611)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201612 VALUES (201612)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201701 VALUES (201701)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201702 VALUES (201702)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201703 VALUES (201703)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201704 VALUES (201704)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201705 VALUES (201705)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201706 VALUES (201706)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201707 VALUES (201707)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201708 VALUES (201708)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201709 VALUES (201709)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201710 VALUES (201710)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201711 VALUES (201711)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201712 VALUES (201712)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201801 VALUES (201801)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201802 VALUES (201802)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201803 VALUES (201803)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201804 VALUES (201804)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201805 VALUES (201805)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201806 VALUES (201806)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201807 VALUES (201807)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201808 VALUES (201808)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201809 VALUES (201809)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201810 VALUES (201810)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201811 VALUES (201811)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201812 VALUES (201812)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201901 VALUES (201901)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201902 VALUES (201902)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201903 VALUES (201903)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201904 VALUES (201904)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201905 VALUES (201905)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201906 VALUES (201906)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201907 VALUES (201907)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201908 VALUES (201908)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201909 VALUES (201909)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201910 VALUES (201910)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201911 VALUES (201911)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201912 VALUES (201912)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202001 VALUES (202001)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202002 VALUES (202002)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202003 VALUES (202003)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202004 VALUES (202004)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202005 VALUES (202005)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202006 VALUES (202006)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202007 VALUES (202007)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202008 VALUES (202008)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202009 VALUES (202009)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202010 VALUES (202010)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202011 VALUES (202011)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202012 VALUES (202012)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202101 VALUES (202101)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202102 VALUES (202102)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202103 VALUES (202103)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202104 VALUES (202104)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202105 VALUES (202105)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202106 VALUES (202106)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202107 VALUES (202107)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202109 VALUES (202109)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202110 VALUES (202110)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202111 VALUES (202111)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202112 VALUES (202112)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202201 VALUES (202201)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202108 VALUES (202108)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202202 VALUES (202202)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202203 VALUES (202203)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202204 VALUES (202204)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202205 VALUES (202205)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202206 VALUES (202206)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202207 VALUES (202207)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202208 VALUES (202208)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202209 VALUES (202209)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202210 VALUES (202210)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202211 VALUES (202211)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202212 VALUES (202212)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202301 VALUES (202301)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          128M
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202302 VALUES (202302)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          128M
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202303 VALUES (202303)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          128M
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202304 VALUES (202304)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          128M
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202305 VALUES (202305)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          128M
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202306 VALUES (202306)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          128M
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202307 VALUES (202307)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202308 VALUES (202308)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_MEDIUM_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             4M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202309 VALUES (202309)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_SMALL
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128K
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202310 VALUES (202310)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202311 VALUES (202311)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202312 VALUES (202312)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_REL_FACTURA
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202401 VALUES (202401)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202402 VALUES (202402)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202403 VALUES (202403)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_03
    PCTUSED    0
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202404 VALUES (202404)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_04
    PCTUSED    0
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202405 VALUES (202405)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202406 VALUES (202406)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202407 VALUES (202407)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202408 VALUES (202408)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_08
    PCTUSED    0
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202409 VALUES (202409)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_09
    PCTUSED    0
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202410 VALUES (202410)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202411 VALUES (202411)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202412 VALUES (202412)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_12
    PCTUSED    0
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202501 VALUES (202501)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202502 VALUES (202502)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202503 VALUES (202503)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_03
    PCTUSED    0
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202504 VALUES (202504)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_04
    PCTUSED    0
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202505 VALUES (202505)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202506 VALUES (202506)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202507 VALUES (202507)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202508 VALUES (202508)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_08
    PCTUSED    0
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202509 VALUES (202509)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_09
    PCTUSED    0
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202510 VALUES (202510)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202511 VALUES (202511)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202512 VALUES (202512)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_12
    PCTUSED    0
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202601 VALUES (202601)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202602 VALUES (202602)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202603 VALUES (202603)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_03
    PCTUSED    0
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202604 VALUES (202604)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_04
    PCTUSED    0
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202605 VALUES (202605)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202606 VALUES (202606)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202607 VALUES (202607)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202608 VALUES (202608)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_08
    PCTUSED    0
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202609 VALUES (202609)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_09
    PCTUSED    0
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202610 VALUES (202610)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202611 VALUES (202611)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202612 VALUES (202612)
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_12
    PCTUSED    0
    PCTFREE    10
    INITRANS   1
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
)
NOCACHE
MONITORING
ENABLE ROW MOVEMENT;


CREATE INDEX DBO.IDX_PERIODO_DECLARACION ON DBO.ITEM_DECLARACION
(PERIODO_DECLARACION)
  PCTFREE    10
  INITRANS   2
  MAXTRANS   255
  STORAGE    (
              BUFFER_POOL      DEFAULT
             )
LOCAL (  
  PARTITION P199312
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199408
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199409
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199410
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199411
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199412
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199501
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199502
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199503
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_LARGE_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199504
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199505
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199506
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199507
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199508
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_MEDIUM
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199509
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199510
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199511
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199512
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199601
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199602
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_LARGE_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199603
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199604
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199605
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199606
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199607
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_MEDIUM
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199608
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199609
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199610
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P19961
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199612
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199701
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_LARGE_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199702
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199703
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199704
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199705
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199706
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_MEDIUM
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199707
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199708
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199709
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199710
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199711
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199712
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199801
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199802
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199803
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199804
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199805
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_MEDIUM
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199806
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199807
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199808
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199809
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199810
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199811
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199812
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_LARGE_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199901
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199902
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199903
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199904
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_MEDIUM
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199905
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199906
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199907
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199908
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199909
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199910
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199911
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_LARGE_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P199912
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200001
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200002
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200003
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_MEDIUM
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200004
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200005
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200006
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200007
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200008
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200009
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200010
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_LARGE_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200011
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200012
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200101
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200102
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_MEDIUM
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200103
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200104
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200105
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200106
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200107
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200108
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P20010
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_LARGE_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200110
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200111
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200112
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200201
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_MEDIUM
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200202
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200203
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200204
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200205
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200206
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200207
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200208
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_LARGE_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200209
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200210
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200211
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200212
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200301
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200302
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200303
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200304
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200305
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200306
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200307
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_LARGE_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200308
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200309
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200310
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200311
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200312
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_MEDIUM
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200401
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200402
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200403
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200404
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200405
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200406
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_LARGE_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200407
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200408
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200409
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200410
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200411
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_MEDIUM
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200412
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200501
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200502
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200503
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200504
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200505
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_LARGE_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200506
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200507
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200508
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200509
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200510
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_MEDIUM
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200511
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200512
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200601
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200602
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200603
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200604
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_LARGE_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200605
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200606
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200607
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200608
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200609
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_MEDIUM
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200610
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200611
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200612
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200701
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200702
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200703
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_LARGE_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200704
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200705
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200706
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200707
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200708
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_MEDIUM
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200709
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200710
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200711
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200712
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200801
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200802
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_LARGE_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200803
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200804
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200805
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200806
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200807
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_MEDIUM
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200808
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200809
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200810
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200811
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200812
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200901
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_LARGE_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200902
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200903
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200904
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200905
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200906
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_MEDIUM
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200907
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200908
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200909
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200910
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200911
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P200912
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201001
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201002
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201003
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201004
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201005
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_MEDIUM
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201006
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201007
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201008
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201009
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201010
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201011
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201012
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_LARGE_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201101
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201102
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201103
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201104
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_MEDIUM
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201105
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201106
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201107
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201108
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201109
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201110
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201111
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_LARGE_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201112
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201201
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201202
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201203
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201204
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_MEDIUM
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201205
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201206
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201207
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201208
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201209
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201210
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201211
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_LARGE_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201212
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201231
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201301
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201302
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_MEDIUM
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201303
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201304
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201305
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201306
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201307
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201308
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201309
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_LARGE_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201310
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201311
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201312
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201401
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_MEDIUM
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201402
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201403
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201404
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201405
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201406
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201407
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201408
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_LARGE_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201409
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201410
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201411
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201412
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_MEDIUM
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201501
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201502
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201503
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201504
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201505
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201506
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201507
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_LARGE_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201508
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201509
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201510
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201511
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201512
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201601
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201602
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201603
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201604
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201605
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201606
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_LARGE_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201607
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201608
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201609
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201610
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201611
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_MEDIUM
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201612
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201701
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201702
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201703
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201704
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201705
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201706
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201707
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_LARGE_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201708
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201709
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201710
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201711
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201712
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201801
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201802
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201803
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201804
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201805
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201806
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201807
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_LARGE_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201808
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201809
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201810
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201811
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201812
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201901
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201902
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201903
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201904
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201905
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201906
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201907
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201908
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_REL_FACTURA
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201909
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201910
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201911
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P201912
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202001
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202002
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202003
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202004
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202005
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202006
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202007
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202008
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_REL_FACTURA
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202009
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202010
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202011
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202012
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202101
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202102
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202103
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202104
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202105
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202106
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202107
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202109
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202110
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202111
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202112
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202201
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202108
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_REL_FACTURA
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202202
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202203
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_LARGE_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202204
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_RELA_FACT_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202205
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202206
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202207
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202208
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_MEDIUM
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202209
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202210
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202211
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202212
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202301
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_LARGE_08
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          128M
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202302
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_LARGE_08
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          128M
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202303
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_LARGE_08
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          128M
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202304
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_LARGE_08
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          128M
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202305
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_LARGE_08
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          128M
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202306
    LOGGING
    NOCOMPRESS 
    TABLESPACE TS_D_LARGE_08
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          128M
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202307
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202308
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_REL_FACTURA
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             128M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                PCTINCREASE      0
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202309
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202310
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202311
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202312
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE TS_I_TRANSC_PART
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202401
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202402
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202403
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_03
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202404
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_04
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202405
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202406
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202407
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202408
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_08
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202409
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_09
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202410
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202411
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202412
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_12
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202501
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202502
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202503
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_03
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202504
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_04
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202505
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202506
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202507
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202508
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_08
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202509
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_09
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202510
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202511
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202512
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_12
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202601
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_01
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202602
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_02
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202603
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_03
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202604
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_04
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202605
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_05
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202606
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_06
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202607
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_07
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202608
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_08
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202609
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_09
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202610
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_10
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202611
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_11
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
               ),  
  PARTITION P202612
    LOGGING
    NOCOMPRESS 
    TABLESPACE TB_PT_VARIOS_12
    INITRANS   2
    MAXTRANS   255
    STORAGE    (
                INITIAL          64K
                NEXT             1M
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                FREELISTS        1
                FREELIST GROUPS  1
                BUFFER_POOL      DEFAULT
               )
);

CREATE UNIQUE INDEX DBO.PK_ITEM_DECLARACION_P ON DBO.ITEM_DECLARACION
(ID_DECLARACION_I_D, NUMERO_ITEM_DECLARACION_I_D)
NOLOGGING
TABLESPACE TS_I_TRANSC_PART
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            FREELISTS        1
            FREELIST GROUPS  1
            BUFFER_POOL      DEFAULT
           );




CREATE OR REPLACE TRIGGER AIRFLOW.TRG_CDC_ITEM_DECLARACION
AFTER INSERT OR UPDATE OR DELETE
ON DBO.ITEM_DECLARACION
FOR EACH ROW
DECLARE
    v_tipo_evento VARCHAR2(10);
    v_user        VARCHAR2(100) := USER;
    v_id_evento   NUMBER;

    PROCEDURE prc_insert_log_error(
        p_evento       VARCHAR2,
        p_usuario      VARCHAR2,
        p_cod          NUMBER,
        p_msg          VARCHAR2,
        p_id_evento    NUMBER,
        p_nombre_tabla VARCHAR2
    ) IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        INSERT INTO AIRFLOW.LOG_CDC_ERRORES (
            NOMBRE_TRIGGER,
            EVENTO,
            USUARIO_BD,
            ERROR_CODE,
            ERROR_MENSAJE,
            FECHA_ERROR,
            ID_EVENTO,
            NOMBRE_TABLA
        ) VALUES (
            'TRG_CDC_ITEM_DECLARACION',
            p_evento,
            p_usuario,
            p_cod,
            SUBSTR(p_msg, 1, 500),
            SYSTIMESTAMP,
            p_id_evento,
            p_nombre_tabla
        );
        COMMIT;
    END prc_insert_log_error;
BEGIN
    IF INSERTING THEN
        v_tipo_evento := 'INSERT';
        SELECT AIRFLOW.SEQ_LOG_CDC_ITEM_DECLARACION.NEXTVAL INTO v_id_evento FROM DUAL;
        BEGIN
            INSERT INTO AIRFLOW.LOG_CDC_ITEM_DECLARACION (
                NUMERO_ITEM_DECLARACION_I_D,
                ID_DECLARACION_I_D,
                VALOR_ITEM_DECLARACION_I_D,
                VALOR_ITEM_NORMALIZADO,
                COD_SITUACION_I_D, 
                ID_ITEM_FORMULARIO_I_D,
                PERIODO_DECLARACION,   
                VALOR_ITEM_DECLARACION_I_D_BS,
                VALOR_ITEM_NORMALIZADO_BS,
                TIPO_EVENTO,
                FECHA_EVENTO,
                USUARIO_BD,
                ID_EVENTO
            ) VALUES (
                :NEW.NUMERO_ITEM_DECLARACION_I_D,
                :NEW.ID_DECLARACION_I_D,
                :NEW.VALOR_ITEM_DECLARACION_I_D,
                :NEW.VALOR_ITEM_NORMALIZADO,
                :NEW.COD_SITUACION_I_D, 
                :NEW.ID_ITEM_FORMULARIO_I_D,
                :NEW.PERIODO_DECLARACION,   
                :NEW.VALOR_ITEM_DECLARACION_I_D_BS,
                :NEW.VALOR_ITEM_NORMALIZADO_BS,
                v_tipo_evento,
                SYSTIMESTAMP,
                v_user,
                v_id_evento
            );

            INSERT INTO AIRFLOW.CDC_CONTROL_REPLICACION (
                ID_CONTROL, TABLA_LOG, ID_EVENTO, ESTADO
            ) VALUES (
                AIRFLOW.SEQ_CDC_CONTROL.NEXTVAL, 'LOG_CDC_ITEM_DECLARACION', v_id_evento, 'P'
            );
        EXCEPTION
            WHEN OTHERS THEN
                prc_insert_log_error(v_tipo_evento, v_user, SQLCODE, SQLERRM, :NEW.ID_DECLARACION_I_D, 'DBO.ITEM_DECLARACION');
        END;

    ELSIF UPDATING THEN
        v_tipo_evento := 'UPDATE';
        SELECT AIRFLOW.SEQ_LOG_CDC_ITEM_DECLARACION.NEXTVAL INTO v_id_evento FROM DUAL;
        BEGIN
            INSERT INTO AIRFLOW.LOG_CDC_ITEM_DECLARACION (
                NUMERO_ITEM_DECLARACION_I_D,
                ID_DECLARACION_I_D,
                VALOR_ITEM_DECLARACION_I_D,
                VALOR_ITEM_NORMALIZADO,
                COD_SITUACION_I_D, 
                ID_ITEM_FORMULARIO_I_D,
                PERIODO_DECLARACION,   
                VALOR_ITEM_DECLARACION_I_D_BS,
                VALOR_ITEM_NORMALIZADO_BS,
                TIPO_EVENTO,
                FECHA_EVENTO,
                USUARIO_BD,
                ID_EVENTO
            ) VALUES (
                :NEW.NUMERO_ITEM_DECLARACION_I_D,
                :NEW.ID_DECLARACION_I_D,
                :NEW.VALOR_ITEM_DECLARACION_I_D,
                :NEW.VALOR_ITEM_NORMALIZADO,
                :NEW.COD_SITUACION_I_D, 
                :NEW.ID_ITEM_FORMULARIO_I_D,
                :NEW.PERIODO_DECLARACION,   
                :NEW.VALOR_ITEM_DECLARACION_I_D_BS,
                :NEW.VALOR_ITEM_NORMALIZADO_BS,
                v_tipo_evento,
                SYSTIMESTAMP,
                v_user,
                v_id_evento
            );

            INSERT INTO AIRFLOW.CDC_CONTROL_REPLICACION (
                ID_CONTROL, TABLA_LOG, ID_EVENTO, ESTADO
            ) VALUES (
                AIRFLOW.SEQ_CDC_CONTROL.NEXTVAL, 'LOG_CDC_ITEM_DECLARACION', v_id_evento, 'P'
            );
        EXCEPTION
            WHEN OTHERS THEN
                prc_insert_log_error(v_tipo_evento, v_user, SQLCODE, SQLERRM, :NEW.ID_DECLARACION_I_D, 'DBO.ITEM_DECLARACION');
        END;

    ELSIF DELETING THEN
        v_tipo_evento := 'DELETE';
        SELECT AIRFLOW.SEQ_LOG_CDC_ITEM_DECLARACION.NEXTVAL INTO v_id_evento FROM DUAL;
        BEGIN
            INSERT INTO AIRFLOW.LOG_CDC_ITEM_DECLARACION (
                NUMERO_ITEM_DECLARACION_I_D,
                ID_DECLARACION_I_D,
                VALOR_ITEM_DECLARACION_I_D,
                VALOR_ITEM_NORMALIZADO,
                COD_SITUACION_I_D, 
                ID_ITEM_FORMULARIO_I_D,
                PERIODO_DECLARACION,   
                VALOR_ITEM_DECLARACION_I_D_BS,
                VALOR_ITEM_NORMALIZADO_BS,
                TIPO_EVENTO,
                FECHA_EVENTO,
                USUARIO_BD,
                ID_EVENTO
            ) VALUES (
                :OLD.NUMERO_ITEM_DECLARACION_I_D,
                :OLD.ID_DECLARACION_I_D,
                :OLD.VALOR_ITEM_DECLARACION_I_D,
                :OLD.VALOR_ITEM_NORMALIZADO,
                :OLD.COD_SITUACION_I_D, 
                :OLD.ID_ITEM_FORMULARIO_I_D,
                :OLD.PERIODO_DECLARACION,   
                :OLD.VALOR_ITEM_DECLARACION_I_D_BS,
                :OLD.VALOR_ITEM_NORMALIZADO_BS,
                v_tipo_evento,
                SYSTIMESTAMP,
                v_user,
                v_id_evento
            );

            INSERT INTO AIRFLOW.CDC_CONTROL_REPLICACION (
                ID_CONTROL, TABLA_LOG, ID_EVENTO, ESTADO
            ) VALUES (
                AIRFLOW.SEQ_CDC_CONTROL.NEXTVAL, 'LOG_CDC_ITEM_DECLARACION', v_id_evento, 'P'
            );
        EXCEPTION
            WHEN OTHERS THEN
                prc_insert_log_error(v_tipo_evento, v_user, SQLCODE, SQLERRM, :OLD.ID_DECLARACION_I_D, 'DBO.ITEM_DECLARACION');
        END;
    END IF;
END;
/


CREATE OR REPLACE TRIGGER IMPEX.TRG_ITEM_DEC_BE_IMPEX
AFTER insert or delete or update on dbo.item_declaracion
for each row
declare
v_id_contribuyente number;
v_rif varchar2(15);
v_emp varchar2(100);
v_traza_new clob:=NULL;
v_traza_old clob:=NULL;
v_codigo number(1);
v_ind_usuario char(2);
V_IND_EMP CHAR(2);
v_impuesto varchar2(5);
V_NOM_IMP VARCHAR2(160);
v_numero_declaracion varchar2(40);
begin
     IF UPDATING OR DELETING THEN
     begin
      select id_contribuyente,impuesto_declaracion,NUMERO_DECLARACION
        into v_id_contribuyente,v_impuesto,v_numero_declaracion
         from dbo.declaracion
       where id_declaracion=:old.id_declaracion_i_d;
       
       exception
          when others then 
            null;
       end;

      begin
        select rif_contribuyente,apellido_contribuyente,'SI'
        into v_rif,v_emp,V_IND_EMP
          from datoscontribuyente.contribuyente
          where id_contribuyente=v_id_contribuyente
          AND PERSONALIDAD_CONTRIBUYENTE IN ('3','5');
      exception
      when NO_DATA_FOUND then
      V_IND_EMP:='NO';
      end;
      
      begin
      select nombre_impuesto
        INTO V_NOM_IMP
        from dbo.impuesto
       where CODIGO_IMPUESTO=v_impuesto;
      end;
      END IF; 

 IF V_IND_EMP='SI' THEN
    BEGIN
    
        select 'SI'
        INTO v_ind_usuario
        FROM DBA_USERS
        WHERE USERNAME=USER
        and username not in ( 'SENIAT'
                                        ,'CONPAGO'
                                        ,'NOTIADUANA'
                                        ,'USERSWORD'
                                        ,'SYS');
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      v_ind_usuario:= 'NO';
   END;
   
 IF v_ind_usuario='SI' THEN  
    if inserting then
      v_codigo:=1;
       v_traza_new:=  'NUMERO_ITEM_DECLARACION_I_D: '||:NEW.NUMERO_ITEM_DECLARACION_I_D  
  ||' ID_DECLARACION_I_D: '         ||:NEW.ID_DECLARACION_I_D           
  ||' VALOR_ITEM_DECLARACION_I_D: ' ||:NEW.VALOR_ITEM_DECLARACION_I_D   
  ||' VALOR_ITEM_NORMALIZADO: '     ||:NEW.VALOR_ITEM_NORMALIZADO       
  ||' COD_SITUACION_I_D: '          ||:NEW.COD_SITUACION_I_D            
  ||' ID_ITEM_FORMULARIO_I_D: '     ||:NEW.ID_ITEM_FORMULARIO_I_D       
  ||' PERIODO_DECLARACION: '        ||:NEW.PERIODO_DECLARACION;  
  
    ELSIF UPDATING THEN
        v_codigo:=2;   
        if :old.NUMERO_ITEM_DECLARACION_I_D<>:new.NUMERO_ITEM_DECLARACION_I_D then
          v_traza_old:=v_traza_old||'NUMERO_ITEM_DECLARACION_I_D: '||:old.NUMERO_ITEM_DECLARACION_I_D;
          v_traza_old:=v_traza_old||', ';
          
          v_traza_new:=v_traza_new||'NUMERO_ITEM_DECLARACION_I_D: '||:new.NUMERO_ITEM_DECLARACION_I_D;
          v_traza_new:=v_traza_new||', ';
          
        end if;
        
         if :old.ID_DECLARACION_I_D<>:new.ID_DECLARACION_I_D then
          v_traza_old:=v_traza_old||'ID_DECLARACION_I_D: '||:old.ID_DECLARACION_I_D;
          v_traza_old:=v_traza_old||', ';
          
          v_traza_new:=v_traza_new||'ID_DECLARACION_I_D: '||:new.ID_DECLARACION_I_D;
          v_traza_new:=v_traza_new||', ';
          
        end if;
        
        if :old.VALOR_ITEM_DECLARACION_I_D<>:new.VALOR_ITEM_DECLARACION_I_D then
          v_traza_old:=v_traza_old||'VALOR_ITEM_DECLARACION_I_D: '||:old.VALOR_ITEM_DECLARACION_I_D;
          v_traza_old:=v_traza_old||', ';
          
          v_traza_new:=v_traza_new||'VALOR_ITEM_DECLARACION_I_D: '||:new.VALOR_ITEM_DECLARACION_I_D;
          v_traza_new:=v_traza_new||', ';
          
        end if;
        
        if :old.VALOR_ITEM_NORMALIZADO<>:new.VALOR_ITEM_NORMALIZADO then
          v_traza_old:=v_traza_old||'VALOR_ITEM_NORMALIZADO: '||:old.VALOR_ITEM_NORMALIZADO;
          v_traza_old:=v_traza_old||', ';
          
          v_traza_new:=v_traza_new||'VALOR_ITEM_NORMALIZADO: '||:new.VALOR_ITEM_NORMALIZADO;
          v_traza_new:=v_traza_new||', ';
          
        end if;
        
        if :old.COD_SITUACION_I_D<>:new.COD_SITUACION_I_D then
          v_traza_old:=v_traza_old||'COD_SITUACION_I_D: '||:old.COD_SITUACION_I_D;
          v_traza_old:=v_traza_old||', ';
          
          v_traza_new:=v_traza_new||'COD_SITUACION_I_D: '||:new.COD_SITUACION_I_D;
          v_traza_new:=v_traza_new||', '; 
        end if;
        
         if :old.ID_ITEM_FORMULARIO_I_D<>:new.ID_ITEM_FORMULARIO_I_D then
          v_traza_old:=v_traza_old||'ID_ITEM_FORMULARIO_I_D: '||:old.ID_ITEM_FORMULARIO_I_D;
          v_traza_old:=v_traza_old||', ';
          
          v_traza_new:=v_traza_new||'ID_ITEM_FORMULARIO_I_D: '||:new.ID_ITEM_FORMULARIO_I_D;
          v_traza_new:=v_traza_new||', '; 
        end if;
        
        if :old.COD_SITUACION_I_D<>:new.COD_SITUACION_I_D then
          v_traza_old:=v_traza_old||'COD_SITUACION_I_D: '||:old.COD_SITUACION_I_D;
          v_traza_old:=v_traza_old||', ';
          
          v_traza_new:=v_traza_new||'COD_SITUACION_I_D: '||:new.COD_SITUACION_I_D;
          v_traza_new:=v_traza_new||', '; 
        end if;
        
         if :old.PERIODO_DECLARACION<>:new.PERIODO_DECLARACION then
          v_traza_old:=v_traza_old||'PERIODO_DECLARACION: '||:old.PERIODO_DECLARACION;
          v_traza_old:=v_traza_old||', ';
          
          v_traza_new:=v_traza_new||'PERIODO_DECLARACION: '||:new.PERIODO_DECLARACION;
          v_traza_new:=v_traza_new||', '; 
        end if;
        
        
        
      
    ELSIF DELETING THEN
    v_codigo:=3;
           v_traza_old:=  'NUMERO_ITEM_DECLARACION_I_D: '||:OLD.NUMERO_ITEM_DECLARACION_I_D  
                                  ||', ID_DECLARACION_I_D: '         ||:OLD.ID_DECLARACION_I_D           
                                  ||', VALOR_ITEM_DECLARACION_I_D: ' ||:OLD.VALOR_ITEM_DECLARACION_I_D   
                                  ||', VALOR_ITEM_NORMALIZADO: '     ||:OLD.VALOR_ITEM_NORMALIZADO       
                                  ||', COD_SITUACION_I_D: '          ||:OLD.COD_SITUACION_I_D            
                                  ||', ID_ITEM_FORMULARIO_I_D: '     ||:OLD.ID_ITEM_FORMULARIO_I_D       
                                  ||', PERIODO_DECLARACION: '        ||:OLD.PERIODO_DECLARACION;  
        
    END IF;
                 IMPEX.p_dec_oper_IMPEX(CASE v_codigo WHEN 1 THEN :NEW.ID_DECLARACION_I_D ELSE :OLD.ID_DECLARACION_I_D END
                                                ,v_traza_old
                                                ,v_traza_new
                                                ,v_codigo
                                                ,sysdate
                                                ,CASE WHEN (CASE v_codigo WHEN 1 THEN :NEW.NUMERO_ITEM_DECLARACION_I_D ELSE :OLD.NUMERO_ITEM_DECLARACION_I_D END) IN ('711','970') THEN 'SI' ELSE  'NO' END
                                                ,v_rif 
                                                ,v_emp
                                                ,CASE v_codigo WHEN 1 THEN :NEW.NUMERO_ITEM_DECLARACION_I_D ELSE :OLD.NUMERO_ITEM_DECLARACION_I_D END
                                                ,v_numero_declaracion
                                                ,V_NOM_IMP
												,'ITEM_DECLARACION'
                                                ,v_id_contribuyente);
   END IF;
  END IF;
exception 
when others then 
null;
end;
/


CREATE OR REPLACE PUBLIC SYNONYM ITEM_DECLARACION FOR DBO.ITEM_DECLARACION;


GRANT SELECT ON DBO.ITEM_DECLARACION TO ABORZELL;

GRANT SELECT ON DBO.ITEM_DECLARACION TO ACRAMIREZM;

GRANT SELECT ON DBO.ITEM_DECLARACION TO AIRFLOW;

GRANT INSERT, SELECT, UPDATE ON DBO.ITEM_DECLARACION TO ANALISTA_DIMD;

GRANT SELECT ON DBO.ITEM_DECLARACION TO ANALISTA1;

GRANT SELECT, UPDATE ON DBO.ITEM_DECLARACION TO ANALISTA2;

GRANT INSERT, SELECT, UPDATE ON DBO.ITEM_DECLARACION TO CCOLLS;

GRANT DELETE ON DBO.ITEM_DECLARACION TO DELETE_DBO;

GRANT DELETE ON DBO.ITEM_DECLARACION TO DELETE_TODOS_ESQUEMAS;

GRANT SELECT, UPDATE ON DBO.ITEM_DECLARACION TO EAPONTE;

GRANT SELECT ON DBO.ITEM_DECLARACION TO GLTORRES;

GRANT INSERT ON DBO.ITEM_DECLARACION TO INSERT_DBO;

GRANT INSERT ON DBO.ITEM_DECLARACION TO INSERT_TODOS_ESQUEMAS;

GRANT INSERT, SELECT, UPDATE ON DBO.ITEM_DECLARACION TO JARRAEZ;

GRANT SELECT ON DBO.ITEM_DECLARACION TO JJMARTINEZ;

GRANT SELECT ON DBO.ITEM_DECLARACION TO JNAVARROM;

GRANT SELECT ON DBO.ITEM_DECLARACION TO JRMARTINEZQ;

GRANT DELETE, INSERT, SELECT, UPDATE ON DBO.ITEM_DECLARACION TO KBLANCOA;

GRANT SELECT ON DBO.ITEM_DECLARACION TO MNGONZALEZC;

GRANT SELECT ON DBO.ITEM_DECLARACION TO MOV_DAT;

GRANT SELECT ON DBO.ITEM_DECLARACION TO OYUSECHE;

GRANT SELECT ON DBO.ITEM_DECLARACION TO PARTICION;

GRANT SELECT ON DBO.ITEM_DECLARACION TO PENTAHO;

GRANT DELETE ON DBO.ITEM_DECLARACION TO RARENAS;

GRANT DELETE ON DBO.ITEM_DECLARACION TO ROLE_DELETE_DBO;

GRANT SELECT ON DBO.ITEM_DECLARACION TO ROLE_DISCOVER;

GRANT SELECT ON DBO.ITEM_DECLARACION TO RROJAS;

GRANT SELECT ON DBO.ITEM_DECLARACION TO SELECT_DBO;

GRANT SELECT ON DBO.ITEM_DECLARACION TO SELECT_TODOS_ESQUEMAS;

GRANT DELETE, INSERT, SELECT, UPDATE ON DBO.ITEM_DECLARACION TO SENIAT;

GRANT SELECT ON DBO.ITEM_DECLARACION TO SERVICEMIGRA;

GRANT DELETE, INSERT, SELECT, UPDATE ON DBO.ITEM_DECLARACION TO SERVICIOWEB;

GRANT SELECT ON DBO.ITEM_DECLARACION TO SVRODRIGUEZ;

GRANT UPDATE ON DBO.ITEM_DECLARACION TO UPDATE_DBO;

GRANT UPDATE ON DBO.ITEM_DECLARACION TO UPDATE_TODOS_ESQUEMAS;

GRANT SELECT ON DBO.ITEM_DECLARACION TO USER_PEGASUS;

GRANT SELECT ON DBO.ITEM_DECLARACION TO ZABBIX;