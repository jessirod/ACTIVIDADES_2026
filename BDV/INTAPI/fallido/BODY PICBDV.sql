CREATE OR REPLACE PACKAGE BODY PICBDV.PKG_API_TRANSFERENCIA AS

PROCEDURE GET_SERIALES_BANCARIOS(
    p_tipo_documento_emisor IN VARCHAR2,
    p_tipo_documento_receptor IN VARCHAR2,
    p_siglas IN VARCHAR2,
    p_serial OUT VARCHAR2,
    p_serial_debito OUT VARCHAR2,
    p_serial_credito OUT VARCHAR2,
    p_usuarioBus OUT VARCHAR2,
    p_canal OUT VARCHAR2,
    p_subApiconci OUT VARCHAR2,
    p_nombreApi OUT VARCHAR2,
    p_clase_transferencia OUT VARCHAR2,
    p_cod_ret OUT VARCHAR2,
    p_des_ret OUT VARCHAR2
) AS
    v_count NUMBER;
    v_siglas VARCHAR2(3);
BEGIN  



    SELECT COUNT(DISTINCT 1)
        INTO v_count
        FROM SUB_APICONCI SUBA
        INNER JOIN API_TRF_SERIALES_SERV TRF
        ON SUBA.ID_SUB_APICONCI = TRF.ID_SUB_APICONCI
        WHERE TRF.TIPO_DOCUMENTO_EMISOR = p_tipo_documento_emisor
        AND TRF.TIPO_DOCUMENTO_RECEPTOR = p_tipo_documento_receptor
        AND SUBA.SIGLAS = p_siglas;
        
        dbms_output.put_line('API KEY CONTADOR: ' || v_count);
        
    IF v_count = 0 THEN
        p_cod_ret := '1001';
        p_des_ret := 'No se encontro el serial para el tipo de transferencia.';
    ELSE    
            SELECT DISTINCT 
                TRF.SERIAL,
                TRF.SERIAL_DEBITO,
                TRF.SERIAL_CREDITO,
                CAN.USUARIO_BUS,
                CAN.CANAL,
                SUBA.SUB_APICONCI,
                CAN.DESCRIPCION,
                SUBA.CLASE_TRANSFERENCIA
            INTO 
                p_serial, 
                p_serial_debito, 
                p_serial_credito,
                p_usuarioBus,
                p_canal,
                p_subApiconci,                
                p_nombreApi,
                p_clase_transferencia
            FROM SUB_APICONCI SUBA
            INNER JOIN API_TRF_SERIALES_SERV TRF
            ON SUBA.ID_SUB_APICONCI = TRF.ID_SUB_APICONCI
            INNER JOIN API_TRF_CANALES_SERV CAN
            ON CAN.ID_CANAL = TRF.ID_CANAL
            WHERE TRF.TIPO_DOCUMENTO_EMISOR = p_tipo_documento_emisor 
            AND TRF.TIPO_DOCUMENTO_RECEPTOR = p_tipo_documento_receptor 
            AND SUBA.SIGLAS = p_siglas;           
        p_cod_ret := '1000';
        p_des_ret := 'Consulta exitosa.';
    END IF;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_serial := NULL;
        p_serial_debito := NULL;
        p_serial_credito := NULL;
        p_usuarioBus := NULL;
        p_canal := NULL;
        p_subApiconci := NULL;
        p_nombreApi := NULL;
        p_cod_ret := '1001';
        p_des_ret := 'No se encontro serial datos proporcionados. '|| SQLERRM;
    
    WHEN OTHERS THEN
        -- Manejar otros errores
        p_serial := NULL;
        p_serial_debito := NULL;
        p_serial_credito := NULL;
        p_usuarioBus := NULL;
        p_canal := NULL;
        p_subApiconci := NULL;
        p_nombreApi := NULL;
        p_nombreApi := NULL;
        p_cod_ret := '1001';
        p_des_ret := 'Ocurrió un error inesperado: ' || SQLERRM;
END GET_SERIALES_BANCARIOS;


