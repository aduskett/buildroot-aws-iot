################################################################################
#
# s2n
#
################################################################################

S2N_VERSION = 0.10.0
S2N_SITE = $(call github,awslabs,s2n,v$(S2N_VERSION))
S2N_LICENSE = Apache-2.0
S2N_LICENSE_FILES = LICENSE
S2N_CPE_ID_VENDOR = amazon
S2N_INSTALL_STAGING = YES

S2N_DEPENDENCIES = openssl

$(eval $(cmake-package))
