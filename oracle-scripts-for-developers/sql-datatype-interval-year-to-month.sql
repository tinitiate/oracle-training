-- >>TITLE - ORACLE-SQL Interval YEAR TO MONTH Datatypes


-- >>BREADCRUMB - ORACLE/SQL/INTERVAL YEAR TO MONTH DATATYPE


-- >>HEADLINE - ORACLE-SQL Interval Datatypes
-- >>AUTHOR - Venkata Bhattaram / TINITIATE.COM
-- >>DATEPUBLISHED - 2016-07-31


-- >>DESC<<
-- ORACLE-SQL Interval Datatypes
-- >><<


-- >>KEYWORDS<<
-- ORACLE, SQL,Interval Datatypes
-- >><<


-- >>POINTS<<
-- + Added Oracle 9, Interval datatypes can store time period intervals. 
-- + The time period is associated with an ACTUAL Date or DateTime to make sense.
-- + The Interval DOESNT store a specific date or date time, its only used to store
--   a time period not a date and time.
-- + Consider a daily routine Wake up between 6:00 AM to 6:30 AM,
--   This is NOT associated with any fixed Date, its a time period, 
-- + Or another scenario, a Dirvers Licence expires every 10 Years, 
--   this has to do with another data set or a column, Licence Issue date 
--   (Which is FIXED) but not the interval itself
--   In such scenarios the Interval data types are useful.
-- >><<



-- >>FILE-NAME - sql-datatype-interval-year-to-month.sql
-- >>DEPENDANT-FILES - N/A


-- >>CODE-TITLE - Interval datatypes INTERVAL YEAR TO MONTH in SQL query
-- >>CODE-NOTES<<
-- + INTERVAL Data Types are used to store Time Period
-- + INTERVAL YEAR TO MONTH is used to store a Year(s) and or Month(s) time period
-- + Using INTERVAL YEAR TO MONTH in a SQL query
-- + Syntax for usage of INTERVAL YEAR to MONTH SQL query
-- >><<
-- >>CODE-ALL-OS<<

-- Creating INTERVAL YEAR TO MONTH
select  sysdate
        -- Interval YEAR-MONTH Format
        ,interval '2-3' year to month
        -- INTERVAL '20' YEARS Only YEAR
        ,interval '20' year
        -- INTERVAL '6' YEAR Only MONTH        
        ,INTERVAL '6' MONTH
from   dual;

-- Using INTERVAL YEAR TO MONTH
select   sysdate
        -- Add a 3 Month Interval to SYSDATE
        ,sysdate + interval '3' month
        -- Create a Date, with a specific Day
        ,to_date('20160121','yyyymmdd') 
        -- Add 3 Months Interval to the specific Day
        ,to_date('20160121','yyyymmdd') + interval '3' month
from   dual;
-- >><<
-- >>OUTPUT<<
-- SYSDATE  INTERVAL'2-3'YEARTOMONTH INTERVAL'20'YEAR INTERVAL'6'MONTH
-- -------- ------------------------ ---------------- ----------------
-- 31-07-16 2-3                      20-0             0-6              

-- SYSDATE  SYSDATE+INTERVAL'3'MONTH TO_DATE('20160121','YYYYMMDD') TO_DATE('20160121','YYYYMMDD')+INTERVAL'3'MONTH
-- -------- ------------------------ ------------------------------ -----------------------------------------------
-- 31-07-16 31-10-16                 21-01-16                       21-04-16    
-- >><<


-- >>CODE-TITLE - Interval datatypes INTERVAL YEAR TO MONTH in PLSQL block
-- >>CODE-NOTES<<
-- + INTERVAL Data Types are used to store Time Period
-- + INTERVAL YEAR TO MONTH is used to store a Year(s) and or Month(s) time period
-- + Using INTERVAL YEAR TO MONTH in a PLSQL block
-- + Syntax for declaration of INTERVAL YEAR to MONTH in PLSQL
-- >><<
-- >>CODE-ALL-OS<<

-- Demonstration of LICENCE VALIDY PERIOD PROGRAM
declare
    -- Create a Constant Time Perio of 10 Years for a Licence Issued for 
    -- any given date.
    C_LICENCE_EXPIRY_TIMEPERIOD INTERVAL YEAR(2) to MONTH := INTERVAL '10' YEAR;
    l_licence_expiry_date       date;

    -- People
    l_person1 varchar2(10) := 'ABC';
    l_person2 varchar2(10) := 'XYZ';
begin
    -- Print the LICENCE EXPIRY PERIOD
    dbms_output.put_line(C_LICENCE_EXPIRY_TIMEPERIOD);
    
    -- Issue a Licence to a person
    dbms_output.put_line('Issue Licence today for: ' || l_person1 || ' on ' ||sysdate);
    
    L_LICENCE_EXPIRY_DATE := SYSDATE+C_LICENCE_EXPIRY_TIMEPERIOD;
    
    dbms_output.put_line('Licence Expiry Date: ' || L_LICENCE_EXPIRY_DATE);
END;
-- >><<
-- >>OUTPUT<<
-- +10-00
-- Issue Licence today for: ABC on 31-07-16
-- LICENCE EXPIRY DATE: 31-07-26
-- >><<


-- >>CODE-TITLE - Interval datatypes INTERVAL YEAR TO MONTH in DDL create table
-- >>CODE-NOTES<<
-- + INTERVAL Data Types are used to store Time Period
-- + INTERVAL YEAR TO MONTH is used to store a Year(s) and or Month(s) time period
-- + Using INTERVAL YEAR TO MONTH in a DDL for create table
-- + Syntax for declaration of INTERVAL YEAR to MONTH in DDL create table
-- >><<
-- >>CODE-ALL-OS<<

-- Demonstration DDL with INTERVAL YEAR TO MONTH
-- Create Table

DROP TABLE INTERVAL_TEST;

CREATE TABLE INTERVAL_TEST
(
   TEST_CASE      VARCHAR2(300)
  ,TEST_interval  INTERVAL YEAR(2) TO MONTH
);  

-- Insert Test Data
INSERT INTO INTERVAL_TEST VALUES(
     '10 Year Interval'
    ,INTERVAL '10' YEAR
)
/

INSERT INTO INTERVAL_TEST VALUES(
     '3 Months Interval'
    ,INTERVAL '3' MONTH
)
/

INSERT INTO INTERVAL_TEST VALUES(
     '5 Years 3 Months Interval'
    ,INTERVAL '5-3' YEAR to MONTH
)
/
-- Commit Changes
commit;


-- Query Test Data
SELECT  *
from    INTERVAL_TEST;

-- >><<
-- >>OUTPUT<<
-- table INTERVAL_TEST created.
-- 1 rows inserted.
-- 1 rows inserted.
-- 1 rows inserted.
-- COMMITTED.

-- TEST_CASE                        TEST_INTERVAL
-- -------------------------------  -------------
-- 10 YEAR INTERVAL                 10-0          
-- 3 Months Interval                0-3           
-- 5 YEARS 3 MONTHS INTERVAL        5-3           
-- >><<


-- >>TAGS - ORACLE/SQL/INTERVAL YEAR TO MONTH DATATYPE
