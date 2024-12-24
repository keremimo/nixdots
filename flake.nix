{
  description = "Victus";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    ghostty.url = "git+ssh://git@github.com/ghostty-org/ghostty";
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
    , nixvim
    , niri
    , stylix
    , ...
    }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
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
          niri.nixosModules.niri
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
              ghostty.packages.x86_64-linux.default

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
                nixvim.homeManagerModules.nixvim
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
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
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
              ghostty.packages.x86_64-linux.default
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
