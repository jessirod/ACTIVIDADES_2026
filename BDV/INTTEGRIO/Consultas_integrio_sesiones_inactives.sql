Consultas INTT 

********************************************************************************************************************************************************
********************************************************************************************************************************************************

set pages 100
col USERNAME format a20
col OSUSER format a15
col MACHINE format a30
col PROGRAM format a20
col MODULE format a20
col SQL_ID format a20
col ACTION format a20
col CLIENT_IDENTIFIER format a20
SELECT
count(1), 
--inst_id,
--       sid,
--       serial#,
--       username,
--       status,
--       osuser,
       machine,
--       program,
--       module,
       min(logon_time) min_logon,
--       max(logon_time) max_logon,
--       last_call_et / 3600,
--       min(last_call_et / 3600) min_hora,
       max(last_call_et / 3600) max_hora,
--       sql_id,
       prev_sql_id
--       action, 
--       client_identifier
FROM gv$session
WHERE username IS NOT NULL
--and machine like '%8jlk4%'
and machine like '%uci%'
and username = 'INTTEGRIOBDV'
AND status = 'INACTIVE'
--and prev_sql_id not in ('f3z79201kugpc', 'a6vvt01r5w66v')
--and prev_sql_id = '39btr1q6t342v'
AND last_call_et > 60 
group by machine, program, module, prev_sql_id
ORDER BY 4;




set pages 100
col USERNAME format a20
col OSUSER format a15
col MACHINE format a30
col PROGRAM format a20
col MODULE format a20
col SQL_ID format a20
col ACTION format a20
col CLIENT_IDENTIFIER format a20
SELECT
count(1), 
--inst_id,
--       sid,
--       serial#,
--       username,
--       status,
--       osuser,
       machine,
--       program,
--       module,
       min(logon_time) min_logon,
--       max(logon_time) max_logon,
--       last_call_et / 3600,
--       min(last_call_et / 3600) min_hora,
       max(last_call_et / 3600) max_hora,
--       sql_id,
       prev_sql_id
--       action, 
--       client_identifier
FROM gv$session
WHERE username IS NOT NULL
--and machine like '%8jlk4%'
and machine like '%uci%'
and username = 'INTTEGRIOBDV'
AND status = 'INACTIVE'
--and prev_sql_id not in ('f3z79201kugpc', 'a6vvt01r5w66v')
--and prev_sql_id = '39btr1q6t342v'
AND last_call_et > 60  
group by machine, program, module, prev_sql_id
ORDER BY 4;




--------------------------------------------------------------------------
Horas y minutos



set pages 100
col USERNAME format a20
col OSUSER format a15
col MACHINE format a30
col PROGRAM format a20
col MODULE format a20
col SQL_ID format a20
col ACTION format a20
col CLIENT_IDENTIFIER format a20
SELECT
count(1), 
--inst_id,
--       sid,
--       serial#,
--       username,
--       status,
--       osuser,
       machine,
--       program,
--       module,
       min(logon_time) min_logon,
--       max(logon_time) max_logon,
--       last_call_et / 3600,
--       min(last_call_et / 3600) min_hora,
       max(last_call_et / 3600) max_hora,
       max(last_call_et / 60) max_min,
--       sql_id,
       prev_sql_id
--       action, 
--       client_identifier
FROM gv$session
WHERE username IS NOT NULL
--and machine like '%8jlk4%'
and machine like '%uci%'
and username = 'INTTEGRIOBDV'
AND status = 'INACTIVE'
--and prev_sql_id not in ('f3z79201kugpc', 'a6vvt01r5w66v')
--and prev_sql_id = '39btr1q6t342v'
AND last_call_et > 60  
group by machine, program, module, prev_sql_id
ORDER BY 4;

--  COUNT(1) MACHINE                        MIN_LOGON              MAX_HORA PREV_SQL_ID
------------ ------------------------------ -------------------- ---------- -------------
--         1 deployuci-7cd9cff5c9-h66m5     25-FEB-2026 08:54:41 7.82861111 841cyzd1fkbcz
--         1 deployuci-7cd9cff5c9-5fv85     25-FEB-2026 08:44:50 7.83944444 841cyzd1fkbcz
--       384 deployuci-7cd9cff5c9-4h22n     25-FEB-2026 06:14:43 8.35944444 f3z79201kugpc
--       493 deployuci-7cd9cff5c9-t987x     25-FEB-2026 07:04:47      8.375 f3z79201kugpc
--
---------------------------------------------------------------------------------




