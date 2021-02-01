################################################################################
#
# usrsctp
#
################################################################################

USRSCTP_VERSION = 0.9.5.0
USRSCTP_SITE = $(call github,sctplab,usrsctp,$(USRSCTP_VERSION))
USRSCTP_LICENSE = BSD-3-Clause
USRSCTP_LICENSE_FILES = LICENSE.md
USRSCTP_CPE_ID_VENDOR = sctplab
USRSCTP_INSTALL_STAGING = YES

ifeq ($(BR2_STATIC_LIBS),y)
USRSCTP_CONF_OPTS += -Dsctp_build_shared_lib=OFF
else ifeq ($(BR2_SHARED_LIBS),y)
USRSCTP_CONF_OPTS += -Dsctp_build_shared_lib=ON
endif

ifeq ($(BR2_PACKAGE_USRSCTP_EXAMPLE_PROGRAMS),y)
USRSCTP_CONF_OPTS += -Dsctp_build_programs=true
else
USRSCTP_CONF_OPTS += -Dsctp_build_programs=false
endif

$(eval $(cmake-package))
