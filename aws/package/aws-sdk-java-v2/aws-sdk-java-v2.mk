################################################################################
#
# aws-sdk-java-v2
#
################################################################################

AWS_SDK_JAVA_V2_VERSION = 2.17.70
AWS_SDK_JAVA_V2_SITE = $(call github,aws,aws-sdk-java-v2,$(AWS_SDK_JAVA_V2_VERSION))
AWS_SDK_JAVA_V2_LICENSE = Apache-2.0
AWS_SDK_JAVA_V2_LICENSE_FILES = LICENSE.txt
AWS_SDK_JAVA_V2_CPE_ID_VENDOR = amazon
AWS_SDK_JAVA_V2_INSTALL_STAGING = YES

AWS_SDK_JAVA_V2_DEPENDENCIES = \
	host-maven-bin \
	amazon-corretto-bin

define AWS_SDK_JAVA_V2_BUILD_CMDS
	cd $(@D)/ && $(MAVEN) install -P quick
endef

$(eval $(generic-package))
