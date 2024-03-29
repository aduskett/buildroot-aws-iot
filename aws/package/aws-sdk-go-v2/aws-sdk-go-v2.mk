################################################################################
#
# aws-sdk-go-v2
#
################################################################################

AWS_SDK_GO_V2_VERSION = 2022-05-12
AWS_SDK_GO_V2_SOURCE = release-$(AWS_SDK_GO_V2_VERSION).tar.gz
AWS_SDK_GO_V2_SITE = https://github.com/aws/aws-sdk-go-v2/archive/refs/tags
AWS_SDK_GO_V2_LICENSE = Apache-2.0
AWS_SDK_GO_V2_LICENSE_FILES = LICENSE.txt
AWS_SDK_GO_V2_CPE_ID_VENDOR = amazon
AWS_SDK_GO_V2_INSTALL_STAGING = YES
AWS_SDK_GO_V2_GO_ENV += GO111MODULE=off CGO_ENABLED=0 GOPATH=$(@D)/vendor

define AWS_SDK_GO_V2_CONFIGURE_CMDS
	cd $(@D)/ && \
	GOROOT="$(HOST_GO_ROOT)" \
	GOPATH="$(HOST_GO_GOPATH)" \
	GOPROXY="direct" \
	$(GO_BIN) mod vendor -v -modcacherw;
	mkdir -p $(@D)/vendor/src/github.com/aws/; \
	ln -sf $(@D) $(@D)/vendor/src/github.com/aws/aws-sdk-go-v2
endef

$(eval $(golang-package))
