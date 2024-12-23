{
  description = "Nixvim with config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixvim.url = "github:nix-community/nixvim/nixos-24.11";
  };

  outputs =
    { self
    , nixpkgs
    , nixvim
    }: {
      nixosModules.nixvim-settings = {
        imports = [ nixvim.nixosModules.nixvim ];
      };
      config = import ./settings.nix;
      packages = {
        # Define a standalone package for Neovim with nixvim and additional dependencies
        default = nixpkgs.legacyPackages.x86_64-linux.buildEnv {
          name = "neovim-with-nixvim";
          paths = with nixpkgs.legacyPackages.x86_64-linux; [
            neovim # The Neovim binary
            nixvim.defaultPackage.x86_64-linux # nixvim itself
            nerdfonts-fira-code # Example: a Nerd Font dependency
          ];
        };
      };
    };
}
