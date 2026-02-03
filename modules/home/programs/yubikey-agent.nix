{ pkgs, ... }:
let
  socketName = "yubikey-agent.sock";
in {
  home.packages = [
    pkgs.yubikey-agent
  ];

  systemd.user.services.yubikey-agent = {
    Unit = {
      Description = "YubiKey hardware SSH agent";
      After = [ "sockets.target" ];
    };
    Service = {
      ExecStart = "${pkgs.yubikey-agent}/bin/yubikey-agent -l %t/${socketName}";
      Restart = "on-failure";
      RestartSec = 2;
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

  home.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/${socketName}";
}
