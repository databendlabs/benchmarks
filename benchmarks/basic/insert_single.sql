-- Basic INSERT: Single row insert

INSERT INTO users (id, username, email, age, created_at, updated_at)
VALUES (1, 'john_doe', 'john@example.com', 30, NOW(), NOW());
