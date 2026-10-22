# 4. Security and networking explained

## Connection path

1. Your client resolves the RDS endpoint DNS name.
2. Traffic travels through the network path to the DB endpoint.
3. VPC routing and network controls must permit the path.
4. The DB's security group must allow inbound TCP on the database port from the client's source.
5. The database engine validates username/password and privileges.

A failure at any layer can prevent a connection.

## Public versus private access

- **Publicly accessible:** AWS can assign a publicly reachable path when the VPC/subnet/routing configuration supports it. You still need restrictive security group rules.
- **Private:** the database is reachable only from suitable network paths inside or connected to the VPC.

Production recommendation: place RDS in private subnets and allow inbound DB traffic only from the security group used by the application server. Avoid using a laptop's public IP as a permanent production rule.

## Security group example

| Setting | Practice value |
|---|---|
| Type | MySQL/Aurora |
| Protocol | TCP |
| Port | 3306 |
| Source | Your current public IP `/32` |

Do not use `0.0.0.0/0`. That source means any IPv4 address can attempt to connect to the port.

For an EC2 application server, a stronger pattern is to set the RDS inbound source to the **application EC2 security group**, rather than a broad IP range. Both resources must have compatible network connectivity.

## Database user permissions

The master user is for administration, not the default application identity. For real applications:
- Create a separate database user for the app.
- Grant only required privileges.
- Rotate credentials.
- Store credentials securely.
- Use TLS when supported/required by your security policy.
- Audit access and monitor database activity.

## Backups and high availability are different

- **Backup / snapshot:** helps recover data from a prior point or snapshot.
- **Multi-AZ:** improves availability/failover for supported configurations; it is not a substitute for backup.
- **Read replica:** primarily used to scale reads and/or support replication use cases; it is not automatically a complete backup strategy.

Test restore procedures. A backup that has never been restored is an unverified recovery plan.
