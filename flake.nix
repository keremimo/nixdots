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
    nixvim.url = "github:Keremimo/nixvim";
    niri = {
      url = "github:sodiboo/niri-flake";
    };
    stylix.url = "github:danth/stylix/release-25.11";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
    };
  };

  outputs =
    { nixpkgs
    , home-manager
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
      nixosConfigurations.legion = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./devices/legion/default.nix
          ./devices/legion/hardware.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.kerem = {
              imports = [
                ./home.nix
                niri.homeModules.niri
                stylix.homeModules.stylix
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
      nixosConfigurations.desktop = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./devices/desktop/default.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.kerem = {
              imports = [
                ./home.nix
                stylix.homeModules.stylix
                niri.homeModules.niri
                niri.homeModules.stylix
                ./modules/niri.nix
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
                stylix.homeModules.stylix
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
    };
}
