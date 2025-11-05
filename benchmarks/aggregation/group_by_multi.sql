-- GROUP BY: Multi-column grouping

SELECT 
    region,
    DATE_TRUNC('month', sale_date) AS sale_month,
    COUNT(*) AS sale_count,
    SUM(sale_amount) AS total_revenue
FROM sales
GROUP BY region, sale_month
ORDER BY region, sale_month;
