-- >---
-- >title: Oracle Table Partitioning Advanced Features
-- >metadata:
-- >    description: 'Oracle Table Partitioning, Advanced Features, Interval Partition, Partition Exchange, Split Partition'
-- >    keywords: 'Oracle Table Partitioning, Advanced Features, Virtual Column Partition, Interval Partition, Partition Exchange, Split Partition, code, examples'
-- >author: Venkata Bhattaram / tinitiate.com
-- >code-alias: Oracle Table Partitioning Advanced Features
-- >slug: oracle/plsql/advanced-partitioning
-- >---


-- ># Oracle Table Partitioning Advanced Features
-- >* Interval Partitioning (11g)
-- >* Interval partitioning is a partitioning strategy where the Oracle database 
-- >  automatically creates partitions when the inserted partition key value doesnt 
-- >  find its partition ranges.
-- >* Interval Partition is implemented by two function NUMTOYMINTERVAL and 
-- >  NUMTODSINTERVAL.
-- >* NUMTOYMINTERVAL: This function return a Value represented in either YEARS 
-- >  or MONTHS.
-- >* NUMTODSINTERVAL: This function return a Value represented in either DAY, HOUR, 
-- >  MINUTES, SECONDS

-- >```sql

create table interval_demo
(
  id         int,
  int_data   varchar2(10),
  tnx_date   date
)
partition by range (tnx_date)
interval (numtoyminterval(1,'MONTH'))
(
   partition ip1 values less than (to_date('01-JAN-2017','DD-MON-YYYY'))
);

-- Check the current number of partitions
select *
from   dba_tab_partitions
where  table_owner = 'TINITIATE'
and    table_name  = 'INTERVAL_DEMO';


insert into interval_demo (id, int_data, tnx_date) values (1,'ABC', to_date('01-FEB-2017','DD-MON-YYYY'));

-- Check to see a New partition being Added
select *
from   dba_tab_partitions
where  table_owner = 'TINITIATE'
and    table_name  = 'INTERVAL_DEMO';

-- Hence we demonstrate that Interval Partition creates new partitions 
-- >```


-- >## Query to demonstrate NUMTOYMINTERVAL and NUMTODSINTERVAL
-- >* 300 in YEAR/MONTH with NUMTOYMINTERVAL
-- >* 300 in DAY/HOUR/MINUTE/SECOND with NUMTODSINTERVAL
-- >```sql
select  numtoyminterval(300,'YEAR')
       ,numtoyminterval(300,'MONTH')
       --
       ,numtodsinterval(300,'DAY')
       ,numtodsinterval(300,'HOUR')
       ,numtodsinterval(300,'MINUTE')
       ,numtodsinterval(300,'SECOND')
from   dual;
-- >```


-- >## Oracle Partition Split
-- >* Partition Split is the process of splitting an existing partition to 
-- >  create newer partitions.

-- >```sql
-- create a partitioned table
-- We have merged "ti_date_p3" for TWO months
-- We will demonstrate the split on that partition
create table split_test
(
        tab_id     int
       ,ti_date    date
       ,some_data  varchar2(20)
       ,constraint split_test_pk primary key (tab_id)
)
partition by range (ti_date)
  (partition ti_date_p1 values less than (to_date('31/01/2017', 'DD/MM/YYYY')),
   partition ti_date_p2 values less than (to_date('28/02/2017', 'DD/MM/YYYY')),
   partition ti_date_p3 values less than (to_date('30/04/2017', 'DD/MM/YYYY')),
   partition ti_date_p4 values less than (to_date('31/05/2017', 'DD/MM/YYYY')));


-- Check to see the new Partition, the Partition Position and the High Value
select table_owner, table_name, partition_name,partition_position,high_value
from   dba_tab_partitions
where  table_owner = 'TINITIATE'
and    table_name  = 'SPLIT_TEST';


-- Alter the table to split the "partition ti_date_p3"
-- This will add the partition ti_date_p3 with a High Value of to_date('31/03/2017', 'DD/MM/YYYY')
-- and the ti_date_p31 with a High Value of to_date('30/04/2017', 'DD/MM/YYYY')
alter table split_test
  split partition ti_date_p3 at (to_date('31/03/2017', 'DD/MM/YYYY'))
  into (partition ti_date_p3,
        partition ti_date_p31)
  update global indexes;


-- Check to see the new Partition, the Partition Position and the High Value
select table_owner, table_name, partition_name,partition_position,high_value
from   dba_tab_partitions
where  table_owner = 'TINITIATE'
and    table_name  = 'SPLIT_TEST';
-- >```







