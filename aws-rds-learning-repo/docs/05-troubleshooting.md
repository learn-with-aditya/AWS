# 5. Troubleshooting RDS connections

## `Can't connect to MySQL server` / timeout

Check in this order:
1. DB status is `Available`.
2. You copied the correct endpoint hostname from the DB details.
3. Port is `3306` for MySQL unless configured otherwise.
4. Public access and subnet/routing settings support your chosen connection path.
5. The security group attached to RDS allows TCP 3306 from your current public IP `/32`.
6. Your network, office firewall, VPN, or ISP is not blocking outbound port 3306.
7. If private-only, connect from a host/VPN inside the VPC; a laptop on the public internet cannot directly reach a private endpoint.

## `Access denied for user`

Likely causes:
- Wrong username/password
- Incorrect database user host/privileges
- Typo or extra spaces in credentials
- Connecting to the wrong DB instance
- Account permissions do not allow the requested operation

Reset credentials through the AWS-supported RDS workflow if needed. Do not paste passwords into logs or tickets.

## `Unknown MySQL server host`

- Copy the endpoint again; do not include `https://`, spaces, or a trailing path.
- Confirm the endpoint belongs to the intended DB and region.
- Check DNS and network configuration.

## Connection works at home but not elsewhere

Your public IP may have changed. Update the inbound security group rule to the current IP. Do not fix this by allowing all IPs.

## `Unknown database 'rds_lab'`

The logical database may not have been created, or you may have connected to a different instance. Check `SHOW DATABASES;`, then create the database if your user has permission.

## `CREATE command denied`

You may be using a user without schema-creation privileges. Use an appropriately privileged administrator to create the database/table, or grant the minimum required privileges.

## Quick tests

From a terminal, you may check DNS resolution with your OS's DNS tools. A TCP port test can help identify network reachability, but a successful port test does not prove database credentials work.

Avoid sharing the full endpoint together with usernames, passwords, account IDs, or other sensitive configuration in public issue trackers.
