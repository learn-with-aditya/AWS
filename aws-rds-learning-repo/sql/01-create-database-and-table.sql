-- Run after connecting to the intended RDS MySQL instance.
-- If rds_lab already exists, CREATE DATABASE IF NOT EXISTS leaves it in place.
CREATE DATABASE IF NOT EXISTS rds_lab;
USE rds_lab;

CREATE TABLE IF NOT EXISTS students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    course VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Confirm the table exists:
SHOW TABLES;
DESCRIBE students;
