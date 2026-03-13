#!/bin/bash
set -ouex pipefail

# Remove these — already in silverblue-main:
# @workstation-product-environment, gdm, flatpak, mesa drivers

# Things to actually add:
rpm-ostree install \
    tmux \
    btop \
    fastfetch \
    curl git gcc gcc-c++ make \
    anaconda anaconda-gui anaconda-webui \
    anaconda-install-env-deps \
    cockpit-bridge cockpit-ws

# AMD fixes
rpm-ostree install \
    xorg-x11-drv-amdgpu

# AMD kernel args
mkdir -p /usr/lib/dracut/dracut.conf.d/
echo 'kernel_cmdline="amdgpu.dc=1 radeon.si_support=0 amdgpu.si_support=1"' \
    > /usr/lib/dracut/dracut.conf.d/99-amdgpu.conf

# Services
systemctl enable podman.socket
# systemctl enable brew-setup.service