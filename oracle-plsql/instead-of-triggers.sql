-- >---
-- >title: Oracle plsql Instead of Triggers
-- >metadata:
-- >    description: 'Oracle Instead of Triggers, Triggers on Views'
-- >    keywords: 'Oracle Instead of Triggers, Triggers on Views example code, tutorials'
-- >author: Venkata Bhattaram / tinitiate.com
-- >code-alias: instead-of-triggers
-- >slug: oracle/plsql/instead-of-triggers
-- >---

-- ># Oracle instead of Triggers
-- >* These are triggers on UPDATABLE VIEWS
-- >* A View is a select statement with a name or a select statement 
-- >  stored in the database as an database object.
-- >* An Updatable View is a SIMPLE view or a VIEW with ONLY a SINGLE 
-- >  UNDERLYING TABLE, There should not be any SET OPERATORS,
-- >  DISTINCT, GROUP BY, CONNECT BY, OR START WITH CLAUSES AND JOINS.
-- >* They do not fire when a DML statement is performed on the view.


-- >```sql

-- create a table
create table trigger_test 
(
  col1     int,
  col2     varchar2(20),
  col3     date,
  col4     int,
  col5     int,
  col6     int
);


-- Create an Updatable View
create view vw_trigger_test
as
select  col1
       ,col2
       ,col3
from   trigger_test;


-- Create the INSTEAD OF TRIGGER on the UPDATABLE VIEW
create or replace trigger ti_instead_of_trigger_ins
  instead of insert
  on vw_trigger_test
  for each row
begin
      dbms_output.put_line('Instead of Trigger on INSERT COL1 Value: '||:new.col1);
      
end ti_instead_of_trigger_ins;
/

create or replace trigger ti_instead_of_trigger_upd
  instead of update
  on vw_trigger_test
  for each row
begin
      dbms_output.put_line('Instead of Trigger on UPDATE COL2 Old Value: '||:old.col2);
      
      update trigger_test
      set    col2 = :new.col2
      where  col1 = :old.col1;
      
      dbms_output.put_line('Instead of Trigger on UPDATE COL2 New Value: '||:new.col2);
      
end ti_instead_of_trigger_upd;
/

create or replace trigger ti_instead_of_trigger_del
  instead of delete
  on vw_trigger_test
  for each row
begin
      dbms_output.put_line('Instead of Trigger on DELETE COL1 Value: '||:old.col1);
      
      delete from trigger_test
      where  col1 = :old.col1;
      
end ti_instead_of_trigger_del;
/

-- Test the code
-- Insert testing
insert into vw_trigger_test (col1, col2, col3) values (1,'ABC', sysdate);
insert into vw_trigger_test (col1, col2, col3) values (2,'PQR', sysdate);
insert into vw_trigger_test (col1, col2, col3) values (3,'XYZ', sysdate);

-- Select data to see the data inserted
select *
from   vw_trigger_test;


-- Update testing
update vw_trigger_test 
set    col2 = 'EFG'
where  col1 = 3;

-- Select data to see the data updated
select *
from   vw_trigger_test;


-- Insert testing
delete from vw_trigger_test;

-- Select data to see the data deleted
select *
from   vw_trigger_test;

-- Drop the view, This will drop the trigger as well.
drop view vw_trigger_test;

-- Drop the table
drop table trigger_test;

-- >```


