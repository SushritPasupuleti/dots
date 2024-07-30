#!/bin/bash

# Follow `https://docs.fedoraproject.org/en-US/quick-docs/getting-started-with-virtualization/` for latest info

sudo dnf install @virtualization
sudo systemctl start libvirtd
sudo systemctl enable libvirtd
lsmod | grep kvm
