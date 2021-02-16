let
  cfg = import ../nix/default.nix { };
  hp = cfg.haskellPackages;
in
{}:

hp.shellFor {
  packages = p: [
    p.hakyll-blog
  ];

  buildInputs = with hp; [
    cabal-install
    ghcid
    hlint
    hp.hakyll-blog
    ormolu
  ];

  withHoogle = true;
}
