-- Time Range Query: Query data within specific time range

SELECT 
    metric_name,
    COUNT(*) AS data_points,
    AVG(metric_value) AS avg_value,
    STDDEV(metric_value) AS stddev_value
FROM metrics
WHERE timestamp >= '2024-01-01 12:00:00' 
  AND timestamp < '2024-01-01 18:00:00'
  AND device_id IN ('device_1', 'device_2', 'device_3')
GROUP BY metric_name;
