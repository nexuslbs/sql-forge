#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"

FILES=(
    "tests/tests.rs"
    "src/lib.rs"
    "crates/sql-forge-macro/src/lib.rs"
    "crates/sql-forge-macro/Cargo.toml"
    "crates/sql-forge-trait/src/lib.rs"
    "crates/sql-forge-trait/Cargo.toml"
)

for file in "${FILES[@]}"; do
    sha256sum "$REPO_ROOT/$file" | awk '{ print $1 }'
done