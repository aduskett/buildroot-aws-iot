################################################################################
#
# aws-c-compression
#
################################################################################

AWS_C_COMPRESSION_VERSION = 0.2.14
AWS_C_COMPRESSION_SITE = $(call github,awslabs,aws-c-compression,v$(AWS_C_COMPRESSION_VERSION))
AWS_C_COMPRESSION_LICENSE = Apache-2.0
AWS_C_COMPRESSION_LICENSE_FILES = LICENSE
AWS_C_COMPRESSION_CPE_ID_VENDOR = amazon
AWS_C_COMPRESSION_INSTALL_STAGING = YES
AWS_C_COMPRESSION_DEPENDENCIES += aws-c-common

AWS_C_COMPRESSION_CONF_OPTS += \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr" \
	-DBUILD_HUFFMAN_GENERATOR=OFF

define AWS_C_COMPRESSION_REMOVE_EMPTY_DIRECTORIES
	find $(TARGET_DIR)/usr/lib/ -type d -name aws-c-compression -exec rm -rf {} +;
endef
AWS_C_COMPRESSION_TARGET_FINALIZE_HOOKS += AWS_C_COMPRESSION_REMOVE_EMPTY_DIRECTORIES

$(eval $(cmake-package))
