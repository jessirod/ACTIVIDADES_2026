CREATE OR REPLACE PROCEDURE PCP.GET_LIST_COMISIONES(
p_tipo_mondeda IN VARCHAR2,
p_out_data OUT SYS_REFCURSOR,
COD_RET OUT VARCHAR2,
DE_CODRET OUT VARCHAR2
)
is
V_NO_DATOS EXCEPTION;
V_NO_PRODUTO EXCEPTION;
V_TIPO_PRODUCTO VARCHAR(3);
BEGIN

    IF UPPER(p_tipo_mondeda) = 'PAYROLL' THEN
        V_TIPO_PRODUCTO:= '10';
    ELSIF UPPER(p_tipo_mondeda) = 'PROVIDER' THEN 
        V_TIPO_PRODUCTO:= '40';
    ELSIF UPPER(p_tipo_mondeda) = 'CURRENCY' THEN 
        V_TIPO_PRODUCTO:= '50';
    ELSE
        RAISE V_NO_PRODUTO;
    END IF;

        BEGIN
           OPEN p_out_data FOR SELECT  c.commission_conf_id id, INITCAP(LOWER(c.banca)) banca, 
            INITCAP(LOWER(c.tipo_cobro)) tipo, c.valor, c.descripcion, c.frecuencia, c.tipo_pago 
            FROM commission_conf c
            WHERE C.TIPO_PAGO = V_TIPO_PRODUCTO
            ORDER BY BANCA ASC;

            COD_RET := '1000';
            DE_CODRET :='CONSULTA EXITOSA';
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            RAISE V_NO_DATOS;
        END;

    EXCEPTION 
    WHEN V_NO_DATOS THEN
    COD_RET := '9997';
    DE_CODRET :='DATOS NO ENCONTRADOS EN LA TABLA CONFIGURACION DE COMISIONES';
    OPEN p_out_data FOR SELECT  '' id, '' banca, '' tipo, '' valor, '' descripcion, '' frecuencia, '' tipo_pago from dual;
    WHEN V_NO_PRODUTO THEN
    COD_RET := '9998';
    DE_CODRET :='PRODUCTO NO RECONOCIDO PARA LOS PERFILES DE COMISIONES';
    OPEN p_out_data FOR SELECT  '' id, '' banca, '' tipo, '' valor, '' descripcion, '' frecuencia, '' tipo_pago from dual;
    WHEN OTHERS THEN
    COD_RET   := '9999';
    DE_CODRET := SUBSTR(SQLCODE || '  ' || SQLERRM, 1, 100);
END;

/
