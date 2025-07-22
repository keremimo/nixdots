{ pkgs, inputs, ... }:

{
  # https://github.com/nix-community/home-manager/pull/2408
  environment.pathsToLink = [ "/share/fish" ];

  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  # Since we're using fish as our shell
  programs.fish.enable = true;

  users.users.kerem = {
    isNormalUser = true;
    home = "/home/kerem";
    extraGroups = [ "docker" "lxd" "wheel" ];
    shell = pkgs.fish;
    hashedPassword = "$6$uPUP7G/ewM3IOJuR$BUenC48i2WLXOdbf2AwC5Vyxl1N7lGiNEb/vCwOdYPfaLrIRH8elL/5o4vbJ.7vgjxGn1fr.uZWVNuIrPaqlo1";
  };
}
