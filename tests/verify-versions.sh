#!/bin/bash
set -euo pipefail

WORKSPACE_VERSION=$(awk '$0 == "[workspace.package]" { in_ws = 1; next } /^\[/ { in_ws = 0 } in_ws && /^version = / { gsub(/^version = "/, ""); gsub(/"$/, ""); print; exit }' Cargo.toml)
MACRO_VERSION=$(awk '$0 == "[workspace.dependencies]" { in_wsd = 1; next } /^\[/ { in_wsd = 0 } in_wsd && /^sql-forge-macro = / { gsub(/.*version = "/, ""); gsub(/".*/, ""); print; exit }' Cargo.toml)
if [ "$WORKSPACE_VERSION" != "$MACRO_VERSION" ]; then
  echo "ERROR: Cargo.toml workspace version ($WORKSPACE_VERSION) does not match sql-forge-macro version ($MACRO_VERSION) in [workspace.dependencies]"
  exit 1
fi

LOCK_VERSION=$(awk '/^name = "sql-forge"$/ { found = 1; next } found && /^version = / { gsub(/^version = "/, ""); gsub(/"$/, ""); print; exit }' Cargo.lock)
if [ "$WORKSPACE_VERSION" != "$LOCK_VERSION" ]; then
  echo "ERROR: Cargo.toml workspace version ($WORKSPACE_VERSION) does not match Cargo.lock sql-forge version ($LOCK_VERSION)"
  exit 1
fi

README_SQLFORGE_VERSION=$(grep '^sql-forge = "' README.md | head -1 | sed 's/.*"\([^"]*\)".*/\1/')
if [ "$WORKSPACE_VERSION" != "$README_SQLFORGE_VERSION" ]; then
  echo "ERROR: README.md sql-forge version ($README_SQLFORGE_VERSION) does not match Cargo.toml workspace version ($WORKSPACE_VERSION)"
  exit 1
fi

CARGOTOML_SQLX_VERSION=$(awk '/^\[dependencies\]/ { in_deps = 1; next } /^\[/ { in_deps = 0 } in_deps && /^sqlx = / { gsub(/.*version = "/, ""); gsub(/".*/, ""); print; exit }' Cargo.toml)
README_SQLX_VERSION=$(grep '^sqlx = { version = ' README.md | head -1 | sed 's/.*version = "\([^"]*\)".*/\1/')
if [ "$CARGOTOML_SQLX_VERSION" != "$README_SQLX_VERSION" ]; then
  echo "ERROR: README.md sqlx version ($README_SQLX_VERSION) does not match Cargo.toml sqlx version ($CARGOTOML_SQLX_VERSION)"
  exit 1
fi

echo "All version checks passed."
