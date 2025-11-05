-- Complex Query: JOIN with aggregation and subquery

SELECT 
    c.country,
    COUNT(DISTINCT c.customer_id) AS customer_count,
    SUM(s.sale_amount) AS total_revenue,
    AVG(s.sale_amount) AS avg_sale
FROM customers c
INNER JOIN sales s ON c.customer_id = s.customer_id
WHERE s.sale_date >= '2023-01-01'
GROUP BY c.country
HAVING SUM(s.sale_amount) > 50000
ORDER BY total_revenue DESC;
