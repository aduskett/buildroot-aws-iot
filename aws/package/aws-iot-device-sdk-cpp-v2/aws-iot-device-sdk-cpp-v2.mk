################################################################################
#
# aws-iot-device-sdk-cpp-v2
#
################################################################################

AWS_IOT_DEVICE_SDK_CPP_V2_VERSION = 1.10.0
AWS_IOT_DEVICE_SDK_CPP_V2_SITE = $(call github,aws,aws-iot-device-sdk-cpp-v2,v$(AWS_IOT_DEVICE_SDK_CPP_V2_VERSION))
AWS_IOT_DEVICE_SDK_CPP_V2_LICENSE = Apache-2.0
AWS_IOT_DEVICE_SDK_CPP_V2_LICENSE_FILES = LICENSE
AWS_IOT_DEVICE_SDK_CPP_V2_CPE_ID_VENDOR = amazon
AWS_IOT_DEVICE_SDK_CPP_V2_INSTALL_STAGING = YES
AWS_IOT_DEVICE_SDK_CPP_V2_DEPENDENCIES = \
	aws-c-io \
	aws-crt-cpp

AWS_IOT_DEVICE_SDK_CPP_V2_CONF_OPTS += \
	-DBUILD_DEPS=OFF \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr"

define AWS_IOT_DEVICE_SDK_CPP_V2_REMOVE_EMPTY_DIRECTORIES
	find $(TARGET_DIR)/usr/lib/ -type d \( -iname IotIdentity-cpp \
		-o -iname IotShadow-cpp \
		-o -iname IotJobs-cpp \
		-o -iname Discovery-cpp \
		-o -iname IotDeviceCommon-cpp \
		-o -iname IotDeviceDefender-cpp \
		-o -iname IotSecureTunneling-cpp \) -exec rm -rf {} +;
endef
AWS_IOT_DEVICE_SDK_CPP_V2_TARGET_FINALIZE_HOOKS += AWS_IOT_DEVICE_SDK_CPP_V2_REMOVE_EMPTY_DIRECTORIES

$(eval $(cmake-package))
