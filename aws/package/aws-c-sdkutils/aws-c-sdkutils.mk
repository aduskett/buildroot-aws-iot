################################################################################
#
# aws-c-sdkutils
#
################################################################################

AWS_C_SDKUTILS_VERSION = 0.1.2
AWS_C_SDKUTILS_SITE = $(call github,awslabs,aws-c-sdkutils,v$(AWS_C_SDKUTILS_VERSION))
AWS_C_SDKUTILS_LICENSE = Apache-2.0
AWS_C_SDKUTILS_LICENSE_FILES = LICENSE
AWS_C_SDKUTILS_CPE_ID_VENDOR = amazon
AWS_C_SDKUTILS_INSTALL_STAGING = YES
AWS_C_SDKUTILS_DEPENDENCIES += \
	aws-c-common

AWS_C_SDKUTILS_CONF_OPTS += \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr"

$(eval $(cmake-package))
