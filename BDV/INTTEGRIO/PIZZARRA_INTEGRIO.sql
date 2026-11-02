ALTER SESSION SET CURRENT_SCHEMA=INTTEGRIOBDV;

SPOOL FullSQL_TLOGMESAJES_280325.log
SET TIMI ON 
SET TIME ON

select * from tlogmensajes order by freal desc;


SPOOL OFF


-----------------------------------------------------------------------
update INTTEGRIOBDV.tservidoraplicacion set URL= 'http://XXX:8080YYY/UCI', ENLINEA=0;
update INTTEGRIOBDV.tdispositivofit set disponible = '0';
commit;
-----------------------------------------------------------------------
update INTTEGRIOBDV.tservidoraplicacion set URL= 'http://XXX:8080YYY/UCI', ENLINEA=0;
update INTTEGRIOBDV.tdispositivofit set disponible = '0';
commit;
--------------
delete from INTTEGRIOBDV.tusuariosesiones where cusuario = 'TRANSLATE';
------
select count(NUMEROINGRESOS) from INTTEGRIOBDV.tusuariosesionesresumen where cusuario = 'TRANSLATE';

select count(cusuario) from INTTEGRIOBDV.tusuariosesiones where cusuario = 'TRANSLATE';
select cusuario, FACTOR from INTTEGRIOBDV.tusuariosesiones fetch first 10 rows only ;

select count(1) from INTTEGRIOBDV.tusuariosesionesresumen where cusuario  = 'TRANSLATE';

delete from INTTEGRIOBDV.tusuariosesiones where cusuario = 'TRANSLATE';
--------
select count(1) from INTTEGRIOBDV.tusuariosesionesresumen where cusuario  = 'TRANSLATE';
select * from INTTEGRIOBDV.tusuariosesionesresumen  where cusuario  = 'TRANSLATE';
-----
update INTTEGRIOBDV.tusuariosesionesresumen set numeroingresos = 1 where cusuario  = 'TRANSLATE';






----------------------	
select CTERMINAL from tterminales where fhasta = fncfhasta and cterminal like 'NM42169%';
.
.
select csucursal, coficina from INTTEGRIOBDV.tcompaniausuarios where fhasta = fncfhasta and cusuario like 'NM32144';


select * from INTTEGRIOBDV.tdispositivofit;
select * from INTTEGRIOBDV.gtcargalote;



set linesize 500
col URL format a50
col NOMBRE format a15
select * from INTTEGRIOBDV.tservidoraplicacion;

-----

set line 180 pagesize 300
col OWNER for a15
col SEGMENT_NAME for a35
col SEGMENT_TYPE for a15
col SIZE_MB for 999,999,999.99
select OWNER
, SEGMENT_NAME
, SEGMENT_TYPE
, BYTES/1024/1024 SIZE_MB
from dba_segments
where SEGMENT_TYPE = 'TABLE'
ORDER BY SIZE_MB
/
-----------------

EXCLUDE=TABLE:"IN('TSALDOS')"
EXCLUDE=TABLE:"IN('TSALDOSPORFECHAVALOR')"
EXCLUDE=TABLE:"IN('TMOVIMIENTOS')"
EXCLUDE=TABLE:"IN('TCUENTASPORCOBRAR')"
EXCLUDE=TABLE:"IN('TLOGMENSAJESCOEXISTENCIA')"
EXCLUDE=TABLE:"IN('TMENSAJESCOEXRECIBIDOS')"
EXCLUDE=TABLE:"IN('TLOGSTECLEO')"
-------------------------------------------------------------------------------------

LOGFILE=EXPORT_BD:BACKUP_INTTQ.log
DUMPFILE=EXPORT_BD:BACKUP_INTTQ_31032025_P%U.dmp
EXCLUDE=AUDIT_TRAILS
EXCLUDE=STATISTICS
METRICS=Y
INCLUDE=SCHEMA:"IN('INTTEGRIOBDV')"
EXCLUDE=TABLE:"IN('TSALDOS')"
EXCLUDE=TABLE:"IN('TSALDOSPORFECHAVALOR')"
EXCLUDE=TABLE:"IN('TMOVIMIENTOS')"
EXCLUDE=TABLE:"IN('TCUENTASPORCOBRAR')"
EXCLUDE=TABLE:"IN('TLOGMENSAJESCOEXISTENCIA')"
EXCLUDE=TABLE:"IN('TMENSAJESCOEXRECIBIDOS')"
EXCLUDE=TABLE:"IN('TLOGSTECLEO')"
PARALLEL=20
ESTIMATE=Y



desc INTTEGRIOBDV.tlotemensajes

