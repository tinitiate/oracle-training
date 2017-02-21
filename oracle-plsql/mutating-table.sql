-- >---
-- >title: Oracle plsql Mutating Table Error from Triggers
-- >metadata:
-- >    description: 'Oracle Mutating Table Error from Triggers
-- >    keywords: 'Oracle Mutating Table Error from Triggers example code, tutorials'
-- >author: Venkata Bhattaram / tinitiate.com
-- >code-alias: Mutating Table
-- >slug: oracle/plsql/mutating-table
-- >---

-- ># Mutating Table
-- >* This is an Error scenario, where a trigger attempting to change values in the 
-- >  table and reads that table.
-- >* This occurs in row-level triggers
-- >* Demonstration of mutating table error
-- >```sql
-- Step 1.
-- Create a table
create table ti_mt_demo
(
    col1 int
   ,col2 varchar2(10)
);

-- Step 2.
-- Create a row-level trigger, that reads and changes the table contents
-- The objective of the below trigger is to append the row count of the table 
-- to the col2, everytime an Insert or Update is performed.
create or replace trigger ti_mt_trg
before insert or update or delete on ti_mt_demo
for each row
declare
   l_table_count int;  
begin
   select count(1)
   into   l_table_count
   from   ti_mt_demo;
   
   if inserting
   then
      :new.col2 := l_table_count||' '||:new.col2;
   end if;

end ti_mt_trg;
/


-- Create an insert statement to execute the trigger
insert into ti_mt_demo(col1, col2) values(2,'abc');

-- attempt an update, will raise the mutating table error
update ti_mt_demo
set    col2 = 'DD'
where  col1 = 1;

-- attempt a delete,  will raise the mutating table error
delete from ti_mt_demo;

-- >``` 

-- >## Avoiding mutating table errors
-- >* To avoid mutating table errors heres the steps to take
-- >* Step 1.
-- >* Hold the INCOMING changes and DML type (insert/update/delete) in the trigger 
-- >  into a temporary package variables or Global Temporary tables.
-- >* Step 2.
-- >* Here we use a package to hold the INCOMING changes, 
-- >* Step 3.
-- >* Recreate the DML on the base table with the temporary variables/table
-- >```sql

-- create a global temporary table to store the values
create or replace package ti_mt_pkg
as
    v_row_count int;
end ti_mt_pkg;


-- Recreate the trigger ti_mt_trg,
-- to ONLY read the data
create or replace trigger ti_mt_trg
before insert or update on ti_mt_demo
declare
   l_table_count int;
begin
   select count(1)
   into   l_table_count
   from   ti_mt_demo;

   if inserting or updating or deleting
   then
      ti_mt_pkg.v_row_count := l_table_count;
   end if;

end ti_mt_trg;
/


-- Create a statement level trigger to execute the DML
create or replace trigger ti_mt_stmt_trg
before insert or update on ti_mt_demo
for each row
declare
   PRAGMA AUTONOMOUS_TRANSACTION;
begin

   if inserting or updating
   then
      :new.col2 := ti_mt_pkg.v_row_count||' '||:new.col2;
   end if;

end ti_mt_stmt_trg;
/
-- >```
