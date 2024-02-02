{
  description = "Home Manager configuration of rick";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];

    # substituters = [
    #   "https://mirrors.ustc.edu.cn/nix-channels/store"
    #   "https://cache.nixos.org"
    # ];

    auto-optimise-store = true;
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , home-manager
    , rust-overlay
    , ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      username = "rick";
    in
    {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix
          ./overlay/rust.nix
        ];

        extraSpecialArgs = { inherit rust-overlay; };
      };

      formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
    };
}
