#**** config_asmlib_con_multipath.sh
#**** Script para configurar ASMLIB con soporte para multipath
#**** Autor: Nelson E. Diaz - DBA Team - ADSI
#**** Fecha: 2025-01-23
#**** Esto aplica para REDHAT 8.x y OL 8.x

Abrir log asm y crs em los tres nodos

#* 0. Bajar servicios del cluster, para ello necesitamos la ruta e los binarios de grid

Como grid

echo $ORACLE_HOME

/oracle/app/product/19c/grid

EJECUTAR TODOS LOS COMANDOS COMO USUARIO **ROOT**, A MENOS QUE SE INDIQUE LO CONTRARIO

Bajar servicios del cluster

/oracle/app/product/19c/grid/bin/crsctl stop crs
/oracle/app/product/19c/grid/bin/crsctl disable crs
/oracle/app/product/19c/grid/bin/crsctl config crs

#* 1. Verificar multipath

multipath -ll

# Output
.
.
.
asm_36 (360000970000220002339533030323643) dm-58 EMC,SYMMETRIX
size=500G features='1 queue_if_no_path' hwhandler='0' wp=rw
`-+- policy='service-time 0' prio=1 status=active
  |- 13:0:0:32 sdah    66:16   active ready running
  |- 13:0:1:32 sdbr    68:80   active ready running
  |- 13:0:2:32 sddb    70:144  active ready running
  |- 13:0:3:32 sdel    128:208 active ready running
  |- 16:0:0:32 sdfv    131:16  active ready running
  |- 16:0:1:32 sdhf    133:80  active ready running
  |- 16:0:2:32 sdip    135:144 active ready running
  `- 16:0:3:32 sdjz    65:464  active ready running

**Donde:**

| DEV          | Name              | Description                                                                           |
| ------------ | ----------------- | ------------------------------------------------------------------------------------- |
| /dev/mapper/ | asm_36            | RECOMENDADO PARA CONFIGURACION DE ASM - Alias del dispositivo, multipath real "dm-58" |
| /dev/dm*     | dm-58             | Nombre ID del dispositivo real de múltiples rutas                                     |
| /dev/sd*     | sdah, sdbr, etc.. | Nombre para cada dispositivo que no sea de múltiples rutas o canal                    |


#* 2. Verificar los discos disponibles existan

ls -l /dev/mapper/
ls -l /dev/dm*

#* 3. El siguiente comando muestra el listado de disco con sus multiples path configurados

lsblk -fms

#* 4. Respaldar y modificar el archivo de configuracion de ASMLIB

ls -ld /etc/sysconfig/oracleasm-_dev_oracleasm
cp -p /etc/sysconfig/oracleasm-_dev_oracleasm /etc/sysconfig/oracleasm-_dev_oracleasm.jr.$(date +'%Y%m%d')

Los parametros a modificar son:


cd /etc/sysconfig/

vi oracleasm-_dev_oracleasm
ORACLEASM_SCANORDER="dm"
ORACLEASM_SCANEXCLUDE="sd nvm"

Donde el valor de 'dm' corresponde al nombre del dispositivo multipath (dm-58 en el ejemplo), se coloca dm para que tome todos los dispositivos multipath disponibles.
El valor de 'sd nvm' corresponde a los dispositivos que no se desean que ASMLIB escanee, en este caso los discos sd* y nvm*. Corresponde a los usados en el SO para otros fines.

--##* 4.1. Modificiacion del archvio de forma automatica

--sed -i.dr.$(date +'%Y%m%d') \
---e 's/^ORACLEASM_SCANORDER=""$/ORACLEASM_SCANORDER="dm"/' \
---e 's/^ORACLEASM_SCANEXCLUDE=""$/ORACLEASM_SCANEXCLUDE="sd nvm"/' \
--/etc/sysconfig/oracleasm-_dev_oracleasm

cat /etc/sysconfig/oracleasm-_dev_oracleasm

El comando anterior respalda el archivo original con extension .nd.YYYYMMDD y luego modifica los parametros indicados con los valores correspondientes.

#* 5. Reiniciar ASMLIB

Con usuario root

/usr/sbin/oracleasm exit
/usr/sbin/oracleasm init

##* 5.1. Verificar que los cambios persisten

cat /etc/sysconfig/oracleasm
cat /etc/sysconfig/oracleasm-_dev_oracleasm

##* 5.2. Volver a escanear los discos pertenecientes a ASMLIB

oracleasm scandisks
oracleasm listdisks

##* 5.3. Verificar el major number de los discos de ASMLIB

ls -l /dev/oracleasm/disks
ls -l /dev/oracleasm/disks | grep -v total | wc -l

# Output

```bash
brw-rw----. 1 grid asmadmin 253,   1 Jan 22 14:58 DISK_ASM01
brw-rw----. 1 grid asmadmin 253, 177 Jan 22 14:58 DISK_ASM02
brw-rw----. 1 grid asmadmin 253,  17 Jan 22 14:58 DISK_ASM03
```

La columna 5, debe ser mayor o igual a 252, ya que corresponde al major number de los dispositivos multipath en Redhat 8.x y Oracle Linux 8.x, que indica el correcto uso de multipath


/oracle/app/product/19c/grid/bin/crsctl enable crs
/oracle/app/product/19c/grid/bin/crsctl start crs
