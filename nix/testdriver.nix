{ reflexPlatform }:

(reflexPlatform.nixpkgs.haskellPackages.override {
  overrides = self: super: {
    # hspec = self.callHackage "hspec" "2.4.4" {};
    hspec-webdriver = self.callPackage ../../hspec-webdriver-1.2.0 {};
  };
}).callPackage ../testdriver/default.nix {}