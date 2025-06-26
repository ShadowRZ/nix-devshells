{
  description = "@ShadowRZ's Nix Dev Shells";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };
    systems = {
      url = "github:nix-systems/default";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      systems,
      rust-overlay,
      ...
    }:
    {
      devShells = nixpkgs.lib.attrsets.genAttrs (import systems) (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              rust-overlay.overlays.default
            ];
          };
        in
        import ./. { inherit pkgs; }
      );
    };
}
