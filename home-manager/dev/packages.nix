{ pkgs, ... }:
{
  home.packages= with pkgs; [
    asdf
    asdf-vm
    zoxide
    delta
  ];
}
