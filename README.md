# NixOS Marth

This is the NixOS config for `marth`, the PC for the conference room at INET.

## TODOS

- [ ] Set up firefox for user `conference`
- [ ] Set up slack (account?) for user `conference`
- [ ] Set up OBS??

## Users

### admin

Admins only, duh.

### conference

The "normal" user that will automatically log in and should be able to do the normal stuff for presenting and video-conferencing.

## Setup

(Mostly for first installation if we want to reinstall or install somewhere else...)

- Start live installation media
- Copy `data-template/data.nix` to the root directory and set the values as needed.
- Also possibly adjust `disko-config.nix`.
- Do disko, which means copying the cofigured `data.nix` and `disko-config.nix` to `/tmp/`, I think, and then doing the following.

```sh
# set `DISKNAME` to the name of the appropriate disk,
# e.g. `/dev/nvme0n1` or `/dev/sda`
DISKNAME="/dev/nvme0n1"
nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko-config.nix --arg disks "[ \"$DISKNAME\" ]"
```

- install NixOS as usual
