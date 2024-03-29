################################################################################
#
# aws-crt-python
#
################################################################################

AWS_CRT_PYTHON_VERSION = 0.13.11
AWS_CRT_PYTHON_SITE = $(call github,awslabs,aws-crt-python,v$(AWS_CRT_PYTHON_VERSION))
AWS_CRT_PYTHON_LICENSE = Apache-2.0
AWS_CRT_PYTHON_LICENSE_FILES = LICENSE
AWS_CRT_PYTHON_CPE_ID_VENDOR = amazon
AWS_CRT_PYTHON_INSTALL_STAGING = YES
AWS_CRT_PYTHON_SETUP_TYPE = setuptools
AWS_CRT_PYTHON_DEPENDENCIES = \
	host-python-setuptools-scm \
	host-cmake \
	aws-c-auth \
	aws-c-cal \
	aws-c-common \
	aws-c-compression \
	aws-c-event-stream \
	aws-checksums \
	aws-c-http \
	aws-c-io \
	aws-c-mqtt \
	aws-c-s3 \
	aws-lc \
	s2n

# Prevent errors about the deprecated functions
# PyEval_ThreadsInitialized and PyEval_InitThreads
AWS_CRT_PYTHON_ENV += \
	CFLAGS="-Wno-error=deprecated-declarations" \
	SKIP_BUILDING_DEPENDENCIES=True

ifeq ($(BR2_SHARED_LIBS),y)
AWS_CRT_PYTHON_ENV += SHARED_LIBS=True
endif

$(eval $(python-package))
