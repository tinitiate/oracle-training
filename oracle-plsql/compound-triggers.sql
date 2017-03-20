-- >---
-- >title: Oracle plsql Compound Triggers
-- >metadata:
-- >    description: 'Oracle Compound Triggers'
-- >    keywords: 'Oracle triggers, Compound Triggers example code, tutorials'
-- >author: Venkata Bhattaram / tinitiate.com
-- >code-alias: Compound Triggers
-- >slug: oracle/plsql/compound-triggers
-- >---

-- ># Compound Triggers
-- >* This is a Oracle 11g NEW FEATURE, Its a special type of trigger.
-- >* Its a single trigger on a table that enables usage of four trigger types:
-- >  ** Before the firing statement
-- >  ** Before each row that the firing statement affects
-- >  ** After each row that the firing statement affects
-- >  ** After the firing statement

-- >## Demonstration of COMPOUND trigger
-- >```sql
-- Create a table for trigger demonstration
create table trigger_test 
(
  col1     int,
  col2     varchar2(20),
  col3     date 
);


-- Create a trigger with FOUR types
create or replace trigger ti_compound_trigger
for insert or update or delete on trigger_test
compound trigger


  -- BEFORE STATEMENT LEVEL BLOCK
  before statement is
  begin

    case
      when inserting then
        dbms_output.put_line('BEFORE INSERT STATEMENT LEVEL COMPLETED');
      when updating then
        dbms_output.put_line('BEFORE UPDATE STATEMENT LEVEL COMPLETED');
      when deleting then
        dbms_output.put_line('BEFORE DELETE STATEMENT LEVEL COMPLETED');
    end case;
  end before statement;


  -- BEFORE ROW LEVEL BLOCK
  before each row is
  begin

    case
      when inserting then
        dbms_output.put_line('BEFORE INSERT ROW LEVEL NEW VALUE: '||:new.col1);
      when updating then
        dbms_output.put_line('BEFORE UPDATE ROW LEVEL COL2 NEW VALUE: '||:new.col2
                             ||' OLD VALUE: '|| :old.col2);
      when deleting then
        dbms_output.put_line('BEFORE DELETE ROW LEVEL COL1: '||:old.col1||' DELETED');
    end case;
    
  end before each row;


  -- AFTER ROW LEVEL BLOCK
  after each row is
  begin

    case
      when inserting then
        dbms_output.put_line('AFTER INSERT ROW LEVEL NEW VALUE: '||:new.col1);
      when updating then
        dbms_output.put_line('AFTER UPDATE ROW LEVEL COL2 NEW VALUE: '||:new.col2
                             ||' OLD VALUE: '|| :old.col2);
      when deleting then
        dbms_output.put_line('AFTER DELETE ROW LEVEL COL1: '||:old.col1||' DELETED');
    end case;
    
  end after each row;


  -- AFTER STATEMENT LEVEL BLOCK
  after statement is
  begin

    case
      when inserting then
        dbms_output.put_line('AFTER INSERT STATEMENT LEVEL COMPLETED.');
      when updating then
        dbms_output.put_line('AFTER UPDATE STATEMENT LEVEL COMPLETED');
      when deleting then
        dbms_output.put_line('AFTER DELETE STATEMENT LEVEL COMPLETED');
    end case;
    
  end after statement;

end ti_compound_trigger;
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


