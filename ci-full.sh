#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail -o xtrace

cargo fmt -- --check

tests/scripts/license-checks.sh

RUSTDOCFLAGS='--deny warnings' cargo doc --locked --no-deps --document-private-items --all-features

cargo clippy --all-targets --all-features

cargo check --no-default-features --features minimal-application

cargo build

cargo test --doc

cargo test

PATH="./target/debug:$PATH" tests/syntax-tests/test_custom_assets.sh

PATH="./target/debug:$PATH" assets/create.sh

PATH="./target/debug:$PATH" tests/syntax-tests/regression_test.sh
