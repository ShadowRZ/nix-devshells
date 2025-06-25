{ inputs, ... }:
{
  perSystem =
    { system, ... }:
    {
      # Instance a global Nixpkgs
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          inputs.rust-overlay.overlays.default
        ];
      };
    };
}
