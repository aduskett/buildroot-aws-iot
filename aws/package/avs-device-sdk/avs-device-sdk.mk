################################################################################
#
# avs-device-sdk
#
################################################################################

AVS_DEVICE_SDK_VERSION = 1.22.0
AVS_DEVICE_SDK_SITE = $(call github,alexa,avs-device-sdk,v$(AVS_DEVICE_SDK_VERSION))
AVS_DEVICE_SDK_LICENSE = Apache-2.0
AVS_DEVICE_SDK_LICENSE_FILES = LICENSE
AVS_DEVICE_SDK_CPE_ID_VENDOR = amazon
AVS_DEVICE_SDK_INSTALL_STAGING = YES
AVS_DEVICE_SDK_SUPPORTS_IN_SOURCE_BUILD = NO

AVS_DEVICE_SDK_DEPENDENCIES = \
	libcurl \
	sqlite

AVS_DEVICE_SDK_CONF_OPTS += \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr"

$(eval $(cmake-package))
