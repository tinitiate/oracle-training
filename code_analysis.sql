select 'connect by',count(1) from dba_source where upper(text) like '%CONNECT%BY%'
union all
select 'with',count(1) from dba_source where upper(text) like '%WITH%'
union all
select 'SYSDATE',count(1) from dba_source where upper(text) like '%SYSDATE%'
union all
select 'SYSTIMESTAMP',count(1) from dba_source where upper(text) like '%SYSTIMESTAMP%'
union all
select 'ROWID',count(1) from dba_source where upper(text) like '%ROWID%'
union all
select 'PARTITION BY',count(1) from dba_source where upper(text) like '%PARTITION%BY%'
union all
select 'DECODE',count(1) from dba_source where upper(text) like '%DECODE%'
union all
select 'NVL',count(1) from dba_source where upper(text) like '%NVL%'
union all
select 'NVL2',count(1) from dba_source where upper(text) like '%NVL2%'
union all
select 'DBMS_SQL',count(1) from dba_source where upper(text) like '%DBMS_SQL%'
union all
select 'DBMS_SESSION',count(1) from dba_source where upper(text) like '%DBMS_SESSION%'
union all
select 'BULK COLLECT',count(1) from dba_source where upper(text) like '%BULK%COLLECT%'
union all
select 'DBMS_SESSION',count(1) from dba_source where upper(text) like '%DBMS_SESSION%'
union all
select 'EXECUTE IMMEDIATE',count(1) from dba_source where upper(text) like '%EXECUTE%IMMEDIATE%'
union all
select 'TYPE',count(1) from dba_source where upper(text) like '%TYPE%'
union all
select 'OBJECT',count(1) from dba_source where upper(text) like '%OBJECT%'
union all
select 'XMLTYPE',count(1) from dba_source where upper(text) like '%XMLTYPE%'
union all
select 'CLOB',count(1) from dba_source where upper(text) like '%CLOB%'
union all
select 'BLOB',count(1) from dba_source where upper(text) like '%BLOB%'
union all
select 'numtodsinterval',count(1) from dba_source where upper(text) like '%NUMTODSINTERVAL%'
union all
select 'UTL_FILE',count(1) from dba_source where upper(text) like '%UTL_FILE%'
union all
select 'PIPE',count(1) from dba_source where upper(text) like '%PIPE%'
