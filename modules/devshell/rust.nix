{
  perSystem =
    { pkgs, ... }:
    {
      devShells =
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
        {
          rust =
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
            ) pkgs.rust-bin.stable;
          rust-nightly =
            mkRustDevShell (
              pkgs.rust-bin.selectLatestNightlyWith (
                toolchain:
                toolchain.default.override {
                  extensions = [ "rust-src" ];
                }
              )
            )
            // builtins.mapAttrs (
              _version: toolchain:
              toolchain.default.override {
                extensions = [ "rust-src" ];
              }
            ) pkgs.rust-bin.nightly;
        };
    };
}
