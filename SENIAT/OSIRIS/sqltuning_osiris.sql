spool sqltuning_osiris.lst

SET LONG 1000000
SET LONGCHUNKSIZE 1000000
SET LINESIZE 200
SET PAGESIZE 0
SET TRIMSPOOL ON
SET FEEDBACK OFF




set long 65536
set longchunksize 65536
set linesize 240
set pagesize 500

PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT "--------------------------0q8t5jtfvnj20--------------------------------------------"
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "

DECLARE
l_sql_tune_task_id VARCHAR2(100);
BEGIN
l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
sql_id => '0q8t5jtfvnj20',
scope => DBMS_SQLTUNE.scope_comprehensive,
time_limit => 20000,
task_name => '0q8t5jtfvnj20_tuning_task1',
description => 'Tuning task1 for statement 0q8t5jtfvnj20');
DBMS_OUTPUT.put_line('l_sql_tune_task_id: ' || l_sql_tune_task_id);
END;
/

EXEC DBMS_SQLTUNE.execute_tuning_task(task_name => '0q8t5jtfvnj20_tuning_task1');

select dbms_sqltune.report_tuning_task('0q8t5jtfvnj20_tuning_task1') from dual;

PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT "-------------------------------f2kta5pc14w3m---------------------------------------"
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "

DECLARE
l_sql_tune_task_id VARCHAR2(100);
BEGIN
l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
sql_id => 'f2kta5pc14w3m',
scope => DBMS_SQLTUNE.scope_comprehensive,
time_limit => 20000,
task_name => 'f2kta5pc14w3m_tuning_task1',
description => 'Tuning task1 for statement f2kta5pc14w3m');
DBMS_OUTPUT.put_line('l_sql_tune_task_id: ' || l_sql_tune_task_id);
END;
/

EXEC DBMS_SQLTUNE.execute_tuning_task(task_name => 'f2kta5pc14w3m_tuning_task1');

select dbms_sqltune.report_tuning_task('f2kta5pc14w3m_tuning_task1') from dual;

PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT "-------------------------------3kr0uc4gcthqw---------------------------------------"
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "

DECLARE
l_sql_tune_task_id VARCHAR2(100);
BEGIN
l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
sql_id => '3kr0uc4gcthqw',
scope => DBMS_SQLTUNE.scope_comprehensive,
time_limit => 20000,
task_name => '3kr0uc4gcthqw_tuning_task1',
description => 'Tuning task1 for statement 3kr0uc4gcthqw');
DBMS_OUTPUT.put_line('l_sql_tune_task_id: ' || l_sql_tune_task_id);
END;
/

EXEC DBMS_SQLTUNE.execute_tuning_task(task_name => '3kr0uc4gcthqw_tuning_task1');

select dbms_sqltune.report_tuning_task('3kr0uc4gcthqw_tuning_task1') from dual;

PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT "----------------------------9c4w6f89ca2rc------------------------------------------"
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "

DECLARE
l_sql_tune_task_id VARCHAR2(100);
BEGIN
l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
sql_id => '9c4w6f89ca2rc',
scope => DBMS_SQLTUNE.scope_comprehensive,
time_limit => 20000,
task_name => '9c4w6f89ca2rc_tuning_task1',
description => 'Tuning task1 for statement 9c4w6f89ca2rc');
DBMS_OUTPUT.put_line('l_sql_tune_task_id: ' || l_sql_tune_task_id);
END;
/

EXEC DBMS_SQLTUNE.execute_tuning_task(task_name => '9c4w6f89ca2rc_tuning_task1');

select dbms_sqltune.report_tuning_task('9c4w6f89ca2rc_tuning_task1') from dual;

PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT "-----------------------------9wm9ynjvdznya-----------------------------------------"
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "

DECLARE
l_sql_tune_task_id VARCHAR2(100);
BEGIN
l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
sql_id => '9wm9ynjvdznya',
scope => DBMS_SQLTUNE.scope_comprehensive,
time_limit => 20000,
task_name => '9wm9ynjvdznya_tuning_task1',
description => 'Tuning task1 for statement 9wm9ynjvdznya');
DBMS_OUTPUT.put_line('l_sql_tune_task_id: ' || l_sql_tune_task_id);
END;
/

