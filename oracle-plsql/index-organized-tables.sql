-- >---
-- >title: Oracle Index Organized Tables
-- >metadata:
-- >    description: 'Oracle Index Organized Tables'
-- >    keywords: 'Oracle Index Organized Table, examples, code'
-- >author: Venkata Bhattaram / tinitiate.com
-- >code-alias: index-organized-tables
-- >slug: oracle/plsql/index-organized-tables
-- >---

-- ># Oracle Oracle Index Organized Tables
-- >* An Index Organized Table is type of table where the entire table data,
-- >  Both the primary key column data and non-key column data stored in the 
-- >  same B*Tree index structure.
-- >* This type of storage willbe very helpful in fast retrival of data, As data 
-- >  from Primary Key retrival is the fastest.
-- >* This type of table is very useful to maintain some application metadata or 
-- >  small amount of data which is frequently used in applications and where there
-- >  is aprovision to uniquely identify all rows with a primary key columns(s).
-- >* DONT use Index Organized Tables where there are frequent inserts or updates.

-- >## Creation of Index Organized Tables
-- >* 
-- >```sql
-- Creating an Index Organized Table
create table ti_iot(
    ti_application_id   int,
    ti_application_name varchar2(50),
    ti_is_accessable    char(1),
    constraint pk_admin_docindex primary key (ti_application_id))
organization index;

-- Insert data
insert all
   into ti_iot ( ti_application_id
                ,ti_application_name
               ,ti_is_accessable)
       values (1,'ACCOUNTS','Y')
   into ti_iot ( ti_application_id
                ,ti_application_name
               ,ti_is_accessable)
       values (2,'IT','Y')  
   into ti_iot ( ti_application_id
                ,ti_application_name
               ,ti_is_accessable)
       values (3,'ACCOUNTS','Y')
select *
from   dual;

-- Select data from Index Organized Table
select *
from   ti_iot;
-- >```
