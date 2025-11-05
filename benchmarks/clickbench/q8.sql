-- ClickBench Query 8: Time-based analysis

SELECT DATE_TRUNC('minute', EventTime) AS m, COUNT(*) AS c 
FROM hits 
GROUP BY m 
ORDER BY c DESC 
LIMIT 10;
