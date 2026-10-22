# 1. What is Amazon RDS?

Amazon Relational Database Service (Amazon RDS) is a managed AWS service for running relational database engines. AWS handles much of the undifferentiated administration, such as provisioning the underlying infrastructure, routine backups (when enabled/configured), monitoring integration, and supported maintenance operations. You still manage data, schema design, users and permissions, query performance, access rules, and cost choices.

## What does “relational” mean?

Data is stored in tables made of rows and columns. Tables can be related through keys.

Example: a `students` table can store each student's ID, name, and course.

## RDS engines

Common RDS engines include:
- MySQL
- PostgreSQL
- MariaDB
- Oracle
- Microsoft SQL Server
- Amazon Aurora (AWS-built relational database compatible with MySQL or PostgreSQL)

Engine availability and supported versions depend on the region and RDS configuration.

## RDS versus MySQL on EC2

| Area | Amazon RDS | Self-managed MySQL on EC2 |
|---|---|---|
| OS access | No host OS access | You manage the OS |
| Database installation | AWS provisions engine | You install and configure it |
| Backups | Managed backup features available | You design and operate backup jobs |
| Patching | Managed options and maintenance windows | You plan OS and DB patching |
| Control | Less low-level control | More low-level control |
| Operations effort | Usually lower | Usually higher |
| Cost | Pay for configured RDS resources | Pay for EC2, storage, and operational effort |

RDS is not “maintenance-free.” You must still plan capacity, security, backup retention, recovery testing, monitoring, and cost.

## Core architecture terms

- **DB instance:** the managed database resource and its allocated compute/storage configuration.
- **DB engine:** MySQL, PostgreSQL, etc.
- **DB name:** a logical database/schema inside the engine. Some engines/configurations let you specify an initial database during creation; otherwise create one after connecting.
- **Endpoint:** a hostname assigned by RDS. Use the endpoint, not an instance's private IP, in your client configuration.
- **Port:** MySQL typically uses TCP 3306; PostgreSQL typically uses TCP 5432.
- **VPC:** the network boundary in which the DB is placed.
- **Security group:** controls which inbound connections are allowed to reach the DB network interface.
- **DB subnet group:** identifies subnets RDS can use. Production configurations typically span multiple Availability Zones.

## Typical use cases

- Website/application user and product data
- Learning SQL with a managed database
- Business applications and internal tools
- Applications needing managed backup and recovery capabilities

## When not to choose RDS blindly

RDS may not be the right answer for every workload. Consider data model, latency, scale, operational needs, engine features, licensing, and total cost. For document/key-value workloads, a relational database may not be ideal.
