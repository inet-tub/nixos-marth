{ config, options, pkgs, lib, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
    ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system = {
    stateVersion = "23.11";
  };
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernel.sysctl = {
      "net.ipv4.ip_forward" = 1;
      "net.ipv6.conf.all.forwarding" = 1;
    };
    initrd.luks.devices = {
      root = {
        device = "/dev/disk/by-uuid/ecace02c-04ee-471a-9d3a-f841d1439304";
        preLVM = true;
        allowDiscards = true;
      };
    };
  };
  i18n = {
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "en_DK.UTF-8/UTF-8"
    ];
    defaultLocale = "en_DK.UTF-8";
    extraLocaleSettings = {
      LC_MEASUREMENT = "en_DK.UTF-8";
      LC_TIME = "en_DK.UTF-8";
    };
  };
  time = {
    timeZone = "Europe/Berlin";
  };
  networking = {
    hostName = "marth";
    firewall = {
      allowedTCPPorts = [22 80 443];
    };
  };
  environment = {
    systemPackages = with pkgs; [
      dig
      emacs29
      ferdium
      file
      filezilla
      firefox
      gimp
      git
      gparted
      gzip
      inkscape
      libreoffice
      mpv
      pciutils
      (python3Full.withPackages (ps: with ps; [ pip ]))
      remmina
      texlive.comvined.scheme-full
      thunderbird
      unzip
      vlc
      yt-dlp
    ];
  };
  hardware = {
  };
  security = {
    rtkit.enable = true;
  };
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    printing = {
      enable = true;
      drivers = with pkgs; [
        hplip
      ];
    };
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
    xserver = {
      enable = true;
      displayManager = {
        lightdm = {
          enable = true;
          greeters.gtk = {
            enable = true;
            extraConfig =
              ''
              user-background = false
              '';
          };
        };
      };
      desktopManager = {
        plasma5 = {
          enable = true;
        };
        xfce = {
          enable = true;
        };
      };
    };
  };
  nix = {
  };
  users = {
    users = {
      admin = {
        uid = 1000;
        isNormalUser = true;
        extraGroups = [
          "wheel"
        ];
      };
      guest = {
        uid = 1001;
        isNormalUser = true;
      };
    };
  };
}
