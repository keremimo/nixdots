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
  ];

  home.username = "kerem";
  home.homeDirectory = "/home/kerem";

  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    newSession = true;
    escapeTime = 0;
    # Force tmux to use /tmp for sockets (WSL2 compat)
    secureSocket = false;

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
    ];

    programs.tmate = {
      enable = true;
    };

    extraConfig = ''
      # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      # Mouse works as expected
      set-option -g mouse on
      # easy-to-remember split pane commands
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';
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
