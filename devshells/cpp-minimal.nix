{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  packages = [
    # clangd, etc.
    pkgs.clang-tools
  ];
}
