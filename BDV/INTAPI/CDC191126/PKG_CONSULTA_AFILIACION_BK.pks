CREATE OR REPLACE PACKAGE PICBDV.PKG_CONSULTA_AFILIACION AS

    PROCEDURE PR_SEARCH_DASHBOARD(
        p_single OUT SYS_REFCURSOR
    );
    
    PROCEDURE PR_GET_TOTAL_RECONCILED_PAYMENTS(
        p_total OUT NUMBER
    );
    
    PROCEDURE PR_GET_TOTAL_NOTIFIED_PAYMENTS(
        p_total OUT NUMBER
    );
    PROCEDURE PR_GET_TOTAL_NOT_NOTIFIED_PAYMENTS(
        p_total OUT NUMBER
    );
    
    PROCEDURE PR_GET_TOTAL_TRANSACTIONS_PROCESSED(
        p_total OUT NUMBER
    );
    
    PROCEDURE PR_SEARCH_DASHBOARD_ERRORES (
        p_errors OUT SYS_REFCURSOR
    );
    
    PROCEDURE PR_GET_TOTAL_ERROR_99 (
        p_result OUT SYS_REFCURSOR
    );
    
    PROCEDURE PR_VALIDATE_USER_LDAP_PORTAL(
        P_USERNAME   IN  VARCHAR2,
        COD_RET      OUT NUMBER,
        DE_CODRET    OUT VARCHAR2,
        P_RESULTADOS OUT SYS_REFCURSOR
    );
    
    PROCEDURE PR_ACTUALIZAR_URL_CLIENTE (
        p_merchant_id   IN  VARCHAR2,
        p_url           IN  VARCHAR2,
        p_cod_ret       OUT VARCHAR2,
        p_de_codret     OUT VARCHAR2
    );
    
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
    );
    
    PROCEDURE PR_DESAFILIAR_MERCHANT_CONNECTIONS (
        p_merchant_id IN  VARCHAR2,
        p_codigo      OUT VARCHAR2,
        p_mensaje     OUT VARCHAR2
    );
    
    PROCEDURE PR_GET_POD_TOTAL (
        p_ids_apiconci IN VARCHAR2,
        p_total_pods OUT SYS_REFCURSOR,
        p_status OUT SYS_REFCURSOR
    );
    
    PROCEDURE PR_LISTAR_INTEGRADORAS_ACTIVAS (
      p_result OUT SYS_REFCURSOR
    );
    
    PROCEDURE PR_REGISTRAR_MERCHANT_CONNECTIONS (
        p_merchant_id   IN  VARCHAR2,
        p_url           IN  VARCHAR2,
        p_obs           IN  VARCHAR2, 
        p_api_key       IN  VARCHAR2,
        p_api_key_hdr   IN  VARCHAR2,
        p_cod_ret       OUT VARCHAR2,
        p_de_codret     OUT VARCHAR2
    );
    
    PROCEDURE pr_search_pago_movil(
        p_referencia IN VARCHAR2,
        p_fecha IN VARCHAR2, -- formato 'DD/MM/YYYY'
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
    );
    
    PROCEDURE PR_SUB_MENU_PORTAL(
        P_USERNAME   IN  VARCHAR2,
        COD_RET      OUT NUMBER,
        DE_CODRET    OUT VARCHAR2,
        P_RESULTADOS OUT SYS_REFCURSOR
    );
    
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
    );
    
     PROCEDURE PR_ELIMINAR_USUARIO_ACCESOS(
        P_USERNAME   IN VARCHAR2,
        P_COD_RET    OUT VARCHAR2,
        P_DE_CODRET  OUT VARCHAR2
    );
    
    PROCEDURE PR_LISTAR_USUARIOS_PERMISOS (
        p_resultados OUT SYS_REFCURSOR
    );
    
    PROCEDURE PR_LISTAR_GERENCIAS (
        P_RESULTADOS OUT SYS_REFCURSOR
    );
    
     PROCEDURE PR_LISTAR_STATUS_USUARIOS (
        P_RESULTADOS OUT SYS_REFCURSOR
    );
    
     PROCEDURE PR_LISTAR_ROLES (
        P_RESULTADOS OUT SYS_REFCURSOR
    );
    
    PROCEDURE PR_LISTAR_PRIVILEGES (
        P_RESULTADOS OUT SYS_REFCURSOR
    );
    
     PROCEDURE PR_CONSULTA_REENVIO (
        p_fecsys     IN VARCHAR2, 
        p_idcomercio IN VARCHAR2,
        t_count      OUT NUMBER,
        COD_RET      OUT VARCHAR2,
        DE_CODRET    OUT VARCHAR2,
        cur          OUT SYS_REFCURSOR
    );

END PKG_CONSULTA_AFILIACION;
/
