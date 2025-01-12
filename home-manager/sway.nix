{ ... }:
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
    };
    extraConfig = ''
      bindsym XF86AudioRaiseVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ +5%'
      bindsym XF86AudioLowerVolume exec 'pactl set-sink-volume @DEFAULT_SINK@ -5%'
      bindsym XF86AudioMute exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'
      bindsym $mod+t exec ~/.config/scripts/audio_switch.sh
    '';
  };
}
