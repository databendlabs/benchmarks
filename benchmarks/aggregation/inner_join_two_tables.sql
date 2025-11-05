-- INNER JOIN: Two tables

SELECT 
    s.sale_id,
    s.sale_date,
    s.sale_amount,
    c.customer_name,
    c.country
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
LIMIT 1000;
