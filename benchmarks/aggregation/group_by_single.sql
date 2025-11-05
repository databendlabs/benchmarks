-- GROUP BY: Single column grouping

SELECT 
    region,
    COUNT(*) AS sale_count,
    SUM(sale_amount) AS total_revenue,
    AVG(sale_amount) AS avg_revenue
FROM sales
GROUP BY region
ORDER BY total_revenue DESC;
