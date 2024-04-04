{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    inputs.nixvim.packages.${system}.default
    ripgrep
    black
    isort
    prettierd
    stylua
    sleek
    codespell
  ];
}
