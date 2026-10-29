Crecimiento de los .aud en tranzaxis. 

tail -f TRZSP1_ora_1254203_20260905220819986997230598.aud
Sat Sep  5 22:46:44 2026 -04:00
LENGTH : '1216'
ACTION :[946] '/* oratop s3a */  SELECT * FROM (  SELECT event, totwa, ttimo, twsec, avgms,  RATIO_TO_REPORT(twsec) OVER () * 100 pctwa, wclas, evtid  FROM (SELECT EVENT,  _TIMEOUTS)      ttimo,           SUM(TIME_WAITED)         twsec,           AVG(AVERAGE_WAIT)        avgms,           WAIT_CLASS               wclas,           EVENT_ID     _CLASS <> 'Idle'      AND  TIME_WAITED > 0    GROUP  BY EVENT, WAIT_CLASS, EVENT_ID    UNION   SELECT  'DB CPU'                 event,           0                        to(VALUE)               twsec,           0                        avgms,           NULL                     wclas,           2075                     evtid      FROM  GV$SYSStwsec desc   )) WHERE rownum < 6 '
DATABASE USER:[1] '/'
PRIVILEGE :[6] 'SYSDBA'
CLIENT USER:[8] 'oracle19'
CLIENT TERMINAL:[6] 'pts/10'
STATUS:[1] '0'
DBID:[10] '1695446553'
SESSIONID:[10] '4294967295'
USERHOST:[23] 'plbdtrz01.banvenez.corp'
CLIENT ADDRESS:[0] ''
ACTION NUMBER:[1] '3'


-- Encontrar la máquina (cliente terminal)
 who | grep "pts/10"
oracle19 pts/10       2026-08-17 10:18 (172.18.68.158)
[oracle19@plbdtrz01 adump]$

-- Encontrar de quien es la ip
nslookup 172.18.68.158
Name:      172.18.68.158
Address 1: 172.18.68.158 SC1_MZ2_JBS2R_

-- Buscar el proceso que esta corriendo desde la maquina
 ps -ef | grep "pts/10" | grep -v grep
oracle19 1251883 1251742  0 Aug17 ?        00:03:41 sshd: oracle19@pts/10
oracle19 1251891 1251883  0 Aug17 pts/10   00:00:00 -bash
oracle19 1254202 1251891  0 Aug17 pts/10   01:23:10 oratop / as sysdba

-- Matar el proceso que esta corriendo desde la maquina
 kill -9 1254202

--Verificar
[oracle19@plbdtrz01 adump]$ ps -ef | grep "pts/10" | grep -v grep
oracle19 1251883 1251742  0 Aug17 ?        00:03:41 sshd: oracle19@pts/10
oracle19 1251891 1251883  0 Aug17 pts/10   00:00:00 -bash



