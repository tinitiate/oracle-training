/*
-- >>TITLE - ORACLE-SQL Interval DAY TO SECOND Datatypes


-- >>BREADCRUMB - ORACLE/SQL/INTERVAL DAY TO SECOND DATATYPE


-- >>HEADLINE - ORACLE-SQL Interval Datatypes
-- >>AUTHOR - Venkata Bhattaram / TINITIATE.COM
-- >>DATEPUBLISHED - 2016-07-31


-- >>DESC<<
-- ORACLE-SQL Interval DAY TO SECOND datatype
-- >><<


-- >>KEYWORDS<<
-- ORACLE, SQL,Interval Datatypes,DAY TO SECOND
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



-- >>FILE-NAME - sql-datatype-interval-day-to-second.sql
-- >>DEPENDANT-FILES - N/A


-- >>CODE-TITLE - Interval datatypes INTERVAL DAY TO SECOND in SQL query
-- >>CODE-NOTES<<
-- + INTERVAL Data Types are used to store Time Period
-- + INTERVAL DAY TO SECOND is used to store a Day(s), Hour(s), Minute(s) 
--   and or Month(s) time period.
-- + DAY - Allowable values 0 to 30
-- + HOUR - Allowable values of 0 to 23.
-- + MINUTE - Allowable values of 0 to 59.
-- + SECOND - ALLOWABLE VALUES OF 0 TO 59.999999999.

-- + Using INTERVAL DAY TO SECOND in a SQL query
-- + Syntax for usage of INTERVAL DAY TO SECOND SQL query
-- >><<
-- >>CODE-ALL-OS<<

-- Creating INTERVAL DAY TO SECOND
SELECT   SYSDATE
        -- Interval DAY-SECOND Format
        ,INTERVAL '20 12:12:12' DAY TO SECOND as DAY_HOUR_MIN_SEC_INTERVAL
        -- INTERVAL '20' DAYS
        ,INTERVAL '20' DAY                    as DAY_INTERVAL
        -- INTERVAL '12' HOURS
        ,INTERVAL '12' HOUR                   as HOUR_INTERVAL
        -- INTERVAL '12' MINUTES
        ,INTERVAL '12' MINUTE                 as MIN_INTERVAL
        -- INTERVAL '12' SECONDS
        ,INTERVAL '12' SECOND                 as SEC_INTERVAL
from   dual;


-- Using INTERVAL DAY TO SECOND
SELECT  -- Create a Date, with a specific Day
         TO_TIMESTAMP('20160121 12:12:12','yyyymmdd hh24:mi:ss') as v_timestamp
        -- Add 3 Days Interval to the specific Day, (NOTICE INCREASE IN DAY)
        ,TO_TIMESTAMP('20160121 12:12:12','yyyymmdd hh24:mi:ss') + INTERVAL '3' DAY as INT_DAY
        -- Add 3 Hours Interval to the specific Day, (NOTICE INCREASE IN HOUR)
        ,TO_TIMESTAMP('20160121 12:12:12','yyyymmdd hh24:mi:ss') + INTERVAL '3' HOUR as INT_HOUR
        -- Add 3 Minutes Interval to the specific Day, (NOTICE INCREASE IN MINUTE)
        ,TO_TIMESTAMP('20160121 12:12:12','yyyymmdd hh24:mi:ss') + INTERVAL '3' MINUTE as INT_MIN
        -- Add 3 Seconds Interval to the specific Day, (NOTICE INCREASE IN SECOND)
        ,TO_TIMESTAMP('20160121 12:12:12','yyyymmdd hh24:mi:ss') + INTERVAL '3' SECOND as INT_SEC
FROM   DUAL;

-- >><<
-- >>OUTPUT<<
SYSDATE  DAY_HOUR_MIN_SEC_INTERVAL DAY_INTERVAL HOUR_INTERVAL MIN_INTERVAL SEC_INTERVAL
-------- ------------------------- ------------ ------------- ------------ ------------
01-08-16 20 12:12:12.0             20 0:0:0.0   0 12:0:0.0    0 0:12:0.0   0 0:0:12.0   

V_TIMESTAMP                      INT_DAY                          INT_HOUR                         INT_MIN                          INT_SEC                        
-------------------------------- -------------------------------- -------------------------------- -------------------------------- ------------------------------
21-01-16 12:12:12.000000000 PM   24-01-16 12:12:12.000000000 PM   21-01-16 03:12:12.000000000 PM   21-01-16 12:15:12.000000000 PM   21-01-16 12:12:15.000000000 PM
-- >><<
*/

