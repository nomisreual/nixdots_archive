{pkgs, ...}:
pkgs.writeShellScriptBin "screenshot_display" ''
  ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -o)" - | ${pkgs.swappy}/bin/swappy -f - &
''
