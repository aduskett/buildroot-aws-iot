################################################################################
#
# amazon-kinesis-producer
#
################################################################################

AMAZON_KINESIS_PRODUCER_VERSION = 0.14.9
AMAZON_KINESIS_PRODUCER_SITE = $(call github,awslabs,amazon-kinesis-producer,v$(AMAZON_KINESIS_PRODUCER_VERSION))
AMAZON_KINESIS_PRODUCER_LICENSE = Apache-2.0
AMAZON_KINESIS_PRODUCER_LICENSE_FILES = LICENSE
AMAZON_KINESIS_PRODUCER_CPE_ID_VENDOR = amazon
AMAZON_KINESIS_PRODUCER_INSTALL_STAGING = YES

AMAZON_KINESIS_PRODUCER_DEPENDENCIES = \
	aws-sdk-cpp \
	boost \
	libcurl \
	libopenssl \
	protobuf \
	util-linux

# We manage our own dependencies
AMAZON_KINESIS_PRODUCER_CONF_OPTS = \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr" \
	-DBUILD_DEPENDENCIES=OFF \
	-DENABLE_ADDRESS_SANITIZER=ON \
	-DProtobuf_PROTOC_EXECUTABLE="$(HOST_DIR)/bin/protoc" \
	-DBUILD_TESTS=ON

$(eval $(cmake-package))
