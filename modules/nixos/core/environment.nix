{ ... }:
{
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.variables = {
    EDITOR = "nvim";
    # OBS_VKCAPTURE is disabled globally - enable per-app when needed for OBS capture
    # OBS_VKCAPTURE=1;
    # WLR_EVDI_RENDER_DEVICE can be set here when an external GPU is in use.
  };
}
