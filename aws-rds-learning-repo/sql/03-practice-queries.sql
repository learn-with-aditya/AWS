USE rds_lab;

-- 1. Read every row
SELECT * FROM students;

-- 2. Choose specific columns
SELECT full_name, course FROM students;

-- 3. Filter rows
SELECT * FROM students
WHERE course = 'Linux Administration';

-- 4. Sort newest first
SELECT student_id, full_name, created_at
FROM students
ORDER BY created_at DESC;

-- 5. Count rows
SELECT COUNT(*) AS total_students
FROM students;

-- 6. Update a row (always use a WHERE clause for targeted updates)
UPDATE students
SET course = 'AWS Solutions Architect'
WHERE email = 'aarav@example.com';

-- 7. Verify the update
SELECT * FROM students
WHERE email = 'aarav@example.com';

-- Practice tasks:
-- A. Add one student with a unique email.
-- B. List students whose names start with 'M'.
-- C. Count students per course using GROUP BY.
-- D. Delete one sample row by student_id, then verify the result.
