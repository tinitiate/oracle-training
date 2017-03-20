-- >---
-- >title: Oracle plsql cursors
-- >metadata:
-- >    description: 'Oracle cursors '
-- >    keywords: 'Oracle cursors, example code, tutorials'
-- >author: Venkata Bhattaram / tinitiate.com
-- >code-alias: cursors
-- >slug: oracle/plsql/cursors
-- >---

-- ># Oracle PLSQL cursors
-- >* Cursor is a temporary work area in the system memory for an executing SQL 
-- >  statement. It contains data, the data types of the data, rows count of data.
-- >* There are TWO types of cursors IMPLICIT and EXPLICIT
-- >* **IMPLICIT CURSORS**
-- >  * implicit cursors are automatically created by oracle whenever an sql 
-- >    statement is executed.
-- >* **EXPLICIT CURSORS**
-- >  * explicit cursors are programmer created for the execution of an sql 
-- >    statement. All actions such as creating the cursor, fetching data from the 
-- >    cursor and closing the cursor are handled by the code and not automatically.


-- >## Create a table and data for IMPLICIT / EXPLICIT cursors demonstration
-- >```
-- Create same table and data
set serverout on;
-- Drop the test data table, if exists

begin
  execute immediate 'drop table tinitiate_tab';
exception 
  when others then
  null;
end;
/
-- create a test data table with three different datatypes.
create table tinitiate_tab
(
  ti_id    int,
  ti_data  varchar2(20),
  ti_date  date
);

-- insert NINE rows into the tinitiate_tab table
insert into tinitiate_tab (ti_id, ti_data, ti_date)
select  level, decode(trunc((level-1)/3), 0, 'A'||level
                                        , 1, 'B'||level
                                        , 2, 'C'||level)
        ,sysdate-level
from    dual
connect by level < 10;
commit;

-- check if the data is created
select * from tinitiate_tab;
-- >```


-- >## Implicit Cursor
-- >* Implicit cursors are automatically created by oracle whenever an sql 
-- >  statement is executed.
-- >* Create an implicit cursor to read data from the table into PLSQL
-- >* Working with individual row-column data of various data types.

-- >```
set serverout on
declare
    -- Create a cursor using the keyword cursor
    cursor cur_tidata is
    select *
    from   tinitiate_tab;

    -- variables to capture the column data
    -- Here for the declared variables we use the data type of the table column
    -- rather than explicitly mentioning int, varchar and date.
    l_ti_id     tinitiate_tab.ti_id%type;
    l_ti_data   tinitiate_tab.ti_data%type;
    l_ti_date   tinitiate_tab.ti_date%type;
    
    -- Here we create a ROWTYPE variable to capture the entire row
    l_tinitiate_tab_row tinitiate_tab%rowtype;
    
begin
    -- Open the implicit cursor in a for loop
    for lp_var in cur_tidata
    loop
        -- Capturing the data from the implicit cursor and fetching them to an 
        -- individual variable and print them in the dbms_output
        l_ti_id   := lp_var.ti_id;
        l_ti_data := lp_var.ti_data;
        l_ti_date := lp_var.ti_date;
        
        dbms_output.put_line('tinitiate_tab row data column%type from implicit cursor: '||
                             l_ti_id ||' '|| l_ti_data ||' '|| l_ti_date);
        
        -- Capturing the data from the implicit cursor and fetching them to an 
        -- row level variable and print them in the dbms_output
        l_tinitiate_tab_row := lp_var;
        dbms_output.put_line('tinitiate_tab row data %rowtype from implicit cursor: '||
                             l_tinitiate_tab_row.ti_id   ||' '|| 
                             l_tinitiate_tab_row.ti_data ||' '|| 
                             l_tinitiate_tab_row.ti_date);

    end loop;
end;
-- >```

-- >## Explicit Cursor
-- >* explicit cursors are programmer created for the execution of an sql 
-- >  statement. All actions such as creating the cursor, fetching data from the 
-- >  cursor and closing the cursor are handled by the code and not automatically.
-- >* Create an explicit cursor to fetch data to read and use it, 
-- >  from the table into PLSQL code.
-- >* Working with individual row-column data of various data types.
-- >* Explicit cursors have cursor attributes which can be used to analyze the 
-- >  cursor programatically
-- >* %ISOPEN Returns TRUE if the cursor is open and FALSE if closed.
-- >* %FOUND	 must be used after the cursor is opened and fetch executed, 
-- >  returns TRUE if cursor has any row data and returns FALSE if no rows 
-- >  are returned.
-- >* %NOTFOUND must be used after the cursor is opened and fetch executed,
-- >  returns FALSE if cursor has any row data and returns TRUE if no rows 
-- >  are returned.
-- >* %ROWCOUNT must be used after the cursor is opened and fetch executed, 
-- >  Returns the row count of the number of rows fetched.

-- >```
declare
    -- Create a cursor using the keyword cursor
    cursor cur_tidata is
    select *
    from   tinitiate_tab;
    
    -- create local variables to hold the cursor data
    -- variables to capture the column data
    -- Here for the declared variables we use the data type of the table column
    -- rather than explicitly mentioning int, varchar and date.
    l_ti_id     tinitiate_tab.ti_id%type;
    l_ti_data   tinitiate_tab.ti_data%type;
    l_ti_date   tinitiate_tab.ti_date%type;
    
    -- Here we create a ROWTYPE variable to capture the entire row
    l_tinitiate_tab_row tinitiate_tab%rowtype;
begin
    -- Open the explicit cursor using the open statement
    open cur_tidata;
        
    -- Loop through the cursor
    loop
        -- Fetch the cursor data into local variables
        -- the fetch works like an iterator and gets the data row by row 
        -- ,hence it should be in a loop
        fetch cur_tidata into l_ti_id, l_ti_data, l_ti_date;
        
        -- The %rowcount cursor attribute gets the number of rows fetched 
        -- from the cursor
        dbms_output.put_line(cur_tidata%rowcount);
            
        -- check if data exists and exit the loop if there is no data
        -- in the cursor, using the %notfound cursor attribut
        exit when cur_tidata%notfound;
        
        -- use the fetched data
        -- here we print the data out
          dbms_output.put_line('tinitiate_tab row data column%type from implicit cursor: '||
                               l_ti_id ||' '|| l_ti_data ||' '|| l_ti_date);
    end loop;
    
    -- Once the loop is completed make sure to close the cursor to 
    -- freeup the memory
    close cur_tidata;
end;

-- >```



