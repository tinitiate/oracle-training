-- >---
-- >title: Oracle plsql objects
-- >metadata:
-- >    description: 'Oracle objects are composite datatypes, with data elements in them.'
-- >    keywords: 'Oracle objects example code, tutorials'
-- >author: Venkata Bhattaram / tinitiate.com
-- >code-alias: objects
-- >slug: oracle/plsql/objects
-- >---

-- ># Oracle plsql objects
-- >* Oracle supports objected oriented programming with the help of Objects 
-- >* Objects are attributes(variables/data) and methods (functionality that can
-- >  operate on the attributes.)

-- >## Object in PLSQL
-- >```sql
-- Step 1. Create an object type
create or replace type t_country as object 
(
     country_name  varchar2(100)
    ,capital_name  varchar2(100)
    ,population    varchar2(100)
);
/

-- Step 2. Using objects in PLSQL code
-- this anynomous block uses the t_country as a type for a variable
declare
    -- Create a variable l_usa as type t_country
    l_usa t_country;
    
begin
    -- Add values to l_usa objects member attributes
    l_usa := t_country('USA', 'Washington D.C','300000000');
    
    -- Printing values from the object
    dbms_output.put_line('Details of USA ' || 
                         ' Capital: '      || l_usa.capital_name ||
                         ' Population: '   || l_usa.population);
end;
/

drop type t_country;
-- >```

-- >## Nested objects
-- >* Nested Objects are object with in another object
-- >```sql
-- Step 1. Create TWO objects t_country and t_city, t_city has a attribute 
-- with t_country as its datatype
create or replace type t_country as object 
(
     country_name  varchar2(100)
    ,capital_name  varchar2(100)
    ,population    varchar2(100)
);
/

-- Create a City Object with its details, and nested country details
create or replace type t_city as object 
(
     city_name        varchar2(100)
    ,state_name       varchar2(100)
    ,country_details  t_country
);
/

-- Step 2. Using objects in PLSQL code
-- this anynomous block uses the t_city as a type for a variable
declare
    -- Create a variable l_newyork as type t_city
    l_newyork t_city;
    
begin
    -- Add values to l_usa objects member attributes
    l_newyork := t_city('New York', 'New York', t_country('USA', 'Washington D.C','300000000'));
    
    -- Printing values from the object
    -- To read the NESTED object attribute use OBJECT.NESTED-OBJECT.ATTREIBUTE
    dbms_output.put_line('Details of New York City ' || 
                         ' State Name: '             || l_newyork.state_name ||
                         ' Country Name: '           || l_newyork.country_details.country_name
                         );
end;
/

-- Drop both the objects
drop type t_city;
drop type t_country;
-- >```


-- >## Objects and Nested Objects in tables
-- >* Objects can be used as table column values
-- >```sql
create or replace type t_country as object 
(
     country_name  varchar2(100)
    ,capital_name  varchar2(100)
    ,population    varchar2(100)
);
/

-- Create a City Object with its details, and nested country details
create or replace type t_city as object 
(
     city_name        varchar2(100)
    ,state_name       varchar2(100)
    ,country_details  t_country
);
/

-- Create a table with these objects as datatypes for some of its columns
create table ti_city
(   
    city_id       int
   ,city_details  t_city
);

-- Insert rows with Object type
insert into ti_city (city_id,city_details) 
values (1,t_city('Austin', 'Texas', t_country('USA', 'Washington D.C','300000000')));

insert into ti_city (city_id,city_details) 
values (2,t_city('Dallas', 'Texas', t_country('USA', 'Washington D.C','300000000')));

-- Select rows with Object type
select *
from   ti_city;

-- Select object and nested object columns
-- Here we MUST supply a table alias
select  city_id 
       ,tc.city_details.city_name                     -- Object Attribute
       ,tc.city_details.country_details.country_name  -- Nested Object Attribute
from   ti_city tc;

-- Update rows with Object type
-- Make sure an alias for the table is given
update ti_city tc
set    tc.city_details.city_name = 'San Antonio'
where  tc.city_details.city_name = 'Dallas';


-- Update Nested Object type row
-- Make sure an alias for the table is given
update ti_city tc
set    tc.city_details.country_details.capital_name = 'D.C'
where  tc.city_id                                   = 2;


-- Select to check changes
select  city_id 
       ,tc.city_details.city_name                     -- Object Attribute
       ,tc.city_details.country_details.country_name  -- Nested Object Attribute
       ,tc.city_details.country_details.capital_name  -- Nested Object Attribute
from   ti_city tc;  

-- Delete rows with Object type
delete from ti_city tc
where  tc.city_details.country_details.capital_name = 'D.C';


-- Select object and nested object columns
select  city_id 
       ,tc.city_details.city_name                     -- Object Attribute
       ,tc.city_details.country_details.country_name  -- Nested Object Attribute
       ,tc.city_details.country_details.capital_name  -- Nested Object Attribute
from   ti_city tc;  


drop table ti_city;
drop type t_city;
drop type t_country;
-- >```


-- >### Object Member functions
-- >* Objects support methods or functions with in them apart from attributes
-- >* Member methods can be used for using attribut data of the object.
-- >* Member methods are declared in the object type and the code for the member method
-- >  can be written the object body, which is created with the CREATE TYPE BODY statement.

