#!/bin/bash

#datadisk
sudo umount /dev/sda1
sudo ntfsfix /dev/sda1
sudo mount /dev/sda1

#Windows partition
sudo umount /dev/nvme0n1p4
sudo nfsfix /dev/nvme0n1p4
sudo mount /dev/nvme0n1p4
