{ self, inputs, ... }:
{
  flake.nixosConfigurations.zephyrus = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.zephyrus
    ];
  };

  flake.nixosModules.zephyrus =
    { pkgs, ... }:
    {
      imports = [
        self.nixosModules.common
        self.nixosModules.tmux
        self.nixosModules.neovim
        self.nixosModules.jujutsu
        self.nixosModules.git
        self.nixosModules.dev-tools
        self.nixosModules.stylix
        self.nixosModules.zephyrus-hardware
        self.nixosModules.opencode
        inputs.nixos-hardware.nixosModules.asus-zephyrus-ga402
      ];

      # Bootloader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

      # Use latest kernel.
      boot.kernelPackages = pkgs.linuxPackages_latest;

      programs.niri.enable = true;
      services.ollama.enable = true;
      programs.dms-shell = {
        enable = true;
        quickshell.package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
        systemd = {
          enable = true;
          restartIfChanged = true;
        };
        enableSystemMonitoring = true;
        enableDynamicTheming = true;
        enableAudioWavelength = true;
        enableCalendarEvents = true;
      };
      services.displayManager.dms-greeter = {
        enable = true;
        compositor.name = "niri";
      };
      environment.systemPackages = with pkgs; [
        ghostty
        cups-pk-helper
      ];

      services.upower.enable = true;

      # Configure keymap in X11
      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };

      networking.networkmanager.enable = true;

      services.supergfxd = {
        settings = {
          vfio_enable = true;
        };
      };

      boot.kernelParams = [
        "mem_sleep_default=deep"
        "resume_offset=37974016"
      ];
      boot.resumeDevice = "/dev/disk/by-uuid/b5e9d237-e829-4cdd-8a38-29a08f72a6c2";
      powerManagement.enable = true;
      services.power-profiles-daemon.enable = true;
      services.logind.settings.Login.LidSwitch = "suspend-then-hibernate";
      services.logind.settings.Login.PowerKey = "hibernate";
      services.logind.settings.Login.PowerKeyLongPress = "poweroff";
      networking.hostName = "zephyrus";

      swapDevices = [
        {
          device = "/swapfile";
          size = 16 * 1024;
        }
      ];

      services.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      users.users.jan = {
        isNormalUser = true;
        description = "Jan";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };

      programs.firefox.enable = true;

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "25.05"; # Did you read the comment?
    };
}
