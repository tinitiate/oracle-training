-- >---
-- >title: Oracle Bind Variables
-- >metadata:
-- >    description: 'Oracle Bind Variables'
-- >    keywords: 'Oracle Bind Variables, example code, tutorials'
-- >author: Venkata Bhattaram / tinitiate.com
-- >code-alias: bind-variables
-- >slug: oracle/plsql/bind-variables
-- >---

-- ># Oracle Bind Variables
-- >* In any SQL statement the lieral values passed to it are HARD PARSED, which is 
-- >  CPU intensive. Oracle Bind variables, are substitution for the literals, 
-- >  where only the first parse is hard parse and all subsequent parse of the 
-- >  select statments will be faster.
-- >* Oracle Bind variables, are best used in Dynamic SQL.
-- >* Regular PL/SQL where there is no HardCoding of values in the joins "=" clause
-- >  we use bind variables
-- >* When Oracle Does a Hard Parse it takes more CPU 
-- >  and Obtaining Latches (LOW LEVL CPU Locks) on shared Memory
-- >* Dont use Bind Variables if the SQL in the dynamic query changes often.


-- >```sql
-- Hard Parse to Count a large values
-- Performance here is SLOWER
declare
   l_count int;
   l_start_time date;
   l_end_time date;
begin
   l_start_time := sysdate;
   --
   for c1 in 1 .. 4
   loop
      -- Get the Counts by decreasing 1 in each iteration
      select count(1) into l_count from dual connect by level < 1000000 - c1;
      dbms_output.put_line('Parse '|| c1 ||' - l_count: '||l_count);   
   end loop;
   --
   l_end_time := sysdate;
   dbms_output.put_line('Time Taken in Secs: '|| to_char((l_end_time - l_start_time))*(24*60*60));
end;
/

--
-- Soft Parse to Count a large values, Using Bind Variables
-- Performance here is FASTER
declare
   l_value int:= 1000000;
   l_count int;
   l_sql varchar2(2000) := 'select count(1) from dual connect by level < :x';
   l_start_time date;
   l_end_time date;
begin
   l_start_time := sysdate;
   --
   for c1 in 1..4
   loop
      -- Get the Counts by decreasing 1 in each iteration
      execute immediate  l_sql
      into    l_count
      using   l_value - c1;
      --
      dbms_output.put_line('Parse '|| c1 ||' - l_count: '||l_count);
      --
   end loop;
   --
   l_end_time := sysdate;
   dbms_output.put_line('Time Taken in Secs: '|| to_char((l_end_time - l_start_time))*(24*60*60));
end;
/
-- >```


-- >## Oracle Bind Variables: Using bind variable with cursor
-- >```sql
-- Using bind variable with cursor
--
declare
   type  refCur is ref cursor;
   l_cur refCur;
   l_value int:= 1000000;
   l_count int;
   l_sql varchar2(2000) := 'select count(1) from dual connect by level < :x';
   l_start_time date;
   l_end_time date;
begin
   l_start_time := sysdate;
   for c1 in 1..4
   loop
      -- Get the Counts by decreasing 1 in each iteration
      open   l_cur for l_sql
      using  l_value - c1;
      fetch  l_cur into l_count;
      close  l_cur;
      --
      dbms_output.put_line('Parse '|| c1 ||' - l_count: '||l_count);
      --
   end loop;
   l_end_time := sysdate;
   dbms_output.put_line('Time Taken in Secs: '|| to_char((l_end_time - l_start_time))*(24*60*60));
end;
/
-- >```


-- >## Oracle Bind Variables: Fetch into Multiple Variables, using one bind variable
-- >```sql
-- Fetch into Multiple Variables, using one bind variable
--
declare
   type  refCur is ref cursor;
   l_cur refCur;
   l_value int:= 1000000;
   l_col1 int;
   l_col2 int;   
   l_sql varchar2(2000):=
'select  count(1)     as Col1
         ,count(1)-100 as Col2 
from   dual connect by level < :x';

   l_start_time date;
   l_end_time date;
begin
   l_start_time := sysdate;
   for c1 in 1..4
   loop
      -- Get the Counts by decreasing 1 in each iteration
      open   l_cur for l_sql
      using  l_value - c1;
      -- fetch into multiple values
      fetch  l_cur into l_col1,l_col2;
      close  l_cur;
      --
      dbms_output.put_line('Parse '|| c1 ||' - l_col1: '|| l_col1 ||' l_col2: '||l_col2);
      --
   end loop;
   l_end_time := sysdate;
   dbms_output.put_line('Time Taken in Secs: '|| to_char((l_end_time - l_start_time))*(24*60*60));
end;
/
-- >```


-- >## Oracle Bind Variables: Using Multiple Variables
-- >```sql
-- Using Multiple Variables
--
declare
   l_bind_var1 int := 1;
   l_bind_var2 int := 300;
   l_count     int;
begin
   -- Using Multiple Bind variables, use the USING clause in the order of the ":Bind Variable" appearence.
   execute immediate 'select count(level) from dual connect by level between :1 and :2'
   into    l_count
   using   l_bind_var1   -- For :1
          ,l_bind_var2;  -- For :2
   -- Make sure you pass the correct order in USING clause
   --
   dbms_output.put_line('Count Value: '||l_count);
   --
end;
/
-- >```
