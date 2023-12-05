# do an `lsblk` and note the name of the device you want to install this on, for example `/dev/nvme0n1`, or `/dev/sda`.
# the name of this one will be the part after `/dev/`, so in the first case name of it would be `nvme0n1`.
# create a file in the directory where this file is, and create an attribute list with that name under the `main` attribute.
# so in the first case, put `{ main = "nvme0n1" }` in it.

let
  data = import ./data.nix;
in
{
  disko.devices = {
    disk = {
      "${data.installation-device}" = {
        type = "disk";
        device = "/dev/${data.installation-device}";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                ];
              };
            };
            primary = {
              size = "100%";
              content = {
                type = "lvm_pv";
                vg = "pool";
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          swap = {
            size = data.ram;
            content = {
              type = "swap";
              randomEncryption = true;
              resumeDevice = true;
            };
          };
          root = {
            size = "200G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [
                "defaults"
              ];
            };
          };
          home = {
            size = "200G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/home";
              mountOptions = [
                "defaults"
              ];
            };
          };
        };
      };
    };
  };
}
