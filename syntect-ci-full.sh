#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail -o xtrace

cargo clippy --all-targets --all-features

RUSTDOCFLAGS='--deny warnings' cargo doc --no-deps --document-private-items --all-features

cargo run --example synhtml --no-default-features --features html,default-syntaxes,default-themes,regex-onig -- examples/synhtml.rs

cargo test --all-targets --all-features

cargo test --doc
