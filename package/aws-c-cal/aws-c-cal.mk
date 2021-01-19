################################################################################
#
# aws-c-cal
#
################################################################################

AWS_C_CAL_VERSION = 0.2.6
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

$(eval $(cmake-package))
