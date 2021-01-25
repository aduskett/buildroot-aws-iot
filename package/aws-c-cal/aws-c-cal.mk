################################################################################
#
# aws-c-cal
#
################################################################################

AWS_C_CAL_VERSION = 0.4.5
AWS_C_CAL_SITE = $(call github,awslabs,aws-c-cal,v$(AWS_C_CAL_VERSION))
AWS_C_CAL_LICENSE = Apache-2.0
AWS_C_CAL_LICENSE_FILES = LICENSE
AWS_C_CAL_CPE_ID_VENDOR = amazon
AWS_C_CAL_INSTALL_STAGING = YES
AWS_C_CAL_DEPENDENCIES += \
	aws-c-common \
	openssl

AWS_C_CAL_CONF_OPTS += \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr"

define AWS_C_CAL_REMOVE_EMPTY_DIRECTORIES
	find $(TARGET_DIR)/usr/lib/ -type d -name aws-c-cal -exec rm -rf {} +;
endef
AWS_C_CAL_TARGET_FINALIZE_HOOKS += AWS_C_CAL_REMOVE_EMPTY_DIRECTORIES

$(eval $(cmake-package))
