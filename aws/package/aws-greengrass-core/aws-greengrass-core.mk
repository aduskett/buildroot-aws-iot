################################################################################
#
# aws-greengrass-core
#
################################################################################

AWS_GREENGRASS_CORE_VERSION = 1.11.6
AWS_GREENGRASS_CORE_ARCH = $(call qstrip,$(BR2_PACKAGE_AWS_GREENGRASS_CORE_ARCH))
AWS_GREENGRASS_CORE_SOURCE = greengrass-linux-$(AWS_GREENGRASS_CORE_ARCH)-$(AWS_GREENGRASS_CORE_VERSION).tar.gz
AWS_GREENGRASS_CORE_SITE = https://d1onfpft10uf5o.cloudfront.net/greengrass-core/downloads/$(AWS_GREENGRASS_CORE_VERSION)
AWS_GREENGRASS_CORE_LICENSE = MIT
AWS_GREENGRASS_CORE_CPE_ID_VENDOR = amazon
AWS_GREENGRASS_CORE_LICENSE_FILES = ggc/packages/$(AWS_GREENGRASS_CORE_VERSION)/LICENSE
AWS_GREENGRASS_CORE_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_AWS_GREENGRASS_CORE_OTA_AGENT),y)
AWS_GREENGRASS_CORE_DEPENDENCIES += \
	bash \
	ca-certificates \
	coreutils \
	findutils \
	grep \
	gzip \
	openssl \
	procps-ng \
	tar \
	util-linux \
	wget

define AWS_GREENGRASS_CORE_INSTALL_OTA_AGENT
	mkdir -p $(TARGET_DIR)/greengrass/ota
	cp -dprf $(@D)/ota/* $(TARGET_DIR)/greengrass/ota/
endef
AWS_GREENGRASS_CORE_POST_INSTALL_TARGET_HOOKS += AWS_GREENGRASS_CORE_INSTALL_OTA_AGENT
endif

ifeq ($(BR2_PACKAGE_AWS_GREENGRASS_CORE_STREAM_MANAGER),y)
AWS_GREENGRASS_CORE_DEPENDENCIES += amazon-corretto-bin
else
define AWS_GREENGRASS_CORE_REMOVE_JAR_FILES
	find $(TARGET_DIR)/greengrass \( -iname "*.jar" \) -delete
endef
AWS_GREENGRASS_CORE_TARGET_FINALIZE_HOOKS += AWS_GREENGRASS_CORE_REMOVE_JAR_FILES
endif

# greengrassd expects everything to be installed udner a single directory.
# Amazon recommends /greengrass
# https://docs.aws.amazon.com/greengrass/latest/developerguide/what-is-gg.html
define AWS_GREENGRASS_CORE_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/greengrass/{config,ggc}
	cp -dprf $(@D)/config/* $(TARGET_DIR)/greengrass/config/

	mkdir -p $(TARGET_DIR)/greengrass/ggc/packages/$(AWS_GREENGRASS_CORE_VERSION)
	cp -dprf $(@D)/ggc/* $(TARGET_DIR)/greengrass/ggc/
endef

define AWS_GREENGRASS_CORE_SET_HARDLINK_PROTECTION
	if ! grep -q "cgroup" $(TARGET_DIR)/etc/fstab; then \
			echo "cgroup /sys/fs/cgroup cgroup defaults  0  0" \
				>> $(TARGET_DIR)/etc/fstab; fi

	if ! grep -qs 'protected_hardlinks' $(TARGET_DIR)/etc/sysctl.conf; then \
		echo "fs.protected_hardlinks = 1" >> $(TARGET_DIR)/etc/sysctl.conf; fi

	if ! grep -qs 'protected_symlinks' $(TARGET_DIR)/etc/sysctl.conf; then \
		echo "fs.protected_symlinks = 1" >> $(TARGET_DIR)/etc/sysctl.conf; fi
endef
AWS_GREENGRASS_CORE_TARGET_FINALIZE_HOOKS += AWS_GREENGRASS_CORE_SET_HARDLINK_PROTECTION

define AWS_GREENGRASS_CORE_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(AWS_GREENGRASS_CORE_PKGDIR)/greengrass.service \
		$(TARGET_DIR)/usr/lib/systemd/system/greengrass.service
	$(SED) 's%"useSystemd".*%"useSystemd": "yes"%g' $(TARGET_DIR)/greengrass/config/config.json
endef

define AWS_GREENGRASS_CORE_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 755 $(AWS_GREENGRASS_CORE_PKGDIR)/S42greengrass \
		$(TARGET_DIR)/etc/init.d/S42greengrass
	$(SED) 's%"useSystemd".*%"useSystemd": "no"%g' $(TARGET_DIR)/greengrass/config/config.json
endef

define AWS_GREENGRASS_CORE_USERS
	ggc_user -1 ggc_group -1 * - - - ggc_user
endef

# From: https://docs.aws.amazon.com/greengrass/latest/developerguide/what-is-gg.html
define AWS_GREENGRASS_CORE_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_CGROUP_DEVICE)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CGROUP_FREEZER)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CGROUP_PIDS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CGROUPS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_DEVPTS_MULTIPLE_INSTANCES)
	$(call KCONFIG_ENABLE_OPT,CONFIG_HAVE_ARCH_SECCOMP_FILTER)
	$(call KCONFIG_ENABLE_OPT,CONFIG_IPC_NS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_KEYS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_MEMCG)
	$(call KCONFIG_ENABLE_OPT,CONFIG_MULTIUSER)
	$(call KCONFIG_ENABLE_OPT,CONFIG_NAMESPACES)
	$(call KCONFIG_ENABLE_OPT,CONFIG_NET_NS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_OF_OVERLAY)
	$(call KCONFIG_ENABLE_OPT,CONFIG_OVERLAY_FS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_PID_NS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_POSIX_MQUEUE)
	$(call KCONFIG_ENABLE_OPT,CONFIG_SECCOMP)
	$(call KCONFIG_ENABLE_OPT,CONFIG_SECCOMP_FILTER)
	$(call KCONFIG_ENABLE_OPT,CONFIG_USER_NS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_UTS_NS)
endef

$(eval $(generic-package))