-- >```sql
-- Example for a calc object with TWO attributes and simple math member methods
create or replace type ti_calc as object
(
   -- These are the attributes
    num1 int,
    num2 int,
   
   -- Member function method declaration
   member function getSum return int,
   member function getMul return int,
   
   -- Member procedure method declaration
   member procedure getDiff(p_diff out int)
);
/

create or replace type body ti_calc 
as

    -- Function Code
    member function getSum
      return int 
      is
    begin
      -- Add the member attributes num1 and num2
      -- and return value
      return num1+num2; 

    end getSum;


    -- Function Code
    member function getMul
      return int 
      is
    begin
      -- Multiply the member attributes num1 and num2
      -- and return value
      return num1*num2; 
      
    end getMul;

  
    -- Procedure Code
    member procedure getDiff(p_diff out int)
    as
    begin
      -- Subtract the member attributes num1 and num2
      -- and assign value to out parameter p_diff
      p_diff := num1 - num2;
    
    end getDiff;
end;
/

-- Using the Object
declare
  
  -- create a variable of type ti_calc
  l1     ti_calc;
  l_val  int;
begin
  
  -- Assign values to the member attributes of l1
  l1 := ti_calc(100, 50);

  -- Use member function methods
  dbms_output.put_line('getMul funtion: '|| l1.getMul);
  dbms_output.put_line('getSum funtion: '|| l1.getSum);

  -- Use member procedure methods, assign out parameter to l_val
  l1.getDiff(l_val);
  dbms_output.put_line('getSum funtion: '|| l_val);

end;
/

-- Drop the objects
drop type ti_calc;
-- >```


-- >## Object comparision
-- >* Unlike variables objects dont have predefined data type such as CHAR or INT,
-- >  This makes the which makes it difficult to compare objects.
-- >* But an object type, have multiple attributes of various data types and there
-- >  is no predefined axis of comparison. 
-- > * The programmer has an option to define an map method or an order method 
-- >   for comparing objects, with these methods we can write our own 
-- >   comparision methods.

-- >### Object comparision with MAP method
-- >* Map methods return values that can be used for comparing and sorting.
-- >* The MUST not return LOBs, BFILE and binary data

create or replace type ti_square as object 
( 
  -- Member attribute length of square side
  side_length number,

  -- Member function to get the square area
  -- Using the KEYWORD map to create the VALUE of the OBJECT for comparision
  map member function getArea return number
);
/

create or replace type body ti_square 
as 

  -- Using the KEYWORD map to create the VALUE of the OBJECT for comparision
  map member function getArea return number
  as
  begin
     return side_length * side_length;
  end getArea;
end;
/


declare

  -- Create TWO variables for comparision
  sq_1 ti_square := ti_square(5);
  sq_2 ti_square := ti_square(6);
  sq_3 ti_square := ti_square(5);
  
begin
  
  -- Objects Comparision with the MAP method
  -- NOTE there are no Object attributes used here.
  if(sq_1 = sq_2)
  then
    dbms_output.put_line('SQ_1 and SQ_2 are EQUAL');
  else
    dbms_output.put_line('SQ_1 and SQ_2 are NOT EQUAL');
  end if;
  
  if(sq_2 = sq_3)
  then
    dbms_output.put_line('SQ_2 and SQ_3 are EQUAL');
  else
    dbms_output.put_line('SQ_2 and SQ_3 are NOT EQUAL');
  end if;
  
  -- Here "SQ_3 and SQ_1 are EQUAL" is printed as the area values are same
  -- and that is what the MAP member uses when objects are compared.
  if(sq_3 = sq_1)
  then
    dbms_output.put_line('SQ_3 and SQ_1 are EQUAL');
  else
    dbms_output.put_line('SQ_3 and SQ_1 are NOT EQUAL');
  end if;  

end;
/

-- drop the object
drop type ti_square;
-- >```


-- >### Object comparision with ORDER method
-- >* ORDER methods return values that can be used for comparing and sorting.
-- >* The MUST not return LOBs, BFILE and binary data
-- >* Order methods make direct one-to-one object comparisons. Unlike map methods,
-- >  they cannot determine the order of a number of objects. 

-- ```sql
create or replace type ti_square as object 
( 
  -- Member attribute length of square side
  side_length number,

  -- Member function to get the square area
  -- Using the KEYWORD order to create the VALUE of the OBJECT for comparision
  order member function compareArea(p_obj in ti_square) return number
);
/

create or replace type body ti_square 
as 

  -- Using the KEYWORD order to create the VALUE of the OBJECT for comparision
  order member function compareArea(p_obj in ti_square) return number
  as
  begin
     if (p_obj.side_length * p_obj.side_length = side_length * side_length)
     then
         return 0;
     elsif (p_obj.side_length * p_obj.side_length > side_length * side_length)
     then
         return 1;
     elsif (p_obj.side_length * p_obj.side_length < side_length * side_length) 
     then
         return -1;
     end if;
     
  end compareArea;
end;
/

declare

  -- Create TWO variables for comparision
  sq_1 ti_square := ti_square(5);
  sq_2 ti_square := ti_square(6);
  
begin
  
  -- Objects Comparision with the MAP method
  -- NOTE there are no Object attributes used here.
  if(sq_1.compareArea(sq_2) = 0)
  then
      dbms_output.put_line('sq_1 = sq_2');
  -- This value is printed.
  elsif(sq_1.compareArea(sq_2) = 1)
  then
      dbms_output.put_line('sq_1 < sq_2');
  elsif(sq_1.compareArea(sq_2) = -1)
  then
      dbms_output.put_line('sq_1 > sq_2');
  end if;
  
end;
/

-- drop the object
drop type ti_square;
-- >```
