
*****
Aumentar RAM y SWAP
Modificar SecureBo**

****
Solicitud de discos

*************************
Solicitar IPs para crear el cluster : (Redes)

Buen dia,
--La presente es para solicitar direcciones IPs en el ambiente de CALIDAD con el fin de crear el cluster de PCPQ-PCP_DOMICQ 

3 IPs de SCAN
2 IPs de VIP

Registro DNS (Windows)

VIP
180.183.168.123 clbdhpcpdom01-vip clbdhpcpdom01-vip.banvenqa.com
180.183.168.124 clbdhpcpdom02-vip clbdhpcpdom02-vip.banvenqa.com


Es necesario crear en modo round robin lo siguiente:
Calidad

### LX010QSCAN
180.183.168.120
180.183.168.121
180.183.168.122


Alias del Clustername:

LX010QSCAN CLUSTERLX010Q

*************
Falta la interfaz de interconnect - se solicita la creacion con la configuracion del MTU en 9600

Modificar /etc/hosts -- en ambos nodos

# PUB
180.183.168.98 clbdhpcpdom01 clbdhpcpdom01.banvenqa.com
180.183.168.99 clbdhpcpdom02 clbdhpcpdom02.banvenqa.com


# VIP
180.183.168.123 clbdhpcpdom01-vip clbdhpcpdom01-vip.banvenqa.com
180.183.168.124 clbdhpcpdom02-vip clbdhpcpdom02-vip.banvenqa.com


#PRIV-IP
192.168.180.10 clbdhpcpdom01-priv clbdhpcpdom01-priv.banvenqa.com
192.168.180.11 clbdhpcpdom02-priv clbdhpcpdom02-priv.banvenqa.com



## LX010QSCAN
## 180.183.168.120
## 180.183.168.121
## 180.183.168.122

***************************************************************
- Dar formato a Discos -
**************************************************************************************************************************************





**************************************************************************************************************************************
**************************************************************************************************************************************



**************************************************************************************************************************************
**************************************************************************************************************************************