set linesize 500
select 
FECHALOTE                
,NUMEROLOTE               
,CPERSONA_COMPANIA        
,CUSUARIO_PROCESO         
,FPROCESO                 
,NUMEROERRORESPROCESO     
,ESTATUS                  
--,COMENTARIOS              
,CSUBSISTEMA              
,CTRANSACCION             
,VERSIONTRANSACCION       
--,CPERSONA_COMPANIAORIGEN  
--,CSUCURSAL_ORIGEN         
--,COFICINA_ORIGEN          
--,CESTRUCTURA              
,CTIPOLOTE                
,NUMEROREGISTROSPROCESADOS
,VERSIONCONTROL           
,IDENTIFICADOR         
from INTTEGRIOBDV.tlotemensajes order by fechalote desc
fetch first 10 rows only ;


select
NUMEROLOTE       
,FECHALOTE        
,STRANSACCION     
,CODIGORESULTADO  
,TEXTOERROR       
,MENSAJEORIGINAL  
from INTTEGRIOBDV.TLOTEMENSAJESDETALLE
order by fechalote desc
fetch first 10 rows only ;

------
truncate table INTTEGRIOBDV.gtcargalote DROP storage;
select count(1) from INTTEGRIOBDV.gtcargalote;


------------------------------------------------------------
delete from INTTEGRIOBDV.tlotemensajesdetalle where fechalote = date '2025-04-14';
delete from INTTEGRIOBDV.tlotemensajes where fechalote = date '2025-04-14';
commit;


BGDTAUX_AUXILIAR_CUENTAS20250413014353.TXT

ALTER PROFILE APPS LIMIT FAILED_LOGIN_ATTEMPTS UNLIMITED;

select RESOURCE_NAME
, RESOURCE_TYPE
, LIMIT 
from dba_profiles
where profile='APPS';


select RESOURCE_NAME
, RESOURCE_TYPE
, LIMIT 
from dba_profiles
where profile='DEFAULT';

SET LINE 300 pages 300
COL USERNAME FOR A15
COL DEFAULT_TABLESPACE FOR A25
COL TEMPORARY_TABLESPACE FOR A25
COL PROFILE FOR A25
COL ACCOUNT_STATUS FOR A10
COL EXPIRY_DATE FOR A20
SELECT  
USERNAME
, ACCOUNT_STATUS 
, TO_CHAR(EXPIRY_DATE,'RRRR-MM-DD HH24:MI:SS') EXPIRY_DATE
, DEFAULT_TABLESPACE
, TEMPORARY_TABLESPACE
, PROFILE 
FROM DBA_USERS 
WHERE USERNAME = 'INTTEGRIOBDV'
/


INTTEGRIOBDV.TLOTEMENSAJESDETALLE
------------

select count(*), csubsistema, ctransaccion, cestructura from INTTEGRIOBDV.tlotemensajes 
where fechalote = to_date('2025-11-09','yyyy-mm-dd')
group by csubsistema, ctransaccion, cestructura;

select numerolote, cestructura, fechalote from INTTEGRIOBDV.tlotemensajes where fechalote = date '2025-11-09' and cestructura = 'BGDTAUXD';
----
select count(*) from INTTEGRIOBDV.tlotemensajesdetalle where fechalote = date '2025-11-09' and numerolote in (4378,4379);
delete from INTTEGRIOBDV.tlotemensajesdetalle where fechalote = date '2025-11-09' and numerolote in (4378,4379);
delete from INTTEGRIOBDV.tlotemensajes where fechalote = date '2025-11-09' and cestructura = 'BGDTAUXD';


	------

	"INTTEGRIOBDV"."TLOTEMENSAJESDETALLE"."TEXTOERROR" (actual: 2023, maximum: 2000)


	desc "INTTEGRIOBDV"."TLOTEMENSAJESDETALLE"


	ALTER TABLE INTTEGRIOBDV.TLOTEMENSAJESDETALLE MODIFY TEXTOERROR VARCHAR2(4000);


truncate table gtcargalote drop storage;




select * from inttegriobdv.tlotemensajes where fechalote = to_date('2025-11-09','yyyy-mm-dd') and numerolote = 43122;


col IDENTIFICADOR format a50
select 
FECHALOTE,
NUMEROLOTE, 
CPERSONA_COMPANIA, 
ESTATUS,
IDENTIFICADOR
from inttegriobdv.tlotemensajes where fechalote = to_date('2025-12-04','yyyy-mm-dd') and numerolote = 43252;

select * from gtcargalote;


update inttegriobdv.tlotemensajes set estatus = 'E' where fechalote = to_date('2025-11-19','yyyy-mm-dd') and numerolote = 43252;

