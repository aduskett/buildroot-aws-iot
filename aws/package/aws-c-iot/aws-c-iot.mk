################################################################################
#
# aws-c-iot
#
################################################################################

AWS_C_IOT_VERSION = 0.0.2
AWS_C_IOT_SITE = $(call github,awslabs,aws-c-iot,v$(AWS_C_IOT_VERSION))
AWS_C_IOT_LICENSE = Apache-2.0
AWS_C_IOT_LICENSE_FILES = LICENSE
AWS_C_IOT_CPE_ID_VENDOR = amazon
AWS_C_IOT_INSTALL_STAGING = YES
AWS_C_IOT_DEPENDENCIES += \
	aws-c-cal \
	aws-c-common \
	aws-c-compression \
	aws-c-http \
	aws-c-io \
	aws-c-mqtt \
	openssl \
	s2n

AWS_C_IOT_CONF_OPTS += \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr"

define AWS_C_IOT_REMOVE_EMPTY_DIRECTORIES
	find $(TARGET_DIR)/usr/lib/ -type d -name aws-c-iot -exec rm -rf {} +;
endef
AWS_C_IOT_TARGET_FINALIZE_HOOKS += AWS_C_IOT_REMOVE_EMPTY_DIRECTORIES

$(eval $(cmake-package))
