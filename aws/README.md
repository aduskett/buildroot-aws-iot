# buildroot-aws-iot
An br2-external tree for AWS-IOT packages

# How to use the included x86-qemu defconfig
- clone or download buildroot from: https://buildroot.org/
- clone or download and extract this repository inside of the buildroot repository: `git clone git@github.com:aduskett/buildroot-aws-iot.git aws`
- copy the config to the buildroot configs directory: `cp ./aws/configs/greengrass_defconfig configs/greengrass_defconfig`
- apply the config with the external tree: `BR2_EXTERNAL=./aws make greengrass_defconfig`
- Add or remove packages with `make menuconfig`
- Build the project with `make`
- Run the qemu image (see aws/board/greengrass/readme.txt)

For more information about using and building with Buildroot, see: https://buildroot.org/downloads/manual/manual.html