update inttegriobdv.tlotemensajes set estatus = 'P' where fechalote = to_date('2025-12-04','yyyy-mm-dd') and numerolote = 17489;
update inttegriobdv.tlotemensajes set estatus = 'P' where fechalote = to_date('2025-11-28','yyyy-mm-dd') and numerolote = 38331;
update inttegriobdv.tlotemensajes set estatus = 'P' where fechalote = to_date('2025-11-28','yyyy-mm-dd') and numerolote = 38332;
update inttegriobdv.tlotemensajes set estatus = 'P' where fechalote = to_date('2025-11-28','yyyy-mm-dd') and numerolote = 38333;
commit;


tcpdump -i ens160 -w /tmp/archivo.dump

tcpdump -i nombredeinterface -s 0 -n -v host ipdestino and port #puerto -w nombreserver.cap

sudo tcpdump -i ens192 -w captura.cap -vvv

sudo tcpdump -i any -s0 -X -S -vvv -ttt -w capserver.cap

tcpdump -i any -s0 -X -S -vvv -ttt -w bd.cap



Col sequence_owner format a20
col sequence_name format a20
SELECT last_number, sequence_owner, sequence_name, cache_size, order_flag FROM dba_sequences WHERE sequence_name = 'slotemensaje';

Col sequence_owner format a20
col sequence_name format a20
SELECT last_number, sequence_owner, sequence_name, cache_size, order_flag FROM dba_sequences WHERE sequence_owner = 'INTTEGRIOBDV';


SELECT 	sequence_name, min_value, increment_by, last_number, cache_size, order_flash 
FROM dba_sequences
WHERE sequence_name = 'SLOTEMENSAJE';

SELECT * FROM inttegriobdv.tlotemensajes ORDER BY fechalote, numerolote;



--- lOTE QUE ESTA FALLANDO 
fechalote=2025-04-16
estructura=PETC001003
tipolote=NOEJ


DELETE from INTTEGRIOBDV.gtcargalote 
where fechalote = to_date('2025-04-16', 'YYYY-MM-DD')
and cestructura = 'PETC001003'
and ctipolote = 'NOEJ'
;


select * from INTTEGRIOBDV.gtcargalote
WHERE	fechalote = to_date('2025-04-16', 'YYYY-MM-DD')
and cestructura = 'PETC001003'
and ctipolote = 'NOEJ'
;




select /*+PARALLEL(50) */ count(1),a.codigoresultado from tlogmensajescoexistencia a where trunc(a.freal) >= to_date('2025-06-30','yyyy-mm-dd') group by a.codigoresultado;

select /*+PARALLEL(50) */ count(1),a.codigoresultado from tlogmensajescoexistencia a where trunc(a.freal) >= to_date('2025-07-01','yyyy-mm-dd') group by a.codigoresultado;


SELECT /*+PARALLEL(50) */
COUNT(1) AS CANTIDAD, A.CODIGORESULTADO
FROM INTTEGRIOBDV.TLOGMENSAJESCOEXISTENCIA A
WHERE A.FREAL BETWEEN TIMESTAMP '2025-07-07 16:00:00.0' AND TIMESTAMP '2025-07-08 08:30:00.0'
GROUP BY A.CODIGORESULTADO
ORDER BY A.CODIGORESULTADO;



SELECT /*+PARALLEL(50) */
COUNT(1) AS CANTIDAD, A.CODIGORESULTADO
FROM INTTEGRIOBDV.TLOGMENSAJESCOEXISTENCIA A
WHERE A.FREAL BETWEEN TIMESTAMP ‘2025-07-19 00:00:00.0’ AND TIMESTAMP ‘2025-07-22 07:30:00.0’
GROUP BY A.CODIGORESULTADO
ORDER BY A.CODIGORESULTADO;


DEFINE start_time = '2025-07-19 00:00:00.0'
DEFINE end_time   = '2025-07-22 00:00:00.0'
DEFINE codigo     = 'FI-030'
SELECT /*+PARALLEL(50) */
*
FROM TLOGMENSAJESCOEXISTENCIA 
WHERE 1=1 
  AND freal BETWEEN timestamp '&start_time' AND timestamp '&end_time' 
  AND CODIGORESULTADO = '&codigo'
/




------------------------------  BIEN  ------------------------------
SELECT 
COUNT(1) AS CANTIDAD, A.CODIGORESULTADO
FROM INTTEGRIOBDV.TLOGMENSAJESCOEXISTENCIA A
WHERE A.FREAL BETWEEN TIMESTAMP '2025-08-05 00:00:00.0' AND TIMESTAMP '2025-08-05 23:59:59.9'
GROUP BY A.CODIGORESULTADO
ORDER BY A.CODIGORESULTADO;


