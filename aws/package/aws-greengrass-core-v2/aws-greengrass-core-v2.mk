################################################################################
#
# aws-greengrass-core-v2
#
################################################################################

AWS_GREENGRASS_CORE_V2_VERSION = 2.5.5
AWS_GREENGRASS_CORE_V2_SOURCE = greengrass-$(AWS_GREENGRASS_CORE_V2_VERSION).zip
AWS_GREENGRASS_CORE_V2_SITE = https://d2s8p88vqu9w66.cloudfront.net/releases
AWS_GREENGRASS_CORE_V2_LICENSE = Apache-2.0
AWS_GREENGRASS_CORE_V2_CPE_ID_VENDOR = amazon
AWS_GREENGRASS_CORE_V2_LICENSE_FILES = LICENSE

AWS_GREENGRASS_CORE_V2_DEPENDENCIES = \
	amazon-corretto-bin \
	ca-certificates \
	ntp \
	sudo

define AWS_GREENGRASS_CORE_V2_EXTRACT_CMDS
	$(UNZIP) $(AWS_GREENGRASS_CORE_V2_DL_DIR)/$(AWS_GREENGRASS_CORE_V2_SOURCE) -d $(@D)
endef

# greengrassd expects everything to be installed udner a single directory.
# Amazon recommends /greengrass
# https://docs.aws.amazon.com/greengrass/v2/developerguide/install-greengrass-core-v2.html
define AWS_GREENGRASS_CORE_V2_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/greengrass/{config,alts}
	mkdir -p $(TARGET_DIR)/greengrass/alts/init/distro/{bin,conf,lib}

	$(INSTALL) -m 0640 $(AWS_GREENGRASS_CORE_V2_PKGDIR)/greengrassv2-init.yaml \
		$(TARGET_DIR)/greengrass/config/config.yaml

	$(SED) 's%posixUser:.*%posixUser: ggc_user%g' \
		$(TARGET_DIR)/greengrass/config/config.yaml

	$(INSTALL) -m 0640 $(@D)/bin/loader \
		$(TARGET_DIR)/greengrass/alts/init/distro/bin/loader

	$(INSTALL) -m 0640 $(@D)/conf/recipe.yaml \
		$(TARGET_DIR)/greengrass/alts/init/distro/conf/recipe.yam

	$(INSTALL) -m 0740 $(@D)/lib/Greengrass.jar \
		$(TARGET_DIR)/greengrass/alts/init/distro/lib/Greengrass.jar

	cd $(TARGET_DIR)/greengrass/alts && ln -sf init current

	$(INSTALL) -D -m 0440 $(AWS_GREENGRASS_CORE_V2_PKGDIR)/greengrass-users \
		$(TARGET_DIR)/etc/sudoers.d/greengrass-users

	$(SED) 's%CONFIG_FILE=.*%CONFIG_FILE="/greengrass/config/config.yaml"%g' \
		$(TARGET_DIR)/greengrass/alts/init/distro/bin/loader

endef

define AWS_GREENGRASS_CORE_V2_SET_HARDLINK_PROTECTION
	if ! grep -q "cgroup" $(TARGET_DIR)/etc/fstab; then \
			echo "cgroup /sys/fs/cgroup cgroup defaults  0  0" \
				>> $(TARGET_DIR)/etc/fstab; fi

	if ! grep -qs 'protected_hardlinks' $(TARGET_DIR)/etc/sysctl.conf; then \
		echo "fs.protected_hardlinks = 1" >> $(TARGET_DIR)/etc/sysctl.conf; fi

	if ! grep -qs 'protected_symlinks' $(TARGET_DIR)/etc/sysctl.conf; then \
		echo "fs.protected_symlinks = 1" >> $(TARGET_DIR)/etc/sysctl.conf; fi
endef
AWS_GREENGRASS_CORE_V2_TARGET_FINALIZE_HOOKS += AWS_GREENGRASS_CORE_V2_SET_HARDLINK_PROTECTION

define AWS_GREENGRASS_CORE_V2_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(@D)/bin/greengrass.service.template \
		$(TARGET_DIR)/usr/lib/systemd/system/greengrass.service
	$(SED) 's%REPLACE_WITH_GG_LOADER_FILE%/greengrass/alts/current/distro/bin/loader%g' \
		$(TARGET_DIR)/usr/lib/systemd/system/greengrass.service

	$(SED) 's%REPLACE_WITH_GG_LOADER_PID_FILE%/var/run/greengrass.pid%g' \
		$(TARGET_DIR)/usr/lib/systemd/system/greengrass.service
endef

define AWS_GREENGRASS_CORE_V2_INSTALL_INIT_SYSVS
	$(INSTALL) -D -m 755 $(AWS_GREENGRASS_CORE_V2_PKGDIR)/S42greengrass \
		$(TARGET_DIR)/etc/init.d/S42greengrass
	$(SED) 's%"useSystemd".*%"useSystemd": "no"%g' $(TARGET_DIR)/greengrass/config/config.json
endef

define AWS_GREENGRASS_CORE_V2_USERS
	ggc_user -1 ggc_group -1 * - - - ggc_user
endef

# From: https://docs.aws.amazon.com/greengrass/v2/developerguide/install-greengrass-core-v2.html
define AWS_GREENGRASS_CORE_V2_LINUX_CONFIG_FIXUPS
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
	$(call KCONFIG_ENABLE_OPT,CONFIG_SHMEM)
	$(call KCONFIG_ENABLE_OPT,CONFIG_SECCOMP)
	$(call KCONFIG_ENABLE_OPT,CONFIG_SECCOMP_FILTER)
	$(call KCONFIG_ENABLE_OPT,CONFIG_USER_NS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_UTS_NS)
endef

$(eval $(generic-package))
