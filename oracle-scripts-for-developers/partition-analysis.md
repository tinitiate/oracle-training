# Oracle 12c + Script to get Partition Highwatermark Long as Date
>
```sql
with
function long2str(i_owner varchar2, i_table_name varchar2,i_partition_name varchar2)
   return varchar2
as
   s varchar2(4000);
   l long;
begin
    select high_value
    into   l
    from   all_tab_partitions
    where  table_owner = i_owner
    and    table_name  = i_table_name
    and    partition_name = i_partition_name;

    s:=substr(l,1,4000);
    return s;
end;
select  table_owner, table_name, max(part_val),count(part_val)
from   (
select table_owner,table_name,partition_name, long2str(table_owner, table_name, partition_name) part_val
from   all_tab_partitions)
group  by table_owner, table_name
order by 3;
```
