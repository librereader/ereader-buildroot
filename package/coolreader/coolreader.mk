################################################################################
#
# coolreader
#
################################################################################

COOLREADER_VERSION = cr3.2.32
COOLREADER_SITE = git://github.com/buggins/coolreader.git
#$(call github,koreader,koreader,$(COOLREADER_VERSION))
COOLREADER_LICENSE = GPL-2.0
#COOLREADER_LICENSE_FILES = COPYING

COOLREADER_INSTALL_STAGING = YES
COOLREADER_INSTALL_TARGET = YES
COOLREADER_CONF_OPTS = -DLDFLAGS=-lintl -DGUI=QT5

COOLREADER_DEPENDENCIES = qt5base qt5tools

$(eval $(cmake-package))
