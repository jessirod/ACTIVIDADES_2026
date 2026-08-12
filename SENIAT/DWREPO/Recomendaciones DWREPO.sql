Recomendaciones DWREPO

cambiar awr a 15 Min

--10Jul
10513 - 10514  


gt5ba38dp0xt1
2p82v7bx6nv9j	


--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

file:///C:/Users/jessika.rodriguez/Documents/SENIAT/DWREPO/dwrepo/DWREPO_10_JUL_2026_0500_0600_10513_10514.html
gt5ba38dp0xt1	
/* MV_REFRESH (INS) */INSERT /*+ BYPASS_RECURSIVE_CHECK APPEND  */ INTO "ITAXUSER"."INVENTARIO_FACTURADORES" SELECT /*+ PARALLEL(8)
           LEADING(mf suc cont cat_mf cat_prod dist inv)
           USE_HASH(suc cont cat_mf cat_prod dist inv)
           NO_MERGE(mf) */
    mf.SERIAL,
    mf.ESTATUS,
    mf.ESTATUS_COM,
    mf.FECHA_ULT_COMUNICACION,
    mf.ULTIMO_NUMZ_ENVIADO,
    mf.FECHA_NUMZ_ENVIADO,
    mf.ULTIMO_NUMZ_REALIZADO,
    mf.FECHA_NUMZ_REALIZADO,
    mf.ID_TIPO_COMUNICACION,
    mf.FECHA_RECEP_ULT_Z,
    mf.FECHA_CREADO,
    cont.DNI_LETRA || cont.DNI_NUMERO                  AS RIF_Contribuyente,
    dist.DNI_LETRA || dist.DNI_NUMERO                  AS RIF_PROVEEDOR,
    suc.NOMBRE                                         AS NOMBRE_SUCURSAL,
    suc.DIRECCION                                      AS DIRECCION_SUCURSAL,
    suc.TELEFONO                                       AS TELEFONO_SUCURSAL,
    cont.DNI_NUMERO,
    cont.DNI_LETRA,
    cont.RAZONSOCIAL                                   AS RAZONSOCIAL_ITAX,
    cont.NOMBRE,
    cont.CORREO,
    cont.APELLIDO,
    cat_mf.NOMBRE                                      AS TIPO_MAQUINA_FISCAL,
    cat_prod.DESCRIPCION                               AS TIPO_PRODUCTO,
    dist.RAZON_SOCIAL                                  AS RAZON_SOCIAL_DISTRIBUIDOR,
    dist.DNI_LETRA                                     AS DNI_LETRA_DISTRIBUIDOR,
    dist.DNI_NUMERO                                    AS DNI_NUMERO_DISTRIBUIDOR,
    /* --- INVENTARIO_CONTRIBUYENTES --- */
    inv.RIF_CONTRIBUYENTE  AS RIF_CONTRIBUYENTE_2,
    inv.ID_CONTRIBUYENTE,
    inv.NOMBRE_CONTRIBUYENTE,
    inv.APELLIDO_CONTRIBUYENTE,
    inv.NOMBRE_COMERCIAL_CONTRIBUYENTE,
    inv.SITUACION_CONTRIBUYENTE,
    inv.REGION_CONTRIBUYENTE,
    inv.NOMBRE_REGION,
    inv.NOMBRE_ESTADO,
    inv.NOMBRE_MUNICIPIO,
    inv.NOMBRE_PARROQUIA,
    inv.NOMBRE_CENTRO_POBLADO,
    inv.SECTOR_DIRECCION_CONTRIBUYENTE,
    inv.VIALIDAD_DIR_CONTRIBUYENTE,
    inv.TELEFONO_DIRECCION_CONTRIBUYEN,
    inv.EMAIL_CONTRIBUYENTE,
    inv.NOMBRE_DEPENDENCIA,
    inv.DEPENDENCIA_SECTOR,
    inv.FLAG_RIF_VENCIDO
