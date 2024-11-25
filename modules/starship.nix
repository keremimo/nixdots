{
  config,
  pkgs,
  ...
}: {
  programs.starship = {
    enable = true;
    settings = {
      palette = "catppuccin_mocha";
    };
  };
}
