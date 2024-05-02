{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    autosuggestion.enable = true;
    enableCompletion = true;
    initExtra = ''
      # Zoxide
      eval "$(zoxide init zsh --cmd cd)"

      # Starship
      eval "$(starship init zsh)"

      # Add local bin
      path=('/home/simon/.local/bin' $path)
      export PATH
    '';
    shellAliases = {
      py = "nix develop github:nomisreual/DevShells -c zsh";
      py310 = "nix develop github:nomisreual/DevShells#py310 -c zsh";
      py312 = "nix develop github:nomisreual/DevShells#py312 -c zsh";
    };
  };
}
