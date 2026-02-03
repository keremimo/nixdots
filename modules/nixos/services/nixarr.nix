{ ... }:
{
  nixarr = {
    enable = true;
    jellyfin.enable = true;

    lidarr = {
      enable = true;
    };
    sonarr = {
      enable = true;
    };
    prowlarr = {
      enable = true;
    };
    # Nixarr defaults to keeping its state under /data/.state/nixarr/*
    # and it can also create/manage library dirs/users/permissions.
  };

  # If you want Jellyfin reachable on your LAN:
  networking.firewall.allowedTCPPorts = [ 8096 ];
}
