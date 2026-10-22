# Amazon RDS for MySQL — CRUD Practice Lab

A beginner-friendly, ready-to-run lab for students using an **Amazon Linux 2023 / Amazon Linux 2 / RHEL EC2 instance** as a MySQL client and **Amazon RDS for MySQL** as the database server.

## What you will learn

- Install the MySQL command-line client on EC2.
- Configure network access from EC2 to RDS on TCP port `3306`.
- Connect to an RDS MySQL endpoint.
- Create a database and table.
- Insert 20 sample student records.
- Read, filter, sort, update, and delete records.
- Verify the effect of each CRUD operation.

## Architecture

```text
Student terminal on EC2
        |
        | MySQL client over TCP 3306
        v
Amazon RDS for MySQL
  └── database: student_lab
       └── table: students
```

> The MySQL client is installed on EC2. MySQL Server is managed by RDS; do **not** install a database server on the EC2 instance for this lab.

## Prerequisites

1. An RDS for MySQL DB instance that has finished creating and is `Available`.
2. The RDS endpoint, port (usually `3306`), database master username, and password—or preferably a dedicated lab user with limited permissions.
3. An EC2 instance running Amazon Linux or RHEL.
4. Network connectivity between EC2 and RDS.

### Required security-group rule

On the **RDS DB instance's VPC security group**, add an inbound rule:

| Type | Protocol | Port | Source |
|---|---|---:|---|
| MySQL/Aurora | TCP | 3306 | **The EC2 instance's security group ID** |

For example, source `sg-0123456789abcdef0` (replace with your EC2 security group ID). Prefer security-group-to-security-group access. Do **not** expose port 3306 to `0.0.0.0/0`.

The EC2 instance must be able to route to the RDS endpoint. For a private RDS instance, use EC2 in the same VPC or a properly connected network. RDS does not need to be publicly accessible for this lab.

## Step 1 — Install the MySQL client on EC2

First connect to EC2 using SSH or EC2 Instance Connect.

### Amazon Linux 2023

```bash
sudo dnf install mariadb105 -y
```

The Amazon Linux 2023 package provides a MySQL-compatible command-line client. Check it:

```bash
mysql --version
```

If your Amazon Linux 2023 repository does not provide that package, check available client packages with `dnf search mariadb` and install the available client package (for example, `mariadb` or `mariadb105`).

### Amazon Linux 2

```bash
sudo yum install mariadb -y
mysql --version
```

### RHEL 8 / RHEL 9

```bash
sudo dnf install mariadb -y
mysql --version
```

If your enabled RHEL repositories do not contain the client package, enable the appropriate approved repository for your environment or use your organization's approved MySQL client package. You only need a **client**, not `mysqld`.

## Step 2 — Collect the RDS connection details

In AWS Console, open **RDS → Databases → your DB instance → Connectivity & security**. Copy the endpoint (hostname), port, and note the username you will use.

An endpoint looks like:

```text
mydb.abcdefghijk.ap-south-1.rds.amazonaws.com
```

Use the endpoint hostname only—do not add `https://` and do not use the RDS console URL.

Set shell variables to avoid repeatedly typing the endpoint. Replace the example hostname and username:

```bash
export RDS_ENDPOINT='mydb.abcdefghijk.ap-south-1.rds.amazonaws.com'
export RDS_PORT='3306'
export RDS_USER='admin'
```

These variables last only for the current terminal session. Do not put passwords in shell history or commit them to Git.

## Step 3 — Connect to RDS MySQL

```bash
mysql --host="$RDS_ENDPOINT" --port="$RDS_PORT" --user="$RDS_USER" --password
```

Enter the password when prompted. Using `--password` without placing the password after it is intentional: it prompts securely instead of exposing the password in the command line.

After a successful login, you should see a MySQL prompt similar to:

```text
mysql>
```

Run these checks:

```sql
SELECT VERSION();
SELECT USER();
SELECT CURRENT_USER();
SHOW DATABASES;
```

## Step 4 — Create the database, table, and 20 records

At the `mysql>` prompt, run the complete script in [`sql/01_setup_and_seed.sql`](sql/01_setup_and_seed.sql). You can paste its contents into the MySQL prompt, or exit the shell and run it from the EC2 Linux terminal as shown below.

### Option A: paste into the MySQL prompt

Open `sql/01_setup_and_seed.sql`, copy its SQL statements, and paste them into the `mysql>` prompt.

### Option B: run the SQL file from the EC2 terminal

Clone/download this repository onto EC2, then run:

```bash
mysql --host="$RDS_ENDPOINT" --port="$RDS_PORT" --user="$RDS_USER" --password < sql/01_setup_and_seed.sql
```

