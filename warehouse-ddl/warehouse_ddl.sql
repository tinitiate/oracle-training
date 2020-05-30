-- products table
create table products
(
  prodid     int,
  pname      varchar2(200),
  category   varchar2(200),
  price      number,
  constraint products_pk primary key (prodid)
);

-- Create 20 Products
INSERT INTO products (prodid,pname,category,price)
values (1,'Green Peas','frozen',2.99);
    
INSERT INTO products (prodid,pname,category,price)
values (2,'Dishwashing Liquid','cleaning',1.99);

INSERT INTO products (prodid,pname,category,price)
values (3,'Potatoes','vegis',3.99);

INSERT INTO products (prodid,pname,category,price)
values (4,'Carrots','vegis',0.99);

INSERT INTO products (prodid,pname,category,price)
values (5,'liquid soap','cleaning',2.99);

commit;
-- rollback;

SELECT * FROM products;
select prodid, pname,category, price from products;


-- bills table
create table bills
(
  billid     int,
  billdate   date,
  custname   varchar2(200),
  billtotal  number,
  constraint bills_pk primary key (billid)
);

-- Insert Bill Data (Create 5 Rows )
INSERT INTO bills (billid, billdate,custname, billtotal)
values (1,TO_DATE('04-JUL-2019','DD-MON-YYYY'),'aaa',null);

INSERT INTO bills (billid, billdate,custname, billtotal)
values (2,TO_DATE('04/05/2019','DD/MM/YYYY'),'bbb',null);


-- billdetails table
create table billdetails
(
  billid          int,
  billlineid      int,
  prodid          int,
  quantity        number,
  lineitemprice   number,
  constraint billdetails_pk primary key (billlineid),
  constraint billid_fk foreign key (billid) references bills(billid),
  constraint prodid_fk foreign key (prodid) references products(prodid)
);
