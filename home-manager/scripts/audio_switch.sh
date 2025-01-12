#!/bin/sh

SOURCE=$(pactl get-default-sink)

case "$SOURCE" in
  "alsa_output.usb-Focusrite_Scarlett_Solo_USB_Y7784JB1B26CD0-00.HiFi__Line1__sink")
    pactl set-default-sink "alsa_output.usb-Logitech_G560_Gaming_Speaker_00000000-00.analog-stereo"
  ;;
  "alsa_output.usb-Logitech_G560_Gaming_Speaker_00000000-00.analog-stereo")
    pactl set-default-sink "alsa_output.usb-Focusrite_Scarlett_Solo_USB_Y7784JB1B26CD0-00.HiFi__Line1__sink"
  ;;
  *)
    pactl set-default-sink "alsa_output.usb-Focusrite_Scarlett_Solo_USB_Y7784JB1B26CD0-00.HiFi__Line1__sink"
  ;;
esac

