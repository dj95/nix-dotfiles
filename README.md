<div align="center">
  <h1 align="center">nix-dotfiles</h1>
  
  <p align="center">
    nix configuration for setting up my development environment.
    <br><br>
    In order to setup a new development machine and to maintain a development setup reliably, nix offers a declarative way for managing dependencies.
    Home manager adds another layer on the nix language for managing and maintaining several setups with their respective applications and configurations.
    This repository contains my opinionated configs, that I use on my daily-bases.
  </p>
  <br>
   <a href="https://nixos.org">nixOS</a>&nbsp;&nbsp;|&nbsp;
   <a href="https://github.com/nix-community/home-manager">home-manager</a>&nbsp;&nbsp;|&nbsp;
   <a href="https://search.nixos.org/packages">nix package search</a>&nbsp;&nbsp;|&nbsp;
   <a href="https://github.com/LnL7/nix-darwin">nix-darwin</a>
</div>


## 📦 Requirements

- nix (with flakes support!)
- home-manager


## 📋 Installed and configured programs

- kitty
- fish
- neovim
- emacs
- git
- ssh
- programming languages
  - golang
  - nodejs (with typescript)
  - php
  - python
- various command line tools (htop, watch, curl, ...)
- devops tools (kubectl, docker-compose, kustomize, helm, ...)


## 🚀 Usage

The repository contains two different configurations: one for my `linux-desktop` and one for my `macbook-pro`.
With flakes support, home-manager is able to process the related profile by adding it as a hash parameter behind the path of the home-manager directory.

```sh
$ cd home-manager
$ home-manager switch --flakes .#linux-desktop
```


## 🏗 Install the requirements

**macOS**

``` sh
$ sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume
$ nix-env -iA nixpkgs.nixUnstable
$ cat /etc/nix/nix.conf
experimental-features = nix-command flakes
$ nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
$ nix-channel --update
$ nix-shell '<home-manager>' -A install
```

**linux**

``` sh
$ sh <(curl -L https://nixos.org/nix/install)
$ nix-env -iA nixpkgs.nixUnstable
$ cat /etc/nix/nix.conf
experimental-features = nix-command flakes
$ nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
$ nix-channel --update
$ nix-shell '<home-manager>' -A install
```


## ❄️ Enable nix flakes support

Since nix flakes are not enable by default, we need to enable the feature flag by installing the `nixUnstable` package and
adding the last line of the code block to the nix configuration. When you've followed the previous section, you do not need
to run these steps.

```sh
$ nix-env -iA nixpkgs.nixUnstable
$ cat /etc/nix/nix.conf
experimental-features = nix-command flakes
```
