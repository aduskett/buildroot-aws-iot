################################################################################
#
# aws-sdk-go
#
################################################################################

AWS_SDK_GO_VERSION = 1.44.13
AWS_SDK_GO_SITE = $(call github,aws,aws-sdk-go,v$(AWS_SDK_GO_VERSION))
AWS_SDK_GO_LICENSE = Apache-2.0
AWS_SDK_GO_LICENSE_FILES = LICENSE.txt
AWS_SDK_GO_CPE_ID_VENDOR = amazon
AWS_SDK_GO_INSTALL_STAGING = YES
AWS_SDK_GO_GO_ENV += GO111MODULE=off CGO_ENABLED=0 GOPATH=$(@D)/vendor

define AWS_SDK_GO_CONFIGURE_CMDS
	cd $(@D)/ && \
	GOROOT="$(HOST_GO_ROOT)" \
	GOPATH="$(HOST_GO_GOPATH)" \
	GOPROXY="direct" \
	$(GO_BIN) mod vendor -v -modcacherw;
	mkdir -p $(@D)/vendor/src/github.com/aws/; \
	ln -sf $(@D) $(@D)/vendor/src/github.com/aws/aws-sdk-go
endef

$(eval $(golang-package))