------------------------------  BIEN  ------------------------------

SELECT /*+PARALLEL(50) */ COUNT(1),A.CODIGORESULTADO 
FROM INTTEGRIOBDV.TLOGMENSAJESCOEXISTENCIA A 
WHERE TRUNC(A.FREAL) >= TO_DATE('2025-07-26','YYYY-MM-DD') 
GROUP BY A.CODIGORESULTADO;


--------------------------------------------------------------------




set lin 180
col host_name format a32
SELECT /*+PARALLEL(50) */
FROM INTTEGRIOBDV.TLOGMENSAJESCOEXISTENCIA
WHERE codigoresultado = 'FI-130'
AND freal BETWEEN to_timestamp('2025-07-19 00:00.00.0','yyyy-mm-dd hh24:mi:ss.ff') AND to_timestamp('2025-07-19 23:59:59.0','yyyy-mm-dd hh24:mi:ss.ff')
;



set lines 400
SELECT /*+PARALLEL(50) */count(1),CODIGORESULTADO 
FROM INTTEGRIOBDV.TLOGMENSAJESCOEXISTENCIA 
WHERE freal BETWEEN TIMESTAMP '2025-07-19 00:00:00' AND TIMESTAMP '2025-07-25 00:00:00' 
GROUP BY CODIGORESULTADO;
 

set lines 400
SELECT /*+PARALLEL(50) */count(1),CODIGORESULTADO 
FROM INTTEGRIOBDV.TLOGMENSAJESCOEXISTENCIA 
WHERE freal BETWEEN TIMESTAMP '2025-07-19 07:00:00' AND TIMESTAMP '2025-07-21 23:59:59' 
GROUP BY CODIGORESULTADO;
 
 
 


SELECT * FROM INTTEGRIOBDV.TMENSAJESCOEXRECIBIDOS WHERE FPROCESO BETWEEN TIMESTAMP '2025-08-01 00:00:00.0' AND TIMESTAMP '2025-08-01 23:59:59.9';



ALTER SESSION SET CURRENT_SCHEMA = INTTEGRIOBDV;


select numerolote, cestructura, estatus, fechalote from tlotemensajes where fechalote = to_date('2025-06-30','yyyy-mm-dd') and cestructura = 'PETC001003';

select numerolote, cestructura, estatus, fechalote from tlotemensajes where fechalote = to_date('2025-06-30','yyyy-mm-dd') and cestructura = 'PEDT003D';

select numerolote, cestructura, estatus, fechalote from tlotemensajes where fechalote = to_date('2025-06-30','yyyy-mm-dd') and cestructura = 'BGTCMAEAUX008';





---------------------------------------------------------------------------------------------------------


select numerolote, cestructura, estatus, fechalote from tlotemensajes where fechalote = to_date('2025-07-26','yyyy-mm-dd') and cestructura = 'PETC001003';
select numerolote, cestructura, estatus, fechalote from tlotemensajes where fechalote = to_date('2025-07-26','yyyy-mm-dd') and cestructura = 'PEDT001D';
select numerolote, cestructura, estatus, fechalote from tlotemensajes where fechalote = to_date('2025-07-26','yyyy-mm-dd') and cestructura = 'BGTCMAEAUX008';
select numerolote, cestructura, estatus, fechalote from tlotemensajes where fechalote = to_date('2025-07-26','yyyy-mm-dd') and cestructura = 'BGDTMAED';

select numerolote, cestructura, estatus, fechalote from tlotemensajes order by fechalote;











select * from INTTEGRIOBDV.tdispositivofit


-------
--- PQC MODIFICADO
-------
1. update INTTEGRIOBDV.tservidoraplicacion set URL= 'http://10.244.0.1:8080/INTTEGRIOUCI/UCI', ENLINEA=1 WHERE NOMBRE = 'UCI1';
2. update INTTEGRIOBDV.tdispositivofit set disponible = '0';
commit;

3. delete from INTTEGRIOBDV.tusuariosesiones where cusuario = 'TRANSLATE';
4. delete from INTTEGRIOBDV.tusuariosesionesresumen where cusuario = 'TRANSLATE';
Commit;

-----
update INTTEGRIOBDV.tservidoraplicacion set URL= 'http://XXX:8080YYY/UCI' ENLINEA = 0 WHERE NOMBRE NOT IN ('UCI', 'UCI1');
-----  


