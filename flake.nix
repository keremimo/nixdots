{
  description = "Kerem's Nixdots";
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
    };
    nixvim = {
      url = "github:keremimo/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs
    , home-manager
    , nixvim
    , ...
    }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      baseHomeImports = [
        ./home.nix
        nixvim.homeModules.default
      ];

      mkHomeModule = extraImports: {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
        home-manager.users.kerem.imports = baseHomeImports ++ extraImports;
      };

      mkHost =
        { modules ? [ ]
        , homeImports ? [ ]
        }:
        lib.nixosSystem {
          inherit system;
          modules =
            [
              ./configuration.nix
              home-manager.nixosModules.home-manager
              (mkHomeModule homeImports)
            ]
            ++ modules;
        };
    in
    {
      nixosConfigurations = {
        desktop = mkHost {
          modules = [
            ./hosts/desktop/default.nix
            ./modules/nixos/desktop/niri.nix
          ];
          homeImports = [
            ./modules/home/desktop/niri.nix
          ];
        };

        legion = mkHost {
          modules = [
            ./hosts/legion
            ./modules/nixos/desktop/hyprland.nix
          ];
          homeImports = [
            ./modules/home/desktop/hyprland.nix
            ./hosts/legion/hyprland-overrides.nix
          ];
        };

        L14 = mkHost {
          modules = [
            ./hosts/L14
            ./modules/nixos/desktop/niri.nix
          ];
          homeImports = [
            ./modules/home/desktop/niri.nix
          ];
        };

      };
    };
}
