{nixpkgs ? import ./nixpkgs.nix {}}:

nixpkgs.haskell.lib.buildStackProject {
  name = "test-nix-thing";

  buildInputs = with nixpkgs.pkgs; [
    git   # used by stack when downloading github repos, etc
    ((haskell.packages.stackage.lib.callStackage2nix "zurihac18" ../.).ghcWithPackages (ps: [ps.text]))
  ];
}
