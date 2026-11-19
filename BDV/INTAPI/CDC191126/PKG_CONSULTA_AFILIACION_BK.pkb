CREATE OR REPLACE PACKAGE BODY PICBDV.PKG_CONSULTA_AFILIACION AS

    PROCEDURE PR_SEARCH_DASHBOARD(p_single OUT SYS_REFCURSOR) IS
            v_received     CONSTANT NUMBER := 0;
            v_id_apiconci  CONSTANT NUMBER := 3;
            v_fecha_inicio DATE := TRUNC(SYSDATE - 1);
            v_fecha_fin    DATE := TRUNC(SYSDATE + 1);
        BEGIN
            OPEN p_single FOR
                SELECT 
                    a.idcomercio AS name,
                    COUNT(1) AS value
                FROM 
                    apimovconci a
                WHERE 
                    a.received = v_received
                    AND a.id_apiconci = v_id_apiconci
                    AND a.fecha >= v_fecha_inicio
                    AND a.fecha < v_fecha_fin
                GROUP BY 
                    a.idcomercio
                ORDER BY 
                    value DESC;
        END PR_SEARCH_DASHBOARD;
            
   PROCEDURE PR_GET_TOTAL_RECONCILED_PAYMENTS(
        p_total OUT NUMBER
    )
    AS
        v_inicio_hoy DATE := TRUNC(SYSDATE);
        v_inicio_manana DATE := TRUNC(SYSDATE + 1);
    BEGIN
        SELECT COUNT(1) 
        INTO p_total
        FROM api_conc_mov_hist
        WHERE FECHA >= v_inicio_hoy 
          AND FECHA < v_inicio_manana;
        
    EXCEPTION
        WHEN OTHERS THEN
            p_total := 0; 
            RAISE;
    END PR_GET_TOTAL_RECONCILED_PAYMENTS;
    
    PROCEDURE PR_GET_TOTAL_NOTIFIED_PAYMENTS(
        p_total OUT NUMBER
    )
    AS
        v_id_apiconci CONSTANT NUMBER := 3;
        v_received    CONSTANT VARCHAR2(10) := '1';
        v_estado      CONSTANT VARCHAR2(10) := '00';
        
    
        v_inicio_hoy    DATE := TRUNC(SYSDATE);
        v_inicio_manana DATE := TRUNC(SYSDATE + 1);
    BEGIN
        SELECT COUNT(1)
        INTO p_total
        FROM apimovconci
        WHERE fecha >= v_inicio_hoy
          AND fecha < v_inicio_manana
          AND id_apiconci = v_id_apiconci
          AND received    = v_received
          AND estado      = v_estado;
        
    EXCEPTION
        WHEN OTHERS THEN
            
            p_total := 0; 
            RAISE;
    END PR_GET_TOTAL_NOTIFIED_PAYMENTS;

    PROCEDURE PR_GET_TOTAL_NOT_NOTIFIED_PAYMENTS(
        p_total OUT NUMBER
    )
    AS
        v_id_apiconci CONSTANT NUMBER := 3;
        v_received    CONSTANT VARCHAR2(10) := '1';
        v_estado_ok   CONSTANT VARCHAR2(10) := '00';
        v_estado_err  CONSTANT VARCHAR2(10) := '99';
        v_inicio_hoy    DATE := TRUNC(SYSDATE);
        v_inicio_manana DATE := TRUNC(SYSDATE + 1);
    BEGIN
        SELECT COUNT(1)
        INTO p_total
        FROM apimovconci
        WHERE fecha >= v_inicio_hoy
          AND fecha < v_inicio_manana
          AND id_apiconci = v_id_apiconci
          AND received    = v_received
          AND estado     != v_estado_ok
          AND estado     != v_estado_err;
        
    EXCEPTION
        WHEN OTHERS THEN
            p_total := 0;
            RAISE;
    END PR_GET_TOTAL_NOT_NOTIFIED_PAYMENTS;
    
    PROCEDURE PR_GET_TOTAL_TRANSACTIONS_PROCESSED(
        p_total OUT NUMBER
    )
    AS
        v_id_apiconci CONSTANT NUMBER := 2;
        v_estado      CONSTANT VARCHAR2(10) := '0';
        v_inicio_hoy    DATE := TRUNC(SYSDATE);
        v_inicio_manana DATE := TRUNC(SYSDATE + 1);
    BEGIN
        SELECT COUNT(1)
        INTO p_total
        FROM apimovconci
        WHERE fecha >= v_inicio_hoy
          AND fecha < v_inicio_manana
          AND id_apiconci = v_id_apiconci
          AND estado      = v_estado;
        
    EXCEPTION
        WHEN OTHERS THEN
            p_total := 0;
            RAISE;
    END PR_GET_TOTAL_TRANSACTIONS_PROCESSED;
    
   PROCEDURE PR_SEARCH_DASHBOARD_ERRORES (
        p_errors OUT SYS_REFCURSOR
    ) AS
        v_id_apiconci  NUMBER       := 3;
        v_received     VARCHAR2(10) := '1';
        v_estado_ok    VARCHAR2(10) := '00';
        v_estado_err   VARCHAR2(10) := '99';
        v_falso        NUMBER       := 0;
        v_fecha_inicio DATE := TRUNC(SYSDATE - 1);
        v_fecha_fin    DATE := TRUNC(SYSDATE + 1);
    BEGIN
        OPEN p_errors FOR
            SELECT 
                ce.code, 
                ce.message AS name, 
                COUNT(1) AS value
            FROM apimovconci a
            JOIN codigo_errores ce ON a.estado = ce.code
            WHERE a.estado NOT IN (v_estado_ok, v_estado_err)
              AND a.id_apiconci = v_id_apiconci
              AND a.received = v_received
              AND a.fecha >= v_fecha_inicio
              AND a.fecha < v_fecha_fin
            GROUP BY ce.code, ce.message
            ORDER BY value DESC;
        
    EXCEPTION
        WHEN OTHERS THEN
            OPEN p_errors FOR 
                SELECT 'ERROR' AS code, 'Error al consultar errores' AS name, 0 AS value 
                FROM DUAL WHERE 1 = v_falso;
    END PR_SEARCH_DASHBOARD_ERRORES;
    
  PROCEDURE PR_GET_TOTAL_ERROR_99 (
        p_result OUT SYS_REFCURSOR
    ) AS
        v_id_apiconci  NUMBER        := 3;
        v_received     NUMBER        := 0;
        v_fecha_inicio DATE          := TRUNC(SYSDATE - 1);
        v_fecha_fin    DATE          := TRUNC(SYSDATE + 1);
    BEGIN
        OPEN p_result FOR
            SELECT 
                COUNT(1) AS total_registros,
                a.idcomercio,
                a.obs AS respuesta_cliente,
                NVL(MAX(mo.nombre_merchant), a.idcomercio) AS nombre_merchant,
                NVL(MAX(mc.url), 'N/A') AS url
            FROM apimovconci a
            LEFT JOIN merchant_operador mo 
              ON a.idcomercio = mo.nacionalidad || mo.cedula_rif
            LEFT JOIN merchant_connections mc 
              ON mo.merchant_id = mc.merchant
            WHERE a.id_apiconci = v_id_apiconci
              AND a.received = v_received
              AND a.fecha >= v_fecha_inicio
              AND a.fecha < v_fecha_fin
            GROUP BY 
                a.idcomercio, 
                a.obs
            ORDER BY total_registros DESC;
            
    EXCEPTION
        WHEN OTHERS THEN
            OPEN p_result FOR 
                SELECT 0 AS total_registros, 'N/A' AS idcomercio, 'ERROR' AS respuesta_cliente, 'N/A' AS nombre_merchant, 'N/A' AS url 
                FROM DUAL WHERE 1 = 0;
    END PR_GET_TOTAL_ERROR_99;

    PROCEDURE PR_VALIDATE_USER_LDAP_PORTAL(
        P_USERNAME   IN  VARCHAR2,
        COD_RET      OUT NUMBER,
        DE_CODRET    OUT VARCHAR2,
        P_RESULTADOS OUT SYS_REFCURSOR
    )
    IS
        V_EXISTE NUMBER := 0;
        V_FALSO NUMBER := 0;
    BEGIN
        COD_RET := 1000;
        DE_CODRET := 'Usuario encontrado';

        SELECT COUNT(1)
          INTO V_EXISTE
          FROM USERS_PORTAL
         WHERE USERNAME = P_USERNAME;
    
        IF V_EXISTE = 0 THEN
            COD_RET := 1001;
            DE_CODRET := 'Error: El usuario no existe';
    
            OPEN P_RESULTADOS FOR
                SELECT USERNAME, ID_STATUS_PORTAL, ID_ROLE_PORTAL
                  FROM USERS_PORTAL 
                 WHERE 1 = V_FALSO;
            RETURN;
        END IF;
    
        OPEN P_RESULTADOS FOR
            SELECT 
                 USP.ID AS ID_USER,
                 USP.USERNAME,
                 USP.FULL_NAME,
                 SP.STATUS,
                 RP.ID AS ID_ROLE,
                 RP.ROLE,
                 MP.ID AS ID_MANAGEMENT,
                 MP.MANAGEMENT_NAME AS MANAGEMENT,
                 UMP.ID AS ID_USERS_MANAGEMENT_PORTAL,
                 SMP.ID_MENU_PORTAL,
                 MEP.MENU_NAME,
                 UMSMP.ID_SUB_MENU_PORTAL,
                 SMP.SUB_MENU_NAME,
                 SMP.SUB_MENU_ROUTE,
                 UMSMPP.ID_PRIVILEGES_PORTAL,
                 PP.PRIVILEGE_NAME
              FROM USERS_PORTAL USP
              INNER JOIN USERS_MANAGEMENT_PORTAL UMP
                 ON USP.ID = UMP.ID_USERS_PORTAL
              INNER JOIN MANAGEMENT_PORTAL MP
                 ON UMP.ID_MANAGEMENT_PORTAL = MP.ID
              INNER JOIN STATUS_PORTAL SP
                 ON SP.ID = USP.ID_STATUS_PORTAL
              INNER JOIN ROLE_PORTAL RP
                 ON RP.ID = USP.ID_ROLE_PORTAL
              INNER JOIN USERS_MANAGEMENT_SUB_MENU_PORTAL UMSMP
                 ON UMP.ID = UMSMP.ID_USERS_MANAGEMENT_PORTAL
              INNER JOIN SUB_MENU_PORTAL SMP
                 ON SMP.ID = UMSMP.ID_SUB_MENU_PORTAL
              INNER JOIN USERS_MANAGEMENT_SUB_MENU_PRIVILEGES_PORTAL UMSMPP
                 ON UMSMPP.ID_USERS_MANAGEMENT_SUB_MENU = UMSMP.ID
              INNER JOIN PRIVILEGES_PORTAL PP
                 ON PP.ID = UMSMPP.ID_PRIVILEGES_PORTAL
              INNER JOIN MENU_PORTAL MEP
                 ON MEP.ID = SMP.ID_MENU_PORTAL
             WHERE USP.USERNAME = P_USERNAME
             ORDER BY 
                MEP.ORDEN ASC,         
                SMP.ORDEN ASC,         
                PP.PRIVILEGE_NAME ASC; 
    
    EXCEPTION
        WHEN OTHERS THEN
            COD_RET := SQLCODE;
            DE_CODRET := 'Error inesperado: ' || SQLERRM;
            IF NOT P_RESULTADOS%ISOPEN THEN
                OPEN P_RESULTADOS FOR 
                    SELECT * FROM USERS_PORTAL WHERE 1 = V_FALSO ;
            END IF;
    END PR_VALIDATE_USER_LDAP_PORTAL;
    
    PROCEDURE PR_ACTUALIZAR_URL_CLIENTE (
        p_merchant_id   IN  VARCHAR2,
        p_url           IN  VARCHAR2,
        p_cod_ret       OUT VARCHAR2,
        p_de_codret     OUT VARCHAR2
    )
    IS
    BEGIN
        UPDATE MERCHANT_CONNECTIONS
        SET URL = p_url
        WHERE MERCHANT = p_merchant_id;
    
        IF SQL%ROWCOUNT = 0 THEN
            p_cod_ret := '01';
            p_de_codret := 'Merchant no encontrado';
        ELSE
            p_cod_ret := '00';
            p_de_codret := 'URL actualizada exitosamente';
            COMMIT;
        END IF;
    
    EXCEPTION
        WHEN OTHERS THEN
            p_cod_ret := '99';
            p_de_codret := 'Error inesperado: ' || SQLERRM;
            ROLLBACK;
    END PR_ACTUALIZAR_URL_CLIENTE;
    
    PROCEDURE PR_CONSULTA_CLIENTE (
        p_NACIONALIDAD IN VARCHAR2,
        p_RIF IN VARCHAR2,
        COD_RET OUT VARCHAR2,
        DE_CODRET OUT VARCHAR2,
        MERCHANT_ID OUT NUMBER,
        NOMBRE_MERCHANT OUT VARCHAR2,
        TELEFONO_CLIENTE OUT VARCHAR2,
        NUMERO_CUENTA OUT VARCHAR2,
        FECHA_MERCHANT OUT VARCHAR2,
        FECHA_AFILIACION OUT VARCHAR2,
        URL OUT VARCHAR2
    ) AS
    
        v_merchant_id       NUMBER;
        v_nombre_merchant   VARCHAR2(100);
        v_telefono_cliente  VARCHAR2(20);
        v_numero_cuenta     VARCHAR2(50);
        v_fecha_merchant    VARCHAR2(50);
        v_url               VARCHAR2(200);
        v_fecha_afiliacion  VARCHAR2(50);
    
        P_ENCONTRADO NUMBER := 0;
    
        CURSOR merchant_cursor IS
            SELECT 
                mo.merchant_id, 
                mo.nombre_merchant,
                mo.telefono_cliente,
                mo.numero_cuenta,
                mo.fecha_creacion AS fecha_merchant,
                mc.url,
                mc.fecsys AS fecha_afiliacion
            FROM PICBDV.MERCHANT_OPERADOR mo
            LEFT JOIN PICBDV.MERCHANT_CONNECTIONS mc 
                   ON mo.merchant_id = mc.merchant
           WHERE mo.NACIONALIDAD = p_NACIONALIDAD
             AND mo.CEDULA_RIF  = TO_NUMBER(p_RIF);
    
    BEGIN
        OPEN merchant_cursor;
        FETCH merchant_cursor INTO v_merchant_id, v_nombre_merchant, v_telefono_cliente, 
                                  v_numero_cuenta, v_fecha_merchant, v_url, v_fecha_afiliacion;
    
        IF merchant_cursor%FOUND THEN
            MERCHANT_ID      := v_merchant_id;
            NOMBRE_MERCHANT  := v_nombre_merchant;
            TELEFONO_CLIENTE := v_telefono_cliente;
            NUMERO_CUENTA    := v_numero_cuenta;
            URL              := v_url;
            FECHA_MERCHANT   := v_fecha_merchant;
            FECHA_AFILIACION := v_fecha_afiliacion;
            P_ENCONTRADO     := 1;
        END IF;
    
        CLOSE merchant_cursor;
    
        IF P_ENCONTRADO > 0 THEN
            IF URL IS NULL THEN
                COD_RET  := '02';
                DE_CODRET := 'CLIENTE NO AFILIADO A NOTIFICACION DE PAGO';
            ELSE
                COD_RET  := '00';
                DE_CODRET := 'CLIENTE AFILIADO A NOTIFICACION DE PAGO';
            END IF;
        ELSE
            COD_RET  := '01';
            DE_CODRET := 'CLIENTE NO REGISTRADO EN APIS';
            MERCHANT_ID      := NULL;
            NOMBRE_MERCHANT  := NULL;
            TELEFONO_CLIENTE := NULL;
            NUMERO_CUENTA    := NULL;
            URL              := NULL;
            FECHA_MERCHANT   := NULL;
            FECHA_AFILIACION := NULL;
        END IF;
    
    EXCEPTION
        WHEN OTHERS THEN
            COD_RET  := '99';
            DE_CODRET := 'ERROR INTERNO EN LA CONSULTA';
            MERCHANT_ID      := NULL;
            NOMBRE_MERCHANT  := NULL;
            TELEFONO_CLIENTE := NULL;
            NUMERO_CUENTA    := NULL;
            URL              := NULL;
            FECHA_MERCHANT   := NULL;
            FECHA_AFILIACION := NULL;
    END PR_CONSULTA_CLIENTE;
    
    PROCEDURE PR_DESAFILIAR_MERCHANT_CONNECTIONS (
        p_merchant_id IN  VARCHAR2,
        p_codigo      OUT VARCHAR2,
        p_mensaje     OUT VARCHAR2
    ) IS
        v_conn_id NUMBER;
    BEGIN
        SELECT id
          INTO v_conn_id
          FROM merchant_connections
         WHERE merchant = p_merchant_id;
    
        DELETE FROM merchant_config
         WHERE connections_id = v_conn_id;
        
        DELETE FROM merchant_connections
         WHERE id = v_conn_id;
    
        COMMIT;
    
        p_codigo  := '00';
        p_mensaje := 'Desafiliación exitosa de notificación de pago';
    
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            p_codigo  := '01';
            p_mensaje := 'No existe afiliación para el merchant_id proporcionado';
        WHEN OTHERS THEN
            ROLLBACK;
            p_codigo  := '99';
            p_mensaje := 'Error inesperado: ' || SQLERRM;
    END PR_DESAFILIAR_MERCHANT_CONNECTIONS;
    
    PROCEDURE PR_GET_POD_TOTAL (
        p_ids_apiconci IN VARCHAR2,
        p_total_pods OUT SYS_REFCURSOR,
        p_status OUT SYS_REFCURSOR
    ) AS
        v_search_list VARCHAR2(4000) := ',' || p_ids_apiconci || ',';
    BEGIN
        OPEN p_total_pods FOR
            SELECT 
                sk.ID,
                sk.ID_APICONCI,
                ac.NAME_API AS NOMBRE_SERVICIO,
                sk.NOMBRE_IMAGEN,
                SUM(NVL(sk.TOTAL_PODS, 0)) AS TOTAL_PODS
            FROM SERVICIO_KUBERNETES sk
            JOIN APICONCI ac ON sk.ID_APICONCI = ac.ID
            WHERE INSTR(v_search_list, ',' || sk.ID_APICONCI || ',') > 0
            GROUP BY sk.ID, sk.ID_APICONCI, ac.NAME_API, sk.NOMBRE_IMAGEN
            ORDER BY sk.ID_APICONCI;
        
        OPEN p_status FOR
            SELECT 
                sk.ID_APICONCI,
                sk.NOMBRE_IMAGEN,
                sa.NAME_PODS,
                sa.STATUS
            FROM SERVICIO_KUBERNETES sk
            JOIN STATUS_ALERTAS sa ON INSTR(sa.NAME_PODS, sk.NOMBRE_IMAGEN) > 0
            WHERE INSTR(v_search_list, ',' || sk.ID_APICONCI || ',') > 0
            ORDER BY sk.ID_APICONCI, sa.NAME_PODS;
    END;
    
    PROCEDURE PR_LISTAR_INTEGRADORAS_ACTIVAS (
      p_result OUT SYS_REFCURSOR
    )
    AS
      v_status NUMBER := 1;
    BEGIN
      OPEN p_result FOR
        SELECT ID,
               NAME,
               URL,
               APIKEY,
               API_KEY_HEADER
          FROM INTEGRADORAS_MERCHANT
         WHERE STATUS = v_status;
    END;
    
    PROCEDURE PR_REGISTRAR_MERCHANT_CONNECTIONS (
            p_merchant_id   IN  VARCHAR2,
            p_url           IN  VARCHAR2,
            p_obs           IN  VARCHAR2, 
            p_api_key       IN  VARCHAR2,
            p_api_key_hdr   IN  VARCHAR2,
            p_cod_ret       OUT VARCHAR2,
            p_de_codret     OUT VARCHAR2
        ) AS
            v_count_conn    INTEGER;
            v_count_cfg     INTEGER;
            v_conn_id       NUMBER;
        BEGIN
         
            SELECT COUNT(1)
              INTO v_count_conn
              FROM MERCHANT_CONNECTIONS
             WHERE merchant = p_merchant_id;
            
            IF v_count_conn > 0 THEN
                p_cod_ret   := '01';
                p_de_codret := 'Ya existe registro en MERCHANT_CONNECTIONS para ese merchant';
                RETURN;
            END IF;
            
           
            INSERT INTO MERCHANT_CONNECTIONS (
                merchant, url, fecsys, status, obs
            ) VALUES (
                p_merchant_id,
                p_url,
                SYSDATE,
                '1',
                p_obs
            );
            
        
            SELECT MAX(id) 
              INTO v_conn_id 
              FROM MERCHANT_CONNECTIONS 
             WHERE merchant = p_merchant_id;
            
            SELECT COUNT(1)
              INTO v_count_cfg
              FROM MERCHANT_CONFIG
             WHERE connections_id = v_conn_id;
            
            IF v_count_cfg = 0 THEN
                INSERT INTO MERCHANT_CONFIG (
                    connections_id, api_key, api_key_header
                ) VALUES (
                    v_conn_id,
                    p_api_key,
                    p_api_key_hdr
                );
            ELSE
                UPDATE MERCHANT_CONFIG
                   SET api_key        = p_api_key,
                       api_key_header = p_api_key_hdr
                 WHERE connections_id = v_conn_id;
            END IF;
            
            COMMIT;
            
            p_cod_ret   := '00';
            p_de_codret := 'Registro exitoso en MERCHANT_CONNECTIONS y MERCHANT_CONFIG';
            
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                p_cod_ret   := '99';
                p_de_codret := 'Error inesperado: ' || SQLERRM;
        END PR_REGISTRAR_MERCHANT_CONNECTIONS;
    
       PROCEDURE PR_SEARCH_PAGO_MOVIL(
        p_referencia IN VARCHAR2,
        p_fecha IN VARCHAR2,
        cod_ret OUT VARCHAR2,
        de_codret OUT VARCHAR2,
        referencia_dcs OUT VARCHAR2,
        rif_comercio_dcs OUT VARCHAR2,
        num_comercio_dcs OUT VARCHAR2,
        banco_origen_dcs OUT VARCHAR2,
        banco_destino_dcs OUT VARCHAR2,
        monto_dcs OUT VARCHAR2,
        id_cliente_dcs OUT VARCHAR2,
        numero_cliente_dcs OUT VARCHAR2,
        estatus_dcs OUT VARCHAR2,
        mensaje_dcs OUT VARCHAR2, 
        fecha_dcs OUT VARCHAR2,
        id_apiconci_pic OUT VARCHAR2,
        api_pic OUT VARCHAR2, 
        referencia_pic OUT VARCHAR2,
        monto_pic OUT VARCHAR2,
        estatus_pic OUT VARCHAR2,
        obs_pic OUT VARCHAR2,
        estado_pic OUT VARCHAR2,
        fecha_pic OUT VARCHAR2
    ) AS
        v_fecha_inicio DATE := TRUNC(TO_DATE(p_fecha, 'DD/MM/YYYY') - 1);
        v_fecha_fin DATE := TRUNC(TO_DATE(p_fecha, 'DD/MM/YYYY') + 1); 
        p_referenciaValor VARCHAR2(30) := '%' || SUBSTR(p_referencia, -8);
   
        CURSOR c_datos IS
            SELECT 
                dcs.referencia AS referencia_dcs,
                dcs.idcomercio,
                dcs.numerocomercio,
                dcs.monto AS monto_dcs,
                dcs.bancoorigen,
                dcs.bancodestino,
                dcs.idcliente,
                dcs.numerocliente,
                dcs.estatus AS estatus_dcs,
                cod.message,
                TO_CHAR(dcs.fecsys, 'DD/MM/YYYY') || ' ' || dcs.hora AS fecha_hora_dcs,
                api.id AS id_apiconci,
                api.name_api,
                pic.referencia AS referencia_pic,
                pic.monto AS monto_pic,
                pic.estatus AS estatus_pic,
                pic.obs,
                pic.estado,
                CASE 
                    WHEN pic.fecsys IS NOT NULL THEN 
                        TO_CHAR(TO_DATE(pic.fecsys, 'DD/MM/YY'), 'DD/MM/YYYY') || ' ' || pic.hora
                    ELSE NULL
                END AS fecha_hora_pic
            FROM apimovconci_dcs dcs
            RIGHT JOIN apimovconci pic 
                ON dcs.referencia = pic.referencia
                AND dcs.fecsys >= v_fecha_inicio
                AND dcs.fecsys < v_fecha_fin
            LEFT JOIN apiconci api ON pic.id_apiconci = api.id
            LEFT JOIN codigo_errores cod ON dcs.estatus = cod.code
            WHERE pic.referencia LIKE p_referenciaValor
              AND pic.fecha >= v_fecha_inicio
              AND pic.fecha < v_fecha_fin
            UNION
            SELECT 
                dcs.referencia AS referencia_dcs,
                dcs.idcomercio,
                dcs.numerocomercio,
                dcs.monto AS monto_dcs,
                dcs.bancoorigen,
                dcs.bancodestino,
                dcs.idcliente,
                dcs.numerocliente,
                dcs.estatus AS estatus_dcs,
                cod.message,
                dcs.fecsys || dcs.hora AS fecha_hora_dcs,
                NULL AS id_apiconci,
                NULL AS name_api,
                NULL AS referencia_pic,
                NULL AS monto_pic,
                NULL AS estatus_pic,
                NULL AS obs,
                NULL AS estado,
                NULL AS fecha_hora_pic
            FROM apimovconci_dcs dcs
            LEFT JOIN codigo_errores cod ON dcs.estatus = cod.code
            WHERE dcs.referencia LIKE p_referenciaValor
              AND dcs.fecsys >= v_fecha_inicio
              AND dcs.fecsys < v_fecha_fin
              AND NOT EXISTS (
                  SELECT 1 
                  FROM apimovconci pic 
                  WHERE pic.referencia = dcs.referencia
                    AND pic.fecha >= v_fecha_inicio
                    AND pic.fecha < v_fecha_fin
              );
        v_datosValor c_datos%ROWTYPE;
        v_encontro BOOLEAN := FALSE;
    BEGIN
        OPEN c_datos;
        LOOP
            FETCH c_datos INTO v_datosValor;
            EXIT WHEN c_datos%NOTFOUND;
            v_encontro := TRUE;
            referencia_dcs := v_datosValor.referencia_dcs;
            rif_comercio_dcs := SUBSTR(v_datosValor.idcomercio, 2);
            num_comercio_dcs := v_datosValor.numerocomercio;
            IF v_datosValor.monto_dcs IS NOT NULL THEN
                monto_dcs := LTRIM(TO_CHAR(v_datosValor.monto_dcs, '999G999G990D00'));
            ELSE
                monto_dcs := NULL;
            END IF;
            banco_origen_dcs := v_datosValor.bancoorigen;
            banco_destino_dcs := v_datosValor.bancodestino;
            id_cliente_dcs := v_datosValor.idcliente;
            numero_cliente_dcs := v_datosValor.numerocliente;
            estatus_dcs := v_datosValor.estatus_dcs;
            mensaje_dcs := v_datosValor.message;
            id_apiconci_pic := v_datosValor.id_apiconci;
            api_pic := v_datosValor.name_api;
            referencia_pic := v_datosValor.referencia_pic;
            IF v_datosValor.fecha_hora_dcs IS NOT NULL AND TRIM(v_datosValor.fecha_hora_dcs) IS NOT NULL THEN
                fecha_dcs := v_datosValor.fecha_hora_dcs;
            ELSE
                fecha_dcs := NULL;
            END IF;
            IF v_datosValor.monto_pic IS NOT NULL THEN
                monto_pic := LTRIM(TO_CHAR(v_datosValor.monto_pic, '999G999G990D00'));
            ELSE
                monto_pic := NULL;
            END IF;
            estatus_pic := v_datosValor.estatus_pic;
            obs_pic := v_datosValor.obs;
            estado_pic := v_datosValor.estado;
            fecha_pic := v_datosValor.fecha_hora_pic;
            IF v_datosValor.referencia_dcs IS NOT NULL AND v_datosValor.referencia_pic IS NULL THEN
                cod_ret := '01';
                de_codret := 'PAGO MÓVIL RECIBIDO DE DCS PERO NO FUE NOTIFICADO';
            ELSIF v_datosValor.referencia_dcs IS NULL AND v_datosValor.referencia_pic IS NOT NULL THEN
                cod_ret := '03';
                de_codret := 'PAGO MÓVIL NOTIFICADO';
            ELSE
                cod_ret := '00';
                de_codret := 'PAGO MÓVIL RECIBIDO DE DCS Y NOTIFICADO';
            END IF;
        END LOOP;
        CLOSE c_datos;
        IF NOT v_encontro THEN
            cod_ret := '02';
            de_codret := 'NO EXISTE EL PAGO MÓVIL A CONSULTAR';
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            IF c_datos%ISOPEN THEN
                CLOSE c_datos;
            END IF;
            cod_ret := '99';
            de_codret := 'ERROR: ' || SQLERRM;
    END PR_SEARCH_PAGO_MOVIL;
          
    PROCEDURE PR_SUB_MENU_PORTAL(
        P_USERNAME   IN  VARCHAR2,
        COD_RET      OUT NUMBER,
        DE_CODRET    OUT VARCHAR2,
        P_RESULTADOS OUT SYS_REFCURSOR
    ) IS
        V_COUNT NUMBER := 0;
    BEGIN
        SELECT COUNT(1)
          INTO V_COUNT
          FROM USERS_PORTAL USP
          INNER JOIN USERS_MANAGEMENT_PORTAL UMP
            ON USP.ID = UMP.ID_USERS_PORTAL
          INNER JOIN MANAGEMENT_PORTAL MP
            ON UMP.ID_MANAGEMENT_PORTAL = MP.ID
          INNER JOIN USERS_MANAGEMENT_SUB_MENU_PORTAL UMSP
            ON UMP.ID = UMSP.ID_USERS_MANAGEMENT_PORTAL
          INNER JOIN SUB_MENU_PORTAL SBP
            ON SBP.ID = UMSP.ID_SUB_MENU_PORTAL
          INNER JOIN USERS_MANAGEMENT_SUB_MENU_PRIVILEGES_PORTAL UMSPP
            ON UMSPP.ID_USERS_MANAGEMENT_SUB_MENU = UMSP.ID
          INNER JOIN PRIVILEGES_PORTAL PP
            ON UMSPP.ID_PRIVILEGES_PORTAL = PP.ID
          INNER JOIN MENU_PORTAL MPL
            ON MPL.ID = SBP.ID_MENU_PORTAL
         WHERE USP.USERNAME = P_USERNAME; 
    
        IF V_COUNT = 0 THEN
            COD_RET   := 204;
            DE_CODRET := 'USUARIO NO TIENE MENU ASIGNADO';
            RETURN;
        END IF;
        OPEN P_RESULTADOS FOR
            SELECT MPL.MENU_NAME,
                   SBP.SUB_MENU_NAME,
                   SBP.SUB_MENU_ROUTE,
                   PP.PRIVILEGE_NAME
              FROM USERS_PORTAL USP
              INNER JOIN USERS_MANAGEMENT_PORTAL UMP
                ON USP.ID = UMP.ID_USERS_PORTAL
              INNER JOIN MANAGEMENT_PORTAL MP
                ON UMP.ID_MANAGEMENT_PORTAL = MP.ID
              INNER JOIN USERS_MANAGEMENT_SUB_MENU_PORTAL UMSP
                ON UMP.ID = UMSP.ID_USERS_MANAGEMENT_PORTAL
              INNER JOIN SUB_MENU_PORTAL SBP
                ON SBP.ID = UMSP.ID_SUB_MENU_PORTAL
              INNER JOIN USERS_MANAGEMENT_SUB_MENU_PRIVILEGES_PORTAL UMSPP
                ON UMSPP.ID_USERS_MANAGEMENT_SUB_MENU = UMSP.ID
              INNER JOIN PRIVILEGES_PORTAL PP
                ON UMSPP.ID_PRIVILEGES_PORTAL = PP.ID
              INNER JOIN MENU_PORTAL MPL
                ON MPL.ID = SBP.ID_MENU_PORTAL
             WHERE USP.USERNAME = P_USERNAME   
             ORDER BY MPL.MENU_NAME DESC;
    
        COD_RET   := 1000;
        DE_CODRET := 'MENU EXITOSO';
    END PR_SUB_MENU_PORTAL;
    
    PROCEDURE PR_USER_SUB_MENU_PORTAL (
        p_resultados OUT SYS_REFCURSOR
    ) IS 
    BEGIN
      OPEN p_resultados FOR
        SELECT 
          u.username, 
          mp.management_name, 
          sm.sub_menu_name
        FROM 
          users_portal u
        INNER JOIN 
          users_management_portal ump ON ump.id_users_portal = u.id
        INNER JOIN 
          management_portal mp ON mp.id = ump.id_management_portal
        INNER JOIN 
          users_management_sub_menu_portal umsm ON umsm.id_users_management_portal = ump.id
        INNER JOIN 
          sub_menu_portal sm ON sm.id = umsm.id_sub_menu_portal;
    EXCEPTION
      WHEN OTHERS THEN
        IF p_resultados%ISOPEN THEN
          CLOSE p_resultados;
        END IF;
        RAISE;
    END PR_USER_SUB_MENU_PORTAL;
    
     PROCEDURE PR_CREAR_USUARIO(
            P_USERNAME      IN VARCHAR2,
            P_ID_STATUS     IN NUMBER,
            P_ID_ROLE       IN NUMBER,
            P_FULLNAME      IN VARCHAR2,
            P_ID_MANAGEMENT IN NUMBER,
            P_ID_SUB_MENU   IN NUMBER,
            P_PRIVILEGES_STR IN VARCHAR2,
            P_COD_RET       OUT VARCHAR2, 
            P_DE_CODRET     OUT VARCHAR2
        ) IS 
            V_ID_USER        NUMBER;
            V_ID_USER_MGMT   NUMBER;
            V_ID_MGMT_SUBMAP NUMBER;
            V_PRIVILEGE      NUMBER;
            V_TEMP_STR       VARCHAR2(200) := P_PRIVILEGES_STR || ',';
            V_COUNT          NUMBER;
        BEGIN
            SELECT COUNT(1) INTO V_COUNT FROM USERS_PORTAL WHERE USERNAME = P_USERNAME;
            
            IF V_COUNT > 0 THEN
                P_COD_RET   := '01';
                P_DE_CODRET := 'El usuario ' || P_USERNAME || ' ya se encuentra registrado.';
            ELSE
            
                INSERT INTO USERS_PORTAL (USERNAME, ID_STATUS_PORTAL, ID_ROLE_PORTAL, FULL_NAME) 
                VALUES (P_USERNAME, P_ID_STATUS, P_ID_ROLE, P_FULLNAME);
                SELECT MAX(ID) INTO V_ID_USER FROM USERS_PORTAL;
        
            
                INSERT INTO USERS_MANAGEMENT_PORTAL (ID_USERS_PORTAL, ID_MANAGEMENT_PORTAL) 
                VALUES (V_ID_USER, P_ID_MANAGEMENT);
                SELECT MAX(ID) INTO V_ID_USER_MGMT FROM USERS_MANAGEMENT_PORTAL;
        
            
                INSERT INTO USERS_MANAGEMENT_SUB_MENU_PORTAL (ID_USERS_MANAGEMENT_PORTAL, ID_SUB_MENU_PORTAL) 
                VALUES (V_ID_USER_MGMT, P_ID_SUB_MENU);
                SELECT MAX(ID) INTO V_ID_MGMT_SUBMAP FROM USERS_MANAGEMENT_SUB_MENU_PORTAL;
        
            
                WHILE INSTR(V_TEMP_STR, ',') > 0 LOOP
                    V_PRIVILEGE := TO_NUMBER(SUBSTR(V_TEMP_STR, 1, INSTR(V_TEMP_STR, ',') - 1));
                    INSERT INTO USERS_MANAGEMENT_SUB_MENU_PRIVILEGES_PORTAL (ID_USERS_MANAGEMENT_SUB_MENU, ID_PRIVILEGES_PORTAL) 
                    VALUES (V_ID_MGMT_SUBMAP, V_PRIVILEGE);
                    V_TEMP_STR := SUBSTR(V_TEMP_STR, INSTR(V_TEMP_STR, ',') + 1);
                END LOOP;
        
                COMMIT;
                P_COD_RET   := '00';
                P_DE_CODRET := 'Usuario creado exitosamente';
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK;
                P_COD_RET   := '99';
                P_DE_CODRET := 'Error técnico: ' || SQLERRM;
        END PR_CREAR_USUARIO;
    
    PROCEDURE PR_ELIMINAR_USUARIO_ACCESOS(
        P_USERNAME   IN VARCHAR2,
        P_COD_RET    OUT VARCHAR2,
        P_DE_CODRET  OUT VARCHAR2
    ) IS
        V_ID_USER NUMBER;
    BEGIN
        P_COD_RET   := '00';
        P_DE_CODRET := 'ÉXITO';
    
        BEGIN
            SELECT ID INTO V_ID_USER
            FROM USERS_PORTAL
            WHERE USERNAME = P_USERNAME;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                P_COD_RET   := '01';
                P_DE_CODRET := 'EL USUARIO NO EXISTE';
                RETURN;
        END;
    
        DELETE FROM USERS_MANAGEMENT_SUB_MENU_PRIVILEGES_PORTAL
        WHERE ID_USERS_MANAGEMENT_SUB_MENU IN (
            SELECT SUB.ID 
            FROM USERS_MANAGEMENT_SUB_MENU_PORTAL SUB
            JOIN USERS_MANAGEMENT_PORTAL MGMT ON SUB.ID_USERS_MANAGEMENT_PORTAL = MGMT.ID
            WHERE MGMT.ID_USERS_PORTAL = V_ID_USER
        );
    
        DELETE FROM USERS_MANAGEMENT_SUB_MENU_PORTAL
        WHERE ID_USERS_MANAGEMENT_PORTAL IN (
            SELECT ID FROM USERS_MANAGEMENT_PORTAL WHERE ID_USERS_PORTAL = V_ID_USER
        );
    
        DELETE FROM USERS_MANAGEMENT_PORTAL
        WHERE ID_USERS_PORTAL = V_ID_USER;
    
        DELETE FROM USERS_PORTAL
        WHERE ID = V_ID_USER;
    
        COMMIT;
    
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            P_COD_RET   := '99';
            P_DE_CODRET := 'ERROR AL ELIMINAR ACCESOS: ' || SQLERRM;
    END PR_ELIMINAR_USUARIO_ACCESOS;
    
    PROCEDURE PR_LISTAR_USUARIOS_PERMISOS (
        p_resultados OUT SYS_REFCURSOR
    ) IS 
    BEGIN
        OPEN p_resultados FOR
            SELECT 
                u.username, u.full_name, mp.management_name, sp.status, mep.menu_name, sm.sub_menu_name, pp.privilege_name
            FROM 
                users_portal u
            INNER JOIN users_management_portal ump ON ump.id_users_portal = u.id
            INNER JOIN status_portal sp ON sp.id = u.id_status_portal
            INNER JOIN management_portal mp ON mp.id = ump.id_management_portal
            INNER JOIN users_management_sub_menu_portal umsm ON umsm.id_users_management_portal = ump.id
            INNER JOIN sub_menu_portal sm ON sm.id = umsm.id_sub_menu_portal
            INNER JOIN menu_portal mep ON mep.id = sm.id_menu_portal
            INNER JOIN users_management_sub_menu_privileges_portal umsmpp ON umsmpp.id_users_management_sub_menu = umsm.id
            INNER JOIN privileges_portal pp ON pp.id = umsmpp.id_privileges_portal
            ORDER BY u.username ASC, mep.menu_name ASC, sm.sub_menu_name ASC;
    EXCEPTION
        WHEN OTHERS THEN
            IF p_resultados%ISOPEN THEN
                CLOSE p_resultados;
            END IF;
            RAISE;
    END PR_LISTAR_USUARIOS_PERMISOS;
    
  PROCEDURE PR_LISTAR_GERENCIAS (
        P_RESULTADOS OUT SYS_REFCURSOR
    ) AS
    BEGIN
    
        OPEN P_RESULTADOS FOR
            SELECT 
                ID AS id_management,
                MANAGEMENT_NAME AS management_name
            FROM 
                MANAGEMENT_PORTAL
            ORDER BY 
                MANAGEMENT_NAME ASC;
    
    EXCEPTION
        WHEN OTHERS THEN
            OPEN P_RESULTADOS FOR 
                SELECT 0 AS id_management, 'ERROR AL CARGAR GERENCIAS' AS management_name FROM DUAL;
    END PR_LISTAR_GERENCIAS;
    
    PROCEDURE PR_LISTAR_STATUS_USUARIOS (
        P_RESULTADOS OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN P_RESULTADOS FOR
            SELECT ID AS ID_STATUS, STATUS FROM STATUS_PORTAL ORDER BY ID ASC;
        EXCEPTION
            WHEN OTHERS THEN
                OPEN P_RESULTADOS FOR
                    SELECT 0 AS ID_STATUS, 'ERROR AL CARGAR ESTATUS' AS STATUS FROM DUAL;
    END   PR_LISTAR_STATUS_USUARIOS;
    
    PROCEDURE PR_LISTAR_ROLES (
        P_RESULTADOS OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN P_RESULTADOS FOR
            SELECT ID AS ID_ROL, ROLE FROM ROLE_PORTAL ORDER BY ID ASC;
        EXCEPTION
            WHEN OTHERS THEN
                OPEN P_RESULTADOS FOR
                    SELECT 0 AS ID_ROL, 'ERROR AL CARGAR ROLES' AS ROLE_PORTAL FROM DUAL;
    END   PR_LISTAR_ROLES;

    PROCEDURE PR_LISTAR_PRIVILEGES (
        P_RESULTADOS OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN P_RESULTADOS FOR
            SELECT ID AS ID_PRIVILGES, PRIVILEGE_NAME FROM PRIVILEGES_PORTAL ORDER BY ID ASC;
        EXCEPTION
            WHEN OTHERS THEN
                OPEN P_RESULTADOS FOR
                    SELECT 0 AS ID_PRIVILGES, 'ERROR AL CARGAR PRIVILEGES' AS PRIVILEGE_NAME FROM DUAL;
    END   PR_LISTAR_PRIVILEGES;   
    
    
    PROCEDURE PR_CONSULTA_REENVIO (
        p_fecsys     IN VARCHAR2, 
        p_idcomercio IN VARCHAR2,
        t_count      OUT NUMBER,
        COD_RET      OUT VARCHAR2,
        DE_CODRET    OUT VARCHAR2,
        cur          OUT SYS_REFCURSOR
    ) AS
        v_inicio_hoy    DATE := TRUNC(SYSDATE);
        v_inicio_manana DATE := TRUNC(SYSDATE + 1);
        v_fecha_filtro  DATE;
        v_received      NUMBER := 0; 
    BEGIN
        IF p_fecsys IS NOT NULL THEN
            v_fecha_filtro := TO_DATE(p_fecsys, 'DD/MM/YYYY');
            v_inicio_hoy   := v_fecha_filtro;
            v_inicio_manana:= v_fecha_filtro + 1;
        END IF;
    
        SELECT COUNT(1)
        INTO t_count
        FROM apimovconci
        WHERE received = v_received
          AND (idcomercio = p_idcomercio OR p_idcomercio IS NULL)
          AND fecha >= v_inicio_hoy
          AND fecha < v_inicio_manana;

        OPEN cur FOR
            SELECT *
            FROM apimovconci
            WHERE received = v_received
              AND (idcomercio = p_idcomercio OR p_idcomercio IS NULL)
              AND fecha >= v_inicio_hoy
              AND fecha < v_inicio_manana;
        
        COD_RET   := '00';
        DE_CODRET := 'EXITOSO';
        
    EXCEPTION
        WHEN OTHERS THEN
            COD_RET   := '99';
            DE_CODRET := 'ERROR: ' || SQLERRM;
            t_count   := 0;
    END PR_CONSULTA_REENVIO;

END PKG_CONSULTA_AFILIACION;
/
