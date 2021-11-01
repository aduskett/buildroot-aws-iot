

# Overview
This directory contains all necessary directories and files of which to use buildroot with aws packages for professional products.

## Reasons for using containers to build
Containers provide the following:
  - A consistent build environment
  - Easy setup and onboarding
  - Reproducible builds
  - An all-in-one setup process.

## Directory structure
This directory has the following structure:
  - buildroot
    - A stock buildroot download found at [buildroot.org](https://buildroot.org/) 
  - docker
    - Contains several files:
      - init
        - This file calls docker/init.py
      - init.py
        - Automatically sets up the buildroot environment.
      - env.json
        - Contains configuration settings for the various aws test defconfigs.
  - aws
    - The aws directory contains several directories used for persistent storage purposes.
        - board:
          - Board specific files and directories.
        - configs:
          - Buildroot defconfig files. During the initialization process, the docker init script loops through this directory and applies each config to aws/output.
        - dl:
          - This directory contains all downloaded source packages used in the above configs in a compressed format.
        - output:
          - The init-script applies each config file found in aws/configs to output/defconfig_config_name, and then the source code is built in that directory.
        - package:
          - Any external packages not in stock Buildroot go here.
        - patches:
          - buildroot:
            - Patches to apply to the buildroot directory. It usually contains package updates or modifications from upstream.

## Prerequisites:
- A computer running Linux
- Docker version 19.0 or newer
- Python version 3.6 or newer
- docker-compose version 1.27 or newer
- 10 - 50GB of free space.

## Setup
  - First, set the variables in docker/*.json to what is appropriate for the build.
    By default, the environment variables automatically apply all config files, and the init script automatically builds the greengrass_qemu_x86_64 defconfig..

## Building
If auto-building:
  - run `docker-compose up`. This will build the greengrass_qemu_x86_64 image.

If manually-building:
  - run `NO_BUILD=true docker-compose up -d && docker exec -ti buildroot-aws-iot-build /bin/bash`
  - Then navigate to `/home/br-user/buildroot/aws/output/${board_dir}/` and run `bmake` or `make` for verbose output.

## Environment variables
These variables will overwrite the variables set in your environment json files and must be passed in front of the `docker-compose up` command:
  - `APPLY_CONFIGS`: force applying of the config files, even if previously applied.
  - `BUILD_PACKAGE`: Specify a specific package or command of which to build.
  - `CLEAN_AFTER_BUILD`: Clean the build directory after building. Used to save space.
  - `ENV_FILES`: overwrite the default environment file list.
  - `EXIT_AFTER_BUILD`: Exit after build.
  - `NO_BUILD`: Do not build anything.
  - `TARGET`: Only build the specified target. Note: The target has to also be in env.json
  - `VERBOSE`: use make instead of brmake.

## Examples:
  - `VERBOSE="true" TARGET="test_musl" BUILD_PACKAGE="aws-iot-device-client" docker-compose up`
     The above command would build only the aws-iot-device-client package for the test_musl target in verbose mode.

# Customizations

## Changing the buildroot user name
  - Edit the BUILDROOT_USER variable in the docker-compose.yml file.

## Changing the buildroot directory name
  - Edit the BUILDROOT_DIR variable in the docker/env and docker-compose.yml files.
  - Change the buildroot_dir_name in env.json

## Changing the buildroot UID and GID
  - The default UID and GID for the buildroot user are 1000. However, you may customize the default by either:
    - modifying the docker-compose.yml file directly.
    - passing the UID and GID directly from the command line. IE: `docker-compose build --build-arg UID=$(id -u $(whoami)) --build-arg GID=$(id -g $(whoami))`

## Adding patches to buildroot
  - Patches in the aws/patches/buildroot directory are automatically copied and applied to buildroot when running `make build`.
    Add any desired buildroot patches to this directory.

## Adding additional external trees
  - Add additional external trees by adding the new directories name to the EXTERNAL_TREES variable in the docker-compose.yml file and adding the new external tree
    name to docker/env.json for the appropriate defconfig.

## Changing the Buildroot version
  - Edit the BUILDROOT_VERSION argument in the docker-compose.yml file
  - run `docker-compose build`
  Note: If you have a BUILDROOT_PATCH_DIR defined, watch for failures during the build process to ensure that all patches applied cleanly!

# Using the packages without docker:
- clone or download buildroot from: https://buildroot.org/
- clone or download and extract this repository: `git clone git@github.com:aduskett/buildroot-aws-iot.git`
- copy the config to the buildroot configs directory: `cp buildroot-aws-iot/aws/configs/greengrass_qemu_x86_64_defconfig configs/greengrass_qemu_x86_64_defconfig`
- apply the config with the external tree: `BR2_EXTERNAL=buildroot-aws-iot/aws make greengrass_qemu_x86_64_defconfig`
- Add or remove packages with `make menuconfig`
- Build the project with `make`
- Run the qemu image (see buildroot-aws-iot/aws/board/greengrass-qemu-x86_64/readme.txt)

For more information about using and building with Buildroot, see: https://buildroot.org/downloads/manual/manual.html

## Further reading
Please check [The Buildroot manual](https://buildroot.org/downloads/manual/manual.html) for more information.
