{pkgs, ...}:
pkgs.writeShellScriptBin "screenshot" ''
  ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -d)" - | ${pkgs.swappy}/bin/swappy -f - &
''
