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

- ghostty
- fish
- zellij
- neovim
- aerospace
- git
- ssh
- programming languages
  - golang
  - nodejs (with typescript)
  - php
  - python
  - rust
- various command line tools (htop, watch, curl, ...)
- devops tools (kubectl, docker-compose, kustomize, helm, ...)

## 🚀 Usage

The repository contains three different configurations: nixos, my personal MBP and the work MBP.
With flakes support, nix, nix-darwin and home-manager are able to process the related profile by adding it as a hash parameter behind the path of the home-manager directory.

```sh
darwin-rebuild switch --flakes .#Daniels-MacBook-Pro
```

*or*

```sh
nix-os switch --flakes .#nixos
```

## 🏗 Install the requirements

**macOS**

``` sh
# install nix
sh <(curl -L https://nixos.org/nix/install)

# install nix-darwin
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer
```
