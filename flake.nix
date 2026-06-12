{
  description = "Nix shell for developing sxt-proof-of-sql";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    rust-overlay,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        overlays = [(import rust-overlay)];
        pkgs = import nixpkgs {
          inherit system overlays;
          config.allowUnfree = true;
        };
      in {
        devShells = rec {
          default = gpu;
          cpu = with pkgs;
            (mkShell.override {stdenv = gcc13Stdenv;}) {
              buildInputs = [
                (rust-bin.fromRustupToolchainFile ./rust-toolchain.toml)
                # additional .cargo config dependencies
                clang
                lld
              ];

              BLITZAR_BACKEND = "cpu";
            };
          gpu = with pkgs;
            (mkShell.override {stdenv = gcc13Stdenv;}) {
              buildInputs = [
                (rust-bin.fromRustupToolchainFile ./rust-toolchain.toml)
                cudatoolkit
                # additional .cargo config dependencies
                clang
                lld
              ];

              BLITZAR_BACKEND = "gpu";

              LD_LIBRARY_PATH = lib.makeLibraryPath [
                "/usr/lib/wsl"
                pkgs.linuxPackages.nvidia_x11
              ];
            };
        };
      }
    );
}
