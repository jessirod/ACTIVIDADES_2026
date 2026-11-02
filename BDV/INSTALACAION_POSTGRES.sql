INSTALACION POSTGRES PRD

************************************************************************************************************************************************************************

SERVER plgranbd01 IP 172.27.88.120

Subir al servidor los binarios a instalar. --FS BINARIOS 

--cp -p /home/administrator/postgresql-17.7.tar.gz /postgres/binarios/

************************************************************************************************************************************************************************
CREAR_GRUPO_Y_USUARIO_SO  --ROOT
************************************************************************************************************************************************************************
groupadd postgres

--useradd --help
useradd -m -g postgres -c "User Database Administrator" -s /bin/bash postgres
passwd postgres

--verificar creación
su - postgres

************************************************************************************************************************************************************************
DESCOMPRIMIR_BINARIOS --ROOT
************************************************************************************************************************************************************************
cd /postgres/binarios/

tar -xvf postgresql-17.7.tar.gz

************************************************************************************************************************************************************************
EJECUTAR_CONFIGURE --ROOT
************************************************************************************************************************************************************************
cd postgresql-17.7

ls -ltr
--./configure --help
--By default, `make install' will install all the files in
--`/usr/local/pgsql/bin', `/usr/local/pgsql/lib' etc.  You can specify
--an installation prefix other than `/usr/local/pgsql' using `--prefix',
--for instance `--prefix=$HOME'.

--cat /etc/*-release  VER SO

yum install -y gcc
yum install -y make
yum install -y readline-devel.x86_64
yum install -y bison
yum install -y flex
yum install -y perl
yum install -y nmon

--pwd
./configure -prefix=/postgres/binarios/postgresql-17.7  --without-icu

--EJECUTAR MAKE -compilar e instalar

make
make install

************************************************************************************************************************************************************************
INICAR_BD --POSTGRES
************************************************************************************************************************************************************************
-- /postgres/binarios/postgresql-17.7/bin

--CAMBIAR DUEÑOS (PERMISOLOGIA) ROOT
chown -R postgres:postgres /postgresql-17.7

cd bin/

df -h | grep -i postgres
-- sirve para inicializar una nueva “instancia” o cluster de base de datos, indicando dónde se guardan los datos y dónde se guardan los WAL 
--	-D, --pgdata=]DATADIR     location for this database cluster
--  -X, --waldir=WALDIR       location for the write-ahead log directory

./initdb -D /postgres/data/SGDC -X /postgres/wall/SGDC

-- The files belonging to this database system will be owned by user "postgres".
-- This user must also own the server process.
-- 
-- The database cluster will be initialized with locale "en_US.UTF-8".
-- The default database encoding has accordingly been set to "UTF8".
-- The default text search configuration will be set to "english".
-- 
-- Data page checksums are disabled.
-- 
-- fixing permissions on existing directory /postgres/data/SGDC ... ok
-- fixing permissions on existing directory /postgres/wall/SGDC ... ok
-- creating subdirectories ... ok
-- selecting dynamic shared memory implementation ... posix
-- selecting default "max_connections" ... 100
-- selecting default "shared_buffers" ... 128MB
-- selecting default time zone ... America/Caracas
-- creating configuration files ... ok
-- running bootstrap script ... ok
-- performing post-bootstrap initialization ... ok
-- syncing data to disk ... ok
-- 
-- initdb: warning: enabling "trust" authentication for local connections
-- initdb: hint: You can change this by editing pg_hba.conf or using the option -A, or --auth-local and --auth-host, the next time you run initdb.
-- 
-- Success. You can now start the database server using:
-- 
--     pg_ctl -D /postgres/data/SGDC -l logfile start

ls -ltra

cd /postgres/binarios/postgresql-17.7/bin/

ls -ltr /postgres/data/SGDC/

./initdb -D /postgres/data/SGDC -X /postgres/wall/SGDC

./pg_ctl -D /postgres/data/SGDC -l /postgres/log/SGDC/postgres.log start
./psql
./pg_ctl -D /postgres/data/SGDC -l postgres/log/SGDC/postgres.log stop
./psql
./pg_ctl -D /postgres/data/SGDC -l postgres/log/SGDC/postgres.log status
./pg_ctl -D /postgres/data/SGDC -l /postgres/log/SGDC/postgres.log start

************************************************************************************************************************************************************************
MENU_BD --POSTGRES
************************************************************************************************************************************************************************
cd
ls -ltra
--MODIFICAR BASH_PROFILE
cp -p .bash_profile .bash_profile.jr.20260121
vi .bash_profile
/*+
export PATH=$PATH:/postgres/binarios/postgresql-17.7/bin

echo -e "\n\e[1;33m- ACCESOS A BASES DE DATOS -\n"
echo -e "* menubd\n\e[0m"
*/

psql
************************************************************************************************************************************************************************

--ARCHIVO PARA SETEAR PROMPT COMO EL DE ORACLE

vi /home/postgres/.psqlrc
/*+
\set PROMPT1 '%`date +%H:%M:%S` %n@%/# '
*/

psql
cd /postgres/data/SGDC/

************************************************************************************************************************************************************************

--CREAR ARCHIVO .MENU

vi .menu

/*+

configsgdc() {
export PGDATA=/postgres/data/SGDC
export PGLOG=/postgres/log/SGDC
export PGHOME=/postgres/binarios/postgresql-17.7
export PGBIN=$PGHOME/bin
export PATH=$PGBIN:$PATH
export MANPATH=$PGHOME/share/man
export LD_LIBRARY_PATH=$PGHOME/lib:$LD_LIBRARY_PATH
export PGVERSION=17.7
export PGPORT=5432
export DATE=`date "+%Y-%m-%d"`;
export LOG=/postgres/log/postgres.log
echo -e "\n### COMANDOS PARA ADMINISTRAR BD SGDC ###"
echo -e "* sgdc_start\n* sgdc_stop\n* sgdc_restart\n* sgdc_status\n"
echo -e "+ SINGLE"
echo -e "+ PUERTO: $PGPORT "
echo -e "+ DATA: $PGDATA \n"
echo -e "+ VERSION POSTGRESQL: $PGVERSION \n"
echo -e "+ INGRESAR A POSTGRESQL: psql \n"
}

clear
echo -e "\e[1;33m---------------------"
echo -e "    MENU DE ACCESO   "
echo -e "---------------------\e[0m"
echo -e "\e[1;33m1. SGDC \e[0m"
echo -e "\e[1;33m2. EXIT     \e[0m"
echo -e "Ingrese su opcion:"
read -t 2 OPCION

case $OPCION in
1) configsgdc ;;
esac

*/
************************************************************************************************************************************************************************

--MODIFICAR BASHRC

cp -p .bashrc .bashrc.jr.20260121
vi .bashrc

/*+
alias menubd='. /home/postgres/./.menu'

alias sgdc_status='/postgres/binarios/postgresql-17.7/bin/./pg_ctl -D /postgres/data/SGDC/ status'
alias sgdc_start='/postgres/binarios/postgresql-17.7/bin/./pg_ctl -D /postgres/data/SGDC/ -l /postgres/log/SGDC/postgres.log start'
alias sgdc_stop='/postgres/binarios/postgresql-17.7/bin/./pg_ctl -D /postgres/data/SGDC/ -l /postgres/log/SGDC/postgres.log -m fast stop'
alias sgdc_restart='/postgres/binarios/postgresql-17.7/bin/./pg_ctl -D /postgres/data/SGDC/ -l /postgres/log/SGDC/postgres.log -m fast restart'
*/

--VARIABLES SETEADAS

menubd
psql
sgdc_stop
sgdc_start
sgdc_restart
sgdc_status
************************************************************************************************************************************************************************
MODIFICAR PARAMETROS DE CONFIGURACIÓN --POSTGRES
************************************************************************************************************************************************************************

--MODIFICAR PARAMETROS DE CONFIGURACIÓN
--GUIARSE POR LA PAGINA PGTUNE

cd /postgres/data/SGDC/

ls -ltr

cp -p postgresql.conf postgresql.conf.jr.20260121

vi postgresql.conf

-- # DB Version: 17
-- # OS Type: linux
-- # DB Type: web
-- # Total Memory (RAM): 16 GB
-- # CPUs num: 8
-- # Connections num: 100
-- # Data Storage: ssd
-- 
-- max_connections = 100
-- shared_buffers = 4GB
-- effective_cache_size = 12GB
-- maintenance_work_mem = 1GB
-- checkpoint_completion_target = 0.9
-- wal_buffers = 16MB
-- default_statistics_target = 100
-- random_page_cost = 1.1
-- effective_io_concurrency = 200
-- work_mem = 38836kB
-- huge_pages = off
-- min_wal_size = 1GB
-- max_wal_size = 4GB
-- max_worker_processes = 8
-- max_parallel_workers_per_gather = 4
-- max_parallel_workers = 8
-- max_parallel_maintenance_workers = 4

************************************************************************************************************************************************************************

--MODIFICAR PARAMETROS DE CONFIGURACIÓN
--PostgreSQL Client Authentication Configuration File

cp -p pg_hba.conf pg_hba.conf.jr.20260121

vi pg_hba.conf
-- host    all             all             172.27.88.120/32        trust

--sgdc_restart
--menubd
--\ alt 92

************************************************************************************************************************************************************************

--Verificar conexión especificando el puerto
psql
psql --port=5432
--Conectarse usando IP PUERTO BD
psql -h 180.183.171.1 -p 5432 postgres

************************************************************************************************************************************************************************
CREAR_USUARIO_BD
************************************************************************************************************************************************************************
--CREAR_USUARIO_BD
createuser --no-createdb --no-createrole --no-superuser --login --pwprompt SISGDCQA
createuser --no-createdb --no-createrole --no-superuser --login --pwprompt CT24795

--CREAR_BD
createdb sgdcqa --owner=SISGDCQA

--DROPEAR_BD
dropdb sgdcqa

--DROPEAR_USUARIO
dropuser SISGDCQA

--VERIFICAR CONEXIÓN
psql --user=SISGDCQA -W
psql --user=SISGDCQA -W SISGDCQA
--
psql -h 180.183.171.1 -p 5432 sgdcqa -U SISGDCQA -W
psql -h 180.183.171.1 -p 5432 sgdcqa -U CT24795 -W