FROM
    /* Pre-filtro: solo maquinas activas y comunicadas (NO_MERGE evita aplanar el filtro) */
    (SELECT /*+ PARALLEL(8) */ *
       FROM ITAXUSER.CONT_MAQUINAS_FISCALES
      WHERE ESTATUS = 1 AND ESTATUS_COM = 1) mf
    LEFT JOIN ITAXUSER.CONT_SUCURSALES             suc
        ON  mf.ID_CONT_SUCURSAL           = suc.ID_CONT_SUCURSAL
    LEFT JOIN ITAXUSER.CONT_CONTRIBUYENTES         cont
        ON  suc.ID_CONT_CONTRIBUYENTE     = cont.ID_CONT_CONTRIBUYENTE
    LEFT JOIN ITAXUSER.CAT_TIPOS_MAQUINAS_FISCALES cat_mf
        ON  mf.ID_CAT_TIPO_MAQUINA_FISCAL = cat_mf.ID_CAT_TIPO_MAQUINA_FISCAL
    LEFT JOIN ITAXUSER.CAT_TIPO_PRODUCTOS          cat_prod
        ON  cat_mf.ID_CAT_TIPO_PRODUCTOS  = cat_prod.ID_CAT_TIPO_PRODUCTOS
    LEFT JOIN ITAXUSER.CONT_DISTRIBUIDOR           dist
        ON  mf.ID_CONT_DISTRIBUIDOR       = dist.ID_CONT_DISTRIBUIDOR
    LEFT JOIN DATOSCONTRIBUYENTE.INVENTARIO_CONTRIBUYENTES inv
        ON  LPAD(TRIM(TO_CHAR(cont.DNI_NUMERO)),  9,  '0')
          = LPAD(TRIM(TO_CHAR(inv.RIF_NUMERICO_CONTRIBUYENTE)),  9,  '0')





2p82v7bx6nv9j	
/* MV_REFRESH (INS) */INSERT /*+ BYPASS_RECURSIVE_CHECK APPEND  */ INTO "ITAXUSER"."CONEXOS_MAQ" SELECT /*+ PARALLEL(8)
           LEADING(dcl act inv)
           USE_HASH(act) USE_HASH(inv)
           NO_MERGE(dcl) */
    'CON DECLARACION PRESENTADA DESDE 2024'  AS IND_DECLARACION_DESDE_2024,
    inv.RIF_CONTRIBUYENTE,
    inv.ID_CONTRIBUYENTE,
    inv.APELLIDO_CONTRIBUYENTE,
    inv.NOMBRE_CONTRIBUYENTE,
    inv.PERSONALIDAD_CONTRIBUYENTE,
    inv.NOMBRE_COMERCIAL_CONTRIBUYENTE,
    inv.FECHA_NACIMIENTO_CONTRIBUYENTE,
    inv.ACTIV_ECONO_CONTRIBUYENTE,
    inv.NACIONALIDAD_CONTRIBUYENTE,
    inv.REGION_CONTRIBUYENTE,
    inv.FECHA_INCORP_CONTRIBUYENTE,
    inv.TIPO_SOCIEDAD_CONTRIBUYENTE,
    inv.CLASE_EMPRESA_CONTRIBUYENTE,
    inv.FECHA_ULT_MODIF_CONTRIBUYENTE,
    inv.IND_DOMICILIADO_CONTRIBUYENTE,
    inv.ESTADO_CIVIL_CONTRIBUYENTE,
    inv.TIPO_CONTRIBUYENTE,
    inv.SITUACION_CONTRIBUYENTE,
    inv.SEXO_CONTRIBUYENTE,
    inv.IND_AGENTE_RETENCION_CONTRIBUY,
    inv.RIF_NUMERICO_CONTRIBUYENTE,
    inv.NIT_NUMERICO_CONTRIBUYENTE,
    inv.MES_CIERRE_FISCAL_CONTRIBUYENT,
    inv.FECHA_CIERRE_FISCAL_C,
    inv.DEPENDENCIA_INSCRIPCION_C,
    inv.DEPENDENCIA_ADSCRIPCION_C,
    inv.ORIGEN_INFORMACION_CONTRIBUYEN,
    inv.FECHA_INSERCION_CONTRIBUYENTE,
    inv.EMAIL_CONTRIBUYENTE,
    inv.ACTIVAR_FIRMAS_PERSONALES,
    inv.DIGITO_VERIF_RIF_CONTRIBUYENTE,
    inv.OBSERVACIONES_INSCRIPCION_C,
    inv.IND_CONTRIB_ESPECIAL_IVA,
    inv.CLASE_CONTRIBUYENTE_IVA,
    inv.FECHA_VENC_CERT_CONTRIBUYENTE,
    inv.FECHA_INCORP_CONTRIB_ESPECIAL,
    inv.FECHA_NOTIF_CONTRIB_ESPECIAL,
    inv.IND_DOMICILIADO_RESIDENCIADO,
    inv.DEPENDENCIA_SECTOR_ADSC,
    inv.ULT_PERIODO_ISLR,
    inv.ULT_PERIODO_IVA,
    inv.DOC_IDENTIDAD_CONTRIBUYENTE,
    inv.NUMERO_CERTIFICADO,
    inv.FLAG_RIF_VENCIDO,
    inv.NOMBRE_DEPENDENCIA,
    inv.TELEFONO_DIRECCION_CONTRIBUYEN,
    inv.TELEFONO_2_DIRECCION_CONTRIBUY,
    inv.EMAIL_DIRECCION_CONTRIBUYENTE,
    inv.EDIFICACION_DIR_CONTRIBUYENTE,
    inv.SECTOR_DIRECCION_CONTRIBUYENTE,
    inv.VIALIDAD_DIR_CONTRIBUYENTE,
    inv.LOCAL_DIRECCION_CONTRIBUYENTE,
    inv.NOMBRE_CENTRO_POBLADO,
    inv.NOMBRE_PARROQUIA,
    inv.NOMBRE_MUNICIPIO,
    inv.NOMBRE_ESTADO,
    inv.NOMBRE_REGION,
    inv.DEPENDENCIA_SECTOR,
    act.CODIGO_ACT_ECONOMICA,
    act.DESCRIPCION_ACT_ECONOMICA,
    act.FECHA_REGISTRO_ACT_ECON,
    act.NUMERO_CERTIFICADO                    AS NUMERO_CERTIFICADO_ACT_ECON
