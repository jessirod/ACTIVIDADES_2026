Consultas POSTGRES
**************************************************************************************************
Revisar versión

 psql --version

 --Dentro de la BD

SELECT version();

**************************************************************************************************
Conectarse a BD
psql


**************************************************************************************************
Revisar las BDs disponibles
\l+

--postgres=# \l+
-- zabbix    | zabbix   | UTF8     | en_US.UTF-8 | en_US.UTF-8 |            | libc            | =Tc/zabbix           +| 17 GB   | pg_default |
--           |          |          |             |             |            |                 | zabbix=CTc/zabbix     |         |            |

**************************************************************************************************
Conectarse a la BD

\c zabbix

**************************************************************************************************

Tamaño BD

-- Tamaño total de la BD zabbix
SELECT pg_size_pretty(pg_database_size('zabbix')) AS Tamaño_BD;

-- Tamaño de todas las tablas de la BD, ordenadas de mayor a menor
SELECT
    schemaname,
    relname AS table_name,
    pg_size_pretty(pg_total_relation_size(schemaname || '.' || relname)) AS total_size,
    pg_size_pretty(pg_relation_size(schemaname || '.' || relname))       AS table_size,
    pg_size_pretty(pg_indexes_size(schemaname || '.' || relname))        AS index_size
FROM pg_stat_user_tables
ORDER BY pg_total_relation_size(schemaname || '.' || relname) DESC;

**************************************************************************************************

Bloqueos y conexiones activas en zabbix

--Conexiones activas a la BD zabbix

SELECT
    pid,
    usename,
    datname,
    client_addr,
    application_name,
    state,
    backend_start,
    query_start,
    wait_event_type,
    wait_event
 --   query
FROM pg_stat_activity
WHERE datname = 'zabbix'
ORDER BY query_start DESC;

--Bloqueos actuales


SELECT
    pg_locks.pid,
    pg_locks.locktype,
    pg_locks.mode,
    pg_locks.granted,
    pg_stat_activity.usename,
    pg_stat_activity.datname,
    pg_stat_activity.client_addr,
    pg_stat_activity.query
FROM pg_locks
LEFT JOIN pg_stat_activity
    ON pg_locks.pid = pg_stat_activity.pid
WHERE pg_stat_activity.datname = 'zabbix'
ORDER BY pg_locks.granted DESC, pg_locks.pid;

**************************************************************************************************
Espacio total en disco usado por la BD


SELECT pg_size_pretty(pg_database_size('zabbix')) AS db_size;


**************************************************************************************************
Puerto en que opera PostgreSQL

psql
show port;
**************************************************************************************************

SHOW data_directory;
du -sh /postgres/data/zabbix

**************************************************************************************************



