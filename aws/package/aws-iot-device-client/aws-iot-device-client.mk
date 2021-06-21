################################################################################
#
# aws-iot-device-client
#
################################################################################

AWS_IOT_DEVICE_CLIENT_VERSION = 1.2
AWS_IOT_DEVICE_CLIENT_SITE = $(call github,awslabs,aws-iot-device-client,v$(AWS_IOT_DEVICE_CLIENT_VERSION))
AWS_IOT_DEVICE_CLIENT_LICENSE = Apache-2.0
AWS_IOT_DEVICE_CLIENT_LICENSE_FILES = LICENSE
AWS_IOT_DEVICE_CLIENT_CPE_ID_VENDOR = amazon
AWS_IOT_DEVICE_CLIENT_DEPENDENCIES = aws-iot-device-sdk-cpp-v2 openssl

AWS_IOT_DEVICE_CLIENT_CONF_OPTS += \
	-DBUILD_TEST_DEPS=OFF \
	-DBUILD_SDK=OFF \
	-DEXCLUDE_DD=OFF \
	-DEXCLUDE_ST=OFF \
	-DEXCLUDE_FP=OFF \
	-DEXCLUDE_JOBS=OFF \
	-DEXCLUDE_SAMPLES=ON \
	-DEXCLUDE_PUBSUB=ON \
	-DGIT_VERSION=OFF

define AWS_IOT_DEVICE_CLIENT_ADD_VERSION
	$(SED) s%"DEVICE_CLIENT_VERSION_FULL.*"%"DEVICE_CLIENT_VERSION_FULL $(AWS_IOT_DEVICE_CLIENT_VERSION)"%g \
		$(@D)/Version.h
endef
AWS_IOT_DEVICE_CLIENT_POST_CONFIGURE_HOOKS += AWS_IOT_DEVICE_CLIENT_ADD_VERSION

define AWS_IOT_DEVICE_CLIENT_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/aws-iot-device-client \
		$(TARGET_DIR)/sbin/aws-iot-device-client
	$(INSTALL) -D -m 0644 $(@D)/config-template.json \
		$(TARGET_DIR)/etc/config-template.json
endef

define AWS_IOT_DEVICE_CLIENT_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(@D)/setup/aws-iot-device-client.service \
		$(TARGET_DIR)/usr/lib/systemd/system//aws-iot-device-client.service
	$(SED) s%"/sbin/aws-iot-device-client"%"/sbin/aws-iot-device-client --config /etc/aws-iot-device-client.json"%g \
		$(TARGET_DIR)/usr/lib/systemd/system//aws-iot-device-client.service
endef

$(eval $(cmake-package))
