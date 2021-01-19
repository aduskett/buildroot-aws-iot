################################################################################
#
# boost-1-69
#
################################################################################

BOOST_1_69_VERSION = 1.69.0
BOOST_1_69_SOURCE = boost_$(subst .,_,$(BOOST_1_69_VERSION)).tar.bz2
BOOST_1_69_SITE = http://downloads.sourceforge.net/project/boost/boost/$(BOOST_1_69_VERSION)
BOOST_1_69_INSTALL_STAGING = YES
BOOST_1_69_LICENSE = BSL-1.0
BOOST_1_69_LICENSE_FILES = LICENSE_1_0.txt
BOOST_1_69_CPE_ID_VENDOR = boost

# keep host variant as minimal as possible
HOST_BOOST_1_69_FLAGS = --without-icu --with-toolset=gcc \
	--without-libraries=$(subst $(space),$(comma),atomic chrono context \
	contract coroutine date_time exception filesystem graph graph_parallel \
	iostreams locale log math mpi program_options python random regex \
	serialization system test thread timer type_erasure wave)

BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_ATOMIC),,atomic)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_CHRONO),,chrono)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_CONTAINER),,container)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_CONTEXT),,context)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_CONTRACT),,contract)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_COROUTINE),,coroutine)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_DATE_TIME),,date_time)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_EXCEPTION),,exception)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_FIBER),,fiber)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_FILESYSTEM),,filesystem)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_GRAPH),,graph)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_GRAPH_PARALLEL),,graph_parallel)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_IOSTREAMS),,iostreams)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_LOCALE),,locale)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_LOG),,log)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_MATH),,math)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_MPI),,mpi)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_PROGRAM_OPTIONS),,program_options)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_PYTHON),,python)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_RANDOM),,random)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_REGEX),,regex)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_SERIALIZATION),,serialization)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_STACKTRACE),,stacktrace)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_SYSTEM),,system)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_TEST),,test)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_THREAD),,thread)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_TIMER),,timer)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_TYPE_ERASURE),,type_erasure)
BOOST_1_69_WITHOUT_FLAGS += $(if $(BR2_PACKAGE_BOOST_1_69_WAVE),,wave)

BOOST_1_69_TARGET_CXXFLAGS = $(TARGET_CXXFLAGS)

BOOST_1_69_FLAGS = --with-toolset=gcc

ifeq ($(BR2_PACKAGE_ICU),y)
BOOST_1_69_FLAGS += --with-icu=$(STAGING_DIR)/usr
BOOST_1_69_DEPENDENCIES += icu
else
BOOST_1_69_FLAGS += --without-icu
endif

ifeq ($(BR2_PACKAGE_BOOST_1_69_IOSTREAMS),y)
BOOST_1_69_DEPENDENCIES += bzip2 zlib
endif

ifeq ($(BR2_PACKAGE_BOOST_1_69_PYTHON),y)
BOOST_1_69_FLAGS += --with-python-root=$(HOST_DIR)
ifeq ($(BR2_PACKAGE_PYTHON3),y)
BOOST_1_69_FLAGS += --with-python=$(HOST_DIR)/bin/python$(PYTHON3_VERSION_MAJOR)
BOOST_1_69_TARGET_CXXFLAGS += -I$(STAGING_DIR)/usr/include/python$(PYTHON3_VERSION_MAJOR)m
BOOST_1_69_DEPENDENCIES += python3
else
BOOST_1_69_FLAGS += --with-python=$(HOST_DIR)/bin/python$(PYTHON_VERSION_MAJOR)
BOOST_1_69_TARGET_CXXFLAGS += -I$(STAGING_DIR)/usr/include/python$(PYTHON_VERSION_MAJOR)
BOOST_1_69_DEPENDENCIES += python
endif
endif

HOST_BOOST_1_69_OPTS += toolset=gcc threading=multi variant=release link=shared \
	runtime-link=shared

ifeq ($(BR2_MIPS_OABI32),y)
BOOST_1_69_ABI = o32
else ifeq ($(BR2_arm),y)
BOOST_1_69_ABI = aapcs
else
BOOST_1_69_ABI = sysv
endif

BOOST_1_69_OPTS += toolset=gcc \
	     threading=multi \
	     abi=$(BOOST_1_69_ABI) \
	     variant=$(if $(BR2_ENABLE_DEBUG),debug,release)

ifeq ($(BR2_sparc64),y)
BOOST_1_69_OPTS += architecture=sparc instruction-set=ultrasparc
endif

ifeq ($(BR2_sparc),y)
BOOST_1_69_OPTS += architecture=sparc instruction-set=v8
endif

# By default, Boost build and installs both the shared and static
# variants. Override that if we want static only or shared only.
ifeq ($(BR2_STATIC_LIBS),y)
BOOST_1_69_OPTS += link=static runtime-link=static
else ifeq ($(BR2_SHARED_LIBS),y)
BOOST_1_69_OPTS += link=shared runtime-link=shared
endif

