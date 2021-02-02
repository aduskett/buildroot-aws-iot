Emulation in qemu (UEFI)
========================

Run the emulation with:

qemu-system-x86_64 \
  -enable-kvm \
  -m 512M \
  -M q35,accel=kvm
  -bios /usr/share/OVMF/OVMF_CODE.fd \
  -drive file=images/disk.img,if=virtio,format=raw \
  -net nic,model=virtio \
  -net user
