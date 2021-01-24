################################################################################
#
# aws-sdk-cpp
#
################################################################################

AWS_SDK_CPP_VERSION = 1.8.129
AWS_SDK_CPP_SITE = $(call github,aws,aws-sdk-cpp,$(AWS_SDK_CPP_VERSION))
AWS_SDK_CPP_LICENSE = Apache-2.0
AWS_SDK_CPP_LICENSE_FILES = LICENSE
AWS_SDK_CPP_CPE_ID_VENDOR = amazon
AWS_SDK_CPP_INSTALL_STAGING = YES

AWS_SDK_CPP_DEPENDENCIES = \
	aws-c-cal \
	aws-c-event-stream

AWS_SDK_CPP_CONF_OPTS += \
	-DANDROID_BUILD_CURL=OFF \
	-DANDROID_BUILD_OPENSSL=OFF \
	-DANDROID_BUILD_ZLIB=OFF \
	-DAUTORUN_UNIT_TESTS=OFF \
	-DBUILD_DEPS=OFF \
	-DBYPASS_DEFAULT_PROXY=OFF \
	-DENABLE_ADDRESS_SANITIZER=OFF \
	-DENABLE_HTTP_CLIENT_TESTING=OFF \
	-DENABLE_RTTI=ON \
	-DENABLE_TESTING=OFF \
	-DENABLE_UNITY_BUILD=ON \
	-DENABLE_VIRTUAL_OPERATIONS=ON \
	-DNO_ENCRYPTION=OFF \
	-DSIMPLE_INSTALL=ON \
	-DUSE_IXML_HTTP_REQUEST_2=OFF \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr"

ifeq ($(BR2_OPTIMIZE_S),y)
AWS_SDK_CPP_CONF_OPTS += -DDMINIMIZE_SIZE=ON
else
AWS_SDK_CPP_CONF_OPTS += -DDMINIMIZE_SIZE=OFF
endif

ifeq ($(BR2_STATIC_LIBS),y)
AWS_SDK_CPP_CONF_OPTS += \
	-DBUILD_SHARED_LIBS=OFF \
	-DFORCE_SHARED_CRT=OFF
else ifeq ($(BR2_SHARED_LIBS),y)
AWS_SDK_CPP_CONF_OPTS += \
	-DBUILD_SHARED_LIBS=ON \
	-DFORCE_SHARED_CRT=ON
endif

ifeq ($(BR2_PACKAGE_AWS_SDK_CPP_HTTP_CLIENT),y)
AWS_SDK_CPP_DEPENDENCIES += libcurl
AWS_SDK_CPP_CONF_OPTS += \
	-DNO_HTTP_CLIENT=OFF \
	-DENABLE_CURL_LOGGING=ON \
	-DFORCE_CURL=ON

# Prevent Cmaketests trying to run cross-compiled binaries in an attempt to
# check if libcurl has proxy support
ifeq ($(BR2_PACKAGE_LIBCURL_PROXY_SUPPORT),y)
AWS_SDK_CPP_CONF_OPTS += \
	-DCURL_HAS_TLS_PROXY_EXITCODE=0 \
	-DCURL_HAS_TLS_PROXY_EXITCODE__TRYRUN_OUTPUT="yes"
else
AWS_SDK_CPP_CONF_OPTS += \
	-DCURL_HAS_TLS_PROXY_EXITCODE=1 \
	-DCURL_HAS_TLS_PROXY_EXITCODE__TRYRUN_OUTPUT="no"
endif

# Prevent Cmaketests trying to run cross-compiled binaries in an attempt to
# check if libcurl has http2 support
ifeq ($(BR2_PACKAGE_NGHTTP2),y)
AWS_SDK_CPP_CONF_OPTS += \
	-DCURL_HAS_H2_EXITCODE=0 \
	-DCURL_HAS_H2_EXITCODE__TRYRUN_OUTPUT="yes"
else
AWS_SDK_CPP_CONF_OPTS += \
	-DCURL_HAS_H2_EXITCODE=1 \
	-DCURL_HAS_H2_EXITCODE__TRYRUN_OUTPUT="no"
endif

else
AWS_SDK_CPP_CONF_OPTS += \
	-DNO_HTTP_CLIENT=ON \
	-DENABLE_CURL_LOGGING=OFF \
	-DFORCE_CURL=OFF
endif # ifeq ($(BR2_PACKAGE_AWS_SDK_CPP_HTTP_CLIENT),y)

ifeq ($(BR2_PACKAGE_AWS_SDK_CPP_TEXT_TO_SPEECH),y)
AWS_SDK_CPP_DEPENDENCIES += pulseaudio
endif

$(eval $(cmake-package))
