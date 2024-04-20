{lib, ...}: {
  imports = [
    ./cmp.nix
  ];

  cmp.enable =
    lib.mkDefault false;
}
