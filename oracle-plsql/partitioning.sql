-- >---
-- >title: Oracle Table Partitioning
-- >metadata:
-- >    description: 'Oracle Table Partitioning, Range partition, List Partittion'
-- >    keywords: 'Oracle Table Partitioning, Range partition, List Partittion'
-- >author: Venkata Bhattaram / tinitiate.com
-- >code-alias: Oracle Table Partitioning
-- >slug: oracle/plsql/partitioning
-- >---


-- ># Oracle Table Partitioning
-- >* Maintaining very large tables can be very very resource intensive, 
-- >  on both CPU and Memory.
-- >* Any query issued could lead to performance issues because of the large data.
-- >* Oracle Database's partitioning is about divide and conquer, a table or index 
-- >  is partitioned into multiple segments placed into different tablespaces. 
-- >* These individual partitions are still addressed as a single table,
-- >  while the individual partitions are stored as separate segments this allows 
-- >  for easier manipulation and handling of data.
-- >* Different types of partitioning:  
-- >  * Range Partitioning
-- >  * Hash Partitioning
-- >  * Composite Partitioning


-- >## Oracle Table Range Partitioning
-- >* Range partitioning is used when the "partitioned-column" values have distinct 
-- >  ranges of data based on a RANGE START VALUE to RANGE END VALUE. 
-- >* Also make sure the RANGE COLUMN cannot be of null value.
-- >* Commonly RANGE PARTITIONING is applied on DATE datatype columns.
-- >* This is very useful to partition data by DATE RANGE, Like DAILY data in one 
-- >  partition each, or One Partition per Week or month .
-- >* Demonstration of Range Paritition
-- >```sql

-- Here we create a partitioned table, here all data is Paritition by the 
-- column "flight_date", Here the data is partitioned by One Week or 7 days.
create table flight_log
  ( flight_number    number not null
   ,departure_city   varchar2(10)
   ,arriving_city    varchar2(10)
   ,flight_date      date not null)
partition by range (flight_date)
  (partition flight_date_w1 values less than (to_date('07/01/2017', 'DD/MM/YYYY')),
   partition flight_date_w2 values less than (to_date('14/01/2017', 'DD/MM/YYYY')),
   partition flight_date_w3 values less than (to_date('21/01/2017', 'DD/MM/YYYY')),
   partition flight_date_w4 values less than (to_date('28/01/2017', 'DD/MM/YYYY')));


-- Insert data
-- This ROW will be inserted into the flight_date_w1 partition
insert into flight_log ( flight_number
                        ,departure_city
                        ,arriving_city
                        ,flight_date)
                values ( 1
                        ,'DEL'
                        ,'NYC'
                        ,to_date('02/01/2017', 'DD/MM/YYYY'));

-- This ROW will be inserted into the flight_date_w2 partition
insert into flight_log ( flight_number
                        ,departure_city
                        ,arriving_city
                        ,flight_date)
                values ( 2
                        ,'BOM'
                        ,'BOS'
                        ,to_date('12/01/2017', 'DD/MM/YYYY'));

-- This ROW will be inserted into the flight_date_w3 partition
insert into flight_log ( flight_number
                        ,departure_city
                        ,arriving_city
                        ,flight_date)
                values ( 3
                        ,'HYD'
                        ,'SHG'
                        ,to_date('18/01/2017', 'DD/MM/YYYY'));

-- This ROW will be inserted into the flight_date_w4 partition
insert into flight_log ( flight_number
                        ,departure_city
                        ,arriving_city
                        ,flight_date)
                values ( 4
                        ,'TKY'
                        ,'DAL'
                        ,to_date('24/01/2017', 'DD/MM/YYYY'));
                        
-- Query data based on partition
select *
from   flight_log partition(flight_date_w1);

select *
from   flight_log partition(flight_date_w2);

select *
from   flight_log partition(flight_date_w3);

select *
from   flight_log partition(flight_date_w4);

-- >```


