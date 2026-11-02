 sqlplus / as sysdba @SIA-VENTANILLAS-VIRTUALES.sql

SQL*Plus: Release 19.0.0.0.0 - Production on Tue Jul 28 15:27:41 2026
Version 19.17.0.0.0

Copyright (c) 1982, 2022, Oracle.  All rights reserved.


Connected to:
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
Version 19.17.0.0.0


Session altered.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.10

0 rows deleted.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.04

1 row created.

Elapsed: 00:00:00.00

0 rows deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

0 rows deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

0 rows deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.01

0 rows deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00
INSERT INTO INTCORE.TRESULTADOSID (CRESULTADO) VALUES ('INT0194')
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKRESULID) violated


Elapsed: 00:00:00.01

2 rows deleted.

Elapsed: 00:00:00.02

1 row created.

Elapsed: 00:00:00.00
INSERT INTO INTCORE.TRESULTADOSID (CRESULTADO) VALUES ('LOT009')
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKRESULID) violated


Elapsed: 00:00:00.00

1 row deleted.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.00

3 rows deleted.

Elapsed: 00:00:00.03

1 row created.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00
INSERT INTO INTCORE.TSUBSISTEMATRANSACCIONESID (CSUBSISTEMA, CTRANSACCION, VERSIONTRANSACCION, ORDENMENU, PRESENTARENMENU, INTERNA, FORMULARIOBASE, AFECTAINMOVILIZACION, CG                         RUPOTRANSACCION, PRESENTARENREVERSO, CNIVELMENU, LISTAVALOR, USACACHE, SUMACOMPONENTES, PROVISION, COMPLETARRUBROS, LOTEGENERICO, VERIFICANIVELSEGURIDAD, CUSUARIO_INGRESO,                          FINGRESO, ACUMULACONTADOR, PAGINA, ORIGENDESTINO, CONTROLAEFECTIVO, REQUIEREAUTORIZACION, EJECUTAENAUTORIZACION, CVARIANTEIDIOMA, CTIPOOPERACIONESPERADA, NOMBRESERVICIO, ME                         TODOSERVICIO, USASERVICIO, USAEXCEPCION) VALUES ('00', '0391', '01', null, null, null, '1', '0', 'OTH', null, null, null, null, null, null, null, null, null, 'ADMIN', null,                          null, null, null, null, null, null, null, null, null, null, '0', '0')
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKSUBSTRANID) violated


Elapsed: 00:00:00.02

1 row updated.

Elapsed: 00:00:00.01

1 row deleted.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCOMPANIATRANSACCIONES (CPERSONA_COMPANIA, CSUBSISTEMA, CTRANSACCION, VERSIONTRANSACCION, VERSIONCONTROL) VALUES (2, '00', '0391', '01', 1)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCIATRAN) violated


Elapsed: 00:00:00.04

0 rows deleted.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.20
INSERT INTO INTCORE.TCOMANDOSID (COMANDO, TIPOCOMANDO, INACTIVAR) VALUES ('com.fitbank.processor.maintenance.MaintenanceProcessor', 'MAN', '0')
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.PK_TCOMANDOSID) violated


Elapsed: 00:00:00.00

0 rows deleted.

Elapsed: 00:00:00.28

1 row created.

Elapsed: 00:00:00.18
INSERT INTO INTCORE.TCOMANDOS (COMANDO, TIPOCOMANDO, FHASTA, CIDIOMA, FDESDE, DESCRIPCION, VERSIONCONTROL) VALUES ('com.fitbank.processor.maintenance.MaintenanceProcessor',                          'MAN', TIMESTAMP '2999-12-31 00:00:00', 'ES', TIMESTAMP '2022-11-01 00:00:00', 'Comando que ejecuta el proceso de mantenimiento estándar y financiero de inttegrio', 1)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCOMANDO) violated


Elapsed: 00:00:00.00

0 rows deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.14

1 row created.

