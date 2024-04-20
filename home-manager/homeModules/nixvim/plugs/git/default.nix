{lib, ...}: {
  imports = [
    ./gitsigns.nix
  ];

  gitsigns.enable =
    lib.mkDefault false;
}
