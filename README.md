# gd-tools-flake
A flake wrapping https://codeberg.org/hashirama/gd-tools/, a fork of ajatt gd-tools. For use with Nix(OS).  
If you have NixOS system, this allows you to use the ajatt gd-tools for goldendict-ng easily.
These gd-tools include image search, strokeorder, and more.

## Installation Instructions
The instructions below are for when you use flakes to configure your system.  
- add `gd-tools.url = "github:1randomguy/gd-tools-flake";` to the inputs of the flake.
- add `inputs.gd-tools.packages.${pkgs.system}.default` to your list of installed programs
- for setup inside of goldendict-ng, refer back to https://codeberg.org/hashirama/gd-tools/

### Requirement for Strokeorder: 
Install `kanji-stroke-order-font` on the system (available as a nix-package)

### Requirement for Marisa: 
Put a dictionary file `<name>.dic` into the `~/.local/share/gd-tools/` directory.  
(https://codeberg.org/hashirama/gd-tools/ has one for japanese in the res directory)
