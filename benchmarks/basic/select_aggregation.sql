-- Basic SELECT: Query with aggregation

SELECT 
    COUNT(*) AS total_users,
    AVG(age) AS avg_age,
    MIN(age) AS min_age,
    MAX(age) AS max_age
FROM users;
