{ inputs, system, ... }:
let 
  nixosSystem = inputs.nixpkgs.lib.nixosSystem;
in
{
  mySystem = nixosSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
      ./home-desktop
      ./configuration.nix
    ];
  };
}
