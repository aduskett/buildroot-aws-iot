################################################################################
#
# amazon-kinesis-video-streams-producer-sdk-cpp
#
################################################################################

AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_VERSION = 3.1.0
AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_SITE = $(call github,awslabs,amazon-kinesis-video-streams-producer-sdk-cpp,v$(AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_VERSION))
AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_LICENSE = Apache-2.0
AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_LICENSE_FILES = LICENSE
AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_CPE_ID_VENDOR = amazon
AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_INSTALL_STAGING = YES

AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_DEPENDENCIES = \
	amazon-kinesis-video-streams-producer-c \
	openssl \
	log4cplus

# We manage our own dependencies
AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_CONF_OPTS = \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr" \
	-DBUILD_DEPENDENCIES=OFF \
	-DBUILD_OPENSSL_PLATFORM=linux

ifeq ($(BR2_STATIC_LIBS),y)
AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_CONF_OPTS += -DBUILD_STATIC=ON
AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_LIB = libKinesisVideoProducer.a
AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_GST_LIB = libgstkvssink.a
else ifeq ($(BR2_SHARED_LIBS),y)
AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_CONF_OPTS += -DBUILD_STATIC=OFF
AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_LIB = libKinesisVideoProducer.so
AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_GST_LIB = libgstkvssink.so
endif

ifeq ($(BR2_TOOLCHAIN_USES_MUSL),y)
AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_CONF_OPTS += -DADD_MUCLIBC=ON
else ifeq ($(BR2_SHARED_LIBS),y)
AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_CONF_OPTS += -DADD_MUCLIBC=OFF
endif

ifeq ($(AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_GSTREAMER_PLUGIN),y)
AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_DEPENDENCIES += \
	gstreamer1 \
	gst1-plugins-base
AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_CONF_OPTS += \
	-DBUILD_GSTREAMER_PLUGIN=ON

define AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_INSTALL_GSTREAMER_PLUGIN
	$(INSTALL) -D -m 0755 $(@D)/$(AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_GST_LIB) \
		$(TARGET_DIR)/usr/lib/gstreamer-1.0/$(AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_GST_LIB);
endef
AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_POST_INSTALL_TARGET_HOOKS += AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_INSTALL_GSTREAMER_PLUGIN
endif

ifeq ($(AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_GSTREAMER_EXAMPLES),y)
define AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_INSTALL_GSTREAMER_EXAMPLES
	cp -dprf $(@D)/kvs_gstreamer_*_sample $(TARGET_DIR)/usr/bin/;
endef
AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_POST_INSTALL_TARGET_HOOKS += AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_INSTALL_GSTREAMER_EXAMPLES
endif

# The current CMakeLists.txt file doesn't support make install.
define AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0755 $(@D)/$(AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_LIB) \
		$(STAGING_DIR)/usr/lib/$(AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_LIB);
endef

define AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/$(AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_LIB) \
		$(TARGET_DIR)/usr/lib/$(AMAZON_KINESIS_VIDEO_STREAMS_PRODUCER_SDK_CPP_LIB);
endef

$(eval $(cmake-package))
