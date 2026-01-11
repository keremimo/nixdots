# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config
, pkgs
, ...
}: {

  nix.extraOptions = ''
    trusted-users = root kerem
  '';

  imports = [
    # ./modules/qemu.nix # No good for now
  ];

  environment.sessionVariables = { NIXOS_OZONE_WL = "1"; };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  security.pam.services = {
    greetd.enableGnomeKeyring = true;
    greetd-password.enableGnomeKeyring = true;
    login.enableGnomeKeyring = true;
  };
  services.dbus.packages = [ pkgs.gnome-keyring pkgs.gcr ];

  services.xserver.displayManager.sessionCommands = ''
    eval $(gnome-keyring-daemon --start --daemonize --components=ssh,secrets)
    export SSH_AUTH_SOCK
  '';

  services.logind.settings.Login = {
    lidSwitchExternalPower = "ignore";
    lidSwitchDocked = "ignore";
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  services.power-profiles-daemon.enable = false;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  programs.xwayland.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    gamescopeSession = {
      enable = true;
    };
  };

  programs.gnupg = {
    agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  services.displayManager = {
    gdm = {
      enable = true;
      wayland = true;
    };
  };

  services.desktopManager.gnome.enable = true;
  services.displayManager = {
    autoLogin = {
      enable = true;
      user = "kerem";
    };
  };

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Brussels";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" ];
  };

  programs.fish.enable = true;

  users.users.kerem.shell = pkgs.fish;

  programs.hyprland.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # services.xserver.libinput.enable = true;
  users.users.kerem = {
    isNormalUser = true;
    description = "Kerem";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  environment.gnome.excludePackages = with pkgs; [
    orca
    evince
    geary
    gnome-disk-utility
    gnome-backgrounds
    gnome-tour # GNOME Shell detects the .desktop file on first log-in.
    gnome-user-docs
    baobab
    epiphany
    gnome-text-editor
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-console
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-weather
    gnome-connections
    simple-scan
    snapshot
    totem
    yelp
    gnome-software
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    lact
    qmk
    google-chrome
    blueman
    neovim
    xwayland-satellite
    xwayland-run
    ghostty
    wl-clipboard
    gnumake
    git
    wget
    curl
    hyprpaper
    hyprnotify
    hyprcursor
    fuzzel
    kitty
    grim
    slurp
    waybar
    hyprlock
    pavucontrol
    networkmanagerapplet
    glibc
    glib
    zlib
    libclang
    openssl
    pkg-config
    gcc
    sqlite
    xfce.thunar
    gnome-tweaks
  ];
  environment.variables.EDITOR = "nvim";
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
  };

  environment.variables = {
    # WLR_EVDI_RENDER_DEVICE = "/dev/dri/card1";
  };

  system.stateVersion = "24.11";
}
