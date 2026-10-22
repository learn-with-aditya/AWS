# 3. Connect to your RDS MySQL database

You need:
- DB status `Available`
- RDS endpoint hostname
- Port (usually `3306`)
- Database name (e.g. `rds_lab`, if created)
- Username and password
- Network path allowed by the security group and VPC settings

## Option A — MySQL command-line client

Install a MySQL-compatible client on your computer. Then run:

```bash
mysql -h YOUR_RDS_ENDPOINT -P 3306 -u dbadmin -p
```

Replace `YOUR_RDS_ENDPOINT` with the exact endpoint from RDS. Do not include `https://`. The `-p` option prompts you for the password; this avoids putting it directly in shell history.

After login, if you created the database during setup:

```sql
SHOW DATABASES;
USE rds_lab;
```

If the database was not created, and your account has permission:

```sql
CREATE DATABASE rds_lab;
USE rds_lab;
```

## Option B — MySQL Workbench (GUI)

1. Open MySQL Workbench.
2. Create a new connection.
3. Connection method: Standard TCP/IP.
4. Hostname: paste the RDS endpoint.
5. Port: `3306` (unless you changed it).
6. Username: your RDS database username.
7. Click **Store in Vault** only if you understand the local-device security implications; otherwise enter the password when prompted.
8. Test Connection, then connect.
9. Open a SQL tab and run the sample SQL scripts in this repository.

## Option C — Application configuration (conceptual)

An application usually needs host, port, database name, username, password, and TLS settings. Store secrets in AWS Secrets Manager or another approved secret store, or inject them securely at runtime. Do not hardcode passwords in source code or commit `.env` files.

Example environment variable names (placeholders only):

```text
DB_HOST=your-rds-endpoint
DB_PORT=3306
DB_NAME=rds_lab
DB_USER=dbadmin
DB_PASSWORD=replace-with-secret
```

This is a list of variable names, not a real `.env` file. Do not paste actual credentials into a public repository.

## Run the practice SQL

After connecting, run these files in order:
1. `sql/01-create-database-and-table.sql`
2. `sql/02-insert-sample-data.sql`
3. `sql/03-practice-queries.sql`

If `rds_lab` was created at RDS setup, the first script selects it and creates a table. If not, create it first using the SQL in Option A.

## What a successful connection proves

A successful connection means the client can resolve/reach the endpoint, the network path allows the port, the database engine accepts the credentials, and the user has sufficient privileges. It does not by itself prove that the DB is production-ready.
