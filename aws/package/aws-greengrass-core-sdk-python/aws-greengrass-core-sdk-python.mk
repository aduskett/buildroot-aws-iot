################################################################################
#
# aws-greengrass-core-sdk-python
#
################################################################################

AWS_GREENGRASS_CORE_SDK_PYTHON_VERSION = 1.6.1
AWS_GREENGRASS_CORE_SDK_PYTHON_SITE = $(call github,aws,aws-greengrass-core-sdk-python,v$(AWS_GREENGRASS_CORE_SDK_PYTHON_VERSION))
AWS_GREENGRASS_CORE_SDK_PYTHON_LICENSE = Apache-2.0
AWS_GREENGRASS_CORE_SDK_PYTHON_LICENSE_FILES = LICENSE
AWS_GREENGRASS_CORE_SDK_PYTHON_CPE_ID_VENDOR = amazon
AWS_GREENGRASS_CORE_SDK_PYTHON_INSTALL_STAGING = YES
AWS_GREENGRASS_CORE_SDK_PYTHON_SETUP_TYPE = setuptools
AWS_GREENGRASS_CORE_SDK_PYTHON_DEPENDENCIES = python-cbor2

AWS_GREENGRASS_CORE_SDK_PYTHON_CONF_OPTS += \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr"

ifeq ($(BR2_PACKAGE_AWS_GREENGRASS_CORE),y)
AWS_GREENGRASS_CORE_SDK_PYTHON_DEPENDENCIES += aws-greengrass-core
else
AWS_GREENGRASS_CORE_SDK_PYTHON_DEPENDENCIES += aws-greengrass-core-v2
endif

$(eval $(python-package))
