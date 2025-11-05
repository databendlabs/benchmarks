-- Time Window Aggregation: 5-minute buckets
-- Note: This uses TO_UNIX_TIMESTAMP for time bucketing which works across different SQL dialects.
-- If your Databend version supports TIME_WINDOW or other optimized time bucketing functions,
-- consider using those for better performance on large datasets.

SELECT 
    TO_TIMESTAMP(FLOOR(TO_UNIX_TIMESTAMP(timestamp) / 300) * 300) AS time_bucket,
    device_id,
    metric_name,
    AVG(metric_value) AS avg_value,
    MIN(metric_value) AS min_value,
    MAX(metric_value) AS max_value,
    COUNT(*) AS sample_count
FROM metrics
WHERE timestamp >= '2024-01-01 00:00:00' 
  AND timestamp < '2024-01-02 00:00:00'
GROUP BY time_bucket, device_id, metric_name
ORDER BY time_bucket, device_id, metric_name;
