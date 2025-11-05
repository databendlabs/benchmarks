-- Aggregation and JOIN Benchmark Setup
-- Creates test tables for aggregation and join operations
--
-- Data Sizes (configurable by changing numbers() parameter):
-- - Customers: 10,000 rows
-- - Products: 5,000 rows  
-- - Suppliers: 100 rows
-- - Sales: 100,000 rows (may take a few seconds to generate)
--
-- To test with different scales, modify the numbers() function calls:
-- - Small scale: numbers(1000) for sales
-- - Large scale: numbers(1000000) for sales

CREATE DATABASE IF NOT EXISTS benchmark_aggregation;
USE benchmark_aggregation;

-- Customers table
CREATE TABLE IF NOT EXISTS customers (
    customer_id BIGINT,
    customer_name VARCHAR(100),
    country VARCHAR(50),
    city VARCHAR(50),
    registration_date DATE
);

-- Products table
CREATE TABLE IF NOT EXISTS products (
    product_id BIGINT,
    product_name VARCHAR(200),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    supplier_id BIGINT
);

-- Sales table
CREATE TABLE IF NOT EXISTS sales (
    sale_id BIGINT,
    customer_id BIGINT,
    product_id BIGINT,
    quantity INT,
    sale_amount DECIMAL(12, 2),
    sale_date DATE,
    region VARCHAR(50)
);

-- Suppliers table
CREATE TABLE IF NOT EXISTS suppliers (
    supplier_id BIGINT,
    supplier_name VARCHAR(100),
    country VARCHAR(50),
    rating DECIMAL(3, 2)
);

-- Generate sample data
INSERT INTO customers (customer_id, customer_name, country, city, registration_date)
SELECT 
    seq AS customer_id,
    CONCAT('Customer_', seq) AS customer_name,
    CASE (seq % 5) 
        WHEN 0 THEN 'USA'
        WHEN 1 THEN 'UK'
        WHEN 2 THEN 'Germany'
        WHEN 3 THEN 'France'
        ELSE 'Japan'
    END AS country,
    CONCAT('City_', (seq % 100)) AS city,
    DATE_ADD('2020-01-01', INTERVAL seq DAY) AS registration_date
FROM numbers(10000);

INSERT INTO products (product_id, product_name, category, price, supplier_id)
SELECT 
    seq AS product_id,
    CONCAT('Product_', seq) AS product_name,
    CASE (seq % 5)
        WHEN 0 THEN 'Electronics'
        WHEN 1 THEN 'Clothing'
        WHEN 2 THEN 'Food'
        WHEN 3 THEN 'Books'
        ELSE 'Toys'
    END AS category,
    10.0 + (seq % 1000) AS price,
    (seq % 100) + 1 AS supplier_id
FROM numbers(5000);

INSERT INTO suppliers (supplier_id, supplier_name, country, rating)
SELECT 
    seq AS supplier_id,
    CONCAT('Supplier_', seq) AS supplier_name,
    CASE (seq % 5)
        WHEN 0 THEN 'China'
        WHEN 1 THEN 'India'
        WHEN 2 THEN 'USA'
        WHEN 3 THEN 'Germany'
        ELSE 'Japan'
    END AS country,
    3.0 + (seq % 20) / 10.0 AS rating
FROM numbers(100);

INSERT INTO sales (sale_id, customer_id, product_id, quantity, sale_amount, sale_date, region)
SELECT 
    seq AS sale_id,
    (seq % 10000) + 1 AS customer_id,
    (seq % 5000) + 1 AS product_id,
    (seq % 10) + 1 AS quantity,
    ((seq % 10) + 1) * (10.0 + (seq % 1000)) AS sale_amount,
    DATE_ADD('2023-01-01', INTERVAL (seq % 365) DAY) AS sale_date,
    CASE (seq % 4)
        WHEN 0 THEN 'North'
        WHEN 1 THEN 'South'
        WHEN 2 THEN 'East'
        ELSE 'West'
    END AS region
FROM numbers(100000);
