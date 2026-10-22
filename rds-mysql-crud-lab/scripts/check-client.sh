#!/usr/bin/env bash
set -euo pipefail

if command -v mysql >/dev/null 2>&1; then
  echo "MySQL-compatible client found:"
  mysql --version
elif command -v mariadb >/dev/null 2>&1; then
  echo "MariaDB client found:"
  mariadb --version
else
  echo "No MySQL/MariaDB command-line client found. Install the client using the README instructions." >&2
  exit 1
fi

if [[ -z "${RDS_ENDPOINT:-}" ]]; then
  echo "RDS_ENDPOINT is not set. Example: export RDS_ENDPOINT='mydb.xxxxx.ap-south-1.rds.amazonaws.com'" >&2
  exit 2
fi

RDS_PORT="${RDS_PORT:-3306}"
echo "Endpoint: ${RDS_ENDPOINT}"
echo "Port: ${RDS_PORT}"
echo "DNS lookup:"
getent hosts "$RDS_ENDPOINT" || true