-- >## Oracle Table List Partitioning
-- >* List partitioning is a partitioning technique where the partitioned column is 
-- >  assigned with a SINGLE value.
-- >* Data with the relevant values are stored in the relevant partitions.

-- >```sql
-- Create a LIST partition table
create table place_type (
       place_name   varchar2(30) primary key,
       place_type   varchar2(30))
  partition by list (place_type) (  
       partition p1 values ('COUNTRY'), 
       partition p2 values ('STATE'), 
       partition p3 values ('CITY','COUNTY'));


insert into place_type (place_name,place_type) values ('USA','COUNTRY');
insert into place_type (place_name,place_type) values ('TEXAS','STATE');
insert into place_type (place_name,place_type) values ('NYC','CITY');
insert into place_type (place_name,place_type) values ('BLANE','COUNTY');


select *
from   place_type partition(p1);

select *
from   place_type partition(p2);

select *
from   place_type partition(p3);
-- >```


-- >## Hash Partitioning Tables
-- >* Hash partitioning is applied is scenarios when there is uneven distribution of 
-- >  data values for the intended partition key column. 
-- >* With the Hash partitioning approach, the partition key column data is randomly 
-- >  distributed across the partitions based on a Hashing algorithm.
-- >* While this approach is acceptable for smaller data sets, It might not be the 
-- >  ideal way to implement the partitioning as there is no business logic attached 
-- >  to it. its purely data partitioning.
-- >```sql
create table it_projects
(
  project_id     int not null,
  project_name   varchar2(10)
)
partition by hash (project_id)
(
  partition it_projects_p1,
  partition it_projects_p2,
  partition it_projects_p3,
  partition it_projects_p4
);


insert into it_projects (project_id,project_name) values (1,'Nano');
insert into it_projects (project_id,project_name) values (434343,'Micro');
insert into it_projects (project_id,project_name) values (71738,'Pico');
insert into it_projects (project_id,project_name) values (92041,'Mega');

select *
from   it_projects partition(it_projects_p1);

select *
from   it_projects partition(it_projects_p2);

select *
from   it_projects partition(it_projects_p3);

select *
from   it_projects partition(it_projects_p4);
-- >```


-- >## SubPartitioning of Tables
-- >* Partition is physically dividing the table into pieces based on values and 
-- >  logically grouping the physically divided segments into a table.
-- >* Sub Partitioning is "Partitioning" a partition, and SubPartition's 
-- >  partition methodology can be different from the Partition's partition methodology
-- >* Partition's can be LIST and its SubPartition can be of Range partition.
-- >```sql
create table yearly_data
(
   year_data_id  int
  ,data_month    varchar2(10)
  ,data_year     int
)
partition by range (data_year)
subpartition by list (data_month)
subpartition template (
   subpartition sp_jan values ('JAN'),
   subpartition sp_feb values ('FEB'),
   subpartition sp_mar values ('MAR'),
   subpartition sp_apr values ('APR'),
   subpartition sp_may values ('MAY'),
   subpartition sp_jun values ('JUN'),
   subpartition sp_jul values ('JUL'),
   subpartition sp_aug values ('AUG'),
   subpartition sp_sep values ('SEP'),
   subpartition sp_oct values ('OCT'),
   subpartition sp_nov values ('NOV'),
   subpartition sp_dec values ('DEC')
)(
partition p_2000 values less than (2000),
partition p_2005 values less than (2005),
partition p_2010 values less than (2010),
partition p_2015 values less than (2015),
partition p_2020 values less than (2020)
);

-- Insert data
insert into yearly_data (year_data_id, data_month, data_year) values(1,'JAN',2001);
insert into yearly_data (year_data_id, data_month, data_year) values(2,'FEB',2011);
insert into yearly_data (year_data_id, data_month, data_year) values(3,'MAY',2017);


-- Select Statement to read from specific partition and subpartition
select *
from   yearly_data subpartition(p_2020_sp_may);
-- >```


