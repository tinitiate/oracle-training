-- >---
-- >title: Oracle plsql Table Triggers
-- >metadata:
-- >    description: 'Oracle Triggers'
-- >    keywords: 'Oracle triggers, stored procedures example code, tutorials'
-- >author: Venkata Bhattaram / tinitiate.com
-- >code-alias: triggers
-- >slug: oracle/plsql/triggers
-- >---

-- ># Oracle Triggers on Tables
-- >* DML is Data Manipulation Language(Insert, Update, Delete data)
-- >* There are TWO types of DML triggers, STATEMENT level and ROW level,
-- >* ROW LEVEL TRIGGERS
-- >  ** It is fired each time the table is affected by the triggering statement.
-- >  ** For example, if an UPDATE statement updates multiple rows of a table, 
-- >     a row trigger is fired once for each row affected by the UPDATE statement
-- >  ** If a triggering statement affects no rows, a row trigger is doesnt run.
-- >* STATEMENT LEVEL TRIGGERS
-- >  ** It is fired once on behalf of the triggering entire statement,
-- >  ** For example, if an UPDATE statement updates multiple rows of a table or
-- >     ZERO rows the statement level trigger is fired once.

-- >## Applying the Trigger action BEFORE or AFTER a DML statement
-- >* :new and :old are pseudo-records that let you access the new and 
-- >  old values of particular columns.
-- >* BEFORE TRIGGERS
-- >* The trigger action before the triggering statement is run.
-- >* Use BEFORE FOR EACH row when you need to WRITE to the :new record 
-- >* AFTER TRIGGERS
-- >* AFTER triggers run the trigger action after the triggering statement is run.
-- >* use AFTER FOR EACH row triggers when you want to VALIDATE the final values 
-- >* in the :new record.
-- >* Values of :NEW.<column-name> and :OLD.<column-name> CANNOT be changed 
-- >  in AFTER triggers.

-- >## Demonstration of BEFORE ROW LEVEL and BEFORE STATEMENT LEVEL triggers
-- >```sql
-- Create a table for trigger demonstration
create table trigger_test 
(
  col1     int,
  col2     varchar2(20),
  col3     date,
  dml_type varchar2(20) 
);

-- Create a ROW LEVEL BEFORE trigger on this table
-- We will derive the DML_TYPE column value from the trigger
-- If we are Inserting into trigger_test table, IT will be INSERT, 
-- If we are Updating trigger_test table, IT will be UPDATE,
-- If we are Deleting from trigger_test table, This will print a DELETE 
-- in DBMS_OUTPUT,
create or replace trigger ti_before_row_trigger
before insert or update or delete on trigger_test
for each row
begin
  -- Flags are booleans and can be used in any branching construct.
  case
    when inserting then
        -- Code here is executed when an INSERT is encountered.
        -- This will fire INSERT which is part of MERGE.
        :new.dml_type := 'INSERT';
        
    when updating then
        -- Code here is executed when an UPDATE is encountered.
        -- This will fire UPDATE which is part of MERGE.
      :new.dml_type := 'UPDATE';
      
    when deleting then
        -- Code here is executed when an UPDATE is encountered.
        -- This will NOT fire DELETE which is part of MERGE.
        dbms_output.put_line('ROW '||:old.col1||' DELETED');
  end case;
end;
/

-- Create a STATEMENT LEVEL BEFORE trigger on this table
-- If we are INSERTING, UPDATING or DELETING from trigger_test table, 
-- This will print a DELETE in DBMS_OUTPUT
create or replace trigger ti_before_statement_trigger
before insert or update or delete on trigger_test
begin
  -- Flags are booleans and can be used in any branching construct.
  case
    when inserting then
        -- Code here is executed when an INSERT is encountered.
        -- This will fire INSERT which is part of MERGE.
        dbms_output.put_line('DATA INSERTED');
        
    when updating then
        -- Code here is executed when an UPDATE is encountered.
        -- This will fire UPDATE which is part of MERGE.
        dbms_output.put_line('DATA UPDATED');
      
    when deleting then
        -- Code here is executed when an UPDATE is encountered.
        -- This will NOT fire DELETE which is part of MERGE.
        dbms_output.put_line('DATA DELETED');
  end case;
end;
/




-- Test the code
-- Insert testing
insert into trigger_test (col1, col2, col3) values (1,'ABC', sysdate);
insert into trigger_test (col1, col2, col3) values (2,'PQR', sysdate);
insert into trigger_test (col1, col2, col3) values (3,'XYZ', sysdate);

-- Select data to see the data inserted into the "dml_type" column
select *
from   trigger_test;


-- Update testing
update trigger_test 
set    col2 = 'EFG'
where  col1 = 3;

-- Select data to see the data inserted into the "dml_type" column
select *
from   trigger_test;


-- Insert testing
delete from trigger_test;

-- Select data to see the data inserted into the "dml_type" column
select *
from   trigger_test;

-- Drop the table, This will drop the trigger as well.
drop table trigger_test;

-- >```