ifeq ($(BR2_PACKAGE_BOOST_1_69_LOCALE),y)
ifeq ($(BR2_TOOLCHAIN_USES_UCLIBC),y)
# posix backend needs monetary.h which isn't available on uClibc
BOOST_1_69_OPTS += boost.locale.posix=off
endif

BOOST_1_69_DEPENDENCIES += $(if $(BR2_ENABLE_LOCALE),,libiconv)
endif

BOOST_1_69_WITHOUT_FLAGS_COMMASEPARATED += $(subst $(space),$(comma),$(strip $(BOOST_1_69_WITHOUT_FLAGS)))
BOOST_1_69_FLAGS += $(if $(BOOST_1_69_WITHOUT_FLAGS_COMMASEPARATED), --without-libraries=$(BOOST_1_69_WITHOUT_FLAGS_COMMASEPARATED))
BOOST_1_69_LAYOUT = $(call qstrip, $(BR2_PACKAGE_BOOST_1_69_LAYOUT))

# how verbose should the build be?
BOOST_1_69_OPTS += $(if $(QUIET),-d,-d+1)
HOST_BOOST_1_69_OPTS += $(if $(QUIET),-d,-d+1)

define BOOST_1_69_CONFIGURE_CMDS
	(cd $(@D) && ./bootstrap.sh $(BOOST_1_69_FLAGS))
	echo "using gcc : `$(TARGET_CC) -dumpversion` : $(TARGET_CXX) : <cxxflags>\"$(BOOST_1_69_TARGET_CXXFLAGS)\" <linkflags>\"$(TARGET_LDFLAGS)\" ;" > $(@D)/user-config.jam
	echo "" >> $(@D)/user-config.jam
endef

define BOOST_1_69_BUILD_CMDS
	(cd $(@D) && $(TARGET_MAKE_ENV) ./bjam -j$(PARALLEL_JOBS) -q \
	--user-config=$(@D)/user-config.jam \
	$(BOOST_1_69_OPTS) \
	--ignore-site-config \
	--layout=$(BOOST_1_69_LAYOUT))
endef

define BOOST_1_69_INSTALL_TARGET_CMDS
	(cd $(@D) && $(TARGET_MAKE_ENV) ./b2 -j$(PARALLEL_JOBS) -q \
	--user-config=$(@D)/user-config.jam \
	$(BOOST_1_69_OPTS) \
	--prefix=$(TARGET_DIR)/usr \
	--ignore-site-config \
	--layout=$(BOOST_1_69_LAYOUT) install )
endef

define BOOST_1_69_INSTALL_STAGING_CMDS
	(cd $(@D) && $(TARGET_MAKE_ENV) ./bjam -j$(PARALLEL_JOBS) -q \
	--user-config=$(@D)/user-config.jam \
	$(BOOST_1_69_OPTS) \
	--prefix=$(STAGING_DIR)/usr \
	--ignore-site-config \
	--layout=$(BOOST_1_69_LAYOUT) install)
endef

# These hooks will help us to detect missing select in Config.in
# Indeed boost buildsystem can select a library even if the user has
# disable it
define BOOST_1_69_REMOVE_TARGET_LIBRARIES
	rm -rf $(TARGET_DIR)/usr/lib/libboost_*
endef

BOOST_1_69_PRE_INSTALL_TARGET_HOOKS += BOOST_1_69_REMOVE_TARGET_LIBRARIES

define BOOST_1_69_CHECK_TARGET_LIBRARIES
	@$(foreach disabled,$(BOOST_1_69_WITHOUT_FLAGS),\
		! ls $(TARGET_DIR)/usr/lib/libboost_$(disabled)* 1>/dev/null 2>&1 || \
			! echo "libboost_$(disabled) shouldn't have been installed: missing select in boost/Config.in" || \
			exit 1;)
endef

BOOST_1_69_POST_INSTALL_TARGET_HOOKS += BOOST_1_69_CHECK_TARGET_LIBRARIES

define HOST_BOOST_1_69_CONFIGURE_CMDS
	(cd $(@D) && ./bootstrap.sh $(HOST_BOOST_1_69_FLAGS))
	echo "using gcc : `$(HOST_CC) -dumpversion` : $(HOSTCXX) : <cxxflags>\"$(HOST_CXXFLAGS)\" <linkflags>\"$(HOST_LDFLAGS)\" ;" > $(@D)/user-config.jam
	echo "" >> $(@D)/user-config.jam
endef

define HOST_BOOST_1_69_BUILD_CMDS
	(cd $(@D) && ./b2 -j$(PARALLEL_JOBS) -q \
	--user-config=$(@D)/user-config.jam \
	$(HOST_BOOST_1_69_OPTS) \
	--ignore-site-config \
	--prefix=$(HOST_DIR) )
endef

define HOST_BOOST_1_69_INSTALL_CMDS
	(cd $(@D) && ./b2 -j$(PARALLEL_JOBS) -q \
	--user-config=$(@D)/user-config.jam \
	$(HOST_BOOST_1_69_OPTS) \
	--prefix=$(HOST_DIR) \
	--ignore-site-config \
	--layout=$(BOOST_1_69_LAYOUT) install )
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
