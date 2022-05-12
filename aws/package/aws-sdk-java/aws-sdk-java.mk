################################################################################
#
# aws-sdk-java
#
################################################################################

AWS_SDK_JAVA_VERSION = 1.12.219
AWS_SDK_JAVA_SITE = $(call github,aws,aws-sdk-java,$(AWS_SDK_JAVA_VERSION))
AWS_SDK_JAVA_LICENSE = Apache-2.0
AWS_SDK_JAVA_LICENSE_FILES = LICENSE.txt
AWS_SDK_JAVA_CPE_ID_VENDOR = amazon
AWS_SDK_JAVA_INSTALL_STAGING = YES

AWS_SDK_JAVA_DEPENDENCIES = \
	host-maven-bin \
	amazon-corretto-bin

define AWS_SDK_JAVA_BUILD_CMDS
	cd $(@D)/ && $(MAVEN) install -P quick
endef

$(eval $(generic-package))
