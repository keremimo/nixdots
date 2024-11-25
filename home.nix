{
  config,
  pkgs,
  ...
}: {
  home.username = "kerem";
  home.homeDirectory = "/home/kerem";
  home.sessionVariables.GTK_THEME = "catppuccin-macchiato-compact-pink-dark";

  imports = [
    ./modules/fish.nix
    ./modules/starship.nix
  ];

  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-macchiato-compact-pink-dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["pink"];
        size = "compact";
        tweaks = ["rimless" "black"];
        variant = "macchiato";
      };
    };
    iconTheme = {
      name = "colloid-icon-theme";
      package = pkgs.colloid-icon-theme;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "Banana";
    package = pkgs.banana-cursor;
    size = 24;
  };

  home.packages = with pkgs; [
    fastfetch
    yazi

    zip
    xz
    unzip
    p7zip

    ripgrep
    jq
    yq-go
    eza
    fzf
    thefuck

    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    glow

    btop
    iotop
    iftop
    powertop

    sysstat
    lm_sensors #sensors
    ethtool
    pciutils #lspci
    usbutils #lsusb

    vesktop
    nodejs_23
    go
    rustup
    gcc
    lua
    nerdfonts

    font-manager
    jetbrains-mono

    brightnessctl
    banana-cursor
    wl-clipboard
    catppuccin-cursors
    notion-app-enhanced
  ];

  programs.git = {
    enable = true;
    userName = "Kerem Kilic";
    userEmail = "nyaa@live.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
