{
  pkgs,
  rust-overlay,
  ...
}: {
  nixpkgs.overlays = [rust-overlay.overlays.default];
  home.packages = with pkgs; [
    (pkgs.rust-bin.stable.latest.default.override {
      extensions = ["rust-src"];
    })
  ];
}
