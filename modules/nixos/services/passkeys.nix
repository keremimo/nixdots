{ pkgs, ... }:
{
  services.pcscd.enable = true;

  services.udev.packages = [
    pkgs.yubikey-personalization
    pkgs.libu2f-host
    pkgs.pam_u2f
  ];

  environment.systemPackages = with pkgs; [
    ccid
    libfido2
    yubico-piv-tool
    yubikey-manager
    yubikey-personalization
  ];
}
