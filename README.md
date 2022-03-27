# [NixOS](https://nixos.org/) on the [Raspberry Pi Zero W](https://www.raspberrypi.com/products/raspberry-pi-zero-w/)

| :warning: WARNING |
|:------------------|
| This is a work in progress. As of now the i2c doesn't work yet. |

## Configuration
Copy the files from the `template` directory to the root of the repository and edit to your requirements.

## Building
```bash
nix-build \
    -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/9bc841f.tar.gz # nixos-unstable on 2022-03-23
```

## Flashing
```bash
# set correct path for SD card
export SD_CARD=/dev/sda
# inflate image and write to SD card
zstd -dcf result/sd-image/*.img.zst | sudo dd status=progress bs=64k iflag=fullblock oflag=direct of=$SD_CARD && sync && sudo eject $SD_CARD
```

## Attribution
- inspired by [illegalprime/nixos-on-arm](https://github.com/illegalprime/nixos-on-arm)
- big thanks to @sternenseemann for helping me with cross compilation
