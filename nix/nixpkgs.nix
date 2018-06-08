# Nixpkgs pinned to specific version set in `nixpkgs.json` with overlays:
# * stackage haskell packages overlay
# * contractor packages overlay

{ pkgsPath ? <nixpkgs>
, overlays ? []
, system ? null
, config ? { } }:

let
  _pkgs = import <nixpkgs> {};
  _stackageOverlayPath = _pkgs.fetchFromGitHub (_pkgs.lib.importJSON ./stackage-overlay.json);
in
  import pkgsPath ({
    overlays = [
      (import _stackageOverlayPath)
    ] ++ overlays;
    config = config // { allowUnfree = true; };
  } // (if system != null then { inherit system; } else { }))
