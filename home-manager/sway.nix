{ config, lib, ... }:
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
    style = ''

    * {
	font-family: "Hack", monospace;
}

window {
	background-color: transparent;
}

#input {
	margin: 5px;
  border: 1px #626880;
  border-style: solid;
	border-radius: 10px;
	background-color: #303446;
	color: #c6d0f5;
  outline-color: #303446;
}

#input:focus {
  box-shadow: rgba(239, 159, 118, 0.4) 0px 0px 0px 2px, rgba(239, 159, 118, 0.65) 0px 4px 6px -1px, rgba(239, 159, 118, 0.08) 0px 1px 0px inset;
}

/* #inner-box { */
/* 	background-color: #303446; */
/* } */

#outer-box {
	margin: 2px;
	padding: 10px;
  border: 1px #626880;
  border-style: solid;
  border-radius: 20px;
	background-color: #303446;
}

#scroll {
	margin: 5px;
}

#text {
	padding: 4px;
	color: #c6d0f5;
}

#entry:nth-child(even){
	background-color: #3C4053;
}

#entry:selected {
	background-color: #626880;
}

#text:selected {
	background: transparent;
}
  '';
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
      output = {
        DP-1 = {
          pos = "-2560 -750";
          adaptive_sync = "on"
        };
        DP-2 = {
          pos = "0 0";
        };
      };
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
