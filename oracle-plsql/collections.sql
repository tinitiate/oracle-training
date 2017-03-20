-- >---
-- >title: Oracle plsql collections
-- >metadata:
-- >    description: 'Oracle collections, Index-by tables, Associative array, Nested table, Varray'
-- >    keywords: 'Oracle collections, Index-by tables, Associative array, Nested table, Varray'
-- >author: Venkata Bhattaram / tinitiate.com
-- >code-alias: collections
-- >slug: oracle/plsql/collections
-- >---

-- ># Oracle PLSQL Collections
-- >*Collections, are set of values called elements, of the same data type.
-- >* Lists and arrays are classic examples of collections.
-- >* Oracle PLSQL supports THREE types of collections
-- >* Index-by tables or Associative arrays
-- >* Nested Table
-- >* VARRAYS


-- ># Oracle PLSQL Index-by tables or Associative arrays
-- >* **Index-by tables** or **Associative Array** is a set of key-value pairs of data
-- >  where the key is the index of the data.
-- >* These "types" come with builtin functions that perform various actions, such as

-- >```sql
-- Example for types
declare
   -- This is the syntax of Index-by tables 
   -- Here the KEY is a Number by default
   -- The VALUE is number(10)
   type ti_number_data is table of number(10) index by binary_integer;
   
   
   -- This is the syntax of Index-by tables 
   -- Here the KEY is a Number by default
   -- The VALUE is varchar2(100)
   type ti_name_data is table of index by varchar2(100);


   -- Declare variables using the index by types
   l_number_data ti_number_data;
   l_name_data   ti_name_data;

begin

   -- Add values by supplying KEY-VALUE (1)-200 and (2)-300 in the below case and values
   l_number_data(1) := 200;
   l_number_data(2) := 300;

   -- Adding values using a loop
   for l_key in 3..5
   loop
     l_number_data(l_key) := 100*l_key;
   end loop;

   -- Print the values of the collection
   dbms_output.put_line(l_number_data(1));
   dbms_output.put_line(l_number_data(2));
   dbms_output.put_line(l_number_data(3));
   dbms_output.put_line(l_number_data(4));
   dbms_output.put_line(l_number_data(5));

end;
/
-- >```


-- >## Collection Methods Supported by Index-by tables or Associative arrays
-- >* Collection Methods
-- >  ** EXISTS
-- >  ** COUNT
-- >  ** LIMIT
-- >  ** FIRST and LAST
-- >  ** PRIOR and NEXT
-- >  ** DELETE
-- >```sql

declare
   -- This is the syntax of Index-by tables 
   -- Here the KEY is a Number by default
   -- The VALUE is number(10)
   type ti_number_data is table of number(10) index by binary_integer;

   -- Create a variable of this type
   l_number_data ti_number_data;
   
   l_element     number(10);
   l_key         int;
begin
   -- Add values by supplying KEY-VALUE (1)-200 and (2)-300 in the below case and values
   l_number_data(1) := 200;
   l_number_data(2) := 300;
   l_number_data(3) := 400;
   l_number_data(4) := 500;
   
   -- EXISTS
   -- EXISTS(n) returns TRUE if nth KEY in a collection exists; else returns FALSE.
   if l_number_data.exists(3)
   then
     dbms_output.put_line('Key 3 exists');
   else
     dbms_output.put_line('Key 3 doesnt exist');
   end if;
     
   if l_number_data.exists(6)
   then
     dbms_output.put_line('Key 6 exists');
   else
     dbms_output.put_line('Key 6 doesnt exist');
   end if;
    
   
   -- COUNT
   -- COUNT returns the current number of elements in a collection.
   dbms_output.put_line('Count of elements in l_number_data: '||l_number_data.count);
   
   
   -- FIRST
   -- LAST
   -- For an associative array or indexed by types, the FIRST and LAST returns the 
   -- lowest and highest key values.
   dbms_output.put_line('The lowest KEY value in l_number_data: '||l_number_data.first);
   dbms_output.put_line('The highest KEY value in l_number_data: '||l_number_data.last);     
   
      
   -- NEXT
   -- NEXT(n) returns the index number that succeeds index n.
   -- If n has no successor, NEXT(n) returns NULL.
   l_key := l_number_data.first;
   l_element := l_number_data(l_key);
   
   while l_key is not null
   loop
     dbms_output.put_line('key: '||l_key||' Element: '||l_element);
     
     -- Get Key and its Element
     l_key := l_number_data.next(l_key);

     -- Exit loop if l_key is NULL
     if l_key is null
     then
       exit;
     end if;
     
     l_element := l_number_data(l_key);
   end loop;
   
   
   dbms_output.put_line('Using Prior to print elements in reverse');
   
   
   -- PRIOR 
   -- PRIOR(n) returns the index number that precedes index n in a collection. 
   -- If n has no predecessor, PRIOR(n) returns NULL.
   l_key     := l_number_data.last;
   l_element := l_number_data(l_key);
   
   while l_key is not null
   loop
     dbms_output.put_line('key: '||l_key||' Element: '||l_element);
     
     -- Get Key and its Element
     l_key := l_number_data.prior(l_key);
     
     -- Exit loop if l_key is NULL
     if l_key is null
     then
       exit;
     end if;
       
     l_element := l_number_data(l_key);
   end loop;
   
   
   -- DELETE
   -- DELETE(n) removes the key and its element
   l_number_data.delete(1);
   
   -- Check if it is deleted using exists
   if l_number_data.exists(1)
   then
     dbms_output.put_line('Key 1 exists');
   else
     dbms_output.put_line('Key 1 deleted');
   end if;   
   
   
end;
/
-- >```



