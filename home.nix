{ config
, pkgs
, inputs
, ...
}: {

  imports = [
    ./modules/fish.nix
    ./modules/starship.nix
    ./modules/waybar.nix
    ./modules/gnome.nix
    ./modules/tmux.nix
  ];

  home.username = "kerem";
  home.homeDirectory = "/home/kerem";

  home.packages = with pkgs; [
    imagemagick
    tesseract
    fastfetch
    yazi
    stow
    lolcat
    mako
    swaynotificationcenter

    zip
    xz
    unzip
    p7zip

    ripgrep
    jq
    yq-go
    eza
    fzf

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
    nodejs
    go
    rustup
    lua

    sqlite

    font-manager

    brightnessctl
    banana-cursor
    wl-clipboard

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

  programs.lazygit = {
    enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Kerem Kilic";
        email = "git@keremk.be";
        init = {
          defaultBranch = "main";
        };
      };

    };
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
