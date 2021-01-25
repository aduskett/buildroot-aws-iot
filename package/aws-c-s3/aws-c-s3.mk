################################################################################
#
# aws-c-s3
#
################################################################################

AWS_C_S3_VERSION = b5343e18a8721bbabd5f6f1b2259c1bae7741dd1
AWS_C_S3_SITE = https://github.com/awslabs/aws-c-s3.git
AWS_C_S3_SITE_METHOD = git
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
