-- INNER JOIN: Multi-table join

SELECT 
    s.sale_id,
    s.sale_date,
    s.sale_amount,
    c.customer_name,
    c.country AS customer_country,
    p.product_name,
    p.category,
    sup.supplier_name,
    sup.country AS supplier_country
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
INNER JOIN products p ON s.product_id = p.product_id
INNER JOIN suppliers sup ON p.supplier_id = sup.supplier_id
LIMIT 1000;
