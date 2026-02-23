{pkgs, ...}: {
  nix = {
    package = pkgs.nix;
    settings = {
      substituters = [
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://yazi.cachix.org"
        "https://cache.nixos.org"
      ];

      trusted-public-keys = [
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];

      experimental-features = ["nix-command" "flakes"];

      auto-optimise-store = pkgs.stdenv.isLinux;
    };
  };
}
