{
  pkgs ? import <nixpkgs> {
    overlays = [
      (builtins.fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz")
    ];
  },
}:

pkgs.lib.filesystem.packagesFromDirectoryRecursive {
  callPackage = pkgs.callPackage;
  directory = ./devshells;
}
