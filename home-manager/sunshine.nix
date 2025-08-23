{ config, pkgs, ...}:
{
  environment.sessionVariables.WLR_NO_HARDWARE_CURSOR = "1";

  hardware.opengl.enable = true;
  hardware.nvidia = {
    modsetting.enable = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  hardware.uinput.enable = true;

  environment.systemPackages = [ pkgs.sunshine pkgs.ffmpeg-full ];

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

  users.users.delta.extraGroups = [ "input" "video" "render" ];

}
