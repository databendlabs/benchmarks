-- Simple Aggregation: Basic aggregate functions

SELECT 
    COUNT(*) AS total_sales,
    SUM(sale_amount) AS total_revenue,
    AVG(sale_amount) AS avg_sale,
    MIN(sale_amount) AS min_sale,
    MAX(sale_amount) AS max_sale
FROM sales;
