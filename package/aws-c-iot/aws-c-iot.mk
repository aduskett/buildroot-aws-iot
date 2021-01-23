################################################################################
#
# aws-c-iot
#
################################################################################

AWS_C_IOT_VERSION = 0119fb3e8599ea0d4f35a5962dc0732de7a82e46
AWS_C_IOT_SITE = https://github.com/awslabs/aws-c-iot.git
AWS_C_IOT_SITE_METHOD = git
AWS_C_IOT_LICENSE = Apache-2.0
AWS_C_IOT_LICENSE_FILES = LICENSE
AWS_C_IOT_CPE_ID_VENDOR = amazon
AWS_C_IOT_INSTALL_STAGING = YES
AWS_C_IOT_DEPENDENCIES += \
	aws-c-common \
	aws-c-io \
	aws-c-mqtt

AWS_C_IOT_CONF_OPTS += \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr"

$(eval $(cmake-package))
