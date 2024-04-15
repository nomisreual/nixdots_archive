{lib, ...}: {
  imports = [./kitty.nix];
  kitty.enable =
    lib.mkDefault false;
}
