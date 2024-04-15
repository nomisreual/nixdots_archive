{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.nixvim.packages.${system}.default
    ripgrep
    sleek
  ];
}
