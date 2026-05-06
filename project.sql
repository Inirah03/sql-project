-- CLEAN START (avoids "already exists" error)

DROP TABLE IF EXISTS Order_Details;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Customer;

-- TABLES

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price INT,
    stock INT
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date VARCHAR(20)
);

CREATE TABLE Order_Details (
    order_id INT,
    product_id INT,
    quantity INT
);

-- INSERT DATA

INSERT INTO Customer VALUES
(1, 'Anu', 'anu@gmail.com', 'Chennai'),
(2, 'Ravi', 'ravi@gmail.com', 'Madurai'),
(3, 'Priya', 'priya@gmail.com', 'Coimbatore');

INSERT INTO Product VALUES
(101, 'Laptop', 50000, 10),
(102, 'Phone', 20000, 20),
(103, 'Headphones', 2000, 50);

INSERT INTO Orders VALUES
(1001, 1, '2025-01-10'),
(1002, 2, '2025-01-11');

INSERT INTO Order_Details VALUES
(1001, 101, 1),
(1001, 103, 2),
(1002, 102, 1);

-- VIEW DATA

SELECT * FROM Customer;
SELECT * FROM Product;

-- JOIN QUERY

SELECT c.name, o.order_id, p.product_name, od.quantity
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Product p ON p.product_id = od.product_id;

-- TOTAL SALES

SELECT p.product_name, SUM(od.quantity * p.price) AS total_sales
FROM Order_Details od
JOIN Product p ON od.product_id = p.product_id
GROUP BY p.product_name;

-- TOTAL ORDERS PER CUSTOMER

SELECT c.name, COUNT(o.order_id) AS total_orders
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_orders DESC;

-- CUSTOMERS WHO PLACED ORDERS

SELECT name
FROM Customer
WHERE customer_id IN (SELECT customer_id FROM Orders);

-- TOP 3 PRODUCTS

SELECT p.product_name, SUM(od.quantity) AS total_sold
FROM Order_Details od
JOIN Product p ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 3;

-- UPDATE STOCK

UPDATE Product
SET stock = stock - 1
WHERE product_id = 101;

-- DELETE ORDER

DELETE FROM Orders
WHERE order_id = 1002;