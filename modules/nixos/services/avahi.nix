{ ... }:
{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true; # UDP 5353
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };
}
