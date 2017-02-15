-- >---
-- >title: Oracle plsql refcursors
-- >metadata:
-- >    description: 'Oracle Refcursors '
-- >    keywords: 'Oracle Refcursors, example code, tutorials'
-- >author: Venkata Bhattaram / tinitiate.com
-- >code-alias: Refcursors
-- >slug: oracle/plsql/refcursors
-- >---

-- ># Oracle RefCursors
-- >* Ref Cursor is a type that holds row data or recordsets to be used as out 
-- >  parameters for procedures and return types for functions.
-- >* Oracle supports a native predefined type SYS_REFCURSOR.

-- >## Ref Cursor example with procedure
-- >```sql
-- Create a procedure with refcursor as out parameter
-- The data type of the return value is "SYS_REFCURSOR"
create or replace procedure refcur_pr (p_refcursor out sys_refcursor) 
as 
begin

  open p_refcursor 
  for
  select  level                             ti_id
         ,dbms_random.string('a',10)        ti_data
         ,sysdate-dbms_random.value(0,300)  ti_date
  from   dual
  connect by level < 11;

end refcur_pr;
/
-- >```


-- >## Reading or using a Ref Cursor procedure OUT parameter example
-- >* From the above procedure refcur_pr, the below code reads the ref cursor data
-- >```sql
declare
  -- Variables and their types to read the data 
  -- Create the "sys_refcursor" datatype variable to capture the 
  -- procedure OUT parameter
  l_ref_cursor  sys_refcursor;
  
  l_ti_id       int;
  l_ti_data     varchar2(100);
  l_ti_date     date;

begin
  
  refcur_pr (p_refcursor => l_ref_cursor);

  loop 
    fetch l_ref_cursor
    into  l_ti_id, l_ti_data, l_ti_date;
    
    exit when l_ref_cursor%notfound;
    dbms_output.put_line(l_ti_id || ' - ' || l_ti_data || ' - ' || l_ti_date);
  
  end loop;
  
  close l_ref_cursor;
end;
/
-- >```


-- >## Ref Cursor example with function
-- >```sql
create or replace function refcur_fn 
return sys_refcursor
as 
  p_refcursor sys_refcursor;
begin

  open p_refcursor 
  for
  for
  select  level                             ti_id
         ,dbms_random.string('a',10)        ti_data
         ,sysdate-dbms_random.value(0,300)  ti_date
  from   dual
  connect by level < 11;

  return p_refcursor;

end refcur_fn;
/
-- >```


-- >## Reading or using a Ref Cursor function return value example
-- >* From the above function refcur_pr, the below code reads the ref cursor data
-- >```sql
declare
  -- Variables and their types to read the data 
  -- Create the "sys_refcursor" datatype variable to capture the 
  -- procedure OUT parameter
  l_ref_cursor  sys_refcursor;
  
  l_ti_id       int;
  l_ti_data     varchar2(100);
  l_ti_date     date;

begin
  
  -- Assign the function to the variable
  l_ref_cursor := refcur_fn;

  -- Execute the loop
  loop 
    fetch l_ref_cursor
    into  l_ti_id, l_ti_data, l_ti_date;
    
    exit when l_ref_cursor%notfound;
    dbms_output.put_line(l_ti_id || ' - ' || l_ti_data || ' - ' || l_ti_date);
  
  end loop;
  
  close l_ref_cursor;
end;
/
-- >```
