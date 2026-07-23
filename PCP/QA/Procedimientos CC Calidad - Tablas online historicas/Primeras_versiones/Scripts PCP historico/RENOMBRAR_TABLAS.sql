CREATE OR REPLACE PROCEDURE PCP.RENOMBRAR_TABLAS IS
    v_step        VARCHAR2(100);
    v_invalid_cnt NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('===========================================');
    DBMS_OUTPUT.PUT_LINE('INICIANDO RENOMBRADO DE TABLAS');
    DBMS_OUTPUT.PUT_LINE('===========================================');


    -- Renombrar originales a _OLD (hijos primero)
    v_step := 'Renombrando tablas originales a _OLD';
    DBMS_OUTPUT.PUT_LINE(v_step || '...');

    EXECUTE IMMEDIATE 'ALTER TABLE credits_credito_inmediato RENAME TO credits_credito_inmediato_old';
    DBMS_OUTPUT.PUT_LINE('  credits_credito_inmediato -> credits_credito_inmediato_old');
    
    EXECUTE IMMEDIATE 'ALTER TABLE debits RENAME TO credits_old';
    DBMS_OUTPUT.PUT_LINE('  credits -> credits_old');
    
    EXECUTE IMMEDIATE 'ALTER TABLE debits RENAME TO debits_old';
    DBMS_OUTPUT.PUT_LINE('  debits -> debits_old');
    
    EXECUTE IMMEDIATE 'ALTER TABLE track_orden RENAME TO track_orden_old';
    DBMS_OUTPUT.PUT_LINE('  track_orden -> track_orden_old');
    
    EXECUTE IMMEDIATE 'ALTER TABLE orden_detail RENAME TO orden_detail_old';
    DBMS_OUTPUT.PUT_LINE('  orden_detail -> orden_detail_old');
    
    EXECUTE IMMEDIATE 'ALTER TABLE orden RENAME TO orden_old';
    DBMS_OUTPUT.PUT_LINE('  orden -> orden_old');

    -- Renombrar _NEW a producción (padres primero)
    v_step := 'Renombrando tablas _NEW a producción';
    DBMS_OUTPUT.PUT_LINE(v_step || '...');

    EXECUTE IMMEDIATE 'ALTER TABLE orden_new RENAME TO orden';
    DBMS_OUTPUT.PUT_LINE('  orden_new -> orden');
    
    EXECUTE IMMEDIATE 'ALTER TABLE orden_detail_new RENAME TO orden_detail';
    DBMS_OUTPUT.PUT_LINE('  orden_detail_new -> orden_detail');
    
    EXECUTE IMMEDIATE 'ALTER TABLE debits_new RENAME TO debits';
    DBMS_OUTPUT.PUT_LINE('  debits_new -> debits');
    
    EXECUTE IMMEDIATE 'ALTER TABLE track_orden_new RENAME TO track_orden';
    DBMS_OUTPUT.PUT_LINE('  track_orden_new -> track_orden');
    
    EXECUTE IMMEDIATE 'ALTER TABLE credits_new RENAME TO credits';
    DBMS_OUTPUT.PUT_LINE('  credits_new -> credits');    
    
    EXECUTE IMMEDIATE 'ALTER TABLE credits_credito_inmediato_new RENAME TO credits_credito_inmediato';
    DBMS_OUTPUT.PUT_LINE('  credits_credito_inmediato_new -> credits_credito_inmediato');


    DBMS_OUTPUT.PUT_LINE('===========================================');
    DBMS_OUTPUT.PUT_LINE('RENOMBRADO COMPLETADO EXITOSAMENTE');
    DBMS_OUTPUT.PUT_LINE('===========================================');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR en paso: ' || v_step);
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLERRM);
        RAISE;
END RENOMBRAR_TABLAS;
/