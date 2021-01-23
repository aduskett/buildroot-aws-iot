################################################################################
#
# aws-c-compression
#
################################################################################

AWS_C_COMPRESSION_VERSION = 0.2.10
AWS_C_COMPRESSION_SITE = $(call github,awslabs,aws-c-compression,v$(AWS_C_COMPRESSION_VERSION))
AWS_C_COMPRESSION_LICENSE = Apache-2.0
AWS_C_COMPRESSION_LICENSE_FILES = LICENSE
AWS_C_COMPRESSION_CPE_ID_VENDOR = amazon
AWS_C_COMPRESSION_INSTALL_STAGING = YES
AWS_C_COMPRESSION_DEPENDENCIES += aws-c-common

AWS_C_COMPRESSION_CONF_OPTS += \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr"

$(eval $(cmake-package))
