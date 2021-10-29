################################################################################
#
# aws-c-event-stream
#
################################################################################

AWS_C_EVENT_STREAM_VERSION = 0.2.7
AWS_C_EVENT_STREAM_SITE = $(call github,awslabs,aws-c-event-stream,v$(AWS_C_EVENT_STREAM_VERSION))
AWS_C_EVENT_STREAM_LICENSE = Apache-2.0
AWS_C_EVENT_STREAM_LICENSE_FILES = LICENSE
AWS_C_EVENT_STREAM_CPE_ID_VENDOR = amazon
AWS_C_EVENT_STREAM_INSTALL_STAGING = YES
AWS_C_EVENT_STREAM_DEPENDENCIES += \
	aws-c-common \
	aws-checksums \
	aws-c-io

AWS_C_EVENT_STREAM_CONF_OPTS += \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr"

define AWS_C_EVENT_STREAM_REMOVE_EMPTY_DIRECTORIES
	find $(TARGET_DIR)/usr/lib/ -name aws-c-event-stream -type d -exec rm -rf {} +;
endef
AWS_C_EVENT_STREAM_TARGET_FINALIZE_HOOKS += AWS_C_EVENT_STREAM_REMOVE_EMPTY_DIRECTORIES

$(eval $(cmake-package))
