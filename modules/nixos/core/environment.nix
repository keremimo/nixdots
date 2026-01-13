{ ... }:
{
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.variables = {
    EDITOR = "nvim";
    # WLR_EVDI_RENDER_DEVICE can be set here when an external GPU is in use.
  };
}
