{ pkgs ? import <nixpkgs> {} }:

pkgs.haskellPackages.callHackage "servant-snap" "0.8.1" {}
