{ lib, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "kitty"; 
      menu = "wofi --show run";
      bars = [{
         command = "waybar";
#        fonts.size = 12.0;
#        position = "bottom";
      }];
      startup = [
        # Launch Firefox on start
        {command = "brave";}
      ];
      keybindings = lib.mkOptionDefault {
        "Shift+XF86AudioMute" =  "exec ./scripts/audio_switch.sh";
        "XF86AudioRaiseVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ +5%'";
        "XF86AudioLowerVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ -5%'";
        "XF86AudioMute"= "exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'";
      };
    };
  };
}