-- >>CODE-TITLE - Interval datatypes INTERVAL DAY TO SECOND in PLSQL block
-- >>CODE-NOTES<<
-- + INTERVAL Data Types are used to store Time Period
-- + INTERVAL DAY TO SECOND is used to store a Year(s) and or Month(s) time period
-- + Using INTERVAL DAY TO SECOND in a PLSQL block
-- + Syntax for declaration of INTERVAL DAY TO SECOND in PLSQL
-- >><<
-- >>CODE-ALL-OS<<

-- Demonstration of ONE TIME PASSWORD EXPIRATION
DECLARE
    -- Create a Constant Time period of 5 Minutes for an One Time Password Generated
    C_OTP_EXPIRY_TIMEPERIOD  INTERVAL DAY(3) TO SECOND := INTERVAL '5' MINUTE;
    l_otp_created_datetime   TIMESTAMP                 := SYSTIMESTAMP;
    l_otp_expire_datetime    TIMESTAMP;
begin
    -- Print the LICENCE EXPIRY PERIOD
    dbms_output.put_line('OTP Generated at: ' || l_otp_created_datetime);
    
    -- Issue a Licence to a person
    l_otp_expire_datetime := l_otp_created_datetime + C_OTP_EXPIRY_TIMEPERIOD;
    DBMS_OUTPUT.PUT_LINE('OTP Expires at: ' || l_otp_expire_datetime);    
END;
-- >><<
-- >>OUTPUT<<
OTP Generated at: 01-08-16 01:07:23.477000 AM
OTP Expires at: 01-08-16 01:12:23.477000 AM
-- >><<


-- >>CODE-TITLE - Interval datatypes INTERVAL DAY TO SECOND in DDL create table
-- >>CODE-NOTES<<
-- + INTERVAL Data Types are used to store Time Period
-- + INTERVAL DAY TO SECOND  is used to store a DAY(s) and or SECOND(s) time period
-- + Using INTERVAL DAY TO SECOND in a DDL for create table
-- + Syntax for declaration of INTERVAL DAY TO SECOND in DDL create table
-- >><<
-- >>CODE-ALL-OS<<

-- Demonstration DDL with INTERVAL YEAR TO MONTH
-- Create Table

drop table interval_test;

create table interval_test
(
   test_case      varchar2(300)
  ,test_interval  interval day(2) to second
);  

-- Insert Test Data
INSERT INTO INTERVAL_TEST VALUES(
     '10 Day Interval'
    ,INTERVAL '10' DAY
)
/

INSERT INTO INTERVAL_TEST VALUES(
     '10 Hours Interval'
    ,INTERVAL '10' HOUR
)
/

insert into interval_test values(
     '2 Days 3 Hours 30 Minutes 20 Seconds Interval'
    ,INTERVAL '2 03:30:20.00000' DAY to SECOND
)
/
-- Commit Changes
commit;


-- Query Test Data
SELECT  *
from    INTERVAL_TEST;

-- >><<
-- >>OUTPUT<<
table INTERVAL_TEST dropped.
table INTERVAL_TEST created.
1 rows inserted.
1 rows inserted.
1 rows inserted.
committed.
test_case                                      test_interval
---------                                      -------------
10 Day Interval                                10 0:0:0.0    
10 hours interval                              0 10:0:0.0    
2 Days 3 Hours 30 Minutes 20 Seconds Interval  2 3:30:20.0
-- >><<


-- >>TAGS - ORACLE, SQL,INTERVAL DAY TO SECOND DATATYPE
