#!/bin/bash
set -euo pipefail

echo "##############################################"
echo "############ VERIFY README VERSION ###########"
echo "##############################################"
CARGOTOML_VERSION=$(awk '/^\[dependencies\]/ { in_deps = 1; next } /^\[/ { in_deps = 0 } in_deps && /^sqlx = / { gsub(/.*version = "/, ""); gsub(/".*/, ""); print; exit }' Cargo.toml)
README_VERSION=$(grep '^sqlx = { version = ' README.md | head -1 | sed 's/.*version = "\([^"]*\)".*/\1/')
if [ "$CARGOTOML_VERSION" != "$README_VERSION" ]; then
  echo "ERROR: README.md sqlx version ($README_VERSION) does not match Cargo.toml sqlx version ($CARGOTOML_VERSION)"
  exit 1
fi

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
