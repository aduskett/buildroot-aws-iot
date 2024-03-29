################################################################################
#
# aws-c-http
#
################################################################################

AWS_C_HTTP_VERSION = 0.6.15
AWS_C_HTTP_SITE = $(call github,awslabs,aws-c-http,v$(AWS_C_HTTP_VERSION))
AWS_C_HTTP_LICENSE = Apache-2.0
AWS_C_HTTP_LICENSE_FILES = LICENSE
AWS_C_HTTP_INSTALL_STAGING = YES
AWS_C_HTTP_CPE_ID_VENDOR = amazon
AWS_C_HTTP_DEPENDENCIES += \
	aws-c-compression \
	aws-c-io

AWS_C_HTTP_CONF_OPTS += \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr" \
	-DENABLE_PROXY_INTEGRATION_TESTS=OFF

define AWS_C_HTTP_REMOVE_EMPTY_DIRECTORIES
	find $(TARGET_DIR)/usr/lib/ -type d -name aws-c-http -exec rm -rf {} +;
endef
AWS_C_HTTP_TARGET_FINALIZE_HOOKS += AWS_C_HTTP_REMOVE_EMPTY_DIRECTORIES

$(eval $(cmake-package))
