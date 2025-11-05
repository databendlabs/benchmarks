-- Basic CRUD Benchmark Setup
-- Creates test tables for basic operations

CREATE DATABASE IF NOT EXISTS benchmark_basic;
USE benchmark_basic;

-- Users table for testing
CREATE TABLE IF NOT EXISTS users (
    id BIGINT,
    username VARCHAR(50),
    email VARCHAR(100),
    age INT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

-- Products table for testing
CREATE TABLE IF NOT EXISTS products (
    product_id BIGINT,
    product_name VARCHAR(200),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock_quantity INT,
    created_at TIMESTAMP
);

-- Orders table for testing
CREATE TABLE IF NOT EXISTS orders (
    order_id BIGINT,
    user_id BIGINT,
    product_id BIGINT,
    quantity INT,
    total_amount DECIMAL(10, 2),
    order_date TIMESTAMP,
    status VARCHAR(20)
);

-- Logs table for bulk insert testing
CREATE TABLE IF NOT EXISTS logs (
    log_id BIGINT,
    log_level VARCHAR(10),
    message VARCHAR(500),
    timestamp TIMESTAMP,
    source VARCHAR(50)
);
