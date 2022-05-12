FROM ubuntu:jammy
LABEL maintainer="Adam Duskett <aduskett@gmail.com>" \
description="Everything needed to build Buildroot in a reproducable manner."

ENV DEBIAN_FRONTEND=noninteractive 
ENV TZ=US/Pacific

# Setup tzdata first as to avoid a dialog requesting tzdata setup.
RUN set -e; \
  mkdir -p /data/; \
  apt --allow-unauthenticated update; \
  apt --allow-unauthenticated upgrade -y; \
  apt-get install -y apt-utils gpgv2 locales tzdata; \
  localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8; \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime; \
  echo $TZ > /etc/timezone;

# Install dependencies
RUN set -e; \
  apt-get update; \
  apt-get upgrade -y; \
  apt-get install -y \
  bash \
  bash-completion \
  bc \
  bison \
  bridge-utils \
  bzip2 \
  cmake \
  cpio \
  curl \
  dialog \
  expect \
  file \
  flex \
  g++ \
  gcc \
  git \
  graphviz \
  help2man \
  iproute2 \
  lib32z1 \
  libgl1 \
  make \
  mc \
  mercurial \
  nano \
  ncurses-dev \
  net-tools \
  patch \
  psmisc \
  python3-dev \
  python3-pip \
  qemu-kvm \
  qemu-system \
  rsync \
  subversion \
  sudo \
  tar \
  unzip \
  wget \
  gcc-multilib \
  g++-multilib \
  libc6-i386; \
  pip3 install \
  aiohttp==3.7.3 \
  cve==1.0.1 \
  ijson==3.1.3 \
  nose2==0.9.2 \
  pexpect==4.8.0 \
  requests==2.25.1 \
  spdx_lookup==0.3.3; \
  cd /usr/bin/; \
  rm -rf python; \
  ln -s python3 python;

# Set these arguments in the docker-compose.yml file and the docker/env file
# if you wish to change the default values.
# Default values:
# BUILDROOT_USER: br-user
# BUILDROOT_DIR: buildroot
# The buildroot source code is extracted to /home/${BUILDROOT_USER}/{BUILDROOT_DIR}
ARG BUILDROOT_USER
ARG BUILDROOT_DIR
ARG BUILDROOT_PATCH_DIR
ARG BUILDROOT_VERSION
ARG UID
ARG GID

# Add the ${BUILDROOT_USER} user, as buildroot should never be built as root.
RUN set -e; \
  groupadd -r -g ${GID} ${BUILDROOT_USER}; \
  useradd -ms /bin/bash -u ${UID} -g ${GID} ${BUILDROOT_USER}; \
  usermod -aG rdma ${BUILDROOT_USER}; \
  echo "alias ls='ls --color=auto'" >> /home/${BUILDROOT_USER}/.bashrc; \
  echo "PS1='\u@\H [\w]$ '" >> /home/${BUILDROOT_USER}/.bashrc; \
  chown -R ${BUILDROOT_USER}:${BUILDROOT_USER} /home/${BUILDROOT_USER}; \
  wget https://buildroot.org/downloads/buildroot-${BUILDROOT_VERSION}.tar.gz -O /home/${BUILDROOT_USER}/buildroot.tar.gz; \
  mkdir -p /home/${BUILDROOT_USER}/${BUILDROOT_DIR}; \
  tar -zxf /home/${BUILDROOT_USER}/buildroot.tar.gz --strip-components=1 -C /home/${BUILDROOT_USER}/${BUILDROOT_DIR}; \
  chown -R ${BUILDROOT_USER}:${BUILDROOT_USER} /home/${BUILDROOT_USER}/${BUILDROOT_DIR}; \
  rm -rf /home/${BUILDROOT_USER}/buildroot.tar.gz;

# Copy brmake to /usr/bin for non-verbose builds.
WORKDIR /home/${BUILDROOT_USER}/${BUILDROOT_DIR}
RUN set -e; \
  cp utils/brmake /usr/bin/brmake; \
  chmod +x /usr/bin/brmake;

# Perform the following:
# - Pre-emtpively create the ccache diretory for permission purposes.
# - Link each external_tree to the base buildroot directory.
ARG EXTERNAL_TREES
RUN set -e; \
  mkdir -p /home/${BUILDROOT_USER}/ccache; \
  chown -R ${BUILDROOT_USER}:${BUILDROOT_USER} /home/${BUILDROOT_USER}/ccache; \
  mkdir -p /tmp/patches; \
  for EXTERNAL_TREE in ${EXTERNAL_TREES}; do \
    ln -s /mnt/${EXTERNAL_TREE} ${EXTERNAL_TREE}; \
  done;

# Ensure that any patches held in ${external_trees}/patches/buildroot are applied.
# This ensures that relevant upstream patches cherry-picked from
# https://patchwork.ozlabs.org/project/buildroot/list/ are applied during the
# docker build process.

COPY ${BUILDROOT_PATCH_DIR}* /tmp/patches/
RUN set -e; \
  cd  /home/${BUILDROOT_USER}/${BUILDROOT_DIR}; \
  if [ -n "${BUILDROOT_PATCH_DIR}" ]; then \
    for i in $(find /tmp/patches/ -name "*.patch" -exec readlink -f {} \; | sort ); do \
      echo "Applying patch: $(basename ${i})"; \
      patch -p1 < "${i}"; done; \
  fi; \
  rm -rf ${BUILDROOT_PATCH_DIR}; \
  chown -R ${BUILDROOT_USER}:${BUILDROOT_USER} /home/${BUILDROOT_USER}/${BUILDROOT_DIR};

COPY --chown=${BUILDROOT_USER}:${BUILDROOT_USER} docker/init /init

USER ${BUILDROOT_USER}
ENV HOME /home/${BUILDROOT_USER}
WORKDIR /home/${BUILDROOT_USER}/${BUILDROOT_DIR}

ENTRYPOINT ["/init"]
CMD ["/bin/bash"]

