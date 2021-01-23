################################################################################
#
# aws-crt-cpp
#
################################################################################

AWS_CRT_CPP_VERSION = 0.11.5
AWS_CRT_CPP_SITE = $(call github,awslabs,aws-crt-cpp,v$(AWS_CRT_CPP_VERSION))
AWS_CRT_CPP_LICENSE = Apache-2.0
AWS_CRT_CPP_LICENSE_FILES = LICENSE
AWS_CRT_CPP_CPE_ID_VENDOR = amazon
AWS_CRT_CPP_INSTALL_STAGING = YES
AWS_CRT_CPP_DEPENDENCIES += \
	aws-c-auth \
	aws-c-cal \
	aws-c-http \
	aws-c-mqtt

AWS_CRT_CPP_CONF_OPTS += \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr"

$(eval $(cmake-package))
