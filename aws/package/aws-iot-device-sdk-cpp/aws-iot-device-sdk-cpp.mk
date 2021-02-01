################################################################################
#
# aws-iot-device-sdk-cpp
#
################################################################################

AWS_IOT_DEVICE_SDK_CPP_VERSION = 1.4.0
AWS_IOT_DEVICE_SDK_CPP_SITE = $(call github,aws,aws-iot-device-sdk-cpp,v$(AWS_IOT_DEVICE_SDK_CPP_VERSION))
AWS_IOT_DEVICE_SDK_CPP_LICENSE = Apache-2.0
AWS_IOT_DEVICE_SDK_CPP_LICENSE_FILES = LICENSE
AWS_IOT_DEVICE_SDK_CPP_CPE_ID_VENDOR = amazon
AWS_IOT_DEVICE_SDK_CPP_INSTALL_STAGING = YES
AWS_IOT_DEVICE_SDK_CPP_SUPPORTS_IN_SOURCE_BUILD = NO

AWS_IOT_DEVICE_SDK_CPP_DEPENDENCIES = \
	aws-c-io \
	aws-crt-cpp

AWS_IOT_DEVICE_SDK_CPP_CONF_OPTS += \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr"

$(eval $(cmake-package))
