################################################################################
#
# aws-lc
#
################################################################################

AWS_LC_VERSION = 1.1.0
AWS_LC_SITE = $(call github,awslabs,aws-lc,v$(AWS_LC_VERSION))
AWS_LC_LICENSE = Apache-2.0, OpenSSL or SSLeay, ISC, BoringSSL
AWS_LC_LICENSE_FILES = LICENSE
AWS_LC_CPE_ID_VENDOR = amazon
AWS_LC_INSTALL_STAGING = YES
AWS_LC_DEPENDENCIES += \
	openssl

# Ensure aws-lc does not overwrite openssl libraries
AWS_LC_CONF_OPTS += \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr/lib/aws-lc" \
	-DCMAKE_INSTALL_PREFIX="/usr/lib/aws-lc" \
	-DBUILD_TESTING=OFF \
	-DBUILD_LIBSSL=OFF \
	-DDISABLE_PERL=ON \
	-DDISABLE_GO=ON

$(eval $(cmake-package))
