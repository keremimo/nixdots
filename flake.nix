{
  description = "Victus";
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    ghostty.url = "github:ghostty-org/ghostty";
    nixvim.url = "github:Keremimo/nixvim";
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs
    , catppuccin
    , home-manager
    , ghostty
    , unstable
    , nixvim
    , niri
    , stylix
    , ...
    }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      unstablePkgs = import unstable { system = "x86_64-linux"; };
    in
    {
      home-manager.backupFileExtension = "backup";
      nixpkgs.overlays = [
        niri.overlays.niri
      ];
      nixosConfigurations.VictimusAMD = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./devices/victus/default.nix
          ./devices/victus/victus-hardware.nix
          ./devices/victus/nvidia-disable.nix
          nixvim.nixosModules.nixvim
          {
            nixpkgs.overlays = [
              (final: prev: {
                ghostty = unstablePkgs.ghostty;
              })
            ];
          }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.kerem = {
              imports = [
                ./home.nix
                catppuccin.homeManagerModules.catppuccin
                niri.homeModules.niri
                stylix.homeManagerModules.stylix
                niri.homeModules.stylix
                inputs.spicetify-nix.homeManagerModules.default
                ./modules/spicetify.nix
              ];
            };
          }
          {
            environment.systemPackages = [
              ghostty
            ];
          }
        ];
      };
      nixosConfigurations.VictimusGPU = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./configuration.nix
          ./devices/victus/default.nix
          ./devices/victus/victus-hardware.nix
          ./devices/victus/nvidia-enable.nix
          nixvim.nixosModules.nixvim
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.kerem = {
              imports = [
                ./home.nix
                catppuccin.homeManagerModules.catppuccin
                niri.homeModules.niri
                stylix.homeManagerModules.stylix
                niri.homeModules.stylix
                inputs.spicetify-nix.homeManagerModules.default
                ./modules/spicetify.nix
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
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./devices/t480
          {
            nixpkgs.overlays = [
              (final: prev: {
                ghostty = unstablePkgs.ghostty;
              })
            ];
          }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; inherit unstable; };
            home-manager.backupFileExtension = "backup";
            home-manager.users.kerem = {
              imports = [
                ./home.nix
                ./devices/t480/git-signkey.nix
                ./devices/t480/niri-t480.nix
                catppuccin.homeManagerModules.catppuccin
                nixvim.homeManagerModules.nixvim
                niri.homeModules.niri
                stylix.homeManagerModules.stylix
                niri.homeModules.stylix
                inputs.spicetify-nix.homeManagerModules.default
                ./modules/spicetify.nix
              ];
            };
          }
          {
            environment.systemPackages = [

            ];
          }
        ];
      };
      nixosConfigurations.L14 = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./devices/L14
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.kerem = {
              imports = [
                ./home.nix
                catppuccin.homeManagerModules.catppuccin
                nixvim.homeManagerModules.nixvim
                niri.homeModules.niri
                niri.homeModules.stylix
                stylix.homeManagerModules.stylix
                inputs.spicetify-nix.homeManagerModules.default
                ./modules/spicetify.nix
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