Elapsed: 00:00:00.00

0 rows deleted.

Elapsed: 00:00:00.01

0 rows deleted.

Elapsed: 00:00:00.01

0 rows deleted.

Elapsed: 00:00:00.00
INSERT INTO INTCORE.TSUBSISTEMATRANSACCIONESID (CSUBSISTEMA, CTRANSACCION, VERSIONTRANSACCION, ORDENMENU, PRESENTARENMENU, INTERNA, FORMULARIOBASE, AFECTAINMOVILIZACION, CG                         RUPOTRANSACCION, PRESENTARENREVERSO, CNIVELMENU, LISTAVALOR, USACACHE, SUMACOMPONENTES, PROVISION, COMPLETARRUBROS, LOTEGENERICO, VERIFICANIVELSEGURIDAD, CUSUARIO_INGRESO,                          FINGRESO, ACUMULACONTADOR, PAGINA, ORIGENDESTINO, CONTROLAEFECTIVO, REQUIEREAUTORIZACION, EJECUTAENAUTORIZACION, CVARIANTEIDIOMA, CTIPOOPERACIONESPERADA, NOMBRESERVICIO, ME                         TODOSERVICIO, USASERVICIO, USAEXCEPCION) VALUES ('00', '0392', '01', null, null, null, '1', '0', 'OTH', null, null, null, null, null, null, null, null, null, 'ADMIN', null,                          null, null, null, null, null, null, null, null, null, null, '0', '0')
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKSUBSTRANID) violated


Elapsed: 00:00:00.00

1 row updated.

Elapsed: 00:00:00.01

1 row deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCOMPANIATRANSACCIONES (CPERSONA_COMPANIA, CSUBSISTEMA, CTRANSACCION, VERSIONTRANSACCION, VERSIONCONTROL) VALUES (2, '00', '0392', '01', 1)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCIATRAN) violated


Elapsed: 00:00:00.00

0 rows deleted.

Elapsed: 00:00:00.00

0 rows deleted.

Elapsed: 00:00:00.01

0 rows deleted.

Elapsed: 00:00:00.00

0 rows deleted.

Elapsed: 00:00:00.00

0 rows deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row updated.

Elapsed: 00:00:00.01

0 rows deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.01

0 rows deleted.

Elapsed: 00:00:00.00

0 rows deleted.

Elapsed: 00:00:00.00

0 rows deleted.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.37

0 rows deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.03

0 rows deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.02

1 row created.

Elapsed: 00:00:00.00

1 row updated.

Elapsed: 00:00:00.01

0 rows deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

0 rows deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.02
INSERT INTO INTCORE.TCOMANDOSID (COMANDO, TIPOCOMANDO, INACTIVAR) VALUES ('com.fitbank.processor.maintenance.MaintenanceProcessor', 'MAN', '0')
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.PK_TCOMANDOSID) violated


Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCOMANDOSID (COMANDO, TIPOCOMANDO, INACTIVAR) VALUES ('com.fitbank.term.maintenance.FlushTransaction', 'MAN', '0')
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.PK_TCOMANDOSID) violated


Elapsed: 00:00:00.00

0 rows deleted.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.01
INSERT INTO INTCORE.TCOMANDOS (COMANDO, TIPOCOMANDO, FHASTA, CIDIOMA, FDESDE, DESCRIPCION, VERSIONCONTROL) VALUES ('com.fitbank.processor.maintenance.MaintenanceProcessor',                          'MAN', TIMESTAMP '2999-12-31 00:00:00', 'ES', TIMESTAMP '2022-11-01 00:00:00', 'Comando que ejecuta el proceso de mantenimiento estándar y financiero de inttegrio', 1)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCOMANDO) violated


Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCOMANDOS (COMANDO, TIPOCOMANDO, FHASTA, CIDIOMA, FDESDE, DESCRIPCION, VERSIONCONTROL) VALUES ('com.fitbank.term.maintenance.FlushTransaction', 'MAN', T                         IMESTAMP '2999-12-31 00:00:00', 'EN', TIMESTAMP '2022-11-01 00:00:00', 'DESCRIPTION', 1)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCOMANDO) violated


Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCOMANDOS (COMANDO, TIPOCOMANDO, FHASTA, CIDIOMA, FDESDE, DESCRIPCION, VERSIONCONTROL) VALUES ('com.fitbank.term.maintenance.FlushTransaction', 'MAN', T                         IMESTAMP '2999-12-31 00:00:00', 'ES', TIMESTAMP '2022-11-01 00:00:00', 'DESCRIPCION', 1)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCOMANDO) violated