PROCEDURE EXISTE_RIF_MERCHANT_SERV (
    V_APIKey          IN  VARCHAR2,
    V_SIGLAS          IN VARCHAR2,
    V_CUENTAMERCHANT  OUT VARCHAR2,
    V_RIFMERCHANT     OUT VARCHAR2,
    V_TLFMERCHANT     OUT VARCHAR2,
    V_NOMBRE		  OUT VARCHAR2,	 
    V_TIPO_CONTROL    OUT VARCHAR2,
    V_CEDULA_RIF_CONTROL    OUT VARCHAR2,
    V_NUMERO_CUENTA_CONTROL    OUT VARCHAR2,
    V_ENCONTRADO      OUT INT,    
    V_COD_RET  OUT VARCHAR2,
    V_DES_RET OUT VARCHAR2
)IS

P_ID_MERCHANT VARCHAR2(50);
P_ENCONTRAR_SIGLAS NUMBER;
P_CONTAR NUMBER;
P_SIGLAS VARCHAR2(3);
P_CONTAR_SIGLA INT;

BEGIN

        SELECT COUNT(DISTINCT SUBA.SIGLAS)
        INTO P_CONTAR_SIGLA
        FROM API_TRF_CANALES_SERV CAN
        INNER JOIN API_TRF_SERIALES_SERV SER
        ON CAN.ID_CANAL = SER.ID_CANAL 
        INNER JOIN SUB_APICONCI SUBA
        ON SUBA.ID_SUB_APICONCI = SER.ID_SUB_APICONCI
        WHERE SUBA.SIGLAS = V_SIGLAS;

    IF P_CONTAR_SIGLA = 0 THEN
    
            V_CUENTAMERCHANT := NULL;
            V_RIFMERCHANT    := NULL;
            V_TLFMERCHANT    := NULL;
            V_NOMBRE		 := NULL;	 
            V_TIPO_CONTROL   := NULL;
            V_CEDULA_RIF_CONTROL := NULL;
            V_NUMERO_CUENTA_CONTROL := NULL;
            V_ENCONTRADO:=1;
            V_COD_RET := '98';
            V_DES_RET := 'Error el campo Tipo Transferencia no corresponde ';
            
    
    
    ELSE   
    
    
        SELECT COUNT(1) INTO P_CONTAR FROM picbdv.MERCHANT_OPERADOR WHERE MERCHANT_OPERADOR.API_KEY = V_APIKey;
            IF P_CONTAR = 0 THEN
            
                dbms_output.put_line('API KEY NO ENCONTRADO' || P_CONTAR);
                        V_CUENTAMERCHANT := NULL;
                        V_RIFMERCHANT    := NULL;
                        V_TLFMERCHANT    := NULL;
                        V_NOMBRE		 := NULL;	 
                        V_TIPO_CONTROL   := NULL;
                        V_CEDULA_RIF_CONTROL := NULL;
                        V_NUMERO_CUENTA_CONTROL := NULL;
                        V_ENCONTRADO:=0;
                        V_COD_RET := '1010';
                        V_DES_RET := 'Api-key Cliente no asociado';
            ELSE
            
                    SELECT MERCHANT_ID INTO P_ID_MERCHANT FROM picbdv.MERCHANT_OPERADOR WHERE MERCHANT_OPERADOR.API_KEY = V_APIKey;
            
                    SELECT COUNT(1)
                        INTO V_ENCONTRADO FROM CUENTA_CONTROL CC
                        INNER JOIN CC_SUB_APICONCI CSA
                        ON CC.ID_CCONTROL = CSA.ID_CCONTROL
                        INNER JOIN SUB_APICONCI SUBA
                        ON SUBA.ID_SUB_APICONCI = CSA.ID_SUB_APICONCI
                        WHERE MERCHANT_ID = P_ID_MERCHANT AND SUBA.SIGLAS = V_SIGLAS;
                        
                    dbms_output.put_line('valor de siglas' || V_SIGLAS);
                    dbms_output.put_line(' encontrado de V_ENCONTRADO: ' || V_ENCONTRADO);        
            
                     IF V_ENCONTRADO = 0 THEN
                    
                                    SELECT
                                        MO.NACIONALIDAD || MO.CEDULA_RIF ||  NVL(MO.DIGITO_VERIFICADOR, ''),
                                        MO.NUMERO_CUENTA,
                                        MO.TELEFONO_CLIENTE,
                                        MO.NOMBRE_MERCHANT,
                                        NULL,
                                        NULL,
                                        NULL
                                INTO
                                        V_RIFMERCHANT,
                                        V_CUENTAMERCHANT,
                                        V_TLFMERCHANT,
                                        V_NOMBRE,
                                        V_TIPO_CONTROL,
                                        V_CEDULA_RIF_CONTROL,
                                        V_NUMERO_CUENTA_CONTROL
                                FROM MERCHANT_OPERADOR MO
                                WHERE MO.MERCHANT_ID = P_ID_MERCHANT;
                                V_ENCONTRADO:=1; --ESTO ES PARA QUE EN P_ENCONTRADO DE API TRANSFE HAGA EL RECORRIDO
                                V_COD_RET := '1000';
                                V_DES_RET := 'Transferencia por Cuenta Financiera';    
                                
                    ELSE       
                            dbms_output.put_line('entrando en validacion de sigla y p_encontrado' );                  
                           
                                SELECT COUNT(1)
                                INTO V_ENCONTRADO FROM CUENTA_CONTROL CC
                                INNER JOIN CC_SUB_APICONCI CSA
                                ON CC.ID_CCONTROL = CSA.ID_CCONTROL
                                INNER JOIN SUB_APICONCI SUBA
                                ON SUBA.ID_SUB_APICONCI = CSA.ID_SUB_APICONCI
                                WHERE MERCHANT_ID = P_ID_MERCHANT AND SUBA.SIGLAS = V_SIGLAS;
                                
                                dbms_output.put_line('SERVICIO ENCONTRADO: ' || V_SIGLAS);
                                SELECT 
                                    MO.NACIONALIDAD || MO.CEDULA_RIF ||  NVL(MO.DIGITO_VERIFICADOR, ''),
                                    MO.NUMERO_CUENTA,
                                    MO.TELEFONO_CLIENTE,
                                    MO.NOMBRE_MERCHANT,    
                                    CLC.TIPO_CONTROL,
                                    CLC.CEDULA_RIF_C,
                                    CC.CUENTA_CONTROL                                    
                                INTO
                                    V_RIFMERCHANT,
                                    V_CUENTAMERCHANT,
                                    V_TLFMERCHANT,
                                    V_NOMBRE,
                                    V_TIPO_CONTROL,
                                    V_CEDULA_RIF_CONTROL,
                                    V_NUMERO_CUENTA_CONTROL                                    
                                FROM MERCHANT_OPERADOR MO
                                    INNER JOIN CUENTA_CONTROL CC
                                    ON CC.MERCHANT_ID = MO.MERCHANT_ID
                                    LEFT JOIN CLIENTE_CONTROL CLC
                                    ON CLC.ID_CLIENTE_C = CC.ID_CLIENTE_C
                                    INNER JOIN CC_SUB_APICONCI CC_SUB
                                    ON CC_SUB.ID_CCONTROL = CC.ID_CCONTROL
                                    INNER JOIN SUB_APICONCI SUB
                                    ON SUB.ID_SUB_APICONCI = CC_SUB.ID_SUB_APICONCI
                                WHERE MO.API_KEY = V_APIKey AND SUB.SIGLAS = V_SIGLAS;
                                V_COD_RET := '1000';
                                V_DES_RET := 'Transferencia por Cuenta Control';                                         
        END IF;
        END IF;  
        END IF;
      

        EXCEPTION WHEN NO_DATA_FOUND THEN
            V_CUENTAMERCHANT := NULL;
            V_RIFMERCHANT    := NULL;
            V_TLFMERCHANT    := NULL;
            V_NOMBRE		 := NULL;	 
            V_TIPO_CONTROL   := NULL;
            V_CEDULA_RIF_CONTROL := NULL;
            V_NUMERO_CUENTA_CONTROL := NULL;
            V_ENCONTRADO:=0;
            V_COD_RET := '99';
            V_DES_RET := 'Error inesperado '|| SQLERRM;
   
