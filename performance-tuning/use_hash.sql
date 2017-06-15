-- ># USE_HASH HINT EXAMPLE
-- >* Demonstration of USE_MERGE HINT 
-- >* Equals Predicate Join clauses involving ( = Sign)
-- >* Use the Table with the larger data set of more rowsin the USE_HASH HINT
-- >* In the below case the table with more rows is "tgt"
-- >* Get the Explain Plan for the Query with the USE_HASH HINT
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
select /*+ ORDERED use_hash(tgt) */*
from   src,tgt  -- Order tables in row sizes LOW to HIGH
where src.lvl = tgt.dat;

SET LINESIZE 130
SET PAGESIZE 0
select plan_table_output 
from   table(dbms_xplan.display);

-- >```