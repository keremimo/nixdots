{ pkgs, ... }:
{
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
  };
}
