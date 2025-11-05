-- LEFT JOIN: Outer join operation

SELECT 
    c.customer_id,
    c.customer_name,
    COUNT(s.sale_id) AS purchase_count,
    COALESCE(SUM(s.sale_amount), 0) AS total_spent
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC
LIMIT 100;