--- PQC ORIGINAL PARA PRODUCCIÓN
1.-update INTTEGRIOBDV.tservidoraplicacion set URL= 'http://XXX:8080YYY/UCI', ENLINEA=0 where nombre = 'UCI2';
2.-update INTTEGRIOBDV.tdispositivofit set disponible = '0' WHERE CSERVIDORAPLICACION = 'UCI2';
commit;

3.-delete from INTTEGRIOBDV.tusuariosesiones where cusuario = 'TRANSLATE';
4. delete from INTTEGRIOBDV.tusuariosesionesresumen where cusuario = 'TRANSLATE';
Commit;


----

--- LIMPIEZA DE LOS DEMAS UCI MENOS (UCI y UCI1) (CALIDAD Y PRODUCCION)
update INTTEGRIOBDV.tservidoraplicacion set URL = 'http://XXX:8080YYY/UCI', ENLINEA =0  WHERE NOMBRE NOT IN ('UCI', 'UCI1');
commit;

----
--- MODIFICAR EL ENLINEA SEGUN SEA LA NECESIDAD  (PRODUCCION)
update INTTEGRIOBDV.tservidoraplicacion set ENLINEA=1 where nombre = 'UCI';
update INTTEGRIOBDV.tservidoraplicacion set ENLINEA=0 where nombre = 'UCI1';
update INTTEGRIOBDV.tservidoraplicacion set ENLINEA=0 where nombre = 'UCI';
commit;


update INTTEGRIOBDV.tservidoraplicacion set ENLINEA=1 where nombre = 'UCI2';
update INTTEGRIOBDV.tservidoraplicacion set ENLINEA=1 where nombre = 'UCI3';
update INTTEGRIOBDV.tservidoraplicacion set ENLINEA=1 where nombre = 'UCI4';
update INTTEGRIOBDV.tservidoraplicacion set ENLINEA=1 where nombre = 'UCI5';
commit;

---
--- CASO DE EMERGENCIA QUE EL UCI NO TENGA LA URL
update INTTEGRIOBDV.tservidoraplicacion set URL= 'http://10.244.0.1:8080/INTTEGRIOUCI/UCI', ENLINEA=1 where nombre = 'UCI1';




http://10.244.0.200:8080/INTTEGRIOUCI/UCI
http://10.244.0.1:8080/INTTEGRIOUCI/UCI

PARA PROCESAR AUTOLOTE
------ 17/11/25
update INTTEGRIOBDV.tservidoraplicacion set URL='http://10.244.0.1:8080/INTTEGRIOUCI/UCI', ENLINEA=1, where nombre = 'UCI1';
Commit;

update INTTEGRIOBDV.tservidoraplicacion set URL= 'http://XXX:8080YYY/UCI', ENLINEA=0 where nombre = 'UCI1';
commit;


----
update INTTEGRIOBDV.tservidoraplicacion set URL= 'http://XXX:8080YYY/UCI', ENLINEA=0 , VERSIONCONTROL=8 where nombre = 'UCI6';
commit;

update INTTEGRIOBDV.tservidoraplicacion set URL= 'http://10.244.0.200:8080/INTTEGRIOUCI/UCI', ENLINEA=1 , VERSIONCONTROL=36 where nombre = 'UCI1';
commit;

------------------------
-- CONSULTA TSERVIDORAPLICACION

set linesize 500
SET pagesize 15
col URL format a50
col NOMBRE format a15
select * from INTTEGRIOBDV.tservidoraplicacion
--WHERE NOMBRE NOT IN ('UCI', 'UCI1')
Order by 2;

------------------------------


(PRODUCCION CON INTTEGRIO VIEJO)
CSERVIDORAPLICA NOMBRE          E URL                                                VERSIONCONTROL
--------------- --------------- - -------------------------------------------------- --------------
UCI             UCI             1 http://10.244.198.200:8080/INTTEGRIOUCI/UCI                    62
UCI1            UCI1            1 http://10.244.0.200:8080/INTTEGRIOUCI/UCI                      30
UCI2            UCI2            0 http://XXX:8080YYY/UCI                                         63
UCI3            UCI3            0 http://XXX:8080YYY/UCI                                         30
UCI4            UCI4            0 http://XXX:8080YYY/UCI                                         27
UCI5            UCI5            0 http://XXX:8080YYY/UCI                                         17
UCI6            UCI6            0 http://XXX:8080YYY/UCI                                          3
UCI7            UCI7            0 http://XXX:8080YYY/UCI                                          2

(PRODUCCION CON INTTEGRIO NUEVO)

