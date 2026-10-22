# RDS connection flow

```text
[Your computer]
 MySQL Workbench / mysql CLI
          |
          | DNS lookup + TCP 3306
          v
[Network path / VPC routing]
          |
          v
[RDS security group]
 Allow TCP 3306 from your public IP /32
          |
          v
[Amazon RDS for MySQL]
 Endpoint -> Engine -> Database -> Tables
```

For production, prefer this arrangement:

```text
[Internet users]
       |
       v
[Load balancer / application]
       |
       | Application security group allowed
       v
[Private RDS subnet]
       |
       v
[Database tables]
```

The application server connects to RDS privately. Do not expose the database port to all internet addresses.