FROM
    /* Paso 1: contribuyentes con al menos una declaracion desde 2024
       (DISTINCT en subquery,  NO_MERGE evita que el optimizador la aplane) */
    (SELECT /*+ PARALLEL(8) */ DISTINCT d.ID_CONTRIBUYENTE
       FROM DBO.DECLARACION d
      WHERE d.FECHA_DECLARACION >= DATE '2024-01-01')     dcl
    /* Paso 2: filtrar actividades por descripcion sobre el set ya reducido */
    INNER JOIN DATOSCONTRIBUYENTE.ACTIVIDAD_ECONOMICA_CONTRIB act
        ON act.ID_CONTRIBUYENTE = dcl.ID_CONTRIBUYENTE
    /* Paso 3: traer las columnas anchas solo para las filas finales */
    INNER JOIN DATOSCONTRIBUYENTE.INVENTARIO_CONTRIBUYENTES inv
        ON inv.ID_CONTRIBUYENTE = act.ID_CONTRIBUYENTE
WHERE
    act.DESCRIPCION_ACT_ECONOMICA IN (
        'OTRAS ACTIVIDADES DEL SERVICIO DE ALIMENTACION',
        'VENTA AL POR MAYOR DE ALIMENTOS,  BEBIDAS Y TABACO',
        'VENTA AL POR MENOR DE ALIMENTO,  BEBIDAS Y TABACO EN ALMACENES ESPECIALIZADOS',
        'VENTA AL POR MENOR DE ALIMENTO EN ALMACENES ESPECIALIZADOS',
        'VENTA AL POR MENOR EN ALMACENES NO ESPECIALIZADOS,  CON SURTIDO COMPUESTOS PRINCIPALMENTE DE ALIMENTO,  BEBIDAS Y TABACO',
        'VENTA AL POR MENOR EN PUESTOS DE VENTA Y MERCADOS DE: ALIMENTO,  BEBIDAS Y DE PRODUCTOS DEL TABACO',
        'ACTIVIDADES VINCULADAS AL SERVICIO DE BEBIDAS',
        'VENTA AL POR MENOR DE BEBIDAS EN ALMACENES ESPECIALIZADOS',
        'VENTA AL POR MENOR DE TABACO EN ALMACENES ESPECIALIZADOS',
        'ELABORACION DE COMIDAS Y PLATOS PREPARADOS',
        'RESTAURANTES Y OTROS SERVICIOS DE COMIDAS MOVILES',
        'VENTA AL POR MAYOR DE MATERIALES DE CONSTRUCCION,  ARTICULOS DE FERRETERIA Y EQUIPO Y MATERIALES DE FONTANERIA Y CALEFACCION',
        'VENTA AL POR MENOR DE ALFOMBRAS,  CUBIERTAS DE PARED Y PISO EN ALMACENES ESPECIALIZADOS',
        'VENTA AL POR MENOR DE ARTICULOS DE FERRETERIA,  PINTURAS Y PRODUCTOS DE VIDRIO EN ALMACENES ESPECIALIZADOS',
        'VENTA AL POR MENOR DE PRODUCTOS FARMACEUTICOS Y MEDICINALES,  COSMETICOS Y ARTICULOS DE TOCADOR EN ALMACENES ESPECIALIZADOS',
        'VENTA AL POR MENOR DE TEXTILES EN ALMACENES ESPECIALIZADOS',
        'VENTA AL POR MENOR DE PRODUCTO TEXTILES,  PRENDAS DE VESTIR,  CALZADO Y ARTICULOS DE CUERO EN ALMACENES ESPECIALIZADOS',
        'VENTA AL POR MENOR EN PUESTOS DE VENTA Y MERCADOS DE: ARTICULOS TEXTILES,  ROPA Y CALZADO',
        'VENTAS AL POR MAYOR DE TEXTILES,  PRENDAS DE VESTIR Y CALZADOS',
        'MANTENIMIENTO Y REPARACION DE VEHICULOS AUTOMOTORES',
        'VENTA DE PARTES,  PIEZAS Y ACCESORIOS DE VEHICULOS AUTOMOTORES',
        'VENTA AL POR MENOR DE COMBUSTIBLE EN ALMACENES ESPECIALIZADOS',
        'VENTA,  MANTENIMIENTO Y REPARACION DE MOTOCICLETAS Y DE SUS PARTES,  PIEZAS Y ACCESORIOS',
        'ACTIVIDADES DE ALOJAMIENTO DE CORTO PLAZO',
        'OTROS ALOJAMIENTOS',
        'ACTIVIDADES DE CLUBES DEPORTIVOS',
        'OTRAS ACTIVIDADES DEPORTIVAS',
        'ACTIVIDADES DE PELUQUERIA Y OTROS TRATAMIENTOS DE BELLEZA',
        'FOTOCOPIA,  PREPARACION DE DOCUMENTOS Y OTRAS ACTIVIDADES ESPECIALIZADAS DE APOYO PARA LA OFICINA',
        'ACTIVIDADES DE IMPRESION',
        'OTROS TIPOS DE VENTA AL POR MENOR NO REALIZADA EN ALMACENES,  PUESTOS DE VENTA O MERCADOS',
        'VENTA AL POR MENOR DE ARTICULOS DE DEPORTE EN ALMACENES ESPECIALIZADOS',
        'VENTA AL POR MENOR DE JUEGOS Y DE JUGUETES EN ALMACENES ESPECIALIZADOS',
        'VENTA AL POR MENOR DE LIBROS,  PERIODICOS Y ARTICULOS DE PAPELERIA EN ALMACENES ESPECIALIZADOS',
        'VENTA AL POR MENOR EN PUESTOS DE VENTA Y MERCADOS DE OTRAS MERCANCIAS',
        'VENTA AL POR MENOR DE OTROS PRODUCTOS EN ALMACENES NO ESPECIALIZADOS',
        'VENTA AL POR MENOR DE PRODUCTOS NUEVOS EN ALMACENES ESPECIALIZADOS',
        'VENTA AL POR MAYOR DE OTROS PRODUCTOS NO ESPECIALIZADOS'
    )

