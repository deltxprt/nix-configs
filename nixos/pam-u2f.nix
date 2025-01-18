{
  pkgs,
  lib,
  inputs,
  ...
}:

let
  ykDisconnect = pkgs.writeShellScript "yk-disconnect.sh" ''
    ${pkgs.procps}/bin/pkill -USR1 swayidle
  '';
in
{
  config = {
    security.pam = {
      u2f = {
        enable = true;
      };
    };
    
    services.udev.extraRules = ''
      ACTION=="remove", SUBSYSTEM=="usb", ENV{PRODUCT}=="1050/406/543", RUN+="${ykDisconnect} '%E{SEQNUM}'"
    '';

  };
}
