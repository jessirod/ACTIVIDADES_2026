PCP - Migracion


-- Maquinas Conectadas

set line 240
set time on
set timi on
set pagesize 50
col username format a20
col service_name format a30
col MACHINE format a60
select count(1), username,service_name , MACHINE,failover_type, failover_method from gv$session
where username='PCP'
 group by username, service_name, machine, failover_type, failover_method
 order by 2,3;


set line 240
set time on
set timi on
set pagesize 50
col username format a20
col service_name format a30
col MACHINE format a60
select count(1) from gv$session
where username='PCP'
 group by username;


ps -fea | grep -i local=no | grep PCP | wc -l
ps -fea | grep -i local=no | grep PCP | awk '{print $2}' | xargs -i kill -9 {} /;



-----------ps -fea | grep tns
lsnrctl stop LISTENER122
/
lsnrctl start LISTENER122


---
sqlplus / as sysdba

STARTUP MOUNT;
ALTER DATABASE OPEN READ ONLY;
ALTER SYSTEM ENABLE RESTRICTED SESSION;

ALTER SYSTEM DISABLE RESTRICTED SESSION;



-- Bloquear esquema PCP

ALTER USER PCP ACCOUNT LOCK; 


-- HASH PCP

SPARE4
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
S:FB2F1C4C484991EAB33F1494AB94E4F3A69F55DA9765616500A13763BA55;T:BB6A4D592218A8E02111D687253F5B9C2067CBCF027A0C48D9CE1CCA59CE4BB47DD72A9C4A54C22519885CCA5C49487C6C6D75D0E440AB4C0A2C63B9F99F3FC9FB8391B3A5D51FC91687A02BE17B6D5D

ALTER USER PCP IDENTIFIED BY values 'S:FB2F1C4C484991EAB33F1494AB94E4F3A69F55DA9765616500A13763BA55;T:BB6A4D592218A8E02111D687253F5B9C2067CBCF027A0C48D9CE1CCA59CE4BB47DD72A9C4A54C22519885CCA5C49487C6C6D75D0E440AB4C0A2C63B9F99F3FC9FB8391B3A5D51FC91687A02BE17B6D5D';




Permisos de select y update del esquema
***************
*****************
*******************

falto
dba registry
customizaciones personalizadas en sys y system
verificar los tbs
regresar la contraseña del esquema
estadisticas full
