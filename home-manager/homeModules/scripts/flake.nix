{
  description = "Screenshot utilities";
  outputs = {
    self,
    nixpkgs,
  }: {
    defaultPackage.x86_64-linux = self.packages.x86_64-linux.screenshot;
    packages.x86_64-linux.screenshot = let
      pkgs = import nixpkgs {system = "x86_64-linux";};
      my_name = "screenshot";
      my_script = pkgs.writeShellScriptBin my_name ''
        grim -g "$(slurp -d)" - | swappy -f - &
      '';
      my_buildInputs = with pkgs; [grim slurp swappy wl-clipboard];
    in
      pkgs.symlinkJoin {
        name = my_name;
        paths = [my_script] ++ my_buildInputs;
        buildInputs = [pkgs.makeWrapper];
        postBuild = "wrapProgram $out/bin/${my_name} --prefix PATH : $out/bin";
      };
  };
}
