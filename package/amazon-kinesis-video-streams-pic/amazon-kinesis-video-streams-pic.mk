################################################################################
#
# amazon-kinesis-video-streams-pic
#
################################################################################

AMAZON_KINESIS_VIDEO_STREAMS_PIC_VERSION = 44e36e026cb5267056b84aa375a8f61501c4ee19
AMAZON_KINESIS_VIDEO_STREAMS_PIC_SITE = https://github.com/awslabs/amazon-kinesis-video-streams-pic.git
AMAZON_KINESIS_VIDEO_STREAMS_PIC_SITE_METHOD = git
AMAZON_KINESIS_VIDEO_STREAMS_PIC_LICENSE = Apache-2.0
AMAZON_KINESIS_VIDEO_STREAMS_PIC_LICENSE_FILES = LICENSE
AMAZON_KINESIS_VIDEO_STREAMS_PIC_CPE_ID_VENDOR = amazon
AMAZON_KINESIS_VIDEO_STREAMS_PIC_INSTALL_STAGING = YES
AMAZON_KINESIS_VIDEO_STREAMS_PIC_DEPENDENCIES = jsmn

# We manage our own dependencies
AMAZON_KINESIS_VIDEO_STREAMS_PIC_CONF_OPTS = \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr" \
	-DBUILD_DEPENDENCIES=OFF

$(eval $(cmake-package))
