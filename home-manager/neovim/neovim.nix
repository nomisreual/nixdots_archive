{ config, pkgs, ... }:
{
  programs.neovim =
  let    
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraLuaConfig = ''
    -- Options
    ${builtins.readFile ./lua/options.lua}
    -- Keymaps
    ${builtins.readFile ./lua/keymaps.lua}
    -- Autocommands
    ${builtins.readFile ./lua/autocmds.lua}
    -- Lazy Plugin manager:
    ${builtins.readFile ./lua/lazy.lua}
    '';

    extraPackages = with pkgs; [
      # Clipboard providers:
      xclip
      wl-clipboard
      # Formatters
      black
      isort
      stylua
    ];
  };
}
