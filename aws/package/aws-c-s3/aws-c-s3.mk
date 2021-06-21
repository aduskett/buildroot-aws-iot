################################################################################
#
# aws-c-s3
#
################################################################################

AWS_C_S3_VERSION = 0.1.4
AWS_C_S3_SITE = $(call github,awslabs,aws-c-s3,v$(AWS_C_S3_VERSION))
AWS_C_S3_LICENSE = Apache-2.0
AWS_C_S3_LICENSE_FILES = LICENSE
AWS_C_S3_CPE_ID_VENDOR = amazon
AWS_C_S3_INSTALL_STAGING = YES
AWS_C_S3_DEPENDENCIES += \
	aws-c-auth \
	aws-c-http

AWS_C_S3_CONF_OPTS += \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr"

define AWS_C_S3_REMOVE_EMPTY_DIRECTORIES
	find $(TARGET_DIR)/usr/lib/ -type d -name aws-c-s3 -exec rm -rf {} +;
endef
AWS_C_S3_TARGET_FINALIZE_HOOKS += AWS_C_S3_REMOVE_EMPTY_DIRECTORIES

$(eval $(cmake-package))
