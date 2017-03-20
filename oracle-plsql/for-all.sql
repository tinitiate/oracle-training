-- >---
-- >title: Oracle bulk collect and for all
-- >metadata:
-- >    description: 'Oracle bulk collect and for all'
-- >    keywords: 'Oracle bulk collect and for all, examples, code'
-- >author: Venkata Bhattaram / tinitiate.com
-- >code-alias: bulk-collect-for-all
-- >slug: oracle/plsql/bulk-collect-for-all
-- >---


-- ># Oracle plsql BULK COLLECT
-- >* PLSQL provides  features for performance enhancements,
-- >* BULK COLLECT construct helps to retrieve multiple rows into a collection with a single 
-- >  fetch, thus improving the performance of an appliction.
-- >* The BULK COLLECT can be used with the LIMIT clause to further improve the 
-- >  performance. Where the number of rows retrived can be limited over iterations 
-- >  to use the system memory effectively. This is acheived by binding the output 
-- >  of the query to the collection.
-- >```sql
-- Create a table
drop table ti_test;

create table ti_test
(
   ti_id   int
  ,ti_date date
);
/

-- Insert data
insert into ti_test(ti_id, ti_date) 
select level,sysdate-level
from dual
connect by level < 100000;

-- check data load
select count(*) from ti_test;

-- Demonstrate BULK COLLECT and its performance
declare
  type t_ti_data_tab is table of ti_test%rowtype;
  l_ti_data_tab      t_ti_data_tab := t_ti_data_tab();
  l_start_sec        number(20);
  
begin
  -- Regular data loading into collection
  l_start_sec := dbms_utility.get_cpu_time;

  for cur_data in (select *
                  from   ti_test)
  loop
    l_ti_data_tab.extend;
    l_ti_data_tab(l_ti_data_tab.last) := cur_data;
  end loop;

  dbms_output.put_line('Data loading time into collection WITHOUT BULKCOLLECT: '
                       ||(dbms_utility.get_cpu_time - l_start_sec));
  
  -- Data loading into collection using BULK COLLECT
  l_start_sec := dbms_utility.get_time;


  select *
  bulk collect into l_ti_data_tab
  from   ti_test;

  dbms_output.put_line('Data loading time into collection WITH BULKCOLLECT: '
                       ||(dbms_utility.get_time - l_start_sec));
end;
/
-- >```


-- ># Oracle plsql BULK COLLECT with LIMIT clause
-- >* Using Bulk Collect with very large data sets is not advisable as it would load 
-- >  all the data in one shot causing memory issues.
-- >* The LIMIT clause helps limit the rows returned using the move data in smaller 
-->   chunks of rows as specified in the "limit <number>"
-- >```sql
-- Create/Re-Create a table
drop table ti_test;

create table ti_test
(
   ti_id   int
  ,ti_date date
);
/

-- Insert data
insert into ti_test(ti_id, ti_date) 
select level,sysdate-level
from dual
connect by level < 100000;

-- Check loaded data
select count(1) from ti_test;

-- 
declare
  l_ti_test_row ti_test%rowtype;
  
  type t_ti_test_tab is table of ti_test%rowtype;
  l_ti_test_tab  t_ti_test_tab;


  cursor cur_data is
  select *
  from   ti_test;

  l_start_sec number(20);
begin
  -- Regular cursor data loading into collection
  l_start_sec := dbms_utility.get_time;

  for cur_rec in cur_data
  loop
    l_ti_test_row := cur_rec;
  end loop;

  dbms_output.put_line('Cursor Data loading time into collection WITHOUT BULKCOLLECT: '
                       ||(dbms_utility.get_time - l_start_sec));


  -- BULK COLLECT cursor data loading into collection.
  -- Here we use the limit clause to fetch data in counts of "10000" using the 
  -- limit clause.
  l_start_sec := dbms_utility.get_time;

  open cur_data;
  loop
    fetch cur_data
    bulk collect into l_ti_test_tab limit 10000;
    exit when cur_data%notfound;
  end loop;
  close cur_data;

  dbms_output.put_line('Cursor Data loading time into collection WITH BULKCOLLECT: '
                       ||(dbms_utility.get_time - l_start_sec));
end;
/
-- >```


-- ># Oracle plsql FOR ALL
-- >  FOR ALL
-- >* The FOR ALL construct helps apply collection into any DML(Insert/Update/Delete)
-- >  statement
-- >```sql
-- Create/Re-Create a table
drop table ti_test;

create table ti_test
(
   ti_id   int
  ,ti_date date
);
/

-- Insert data
insert into ti_test(ti_id, ti_date) 
select level,sysdate-level
from dual
connect by level < 100000;

-- Check loaded data
select count(1) from ti_test;

-- Create/Re-Create a target table
drop table ti_target;
create table ti_target
(
   ti_id   int
  ,ti_date date
);
/

-- Load the ti_target table using the for all clause 
declare
  l_ti_test_row ti_test%rowtype;
  
  type t_ti_test_tab is table of ti_test%rowtype;
  l_ti_test_tab  t_ti_test_tab;


  cursor cur_data is
  select *
  from   ti_test;

  l_start_sec number(20);
begin
  -- Fetch Data into a collection using bulk collect
  open cur_data;
  loop
    fetch cur_data
    bulk collect into l_ti_test_tab
    limit 10000;
    
      -- Call the FOR ALL in the loop of the LIMIT
      forall i in 1 .. l_ti_test_tab.count
        insert into ti_target values l_ti_test_tab(i);
        
    exit when cur_data%notfound;
  end loop;
  close cur_data;
  
  dbms_output.put_line(l_ti_test_tab.count);

end;
/
delete ti_target;
select count(1) from ti_target;
-- >```
