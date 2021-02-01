################################################################################
#
# aws-c-io
#
################################################################################

AWS_C_IO_VERSION = 0.8.2
AWS_C_IO_SITE = $(call github,awslabs,aws-c-io,v$(AWS_C_IO_VERSION))
AWS_C_IO_LICENSE = Apache-2.0
AWS_C_IO_LICENSE_FILES = LICENSE
AWS_C_IO_CPE_ID_VENDOR = amazon
AWS_C_IO_INSTALL_STAGING = YES
AWS_C_IO_DEPENDENCIES += \
	aws-c-common \
	s2n

AWS_C_IO_CONF_OPTS += \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr"

define AWS_C_IO_REMOVE_EMPTY_DIRECTORIES
	find $(TARGET_DIR)/usr/lib/ -type d -name aws-c-io -exec rm -rf {} +;
endef
AWS_C_IO_TARGET_FINALIZE_HOOKS += AWS_C_IO_REMOVE_EMPTY_DIRECTORIES

$(eval $(cmake-package))
