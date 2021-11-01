################################################################################
#
# aws-c-auth
#
################################################################################

AWS_LAMBDA_CPP_VERSION = 0.2.7
AWS_LAMBDA_CPP_SITE = $(call github,awslabs,aws-lambda-cpp,v$(AWS_LAMBDA_CPP_VERSION))
AWS_LAMBDA_CPP_LICENSE = Apache-2.0
AWS_LAMBDA_CPP_LICENSE_FILES = LICENSE
AWS_LAMBDA_CPP_CPE_ID_VENDOR = amazon
AWS_LAMBDA_CPP_INSTALL_STAGING = YES
AWS_LAMBDA_CPP_DEPENDENCIES += \
	libcurl \
	zip

AWS_LAMBDA_CPP_CONF_OPTS += \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr"


ifeq ($(BR2_GCC_ENABLE_LTO),y)
AWS_LAMBDA_CPP_CONF_OPTS += -DENABLE_LTO=ON
else
AWS_LAMBDA_CPP_CONF_OPTS += -DENABLE_LTO=OFF
endif

$(eval $(cmake-package))
