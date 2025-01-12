{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;


    shellAliases = {
      ll = "ls -l";
      update = "cd ~/Documents/nix-config && sudo nixos-rebuild switch --flake .#desktop";
      uupdate = "cd ~/Documents/nix-configs && home-manager switch --flake .#delta@desktop";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "golang"];
#      theme = "powerlevel10";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README
      ];
    };
    plugins = [
        { name = "powerlevel10k"; src = pkgs.zsh-powerlevel10k; file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";}
        {
          name = "powerlevel10k-config";
          src = ./p10k-config;
          file = "p10k.zsh";
        }
    ];
  };
}
