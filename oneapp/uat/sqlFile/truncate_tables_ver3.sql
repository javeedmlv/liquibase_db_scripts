CREATE OR REPLACE PROCEDURE TRUNCATE_LOG_TX_MESSAGE_two_months AS

--set serveroutput ON;
DECLARE
    v_date_prefix VARCHAR2(6);
    v_prev_month DATE;
	vs_statement VARCHAR2(100);
BEGIN
    -- Calculate the first day of the current month
    v_prev_month := TRUNC(SYSDATE, 'MM') - INTERVAL '2' MONTH;
    -- Format the previous month as 'YYYYMM'
    v_date_prefix := TO_CHAR(v_prev_month, 'YYYYMM');
	

    -- Search for tables with names starting with the date prefix
    FOR rec IN (
        SELECT table_name
        FROM all_tables
        WHERE table_name ='LOG_TX_MESSAGE_' || v_date_prefix
       ) LOOP
	   
	    vs_statement := 'TRUNCATE TABLE ONEAPP. ' || rec.table_name|| ' DROP STORAGE' ; 
		EXECUTE IMMEDIATE vs_statement;
        DBMS_OUTPUT.PUT_LINE('Table '||REC.table_name||' Truncated!');
    END LOOP;
END;
/

