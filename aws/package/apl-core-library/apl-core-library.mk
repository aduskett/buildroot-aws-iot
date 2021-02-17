################################################################################
#
# apl-core-library
#
################################################################################

APL_CORE_LIBRARY_VERSION = 1.5.1
APL_CORE_LIBRARY_SITE = $(call github,alexa,apl-core-library,v$(APL_CORE_LIBRARY_VERSION))
APL_CORE_LIBRARY_LICENSE = Apache-2.0
APL_CORE_LIBRARY_LICENSE_FILES = LICENSE
APL_CORE_LIBRARY_CPE_ID_VENDOR = amazon
APL_CORE_LIBRARY_INSTALL_STAGING = YES
APL_CORE_LIBRARY_SUPPORTS_IN_SOURCE_BUILD = NO

APL_CORE_LIBRARY_DEPENDENCIES = \
	rapidjson

APL_CORE_LIBRARY_CONF_OPTS += \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr" \
	-DUSE_SYSTEM_RAPIDJSON=ON

$(eval $(cmake-package))
