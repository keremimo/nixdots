{
  config,
  pkgs,
  ...
}: {
  programs.fish = {
    enable = true;
  };

  programs.zoxide.enable = true;
  programs.thefuck.enable = true;
}
