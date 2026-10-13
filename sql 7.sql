-- Create Tables
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT, -- Note: Contains NULLs for guest checkouts
    product_id INT,
    order_date DATE
);

-- Insert Mock Data
INSERT INTO customers VALUES 
(1, 'Alice Smith', 'USA'),
(2, 'Bob Jones', 'Canada'),
(3, 'Charlie Brown', 'UK'),
(4, 'Diana Prince', 'USA'); -- Has never placed an order

INSERT INTO products VALUES 
(101, 'Laptop', 1200.00),
(102, 'Smartphone', 800.00),
(103, 'Wireless Headphones', 150.00),
(104, 'Tablet', 400.00); -- Has never been ordered

INSERT INTO orders VALUES 
(5001, 1, 101, '2026-06-01'), -- Alice bought Laptop
(5002, 2, 102, '2026-06-02'), -- Bob bought Smartphone
(5003, 1, 103, '2026-06-03'), -- Alice bought Headphones
(5004, NULL, 101, '2026-06-04'); -- Guest checkout bought Laptop

--Used INNER JOIN to return only orders that have both valid customer and product details, excluding guest checkouts and unordered products
select order_id,customer_name,product_name 
from orders as o inner join customers as c
on o.customer_id=c.customer_id
inner join products as p
on o.product_id=p.product_id;

--Used LEFT JOIN to include all registered customers, with NULL as Diana Prince’s order_id if she has no orders
select c.customer_id,c.customer_name,order_id
from orders as o left join customers as c
on o.customer_id=c.customer_id;

--Used RIGHT JOIN to include every product, with NULL as the order_id for any product that has never been purchased
select p.product_id,p.product_name,order_id
from orders as o right join products as p
on o.product_id=p.product_id;

--Used INNER JOIN to return only orders that have both valid customer and product details, excluding guest checkouts and unordered products
select * from orders as o full outer join customers as c
on o.customer_id=c.customer_id;

--Used CROSS JOIN to create every possible customer-product combination, producing customers × products total rows
select customer_name,product_name
from customers as c cross join products as p;