********************************************************************************************************************************************************
********************************************************************************************************************************************************

set pages 100
col USERNAME format a20
col OSUSER format a15
col MACHINE format a30
col PROGRAM format a20
col MODULE format a20
col SQL_ID format a20
col ACTION format a20
col CLIENT_IDENTIFIER format a20
SELECT
count(1), 
--inst_id,
--       sid,
--       serial#,
--       username,
--       status,
--       osuser,
--       machine,
--       program,
--       module,
----       min(logon_time) min_logon,
--       max(logon_time) max_logon,
--       last_call_et / 3600,
--       min(last_call_et / 3600) min_hora,
----       max(last_call_et / 3600) max_hora,
--       sql_id,
       prev_sql_id
--       action, 
--       client_identifier
FROM gv$session
WHERE username IS NOT NULL
--and machine like '%8jlk4%'
and machine like '%uci%'
and username = 'INTTEGRIOBDV'
AND status = 'INACTIVE'
--and prev_sql_id not in ('f3z79201kugpc', 'a6vvt01r5w66v')
--and prev_sql_id = '39btr1q6t342v'
AND last_call_et > 60   -- más de 1 hora inactiva
group by prev_sql_id
ORDER BY 1;

--  COUNT(1) PREV_SQL_ID
-- --------- -------------
--         1 29xjfpvcmka7x
--         2 841cyzd1fkbcz
--         8 6ujzq3w5476qp
--        11 39btr1q6t342v
--      3187 f3z79201kugpc




********************************************************************************************************************************************************
********************************************************************************************************************************************************

--------------------------------------

set pages 100
col parsing_schema_name format a20
col SQL_TEXT format a250
SELECT sql_id,
       parsing_schema_name,
       sum(executions),
--       last_active_time,
       sql_text
FROM gv$sql
--WHERE sql_id = '39btr1q6t342v'
WHERE sql_id in (
'29xjfpvcmka7x'
,'9vuzj1auvwcgw'
,'26fpw3q58cdxb'
,'6ujzq3w5476qp'
,'59saap68wwy29'
,'39btr1q6t342v'
,'gykh5tn2n1jhp'
,'a4b0t4gw4sr6n'
 )
group by sql_id, parsing_schema_name, sql_text
order by 3;





29xjfpvcmka7x
9vuzj1auvwcgw
a4b0t4gw4sr6n
6ujzq3w5476qp
39btr1q6t342v
59saap68wwy29
gykh5tn2n1jhp
26fpw3q58cdxb





7fqy7jgc0vms5
5d5ckt7wh9m82
a4b0t4gw4sr6n
59saap68wwy29
gykh5tn2n1jhp
841cyzd1fkbcz
26fpw3q58cdxb
f3z79201kugpc


5d5ckt7wh9m82
gykh5tn2n1jhp
841cyzd1fkbcz
a4b0t4gw4sr6n
59saap68wwy29
f3z79201kugpc
26fpw3q58cdxb
479b3w2aka4td
         1 deployuci-868467d487-8jlk4     25-FEB-2026 20:54:50 .006388889 '841cyzd1fkbcz'
         1 deployuci-868467d487-8jlk4     25-FEB-2026 20:54:50 .006388889 'gykh5tn2n1jhp'
         8 deployuci-868467d487-8jlk4     25-FEB-2026 21:52:11 .008611111 '26fpw3q58cdxb'
         2 deployuci-868467d487-8jlk4     25-FEB-2026 20:54:50 .011944444 'a4b0t4gw4sr6n'
         3 deployuci-868467d487-8jlk4     25-FEB-2026 20:54:50 .024166667 '59saap68wwy29'

