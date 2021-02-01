################################################################################
#
# aws-iot-securetunneling-localproxy
#
################################################################################

AWS_IOT_SECURETUNNELING_LOCALPROXY_VERSION = 2.1.0

AWS_IOT_SECURETUNNELING_LOCALPROXY_SITE = $(call github,aws-samples,aws-iot-securetunneling-localproxy,v$(AWS_IOT_SECURETUNNELING_LOCALPROXY_VERSION))
AWS_IOT_SECURETUNNELING_LOCALPROXY_LICENSE = Apache-2.0
AWS_IOT_SECURETUNNELING_LOCALPROXY_LICENSE_FILES = LICENSE
AWS_IOT_SECURETUNNELING_LOCALPROXY_CPE_ID_VENDOR = amazon
AWS_IOT_SECURETUNNELING_LOCALPROXY_SUPPORTS_IN_SOURCE_BUILD = NO
AWS_IOT_SECURETUNNELING_LOCALPROXY_DEPENDENCIES += \
	host-protobuf \
	boost-1-69 \
	libopenssl \
	protobuf

AWS_IOT_SECURETUNNELING_LOCALPROXY_CONF_OPTS += \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr" \
	-DProtobuf_PROTOC_EXECUTABLE="$(HOST_DIR)/bin/protoc"

define AWS_IOT_SECURETUNNELING_LOCALPROXY_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 $(AWS_IOT_SECURETUNNELING_LOCALPROXY_BUILDDIR)/bin/localproxy \
		$(TARGET_DIR)/usr/bin/localproxy
endef

$(eval $(cmake-package))