Elapsed: 00:00:00.00

0 rows deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.01

0 rows deleted.

Elapsed: 00:00:00.00

0 rows deleted.

Elapsed: 00:00:00.00

0 rows deleted.

Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCONCEPTOSID (CCONCEPTO, CSUBSISTEMA, CGRUPOTRANSACCION, CODIGOORDENPAGO) VALUES ('760', '04', 'DEB', null)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCONCEPID) violated


Elapsed: 00:00:00.08
INSERT INTO INTCORE.TCONCEPTOSID (CCONCEPTO, CSUBSISTEMA, CGRUPOTRANSACCION, CODIGOORDENPAGO) VALUES ('761', '04', 'DEB', null)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCONCEPID) violated


Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCONCEPTOSID (CCONCEPTO, CSUBSISTEMA, CGRUPOTRANSACCION, CODIGOORDENPAGO) VALUES ('762', '04', 'DEB', null)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCONCEPID) violated


Elapsed: 00:00:00.01
INSERT INTO INTCORE.TCONCEPTOSID (CCONCEPTO, CSUBSISTEMA, CGRUPOTRANSACCION, CODIGOORDENPAGO) VALUES ('763', '04', 'DEB', null)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCONCEPID) violated


Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCONCEPTOSID (CCONCEPTO, CSUBSISTEMA, CGRUPOTRANSACCION, CODIGOORDENPAGO) VALUES ('764', '04', 'DEB', null)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCONCEPID) violated


Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCONCEPTOSID (CCONCEPTO, CSUBSISTEMA, CGRUPOTRANSACCION, CODIGOORDENPAGO) VALUES ('765', '04', 'DEB', null)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCONCEPID) violated


Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCONCEPTOSID (CCONCEPTO, CSUBSISTEMA, CGRUPOTRANSACCION, CODIGOORDENPAGO) VALUES ('766', '04', 'DEB', null)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCONCEPID) violated


Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCONCEPTOSID (CCONCEPTO, CSUBSISTEMA, CGRUPOTRANSACCION, CODIGOORDENPAGO) VALUES ('767', '04', 'DEB', null)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCONCEPID) violated


Elapsed: 00:00:00.01
INSERT INTO INTCORE.TCONCEPTOSID (CCONCEPTO, CSUBSISTEMA, CGRUPOTRANSACCION, CODIGOORDENPAGO) VALUES ('768', '04', 'DEB', null)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCONCEPID) violated


Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCONCEPTOSID (CCONCEPTO, CSUBSISTEMA, CGRUPOTRANSACCION, CODIGOORDENPAGO) VALUES ('769', '04', 'DEB', null)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCONCEPID) violated


Elapsed: 00:00:00.00

0 rows deleted.

Elapsed: 00:00:00.02
INSERT INTO INTCORE.TCONCEPTOS (CIDIOMA, CCONCEPTO, FHASTA, FDESDE, DESCRIPCION, VERSIONCONTROL) VALUES ('ES', '760', TIMESTAMP '2999-12-31 00:00:00', TIMESTAMP '2022-11-01                          00:00:00', 'RECAUDACION COMERCIOS LOCAL 1', 1)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCONCEP) violated


