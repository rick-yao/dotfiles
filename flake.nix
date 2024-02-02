{
  description = "Nix for macOS configuration";
  
  outputs = inputs @{self, nixpkgs, darwin, home-manager, ...}: let 
   
    overlays = [
     inputs.rust-overlay.overlays.default
    ];
    
    mkSystem = import ./lib/mksystem.nix {
      inherit overlays nixpkgs inputs;
    };
    in {
    
    # darwinConfigurations."Ricks-MacBook-Air"  = mkSystem "Ricks-MacBook-Air" {
    #   system = "aarch64-darwin";
    #   user   = "rick";
    #   darwin = true;
    # };
    
    homeConfigurations.rick = mkSystem "rick" {
      system = "x86_64-linux";
      user   = "rick";
      linux  = true;
    };
    
     # formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
    
    };
    
  # outputs = inputs @ {
  #   self,
  #   nixpkgs,
  #   darwin,
  #   home-manager,
  #   rust-overlay,
  #   ...
  # }: {
  #   # NOTE: please update the whole "hostname" placeholder string to your own hostname!
  #   # such as darwinConfigurations.mymac = darwin.lib.darwinSystem {
  #   darwinConfigurations."Ricks-MacBook-Air" = darwin.lib.darwinSystem {
  #     system = "aarch64-darwin"; # change this to "aarch64-darwin" if you are using Apple Silicon
  #     modules = [
  #       ./darwin/nix-core.nix
  #       ./darwin/system.nix
  #       ./darwin/apps.nix
  #       ./darwin/host-users.nix
  #
  #       # home manager
  #       home-manager.darwinModules.home-manager
  #       {
  #         home-manager.useGlobalPkgs = true;
  #         home-manager.useUserPackages = true;
  #
  #         home-manager.extraSpecialArgs = inputs;
  #
  #         # NOTE: replace "yourusername" with your own username!
  #         home-manager.users.rick = import ./home.nix;
  #       }
  #
  #       ({pkgs, ...}: {
  #         nixpkgs.overlays = [rust-overlay.overlays.default];
  #         environment.systemPackages = [
  #           (pkgs.rust-bin.stable.latest.default.override {
  #             extensions = ["rust-src"];
  #           })
  #         ];
  #       })
  #     ];
  #   };
  #
  #   # nix codee formmater
  #   formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
  # };
  
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

    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    rust-overlay.url = "github:oxalica/rust-overlay";
  };
}
