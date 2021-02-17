################################################################################
#
# alexa-smart-screen-sdk
#
################################################################################

ALEXA_SMART_SCREEN_SDK_VERSION = 2.5.0
ALEXA_SMART_SCREEN_SDK_SITE = $(call github,alexa,alexa-smart-screen-sdk,v$(ALEXA_SMART_SCREEN_SDK_VERSION))
ALEXA_SMART_SCREEN_SDK_LICENSE = Apache-2.0
ALEXA_SMART_SCREEN_SDK_LICENSE_FILES = LICENSE.TXT
ALEXA_SMART_SCREEN_SDK_CPE_ID_VENDOR = amazon
ALEXA_SMART_SCREEN_SDK_INSTALL_STAGING = YES
ALEXA_SMART_SCREEN_SDK_SUPPORTS_IN_SOURCE_BUILD = NO

ALEXA_SMART_SCREEN_SDK_DEPENDENCIES = \
	host-nodejs \
	avs-device-sdk \
	apl-core-library \
	libasio \
	rapidjson \
	websocketpp

ALEXA_SMART_SCREEN_SDK_CONF_OPTS += \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr" \
	-DWEBSOCKETPP_INCLUDE_DIR="$(STAGING_DIR)/usr/include" \
	-DASIO_INCLUDE_DIR="$(STAGING_DIR)/usr/include" \
	-DAPLCORE_RAPIDJSON_INCLUDE_DIR="$(STAGING_DIR)/usr/include" \
	-DAPLCORE_INCLUDE_DIR="$(STAGING_DIR)/usr/include" \
	-DAPLCORE_BUILD_INCLUDE_DIR="$(STAGING_DIR)/usr/include" \
	-DAPLCORE_LIB_DIR="$(STAGING_DIR)/usr/lib" \
	-DBLUETOOTH_BLUEZ=OFF

$(eval $(cmake-package))
