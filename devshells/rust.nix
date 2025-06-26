{
  pkgs ? import <nixpkgs> {
    overlays = [
      (builtins.fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz")
    ];
  },
}:

let
  mkRustDevShell =
    rust-package:
    pkgs.mkShell {
      packages = with pkgs; [
        openssl
        pkg-config
        rust-package
      ];

      RUST_SRC_PATH = "${rust-package}/lib/rustlib/src/rust/library";
    };
in

mkRustDevShell (
  pkgs.rust-bin.stable.latest.default.override {
    extensions = [ "rust-src" ];
  }
)
// builtins.mapAttrs (
  _version: toolchain:
  toolchain.default.override {
    extensions = [ "rust-src" ];
  }
) pkgs.rust-bin.stable
