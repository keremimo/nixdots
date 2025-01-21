{ config, pkgs, inputs, ... }:
{
  imports = [
    ./modules/fish.nix
    ./modules/starship.nix
    ./modules/spicetify.nix
  ];
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
