{ system, nixpkgs, nurpkgs, home-manager, ...}:

let
  username = "admin";
  homeDirectory = "/home/${admin}";
  configHome = "${homeDirectory}/.config";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
    config.xdg.configHome = configHome;
    overlays = [ nurpkgs.overlay ];
  };

  nur = import nurpkgs {
    inherit pkgs;
    nurpkgs = pkgs;
  };

in
{
  main = home-manager.lib.homeManagerConfiguration rec {
    inherit pkgs system username homeDirectory;

    stateVersion = "22.04";
    configuration = import ./home.nix {
      inherit nur pkgs;
      inherit (pkgs) config lib stdenv;
    };
  };
}
