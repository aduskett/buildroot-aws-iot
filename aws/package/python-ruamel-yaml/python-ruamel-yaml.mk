################################################################################
#
# python-ruamel-yaml
#
################################################################################

PYTHON_RUAMEL_YAML_VERSION = 0.17.17
PYTHON_RUAMEL_YAML_SOURCE = ruamel.yaml-$(PYTHON_RUAMEL_YAML_VERSION).tar.gz
PYTHON_RUAMEL_YAML_SITE = https://files.pythonhosted.org/packages/4d/15/7fc04de02ca774342800c9adf1a8239703977c49c5deaadec1689ec85506
PYTHON_RUAMEL_YAML_SETUP_TYPE = setuptools
PYTHON_RUAMEL_YAML_LICENSE = Apache-2.0
PYTHON_RUAMEL_YAML_LICENSE_FILES = LICENSE

$(eval $(python-package))
