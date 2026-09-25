USE vendor_purchase_analytics;
CREATE TABLE vendors (
    vendor_id INT PRIMARY KEY,
    vendor_name VARCHAR(100),
    contact_person VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    city VARCHAR(50)
);
CREATE TABLE products (
	product_id INT PRIMARY KEY,
	product_name VARCHAR(100),
	category VARCHAR(50),
	unit_price DECIMAL(10,2),
	vendor_id INT,
	FOREIGN KEY (vendor_id)
REFERENCES vendors(vendor_id)
);

SHOW TABLES;

SELECT * FROM vendors;

INSERT INTO vendors
(vendor_id, vendor_name, contact_person, phone, email, city)
VALUES
(1, 'ABC Electronics', 'Ravi Kumar', '9876543210', 'abc@gmail.com', 'Hyderabad'),
(2, 'Tech Solutions', 'Priya Sharma', '9876543211', 'tech@gmail.com', 'Bangalore'),
(3, 'Global Supplies', 'Arun Kumar', '9876543212', 'global@gmail.com', 'Chennai');

INSERT INTO products
(product_id, product_name, category, unit_price, vendor_id)
VALUES
(1, 'Laptop', 'Electronics', 50000, 1),
(2, 'Monitor', 'Electronics', 15000, 2),
(3, 'Keyboard', 'Accessories', 1200, 1),
(4, 'Mouse', 'Accessories', 700, 2),
(5, 'Printer', 'Office Equipment', 12000, 3);

 SELECT * FROM products 
 
 CREATE TABLE purchase_orders (
	 order_id INT PRIMARY KEY,
     vendor_id INT, 
     order_date DATE,
     expected_date DATE,
     delivery_date DATE,
     delivery_status VARCHAR(30),
     FOREIGN KEY (vendor_id)
REFERENCES vendors(vendor_id)
);

SELECT * FROM purchase_orders;

INSERT INTO purchase_orders
(order_id, vendor_id, order_date, expected_date, delivery_date, delivery_status)
VALUES
(101, 1, '2026-09-01', '2026-09-05', '2026-09-04', 'Delivered'),
(102, 2, '2026-09-03', '2026-09-08', NULL, 'Pending'),
(103, 1, '2026-09-07', '2026-09-12', '2026-09-14', 'Delayed'),
(104, 3, '2026-09-10', '2026-09-15', '2026-09-15', 'Delivered'),
(105, 2, '2026-09-15', '2026-09-20', NULL, 'Pending');
    
CREATE TABLE purchase_order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES purchase_orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO purchase_order_items
(order_item_id, order_id, product_id, quantity, unit_price)
VALUES
(1, 101, 1, 5, 50000),
(2, 101, 3, 10, 1200),
(3, 102, 2, 10, 15000),
(4, 103, 1, 3, 50000),
(5, 104, 5, 2, 12000),
(6, 105, 4, 20, 700); 

SELECT 
    SUM(quantity * unit_price) AS total_purchase_amount
FROM purchase_order_items; 

SELECT 
    v.vendor_name,
    SUM(poi.quantity * poi.unit_price) AS total_purchase
FROM vendors v
JOIN purchase_orders po
    ON v.vendor_id = po.vendor_id
JOIN purchase_order_items poi
    ON po.order_id = poi.order_id
GROUP BY v.vendor_name;  

SELECT
    p.product_name,
    SUM(poi.quantity) AS total_quantity
FROM products p
JOIN purchase_order_items poi
    ON p.product_id = poi.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC;

SELECT
    delivery_status,
    COUNT(*) AS total_orders
FROM purchase_orders
GROUP BY delivery_status;

SELECT
    po.order_id,
    v.vendor_name,
    po.order_date,
    po.expected_date,
    po.delivery_date,
    po.delivery_status
FROM purchase_orders po
JOIN vendors v
    ON po.vendor_id = v.vendor_id
WHERE po.delivery_status = 'Delayed';

SELECT
    COUNT(*) AS total_orders
FROM purchase_orders; 

SELECT
    AVG(order_total) AS average_order_value
FROM (
    SELECT
        order_id,
        SUM(quantity * unit_price) AS order_total
    FROM purchase_order_items
    GROUP BY order_id
) AS order_summary;

SELECT
    v.vendor_name,
    SUM(poi.quantity * poi.unit_price) AS total_purchase
FROM vendors v
JOIN purchase_orders po
    ON v.vendor_id = po.vendor_id
JOIN purchase_order_items poi
    ON po.order_id = poi.order_id
GROUP BY v.vendor_name
ORDER BY total_purchase DESC
LIMIT 1;

SELECT
    p.product_name,
    SUM(poi.quantity * poi.unit_price) AS total_purchase_amount
FROM products p
JOIN purchase_order_items poi
    ON p.product_id = poi.product_id
GROUP BY p.product_name
ORDER BY total_purchase_amount DESC; 

SELECT
    DATE_FORMAT(po.order_date, '%Y-%m') AS purchase_month,
    SUM(poi.quantity * poi.unit_price) AS total_purchase
FROM purchase_orders po
JOIN purchase_order_items poi
    ON po.order_id = poi.order_id
GROUP BY DATE_FORMAT(po.order_date, '%Y-%m')
ORDER BY purchase_month;

SELECT
    vendor_name,
    total_purchase
FROM (
    SELECT
        v.vendor_name,
        SUM(poi.quantity * poi.unit_price) AS total_purchase
    FROM vendors v
    JOIN purchase_orders po
        ON v.vendor_id = po.vendor_id
    JOIN purchase_order_items poi
        ON po.order_id = poi.order_id
    GROUP BY v.vendor_name
) AS vendor_summary
WHERE total_purchase > (
    SELECT AVG(total_purchase)
    FROM (
        SELECT
            SUM(poi.quantity * poi.unit_price) AS total_purchase
        FROM vendors v
        JOIN purchase_orders po
            ON v.vendor_id = po.vendor_id
        JOIN purchase_order_items poi
            ON po.order_id = poi.order_id
        GROUP BY v.vendor_id
    ) AS avg_vendor_purchase
);

SELECT * FROM vendors;

SELECT * FROM products;

SELECT * FROM purchase_orders;

SELECT * FROM purchase_order_items;

SHOW TABLES;



