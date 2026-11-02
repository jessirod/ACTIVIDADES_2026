SELECT tablespace_name, file_id, file_name, status, online_status 
FROM dba_data_files 
WHERE file_id = 48;




file 50: /cyberdata4/rcvry01q_CYBER.dbf
Tue May 26 10:22:03 2026
KCF: write/open error block=0x2c509 online=1
     file=48 /cyberdata4/rcvry01o_CYBER.dbf
     error=27063 txt: 'IBM AIX RISC System/6000 Error: 5: I/O error
Additional information: -1
Additional information: 65536'
Automatic datafile offline due to write error on
file 48: /cyberdata4/rcvry01o_CYBER.dbf



select * from v$recover_file;

RECOVER DATAFILE 48;
RECOVER DATAFILE 50;


ALTER DATABASE DATAFILE 48 ONLINE;
ALTER DATABASE DATAFILE 50 ONLINE;


