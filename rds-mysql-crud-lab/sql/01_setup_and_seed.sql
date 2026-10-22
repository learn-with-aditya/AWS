-- Amazon RDS for MySQL CRUD Lab: setup and seed data
-- WARNING: This lab setup drops/recreates the practice table's data.
-- Run only in your own practice database, never in production.

CREATE DATABASE IF NOT EXISTS student_lab;
USE student_lab;

CREATE TABLE IF NOT EXISTS students (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    student_code VARCHAR(10) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    course ENUM('DA/DS', 'Linux', 'AWS', 'DevOps') NOT NULL,
    batch_name VARCHAR(30) NOT NULL,
    email VARCHAR(150) NOT NULL,
    city VARCHAR(80) NOT NULL,
    marks DECIMAL(5,2) NOT NULL DEFAULT 0.00,
    status ENUM('Active', 'Completed', 'On Hold') NOT NULL DEFAULT 'Active',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_students_student_code (student_code),
    UNIQUE KEY uq_students_email (email),
    KEY idx_students_course (course),
    KEY idx_students_batch (batch_name)
) ENGINE=InnoDB;

-- Reset the sample data so this script can be rerun for practice.
DELETE FROM students;
ALTER TABLE students AUTO_INCREMENT = 1;

INSERT INTO students
(student_code, full_name, course, batch_name, email, city, marks, status)
VALUES
('STU001', 'Aarav Sharma',       'AWS',   'AWS-Batch-1',   'aarav.sharma@example.com',       'Mumbai',    88.50, 'Active'),
('STU002', 'Priya Patil',        'Linux', 'Linux-Batch-1', 'priya.patil@example.com',        'Pune',      91.00, 'Active'),
('STU003', 'Rohan Verma',        'DevOps','DevOps-Batch-1','rohan.verma@example.com',        'Nashik',    76.50, 'Active'),
('STU004', 'Sneha Gupta',        'DA/DS', 'DA-DS-Batch-1', 'sneha.gupta@example.com',        'Thane',     84.00, 'Active'),
('STU005', 'Vikram Singh',       'AWS',   'AWS-Batch-2',   'vikram.singh@example.com',       'Nagpur',    69.50, 'On Hold'),
('STU006', 'Ananya Desai',       'Linux', 'Linux-Batch-1', 'ananya.desai@example.com',       'Mumbai',    95.00, 'Active'),
('STU007', 'Ishaan Joshi',       'DevOps','DevOps-Batch-1','ishaan.joshi@example.com',       'Pune',      81.00, 'Active'),
('STU008', 'Kavya Nair',         'DA/DS', 'DA-DS-Batch-1', 'kavya.nair@example.com',         'Navi Mumbai',87.50,'Completed'),
('STU009', 'Aditya Kulkarni',    'AWS',   'AWS-Batch-1',   'aditya.kulkarni@example.com',    'Kolhapur',  73.00, 'Active'),
('STU010', 'Meera Iyer',         'Linux', 'Linux-Batch-2', 'meera.iyer@example.com',         'Mumbai',    89.00, 'Active'),
('STU011', 'Rahul Chavan',       'DevOps','DevOps-Batch-2','rahul.chavan@example.com',       'Aurangabad',78.00,'Active'),
('STU012', 'Pooja Mishra',       'DA/DS', 'DA-DS-Batch-2', 'pooja.mishra@example.com',       'Pune',      92.50, 'Completed'),
('STU013', 'Karan Mehta',        'AWS',   'AWS-Batch-2',   'karan.mehta@example.com',        'Surat',     66.00, 'Active'),
('STU014', 'Diya Shah',          'Linux', 'Linux-Batch-2', 'diya.shah@example.com',          'Ahmedabad', 85.50, 'Active'),
('STU015', 'Siddharth Rao',      'DevOps','DevOps-Batch-2','siddharth.rao@example.com',      'Bengaluru', 90.00, 'Active'),
('STU016', 'Ira Fernandes',      'DA/DS', 'DA-DS-Batch-2', 'ira.fernandes@example.com',      'Goa',       79.50, 'On Hold'),
('STU017', 'Manav Pawar',        'AWS',   'AWS-Batch-3',   'manav.pawar@example.com',        'Mumbai',    82.00, 'Active'),
('STU018', 'Tanya Kapoor',       'Linux', 'Linux-Batch-3', 'tanya.kapoor@example.com',       'Delhi',     94.00, 'Completed'),
('STU019', 'Omkar Jadhav',       'DevOps','DevOps-Batch-3','omkar.jadhav@example.com',        'Pune',      71.50, 'Active'),
('STU020', 'Zoya Khan',          'DA/DS', 'DA-DS-Batch-3', 'zoya.khan@example.com',          'Hyderabad', 86.00, 'Active');

SELECT COUNT(*) AS seeded_records FROM students;
SELECT student_code, full_name, course, batch_name, marks, status
FROM students
ORDER BY id;
