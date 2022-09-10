{
  description = "Home and system nix flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nurpkgs.url = github:nix-community/NUR;

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, ...}: 
    let
      system = "x86_64-linux";
    in
    {
      homeConfigurations = (
        import ./home/home-conf.nix {
	  inherit inputs system;
	}
      );

      nixosConfigurations = (
        import ./system/nixos-conf.nix {
	  inherit inputs system;
	}
      );

    };
}
