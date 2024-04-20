{lib, ...}: {
  imports = [./dadbod.nix];
  dadbod.enable =
    lib.mkDefault false;
}
