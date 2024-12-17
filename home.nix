{ config
, pkgs
, inputs
, ...
}: {

  imports = [
    ./modules/fish.nix
    ./modules/starship.nix
    ./modules/nixvim.nix
  ];

  home.username = "kerem";
  home.homeDirectory = "/home/kerem";
  home.sessionVariables.GTK_THEME = "catppuccin-macchiato-compact-pink-dark";

  catppuccin = {
    enable = true;
    flavor = "mocha";
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
    stow
    lolcat

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
    lua

    sqlite

    font-manager

    brightnessctl
    banana-cursor
    wl-clipboard
    devenv

    vscodium
    foliate
  ];

  programs.direnv = {
    enable = true;
    silent = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Kerem Kilic";
    userEmail = "code@kerem.tech";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
