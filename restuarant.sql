--1 fact 4 dimension (restuarant's owner)
  -- How to add foreign key
  -- 3-5 query analyze data
  -- 1 subquery / with

.mode markdown
.header on

CREATE TABLE DIM_MENU_COST (
  menucost_id TEXT primary key,
  menucost_name TEXT,
  menucost_cost INT
);

INSERT INTO DIM_MENU_COST VALUES
  ('m-01','Salad',40),
  ('m-02','Burger',72),
  ('m-03','Frenchfried',31),
  ('m-04','Nuggets',41),
  ('m-05','Icecream',34),
  ('m-06','Water',8),
  ('m-07','Orangejuice',19)
;
  
CREATE TABLE DIM_MENU_SELL (
  menusell_id TEXT primary key,
  menusell_name TEXT,
  menusell_type TEXT,
  menusell_price INT
);

INSERT INTO DIM_MENU_SELL VALUES
  ('m-01','Salad','Main',100),
  ('m-02','Burger','Main',160),
  ('m-03','Frenchfried','Appetizer',60),
  ('m-04','Nuggets','Appetizer',80),
  ('m-05','Icecream','Appetizer',80),
  ('m-06','Water','Beverage',20),
  ('m-07','Orangejuice','Beverage',40)
;

CREATE TABLE DIM_CUSTOMERS (
  cust_id TEXT primary key,
  cust_name TEXT,
  cust_sex TEXT,
  cust_level
);

INSERT INTO DIM_CUSTOMERS values
  ('c-01','Pop','Male','r-01'),
  ('c-02','Sherly','Female','r-01'),
  ('c-03','Natty','Female','r-02'),
  ('c-04','Ploy','Female','r-02'),
  ('c-05','Chart','Male','r-03'),
  ('c-06','Jack','Male','r-03'),
  ('c-07','Mint','Female',null),
  ('c-08','Lord','Male',null)
;

CREATE TABLE DIM_CUSRANK (
  rank_id TEXT primary key,
  rank_name TEXT,
  rank_discount INT
);

INSERT INTO DIM_CUSRANK VALUES
  ('r-01','Platinum',0.10),
  ('r-02','Gold',0.07),
  ('r-03','Silver',0.05)
;

CREATE TABLE FACT_ORDER (
  order_id TEXT primary key,
  order_date DATE,
  order_menu TEXT,
  order_cusid TEXT,
  order_quantity INT,
  FOREIGN KEY (order_menu) REFERENCES menusell_id(order_menu),
  FOREIGN KEY (order_cusid) REFERENCES cust_id(order_cusid)
);

INSERT INTO FACT_ORDER values
  ('or-01','2021-12-20','m-02','c-01',5),
  ('or-02','2021-12-20','m-01','c-02',4),
  ('or-03','2021-12-21','m-05','c-04',2),
  ('or-04','2021-12-21','m-06','c-07',2),
  ('or-05','2021-12-21','m-03','c-03',3),
  ('or-06','2021-12-21','m-07','c-05',2),
  ('or-07','2021-12-22','m-04','c-06',5),
  ('or-08','2021-12-22','m-02','c-02',3),
  ('or-09','2021-12-22','m-07','c-01',4),
  ('or-10','2021-12-23','m-03','c-07',1),
  ('or-11','2021-12-23','m-01','c-02',2),
  ('or-12','2021-12-23','m-06','c-04',3),
  ('or-13','2021-12-24','m-07','c-03',2),
  ('or-14','2021-12-22','m-04','c-06',3)
;

-- How much of revenue by order?
SELECT fo.order_id AS id, fo.order_date AS date , ms.menusell_name AS menu , fo.order_quantity AS quantity, (ms.menusell_price * fo.order_quantity)*(1-(1*rank_discount)) AS revenue 
FROM FACT_ORDER AS fo
JOIN DIM_MENU_SELL AS ms
ON fo.order_menu = ms.menusell_id 
JOIN DIM_CUSTOMERS AS dc
ON fo.order_cusid = dc.cust_id
JOIN DIM_CUSRANK AS dr
ON dc.cust_level = dr.rank_id
;

--What menu is best on quantity & profit ?
Select menu , quantity, profit
  From
(SELECT ms.menusell_name AS menu , fo.order_quantity AS quantity, ms.menusell_price * fo.order_quantity  AS price, (ms.menusell_price * fo.order_quantity)*(1-(1*rank_discount)) AS revenue ,dmc.menucost_cost * fo.order_quantity AS cost , (ms.menusell_price * fo.order_quantity)*(1-(1*rank_discount)) - (dmc.menucost_cost * fo.order_quantity) AS profit
FROM FACT_ORDER AS fo
JOIN DIM_MENU_SELL AS ms
ON fo.order_menu = ms.menusell_id 
JOIN DIM_CUSTOMERS AS dc
ON fo.order_cusid = dc.cust_id
JOIN DIM_CUSRANK AS dr
ON dc.cust_level = dr.rank_id
JOIN DIM_MENU_COST AS dmc
ON fo.order_menu = dmc.menucost_id
)
Group by menu
ORDER BY quantity DESC, profit DESC ;

-- Who is the best buyer?
Select customer , quantity, revenue
  From
(SELECT fo.order_quantity AS quantity, ms.menusell_price * fo.order_quantity  AS price, (ms.menusell_price * fo.order_quantity)*(1-(1*rank_discount)) AS revenue ,dmc.menucost_cost * fo.order_quantity AS cost , (ms.menusell_price * fo.order_quantity)*(1-(1*rank_discount)) - (dmc.menucost_cost * fo.order_quantity) AS profit, dc.cust_name AS customer
FROM FACT_ORDER AS fo
JOIN DIM_MENU_SELL AS ms
ON fo.order_menu = ms.menusell_id 
JOIN DIM_CUSTOMERS AS dc
ON fo.order_cusid = dc.cust_id
JOIN DIM_CUSRANK AS dr
ON dc.cust_level = dr.rank_id
JOIN DIM_MENU_COST AS dmc
ON fo.order_menu = dmc.menucost_id
)
Group by customer
ORDER BY revenue DESC 
