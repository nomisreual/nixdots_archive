{lib, ...}: {
  imports = [./luasnip.nix];
  luasnip.enable =
    lib.mkDefault false;
}
