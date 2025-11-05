-- Basic UPDATE: Single row update

UPDATE users 
SET email = 'newemail@example.com', updated_at = NOW()
WHERE id = 1;