--21:07:51  29  21:07:51  30
--
--  COUNT(1) PREV_SQL_ID
------------ -------------
--         1 'fxz6np166ah3z'
--         1 ,'gkqj2g0sfdcs0'
--         1 ,'bunvx480ynf57'
--         1 ,'841cyzd1fkbcz'
--         2 ,'96q0pp1sajdfy'
--         5 ,'a4b0t4gw4sr6n'
--         7 ,'59saap68wwy29'
--         8 ,'gykh5tn2n1jhp'
--         9 ,'589duq5z381t0'
--         9 ,'5kg6g1sasfd3z'
--        11 ,'18z4hmmktkd2t'
--        12 ,'4cy3qx4z6mm1y'
--        20 ,'cfq7zjyz69rct'
--      1266 ,'26fpw3q58cdxb'

 21:13:48  30

  COUNT(1) PREV_SQL_ID
---------- -------------
         1 'bunvx480ynf57'
         4 ,'96q0pp1sajdfy'
         5 ,'a4b0t4gw4sr6n'
         9 ,'5kg6g1sasfd3z'
         9 ,'589duq5z381t0'
         9 ,'gykh5tn2n1jhp'
        12 ,'59saap68wwy29'
        12 ,'4cy3qx4z6mm1y'
        17 ,'18z4hmmktkd2t'
        20 ,'cfq7zjyz69rct'
      2932 ,'26fpw3q58cdxb'

21:48:34  30

  COUNT(1) PREV_SQL_ID
---------- -------------
         1 gykh5tn2n1jhp
         8 26fpw3q58cdxb



260226 2128

5d5ckt7wh9m82
29xjfpvcmka7x
a4b0t4gw4sr6n
gykh5tn2n1jhp
6ujzq3w5476qp
59saap68wwy29
39btr1q6t342v
26fpw3q58cdxb



 


6ujzq3w5476qp

-- SQL_ID               PARSING_SCHEMA_NAME                                                                                                              SUM(EXECUTIONS)
-- -------------------- -------------------------------------------------------------------------------------------------------------------------------- ---------------
-- SQL_TEXT
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 29xjfpvcmka7x        INTTEGRIOBDV                                                                                                                                  99
-- select tfitdevice0_.CCANAL as CCANAL1_118_0_, tfitdevice0_.CDISPOSITIVO as CDISPOSITIVO2_118_0_, tfitdevice0_.CSERVIDORAPLICACION as CSERVIDORAPLICACIO3_118_0_, tfitdevice0_.DISPONIBLE as DISPONIBLE4_118_0_, tfitdevice0_.PESO as PESO5_118_0
-- _ from TDISPOSITIVOFIT tfitdevice0_ where tfitdevice0_.CCANAL=:1  and tfitdevice0_.CDISPOSITIVO=:2  and tfitdevice0_.CSERVIDORAPLICACION=:3
-- 
-- f3z79201kugpc        INTTEGRIOBDV                                                                                                                               18142
-- select this_.CSERVIDORAPLICACION as CSERVIDORAPLICACIO1_326_0_, this_.VERSIONCONTROL as VERSIONCONTROL2_326_0_, this_.NOMBRE as NOMBRE3_326_0_, this_.ENLINEA as ENLINEA4_326_0_, this_.URL as URL5_326_0_ from TSERVIDORAPLICACION this_ where
-- this_.ENLINEA=:1
-- 
------------250226

6ujzq3w5476qp
841cyzd1fkbcz
f3z79201kugpc
29xjfpvcmka7x
39btr1q6t342v

********************************************************************************************************************************************************


set pages 100
col parsing_schema_name format a20
col SQL_TEXT format a250
SELECT sql_id,
       parsing_schema_name,
       sum(executions),
--       last_active_time,
       sql_text
FROM gv$sql
WHERE sql_id = '7fqy7jgc0vms5'
group by sql_id, parsing_schema_name, sql_text
order by 3;


********************************************************************************************************************************************************
********************************************************************************************************************************************************


---consultas solo UCI
set line 240
set time on
set timi on
col username format a35
col service_name format a20
col MACHINE format a50
col SQL_ID format a50
select count(1),
--SID, 
MACHINE, 
username,
service_name,
--inst_id, 
 status from gv$session
 where username='INTTEGRIOBDV'
-- and inst_id=1
 and MACHINE like '%uci%'
 group by username, service_name, machine, status --, inst_id
 order by 5
/

