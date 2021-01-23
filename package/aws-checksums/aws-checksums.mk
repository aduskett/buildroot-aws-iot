################################################################################
#
# aws-checksums
#
################################################################################

AWS_CHECKSUMS_VERSION = 0.1.10
AWS_CHECKSUMS_SITE = $(call github,awslabs,aws-checksums,v$(AWS_CHECKSUMS_VERSION))
AWS_CHECKSUMS_LICENSE = Apache-2.0
AWS_CHECKSUMS_LICENSE_FILES = LICENSE
AWS_CHECKSUMS_CPE_ID_VENDOR = amazon
AWS_CHECKSUMS_INSTALL_STAGING = YES
AWS_CHECKSUMS_DEPENDENCIES += \
	aws-c-common

AWS_CHECKSUMS_CONF_OPTS += \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr"

$(eval $(cmake-package))
