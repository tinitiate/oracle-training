-- >---
-- >title: Oracle Explain Plan
-- >metadata:
-- >    description: 'Oracle Explain Plan'
-- >    keywords: 'Oracle Explain Plan, example code, tutorials'
-- >author: Venkata Bhattaram / tinitiate.com
-- >code-alias: explain-plan
-- >slug: oracle/plsql/explain-plan
-- >---

-- ># Oracle Explain Plan
-- >* EXPLAIN PLAN is the the process adopted by Oracle Optimizer for a query that 
-- >  is executed.
-- >* The order of execution of a query roughly has the following steps:
-- >  * Make sure the QUERY syntax is valid
-- >  * Make sure all the DB objects (Tables, Views, Functions) referred to in the 
-- >    "syntaxtically correct query" are accessible in the current executing schema.
-- >  * Transform the query by adjusting or rewriting the query-subquery.
-- >  * Identify the optimal execution path RBO or CBO and execute the query.

-- >```sql
select *
from   ti_emp;
-- >```