Elapsed: 00:00:00.36
INSERT INTO INTCORE.TCONCEPTOS (CIDIOMA, CCONCEPTO, FHASTA, FDESDE, DESCRIPCION, VERSIONCONTROL) VALUES ('ES', '761', TIMESTAMP '2999-12-31 00:00:00', TIMESTAMP '2022-11-01                          00:00:00', 'RECAUDACION COMERCIOS LOCAL 2', 1)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCONCEP) violated


Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCONCEPTOS (CIDIOMA, CCONCEPTO, FHASTA, FDESDE, DESCRIPCION, VERSIONCONTROL) VALUES ('ES', '762', TIMESTAMP '2999-12-31 00:00:00', TIMESTAMP '2022-11-01                          00:00:00', 'RECAUDACION COMERCIOS LOCAL 3', 1)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCONCEP) violated


Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCONCEPTOS (CIDIOMA, CCONCEPTO, FHASTA, FDESDE, DESCRIPCION, VERSIONCONTROL) VALUES ('ES', '763', TIMESTAMP '2999-12-31 00:00:00', TIMESTAMP '2022-11-01                          00:00:00', 'RECAUDACION COMERCIOS LOCAL 4', 1)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCONCEP) violated


Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCONCEPTOS (CIDIOMA, CCONCEPTO, FHASTA, FDESDE, DESCRIPCION, VERSIONCONTROL) VALUES ('ES', '764', TIMESTAMP '2999-12-31 00:00:00', TIMESTAMP '2022-11-01                          00:00:00', 'RECAUDACION COMERCIOS LOCAL 5', 1)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCONCEP) violated


Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCONCEPTOS (CIDIOMA, CCONCEPTO, FHASTA, FDESDE, DESCRIPCION, VERSIONCONTROL) VALUES ('ES', '765', TIMESTAMP '2999-12-31 00:00:00', TIMESTAMP '2022-11-01                          00:00:00', 'RECAUDACION COMERCIOS LOCAL 6', 1)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCONCEP) violated


Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCONCEPTOS (CIDIOMA, CCONCEPTO, FHASTA, FDESDE, DESCRIPCION, VERSIONCONTROL) VALUES ('ES', '766', TIMESTAMP '2999-12-31 00:00:00', TIMESTAMP '2022-11-01                          00:00:00', 'RECAUDACION COMERCIOS LOCAL 7', 1)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCONCEP) violated


Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCONCEPTOS (CIDIOMA, CCONCEPTO, FHASTA, FDESDE, DESCRIPCION, VERSIONCONTROL) VALUES ('ES', '767', TIMESTAMP '2999-12-31 00:00:00', TIMESTAMP '2022-11-01                          00:00:00', 'RECAUDACION COMERCIOS LOCAL 8', 1)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCONCEP) violated


Elapsed: 00:00:00.01
INSERT INTO INTCORE.TCONCEPTOS (CIDIOMA, CCONCEPTO, FHASTA, FDESDE, DESCRIPCION, VERSIONCONTROL) VALUES ('ES', '768', TIMESTAMP '2999-12-31 00:00:00', TIMESTAMP '2022-11-01                          00:00:00', 'RECAUDACION COMERCIOS LOCAL 9', 1)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCONCEP) violated


Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCONCEPTOS (CIDIOMA, CCONCEPTO, FHASTA, FDESDE, DESCRIPCION, VERSIONCONTROL) VALUES ('ES', '769', TIMESTAMP '2999-12-31 00:00:00', TIMESTAMP '2022-11-01                          00:00:00', 'RECAUDACION COMERCIOS LOCAL 10', 1)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCONCEP) violated


Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.16

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

0 rows deleted.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.02

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.01

0 rows deleted.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.02

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

0 rows deleted.

Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCATEGORIASID (CATEGORIA, CGRUPOBALANCE, CPERSONA_COMPANIA) VALUES ('ND760', '2', 2)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCATEGORIAID) violated


Elapsed: 00:00:00.14

