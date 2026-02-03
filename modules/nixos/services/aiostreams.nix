{ config, pkgs, ... }:

{
  # Use Podman as the container backend (rootless-friendly)
  virtualisation.podman.enable = true;

  # NixOS module that manages containers via systemd
  virtualisation.oci-containers.backend = "podman";

  # Open the AIOStreams port on your LAN
  networking.firewall.allowedTCPPorts = [ 3000 ];

  # Persist AIOStreams state
  systemd.tmpfiles.rules = [
    "d /data/aiostreams 0755 root root -"
  ];

  virtualisation.oci-containers.containers.aiostreams = {
    image = "ghcr.io/viren070/aiostreams:latest";
    autoStart = true;

    extraOptions = [ "--network=host" ];

    ports = [ "3000:3000" ];

    volumes = [
      "/data/aiostreams:/app/data"
    ];

    environment = {
      # Generate this once with: openssl rand -hex 32
      # (64 hex characters)
      SECRET_KEY = "3832161375b0504323f03a4f7dcdda7795097ea3203b5152ff666eed44e13d3f";
      BASE_URL   = "http://localhost:3000";

      # Optional: override listening port (default is 3000)
      # PORT = "3000";
    };
  };
}
