################################################################################
#
# aws-c-common
#
################################################################################

AWS_C_COMMON_VERSION = 0.4.36
AWS_C_COMMON_SITE = $(call github,awslabs,aws-c-common,v$(AWS_C_COMMON_VERSION))
AWS_C_COMMON_LICENSE = Apache-2.0
AWS_C_COMMON_LICENSE_FILES = LICENSE
AWS_C_COMMON_CPE_ID_VENDOR = amazon
AWS_C_COMMON_INSTALL_STAGING = YES

$(eval $(cmake-package))