2 rows deleted.

Elapsed: 00:00:00.16

1 row created.

Elapsed: 00:00:00.30

1 row deleted.

Elapsed: 00:00:00.05

1 row created.

Elapsed: 00:00:00.13
INSERT INTO INTCORE.TCATEGORIASID (CATEGORIA, CGRUPOBALANCE, CPERSONA_COMPANIA) VALUES ('ND761', '2', 2)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCATEGORIAID) violated


Elapsed: 00:00:00.01

2 rows deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.01
INSERT INTO INTCORE.TCATEGORIASID (CATEGORIA, CGRUPOBALANCE, CPERSONA_COMPANIA) VALUES ('ND762', '2', 2)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCATEGORIAID) violated


Elapsed: 00:00:00.00

2 rows deleted.

Elapsed: 00:00:00.16

1 row created.

Elapsed: 00:00:00.00

1 row deleted.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCATEGORIASID (CATEGORIA, CGRUPOBALANCE, CPERSONA_COMPANIA) VALUES ('ND763', '2', 2)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCATEGORIAID) violated


Elapsed: 00:00:00.00

2 rows deleted.

Elapsed: 00:00:00.10

1 row created.

Elapsed: 00:00:00.00

1 row deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCATEGORIASID (CATEGORIA, CGRUPOBALANCE, CPERSONA_COMPANIA) VALUES ('ND764', '2', 2)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCATEGORIAID) violated


Elapsed: 00:00:00.01

2 rows deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCATEGORIASID (CATEGORIA, CGRUPOBALANCE, CPERSONA_COMPANIA) VALUES ('ND765', '2', 2)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCATEGORIAID) violated


Elapsed: 00:00:00.01

2 rows deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCATEGORIASID (CATEGORIA, CGRUPOBALANCE, CPERSONA_COMPANIA) VALUES ('ND766', '2', 2)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCATEGORIAID) violated


Elapsed: 00:00:00.01

2 rows deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCATEGORIASID (CATEGORIA, CGRUPOBALANCE, CPERSONA_COMPANIA) VALUES ('ND767', '2', 2)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCATEGORIAID) violated


Elapsed: 00:00:00.00

2 rows deleted.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.00

1 row deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCATEGORIASID (CATEGORIA, CGRUPOBALANCE, CPERSONA_COMPANIA) VALUES ('ND768', '2', 2)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCATEGORIAID) violated


Elapsed: 00:00:00.00

2 rows deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row deleted.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.00
INSERT INTO INTCORE.TCATEGORIASID (CATEGORIA, CGRUPOBALANCE, CPERSONA_COMPANIA) VALUES ('ND769', '2', 2)
*
ERROR at line 1:
ORA-00001: unique constraint (INTCORE.IPKCATEGORIAID) violated


Elapsed: 00:00:00.00

2 rows deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row deleted.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.00

0 rows deleted.

Elapsed: 00:00:00.03

0 rows deleted.

Elapsed: 00:00:00.15

0 rows deleted.

Elapsed: 00:00:00.18

0 rows deleted.

Elapsed: 00:00:00.02

0 rows deleted.

Elapsed: 00:00:00.12

0 rows deleted.

Elapsed: 00:00:00.02

0 rows deleted.

Elapsed: 00:00:00.13

0 rows deleted.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.16

1 row created.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.27

1 row created.

Elapsed: 00:00:00.05

1 row created.

Elapsed: 00:00:00.10

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.24

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.08

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.32

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.00

0 rows deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.01

0 rows deleted.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.37

0 rows deleted.

Elapsed: 00:00:00.02

1 row created.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.13

0 rows deleted.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.00

1 row created.

Elapsed: 00:00:00.10

0 rows deleted.

Elapsed: 00:00:00.01

1 row created.

Elapsed: 00:00:00.00

Commit complete.

Elapsed: 00:00:00.23
15:27:48 SYS@INTCORE1>
