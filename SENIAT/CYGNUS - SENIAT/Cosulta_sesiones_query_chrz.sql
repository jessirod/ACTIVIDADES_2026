set lin 4000
set timi on 
set time on 
col machine format a30
col object format a32
col x format a80 
col owner format a8
col WAIT_CLASS format a15
col USERNAME format a10
col MODULE format a90
col CLIENT_INFO format a30
col action  format a70
col type format a10
col OSUSER format a10
select distinct  
--b.SECONDS_IN_WAIT,b.LOGON_TIME,WAIT_CLASS,
--'alter system kill session '''||b.sid||','||b.serial#||''' immediate;' x
-- p.spid psid_local, b.process  psid_remote
-- ,
-- b.serial#
--,a.*
b.machine, b.osuser, b.username
-- , b.program, status
--, b.process, b.module
--, b.CLIENT_INFO
--, b.action
-- ,b.sid
,b.sql_id
--, s.server
from gv$access a,gv$session b , gv$process p
where a.sid=b.sid and p.addr=b.paddr
and a.inst_id=b.inst_id and b.inst_id=p.inst_id and a.inst_id=p.inst_id
--and b.sid in (4088)
--and b.sql_id = '2vn8v3xw4drpm'
--and b.status = 'INACTIVE'
and (
       a.object =upper('ITEM_DECLARACION')
        --a.object =upper('X001T_SERVICE_LOG')
       --or a.object =upper('pkg_comp_metadato_compl')
)
--AND b.machine NOT LIKE ('bdvx-%')
/