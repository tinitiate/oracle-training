-- >---
-- >YamlDesc: CONTENT-ARTICLE
-- >Title: Oracle Pivot
-- >MetaDescription: 'Oracle Pivot'
-- >MetaKeywords: 'Oracle SQL Pivot, example code, tutorials'
-- >Author: Venkata Bhattaram / tinitiate.com
-- >ContentName: oracle-pivot
-- >---

-- ># Oracle SQL Pivot
-- >* Pivot of rows is to rotate rows into columns.
-- >* Since Oracle 11g, the *PIVOT* operator, provides 
-- >  mechanism to aggregate rows into columns.
-- >* Demonstration of PIVOT without aggregation.

-- >```

-- Consider the following SOURCE
select  level id ,mod(level,2) bin
from    dual
connect by level < 9;

-- DATA SET
--  ID   BIN
--  --   ---
--  1    1
--  2    0
--  3    1
--  4    0
--  5    1
--  6    0
--  7    1
--  8    0


-- Case 1.
-- ------
-- Show how many 0's and 1's
-- Pivot Counts of 0 and 1 bin values

-- EXPECTED OUTPUT
--   0    1
--  ---  ---
--   4    4

-- Pivot Query
SELECT * FROM
(
    select  level id ,mod(level,2) bin
    from    dual
    connect by level < 9
)
PIVOT ( count(id)  FOR bin IN (0, 1) );


-- Case 2.
-- -------
-- Show IDs under bin 0 and 1

-- EXPECTED OUTPUT
-- 
-- TID  0   1
-- --- --- ---
-- 6    6
-- 7        7
-- 5        5
-- 8    8
-- 1        1
-- 2    2
-- 3        3
-- 4    4

-- Pivot Query
SELECT * FROM
(
    select  level tid, level id ,mod(level,2) bin
    from    dual
    connect by level < 9
)
PIVOT ( max(to_char(id))  FOR bin IN (0 as "0", 1 as "1") );



-- Case 3.
-- -------
-- Classify numbers by 0s and 1s
-- This will generate Gaps

-- EXPECTED OUTPUT
-- 
--  0s  1s
--  --- ---
--       1
--  2 
--       3
--  4 
--       5
--  6 
--       7
--  8

-- Query
-- 
SELECT DECODE(bin, 0, id, null) as "0s",
       DECODE(bin, 1, id, null) as "1s"
FROM   (select  level id ,mod(level,2) bin
        from    dual
        connect by level < 9);

        
-- Case 4.
-- -------
-- Classify numbers by 0s and 1s WITHOUT GAPS
-- Demonstration of PIVOT without aggregation.

-- EXPECTED OUTPUT
-- 
--  0s  1s
--  --- ---
--  2   1
--  4   7
--  6   3
--  8   5

-- Query PIVOT without aggregation.
-- 
select min(case bin when 0 then id end) as "0s",
       min(case bin when 1 then id end) as "1s"
from   (select id, bin, row_number() over ( partition by bin order by bin) rn
        from   (select  level id ,mod(level,2) bin
                from    dual
                connect by level < 9))
group by rn;


-- Order By values within the PIVOT columns
-- 
select min(case bin when 0 then id end) as "0s",
       min(case bin when 1 then id end) as "1s",
       rn
from   (select id, bin, row_number() over ( partition by bin order by id) rn
        from   (select  level id ,mod(level,2) bin
                from    dual
                connect by level < 10))
group by rn
order by rn

-- >```
