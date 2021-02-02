#!/usr/bin/env sh
set -e
BOARD_DIR=$(dirname "$0")

cp -f "${BOARD_DIR}/grub.cfg" "${BINARIES_DIR}/efi-part/EFI/BOOT/grub.cfg"
cp -f "${BOARD_DIR}/linux.config" "${TARGET_DIR}/boot/linux.config"
