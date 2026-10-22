-- Run after connecting to RDS and selecting student_lab.
USE student_lab;

-- READ: all rows
SELECT * FROM students;

-- READ: selected columns, highest marks first
SELECT student_code, full_name, course, marks
FROM students
ORDER BY marks DESC;

-- READ: filter by course
SELECT student_code, full_name, batch_name
FROM students
WHERE course = 'AWS';

-- READ: search names
SELECT student_code, full_name
FROM students
WHERE full_name LIKE '%Sharma%';

-- READ: top 5 students
SELECT student_code, full_name, marks
FROM students
ORDER BY marks DESC
LIMIT 5;

-- CREATE: add one test row
INSERT INTO students (student_code, full_name, course, batch_name, email, city, marks, status)
VALUES ('STU021', 'Aarav Patil', 'AWS', 'AWS-Batch-2', 'aarav.patil@example.com', 'Pune', 86.50, 'Active');

-- UPDATE: inspect first, then update a single row
SELECT * FROM students WHERE student_code = 'STU021';
UPDATE students SET marks = 91.00 WHERE student_code = 'STU021';
SELECT student_code, full_name, marks FROM students WHERE student_code = 'STU021';

-- DELETE: inspect first, then delete the test row
SELECT * FROM students WHERE student_code = 'STU021';
DELETE FROM students WHERE student_code = 'STU021';
SELECT * FROM students WHERE student_code = 'STU021';
