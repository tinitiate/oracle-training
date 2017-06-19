-- Topic: Product-Inventory-Invoice Data set for Oracle
-- 
-- (c) tinitiate.com / Venkata Bhattaram
-- 
create table ti_products
(
     prod_id         int
    ,pname           varchar2(200)
    ,sp              number(6,2)
    ,eff_start_date  date
    ,eff_end_date    date
);
alter table ti_products add constraint products_pk primary key(prod_id);


create table ti_region
(
     region_id       int
    ,region_name     varchar2(200)
);
alter table ti_region add constraint region_pk primary key(region_id);


create table ti_city
(
     city_id        int
    ,city_name      varchar2(200)
    ,region_id      int
);
alter table ti_city add constraint city_pk primary key(city_id);


create table ti_store
(
     store_id        int
    ,city_id         int
);
alter table ti_store add constraint store_pk primary key(store_id);


create table ti_inventory
(
     inv_id          int
    ,prod_id         int
);    
alter table ti_inventory add constraint inventory_pk primary key(inv_id);


create table ti_invoice
(
     invoice_id         int
    ,store_id           int
    ,invoice_date       date
    ,prod_id            int
    ,quantity           int
    ,line_item_price    number(6,2)
    ,invoice_price      number(6,2)
);
alter table ti_invoice add constraint invoice_pk primary key(invoice_id);


create table ti_invoice_inventory
(
     invoice_inventory_id   int
    ,invoice_id             int
    ,prod_id                int
    ,inv_id                 int
);
alter table ti_invoice_inventory add constraint invoice_inventory_pk primary key(invoice_inventory_id);


-- drop table ti_invoice_inventory;
-- drop table ti_invoice;
-- drop table ti_inventory;
-- drop table ti_store;
-- drop table ti_city;
-- drop table ti_region;
-- drop table ti_products;
