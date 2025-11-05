-- Time-based Trend Analysis: Compare current vs previous period

SELECT 
    DATE_TRUNC('hour', timestamp) AS hour,
    COUNT(*) AS log_count,
    AVG(response_time) AS avg_response_time,
    SUM(CASE WHEN status_code >= 400 THEN 1 ELSE 0 END) AS error_count
FROM app_logs
WHERE timestamp >= '2024-01-01 00:00:00' 
  AND timestamp < '2024-01-02 00:00:00'
GROUP BY hour
ORDER BY hour;
