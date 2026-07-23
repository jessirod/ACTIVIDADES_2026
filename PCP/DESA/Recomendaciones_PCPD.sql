Recomendaciones_PCPD

5u25ykj7nt02t
aku8hwwr8nxya
36wyu7vtfb8td


Cambiar SELECT COUNT(*) por SELECT COUNT(1)


7wjn43tw72tdm		SELECT COUNT(*) FROM PCP.CREDITS PARTITION (CREDITS_NEW_600000001)

dw9aggukg8z9s		SELECT COUNT(*) FROM PCP.CREDITS PARTITION (CREDITS_NEW_580000001)


36wyu7vtfb8td		delete from "PCP"."CREDITS_CREDITO_INMEDIATO" where "ID_ORDEN"
create index PCP.CREDITS_CREDITO_INMEDIATO_N1  on PCP.CREDITS_CREDITO_INMEDIATO("ID_ORDEN") TABLESPACE INDX;



Finding 3: Commits and Rollbacks
Impact is .22 active sessions, 20.45% of total activity.
--------------------------------------------------------
Wait class "Commit" was consuming significant database time.
Waits on event "log file sync" while performing COMMIT and ROLLBACK operations
were not consuming significant database time.



********************
Subir la SGA 22GB

**************************
session_cached_cursors               integer     100
alter system set session_cached_cursors=1200 scope=spfile;

************************
undo segment extension	71	6.6	93.21ms	.2	Configuration

ACTUAL UNDO SIZE [MByte] UNDO RETENTION [Sec] OPTIMAL UNDO RETENTION [Sec]
------------------------ -------------------- ----------------------------
                  131069 900                                       1226675
.
undo_retention                       integer     900

ALTER SYSTEM SET UNDO_RETENTION = 7200 SCOPE=BOTH;
*****************************

1mn41t2b1kn3m	DELETE FROM DEBITS WHERE ID_ORDEN = :B1 
1kmrd5cf2rd90	 delete from "PCP"."CREDITS" where "ID_DEBITS" = :1
36wyu7vtfb8td	 delete from "PCP"."CREDITS_CREDITO_INMEDIATO" where "ID_ORDEN" = :1

*****************************
create index PCP.CREDITS_CREDITO_INMEDIATO_N1  on PCP.CREDITS_CREDITO_INMEDIATO("ID_ORDEN") TABLESPACE INDX;



