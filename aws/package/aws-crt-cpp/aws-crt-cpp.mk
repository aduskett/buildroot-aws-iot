################################################################################
#
# aws-crt-cpp
#
################################################################################

AWS_CRT_CPP_VERSION = 0.17.29
AWS_CRT_CPP_SITE = $(call github,awslabs,aws-crt-cpp,v$(AWS_CRT_CPP_VERSION))
AWS_CRT_CPP_LICENSE = Apache-2.0
AWS_CRT_CPP_LICENSE_FILES = LICENSE
AWS_CRT_CPP_CPE_ID_VENDOR = amazon
AWS_CRT_CPP_INSTALL_STAGING = YES
AWS_CRT_CPP_DEPENDENCIES += \
	aws-c-auth \
	aws-c-cal \
	aws-c-common \
	aws-c-event-stream \
	aws-checksums \
	aws-c-http \
	aws-c-io \
	aws-c-mqtt \
	aws-c-s3 \
	openssl \
	s2n

AWS_CRT_CPP_CONF_OPTS += \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr" \
	-DBUILD_DEPS=OFF \
	-DBYO_CRYPTO=OFF \
	-DUSE_OPENSSL=ON

define AWS_CRT_CPP_REMOVE_EMPTY_DIRECTORIES
	find $(TARGET_DIR)/usr/lib/ -type d -name aws-crt-cpp -exec rm -rf {} +;
endef
AWS_CRT_CPP_TARGET_FINALIZE_HOOKS += AWS_CRT_CPP_REMOVE_EMPTY_DIRECTORIES

$(eval $(cmake-package))
