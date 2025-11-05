-- GROUP BY: Aggregation with HAVING clause

SELECT 
    customer_id,
    COUNT(*) AS purchase_count,
    SUM(sale_amount) AS total_spent
FROM sales
GROUP BY customer_id
HAVING SUM(sale_amount) > 10000
ORDER BY total_spent DESC
LIMIT 100;
