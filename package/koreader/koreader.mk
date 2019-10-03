################################################################################
#
# koreader
#
################################################################################

KOREADER_VERSION = v2019.09.3
KOREADER_SITE = git://github.com/koreader/koreader.git
#$(call github,koreader,koreader,$(KOREADER_VERSION))
KOREADER_LICENSE = AGPL-3.0
KOREADER_LICENSE_FILES = COPYING
KOREADER_GIT_SUBMODULES = YES

define KOREADER_BUILD_CMDS
$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) CHOST=$(notdir $(TARGET_CROSS:-=)) USE_MAKE=YES TARGET=kobo koboupdate
endef

$(eval $(generic-package))
