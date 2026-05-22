#!/bin/bash
set -euo pipefail

cargo fmt --all -- --check
cargo check --tests
cargo clippy --tests
cargo sqlx prepare -- --tests
cargo test