-- >---
-- >title: Oracle Types of Joins
-- >metadata:
-- >    description: 'Oracle Join Types'
-- >    keywords: 'Oracle hash join, nested loop join, sort merge join, examples, code'
-- >author: Venkata Bhattaram / tinitiate.com
-- >code-alias: join-types
-- >slug: oracle/sql/join-types
-- >---

-- ># Oracle SQL join mechanisms
-- >* Hash joins - In a hash join, the Oracle database does a full-scan of the driving table, 
-- >* builds a RAM hash table, and then probes for matching rows in the other table.  
For certain types of SQL, the hash join will execute faster than a nested loop join, 
but the hash join uses more RAM resources. 

-- >* Nested loops join - The nested loops table join is one of the original table join plans 
and it remains the most common.  In a nested loops join, we have two tables a driving 
table and a secondary table.  The rows are usually accessed from a driving table index 
range scan, and the driving table result set is then nested within a probe of the 
second table, normally using an index range scan method.
