-- Window Functions: LAG and LEAD for time-series comparison

SELECT 
    timestamp,
    symbol,
    close_price,
    LAG(close_price, 1) OVER (PARTITION BY symbol ORDER BY timestamp) AS prev_close,
    LEAD(close_price, 1) OVER (PARTITION BY symbol ORDER BY timestamp) AS next_close,
    close_price - LAG(close_price, 1) OVER (PARTITION BY symbol ORDER BY timestamp) AS price_change
FROM stock_prices
ORDER BY symbol, timestamp;
