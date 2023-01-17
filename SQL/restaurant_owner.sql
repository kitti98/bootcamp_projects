-- I'm a restaurant owner
-- create 5 Tables
-- 1x Fact, 4x Dimensions
-- search google -> how to add a foreign key
-- write SQL 3-5 queries to analyze data
-- 1x subquery/ with


-- table 1 -> dimHamburger
CREATE TABLE dimHamburgers (
    hamburger_id INT PRIMARY KEY,
    hamburger TEXT,
    price REAL
);

INSERT INTO dimHamburgers VALUES
    (1, 'Blue Cheese Burger', 149.99),
    (2, 'Bison Burger', 249.99),
    (3, 'Whale Burger', 479.99),
    (4, 'Kurobuta Pork Burger', 199.50),
    (5, 'Veggie Burger', 129.50);

-- tabel 2 -> ingredients
CREATE TABLE ingredients (
    ing_id INT PRIMARY KEY,
    ing_name TEXT
);

INSERT INTO ingredients VALUES
    (1, 'Burger Bun'),
    (2, 'Blue Cheese'),
    (3, 'Bison Meat'),
    (4, 'Whale Meat'),
    (5, 'Kurobuta Pork Meat'),
    (6, 'Veggie'),
    (7, 'Veggie Meat'),
    (8, 'Cheese'),
    (9, 'Pickled Cucumbers'),
    (10, 'Onion'),
    (11, 'Eggs'),
    (12, 'Salt & Pepper');

-- table 3 -> bridge_ham_ing
CREATE TABLE bridge_ham_ing (
    ham_id INT,
    ing_id INT
);

INSERT INTO bridge_ham_ing VALUES
    (1, 1), (1, 2), (1, 6), (1, 8), (1, 9), (1, 10), (1, 11),
    (2, 1), (2, 3), (2, 8), (2, 10), (2, 12),
    (3, 1), (3, 4), (3, 8), (3, 10), (3, 12),
    (4, 1), (4, 5), (4, 6), (4, 8), (4, 10), (4, 12),
    (5, 1), (5, 6), (5, 7), (5, 8), (5, 9), (5, 10), (5, 11), (5, 12);

-- table 4 -> dimCustomers
CREATE TABLE dimCustomers (
    customer_id INT PRIMARY KEY,
    first_name TAXT,
    last_name TEXT,
    phone TAXT
);

INSERT INTO dimCustomers VALUES
    (1, 'Carsten', 'Kornhäusel', '086-629-5722'),
    (2, 'Ishida', 'Nagateru', '088-526-5866'),
    (3, 'Hyun-Ah', 'Yong', '089-691-0848'),
    (4, 'Chalvagiall', 'Wolfglory', '084-264-3061'),
    (5, 'Wang', 'Jiao', '086-436-9175'),
    (6, 'Øpir', 'Orgumleidisson', '087-846-3199'),
    (7, 'Visemarys', 'Raenareon', '086-875-0939'),
    (8, 'Edwin', 'Dogbane', '089-157-8047'),
    (9, 'Darth', 'Tyzzix', '083-608-7473'),
    (10, 'Mae Noi', 'Chan-ocha', '081-988-8186');
    
-- table 5 -> dimLocations
CREATE TABLE dimLocations (
    location_id INT PRIMARY KEY,
    location TEXT
);

INSERT INTO dimLocations VALUES 
    (1, 'Bangkok'),
    (2, 'Westeros'),
    (3, 'Hogwarts'),
    (4, 'Naboo'),
    (5, 'Kaer Morhen');

-- table 6 -> dimDelivery
CREATE TABLE dimDelivery (
    delivery_id INT PRIMARY KEY,
    delivery_type TEXT
);

INSERT INTO dimDelivery VALUES
    (1, 'Self Pick-Up'),
    (2, 'GrabFood'),
    (3, 'Line Man'),
    (4, 'ShopeeFood');
    
-- table 7 -> factOrders
CREATE TABLE factOrders (
    order_id INT PRIMARY KEY,
    hamburger_id INT,
    customer_id  INT,
    location_id  INT,
    delivery_id  INT,
    order_date TEXT,
    FOREIGN KEY (hamburger_id) REFERENCES dimHamburgers (hamburger_id),
    FOREIGN KEY (customer_id)  REFERENCES dimCustomers  (customer_id),
    FOREIGN KEY (location_id)  REFERENCES dimLocations  (location_id),
    FOREIGN KEY (delivery_id)  REFERENCES dimDelivery   (delivery_id)
);

