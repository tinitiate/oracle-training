with
function long2str(i_owner varchar2, i_table_name varchar2,i_partition_name varchar2)
   return date
as
   s varchar2(4000);
   l long;
   d date;
begin
    select high_value
    into   l
    from   all_tab_partitions
    where  table_owner = i_owner
    and    table_name  = i_table_name
    and    partition_name = i_partition_name;

    s:=substr(l,1,4000);
    execute immediate 'select '||s|| ' from dual' into d;
    return d;
exception when others then
return null;
end;
select table_owner,table_name,apkc.column_name,partition_name,partition_position, long2str(table_owner, table_name, partition_name) part_val
from    all_tab_partitions   atp
       ,ALL_PART_KEY_COLUMNS apkc
where  atp.table_owner=apkc.OWNER
and    atp.table_name = apkc.name
and    atp.table_name = 'TABLENAME'
and    apkc.object_type = 'TABLE'
