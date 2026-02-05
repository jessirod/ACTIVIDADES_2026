**********************************************************************************
Servidor ORIGEN
Name:   clbdmdbpp01.banvenqa.com
Address: 180.183.170.108
**********************************************************************************

--Consultar el filesystem mariadb/backup

df -h

-- Entrar en la ruta donde se guardan los .sql.gz (backup)
cd /mariadb/backup/dump

-- Revisar el crontab y ejecutar:
crontab -l

sh /home/mariadb/utils/scripts/dump_database.sh paginapublica wordpress_qa
-- Listar los archivos y descargar el ultimo archivo.

**********************************************************************************
Servidor DESTINO
Name:   plbdmdbpp01.banvenez.corp
Address: 172.27.67.103
**********************************************************************************
--Realizar un backup previamente

sh /home/mariadb/utils/scripts/dump_database.sh paginapublica wordpress

-- Subir el backup de qa al servidor de PRODUCCIÓN a la ruta  /mariadb/backup/restore
--Conectarse a la BD
paginapublica_connect

--Listar las Base de Datos --mariadb@(none)>
show databases;

--Borrar BD
drop database wordpress;

--Recrear la Base de Datos

create database wordpress;
show databases;
exit;

**********************************************************************************

--Descomprimir el backup.
cd /mariadb/backup/restore

--gzip -d archivo_descargado.sql.gz
--paginapublica_connect wordpress < archivo_descargado.sql


gzip -d dump_paginapublica_20260203-1121.sql.gz
paginapublica_connect wordpress < dump_paginapublica_20260203-1121.sql


--Conectarse a la BD --mariadb@(none)>
paginapublica_connect

show databases;
use wordpress;
show tables;
**********************************************************************************

---Consultas verificación:

SELECT id, referer, referer_title from wp_e_submissions;

SELECT * FROM wp_e_submissions_values WHERE submission_id IN (82910);
