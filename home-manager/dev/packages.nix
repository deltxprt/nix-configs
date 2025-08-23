{ pkgs, ... }:
{
  home.packages= with pkgs; [
    asdf
    asdf-vm
    bun
    gleam
  ];
}
