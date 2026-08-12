***********************************************************************
EXPORT
***********************************************************************

vi exp_seniat_full.par

DIRECTORY=EXPORT_BDTEMP
LOGFILE=EXP_DBO_202605.log
DUMPFILE=EXP_DBO_ITM_202605_%U.dmp
METRICS=Y
EXCLUDE=INDEX,CONSTRAINT,PROCACT_SYSTEM,STATISTICS
CONTENT=DATA_ONLY
CLUSTER=N
PARALLEL=5
TABLES=DBO.ITEM_DECLARACION:P202605



nohup expdp \' / as sysdba \' parfile=exp_seniat_full.par &
expdp \' / as sysdba \' ATTACH=SYS_EXPORT_TABLE_01