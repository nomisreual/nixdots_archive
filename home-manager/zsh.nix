{ config, pkgs, ...}:
{
  programs.zsh = {
    enable = true;
    #dotDir = ".config/zsh";
    autosuggestion.enable = true;
    enableCompletion = true;
    initExtra = ''
	# Zoxide
	eval "$(zoxide init zsh)"

	# Starship
	eval "$(starship init zsh)"

	# Add local bin
	path=('/home/simon/.local/bin' $path)
	export PATH
    '';
  };
}
