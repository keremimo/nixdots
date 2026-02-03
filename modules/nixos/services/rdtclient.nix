{ config, pkgs, ... }:

let
  qbUid = "1000";
  hasMediaGroup = config.users.groups ? media;
  downloadGroup = if hasMediaGroup then "media" else "users";
  qbGid =
    if hasMediaGroup then builtins.toString config.users.groups.media.gid else qbUid;
  downloadCategories = [ "lidarr" "sonarr" "radarr" ];
  downloadCategoryRules =
    builtins.map (category: "d /data/downloads/${category} 2775 ${qbUid} ${downloadGroup} -")
      downloadCategories;
in
{
  virtualisation.podman.enable = true;
  virtualisation.oci-containers.backend = "podman";

  # Web UI + qBittorrent API port
  networking.firewall.allowedTCPPorts = [ 6500 ];

  # Persistent data + downloads staging (pick paths you actually use)
  systemd.tmpfiles.rules =
    [
      "d /data/rdtclient 0755 root root -"
      "d /data/downloads 2775 ${qbUid} ${downloadGroup} -"
    ]
    ++ downloadCategoryRules;

  virtualisation.oci-containers.containers.rdtclient = {
    image = "rogerfar/rdtclient:latest";
    autoStart = true;

    ports = [ "6500:6500" ];

    volumes = [
      "/data/rdtclient:/data/db"
      "/data/downloads:/data/downloads"
    ];

    environment = {
      # optional but commonly used; matches TorBox guide style
      PUID = qbUid;
      PGID = qbGid;
      TZ = "Europe/Brussels";
    };
  };
}
