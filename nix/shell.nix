{nixpkgs ? import ./nixpkgs.nix {}}:

let
  packagesToInstall = nixpkgs.pkgs.haskell.packages.stackage.lib.callStackage2nix "zurihac18" ../. {inherit nixpkgs;};
in
  nixpkgs.haskell.lib.buildStackProject {
    name = "test-nix-thing";

    buildInputs = with nixpkgs.pkgs; [
      git   # used by stack when downloading github repos, etc
      (packagesToInstall.ghc.withPackages (ps: [ps.foo ps.bar]))
    ];
  }
