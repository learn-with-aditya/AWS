USE rds_lab;

INSERT INTO students (full_name, course, email)
VALUES
    ('Aarav Sharma', 'AWS Cloud Fundamentals', 'aarav@example.com'),
    ('Meera Patel', 'Linux Administration', 'meera@example.com'),
    ('Kabir Singh', 'DevOps Foundations', 'kabir@example.com');

-- If you run this script repeatedly, duplicate email values will trigger
-- the UNIQUE constraint. This is intentional for a beginner's data-integrity lesson.
SELECT * FROM students;
