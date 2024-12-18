{ config
, pkgs
, lib
, ...
}:
{
  programs.niri = {
    settings.outputs = {
      "eDP-1" = {
        position = {
          x = 0;
          y = 0;
        };
        mode = {
          width = 2560;
          height = 1440;
        };
        scale = 1.33;
      };
    };
  };
}
