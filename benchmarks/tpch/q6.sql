-- TPC-H Query 6: Forecasting Revenue Change
-- This query quantifies the amount of revenue increase from eliminating certain discounts

SELECT
    SUM(l_extendedprice * l_discount) AS revenue
FROM
    lineitem
WHERE
    l_shipdate >= DATE '1994-01-01'
    AND l_shipdate < DATE '1994-01-01' + INTERVAL '1' YEAR
    AND l_discount BETWEEN 0.05 AND 0.07
    AND l_quantity < 24;
