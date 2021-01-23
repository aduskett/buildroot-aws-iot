################################################################################
#
# aws-c-event-stream
#
################################################################################

AWS_C_EVENT_STREAM_VERSION = 0.2.6
AWS_C_EVENT_STREAM_SITE = $(call github,awslabs,aws-c-event-stream,v$(AWS_C_EVENT_STREAM_VERSION))
AWS_C_EVENT_STREAM_LICENSE = Apache-2.0
AWS_C_EVENT_STREAM_LICENSE_FILES = LICENSE
AWS_C_EVENT_STREAM_CPE_ID_VENDOR = amazon
AWS_C_EVENT_STREAM_INSTALL_STAGING = YES
AWS_C_EVENT_STREAM_DEPENDENCIES += \
	aws-checksums \
	aws-c-io

AWS_C_EVENT_STREAM_CONF_OPTS += \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr"

$(eval $(cmake-package))
