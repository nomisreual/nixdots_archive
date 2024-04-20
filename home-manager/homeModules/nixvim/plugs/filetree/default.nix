{lib, ...}: {
  imports = [
    ./neotree.nix
  ];
  neotree.enable =
    lib.mkDefault false;
}
