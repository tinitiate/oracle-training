-- >---
-- >title: Oracle plsql Materialized Views
-- >metadata:
-- >    description: 'Oracle Materialized Views'
-- >    keywords: 'Oracle Materialized Views example code, tutorials'
-- >author: Venkata Bhattaram / tinitiate.com
-- >code-alias: materialized-views
-- >slug: oracle/plsql/materialized-views
-- >---

-- ># Oracle Materialized Views
-- >* Materialized view is a database object that stores the results of a SQL query.
-- >* The data of the query can select data from tables, views, and materialized views.
-- >* The data in the materialized views can be periodically refreshed, the underlying
-->   tables could be on the local or remote database.


-- >## STEP 1. Demonstration of Materialized Views (Create Tables)
-- >* Create THREE tables for out test.
-- >* Table big_tab with 100000 Rows
-- >* Table med_tab with 50000 Rows
-- >* Table small_tab with 100 Rows

-- >``sql

begin
   execute immediate('drop table big_tab');
exception
  when others then
    null;    
end;
/


begin
   execute immediate('drop table med_tab');
exception
  when others then
    null;    
end;
/

begin
   execute immediate('drop table small_tab');
exception
  when others then
    null;    
end;
/


-- Table big_tab table with 100000 Rows
create table big_tab
(
     col1   int
    ,col2   varchar2(100)
    ,col3   date
    primary key(col1)
);
/

-- Table med_tab table with 50000 Rows
create table med_tab
(
     col1   int
    ,col2   varchar2(100)
    ,col3   date
    ,col4   int
);
/

-- Table small_tab table with 100 Rows
create table small_tab
(
     col4   int
    ,col5   date
);
/


-- Insert data for big_tab table
begin
  
  -- Insert TWO sets of joins
  insert into big_tab (col1, col2, col3)
  select  level
         ,dbms_random.string('a',10)
         ,sysdate-dbms_random.value(0,300)
  from   dual
  connect by level < 50001;


  -- Insert 
  insert into big_tab (col1, col2, col3)
  select  level
         ,dbms_random.string('a',10)
         ,sysdate-dbms_random.value(0,300)
  from   dual
  connect by level < 50001;
  
  -- Commit changes
  commit;
  
end;
/


-- Insert data for med_tab table
begin

  insert into med_tab (col1, col2, col3, col4)
  select  level
         ,dbms_random.string('a',10)
         ,sysdate-dbms_random.value(0,300)
         ,dbms_random.value(0,100)
  from   dual
  connect by level < 50001;
  
  -- Commit
  commit;
  
end;
/


    
-- Insert data for small_tab table
begin

  insert into small_tab (col4, col5)
  select  dbms_random.value(0,100)
         ,sysdate-dbms_random.value(0,300)
  from   dual
  connect by level < 101;
  
  -- Commit
  commit;
  
end;
/

-- Check the generated data
select *
from   big_tab;


select *
from   med_tab;


select *
from   small_tab;

