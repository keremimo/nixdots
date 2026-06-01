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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
    };
  };

  outputs =
    { nixpkgs
    , home-manager
    , niri
    , ...
    }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      baseHomeImports = [
        ./home.nix
      ];

      mkHomeModule = extraImports: {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.users.kerem.imports = baseHomeImports ++ extraImports;
      };

      mkHost =
        { modules ? [ ]
        , homeImports ? [ ]
        }:
        lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
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
        legion = mkHost {
          modules = [
            ./hosts/legion/default.nix
            ./hosts/legion/hardware.nix
          ];
          homeImports = [
            ./hosts/legion/hyprland-overrides.nix
          ];
        };

        desktop = mkHost {
          modules = [
            ./hosts/desktop/default.nix
          ];
          homeImports = [
          ];
        };

        L14 = mkHost {
          modules = [
            ./hosts/L14
          ];
          homeImports = [
          ];
        };

        sci-go = mkHost {
          modules = [
            ./hosts/sci-go
          ];
          homeImports = [
          ];
        };
      };
    };
}
