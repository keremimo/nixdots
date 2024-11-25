{config, pkgs, ...}: {
  programs.fish = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    enableTransience = true;
  };

  programs.zoxide.enable = true;
  programs.thefuck.enable = true;
}
