{ pkgs }:

(pkgs.callPackage ./hpkgs.nix { }).hakyll-blog
