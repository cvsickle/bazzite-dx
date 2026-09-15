# Bazzite DX

[![bluebuild build badge](https://github.com/cvsickle/bazzite-dx/actions/workflows/build.yml/badge.svg)](https://github.com/cvsickle/bazzite-dx/actions/workflows/build.yml) &nbsp; [![Dependabot Updates](https://github.com/cvsickle/bazzite-dx/actions/workflows/dependabot/dependabot-updates/badge.svg)](https://github.com/cvsickle/bazzite-dx/actions/workflows/dependabot/dependabot-updates) &nbsp; [![renovate](https://github.com/cvsickle/bazzite-dx/actions/workflows/renovate.yml/badge.svg)](https://github.com/cvsickle/bazzite-dx/actions/workflows/renovate.yml) &nbsp; [![Repo sync (GitHub -> Codeberg)](https://github.com/cvsickle/bazzite-dx/actions/workflows/sync_codeberg.yaml/badge.svg)](https://github.com/cvsickle/bazzite-dx/actions/workflows/sync_codeberg.yaml)

---

This repository is a custom [bootc](https://github.com/bootc-dev/bootc) image built on [Bazzite-DX](https://github.com/ublue-os/bazzite).

It was created using the [BlueBuild Workshop](https://workshop.blue-build.org/).

## Changes made

### System packages added

- Everything needed for [LazyVim](https://github.com/lazyvim/lazyvim)
  - [Neovim](https://github.com/neovim/neovim)
  - [LazyGit](https://github.com/jesseduffield/lazygit)
  - JetBrains Mono Nerd Font from [ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts)
  - Etc.
- [Helium Browser](https://github.com/imputnet/helium)

### Brew

- [Dev Container CLI](https://github.com/devcontainers/cli)
- [LazyDocker](https://github.com/jesseduffield/lazydocker)

### Flatpak

- [Easy Effects](https://flathub.org/en/apps/com.github.wwmm.easyeffects)
- [Gear Lever](https://flathub.org/en/apps/it.mijorus.gearlever)
- [Web Apps](https://flathub.org/en/apps/net.codelogistics.webapps)
- [SiriKali](https://flathub.org/en/apps/io.github.mhogomchungu.sirikali)

## Installation

THere is the recommened installation process.

- Flash the Stable Bazzite ISO from [bazzite.gg](https://bazzite.gg/) onto a USB.
- Boot from the USB and install Bazzite.
- Boot into Bazzite and switch it to [developer mode](https://dev.bazzite.gg/).

> [!TIP]
> This process should work from any Fedora-based bootc image.

- Once in developer mode, switch to this image.

```bash
# Normal image
sudo bootc switch ghcr.io/cvsickle/bazzite-dx:latest
# Nvidia image
sudo bootc switch ghcr.io/cvsickle/bazzite-dx-nvidia:latest

# Reboot when done.
systemctl reboot
```

- Once booted into this image, enable signing verification.

```bash
# Normal image
sudo bootc switch --enforce-container-sigpolicy ghcr.io/cvsickle/bazzite-dx:latest
# Nvidia image
sudo bootc switch --enforce-container-sigpolicy ghcr.io/cvsickle/bazzite-dx-nvidia:latest
```

- If the boot loader menu entries are still showing the upstream image name, force them to update.

```bash
sudo rpm-ostree kargs --append=bls.refresh=1
systemctl reboot

sudo rpm-ostree kargs --delete=bls.refresh=1
systemctl reboot
```

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/cvsickle/bazzite-dx
```

## Repository Mirrors

- GitHub - [https://github.com/cvsickle/bazzite-dx](https://github.com/cvsickle/bazzite-dx)
- Codeberg - [https://codeberg.org/cvsickle/bazzite-dx](https://codeberg.org/cvsickle/bazzite-dx)
- Forgejo (Mirror) - [https://git.cvsickle.com/cvsickle/bazzite-dx](https://git.cvsickle.com/cvsickle/bazzite-dx)
