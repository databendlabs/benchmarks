-- Moving Average: 10-period moving average for stock prices

SELECT 
    timestamp,
    symbol,
    close_price,
    AVG(close_price) OVER (
        PARTITION BY symbol 
        ORDER BY timestamp 
        ROWS BETWEEN 9 PRECEDING AND CURRENT ROW
    ) AS moving_avg_10
FROM stock_prices
ORDER BY symbol, timestamp;
