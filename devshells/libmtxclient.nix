{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  packages = [
    (pkgs.rust-bin.stable.latest.default.override {
      extensions = [
        "rust-src"
        "rust-analyzer"
      ];
    })
  ];

  nativeBuildInputs = [
    pkgs.clang-analyzer
    pkgs.clang-tools
    pkgs.cmake
    pkgs.pkg-config
    pkgs.rustPlatform.bindgenHook
  ];

  buildInputs = [
    pkgs.coeurl
    pkgs.curl
    pkgs.gtest
    pkgs.libevent
    pkgs.nlohmann_json
    pkgs.openssl
    pkgs.re2
    pkgs.spdlog
  ];
}
