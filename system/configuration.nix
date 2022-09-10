{ config, lib, pkgs, inputs, ... }:
{
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Bootloader.
  boot.loader = {
	systemd-boot.enable = true;
  	efi.canTouchEfiVariables = true;
  	efi.efiSysMountPoint = "/boot/efi";
  };

  networking = {
	hostName = "nixos"; # Define your hostname.
  	networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Enable the X11 windowing system.
  services = {
	xserver = {
		enable = true;
	
  		# Enable the Cinnamon Desktop Environment.
		displayManager = {
			lightdm.enable = true;
			cinnamon.enable = true;
		};

  		# Configure keymap in X11
		layout = "us";
		xkbVariant = "";
  	};

  	# Enable CUPS to print documents.
  	printing.enable = true;

	pipewire = {
    		enable = true;
    		alsa.enable = true;
    		alsa.support32Bit = true;
    		pulse.enable = true;
	};
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.admin = {
    isNormalUser = true;
    description = "Admin";
    extraGroups = [ "networkmanager" "wheel" "kvm" ];
    packages = with pkgs; [
      firefox
    ];
    shell = pkgs.fish;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs = {
    fish.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };

  environment.systemPackages = with pkgs; [
    neovim
    fish
    direnv
    nix-direnv
    discord
  ];

  system.stateVersion = "22.05";
}
