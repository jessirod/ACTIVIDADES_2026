DROP TRIGGER PICBDV.MERCANT_OPERATOR_TGG;

CREATE OR REPLACE TRIGGER PICBDV.MERCANT_OPERATOR_TGG
BEFORE INSERT
ON PICBDV.MERCHANT_OPERADOR
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE
tmpVar NUMBER;
/******************************************************************************
   NAME:       
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        18/4/2023      CT24504       1. Created this trigger.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     
      Sysdate:         18/4/2023
      Date and Time:   18/4/2023, 10:22:03, and 18/4/2023 10:22:03
      Username:        CT24504 (set in TOAD Options, Proc Templates)
      Table Name:      MERCHANT_OPERADOR (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (set in the "New PL/SQL Object" dialog)
******************************************************************************/
BEGIN
   tmpVar := 0;

   :New.API_KEY := hash_key(TO_CHAR(:New.CEDULA_RIF)||:New.NOMBRE_MERCHANT||:New.NUMERO_CUENTA);
   :New.FECHA_CREACION := SYSDATE;
   --:New.USUARIO_CANAL := 'FINTECH';
   --:NEW.STATUS := 'A';

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END ;
/
