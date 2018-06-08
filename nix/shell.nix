{nixpkgs ? import <nixpkgs> {}}:

nixpkgs.haskell.lib.buildStackProject {
  name = "test-nix-thing";

  buildInputs = with nixpkgs.pkgs; [
    git   # used by stack when downloading github repos, etc
    haskell.compiler.ghc822
  ];
}
