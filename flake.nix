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
  };

  outputs = inputs @ {
    nixpkgs,
    catppuccin,
    home-manager,
    ghostty,
    ...
  }: {
    nixosConfigurations.Victimus = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./devices/victus.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.kerem = {
	  imports = [
	  ./home.nix
	  catppuccin.homeManagerModules.catppuccin
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
	  catppuccin.homeManagerModules.catppuccin
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
