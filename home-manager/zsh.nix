{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
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
  };
}
