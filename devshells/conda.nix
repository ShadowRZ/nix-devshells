{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  packages = [
    (pkgs.conda.override {
      extraPkgs = with pkgs; [
        xorg.libX11
        xorg.libXau
        xorg.libXi
        xorg.libXrender
        xorg.libXext
        dbus
        fontconfig
        freetype
        wayland
        libxkbcommon
        libGL
        glib.out
      ];
    })
  ];
  shellHook = ''
    exec conda-shell
  '';
}