--   COUNT(1) MACHINE                                            USERNAME                            SERVICE_NAME         STATUS
-- ---------- -------------------------------------------------- ----------------------------------- -------------------- --------
--         50 deployuci-868467d487-8jlk4                         INTTEGRIOBDV                        INTTEGP_APP          INACTIVE
--        451 deployuci-7cd9cff5c9-c9hc4                         INTTEGRIOBDV                        INTTEGP_APP          INACTIVE
--        490 deployuci-7cd9cff5c9-h66m5                         INTTEGRIOBDV                        INTTEGP_APP          INACTIVE
--        501 deployuci-7cd9cff5c9-4h22n                         INTTEGRIOBDV                        INTTEGP_APP          INACTIVE
-- 



----------------------------------------------------------------------------------------

------PL PARA MATAR SESIONES MASIVO

set serveroutput on
declare
cursor sessions_for_kill is
SELECT s.sid
, s.serial# serial
, s.inst_id
from gv$session s
JOIN gv$process p ON p.addr = s.paddr 
AND p.inst_id = s.inst_id
WHERE s.username='INTTEGRIOBDV'
AND s.OSUSER !='SYSDBA'
--and s.MODULE like '%backup%'
and s.MACHINE like '%uci%'
and s.status = 'INACTIVE'
--and s.sid IN (39775,51983,9255)
--AND p.inst_id = 3
order by s.username, s.LOGON_TIME;

BEGIN
    FOR cur in sessions_for_kill
    LOOP
      BEGIN
         EXECUTE IMMEDIATE 'alter system kill session '''||cur.sid||','||cur.serial||',@'||cur.inst_id||''' immediate'; 
      END;
    END LOOP;
END;
/





--- VER EL SID Y SERIAL# DE LA SESSION ACTUAL

SELECT INST_ID
      ,SID,SERIAL#
  FROM GV$SESSION
WHERE SID=(SELECT SID FROM V$MYSTAT WHERE ROWNUM=1);
   INST_ID        SID    SERIAL#
---------- ---------- ----------
         1       8531      57135
         2       8531      25826


alter system kill session 8531, 57135 immediate;



---------------------------------------------------------------------------------------------------------
SET SERVEROUTPUT ON;

DECLARE

CURSOR sessions_for_kill IS
SELECT  s.sid,
        s.serial# serial,
        s.inst_id
FROM gv$session s
JOIN gv$process p 
     ON p.addr = s.paddr 
    AND p.inst_id = s.inst_id
WHERE s.username = 'INTTEGRIOBDV'
  AND s.OSUSER  != 'SYSDBA'
  AND s.MACHINE LIKE '%uci%'
  AND s.status = 'INACTIVE'
ORDER BY s.username, s.LOGON_TIME;

sqlCreate VARCHAR2(500);

BEGIN
    FOR cur IN sessions_for_kill LOOP
        BEGIN        
            sqlCreate := 'alter system kill session ''' || cur.sid || ',' || cur.serial || ',@' || cur.inst_id || ''' immediate';           
            DBMS_OUTPUT.PUT_LINE('Ejecutando: ' || sqlCreate);            
            EXECUTE IMMEDIATE sqlCreate;           
            DBMS_OUTPUT.PUT_LINE('OK');
        END;
    END LOOP;
END;
/


---------------------------------------------------------------------------------------------------------


SET SERVEROUTPUT ON;
DECLARE
CURSOR sessions_for_kill IS
SELECT  s.sid,
        s.serial# serial,
        s.inst_id
FROM gv$session s
JOIN gv$process p 
     ON p.addr = s.paddr 
    AND p.inst_id = s.inst_id
WHERE s.username = 'INTTEGRIOBDV'
  AND s.OSUSER  != 'SYSDBA'
  AND s.MACHINE LIKE '%8jlk4'
  AND s.status = 'INACTIVE'
ORDER BY s.username, s.LOGON_TIME;
sqlCreate VARCHAR2(500);
BEGIN
    FOR cur IN sessions_for_kill LOOP
        BEGIN        
            sqlCreate := 'alter system kill session ''' || cur.sid || ',' || cur.serial || ',@' || cur.inst_id || ''' immediate';           
            DBMS_OUTPUT.PUT_LINE('Ejecutando: ' || sqlCreate);            
            EXECUTE IMMEDIATE sqlCreate;           
            DBMS_OUTPUT.PUT_LINE('OK');
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error ejecutando: ' || sqlCreate);
                DBMS_OUTPUT.PUT_LINE('Mensaje: ' || SQLERRM);
        END;
    END LOOP;
END;
/