################################################################################
#
# host-maven-bin
#
################################################################################

HOST_MAVEN_BIN_VERSION = 3.8.5
HOST_MAVEN_BIN_SOURCE = apache-maven-$(HOST_MAVEN_BIN_VERSION)-bin.tar.gz
HOST_MAVEN_BIN_SITE = https://dlcdn.apache.org/maven/maven-3/$(HOST_MAVEN_BIN_VERSION)/binaries
HOST_MAVEN_BIN_LICENSE = Apache-2.0
HOST_MAVEN_BIN_LICENSE_FILES = LICENSE

ifeq ($(BR2_OPENJDK),y)
HOST_MAVEN_BIN_DEPENDENCIES = host-openjdk-bin
HOST_MAVEN_BIN_JAVA_HOME="$(HOST_DIR)/usr/lib/jvm/"
endif

ifeq ($(BR2_PACKAGE_AMAZON_CORRETTO_BIN),y)
HOST_MAVEN_BIN_DEPENDENCIES = host-amazon-corretto-bin
HOST_MAVEN_BIN_JAVA_HOME="$(HOST_DIR)/usr/lib/jvm/amazon-corretto-$(AMAZON_CORRETTO_BIN_VERSION)"
endif

# Maven is traditionally installed in it's own seperate directory in either
# usr/share/maven or /usr/lib/maven with the mvn binary symlinked to /usr/bin.
define HOST_MAVEN_BIN_INSTALL_CMDS
	mkdir -p $(HOST_DIR)/usr/lib/maven
	mkdir -p $(HOST_DIR)/bin
	cp -dprf $(@D)/* $(HOST_DIR)/usr/lib/maven/
	ln -sf $(HOST_DIR)/usr/lib/maven/bin/mvn $(HOST_DIR)/bin/mvn

# The settings.xml file set's the localRepository directory to the
# MAVEN_REPO_DIR environment variable.
	$(INSTALL) -D -m 755 $(HOST_MAVEN_BIN_PKGDIR)/settings.xml \
		$(HOST_DIR)/usr/lib/maven/conf/settings.xml
endef

$(eval $(host-generic-package))

# variables used by other packages
MAVEN = \
	JAVA_HOME=$(HOST_MAVEN_BIN_JAVA_HOME) \
	M2_HOME="$(HOST_DIR)/usr/lib/maven" \
	MAVEN_HOME="$(HOST_DIR)/usr/lib/maven" \
	MAVEN_REPO_DIR=$(BR2_DL_DIR)/maven-repo \
	$(HOST_DIR)/bin/mvn
