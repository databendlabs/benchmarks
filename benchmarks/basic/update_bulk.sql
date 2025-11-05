-- Basic UPDATE: Bulk update with condition

UPDATE users 
SET age = age + 1, updated_at = NOW()
WHERE age < 30;
