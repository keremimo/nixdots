{ ... }:
{
  services.logind.settings.Login = {
    lidSwitchExternalPower = "ignore";
    lidSwitchDocked = "ignore";
  };
}
