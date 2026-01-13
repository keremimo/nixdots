{ config
, pkgs
, inputs
, ...
}:
{
  imports = [
    ./modules/home/core
    ./modules/home/desktop
    ./modules/home/programs/shells.nix
    ./modules/home/programs/dev-tools.nix
  ];
}
