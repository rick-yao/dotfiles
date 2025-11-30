{pkgs, ...}: {
  nix = {
    package = pkgs.lixPackageSets.stable.lix;

    settings = {
      substituters = [
        "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        "https://yazi.cachix.org"
        "https://cache.nixos.org"
        "https://cache.lix.systems"
      ];

      trusted-public-keys = [
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
      ];

      experimental-features = ["nix-command" "flakes"];

      auto-optimise-store = pkgs.stdenv.isLinux;
    };
  };
}
