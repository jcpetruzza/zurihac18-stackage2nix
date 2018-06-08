{nixpkgs ? import ./nixpkgs.nix {}}:

nixpkgs.haskell.lib.buildStackProject {
  name = "test-nix-thing";

  buildInputs = with nixpkgs.pkgs; [
    git   # used by stack when downloading github repos, etc
    (haskell.packages.stackage.lts-116.ghcWithPackages (ps: [ps.text]))
  ];
}
