{lib, ...}: {
  imports = [
    ./lualine.nix
  ];
  lualine.enable =
    lib.mkDefault false;
}
