{ config
, pkgs
, inputs
, ...
}: {

  imports = [
    ./modules/fish.nix
    ./modules/starship.nix
    ./modules/niri.nix
    ./modules/waybar.nix
    ./modules/gnome.nix
    ./modules/tmux.nix
  ];

  home.username = "kerem";
  home.homeDirectory = "/home/kerem";

  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  home.packages = with pkgs; [
    fastfetch
    yazi
    stow
    lolcat
    mako
    swww
    swaynotificationcenter
    stremio

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

    aerc
    senpai
    ulauncher

    jetbrains-toolbox
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
