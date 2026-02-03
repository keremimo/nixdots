{ pkgs, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true;
    cursor = {
      package = pkgs.banana-cursor;
      name = "Banana";
      size = 28;
    };
    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/yx/wallhaven-yxdrex.png";
      sha256 = "sha256-lLpIOKdyH4YaIO1Yw0wxWGhTEPYdSMLzMedoDQ5ko/o=";
    };
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-soft.yaml";
  };
}
