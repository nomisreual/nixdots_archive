{
  imports = [
    ./completion/cmp.nix
    ./database
    ./filetree/neotree.nix
    ./git
    ./lsp
    ./snippets
    ./statusline
    ./telescope/telescope.nix
    ./treesitter/treesitter.nix
    ./ui
    ./utilities
  ];

  cmp.enable = true;
  neotree.enable = true;
  dadbod.enable = true;
  gitsigns.enable = true;

  lsp.enable = true;
  none-ls.enable = true;
  conform.enable = true;
  fidget.enable = true;

  luasnip.enable = true;

  lualine.enable = true;
}