CSERVIDORAPLICA NOMBRE          E URL                                                VERSIONCONTROL
--------------- --------------- - -------------------------------------------------- --------------
UCI             UCI             0 http://10.244.198.200:8080/INTTEGRIOUCI/UCI                    58
UCI1            UCI1            0 http://10.244.0.200:8080/INTTEGRIOUCI/UCI                      30
UCI2            UCI2            1 http://10.244.127.226:8080/INTTEGRIOUCI/UCI                    57
UCI3            UCI3            1 http://10.244.29.148:8080/INTTEGRIOUCI/UCI                     24
UCI4            UCI4            1 http://10.244.24.225:8080/INTTEGRIOUCI/UCI                     22
UCI5            UCI5            1 http://10.244.75.106:8080/INTTEGRIOUCI/UCI                     14
UCI6            UCI6            0 http://XXX:8080YYY/UCI                                          3
UCI7            UCI7            0 http://XXX:8080YYY/UCI                                          2


(QA)

CSERVIDORAPLICACION                           NOMBRE          ENL URL                                                VERSIONCONTROL
--------------------------------------------- --------------- --- -------------------------------------------------- --------------
UCI                                           UCI             1   http://10.244.0.200:8080/INTTEGRIOUCI/UCI                      60
UCI1                                          UCI1            1   http://10.244.0.1:8080/INTTEGRIOUCI/UCI                         7
UCI10                                         UCI10           0   http://XXX:8080YYY/UCI                                          3
UCI11                                         UCI11           0   http://XXX:8080YYY/UCI                                          3
UCI12                                         UCI12           0   http://XXX:8080YYY/UCI                                          3
UCI13                                         UCI13           0   http://XXX:8080YYY/UCI                                          4
UCI14                                         UCI14           0   http://XXX:8080YYY/UCI                                          3
UCI15                                         UCI15           0   http://XXX:8080YYY/UCI                                          3
UCI16                                         UCI16           0   http://XXX:8080YYY/UCI                                          2
UCI17                                         UCI17           0   http://XXX:8080YYY/UCI                                          2
UCI18                                         UCI18           0   http://XXX:8080YYY/UCI                                          2

CSERVIDORAPLICACION                           NOMBRE          ENL URL                                                VERSIONCONTROL
--------------------------------------------- --------------- --- -------------------------------------------------- --------------
UCI2                                          UCI2            1   http://10.244.0.93:8080/INTTEGRIOUCI/UCI                       32
UCI3                                          UCI3            1   http://10.244.30.144:8080/INTTEGRIOUCI/UCI                     38
UCI4                                          UCI4            0   http://XXX:8080YYY/UCI                                         15
UCI5                                          UCI5            0   http://XXX:8080YYY/UCI                                          9
UCI6                                          UCI6            0   http://XXX:8080YYY/UCI                                          5
UCI7                                          UCI7            0   http://XXX:8080YYY/UCI                                          4
UCI8                                          UCI8            0   http://XXX:8080YYY/UCI                                          4
UCI9                                          UCI9            0   http://XXX:8080YYY/UCI                                          3





select * from INTTEGRIOBDV.tdispositivofit;
SELECT * FROM INTTEGRIOBDV.tusuariosesiones  where cusuario = 'TRANSLATE';
SELECT * from INTTEGRIOBDV.tusuariosesionesresumen  where cusuario = 'TRANSLATE';

select * from INTTEGRIOBDV.tcaracteristicasequipo where cequipo in ('TERM_246433');


Para verificar procesos en vuelo:
SELECT * FROM INTTEGRIOBDV.gtcargalote;

Para purgar procesos en vuelo:
TRUNCATE TABLE INTTEGRIOBDV.gtcargalote drop STORAGE;



-----

CCA CDISPOSITIVO              T UNI CTERMINAL            E CUSUARIO    	     PARAMETROS        CSERVIDORAPLICA      CTIP E E P M   AGRUPAMIENTO                   I VERSIONCONTROL
--- ------------------------- - --- -------------------- - ------------ ---------------------  ------------------- ----- - - - -  -------------                                                                      ----------------------------
FIT   FITS_1                  O   						 1 ADMIN        127.0.0.1#12345#60      UCI1                FITS 1 1 0 0                                1             27


UPDATE INTTEGRIOBDV.TDISPOSITIVO
	SET TIPODISPOSITIVO='O', 
		UNIDADLOGICA=NULL, 
		CTERMINAL=NULL, 
		ENPROCESO='1', 
		CUSUARIO='ADMIN', 
		PARAMETROS='10.244.0.100#6000#60', 
		CSERVIDORAPLICACION='UCI1', 
		CTIPOCONTROLADOR='FITS', 
		EXCLUSIVA='1', 
		ENLINEA='1', 
		PARALELO='0', 
		MODOEXCLUSIVO='0', 
		AGRUPAMIENTO=NULL, 
		INICIAR='1', 
		VERSIONCONTROL=27
