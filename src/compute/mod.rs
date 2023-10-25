// Copyright 2023-present Space and Time Labs, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

//! High-Level Rust wrapper for the blitzar-sys crate.

mod backend;
pub use backend::{init_backend, init_backend_with_config, BackendConfig};

mod commitments;
pub use commitments::{
    compute_bls12_381_g1_commitments_with_generators, compute_commitments,
    compute_commitments_with_generators, update_commitments,
};

#[cfg(test)]
mod commitments_tests;

mod generators;
pub use generators::{get_generators, get_one_commit};

#[cfg(test)]
mod generators_tests;
