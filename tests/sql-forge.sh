#!/bin/bash
set -euo pipefail

if [ "${1:-}" == '--build' ]; then
  # Useful when the script fails due to Cargo.lock version mismatch
  env-mysql cargo build
fi

echo "##############################################"
echo "############ VERIFY DEPENDENCIES #############"
echo "##############################################"
bash /app/tests/verify-versions.sh

echo "##############################################"
echo "################### MYSQL ####################"
echo "##############################################"
env-mysql sql-forge-with-db

echo "##############################################"
echo "################## POSTGRES ##################"
echo "##############################################"
env-postgres sql-forge-with-db

echo "##############################################"
echo "################### SQLITE ###################"
echo "##############################################"
env-sqlite sql-forge-with-db
