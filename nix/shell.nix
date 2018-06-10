{nixpkgs ? import ./nixpkgs.nix {}}:

let
  stackWorkFilter = name: type: let baseName = baseNameOf (toString name); in ! (
    (type == "directory" && baseName == ".stack-work")
  );

  srcDir = builtins.filterSource stackWorkFilter ../.;

  packagesToInstall = nixpkgs.pkgs.haskell.packages.stackage.lib.callStackage2nix "zurihac18" srcDir {inherit nixpkgs;};

  makeOverridable = nixpkgs.lib.makeOverridable;

  ghc_with_packages = packagesToInstall.ghc.withPackages (ps: [ps.foo ps.bar]);

  buildStackProject = args: (nixpkgs.haskell.lib.buildStackProject args).overrideAttrs (oldAttrs: {
    STACK_IN_NIX_EXTRA_ARGS = "";
  });
in
  buildStackProject {
    name = "test-nix-thing";

      buildInputs = with nixpkgs.pkgs; [
      git   # used by stack when downloading github repos, etc
      ghc_with_packages
    ];
  }
