CREATE OR REPLACE PROCEDURE PCP.migracion_automatica_diaria IS
    v_out VARCHAR2(4000);
BEGIN
    PCP.MANTENIMIENTO_TABLAS_PCP_HIST_PKG.MANTENIMIENTO_PCP_HIST_DIARIO(
        P_MONTHS_RETENTION_H => NULL,   -- NULL para que tome el valor de PARAMETROS_PCP o 12 por defecto
        P_OUT_DATA          => v_out,
        P_ID_ORDEN          => NULL,
        P_START_DATE        => NULL,
        P_END_DATE          => NULL
    );
END migracion_automatica_diaria;
/