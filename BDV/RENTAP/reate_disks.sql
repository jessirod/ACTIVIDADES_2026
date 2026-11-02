userdel -r oracle
userdel -r oracle19
userdel -r grid
groupdel asmadmin
groupdel asmdba
groupdel asmoper
--groupdel dba
groupdel oper
groupdel backupdba
groupdel dgdba
groupdel kmdba
groupdel racdba
groupdel oinstall


********
groupadd -g 54321 oinstall
--groupadd -g 54322 dba
groupadd -g 54323 oper
groupadd -g 54324 backupdba
groupadd -g 54325 dgdba
groupadd -g 54326 kmdba
groupadd -g 54327 asmdba
groupadd -g 54328 asmoper
groupadd -g 54329 asmadmin
groupadd -g 54330 racdba

********

useradd -u 54321 -g oinstall -G dba,asmdba,backupdba,dgdba,kmdba,racdba,oper,asmoper,asmadmin oracle19
useradd -u 54322 -g oinstall -G asmadmin,asmdba,asmoper,racdba,dba grid

****************************************************************************************************************

mkdir -p /oracle/app/oraInventory
mkdir -p /oracle/app/grid
mkdir -p /oracle/app/product/19c/grid
mkdir -p /oracle/app/oracle/product/19c/db1

********

chown -R grid:oinstall /oracle/
chown -R oracle19:oinstall /oracle/app/oracle
chmod -R 775 /oracle/

****************************************************************************************************************

Ejemplo del rango sdb al sdg
lsblk -fm `ls -1 /dev/sd[e-q]` | sort -k1

for i in `ls -1 /dev/sd[e-q]`
do
  echo -e "o\nn\np\n1\n\n\nw" | fdisk $i
done


sde----   5G 
sdf----   5G 

sdg----   10G 
sdh----   10G 
sdi----   10G 
sdj----   10G 
sdk----   10G 
sdl----   10G 

sdm----   200G 
sdn----   200G 
sdo----   200G 
sdp----   100G 
sdq----   100G 

/usr/sbin/oracleasm createdisk ASM_01 /dev/sde1
/usr/sbin/oracleasm createdisk ASM_02 /dev/sdf1

/usr/sbin/oracleasm createdisk REDO01_RENTA_01 /dev/sdg1
/usr/sbin/oracleasm createdisk REDO01_RENTA_02 /dev/sdh1
/usr/sbin/oracleasm createdisk REDO01_RENTA_03 /dev/sdi1
/usr/sbin/oracleasm createdisk REDO02_RENTA_01 /dev/sdj1
/usr/sbin/oracleasm createdisk REDO02_RENTA_02 /dev/sdk1
/usr/sbin/oracleasm createdisk REDO02_RENTA_03 /dev/sdl1

/usr/sbin/oracleasm createdisk DATA_RENTA_01 /dev/sdm1
/usr/sbin/oracleasm createdisk DATA_RENTA_02 /dev/sdn1
/usr/sbin/oracleasm createdisk DATA_RENTA_03 /dev/sdo1

/usr/sbin/oracleasm createdisk FRA_RENTA_01 /dev/sdp1
/usr/sbin/oracleasm createdisk FRA_RENTA_02 /dev/sdq1





FILE_PATH=/opt/oracle.ahf/data/dlbdro01/orachk/user_root/output/orachk_dlbdro01_RORAIMAD_012726_101514.zip
FILE_NAME=$(basename ${FILE_PATH} | cut -d'.' -f1)
unzip -q -d /tmp -j ${FILE_PATH} "${FILE_NAME}/${FILE_NAME}.html" && chmod 777 /tmp/${FILE_NAME}.html && cd /tmp




