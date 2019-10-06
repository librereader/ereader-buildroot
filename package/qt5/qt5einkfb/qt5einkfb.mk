################################################################################
#
# qt5quickcontrols2
#
################################################################################

QT5EINKFB_VERSION = ea0fdd413c36404b27d1d657e088bb297f770676
QT5EINKFB_SITE = git://github.com/jdek/qpa-einkfb.git
QT5EINKFB_DEPENDENCIES = qt5base
QT5EINKFB_INSTALL_STAGING = YES

QT5EINKFB_LICENSE = GPL-3.0 or LGPL-3.0, GFDL-1.3 (docs)
QT5EINKFB_LICENSE_FILES = LICENSE.GPLv3 LICENSE.LGPLv3 LICENSE.FDL

define QT5EINKFB_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_MAKE_ENV) $(HOST_DIR)/bin/qmake)
endef

define QT5EINKFB_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QT5EINKFB_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) install
endef

# cp -dpfr $(STAGING_DIR)/usr/lib/qt/plugins/einkfb* $(TARGET_DIR)/usr/lib/qt/plugins
define QT5EINKFB_INSTALL_TARGET_CMDS
	cp -dpfr $(STAGING_DIR)/usr/lib/qt/plugins/platforms/libqeinkfb* $(TARGET_DIR)/usr/lib/qt/plugins/platforms/
endef

$(eval $(generic-package))
