{ ... }:
{
  nix = {
    extraOptions = ''
      trusted-users = root kerem
    '';
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs.config.allowUnfree = true;
}
