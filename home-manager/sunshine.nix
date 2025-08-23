{ config, pkgs, ...}:
{

  systemd.user.services.sunshine = {
    description = "Sunshine Host";
    after = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      Environment = "XDG_SESSION_TYPE=wayland";
      ExecStart = "${pkgs.sunshine}/bin/sunshine";
      Restart = "on-failure";
    };
  };


}
