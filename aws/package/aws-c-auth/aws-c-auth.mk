################################################################################
#
# aws-c-auth
#
################################################################################

AWS_C_AUTH_VERSION = 0.4.9
AWS_C_AUTH_SITE = $(call github,awslabs,aws-c-auth,v$(AWS_C_AUTH_VERSION))
AWS_C_AUTH_LICENSE = Apache-2.0
AWS_C_AUTH_LICENSE_FILES = LICENSE
AWS_C_AUTH_CPE_ID_VENDOR = amazon
AWS_C_AUTH_INSTALL_STAGING = YES
AWS_C_AUTH_DEPENDENCIES += \
	aws-c-cal \
	aws-c-common \
	aws-c-http \
	aws-c-io

AWS_C_AUTH_CONF_OPTS += \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr"

define AWS_C_AUTH_REMOVE_EMPTY_DIRECTORIES
	find $(TARGET_DIR)/usr/lib/ -type d -name aws-c-auth -exec rm -rf {} +;
endef
AWS_C_AUTH_TARGET_FINALIZE_HOOKS += AWS_C_AUTH_REMOVE_EMPTY_DIRECTORIES

$(eval $(cmake-package))
