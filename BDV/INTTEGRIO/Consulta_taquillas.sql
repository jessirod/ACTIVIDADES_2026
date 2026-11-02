Consultas Taquillas 

*********************************************************************************************
Taquillas_Activas_Inttegrio
*********************************************************************************************

SET LINES 180 PAGES 300
BREAK ON REPORT
COMPUTE SUM LABEL "TOTAL :" OF CANTIDAD ON REPORT
SELECT
      CUSUARIO
    , CTERMINAL 
    , COUNT(1) CANTIDAD
FROM INTTEGRIOBDV.TUSUARIOSESIONES 
WHERE FHASTA = TIMESTAMP '2999-12-31 00:00:00.0' 
GROUP BY CUSUARIO, CTERMINAL
ORDER BY CTERMINAL;
CLEAR BREAK


*********************************************************************************************
Conteo_Total_Taquillas_Activas_Inttegrio
*********************************************************************************************
SET LINES 180 PAGES 300
BREAK ON REPORT
COMPUTE SUM LABEL "TOTAL :" OF CANTIDAD ON REPORT
SELECT
      SUBSTR(CTERMINAL,0,3) CTERMINAL
    , COUNT(1) CANTIDAD
FROM INTTEGRIOBDV.TUSUARIOSESIONES 
WHERE FHASTA = TIMESTAMP '2999-12-31 00:00:00.0' 
GROUP BY SUBSTR(CTERMINAL ,0,3)
ORDER BY 1;
CLEAR BREAK
CLEAR COMPUTE


--*********************************************************************************************
--Conteo_Taquillas_Activas_Inttegrio
--*********************************************************************************************
--set pages 30
--SELECT COUNT(1),  SUBSTR(CTERMINAL,0,3) CTERMINAL
--FROM INTTEGRIOBDV.TUSUARIOSESIONES 
--WHERE FHASTA = TIMESTAMP '2999-12-31 00:00:00.0' 
--GROUP BY SUBSTR(CTERMINAL ,0,3)
--ORDER BY 2 ;
--
--*********************************************************************************************
--Total_Taquillas_Inttegrio
--*********************************************************************************************
--SELECT COUNT(1)
--FROM INTTEGRIOBDV.TUSUARIOSESIONES 
--WHERE FHASTA = TIMESTAMP '2999-12-31 00:00:00.0' ;


