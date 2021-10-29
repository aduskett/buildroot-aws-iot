################################################################################
#
# aws-greengrass-core-sdk-c
#
################################################################################

AWS_GREENGRASS_CORE_SDK_C_VERSION = 1.2.0
AWS_GREENGRASS_CORE_SDK_C_SITE = $(call github,aws,aws-greengrass-core-sdk-c,v$(AWS_GREENGRASS_CORE_SDK_C_VERSION))
AWS_GREENGRASS_CORE_SDK_C_LICENSE = Apache-2.0
AWS_GREENGRASS_CORE_SDK_C_LICENSE_FILES = LICENSE
AWS_GREENGRASS_CORE_SDK_C_CPE_ID_VENDOR = amazon
AWS_GREENGRASS_CORE_SDK_C_INSTALL_STAGING = YES
AWS_GREENGRASS_CORE_SDK_C_CONF_OPTS += -DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr"

ifeq ($(BR2_PACKAGE_AWS_GREENGRASS_CORE),y)
AWS_GREENGRASS_CORE_SDK_C_DEPENDENCIES =  aws-greengrass-core
else
AWS_GREENGRASS_CORE_SDK_C_DEPENDENCIES =  aws-greengrass-core-v2
endif

$(eval $(cmake-package))