--------------------------------------------------------------------------------------------------------------------------------------

Run SQL Tuning Advisor
2p82v7bx6nv9j
gt5ba38dp0xt1
gn4frgu8xvgpq
   


Finding 2: Top Segments by "User I/O" and "Cluster"
Impact is .07 active sessions, 39.19% of total activity.
--------------------------------------------------------
Individual database segments responsible for significant "User I/O" and
"Cluster" waits were found.

   Recommendation 1: Segment Tuning
   Estimated benefit is .07 active sessions, 39.19% of total activity.
   -------------------------------------------------------------------
   Action
      Run "Segment Advisor" on TABLE
      "DATOSCONTRIBUYENTE.INVENTARIO_CONTRIBUYENTES" with object ID 201434.
      Related Object
         Database object with ID 201434.
   Action
      Investigate application logic involving I/O on TABLE
      "DATOSCONTRIBUYENTE.INVENTARIO_CONTRIBUYENTES" with object ID 201434.
      Related Object
         Database object with ID 201434.
   Action
      Look at the "Top SQL Statements" finding for SQL statements consuming
      significant I/O on this segment. For example, the INSERT statement with
      SQL_ID "2p82v7bx6nv9j" is responsible for 66% of "User I/O" and
      "Cluster" waits for this segment.
   Rationale
      The I/O usage statistics for the object are: 204 full object scans,
      3986567 physical reads, 0 physical writes and 3986567 direct reads.

   Symptoms That Led to the Finding:
   ---------------------------------
      Wait class "User I/O" was consuming significant database time.
      Impact is .11 active sessions, 66.77% of total activity.

