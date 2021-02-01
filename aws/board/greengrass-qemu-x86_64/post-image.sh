#!/usr/bin/env sh
set -e
CWD=$(pwd)
BOARD_DIR=$(realpath "$(dirname "$0")")
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"
ROOTPATH_TMP="$(mktemp -d)"
PRODUCTION_DIR="${CWD}/aws/production-images/"
UUID=$(dumpe2fs "${BINARIES_DIR}/rootfs.ext2" 2>/dev/null | sed -n 's/^Filesystem UUID: *\(.*\)/\1/p')
sed -i "s/UUID_TMP/${UUID}/g" "${BINARIES_DIR}/efi-part/EFI/BOOT/grub.cfg"
sed "s/UUID_TMP/${UUID}/g" "${BOARD_DIR}/genimage.cfg" > "${BINARIES_DIR}/genimage.cfg"
support/scripts/genimage.sh -c "${BINARIES_DIR}/genimage.cfg"

mkdir -p "${PRODUCTION_DIR}"
cp "${BINARIES_DIR}/aws-iot-qemu-x86_64.img" "${PRODUCTION_DIR}/aws-iot-qemu-x86_64.img"