WHERE CCANAL='FIT' AND CDISPOSITIVO='FITS_1';



CCA CDISPOSITIVO              T UNI CTERMINAL            E CUSUARIO     PARAMETROS                     CSERVIDORAPLICA CTIP E E P M AGRUPAMIENTO                   I VERSIONCONTROL
--- ------------------------- - --- -------------------- - ------------ ------------------------------ --------------- ---- - - - - ------------------------------ - --------------
FIT FITS_1                    O                          1 ADMIN        10.244.0.100#6000#60           UCI1            FITS 1 1 0 0                                1             27


col CDISPOSITIVO format a12
col CTERMINAL format a10
col CUSUARIO format a10
col PARAMETROS format a50
col CSERVIDORAPLICACION format a5
col AGRUPAMIENTO format a10
col VERSIONCONTROL format a100
select * from INTTEGRIOBDV.TDISPOSITIVO WHERE CCANAL='FIT' AND CDISPOSITIVO='FITS_1';

set pagesize 30
col PARAMETROS format a80
SELECT * FROM INTTEGRIOBDV.tdispositivo WHERE PARAMETROS LIKE '%autolote%';


--- Ejeuto el update 
@Activacion_Autolote.sql



serviceinttegriocore.inttegriobdv.svc#12345#60


------------------------------------------
ADICIONAL MODIFICACION DEL UCI1 
------------------------------------------

15:46:56 SYS@INTTEGP1>
CSERVIDORAPLICA NOMBRE          E URL                                                VERSIONCONTROL
--------------- --------------- - -------------------------------------------------- --------------
UCI             UCI             0 http://10.244.198.200:8080/INTTEGRIOUCI/UCI                    69
UCI1            UCI1            0 http://10.244.0.200:8080/INTTEGRIOUCI/UCI                      30
UCI2            UCI2            1 http://10.244.0.64:8080/INTTEGRIOUCI/UCI                       68
UCI3            UCI3            1 http://10.244.75.69:8080/INTTEGRIOUCI/UCI                      34
UCI4            UCI4            1 http://10.244.24.248:8080/INTTEGRIOUCI/UCI                     31
UCI5            UCI5            1 http://10.244.127.255:8080/INTTEGRIOUCI/UCI                    21
UCI6            UCI6            0 http://XXX:8080YYY/UCI                                          3
UCI7            UCI7            0 http://XXX:8080YYY/UCI                                          2

8 rows selected.

15:46:56 SYS@INTTEGP1>


---- Ejecucion del update 
15:48:52 SYS@INTTEGP1> 
update INTTEGRIOBDV.tservidoraplicacion set URL= 'http://XXX:8080YYY/UCI', ENLINEA=0 where nombre = 'UCI1';
commit
15:49:04 SYS@INTTEGP1>


---- Despues de Ejecutar el UPDATE

CSERVIDORAPLICA NOMBRE          E URL                                                VERSIONCONTROL
--------------- --------------- - -------------------------------------------------- --------------
UCI             UCI             0 http://10.244.198.200:8080/INTTEGRIOUCI/UCI                    69
UCI1            UCI1            0 http://XXX:8080YYY/UCI                                         30
UCI2            UCI2            1 http://10.244.0.64:8080/INTTEGRIOUCI/UCI                       68
UCI3            UCI3            1 http://10.244.75.69:8080/INTTEGRIOUCI/UCI                      34
UCI4            UCI4            1 http://10.244.24.248:8080/INTTEGRIOUCI/UCI                     31
UCI5            UCI5            1 http://10.244.127.255:8080/INTTEGRIOUCI/UCI                    21
UCI6            UCI6            0 http://XXX:8080YYY/UCI                                          3
UCI7            UCI7            0 http://XXX:8080YYY/UCI                                          2

8 rows selected.

Elapsed: 00:00:00.00
15:49:14 SYS@INTTEGP1>


--- AMBIENTE DE CALIDAD
TLOGMENSAJESCOEXISTENCIA 
TMENSAJESCOEXRECIBIDOS

SELECT COUNT(1) FROM 5.TLOGMENSAJESCOEXISTENCIA;
SELECT COUNT(1) FROM INTTEGRIOBDV.TMENSAJESCOEXRECIBIDOS;

truncate TABLE INTTEGRIOBDV.TLOGMENSAJESCOEXISTENCIA;
truncate TABLE INTTEGRIOBDV.TMENSAJESCOEXRECIBIDOS;