EXEC DBMS_SQLTUNE.execute_tuning_task(task_name => '9wm9ynjvdznya_tuning_task1');

select dbms_sqltune.report_tuning_task('9wm9ynjvdznya_tuning_task1') from dual;

PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT "----------------------------cr4k0um90nuqc------------------------------------------"
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "

DECLARE
l_sql_tune_task_id VARCHAR2(100);
BEGIN
l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
sql_id => 'cr4k0um90nuqc',
scope => DBMS_SQLTUNE.scope_comprehensive,
time_limit => 20000,
task_name => 'cr4k0um90nuqc_tuning_task1',
description => 'Tuning task1 for statement cr4k0um90nuqc');
DBMS_OUTPUT.put_line('l_sql_tune_task_id: ' || l_sql_tune_task_id);
END;
/

EXEC DBMS_SQLTUNE.execute_tuning_task(task_name => 'cr4k0um90nuqc_tuning_task1');

select dbms_sqltune.report_tuning_task('cr4k0um90nuqc_tuning_task1') from dual;

PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT "-----------------------------7f458sz8134fh-----------------------------------------"
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "

DECLARE
l_sql_tune_task_id VARCHAR2(100);
BEGIN
l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
sql_id => '7f458sz8134fh',
scope => DBMS_SQLTUNE.scope_comprehensive,
time_limit => 20000,
task_name => '7f458sz8134fh_tuning_task1',
description => 'Tuning task1 for statement 7f458sz8134fh');
DBMS_OUTPUT.put_line('l_sql_tune_task_id: ' || l_sql_tune_task_id);
END;
/

EXEC DBMS_SQLTUNE.execute_tuning_task(task_name => '7f458sz8134fh_tuning_task1');

select dbms_sqltune.report_tuning_task('7f458sz8134fh_tuning_task1') from dual;

PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT "-------------------------------8h24t7pnjxgjc---------------------------------------"
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "

DECLARE
l_sql_tune_task_id VARCHAR2(100);
BEGIN
l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
sql_id => '8h24t7pnjxgjc',
scope => DBMS_SQLTUNE.scope_comprehensive,
time_limit => 20000,
task_name => '8h24t7pnjxgjc_tuning_task1',
description => 'Tuning task1 for statement 8h24t7pnjxgjc');
DBMS_OUTPUT.put_line('l_sql_tune_task_id: ' || l_sql_tune_task_id);
END;
/

EXEC DBMS_SQLTUNE.execute_tuning_task(task_name => '8h24t7pnjxgjc_tuning_task1');

select dbms_sqltune.report_tuning_task('8h24t7pnjxgjc_tuning_task1') from dual;

PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT "-------------------------------57yhzcdjc71wy---------------------------------------"
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "

DECLARE
l_sql_tune_task_id VARCHAR2(100);
BEGIN
l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
sql_id => '57yhzcdjc71wy',
scope => DBMS_SQLTUNE.scope_comprehensive,
time_limit => 20000,
task_name => '57yhzcdjc71wy_tuning_task1',
description => 'Tuning task1 for statement 57yhzcdjc71wy');
DBMS_OUTPUT.put_line('l_sql_tune_task_id: ' || l_sql_tune_task_id);
END;
/

EXEC DBMS_SQLTUNE.execute_tuning_task(task_name => '57yhzcdjc71wy_tuning_task1');

select dbms_sqltune.report_tuning_task('57yhzcdjc71wy_tuning_task1') from dual;

PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT "--------------------------------3fuzprm640n1y--------------------------------------"
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "

DECLARE
l_sql_tune_task_id VARCHAR2(100);
BEGIN
l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
sql_id => '3fuzprm640n1y',
scope => DBMS_SQLTUNE.scope_comprehensive,
time_limit => 20000,
task_name => '3fuzprm640n1y_tuning_task1',
description => 'Tuning task1 for statement 3fuzprm640n1y');
DBMS_OUTPUT.put_line('l_sql_tune_task_id: ' || l_sql_tune_task_id);
END;
/

EXEC DBMS_SQLTUNE.execute_tuning_task(task_name => '3fuzprm640n1y_tuning_task1');

