{
  pkgs,
  lib,
  inputs,
  ...
}:

let
  mapping = "delta:3mQY9hoHlogwsTRFStVuUB3vaRaNSp5+Ms970cpqHrKZGBlm0IwKbiXVZzlM0WkjS4pttMAcsgf8mM7YDJIA/w==,ZEQD+jq1zxeUZUfPfWDp4PfEAjuOrXWiRdXt27y4zV/JyJ1CYGoR6+sxkR+oXY7VG8oKZi8KVeR/uZkTc+grfw==,es256,+presence";

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

    home-manager.users.delta =
      { pkgs, ... }:
      {
        xdg.configFile."Yubico/u2f_keys".text = mapping;
      };
  };
}
