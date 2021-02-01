################################################################################
#
# aws-iot-device-sdk-python-v2
#
################################################################################

AWS_IOT_DEVICE_SDK_PYTHON_V2_VERSION = 1.5.2
AWS_IOT_DEVICE_SDK_PYTHON_V2_SITE = $(call github,aws,aws-iot-device-sdk-python-v2,v$(AWS_IOT_DEVICE_SDK_PYTHON_V2_VERSION))
AWS_IOT_DEVICE_SDK_PYTHON_V2_LICENSE = Apache-2.0
AWS_IOT_DEVICE_SDK_PYTHON_V2_LICENSE_FILES = LICENSE
AWS_IOT_DEVICE_SDK_PYTHON_V2_CPE_ID_VENDOR = amazon
AWS_IOT_DEVICE_SDK_PYTHON_V2_INSTALL_STAGING = YES
AWS_IOT_DEVICE_SDK_PYTHON_V2_SETUP_TYPE = setuptools
AWS_IOT_DEVICE_SDK_PYTHON_V2_DEPENDENCIES = aws-crt-python

$(eval $(python-package))
