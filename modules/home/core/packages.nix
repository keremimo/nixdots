{ pkgs, ... }:
{
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
    lm_sensors
    ethtool
    pciutils
    usbutils

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
}
