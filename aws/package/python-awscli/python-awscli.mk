################################################################################
#
# python-awscli
#
################################################################################

PYTHON_AWSCLI_VERSION = 1.21.10
PYTHON_AWSCLI_SOURCE = awscli-$(PYTHON_AWSCLI_VERSION).tar.gz
PYTHON_AWSCLI_SITE = https://files.pythonhosted.org/packages/b8/e2/af43a0ffaee068ebfa64fd835c2bb8a5412ea51f9874497140f7267cd13b
PYTHON_AWSCLI_SETUP_TYPE = setuptools
PYTHON_AWSCLI_LICENSE = Apache-2.0
PYTHON_AWSCLI_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
