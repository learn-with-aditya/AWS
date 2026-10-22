# AWS RDS for Beginners — Create a Database and Connect to It

A beginner-friendly, hands-on learning repository for understanding Amazon Relational Database Service (Amazon RDS), creating a managed database, connecting securely, and troubleshooting common issues.

> **Cost warning:** RDS is a paid AWS service. Create a small lab instance, check the estimate shown in the console, and delete the DB instance when finished. Deletion and backup choices affect whether charges continue.

## Learning outcomes

By completing this lab, you will be able to:
- Explain what Amazon RDS is and when to use it.
- Distinguish a database engine, DB instance, database, endpoint, port, and credentials.
- Create a MySQL RDS database in the AWS Console.
- Configure network access using a VPC security group.
- Connect from a computer using a SQL client or MySQL CLI.
- Create a table, insert rows, query data, and clean up resources safely.
- Diagnose common connection failures.

## Repository map

```text
aws-rds-learning-repo/
├── README.md
├── docs/
│   ├── 01-rds-basics.md
│   ├── 02-create-rds-console.md
│   ├── 03-connect-to-rds.md
│   ├── 04-security-and-networking.md
│   └── 05-troubleshooting.md
├── sql/
│   ├── 01-create-database-and-table.sql
│   ├── 02-insert-sample-data.sql
│   ├── 03-practice-queries.sql
│   └── 04-cleanup.sql
├── diagrams/
│   └── connection-flow.md
└── .gitignore
```

## Lab architecture

Your computer (MySQL client) → Internet → RDS DB endpoint, allowed by the DB security group.

For a real application, prefer:
Application server (EC2 / ECS / Lambda with suitable networking) → private RDS endpoint inside the VPC. Avoid public database access where possible.

## Prerequisites

- An AWS account and permission to create RDS, VPC security groups, and related resources.
- A computer with a current MySQL client, or a GUI such as MySQL Workbench.
- Your own public IP address, to use as a narrowly scoped inbound rule.
- Basic SQL knowledge helps, but the SQL files include comments.

## Recommended beginner lab choices

For a low-cost learning lab, choose a small eligible instance class and a small storage allocation offered in your region. Availability and pricing vary by region, engine, and account eligibility. Review the price estimate before creating the resource. Do not assume the lab is free.

- Engine: MySQL
- Template: Dev/Test (if available)
- DB identifier: `rds-learning-db`
- Initial database name (if the console offers it): `rds_lab`
- Public access: only temporarily for a local-computer lab, if necessary
- Security group inbound: MySQL TCP 3306 from **My IP** only
- Multi-AZ: disabled for a disposable practice lab unless your exercise requires it
- Deletion protection: disabled only for a disposable lab that you intend to delete

**Never** use `0.0.0.0/0` as the inbound source for a database port. Never commit passwords, access keys, connection strings containing passwords, or real customer data to Git.

## Quick start

1. Read [`docs/01-rds-basics.md`](docs/01-rds-basics.md).
2. Follow [`docs/02-create-rds-console.md`](docs/02-create-rds-console.md).
3. Wait until RDS status is `Available`.
4. Copy the endpoint from **RDS → Databases → your DB → Connectivity & security**.
5. Follow [`docs/03-connect-to-rds.md`](docs/03-connect-to-rds.md).
6. Run the SQL files in order: `sql/01...`, `sql/02...`, then `sql/03...`.
7. Delete the database after practice using the cleanup checklist in the creation guide.

## Important terms

| Term | Meaning |
|---|---|
| RDS | AWS managed relational database service |
| DB engine | Database software, such as MySQL or PostgreSQL |
| DB instance | Managed compute/storage resource that runs the database engine |
| Database/schema | Logical container for tables; exact terminology varies by engine |
| Endpoint | DNS hostname clients use to reach the DB instance |
| Port | Network entry point; MySQL commonly uses 3306, PostgreSQL 5432 |
| VPC | Isolated virtual network in AWS |
| Security group | Stateful virtual firewall attached to network interfaces/resources |
| Subnet group | Subnets RDS can use in a VPC |
| Backup / snapshot | Data recovery mechanism; retention and deletion behavior depend on settings |

## Completion checklist

- [ ] I can explain RDS versus installing MySQL on an EC2 instance.
- [ ] I created an RDS MySQL DB instance and found its endpoint.
- [ ] I allowed only my current public IP on TCP 3306.
- [ ] I connected using a client.
- [ ] I created and queried a table.
- [ ] I know how to close access and delete the lab resource.
