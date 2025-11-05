-- Basic INSERT: Bulk insert (1000 rows)
-- This tests bulk insert performance

INSERT INTO users (id, username, email, age, created_at, updated_at)
SELECT 
    seq AS id,
    CONCAT('user_', seq) AS username,
    CONCAT('user_', seq, '@example.com') AS email,
    20 + (seq % 50) AS age,
    NOW() AS created_at,
    NOW() AS updated_at
FROM numbers(1000);
