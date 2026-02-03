{ ... }:
{
  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" ];
    xkb.layout = "us";
    xkb.variant = "";
  };
}
