{ pkgs, ... }:
{
  imports = [
    ./dms.nix
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  services.displayManager.defaultSession = "niri";
}
