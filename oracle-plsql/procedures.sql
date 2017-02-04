-- >---
-- >title: Oracle plsql procedures
-- >metadata:
-- >    description: 'Oracle procedures '
-- >    keywords: 'Oracle procedures, stored procedures example code, tutorials'
-- >author: Venkata Bhattaram / tinitiate.com
-- >code-alias: procedures
-- >slug: oracle/plsql/procerdures
-- >---

-- ># Oracle Procedures
-- >* Procedure is a database object(anything that is stored in the database)
-- >   Its basically a code block performing a specific task and has a name.
-- >* Procedures are created under a SCHEMA or a user in the oracle database.
-- >* They can accept inputs in through **IN** parameters
-- >* And they can pass outputs through **OUT** parameters

-- >```sql
-- Create procedure
create or replace procedure myproc
as
begin
  
  -- Print the current day name
  dbms_output.put_line(to_char(sysdate,'DAY'));

exception
  when others then
    null;
end;  
/

-- Execute the procedure
begin
  myproc;
end;
/

-- Dro procedure command
drop procedure myproc;
-- >```

-- >## procedure with IN, OUT and IN OUT parameters
-- >* Procecure can have IN, OUT and IN OUT parameters
-- >```sql
create or replace procedure adder( num1 in  int
                                  ,num2 in  int
                                  ,res  out int)
as
begin
  -- add num1 and num2 and store in res OUT parameter
  res := num1 + num2;
exception
when others then
  null;

end adder;
/


-- Execute the procedure
declare
  -- variables to pass data to the IN parameters
  l_num1   int := 10;
  l_num2   int := 20;
  
  -- variable to store result from the OUT parameter
  l_result int;
begin

  -- Call the procedure
  adder(l_num1,l_num2,l_result);
  dbms_output.put_line(l_result);
  -- The prints 30
end;
/

-- drop the procedure
drop procedure adder;
-- >```

-- ># Procedure with NOCOPY hint
-- >* OUT and IN OUT parameters values are passed by value in oracle.
-- >* Pass By Value, store parameter value in a temporary buffer, and use the 
-- >  temporary buffer in the procedure.
-- >* By using **NOCOPY** there is no temporary buffer used and the actual 
-- >  parameter is used through out the procedure, thus saving CPU and memory 
-- >  overhead and making the process faster.
-- >* Since there is no temp buffer, any changes made to the parameter value 
-- >  will be reflected outside the code as well
-- >* Using NOCOPY is ideal for parameters with heavy datasets like refcursors
--
-- >```sql
-- create a procedure with a nocopy parameter
create or replace procedure myproc(p_data in out nocopy int)
as
begin
  p_data := 1000*p_data;
end myproc;
/

declare
  l_data int := 1000;
begin
  
  -- Display value of l_data before calling proc
  dbms_output.put_line(l_data);
  -- 1000
  
  
  myproc(l_data);
  
  
  -- Display value of l_data after calling proc
  dbms_output.put_line(l_data);
  -- 1000000
  
end;
/

drop procedure myproc;
-- >```
