{
  pkgs,
  overlays,
  ...
}: {
  nixpkgs.overlays = overlays;
  home.packages = with pkgs; [
    (pkgs.rust-bin.stable.latest.default.override {
      extensions = ["rust-src"];
    })
  ];
}
