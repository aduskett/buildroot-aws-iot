################################################################################
#
# amazon-corretto-bin
#
################################################################################

ifeq ($(BR2_AMAZON_CORRETTO_BIN_VERSION_17),y)
AMAZON_CORRETTO_BIN_VERSION = 17.0.0.35.1
else ifeq ($(BR2_AMAZON_CORRETTO_BIN_VERSION_11),y)
AMAZON_CORRETTO_BIN_VERSION = 11.0.13.8.1
else
AMAZON_CORRETTO_BIN_VERSION = 8.312.07.1
endif
AMAZON_CORRETTO_BIN_ARCH = $(call qstrip,$(BR2_PACKAGE_AMAZON_CORRETTO_BIN_ARCH))
AMAZON_CORRETTO_BIN_SOURCE = amazon-corretto-$(AMAZON_CORRETTO_BIN_VERSION)-linux-$(AMAZON_CORRETTO_BIN_ARCH).tar.gz
AMAZON_CORRETTO_BIN_SITE = https://corretto.aws/downloads/resources/$(AMAZON_CORRETTO_BIN_VERSION)
HOST_AMAZON_CORRETTO_BIN_SOURCE = amazon-corretto-$(AMAZON_CORRETTO_BIN_VERSION)-linux-x64.tar.gz
HOST_AMAZON_CORRETTO_BIN_SITE = https://corretto.aws/downloads/resources/$(AMAZON_CORRETTO_BIN_VERSION)
AMAZON_CORRETTO_BIN_INSTALL_STAGING = YES
AMAZON_CORRETTO_BIN_LICENSE = GPL-2.0+ with exception
AMAZON_CORRETTO_BIN_LICENSE_FILES = LICENSE ASSEMBLY_EXCEPTION

AMAZON_CORRETTO_BIN_INSTALL_BASE = usr/lib/jvm/amazon-corretto-$(AMAZON_CORRETTO_BIN_VERSION)


# unpack200 has an invalid RPATH and relies on libzlib. When
# host-libzlib is installed on the system, the error "ERROR: package
# host-libzlib installs executables without proper RPATH: will occur.
# Because unpack200 is a deprecated tool, removing it to fix this
# issue is safe.
define AMAZON_CORRETTO_BIN_INSTALL_STAGING_CMDS
	mkdir -p $(STAGING_DIR)/$(AMAZON_CORRETTO_BIN_INSTALL_BASE)
	cp -dpfr $(@D)/bin/* $(STAGING_DIR)/$(AMAZON_CORRETTO_BIN_INSTALL_BASE)
	$(RM) $(STAGING_DIR)/$(AMAZON_CORRETTO_BIN_INSTALL_BASE)/unpack200
	cd $(STAGING_DIR)/usr/bin && ln -snf ../../$(AMAZON_CORRETTO_BIN_INSTALL_BASE)/* .
endef

define AMAZON_CORRETTO_BIN_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/$(AMAZON_CORRETTO_BIN_INSTALL_BASE)
	cp -dpfr $(@D)/bin/* $(TARGET_DIR)/$(AMAZON_CORRETTO_BIN_INSTALL_BASE)
	$(RM) $(TARGET_DIR)/$(AMAZON_CORRETTO_BIN_INSTALL_BASE)/unpack200
	cd $(TARGET_DIR)/usr/bin && ln -snf ../../$(AMAZON_CORRETTO_BIN_INSTALL_BASE)/* .
endef

define HOST_AMAZON_CORRETTO_BIN_INSTALL_CMDS
	mkdir -p $(HOST_DIR)/$(AMAZON_CORRETTO_BIN_INSTALL_BASE)
	mkdir -p $(HOST_DIR)/usr/bin
	cp -dpfr $(@D)/* $(HOST_DIR)/$(AMAZON_CORRETTO_BIN_INSTALL_BASE)
	$(RM) $(HOST_DIR)/$(AMAZON_CORRETTO_BIN_INSTALL_BASE)/bin/unpack200
	cd $(HOST_DIR)/usr/bin && ln -snf ../$(AMAZON_CORRETTO_BIN_INSTALL_BASE)/bin/* .
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
