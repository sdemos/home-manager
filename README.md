# Demos's home directory configuration

Since I'm incapable of just doing a project without inventing one hundred
pre-projects to do first, I decided to set up my new computer with nix.

To keep everything at least somewhat contained (and hopefully useful on other
platforms), I'm sticking with a much more narrow version of "using nix" than
you can potentiall get to. Instead of using nix-darwin or nixos or something
like that, I'm using home-manager to manage my config files and install all my
regular programs.

This repo contains the contents of .config/home-manager. It has the
configurations for all the basic programs I need installed on a system, as well
as my shell environment and various other files.

## Installation

The first step is to install nix. The easiest way is probably [zero-to-nix][1].

The next step is to do an initial bootstrap. This command should work, run from
this repo -

```
nix run . -- switch --flake .
```

Assuming there aren't any config file conflicts from existing configs, you
should be good to go.

Once the bootstrap is complete, we should be able to just use home-manager from
then on. The reason this works is pretty clever - home-manager manages config
files the "normal nix" way of symlinks into the nix store, but since those
symlinks are in the normal place things look for them, and don't go away, when
the terminal runs zsh as the default shell it sources the home-manager zsh
files which fix up the path and give us our packages back.

## Usage

I need to remember to flesh out this part as I get more used to day-to-day
usage of nix. However, there are a couple of initial flows I think work.

There are two ways to "install" packages - one is to put a new package into
`home.packages`. The other is - this is nix! Use it! zero-to-nix has various
tutorials for using nix, but the gist is you can run packages one-off very
easily with `nix run` -

```
echo "Hello Nix" | nix run "https://flakehub.com/f/NixOS/nixpkgs/*#ponysay"
```

The more normal way though, once we decide we need a package, is to add it to
home.packages. Once you do that, you can run `home-manager switch` and it
should install it and make it available in the path.

[1]: https://zero-to-nix.com/start/install/

