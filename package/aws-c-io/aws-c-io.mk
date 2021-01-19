################################################################################
#
# aws-c-io
#
################################################################################

AWS_C_IO_VERSION = 0.4.35
AWS_C_IO_SITE = $(call github,awslabs,aws-c-io,v$(AWS_C_IO_VERSION))
AWS_C_IO_LICENSE = Apache-2.0
AWS_C_IO_LICENSE_FILES = LICENSE
AWS_C_IO_CPE_ID_VENDOR = amazon
AWS_C_IO_INSTALL_STAGING = YES
AWS_C_IO_DEPENDENCIES += \
	aws-c-common \
	s2n

AWS_C_IO_CONF_OPTS += \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr"

$(eval $(cmake-package))
