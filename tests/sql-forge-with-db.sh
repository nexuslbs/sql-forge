#!/bin/bash
set -euo pipefail

export SQLX_OFFLINE_DIR="$ENV_DIR/.sqlx"

cargo fmt --all -- --check
cargo expand --test tests > "$ENV_DIR/tests_expanded.rs"
cargo check --tests
cargo clippy --tests
cargo sqlx prepare -- --tests
cargo test
