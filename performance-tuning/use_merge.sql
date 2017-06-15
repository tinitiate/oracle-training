-- ># USE_MERGE HINT EXAMPLE
-- >* Demonstration of USE_MERGE HINT 
-- >* Range Predicate Join clauses involving (<=, >=, <, >, Like and Between)
-- >* **Range Predicate DOEST NOT INLCUDE THE =**
-- >* Use the Table with the larger data set of more rowsin the HINT
-- >* In the below case the table with more rows is "tgt"
-- >* Get the Explain Plan for the Query with the USE_MERGE HINT
-- >```
set timing on
explain plan
for
with src
as
(
    select level lvl
    from   dual
    connect by level < 10
),
tgt
as
(
    select case 
           when (level<10)
           then level
           when (level>10)
           then trunc(level/10)
           when (level=10)
           then 1
           end as dat
    from   dual
    connect by level < 100000
)
select /*+ ORDERED use_merge(tgt) */*
from   src,tgt  -- Order tables in row sizes LOW to HIGH
where src.lvl = tgt.dat;

SET LINESIZE 130
SET PAGESIZE 0
select plan_table_output 
from   table(dbms_xplan.display);

-- >```