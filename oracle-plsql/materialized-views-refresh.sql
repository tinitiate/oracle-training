-- >---
-- >title: Oracle plsql Materialized Views Refresh
-- >metadata:
-- >    description: 'Oracle Materialized Views Refresh'
-- >    keywords: 'Oracle Materialized Views Refresh,DBMS_MVIEW.REFRESH, DBMS_MVIEW.REFRESH_ALL_MVIEWS, DBMS_MVIEW.REFRESH_DEPENDENT example code, tutorials'
-- >author: Venkata Bhattaram / tinitiate.com
-- >code-alias: materialized-views-refresh
-- >slug: oracle/plsql/materialized-views-refresh
-- >---

-- ># Oracle Materialized Views Refresh
-- >* The package procedure DBMS_MVIEW.REFRESH('my-materialized-view')
-- >* Fast Refresh 
-- >  * Materialized View is refreshed only when the rows in the underlying table 
-- >    have changed since last refresh.
-- >  * Materialized View Log on the underlying tables MUST be present for Fast Refresh.
-- >  * Complete Refresh
-- >  * Complete Refresh will truncate the Materialized View and refresh the data 
-- >    from base tables. This process consumes lot of CPU and IO.
-- >* Force Refresh
-- >  * Force Refresh will attempt a fast refresh, if it fails a complete refresh is done. 

-- >## Oracle Materialized Views Manual Refresh
-- >* A materialized view can be manually refreshed using the DBMS_MVIEW package.
-- >```sql
begin
  DBMS_MVIEW.refresh('MY-MATERIALIZED-VIEW-NAME');
end;
/

-- >```

-- >## Oracle Materialized Views Scheduled Refresh, with Refresh Groups
-- >* Refresh can be scheduled by a scheduler, using Refresh Groups
-- >* DBMS_REFRESH.MAKE procedure is used to create a Group Name and refresh interval
-- >* Use 
-- >```sql
begin
   dbms_refresh.make(
     name                 => 'TINITIATE.FIVE_MINUTE_REFRESH',
     list                 => '',
     next_date            => SYSDATE,
     interval             => 'SYSDATE + 5/(60*24)', -- Refresh Every 5 Mins
     implicit_destroy     => FALSE,
     lax                  => FALSE,
     job                  => 0,
     rollback_seg         => NULL,
     push_deferred_rpc    => TRUE,
     refresh_after_errors => TRUE,
     purge_option         => NULL,
     parallelism          => NULL,
     heap_size            => NULL);
end;
/

-- Add a Mat. view to the Refresh Group "TINITIATE.FIVE_MINUTE_REFRESH"
begin
   dbms_refresh.add(
     name => 'TINITIATE.FIVE_MINUTE_REFRESH',
     list => 'TINITIATE.TI_MV_BI_RF',
     lax  => TRUE);
end;
/
-- >```

-- >## Tables and System Views to monitor Materialized Views
-- >* Make sure select grants are give on "dba_mviews", "dba_mview_logs" and 
-- > "dba_refresh" system views as SYS DBA
-- >```sql
-- Step 1. Login as SYSDBA and grant to TINITIATE user
grant select on dba_mviews to tinitiate;
grant select on dba_mview_logs to tinitiate;
grant select on dba_refresh to tinitiate;

-- Step 2. Monitor Materialized View using TINITIATE user

-- Details About all the Materialized Views
select *
from   dba_mviews;

-- Details About all the Materialized Views Logs
select *
from   dba_mviews_logs;

-- Details About all the Materialized Views Refresh Groups
select *
from   dba_refresh;

-- >```