--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

--AWR snapshot range from 10512 to 10513.
file:///C:/Users/jessika.rodriguez/Documents/SENIAT/DWREPO/dwrepo/DWREPO_10_JUL_2026_0400_0500_10512_10513.html#d7qmxx27nhctm
dp0j3902qax22
5g70vf1q6544t
5yucc2q33ayzc  -- TABLE ACCESS - FULL - db file scattered read	
8c40b4tym19nj
g60dvp6w5y8kq
fnbjkp6bvfwkm
0d5xf7mvsjwm5  -- INDEX - RANGE SCAN -  db file sequential read
2p82v7bx6nv9j
9a81achmm7hzw	
1q4hktq79fvg4

--------------------------------------------------------------------------------------------------------------------------------------

      Run SQL Tuning Advisor on 
      
5yucc2q33ayzc
f0bwcgsxar0gp
   Rationale
Top level calls to execute the PL/SQL statement with SQL_ID
"8c40b4tym19nj" are responsible for 100% of the database time spent on
the INSERT statement with SQL_ID "f0bwcgsxar0gp".
0d5xf7mvsjwm5
fa9wsqfzz61pp
   Rationale
Top level calls to execute the PL/SQL statement with SQL_ID
"dp0j3902qax22" are responsible for 100% of the database time spent on
the INSERT statement with SQL_ID "fa9wsqfzz61pp".
d7qmxx27nhctm
   Rationale
Top level calls to execute the PL/SQL statement with SQL_ID
"8c40b4tym19nj" are responsible for 100% of the database time spent on
the CREATE INDEX statement with SQL_ID "d7qmxx27nhctm".
Related Object
SQL statement with SQL_ID 8c40b4tym19nj.
call DBO.REFRESCA_VISTAS (  )


---------------
      Run "Segment Advisor" on TABLE "DBO.COMPROMISO_PAGO" with object ID
      77318.
      Related Object
         Database object with ID 77318.
Action
      Investigate application logic involving I/O on TABLE
      "DBO.COMPROMISO_PAGO" with object ID 77318.
5yucc2q33ayzc

      Run "Segment Advisor" on TABLE
      "DATOSCONTRIBUYENTE.CONTRIBUYENTES_ORDINARIOS_ACTIVOS" with object ID
      115736.
      Related Object
         Database object with ID 115736.
   Action
      Investigate application logic involving I/O on TABLE
      "DATOSCONTRIBUYENTE.CONTRIBUYENTES_ORDINARIOS_ACTIVOS" with object ID
      115736.
f0bwcgsxar0gp
--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

file:///C:/Users/jessika.rodriguez/Documents/SENIAT/DWREPO/dwrepo/DWREPO_10_JUL_2026_0300_0400_10511_10512.html

AWR snapshot range from 10511 to 10512

Alto elapsed time

