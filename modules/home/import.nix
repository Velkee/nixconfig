{lib, ...}: let
  inherit (lib) mapAttrs collect isString mapAttrsRecursive concatStringsSep;

  getDir = dir:
    mapAttrs (
      file: type:
        if type == "directory"
        then getDir "${dir}/${file}"
        else type
    ) (builtins.readDir dir);

  # Collects all files of a directory as a list of strings of paths
  files = dir: collect isString (mapAttrsRecursive (path: type: concatStringsSep "/" path) (getDir dir));

  getDefaultNix = dir:
    builtins.map (file: ./. + "/${file}") (
      builtins.filter (file: builtins.baseNameOf file == "default.nix") (files dir)
    );
in {
  imports = getDefaultNix ./.;
}
