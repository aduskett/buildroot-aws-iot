################################################################################
#
# aws-c-common
#
################################################################################

AWS_C_COMMON_VERSION = 0.4.67
AWS_C_COMMON_SITE = $(call github,awslabs,aws-c-common,v$(AWS_C_COMMON_VERSION))
AWS_C_COMMON_LICENSE = Apache-2.0
AWS_C_COMMON_LICENSE_FILES = LICENSE
AWS_C_COMMON_CPE_ID_VENDOR = amazon
AWS_C_COMMON_INSTALL_STAGING = YES

define AWS_C_COMMON_REMOVE_EMPTY_DIRECTORIES
	find $(TARGET_DIR)/usr/lib/ -type d -name aws-c-common -exec rm -rf {} +;
endef
AWS_C_COMMON_TARGET_FINALIZE_HOOKS += AWS_C_COMMON_REMOVE_EMPTY_DIRECTORIES

$(eval $(cmake-package))