INTTEGRIO CALIDAD 13-12-25
SELECT * FROM INTTEGRIOBDV.TDISPOSITIVO WHERE CCANAL='FIT' AND CDISPOSITIVO='FITS_2';
UPDATE INTTEGRIOBDV.TDISPOSITIVO SET PARAMETROS='serviceinttegriocore.inttegriobdv.svc#12345#60' WHERE CCANAL='FIT' AND CDISPOSITIVO='FITS_2';


INTTEGRIO CALIDAD 14-12-25
UPDATE INTTEGRIOBDV.TDISPOSITIVO 
SET TIPODISPOSITIVO='O', UNIDADLOGICA=NULL, CTERMINAL=NULL, ENPROCESO='1', CUSUARIO='ADMIN', PARAMETROS='serviceinttegriocore.inttegriobdv.svc#12345#60', CSERVIDORAPLICACION='UCI1', CTIPOCONTROLADOR='FITS', EXCLUSIVA='1', ENLINEA='1', PARALELO='0', MODOEXCLUSIVO='0', AGRUPAMIENTO=NULL, INICIAR='1', VERSIONCONTROL=29
WHERE CCANAL='FIT' AND CDISPOSITIVO='FITS_1';
COMMIT;


INTTEGRIO PRODUCCION 13-12-25
UPDATE INTTEGRIOBDV.TDISPOSITIVO
SET PARAMETROS = 'serviceinttegriocore.inttegriobdv.svc#12345#60'
WHERE CCANAL = 'FIT' AND CDISPOSITIVO IN ('FITS_2','FITS_3','FITS_4','FITS_5','FITS_6','FITS_7','FITS_8','FITS_9','FITS_10','FITS_11','FITS_12','FITS_13','FITS_14','FITS_15','FITS_16','FITS_17','FITS_18');


col PARAMETROS format a40
SELECT * FROM INTTEGRIOBDV.TDISPOSITIVO 
WHERE CCANAL = 'FIT' AND CDISPOSITIVO IN ('FITS_2', 'FITS_3', 'FITS_4', 'FITS_5', 'FITS_6', 'FITS_7', 'FITS_8', 'FITS_9', 'FITS_10', 'FITS_11', 'FITS_12', 'FITS_13', 'FITS_14', 'FITS_15', 'FITS_16', 'FITS_17', 'FITS_18');



Select * from inttegriobdv.tdispositivo a where a iniciar="1" and a.ctipocontrolador in ('TIME','TASK');



col CEQUIPO format a10
col CDOMINIO format a5
col CDOMINIOVALOR format a5
col CEQUIPO format a10
Select * from inttegriobdv.tcaracteristicasequipo where cequipo in ('TERM_246433');




------------------------------------ TAQUILLAS CONECTADAS  -------------------------------

--- Consulta de Taquillas conectadas 
SELECT CUSUARIO, CTERMINAL 
FROM INTTEGRIOBDV.TUSUARIOSESIONES 
WHERE FHASTA = TIMESTAMP '2999-12-31 00:00:00.0' 
GROUP BY CUSUARIO, CTERMINAL
ORDER BY CTERMINAL;

SELECT COUNT(1), CTERMINAL, CUSUARIO
FROM INTTEGRIOBDV.TUSUARIOSESIONES
WHERE FHASTA = TIMESTAMP '2999-12-31 00:00:00.0'
GROUP BY CUSUARIO, CTERMINAL 
ORDER BY CTERMINAL;


---- Consulta los duplicados  
SELECT COUNT(1), CTERMINAL, CUSUARIO
FROM INTTEGRIOBDV.TUSUARIOSESIONES
WHERE FHASTA = TIMESTAMP '2999-12-31 00:00:00.0'
GROUP BY CUSUARIO, CTERMINAL 
HAVING COUNT(1)>1
ORDER BY CTERMINAL;


--- Conteo por taquillas 
SELECT COUNT(1),  SUBSTR(CTERMINAL,9,3) CTERMINAL
FROM INTTEGRIOBDV.TUSUARIOSESIONES 
WHERE FHASTA = TIMESTAMP '2999-12-31 00:00:00.0' 
GROUP BY SUBSTR(CTERMINAL ,9,3)
ORDER BY 2 ;



--- No me acuerdo para que era 
set pagesize 600
set linesize 500
col FACTOR format 9999999999999999999
col SESION format a30
col FHASTA format a30
col FDESDE format a30
SELECT *
FROM INTTEGRIOBDV.TUSUARIOSESIONES 
WHERE FHASTA = TIMESTAMP '2999-12-31 00:00:00.0' 
AND CTERMINAL = 'NM12618_383_PE03T'
ORDER BY CTERMINAL;





