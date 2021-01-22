################################################################################
#
# amazon-ssm-agent
#
################################################################################

AMAZON_SSM_AGENT_VERSION = 3.0.603.0
AMAZON_SSM_AGENT_SITE = $(call github,aws,amazon-ssm-agent,$(AMAZON_SSM_AGENT_VERSION))
AMAZON_SSM_AGENT_LICENSE = Apache-2.0
AMAZON_SSM_AGENT_LICENSE_FILES = LICENSE
AMAZON_SSM_AGENT_CPE_ID_VENDOR = amazon

AMAZON_SSM_AGENT_DEPENDENCIES = sudo

AMAZON_SSM_AGENT_BUILD_CMD = \
	$(HOST_GO_TARGET_ENV) \
	GO111MODULE=off \
	GOFLAGS="-mod=vendor -modcacherw" \
	GOPATH=$(@D)/build/private:$(@D)/vendor \
	CGO_ENABLED=0 \
	$(GO_BIN) build \
	-ldflags "-s -w -extldflags=-Wl,-z,now,-z,relro,-z,defs" \
	-buildmode=pie

define AMAZON_SSM_AGENT_SYMLINK_FIXUP
	ln -sf $(@D) $(@D)/vendor/src/github.com/aws/amazon-ssm-agent
endef
AMAZON_SSM_AGENT_PRE_CONFIGURE_HOOKS += AMAZON_SSM_AGENT_SYMLINK_FIXUP

# Taken from amazon-ssm-agent.spec
define AMAZON_SSM_AGENT_BUILD_CMDS
	cd $(@D); \
	$(AMAZON_SSM_AGENT_BUILD_CMD) -o bin/amazon-ssm-agent -v \
		core/agent.go core/agent_unix.go core/agent_parser.go && \
	$(AMAZON_SSM_AGENT_BUILD_CMD) -o bin/ssm-agent-worker -v \
		agent/agent.go agent/agent_unix.go agent/agent_parser.go && \
	$(AMAZON_SSM_AGENT_BUILD_CMD) -o bin/ssm-document-worker -v \
		agent/framework/processor/executer/outofproc/worker/main.go && \
	$(AMAZON_SSM_AGENT_BUILD_CMD) -o bin/ssm-session-worker -v \
		agent/framework/processor/executer/outofproc/sessionworker/main.go && \
	$(AMAZON_SSM_AGENT_BUILD_CMD) -o bin/ssm-session-logger -v \
		agent/session/logging/main.go && \
	$(AMAZON_SSM_AGENT_BUILD_CMD) -o bin/ssm-cli -v \
		agent/cli-main/cli-main.go
endef

define AMAZON_SSM_AGENT_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/etc/amazon/ssm/ \
		$(TARGET_DIR)/etc/sudoers.d/ \
		$(TARGET_DIR)/usr/bin/ \
		$(TARGET_DIR)/var/lib/amazon/ssm/ \
		$(TARGET_DIR)/var/log/amazon/ssm/;

	$(INSTALL) -D -m 0755 $(@D)/bin/amazon-ssm-agent \
		$(TARGET_DIR)/usr/bin/amazon-ssm-agent

	$(INSTALL) -D -m 0755 $(@D)/bin/ssm-agent-worker \
		$(TARGET_DIR)/usr/bin/ssm-agent-worker

	$(INSTALL) -D -m 0755 $(@D)/bin/ssm-document-worker \
		$(TARGET_DIR)/usr/bin/ssm-document-worker

	$(INSTALL) -D -m 0755 $(@D)/bin/ssm-session-worker \
		$(TARGET_DIR)/usr/bin/ssm-session-worker

	$(INSTALL) -D -m 0755 $(@D)/bin/ssm-session-logger \
		$(TARGET_DIR)/usr/bin/ssm-session-logger

	$(INSTALL) -D -m 0755 $(@D)/bin/ssm-cli \
		$(TARGET_DIR)/usr/bin/ssm-cli

	$(INSTALL) -D -m 0440 $(AMAZON_SSM_AGENT_PKGDIR)/ssm-agent-users \
		$(TARGET_DIR)/etc/sudoers.d/ssm-agent-users
endef

define AMAZON_SSM_AGENT_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(@D)/packaging/linux/amazon-ssm-agent.service \
		$(TARGET_DIR)/usr/lib/systemd/system/amazon-ssm-agent.service
endef

define AMAZON_SSM_AGENT_CORE_USERS
	ssm-user -1 ssm-user -1 * - - - ssm-user
endef

$(eval $(golang-package))
