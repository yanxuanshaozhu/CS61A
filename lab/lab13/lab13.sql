.read data.sql


CREATE TABLE average_prices AS
  SELECT category, round(avg(MSRP), 0) as average_price from products
  group by category;


CREATE TABLE lowest_prices AS
  SELECT store, item, min(price) from inventory
  group by item;


CREATE TABLE shopping_list AS
  SELECT tbl.name, a.store from lowest_prices as a join
  (select name, round(min(MSRP/rating), 2) as deal from products group by category) as tbl
  where tbl.name = a.item;

CREATE TABLE total_bandwidth AS
  select sum(b.Mbs) from shopping_list as a join stores as b
  where a.store = b.store;

