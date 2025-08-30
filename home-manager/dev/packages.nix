{ pkgs, ... }:
{
  home.packages= with pkgs; [
    asdf
    asdf-vm
    zoxide
    delta
    bun
    fzf
    jetbrains.rider
  ];
}
