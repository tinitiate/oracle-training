create table products 
( 
  prodid     int, 
  pname      varchar2(200), 
  category   varchar2(200), 
  price      number, 
  constraint products_pk primary key (prodid) 
);

create table bills 
( 
  billid     int, 
  billdate   date, 
  custname   varchar2(200), 
  billtotal  number, 
  constraint bills_pk primary key (billid) 
);

create table billdetails 
( 
  billid          int, 
  billlineid      int, 
  prodid          int,   -- 1  1000
  quantity        number, -- 1 - 10
  lineitemprice   number, 
  constraint billdetails_pk primary key (billlineid), 
  constraint billid_fk foreign key (billid) references bills(billid), 
  constraint prodid_fk foreign key (prodid) references products(prodid) 
);

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

--
insert into billdetails values (
   1 --billid
  ,1 --billlineid
  ,1 --prodid
  ,2 --quantity
  ,null --lineitemprice
  );

insert into billdetails values (
   2 --billid
  ,2 --billlineid
  ,2 --prodid
  ,2 --quantity
  ,null --lineitemprice
  );

update   billdetails t
set     lineitemprice = (select  (p.price * bd.quantity) lineitemprice
                         from    products    p
                                ,billdetails bd
                         where  p.prodid = bd.prodid
                         and    t.billlineid = bd.billlineid);

select * from billdetails;

-- Associative Law
(a+b) + c = a + (b+c)
-- Create  100 Products
declare
    l_prod_id int;
    l_prod_name varchar2(100);
    l_prod_price number;
    l_prod_cat varchar2(100);
begin
   for c1 in 1 .. 100
   loop
      l_prod_id := c1;
      l_prod_price := round(DBMS_RANDOM.value(1,50),2);
      l_prod_cat := trunc(DBMS_RANDOM.value(1,20));
      l_prod_name := DBMS_RANDOM.string('P',10);
      
      dbms_output.put_line('prod_id: '||l_prod_id);
      dbms_output.put_line('prod_cat: '||l_prod_cat);
      dbms_output.put_line('price: '||l_prod_price);
      dbms_output.put_line('prod_name: '||l_prod_name);
      
      /*
      insert into products values (
         l_prod_id     -- prodid
        ,l_prod_name   -- pname
        ,l_prod_cat    -- category
        ,l_prod_price  -- price
      );
      */
   end loop;
end;

-- Write 20 Updates 1 for each category
update products
set    prod_cat = 'Frozen'
where  prod_cat = '1';

