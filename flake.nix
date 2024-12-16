{
  description = "Victus";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    ghostty = {
      url = "git+ssh://git@github.com/ghostty-org/ghostty";

      # NOTE: The below 2 lines are only required on nixos-unstable,
      # if you're on stable, they may break your build
      inputs.nixpkgs-stable.follows = "nixpkgs";
      inputs.nixpkgs-unstable.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    catppuccin,
    home-manager,
    ghostty,
    nixvim,
    ...
  }: {
    nixosConfigurations.Victimus = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./devices/victus/default.nix
        ./devices/victus/victus-hardware.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.kerem = {
	  imports = [
	  ./home.nix
	  catppuccin.homeManagerModules.catppuccin
          nixvim.homeManagerModules.nixvim
	  ];
	  };
        }
        {
          environment.systemPackages = [
            ghostty.packages.x86_64-linux.default
          ];
        }
      ];
    };
    nixosConfigurations.ThinkChad = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./devices/t480
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.kerem = {
	  imports = [
	  ./home.nix
          ./devices/t480/git-signkey.nix
	  catppuccin.homeManagerModules.catppuccin
          nixvim.homeManagerModules.nixvim
	  ];
	  };
        }
        {
          environment.systemPackages = [
            ghostty.packages.x86_64-linux.default
          ];
        }
      ];
    };
  };
}