-- >## Demonstration of AFTER ROW LEVEL and AFTER STATEMENT LEVEL triggers
-- >```sql
-- Create a table for trigger demonstration
create table trigger_test 
(
  col1     int,
  col2     varchar2(20),
  col3     date,
  dml_type varchar2(20) 
);

-- Create a ROW LEVEL AFTER trigger on this table
-- We will derive the DML_TYPE column value from the trigger
-- If we are Inserting into trigger_test table, IT will be INSERT, 
-- If we are Updating trigger_test table, IT will be UPDATE,
-- If we are Deleting from trigger_test table, This will print a DELETE 
-- in DBMS_OUTPUT,
create or replace trigger ti_before_row_trigger
after insert or update or delete on trigger_test
for each row
begin
  -- Flags are booleans and can be used in any branching construct.
  case
    when inserting then
        -- Code here is executed when an INSERT is encountered.
        -- This will fire INSERT which is part of MERGE.
        dbms_output.put_line('Insert New COL1 Value: '||:new.col1);
        
    when updating then
        -- Code here is executed when an UPDATE is encountered.
        -- This will fire UPDATE which is part of MERGE.
        dbms_output.put_line('Update New COL2 Value: '||:new.col2);
        dbms_output.put_line('Update Old COL2 Value: '||:old.col2);
      
    when deleting then
        -- Code here is executed when an UPDATE is encountered.
        -- This will NOT fire DELETE which is part of MERGE.
        dbms_output.put_line('Deleted COL1 Value '||:old.col1);
  end case;
end;
/

-- Create a STATEMENT LEVEL AFTER trigger on this table
-- If we are INSERTING, UPDATING or DELETING from trigger_test table, 
-- This will print a DELETE in DBMS_OUTPUT
create or replace trigger ti_before_statement_trigger
after insert or update or delete on trigger_test
begin
  -- Flags are booleans and can be used in any branching construct.
  case
    when inserting then
        -- Code here is executed when an INSERT is encountered.
        -- This will fire INSERT which is part of MERGE.
        dbms_output.put_line('DATA INSERTED');
        
    when updating then
        -- Code here is executed when an UPDATE is encountered.
        -- This will fire UPDATE which is part of MERGE.
        dbms_output.put_line('DATA UPDATED');
      
    when deleting then
        -- Code here is executed when an UPDATE is encountered.
        -- This will NOT fire DELETE which is part of MERGE.
        dbms_output.put_line('DATA DELETED');
  end case;
end;
/




-- Test the code
-- Insert testing
insert into trigger_test (col1, col2, col3) values (1,'ABC', sysdate);
insert into trigger_test (col1, col2, col3) values (2,'PQR', sysdate);
insert into trigger_test (col1, col2, col3) values (3,'XYZ', sysdate);

-- Select data to see the data inserted into the "dml_type" column
select *
from   trigger_test;


-- Update testing
update trigger_test 
set    col2 = 'EFG'
where  col1 = 3;

-- Select data to see the data inserted into the "dml_type" column
select *
from   trigger_test;


-- Insert testing
delete from trigger_test;

-- Select data to see the data inserted into the "dml_type" column
select *
from   trigger_test;

-- Drop the table, This will drop the trigger as well.
drop table trigger_test;

-- >```