The script creates `student_lab`, creates the `students` table, and inserts 20 sample records. It uses `CREATE DATABASE IF NOT EXISTS` and clears/re-seeds only the `students` table so repeated practice starts with the same sample data. **Do not run it against a production database or a table containing data you need.**

## Step 5 — Perform CRUD operations

Connect to the database if you are not already connected:

```sql
USE student_lab;
```

### C — Create (INSERT)

```sql
INSERT INTO students (student_code, full_name, course, batch_name, email, city, marks, status)
VALUES ('STU021', 'Aarav Patil', 'AWS', 'AWS-Batch-2', 'aarav.patil@example.com', 'Pune', 86.50, 'Active');
```

Verify the new row:

```sql
SELECT * FROM students WHERE student_code = 'STU021';
```

### R — Read (SELECT)

Read all records:

```sql
SELECT * FROM students;
```

Count the rows (20 after setup; 21 after the example INSERT above):

```sql
SELECT COUNT(*) AS total_students FROM students;
```

Choose specific columns and sort results:

```sql
SELECT student_code, full_name, course, marks
FROM students
ORDER BY marks DESC;
```

Filter by course:

```sql
SELECT student_code, full_name, batch_name
FROM students
WHERE course = 'AWS';
```

Search by partial name:

```sql
SELECT student_code, full_name
FROM students
WHERE full_name LIKE '%Sharma%';
```

Find students with marks of at least 80:

```sql
SELECT student_code, full_name, marks
FROM students
WHERE marks >= 80
ORDER BY marks DESC;
```

### U — Update (UPDATE)

Update one student's marks. Always use a `WHERE` clause when you intend to update a particular row:

```sql
UPDATE students
SET marks = 91.00
WHERE student_code = 'STU021';
```

Verify:

```sql
SELECT student_code, full_name, marks
FROM students
WHERE student_code = 'STU021';
```

Update a student's status:

```sql
UPDATE students
SET status = 'Completed'
WHERE student_code = 'STU005';
```

### D — Delete (DELETE)

Delete only the practice row you inserted:

```sql
DELETE FROM students
WHERE student_code = 'STU021';
```

Verify that it is gone:

```sql
SELECT * FROM students WHERE student_code = 'STU021';
```

The query should return `Empty set`.

> **Safety habit:** Before `UPDATE` or `DELETE`, run a `SELECT` with the same `WHERE` condition. Never run `UPDATE students ...` or `DELETE FROM students` without a `WHERE` clause unless you deliberately intend to affect every row.

## Step 6 — Exit the MySQL shell

```sql
EXIT;
```

## Troubleshooting

### `ERROR 2003` / can't connect to MySQL server

- Confirm the endpoint and port are correct.
- Confirm RDS status is `Available`.
- Check the RDS security group allows inbound TCP `3306` from the EC2 security group.
- Confirm EC2 and RDS can communicate through their VPC/subnet route tables and network ACLs.
- Check that DNS resolution works: `getent hosts "$RDS_ENDPOINT"`.

### `ERROR 1045: Access denied`

- Check the username and password.
- Confirm you are using the correct DB instance and user.
- Check whether the account is allowed to connect and has permissions on `student_lab`.

### `ERROR 1049: Unknown database 'student_lab'`

Run the setup SQL first, then `USE student_lab;`.

### `mysql: command not found`

The client is not installed or not in `PATH`. Repeat the install command for your operating system and check `mysql --version`.

### TLS/SSL considerations

Use the RDS CA certificate and the SSL options required by your organization's policy, especially for production. For a stricter connection, download the current AWS RDS CA bundle from AWS's official RDS documentation and connect with the supported client options, such as `--ssl-mode=VERIFY_IDENTITY` and `--ssl-ca=/path/to/global-bundle.pem` when supported by the installed client. Client options vary by MySQL/MariaDB client version.

## Cleanup

To remove the practice database after the lab (this permanently deletes its contents):

```sql
DROP DATABASE student_lab;
```

Only do this for your own lab database, never a shared or production database.

## Suggested student exercise

1. Insert a new student with code `STU021`.
2. Display only students in `Linux` course.
3. Display the top 5 students by marks.
4. Change `STU003` status to `Completed`.
5. Delete `STU021` and verify it no longer exists.
6. Explain the difference between the EC2 MySQL client and the RDS MySQL database server.

## Repository structure

```text
rds-mysql-crud-lab/
├── README.md
├── .gitignore
├── sql/
│   ├── 01_setup_and_seed.sql
│   └── 02_crud_practice.sql
└── scripts/
    └── check-client.sh
```
