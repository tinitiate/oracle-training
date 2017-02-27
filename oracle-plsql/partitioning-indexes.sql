-- >---
-- >title: Oracle Table Index Partitioning
-- >metadata:
-- >    description: 'Oracle Table Index Partitioning, Local Index, Global Index'
-- >    keywords: 'Oracle Table Index Partitioning, Local Index, Global Index Code Examples and tutorials'
-- >author: Venkata Bhattaram / tinitiate.com
-- >code-alias: Oracle Table Index Partitioning
-- >slug: oracle/plsql/index-partitioning
-- >---


-- ># Oracle Table Index Partitioning
-- >* Global Index is a single index covering all partitions, PRIMARY KEY for example.
-- >* Local indexes are indexes for each partition. They are added automatically if 
-- >  and when a partition is added.
-- >* Partitioning helps in better DML, and Data Selection.
-- >* Partitioning supports parallelism and partition pruning (not considering the 
-- >  partitions that are not needed for the current operation). Helps in the 
-- >  performance of the system.
-- >```sql
create table it_projects
(
  project_id     int primary key, -- This is the Global Index
  project_name   varchar2(10)
)
partition by hash (project_id)
(
  partition it_projects_p1,
  partition it_projects_p2,
  partition it_projects_p3,
  partition it_projects_p4
);

-- Create Local Index
create index it_projects_idx on it_projects(project_name) local
( partition it_projects_p1,
  partition it_projects_p2,
  partition it_projects_p3,
  partition it_projects_p4
);


-- Check indexes by querying system tables
-- Make sure there is select privlage to the current user 

-- List all indexes, The Uniqueness column here in this case is the 
-- Primary Key (Global Index).
-- And the other is the Local index.
select owner, index_name, uniqueness
from   dba_indexes
where  owner      = 'TINITIATE'
and    table_name = 'IT_PROJECTS';

-- Details of the Local Index Partition details
select index_owner, index_name, partition_name
from   dba_ind_partitions
where  index_owner = 'TINITIATE'
and    index_name  = 'IT_PROJECTS_IDX';
-- >```
