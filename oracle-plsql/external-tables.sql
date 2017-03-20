-- >---
-- >title: Oracle External Tables
-- >metadata:
-- >    description: 'Oracle External Tables'
-- >    keywords: 'Oracle External Tables, example code, tutorials'
-- >author: Venkata Bhattaram / tinitiate.com
-- >code-alias: external-tables
-- >slug: oracle/plsql/external-tables
-- >---

-- ># Oracle External Tables
-- >* External tables enable Oracle to query data stored in a flat file.
-- >* Insert / Update / Delete DML CANNOT be performed on external tables.
-- >* External tables can be used in query joins and order by operations.
-- >* Views and synonyms can be created using the external tables

-- >## Steps to creating external tables

-- >### STEP 1. Creating Folder that holds the External Table's CSV FILE
-- >* Create a folder in oracle to read the filesystem
-- >* Make sure Oracle user can access the folder for reading
-- >```sql
create directory tinitiate as 'c:\tinitiate';
-- >```

-- >### STEP 2. Create CSV file for the folder
-- >* Save the below contents as tinitiate1.txt in the folder 'c:\tinitiate'
```
1,'a','20170101'
2,'b','20170201'
3,'c','20170301'
4,'d','20170401'
```

-- >### Create CSV file for the folder
-- >* Save the below contents as tinitiate2.txt in the folder 'c:\tinitiate'
```
5,'w','20170102'
6,'x','20170202'
7,'y','20170302'
8,'z','20170402'
```


-- >### STEP 3. Create the external table
-- >* 
-- >```sql
drop table ti_data;
create table ti_data (
  ti_id     int,
  ti_data   varchar2(10),
  ti_date   date
)
organization external (
  type oracle_loader
  -- The directory name
  default directory tinitiate
  access parameters (
    records delimited by newline
    fields terminated by ','
    optionally enclosed by "'"
    missing field values are null
    (
      ti_id,
      ti_data,
      ti_date date 'YYYYDDMM'
    )
  )
  -- The below clause specifies the exact filenames
  location ('tinitiate1.txt','tinitiate2.txt')
)
reject limit unlimited
noparallel;
-- >```


-- >### STEP 4. Select data from the external table
-- >* 
-- >```sql
select *
from   ti_data;
-- >```
