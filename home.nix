{ config
, pkgs
, inputs
, ...
}:
{
  imports = [
    ./modules/home/core
    ./modules/home/desktop
    ./modules/home/programs
    ./scripts/default.nix
  ];
}