END EXISTE_RIF_MERCHANT_SERV;



PROCEDURE PR_INSERTAR_TRANSFERENCIA (
              PID_APICONCI       IN  NUMBER,
              PBANCOCLIENTE      IN  VARCHAR2,
              PIDCLIENTE         IN  VARCHAR2,
              PNUMEROCLIENTE     IN  VARCHAR2,
              PIDCOMERCIO        IN  VARCHAR2,
              PNUMEROCOMERCIO    IN  VARCHAR2,
              PCODIGOMONEDA      IN  VARCHAR2,
              PMONTO             IN  NUMBER,
              PESTATUS           IN  VARCHAR2,
              POBS               IN  VARCHAR2,
              PESTADO            IN  VARCHAR2,
              PRESPUESTADCS      IN  VARCHAR2,
              PRESPUESTAMEGASOFT IN  VARCHAR2,  
              PREFERENCIA        IN  VARCHAR2,
              PCTA_ORDENANTE     IN  VARCHAR2,
              PCTA_DESTINO       IN  VARCHAR2,
              PNOTIFICACION      IN  CLOB,
              PURL				 IN  VARCHAR2,
              PHEADER		     IN  VARCHAR2,
              P_API_KEY 		 IN  VARCHAR2,
              COD_RET            OUT VARCHAR2,
              DE_CODRET          OUT VARCHAR2
            
              ) IS
            
            BEGIN
            insert INTO APIMOVCONCI
            (
              ID_APICONCI,
              BANCOCLIENTE,
              IDCLIENTE,
              NUMEROCLIENTE,
              IDCOMERCIO,
              NUMEROCOMERCIO,
              CODIGOMONEDA,
              MONTO,
              FECSYS,
              HORA,
              ESTATUS,
              OBS,
              ESTADO,
              RESPUESTADCS,
              RESPUESTA_SNP_CLIENTE,  
              REFERENCIA,
              CTA_ORDENANTE,
              CTA_DESTINO,
              NOTIFICACION,
              URL,
              HEADER,
              API_KEY
            )
            VALUES (
              PID_APICONCI,
              PBANCOCLIENTE,
              PIDCLIENTE,
              PNUMEROCLIENTE,
              PIDCOMERCIO,
              PNUMEROCOMERCIO,
              PCODIGOMONEDA,
              PMONTO,
              TO_CHAR(SYSDATE, 'DD/MM/YYYY'),
              TO_CHAR(CURRENT_TIMESTAMP, 'HH24:MI:SS'),
              PESTATUS,
              POBS,
              PESTADO,
              PRESPUESTADCS,
              PRESPUESTAMEGASOFT,  
              PREFERENCIA,
              PCTA_ORDENANTE,
              PCTA_DESTINO,
              PNOTIFICACION,
              PURL,
              PHEADER,
              P_API_KEY
              );
              
              COMMIT;
              COD_RET :='00';
              DE_CODRET := 'Registro de operación realizada exitosamente';
              
              EXCEPTION
                WHEN OTHERS THEN
                  COD_RET :='99';
                  DE_CODRET := SUBSTR(SQLERRM,0,100);
              -- DE_CODRET := 'Falla en el registro de Operación';
              -- ROLLBACK;
END PR_INSERTAR_TRANSFERENCIA;


PROCEDURE PR_INSERTAR_END_TO_END (
    V_CEDULA_RIF IN VARCHAR2,
    V_END_TO_END IN VARCHAR2,
    V_REFERENCIA IN VARCHAR2,
    V_COD_RET   OUT VARCHAR2,
    V_DE_CODRET OUT VARCHAR2
  
  ) AS
  BEGIN

    INSERT INTO PAGOS_END_TO_END(END_TO_END, CEDULA_RIF,REFERENCIA) 
    VALUES(V_END_TO_END, V_CEDULA_RIF,V_REFERENCIA);
    
    COMMIT;    
    -- Si la inserción fue exitosa, retornar 00
    V_COD_RET := '00';
    V_DE_CODRET := 'Inserción exitosa';
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        V_COD_RET := '99';
        V_DE_CODRET := 'Error inesperado: ' || SQLERRM;
  END PR_INSERTAR_END_TO_END;


END PKG_API_TRANSFERENCIA;
/
