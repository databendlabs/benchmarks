-- Basic SELECT: Query with WHERE clause

SELECT id, username, email 
FROM users 
WHERE age > 25 AND age < 40
ORDER BY username
LIMIT 100;
