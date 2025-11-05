-- Time-Series Benchmark Setup
-- Creates test tables for time-series operations

CREATE DATABASE IF NOT EXISTS benchmark_timeseries;
USE benchmark_timeseries;

-- Metrics table (IoT/monitoring style)
CREATE TABLE IF NOT EXISTS metrics (
    timestamp TIMESTAMP,
    device_id VARCHAR(50),
    metric_name VARCHAR(50),
    metric_value DOUBLE,
    tags VARCHAR(200)
);

-- Stock prices table
CREATE TABLE IF NOT EXISTS stock_prices (
    timestamp TIMESTAMP,
    symbol VARCHAR(10),
    open_price DECIMAL(10, 2),
    close_price DECIMAL(10, 2),
    high_price DECIMAL(10, 2),
    low_price DECIMAL(10, 2),
    volume BIGINT
);

-- Application logs table
CREATE TABLE IF NOT EXISTS app_logs (
    timestamp TIMESTAMP,
    app_name VARCHAR(50),
    log_level VARCHAR(10),
    response_time INT,
    status_code INT,
    endpoint VARCHAR(100)
);

-- Generate sample metrics data (1M rows)
INSERT INTO metrics (timestamp, device_id, metric_name, metric_value, tags)
SELECT 
    DATE_ADD('2024-01-01 00:00:00', INTERVAL seq SECOND) AS timestamp,
    CONCAT('device_', (seq % 100) + 1) AS device_id,
    CASE (seq % 5)
        WHEN 0 THEN 'cpu_usage'
        WHEN 1 THEN 'memory_usage'
        WHEN 2 THEN 'disk_io'
        WHEN 3 THEN 'network_throughput'
        ELSE 'temperature'
    END AS metric_name,
    RAND() * 100 AS metric_value,
    CONCAT('datacenter=dc', ((seq % 10) + 1)) AS tags
FROM numbers(1000000);

-- Generate sample stock data
INSERT INTO stock_prices (timestamp, symbol, open_price, close_price, high_price, low_price, volume)
SELECT 
    DATE_ADD('2024-01-01', INTERVAL seq DAY) AS timestamp,
    CASE (seq % 5)
        WHEN 0 THEN 'AAPL'
        WHEN 1 THEN 'GOOGL'
        WHEN 2 THEN 'MSFT'
        WHEN 3 THEN 'AMZN'
        ELSE 'TSLA'
    END AS symbol,
    100.0 + (seq % 100) AS open_price,
    100.0 + ((seq + 1) % 100) AS close_price,
    100.0 + ((seq + 5) % 100) AS high_price,
    100.0 + ((seq - 5) % 100) AS low_price,
    1000000 + (seq * 10000) AS volume
FROM numbers(1000);

-- Generate sample application logs
INSERT INTO app_logs (timestamp, app_name, log_level, response_time, status_code, endpoint)
SELECT 
    DATE_ADD('2024-01-01 00:00:00', INTERVAL seq SECOND) AS timestamp,
    CONCAT('app_', (seq % 10) + 1) AS app_name,
    CASE (seq % 10)
        WHEN 0 THEN 'ERROR'
        WHEN 1 THEN 'WARN'
        WHEN 2 THEN 'WARN'
        ELSE 'INFO'
    END AS log_level,
    50 + (seq % 500) AS response_time,
    CASE (seq % 20)
        WHEN 0 THEN 500
        WHEN 1 THEN 404
        WHEN 2 THEN 400
        ELSE 200
    END AS status_code,
    CONCAT('/api/v1/endpoint', (seq % 20)) AS endpoint
FROM numbers(500000);
