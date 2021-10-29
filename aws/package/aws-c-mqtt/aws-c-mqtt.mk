################################################################################
#
# aws-c-mqtt
#
################################################################################

AWS_C_MQTT_VERSION = 0.7.6
AWS_C_MQTT_SITE = $(call github,awslabs,aws-c-mqtt,v$(AWS_C_MQTT_VERSION))
AWS_C_MQTT_LICENSE = Apache-2.0
AWS_C_MQTT_LICENSE_FILES = LICENSE
AWS_C_MQTT_CPE_ID_VENDOR = amazon
AWS_C_MQTT_INSTALL_STAGING = YES
AWS_C_MQTT_DEPENDENCIES += \
	aws-c-http \
	aws-c-io

ifeq ($(BR2_PACKAGE_AWS_C_MQTT_WEBSOCKETS),y)
AWS_C_MQTT_CONF_OPTS += -DMQTT_WITH_WEBSOCKETS=ON
else
AWS_C_MQTT_CONF_OPTS += -DMQTT_WITH_WEBSOCKETS=OFF
endif

AWS_C_MQTT_CONF_OPTS += \
	-DCMAKE_PREFIX_PATH="$(STAGING_DIR)/usr"

define AWS_C_MQTT_REMOVE_EMPTY_DIRECTORIES
	find $(TARGET_DIR)/usr/lib/ -type d -name aws-c-mqtt -exec rm -rf {} +;
endef
AWS_C_MQTT_TARGET_FINALIZE_HOOKS += AWS_C_MQTT_REMOVE_EMPTY_DIRECTORIES

$(eval $(cmake-package))