select dbms_sqltune.report_tuning_task('3fuzprm640n1y_tuning_task1') from dual;

PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT "------------------------------94013gg00mfnt----------------------------------------"
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "

DECLARE
l_sql_tune_task_id VARCHAR2(100);
BEGIN
l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
sql_id => '94013gg00mfnt',
scope => DBMS_SQLTUNE.scope_comprehensive,
time_limit => 20000,
task_name => '94013gg00mfnt_tuning_task1',
description => 'Tuning task1 for statement 94013gg00mfnt');
DBMS_OUTPUT.put_line('l_sql_tune_task_id: ' || l_sql_tune_task_id);
END;
/

EXEC DBMS_SQLTUNE.execute_tuning_task(task_name => '94013gg00mfnt_tuning_task1');

select dbms_sqltune.report_tuning_task('94013gg00mfnt_tuning_task1') from dual;

PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT "------------------------------04c3r8pbn1tjc----------------------------------------"
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "

DECLARE
l_sql_tune_task_id VARCHAR2(100);
BEGIN
l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
sql_id => '04c3r8pbn1tjc',
scope => DBMS_SQLTUNE.scope_comprehensive,
time_limit => 20000,
task_name => '04c3r8pbn1tjc_tuning_task1',
description => 'Tuning task1 for statement 04c3r8pbn1tjc');
DBMS_OUTPUT.put_line('l_sql_tune_task_id: ' || l_sql_tune_task_id);
END;
/

EXEC DBMS_SQLTUNE.execute_tuning_task(task_name => '04c3r8pbn1tjc_tuning_task1');

select dbms_sqltune.report_tuning_task('04c3r8pbn1tjc_tuning_task1') from dual;

PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT "----------------------------------b4jmru9wxunqy------------------------------------"
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "

DECLARE
l_sql_tune_task_id VARCHAR2(100);
BEGIN
l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
sql_id => 'b4jmru9wxunqy',
scope => DBMS_SQLTUNE.scope_comprehensive,
time_limit => 20000,
task_name => 'b4jmru9wxunqy_tuning_task1',
description => 'Tuning task1 for statement b4jmru9wxunqy');
DBMS_OUTPUT.put_line('l_sql_tune_task_id: ' || l_sql_tune_task_id);
END;
/

EXEC DBMS_SQLTUNE.execute_tuning_task(task_name => 'b4jmru9wxunqy_tuning_task1');

select dbms_sqltune.report_tuning_task('b4jmru9wxunqy_tuning_task1') from dual;

PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT "------------------------------267pa6yujgpmd----------------------------------------"
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "

DECLARE
l_sql_tune_task_id VARCHAR2(100);
BEGIN
l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
sql_id => '267pa6yujgpmd',
scope => DBMS_SQLTUNE.scope_comprehensive,
time_limit => 20000,
task_name => '267pa6yujgpmd_tuning_task1',
description => 'Tuning task1 for statement 267pa6yujgpmd');
DBMS_OUTPUT.put_line('l_sql_tune_task_id: ' || l_sql_tune_task_id);
END;
/

EXEC DBMS_SQLTUNE.execute_tuning_task(task_name => '267pa6yujgpmd_tuning_task1');

select dbms_sqltune.report_tuning_task('267pa6yujgpmd_tuning_task1') from dual;

PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT "--------------------------------4nm42wpg27wmy--------------------------------------"
PROMPT " "
PROMPT " "
PROMPT " "
PROMPT " "

DECLARE
l_sql_tune_task_id VARCHAR2(100);
BEGIN
l_sql_tune_task_id := DBMS_SQLTUNE.create_tuning_task (
sql_id => '4nm42wpg27wmy',
scope => DBMS_SQLTUNE.scope_comprehensive,
time_limit => 20000,
task_name => '4nm42wpg27wmy_tuning_task1',
description => 'Tuning task1 for statement 4nm42wpg27wmy');
DBMS_OUTPUT.put_line('l_sql_tune_task_id: ' || l_sql_tune_task_id);
END;
/

EXEC DBMS_SQLTUNE.execute_tuning_task(task_name => '4nm42wpg27wmy_tuning_task1');

select dbms_sqltune.report_tuning_task('4nm42wpg27wmy_tuning_task1') from dual;





spool off;