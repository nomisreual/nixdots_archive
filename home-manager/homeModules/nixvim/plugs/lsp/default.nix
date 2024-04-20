{lib, ...}: {
  imports = [./conform.nix ./fidget.nix ./lsp.nix ./none-ls.nix];
  conform.enable =
    lib.mkDefault false;
  fidget.enable =
    lib.mkDefault false;
  lsp.enable =
    lib.mkDefault false;
  none-ls.enable =
    lib.mkDefault false;
}
