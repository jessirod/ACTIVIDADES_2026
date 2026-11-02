select /*+ PARALLEL(100) */count (1) from dcsp.movement_hist where date_pay = '2026-06-05' and product_code in ('560001','560050') and modality_code = '0012' and time_pay between '10:00' and '10:15';

SET ECHO OFF
SET FEEDBACK OFF
SET TERMOUT OFF
SET MARKUP CSV ON QUOTE OFF
SPOOL /home/oracle19/scripts/movement_hist_100626.csv
select /*+ PARALLEL(100) */ * from dcsp.movement_hist 
where date_pay = '2026-06-05' 
and product_code in ('560001','560050') 
and modality_code = '0012' 
and time_pay between '10:00' and '10:15';

SPOOL OFF
SET MARKUP CSV OFF
SET TERMOUT ON
SET FEEDBACK ON