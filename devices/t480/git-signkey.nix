{ config, lib, pkgs, ... }:

{
  programs.git.signing = {
    key = "70D73D1976D6B1BA";
    signByDefault = true;
  };
}
