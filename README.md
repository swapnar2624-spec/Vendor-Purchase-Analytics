# Vendor & Purchase Analytics System

## Project Overview

The Vendor & Purchase Analytics System is a MySQL-based database project designed to manage vendors, products, purchase orders, and purchase order items.

The project uses SQL queries to analyze purchasing costs, vendor performance, product quantities, delivery status, delayed orders, and purchase trends.

## Technologies Used

- MySQL
- SQL
- MySQL Workbench

## Database Tables

### 1. Vendors
Stores vendor/supplier information such as vendor name, contact person, phone, email, and city.

### 2. Products
Stores product details including product name, category, unit price, and vendor.

### 3. Purchase Orders
Stores purchase order information including order date, expected delivery date, actual delivery date, and delivery status.

### 4. Purchase Order Items
Stores products included in each purchase order along with quantity and unit price.

## SQL Concepts Used

- CREATE TABLE
- INSERT INTO
- SELECT
- WHERE
- JOIN
- GROUP BY
- ORDER BY
- SUM()
- COUNT()
- AVG()
- DATE_FORMAT()
- Subqueries
- Foreign Keys
- Primary Keys

## Key Analysis Performed

- Total purchase amount
- Vendor-wise purchase analysis
- Product-wise quantity purchased
- Delivery status analysis
- Delayed order analysis
- Total number of purchase orders
- Average order value
- Highest purchase vendor
- Product-wise purchase amount
- Monthly purchase trend
- Vendors with purchases above average

## Sample Business Insights

The database can help identify:

- Vendors with higher purchase volumes
- Products with higher purchase quantities
- Total purchasing expenditure
- Pending and delayed orders
- Average purchase order value
- Monthly purchasing patterns

## How to Run

1. Install MySQL Server and MySQL Workbench.
2. Open MySQL Workbench.
3. Create or select the `vendor_purchase_analytics` database.
4. Open `vendor_purchase_analytics.sql`.
5. Execute the SQL statements.
6. Run the analysis queries to view the results.

## Project Structure

```text
Vendor-Purchase-Analytics/
│
├── vendor_purchase_analytics.sql
└── README.md
