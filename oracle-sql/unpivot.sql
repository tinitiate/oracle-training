-- >---
-- >YamlDesc: CONTENT-ARTICLE
-- >Title: Oracle UnPivot
-- >MetaDescription: 'Oracle UnPivot'
-- >MetaKeywords: 'Oracle SQL UnPivot, example code, tutorials'
-- >Author: Venkata Bhattaram / tinitiate.com
-- >ContentName: oracle-unpivot
-- >---

-- ># Oracle SQL UnPivot
-- >* unpivot operation is the reverse of pivot, its the mechanism to 
-- >  disaggregate the rows and columns.
-- >* Unpivot is the process of converting columns into rows, one data row 
-- >  for every column that is unpivoted.

-- >```
-- Consider the following SOURCE
select  level id,
        decode(mod(level*5,10),0,(level*5)+5,level*5) Fives,
        level*10  Tens
from    dual
connect by level < 4;

-- ID   FIVES   TENS
-- --   -----   ----
-- 1    5       10
-- 2    15      20
-- 3    15      30

-- Case 1.
-- ------
-- For each ID show FIVES and TENS as seperate rows
-- UnPivot FIVES and TENS for each ID


--  EXPECTED OUTPUT
-- 
--  ID    DATA_KEY   DATA_VALUE 
--  ---   --------   ----------
--  1     FIVES      5
--  1     TENS       10
--  2     FIVES      15
--  2     TENS       20
--  3     FIVES      15
--  3     TENS       30

-- Query
-- DATA_KEY and DATA_VALUE are the new colums that are created to hold 
-- the column names and column data from the source query.
select *
from   (select  level                                           id,
                decode(mod(level*5,10),0,(level*5)+5,level*5)   fives,
                level*10                                        tens
        from    dual
        connect by level < 4)
unpivot ( data_value for data_key in (fives, tens) );

-- >```
