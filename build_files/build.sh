#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux 

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket

dnf5 install -y @workstation-product-environment
systemctl enable gdm

# Install Flatpak

dnf5 install -y flatpak
flatpak remote-add --if-not-exists --system flathub https://flathub.org/repo/flathub.flatpakrepo

# Brew Dependincies
dnf5 install -y curl git gcc gcc-c++ make

# anaconda
dnf5 install -y anaconda anaconda-gui anaconda-webui anaconda-install-env-deps

# AMD Fixes
dnf5 install -y mesa-dri-drivers mesa-vulkan-drivers xorg-x11-drv-amdgpu
# AMD GPU kernel arguments
mkdir -p /usr/lib/dracut/dracut.conf.d/
echo 'kernel_cmdline="amdgpu.dc=1 radeon.si_support=0 amdgpu.si_support=1"' > /usr/lib/dracut/dracut.conf.d/99-amdgpu.conf