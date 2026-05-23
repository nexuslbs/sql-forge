#!/bin/bash
set -euo pipefail

echo "##############################################"
echo "################### MYSQL ####################"
echo "##############################################"
export ENV_DB_TYPE=mysql
export DATABASE_URL=mysql://root:root@mysql:3306/sql_forge_test
export SQL_FORGE_DB_TYPE="sqlx::MySql"
cargo clean
sql-forge-with-db

echo "##############################################"
echo "################## POSTGRES ##################"
echo "##############################################"
export ENV_DB_TYPE=postgres
export DATABASE_URL=postgres://postgres:root@pg:5432/sql_forge_test
export SQL_FORGE_DB_TYPE="sqlx::Postgres"
cargo clean
sql-forge-with-db

echo "##############################################"
echo "################### SQLITE ###################"
echo "##############################################"
export ENV_DB_TYPE=sqlite
export DATABASE_URL=sqlite:sql_forge_test.db
export SQL_FORGE_DB_TYPE="sqlx::Sqlite"
cargo clean
sql-forge-with-db
