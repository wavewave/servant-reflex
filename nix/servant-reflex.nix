{ pkgs ? import <nixpkgs> {}, reflexPlatform, compiler ? "ghcjs" }:

let

  ghcjsPackages = reflexPlatform.${compiler}.override {
    overrides = self: super: {
      uri-bytestring = pkgs.haskell.lib.doJailbreak super.uri-bytestring;
      http-api-data = pkgs.haskell.lib.dontHaddock super.http-api-data;
      http-media = pkgs.haskell.lib.dontCheck super.http-media;

      # for attoparsec and doctest issues
      servant = pkgs.haskell.lib.dontCheck (pkgs.haskell.lib.doJailbreak super.servant);
      wai = super.wai;
      servant-reflex = pkgs.haskell.lib.appendConfigureFlag 
                       (self.callPackage ../. {}) "-fExample";
    };
  };

in ghcjsPackages.servant-reflex