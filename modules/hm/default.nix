{ ... }:

{
  imports = [
    # ./example.nix - add your modules here
    ./packages.nix
  ];

  # hydenix home-manager options go here
  hydenix.hm = {
    enable = true;
    theme.active = "Peace Of Mind";
    social.enable = false;
    spotify.enable = false;
    editors.neovim.enable = true;
    editors.vscode.enable = true;
  };

  # Visit https://github.com/richen604/hydenix/blob/main/docs/options.md for more options

  programs.yazi.enable = true;
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