fn372y6s8a5u1	DBMS_SCHEDULER	BEGIN DBMS_MVIEW.REFRESH(LIST ...
fvm4hdhwd0ra9	DBMS_SCHEDULER	/* MV_REFRESH (INS) */INSERT /...
3mbjxc7zpq7p4	DBMS_SCHEDULER	BEGIN DBMS_MVIEW.REFRESH(LIST ...
46k6ff6j4mnwq	DBMS_SCHEDULER	/* MV_REFRESH (INS) */INSERT /...
1jzwhdrc8q3ra	DBMS_SCHEDULER	BEGIN DBMS_MVIEW.REFRESH(LIST ...
ag3jr73zy19q3	DBMS_SCHEDULER	/* MV_REFRESH (INS) */INSERT /...
7vkk8v38d0h05	DBMS_SCHEDULER	SELECT COUNT(*) FROM DATOSCONT...
1vshv0bzhkurt	DBMS_SCHEDULER	DECLARE job BINARY_INTEGER := ...
4877g3czt283w	DBMS_SCHEDULER	DECLARE job BINARY_INTEGER := ...
cfyv2uf2kambq	DBMS_SCHEDULER	BEGIN DBMS_MVIEW.REFRESH(LIST ...
3q717rqr2phsh	DBMS_SCHEDULER	DECLARE job BINARY_INTEGER := ...
buqzwghk08b7c	DBMS_SCHEDULER	DECLARE job BINARY_INTEGER := ...
dsf2mytj0nphs	DBMS_SCHEDULER	DECLARE job BINARY_INTEGER := ...
78r4zc72nzqjd	DBMS_SCHEDULER	DECLARE job BINARY_INTEGER := ...
0zqjh970rfp8c	DBMS_SCHEDULER	DECLARE job BINARY_INTEGER := ...
3h6349fv8avak	DBMS_SCHEDULER	DECLARE job BINARY_INTEGER := ...
6h4g9z5asu6p9	DBMS_SCHEDULER	BEGIN DBMS_MVIEW.REFRESH(LIST ...
bgwswdcwrpss7	DBMS_SCHEDULER	/* MV_REFRESH (INS) */INSERT /...
9uzdbhbrzkcau	DBMS_SCHEDULER	DECLARE job BINARY_INTEGER := ...
6b5wc0purdn8c	DBMS_SCHEDULER	BEGIN DBMS_MVIEW.REFRESH(LIST ...
2pkpvuh0wqb4z	DBMS_SCHEDULER	/* MV_REFRESH (INS) */INSERT /...
9cqgptp0hahna	DBMS_SCHEDULER	DECLARE job BINARY_INTEGER := ...
3b321za88646s	DBMS_SCHEDULER	DECLARE job BINARY_INTEGER := ...
5vrt3j98qua2w	DBMS_SCHEDULER	SELECT COUNT(*) FROM DBO.DECLA...




DATOSCONTRIBUYENTE	TS_INDEX	    PK_CONTRIBUYENTE	 	    INDEX
DATOSCONTRIBUYENTE	TS_DATA	        CONTRIBUYENTE	 	        TABLE
DATOSCONTRIBUYENTE	TS_DATA	        INVENTARIO_CONTRIBUYENTES	TABLE  ****
JMMARTINEZF	        USERS	        IX_MPG_PERIODO_GROUP	 	INDEX
DBO	                TS_DATA	        MEJORES_PAGADORES_GLOBAL	TABLE

--------------------------------------------------------------------------------------------------------------------------------------

      Run SQL Tuning Advisor 
fvm4hdhwd0ra9
   Rationale
      Top level calls to execute the PL/SQL statement with SQL_ID
      "dp0j3902qax22" are responsible for 100% of the database time spent on
      the INSERT statement with SQL_ID "fvm4hdhwd0ra9".

46k6ff6j4mnwq
   Rationale
      Top level calls to execute the PL/SQL statement with SQL_ID
      "8c40b4tym19nj" are responsible for 100% of the database time spent on
      the INSERT statement with SQL_ID "ag3jr73zy19q3".
      Related Object
         SQL statement with SQL_ID 8c40b4tym19nj.
         call DBO.REFRESCA_VISTAS (  )

7vkk8v38d0h05
   Rationale
      Top level calls to execute the PL/SQL statement with SQL_ID
      "8c40b4tym19nj" are responsible for 100% of the database time spent on
      the SELECT statement with SQL_ID "7vkk8v38d0h05".
      Related Object
         SQL statement with SQL_ID 8c40b4tym19nj.
         call DBO.REFRESCA_VISTAS (  )

9p83s7d1kk285   

--------------------


 Run "Segment Advisor" on TABLE
      "DATOSCONTRIBUYENTE.INVENTARIO_CONTRIBUYENTES" with object ID 201434.
      Related Object
         Database object with ID 201434.
   Action
      Investigate application logic involving I/O on TABLE
      "DATOSCONTRIBUYENTE.INVENTARIO_CONTRIBUYENTES" with object ID 201434.

Run "Segment Advisor" on TABLE "DBO.MEJORES_PAGADORES_GLOBAL" with
      object ID 191185.
      Related Object
         Database object with ID 191185.
   Action
      Investigate application logic involving I/O on TABLE
      "DBO.MEJORES_PAGADORES_GLOBAL" with object ID 191185.

Run "Segment Advisor" on TABLE "DBO.DECLARACIONES_REGION_CAPITAL" with
      object ID 89977.
      Related Object
         Database object with ID 89977.
   Action
      Investigate application logic involving I/O on TABLE
      "DBO.DECLARACIONES_REGION_CAPITAL" with object ID 89977.


--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
file:///C:/Users/jessika.rodriguez/Documents/SENIAT/DWREPO/dwrepo/DWREPO_10_JUL_2026_0200_0300_10510_10511.html

AWR snapshot range from 10510 to 10511.



Run SQL Tuning Advisor on

d0a7np2104dzg
bxp7vp7vs00n4
2f6u2kpax37n3
566c64kjrnpba

Investigate application logic involving I/O on TABLE
DATOSCONTRIBUYENTE.DIRECCION_CONTRIBUYENTE

Run "Segment Advisor" on INDEX 
"DBO.IDX_DECLARACION_01" 
"DBO.IDX_DECL_FECHA_CONTRIB"


--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
file:///C:/Users/jessika.rodriguez/Documents/SENIAT/DWREPO/dwrepo/DWREPO_10_JUL_2026_0000_0100_10508_10509.html#22

gzdaa8gpq54m4
36hawtjr1mrnn
1pf3r2zy8m2qk
fca5nmv3tbnkd

DATOSCONTRIBUYENTE.PK_CONTRIBUYENTE (INDEX)	TS_INDEX  db file sequential read
DATOSCONTRIBUYENTE.IDX_CONTRIBUYENTE_ISLR (INDEX)	TS_INDEX  db file sequential read
EXCOEX.IMPORTACIONES (TABLE)	TS_DATA db file scattered read
EXCOEX.SACRIFICIO_FISCAL (TABLE)	TS_DATA db file scattered read
DATOSCONTRIBUYENTE.IDX_CONTRIBUYENTE_ISLR_FUNC (INDEX)	TS_INDEX  db file sequential read

SQL Tuning Advisor 
b6g5rr0cgvhp8
89an1rgdaazxg
gfk1ypknmfxfr
510xk1myp5mng
36hawtjr1mrnn

EXCOEX.IMPORTACIONES
DATOSCONTRIBUYENTE.PK_CONTRIBUYENTE
DATOSCONTRIBUYENTE.IDX_CONTRIBUYENTE_ISLR


Finding 4: Commits and Rollbacks
Impact is .11 active sessions, 21.1% of total activity.
-------------------------------------------------------
Waits on event "log file sync" while performing COMMIT and ROLLBACK operations
were consuming significant database time.

   Recommendation 1: Host Configuration
   Estimated benefit is .11 active sessions, 21.1% of total activity.
   ------------------------------------------------------------------
   Action
      Investigate the possibility of improving the performance of I/O to the
      online redo log files.
   Rationale
      The average size of writes to the online redo log files was 196 K and
      the average time per write was 1 milliseconds.
   Rationale
      The total I/O throughput on redo log files was 563 K per second for
      reads and 563 K per second for writes.
   Rationale
      The redo log I/O throughput was divided as follows: 0% by RMAN and
      recovery, 49% by Log Writer, 0% by Archiver, 0% by Streams AQ and 50% by
      all other activity.

   Symptoms That Led to the Finding:
   ---------------------------------
      Wait class "Commit" was consuming significant database time.
      Impact is .11 active sessions, 21.1% of total activity.

-----Hay que multiplexar



--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------
file:///C:/Users/jessika.rodriguez/Documents/SENIAT/DWREPO/dwrepo/DWREPO_10_JUL_2026_0900_1000_10517_10518.html


d64ava2g0gfph
gn4frgu8xvgpq
97t8mn9b0m213	 


--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------






--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------






--------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------