-- ># Oracle PLSQL Nested Tables
-- >* **Nested tables** is a one-dimensional array with an arbitrary number of elements.
-- >* The size of a nested table can increase dynamically, nested array is dense initially,
-- >  which is the Index is continous, but it can become sparse (where elements would
-- >  not be continous) when elements are deleted from it.

-- >```sql
-- Example for types
declare
   -- This is the syntax of Nested tables of number(10) data elements
   -- Here the KEY is a integer by default
   type ti_number_data is table of number(10);

   -- Declare variables using the index by types
   l_number_data ti_number_data;
begin

   -- Initial values to nested table collection
   l_number_data := ti_number_data(100, 200, 300, 400, 500);

   -- Adding elements
   -- Use the "EXTEND" method
   l_number_data.extend;
   l_number_data(l_number_data.last) := 600;
   
   -- Adding values using a loop
   for l_key in l_number_data.first .. l_number_data.last
   loop
     dbms_output.put_line(l_number_data(l_key));
   end loop;

end;
/
-- >```


-- >## Collection Methods Supported by Nested Tables
-- >* Collection Methods
-- >  ** EXISTS
-- >  ** COUNT
-- >  ** LIMIT
-- >  ** FIRST and LAST
-- >  ** PRIOR and NEXT
-- >  ** DELETE
-- >  ** EXTEND
-- >  ** TRIM
-- >```sql

declare
   -- This is the syntax of nested tables 
   -- Here the KEY is a Number by default
   -- The VALUE is number(10)
   type ti_number_data is table of number(10);

   -- Create a variable of this type
   l_number_data ti_number_data;
   
   l_element     number(10);
   l_key         int;
begin
   -- Add values by supplying KEY-VALUE (1)-200 and (2)-300 in the below case and values
   l_number_data :=  ti_number_data(100, 200, 300, 400, 500);
   
   
   -- EXTEND
   -- EXTEND adds an empty key in the end, which can be referenced by var.LAST
   -- EXTEND appends one null element to a collection.
   -- EXTEND(n) appends n null elements to a collection.
   -- EXTEND(n,i) appends n copies of the ith element to a collection.   
   l_number_data.extend;
   -- Here we add 600 to as the element value of the last KEY
   l_number_data(l_number_data.last) := 600;
   
   l_number_data.extend(700);
   
   for i in l_number_data.first .. l_number_data.last
   loop
     dbms_output.put_line(l_number_data(i));
   end loop;
   
   
   -- EXISTS
   -- EXISTS(n) returns TRUE if nth KEY in a collection exists; else returns FALSE.
   if l_number_data.exists(3)
   then
     dbms_output.put_line('Key 3 exists');
   else
     dbms_output.put_line('Key 3 doesnt exist');
   end if;
     
   if l_number_data.exists(6)
   then
     dbms_output.put_line('Key 6 exists');
   else
     dbms_output.put_line('Key 6 doesnt exist');
   end if;
    
   
   -- COUNT
   -- COUNT returns the current number of elements in a collection.
   dbms_output.put_line('Count of elements in l_number_data: '||l_number_data.count);
   
   
   -- FIRST
   -- LAST
   -- For an associative array or indexed by types, the FIRST and LAST returns the 
   -- lowest and highest key values.
   dbms_output.put_line('The lowest KEY value in l_number_data: '||l_number_data.first);
   dbms_output.put_line('The highest KEY value in l_number_data: '||l_number_data.last);     
   
      
   -- NEXT
   -- NEXT(n) returns the index number that succeeds index n.
   -- If n has no successor, NEXT(n) returns NULL.
   l_key := l_number_data.first;
   l_element := l_number_data(l_key);
   
   while l_key is not null
   loop
     dbms_output.put_line('key: '||l_key||' Element: '||l_element);
     
     -- Get Key and its Element
     l_key := l_number_data.next(l_key);

     -- Exit loop if l_key is NULL
     if l_key is null
     then
       exit;
     end if;
     
     l_element := l_number_data(l_key);
   end loop;
   
   
   dbms_output.put_line('Using Prior to print elements in reverse');
   
   
   -- PRIOR 
   -- PRIOR(n) returns the index number that precedes index n in a collection. 
   -- If n has no predecessor, PRIOR(n) returns NULL.
   l_key := l_number_data.last;
   l_element := l_number_data(l_key);
   
   while l_key is not null
   loop
     dbms_output.put_line('key: '||l_key||' Element: '||l_element);
     
     -- Get Key and its Element
     l_key := l_number_data.prior(l_key);
     
     -- Exit loop if l_key is NULL
     if l_key is null
     then
       exit;
     end if;
       
     l_element := l_number_data(l_key);
   end loop;   
   
   
   -- DELETE
   -- DELETE(n) removes the key and its element
   l_number_data.delete(1);
   
   -- Check if it is deleted using exists
   if l_number_data.exists(1)
   then
     dbms_output.put_line('Key 1 exists');
   else
     dbms_output.put_line('Key 1 deleted');
   end if;   
   
   
   -- TRIM
   -- TRIM(n) removes the LAST element
   l_number_data.trim;
   
   -- Check if it is deleted using exists
   if l_number_data.exists(6)
   then
     dbms_output.put_line('Key 6 exists');
   else
     dbms_output.put_line('Key 6 deleted');
   end if;   
         
end;
/
-- >```


-- ># Oracle PLSQL VARRAY
-- >* **VARRAY** is exactly similar to NESTED TABLEs, except that an upper bound 
-->   or max key size must be specified.
-- >* Also Elements cannot be deleted.
-- >* All builtin methods of Nested Table works with VARRAY
-- >```sql
-- Example for types
declare
   -- This is the syntax of Nested tables of number(10) data elements
   -- Here the KEY is a integer by default
   type ti_number_data is varray(5) of number(10);

   -- Declare variables using the index by types
   l_number_data ti_number_data;
begin

   -- Initial values to nested table collection
   l_number_data := ti_number_data(100, 200, 300, 400);

   -- Adding the LAST element
   -- Use the "EXTEND" method
   l_number_data.extend;
   l_number_data(l_number_data.last) := 500;

   -- Adding values using a loop
   for l_key in l_number_data.first .. l_number_data.last
   loop
     dbms_output.put_line(l_number_data(l_key));
   end loop;

   -- Elements CANNOT be deleted.
end;
/
-- >```
