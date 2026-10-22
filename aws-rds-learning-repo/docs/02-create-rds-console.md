# 2. Create a MySQL RDS database in the AWS Console

AWS Console labels can change slightly over time. Follow the concepts if a label differs.

## Step 1 — Open RDS

1. Sign in to the AWS Management Console.
2. Search for **RDS** and open Amazon RDS.
3. Check the AWS Region selector in the top navigation. Choose the region where you want to practice.
4. Open **Databases** and choose **Create database**.

## Step 2 — Choose the creation method and engine

1. Choose **Standard create** if you want to see the settings.
2. Select **MySQL** as the engine.
3. Choose a supported engine version offered in your region.
4. Select a **Dev/Test** template if it is available and appropriate for this disposable lab. The template changes defaults; review all settings.

## Step 3 — Configure credentials

Example values:
- DB instance identifier: `rds-learning-db`
- Master username: `dbadmin` (or another non-default username)
- Master password: create a strong unique password and store it in a password manager

Do not put the password in this repository or commit it to Git. If AWS offers managed master credentials in Secrets Manager, review that option and its additional charges before selecting it.

## Step 4 — Select instance and storage

For a practice lab:
1. Select a small instance class eligible for your account/region.
2. Select a small storage allocation suitable for sample data.
3. Review storage type, autoscaling, and any additional paid features.
4. Avoid production-sized resources for a beginner exercise.

Exact instance classes and minimum storage sizes change, and some choices depend on engine/version. Read the console's cost estimate before proceeding.

## Step 5 — Configure connectivity

1. Choose the correct VPC. The default VPC may be sufficient for a simple lab, but understand where it places the DB.
2. Select or create a DB subnet group that uses subnets in the required Availability Zones.
3. For a local-computer learning lab, **Public access** may be set to **Yes** temporarily if the VPC/subnet configuration supports it. This does not automatically open the DB to everyone; security group rules still apply. Prefer private access for production.
4. Create/select a DB security group.
5. Add an inbound rule:
   - Type: MySQL/Aurora
   - Protocol: TCP
   - Port: 3306
   - Source: **My IP** (a single current public IP in CIDR form, usually `/32`)
6. Do not use `0.0.0.0/0` for the database port.
7. If your IP changes, update the rule to your new IP rather than opening access broadly.

If the DB must be private, connect through an EC2 bastion, VPN, Direct Connect, or an application host inside the VPC instead of enabling public access.

## Step 6 — Additional settings

- Initial database name: `rds_lab` if the console offers this field.
- Backups: review backup retention. Backups can have storage/cost implications.
- Encryption: enable encryption for data at rest where appropriate; check whether it can be changed later for your selected setup.
- Monitoring: review optional enhanced monitoring and paid add-ons.
- Deletion protection: for a disposable lab, you may leave it disabled if you intend to delete the DB. For important databases, enable it.
- Multi-AZ: usually unnecessary for a short disposable lab, but appropriate availability design depends on the workload.

## Step 7 — Create and wait

1. Review the summary and estimated cost.
2. Choose **Create database**.
3. In **Databases**, wait until the DB status becomes **Available**. Creation can take several minutes.
4. Select the DB and open **Connectivity & security**.
5. Copy:
   - Endpoint (hostname)
   - Port (MySQL usually 3306)
   - DB name, if configured

The endpoint is not the password and is not a web URL. Do not add `https://` to it.

## Step 8 — Confirm the security group

On the DB details page, find the VPC security group and open it. Check inbound rules:
- MySQL TCP 3306
- Source is only your current public IP, not all IPv4 addresses

Security group changes usually apply without restarting the DB, though network/client conditions can still affect connectivity.

## Step 9 — Delete the lab after practice

1. Save any practice notes/data you need.
2. Open RDS → Databases → select `rds-learning-db` → **Actions → Delete**.
3. Review final snapshot and automated backup options. A final snapshot can be useful but may incur ongoing storage charges; skipping it is reasonable only for disposable data you truly do not need.
4. Confirm deletion.
5. If you created a dedicated security group or other resources only for this lab, remove them when no longer used and when AWS permits it.
6. Check the Billing console later for any remaining storage, snapshot, or related charges.

Deleting the DB instance does not necessarily remove every snapshot or retained backup. Review the deletion choices carefully.
