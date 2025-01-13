{ lib, ... }:
{

  programs.wofi = {
    enable = true;
    settings = {
     show="drun";
     width=750;
     height=400;
     always_parse_args=true;
     show_all=false;
     term="kitty";
     hide_scroll=true;
     print_command=true;
     insensitive=true;
     prompt="Search";
     columns=2;
     theme="mocha";
    };
    style = "./wofi/style.css";
  };
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
    config = rec {
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "kitty tmux"; 
      menu = "wofi --show drun";
      bars = [{
         command = "waybar";
#        fonts.size = 12.0;
#        position = "bottom";
      }];
#      execAlways = [
#        {command = "swaybg -i ~/.config/backgrounds/landscape01.jpg";}

#      ];
      startup = [
        {command = "swaybg -m fill -i ~/.config/backgrounds/landscape02.jpg"; always=true;}
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
