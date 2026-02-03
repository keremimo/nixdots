{ pkgs, ... }:
{
  programs.fish.enable = true;

  users.users.kerem = {
    isNormalUser = true;
    description = "Kerem";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = [ ];
  };
}
