{ lib, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "kitty tmux"; 
      menu = "wofi --show run";
      bars = [{
         command = "waybar";
#        fonts.size = 12.0;
#        position = "bottom";
      }];
      startup = [
        {command = "swaybg -i ~/.config/backgrounds/landscape01.jpg"}
        # Launch Firefox on start
        {command = "brave";}
      ];
      keybindings = lib.mkOptionDefault {
        "Mod4+Shift+XF86AudioMute" =  "exec 'bash /home/delta/.config/scripts/audio_switch.sh'"; # switch audio source
        "XF86AudioRaiseVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ +5%'"; # raise volume
        "XF86AudioLowerVolume" = "exec 'pactl set-sink-volume @DEFAULT_SINK@ -5%'"; # lower volume
        "XF86AudioMute"= "exec 'pactl set-sink-mute @DEFAULT_SINK@ toggle'"; # mute volume
        "XF86AudioPlay" = "exec 'playerctl play-pause'"; # play pause music
        "XF86AudioPause" = "exec 'playerctl play-pause'"; # play pause music
        "XF86AudioNext" = "exec 'playerctl next'"; # next song
        "XF86AudioPrev" = "exec 'playerctl previous'"; # previous song
      };
    };
  };
}
