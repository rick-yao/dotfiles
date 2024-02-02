{
  description = "Home Manager configuration of rick";

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];

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

  outputs = inputs @ {self, nixpkgs, home-manager, rust-overlay, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      username = "rick";
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
        ./home.nix 
        ./overlay/rust.nix
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}

