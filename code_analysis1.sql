select 'NVL' Type,count(1) frm dba_source where upper(text) like '%NVL%'
union all
select 'NVL2' Type,count(1) frm dba_source where upper(text) like '%NVL2%'
union all
select 'CONNECT BY' Type,count(1)  frm dba_source where upper(text) like '%CONNECT BY%'
union all
select 'WITH' Type,count(1)  frm dba_source where upper(text) like '%WITH%'
union all
select 'DBMS_SQL' Type,count(1)  frm dba_source where upper(text) like '%DBMS_SQL%'
union all
select 'DECODE' Type,count(1)  frm dba_source where upper(text) like '%DECODE%'
union all
select 'PARTITION' Type,count(1)  frm dba_source where upper(text) like '%PARTITION%'
union all
select 'DBMS_SQL' Type,count(1)  frm dba_source where upper(text) like '%DBMS%'