-- >```


-- >## STEP 2. Create Materialized View
-- >* Materialized View must be created with REFRESH settings, The data from the
-- >  underlying query is bound to change and these changes must be reflected in the
-- >  Materialized View as well.
-- >* Refreshing or updating the changes to the Materialized View are possible by 
-- >  the following settings ( clauses in the create statement).

-- >* **REFRESH COMPLETE ON DEMAND**
-- >  In a complete refresh on demand setting the materialized view is truncated 
-- >  (data deleted and commit issued) and rebuilt.
-- >  ON DEMAND clause ensures the rebuilding happens when there is a manual rebuild 
-- >  request or a scheduled rebuild request.

-- >* **REFRESH FAST ON DEMAND**
-- >* In a REFRESH FAST ON DEMAND setting required the presence of:
-- >  ** "MATERIALIZED VIEW LOGS"
-- >     *** These are database objects that are built on the tables that are part of 
-- >         the materialized view query.
-- >     *** Their purpose is to capture the data changes so instead of rebuilding 
-- >         qualifying existing data they capture only the changes that will be 
-- >         part of the materialized view query.
-- >     *** This will enhance the performance greatly and also ease the load on the 
-- >         DB server resources CPU / IO

-- >* **REFRESH FORCE ON DEMAND**
-- >* In this setting a fast refresh is attempted and if that fails complete 
-- >  refresh is executed
-- >* This is the default setting to be used to create a materialized view.

-- >### Demonstration of **REFRESH FORCE ON DEMAND**
-- >* Here a **REFRESH COMPLETE ON DEMAND** is performed as there is no MATERIALIZED 
-- >  VIEW LOG created on the underlying tables

-- >```sql
-- Create materialized view statement with 
create materialized view ti_mv_bi_rf
build immediate 
refresh force on demand
as
-- materialized view underlying query
select   mt.col1
        ,mt.col2
        ,mt.col3
        ,mt.col4
        ,st.col5
-- materialized view underlying tables       
from   big_tab    bt
 join  med_tab    mt
   on  (mt.col1 = bt.col1)
 join  small_tab  st
   on  (mt.col4 = st.col4);

-- Check performance using the query Vs the Materialized View

-- Check with SQL Query
select systimestamp SQL_START_TIME 
from   dual;

select   mt.col1
        ,mt.col2
        ,mt.col3
        ,mt.col4
        ,st.col5
from   big_tab    bt
 join  med_tab    mt
   on  (mt.col1 = bt.col1)
 join  small_tab  st
   on  (mt.col4 = st.col4);
   
select systimestamp SQL_END_TIME
from   dual;


-- Check with Materialized View
select systimestamp MV_START_TIME 
from   dual;

select *
from   ti_mv_bi_rf;
   
select systimestamp  MV_END_TIME 
from   dual;


-- drop the M View
drop materialized view ti_mv_bi_rf;

-->```

-- >### Demonstration of **REFRESH FAST ON DEMAND**
-- >* Here a **MATERIALIZED VIEW LOG** is built on the underlying tables of the 
-- >  materialized view query.
-- >* A materialized view log is not given a name, as one table can have atmost one 
-- >  materialized view log built for it at a time.
-- >* WITH PRIMARY KEY
-- >* If the base tables primary key column is required in the materialized view log 
-- >  the WITH PRIMARY KEY clause can be specified.
-- >* WITH ROWID
-- >* If there is NO Primary key in the table that is required to be included then
-- >  ROWID can be specified.
-- >* WITH SEQUENCE
-- >* A SEQUENCE column can be included in the materialized view log to correctly 
-- >  order Data Manipulation Language (DML), on the base table.
-- >* WITH Column List
-- >* A List of columns of the base table can be specified as part materialized view log 
-- >* INCLUDING NEW VALUES Clause
-- >* This is a clause which enhances the capture of Updates on the base table and 
-- >  in cases where the materialized view has Aggregate values.

-- >## Demonstration of Creating a Materialized View with logs
-- >```sql

-- STEP 1.
-- Create Materialized View Log on all the there tables that are used by the 
-- materialized view
create materialized view log on big_tab
with rowid;

create materialized view log on med_tab
with rowid;

create materialized view log on small_tab
with rowid;


-- Create materialized view statement with 
create materialized view ti_mv_bi_rf
build immediate 
refresh force on demand
as
-- materialized view underlying query
select   mt.col1
        ,mt.col2
        ,mt.col3
        ,mt.col4
        ,st.col5
-- materialized view underlying tables       
from   big_tab    bt
 join  med_tab    mt
   on  (mt.col1 = bt.col1)
 join  small_tab  st
   on  (mt.col4 = st.col4);

-- select from m View
select *
from   ti_mv_bi_rf;

-- drop the M View
drop materialized view ti_mv_bi_rf;
-- >```
