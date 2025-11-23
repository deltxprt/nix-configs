{ ... }:

{
  imports = [
    # ./example.nix - add your modules here
    ./packages.nix
  ];

  # hydenix home-manager options go here
  hydenix.hm.enable = true;
  # Visit https://github.com/richen604/hydenix/blob/main/docs/options.md for more options

  programs.yazi.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
 
  hydenix.hm.theme.active = "Peace Of Mind"

  hydenix.hm.social.enable = false;
  hydenix.hm.spotify.enable = false;
  hydenix.hm.editors.neovim.enable = true;
  hydenix.hm.editors.vscode.enable = true;

}
