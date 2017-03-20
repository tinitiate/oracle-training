-- >---
-- >title: Oracle Data Sets for Performance Tuning Practice
-- >metadata:
-- >    description: 'Free Oracle Data Sets for Performance Tuning practice'
-- >    keywords: 'Free Oracle Data Sets, for Performance Tuning practice, example code, tutorials'
-- >author: Venkata Bhattaram / tinitiate.com
-- >code-alias: free-datasets
-- >slug: oracle/admin/large-dataset
-- >---

-- ># Large Datasets for Oracle Performance Tuning Practice
-- >* Here we create a large data set for a fictional Phone Company
-- >* Tables and their relationships with ROW counts mentioned below

-- >```sql
-- TI_PHONES Table
create table ti_phones
(
     ti_phone_id         int
    ,ti_phone_make       varchar2(50)
    ,ti_phone_model      varchar2(50)
    ,ti_phone_price      number(5,2)
    ,primary key ti_phones_pk    
);

-- TI_PLANS Table
create table ti_plans
(
     ti_plan_id              int
    ,ti_plan_name            varchar2(50)
    ,ti_plan_minutes         number(10)
    ,ti_plan_data_mb         number(10)
    ,ti_plan_price           number(5,2)
    ,ti_price_extra_per_min  number(5,2)
    ,ti_price_extra_per_mb   number(5,2)    
    ,primary key ti_phones_pk    
);


-- TI_CUST
create table ti_customer
(
     ti_cust_id        int
    ,ti_cust_name      varchar2(50)
    ,ti_cust_address   number(10)
    ,primary key ti_phones_pk    
);        


-- TI_PHONE_PLANS
create table ti_phone_plan
(
     ti_pp_id           int
    ,ti_plan_id            int    
    ,ti_phone_id         int
    ,primary key ti_phone_plan_pk
);


-- TI_CUST_PHONE_PLAN
create table ti_cust_phone_plan
(
     ti_cust_phone_plan_id  int
    ,ti_cust_id             int
    ,ti_pp_id               int
    ,plan_start_date        date
    ,plan_end_date          date
);

-- TI_BILLING
create table ti_billing
(
     billing_id             int
    ,ti_cust_phone_plan_id  int
    ,ti_bill_month          varchar2(3)
    ,ti_bill_year           number(4)
    ,tot_mins_used          int
    ,tot_mb_used            int
    ,tot_bill               number(5,2)
    ,bill_date              date
    ,primary key ti_billing )
partition by range (bill_date)
interval (numtoyminterval(1,'MONTH'))
(
   partition ip1 values less than (to_date('01-JAN-2017','DD-MON-YYYY'))
);



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



/*
select dbms_utility.get_time, dbms_utility.get_cpu_time from dual;





DECLARE 
 i NUMBER;
 j NUMBER; 
BEGIN
  i := dbms_utility.get_time; 
  dbms_lock.sleep(1.6); 
  j := dbms_utility.get_time; 
  dbms_output.put_line(j-i);
END;
/
*/