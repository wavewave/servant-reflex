{ servant-reflex, reflexPlatform }:

let
  dj = reflexPlatform.nixpkgs.haskell.lib.doJailbreak;
  dc = reflexPlatform.nixpkgs.haskell.lib.dontCheck;
  ghcPackages = reflexPlatform.ghc.override {
    overrides = self: super: {
      snap = dj (self.callCabal2nix "snap" ../../snap {});
      hspec-snap = dj (super.hspec-snap);
      snap-server = dc super.snap-server;
      servant-snap = dc (dj (self.callHackage "servant-snap" "0.8.1" {}));
      skylighting = dc super.skylighting;
      testserver = (self.callPackage ../testserver/default.nix {}).overrideDerivation (old:
        { postInstall = ''
        echo "SOURCE IS: $src"
        echo "ls IS: $ls"
        echo "EXAMPLE IS: ${servant-reflex}"
        cp dist/build/back/back $out/back
        mkdir $out/static
        cp ${servant-reflex}/bin/example.jsexe/* $out/static/
        '';
         }
      );
      heist       = dj (dc super.heist);
    };
  };

in ghcPackages.testserver