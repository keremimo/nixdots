{ pkgs, ... }:
{
  security.pam.services = {
    greetd.enableGnomeKeyring = true;
    greetd-password.enableGnomeKeyring = true;
    login.enableGnomeKeyring = true;
  };

  services.dbus.packages = [
    pkgs.gnome-keyring
    pkgs.gcr
  ];

  services.xserver.displayManager.sessionCommands = ''
    eval $(gnome-keyring-daemon --start --daemonize --components=pkcs11,secrets)
  '';
}