-- show tables
.schema

INSERT INTO factOrders VALUES
    (1, 1, 3, 1, 2, '2022-08-01'),
    (2, 3, 1, 1, 2, '2022-08-01'),
    (3, 1, 5, 3, 4, '2022-08-02'),
    (4, 5, 9, 4, 2, '2022-08-02'),
    (5, 3, 10, 1, 3, '2022-08-02'),
    (6, 3, 7, 2, 1, '2022-08-03'),
    (7, 2, 7, 2, 1, '2022-08-03'),
    (8, 2, 8, 3, 3, '2022-08-03'),
    (9, 2, 4, 5, 3, '2022-08-04'),
    (10, 3, 6, 2, 4, '2022-08-05'),
    (11, 2, 2, 5, 1, '2022-08-06'),
    (12, 4, 7, 2, 3, '2022-08-06'),
    (13, 1, 9, 4, 4, '2022-08-07'),
    (14, 4, 4, 5, 1, '2022-08-09'),
    (15, 3, 10, 1, 2, '2022-08-09'),
    (16, 5, 6, 4, 2, '2022-08-09'),
    (17, 4, 5, 2, 4, '2022-08-10'),
    (18, 3, 9, 2, 1, '2022-08-10');
    
-- sqlite command - manipulate console displays
.mode markdown
.header on

    
-- query 1 -> summary of all tables
SELECT 
    Ord.order_id,
    Ord.order_date,
    Ham.hamburger,
    Ham.price || ' $' AS price,
    Cus.first_name || ' ' || Cus.last_name AS customer,
    Loc.location,
    Del.delivery_type
FROM factOrders AS Ord
JOIN dimHamburgers AS Ham ON Ord.hamburger_id = Ham.hamburger_id
JOIN dimCustomers  AS Cus ON Ord.customer_id  = Cus.customer_id 
JOIN dimLocations  AS Loc ON Ord.location_id  = Loc.location_id
JOIN dimDelivery   AS Del ON Ord.delivery_id  = Del.delivery_id;


-- query 2 -> top 3 hambugers
SELECT 
    Ham.hamburger,
    COUNT(*) AS n_hamburgers
FROM factOrders AS Ord
JOIN dimHamburgers AS Ham ON Ord.hamburger_id = Ham.hamburger_id
JOIN dimCustomers  AS Cus ON Ord.customer_id  = Cus.customer_id 
JOIN dimLocations  AS Loc ON Ord.location_id  = Loc.location_id
JOIN dimDelivery   AS Del ON Ord.delivery_id  = Del.delivery_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;



-- query 3 -> daily income
SELECT 
    Ord.order_date,
    ROUND(SUM(Ham.price), 2) || ' $' AS total
FROM factOrders AS Ord
JOIN dimHamburgers AS Ham ON Ord.hamburger_id = Ham.hamburger_id
JOIN dimCustomers  AS Cus ON Ord.customer_id  = Cus.customer_id 
JOIN dimLocations  AS Loc ON Ord.location_id  = Loc.location_id
JOIN dimDelivery   AS Del ON Ord.delivery_id  = Del.delivery_id
GROUP BY Ord.order_date;


-- query 4 + subquery -> all ingredients for the whale burger
SELECT *
FROM (
    SELECT 
    Ham.hamburger AS hamburger,
    Ing.ing_name AS ingredients
FROM dimHamburgers  AS Ham
JOIN bridge_ham_ing AS Brd ON Ham.hamburger_id = Brd.ham_id
JOIN ingredients    AS Ing ON Brd.ing_id = Ing.ing_id
) AS sub
WHERE hamburger LIKE '%Whale%';


-- query 5 + subquery/WITH -> The most popular hamburger in Westeros
WITH westeros_branch AS (
    SELECT *
    FROM factOrders AS Ord
    JOIN dimHamburgers AS Ham ON Ord.hamburger_id = Ham.hamburger_id
    JOIN dimLocations  AS Loc ON Ord.location_id  = Loc.location_id
    WHERE Loc.location = 'Westeros'
)
SELECT 
    hamburger,
    COUNT(*) AS n_hamburgers
FROM westeros_branch
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;
