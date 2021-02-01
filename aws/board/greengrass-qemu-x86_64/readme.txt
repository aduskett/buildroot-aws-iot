Run the emulation with:

qemu-system-x86_64 \
  -enable-kvm \
  -m 512M \
  -M q35,accel=kvm \
  -drive if=pflash,format=raw,readonly,file=/usr/share/OVMF/OVMF_CODE.fd \
  -drive if=pflash,format=raw,readonly,file=/usr/share/OVMF/OVMF_VARS.fd \
  -smbios type=2 \
  -drive file=${CWD}/../../production/aws-iot-qemu-x86_64.img,format=raw,id=dcu,if=none \
  -device ahci,id=ahci \
  -device ide-hd,drive=dcu,bus=ahci.0 \
  -net nic,model=virtio -net user

Optionally add -smp N to emulate a SMP system with N CPUs.

The login prompt will appear in the graphical window.
