.PHONY: default
default: all

CROSSDIR     = $(HOME)/kobo/buildroot-2019.02.5/output/host/
TRIPLE       = arm-buildroot-linux-musleabihf

CC           = $(CROSSDIR)/bin/$(TRIPLE)-gcc
CXX          = $(CROSSDIR)/bin/$(TRIPLE)-g++
STRIP        = $(CROSSDIR)/bin/$(TRIPLE)-strip
AR           = $(CROSSDIR)/bin/$(TRIPLE)-ar

CFLAGS       = -mno-unaligned-access -std=c11
CXXFLAGS     = -mno-unaligned-access -std=c++11
CPPFLAGS     = -Iocher \
               -Isubprojects/Signals/ -Isubprojects/json \
	       -I$(SYSROOT)/usr/include/freetype2 \
	       -I$(SYSROOT)/usr/include

SYSROOT      = $(CROSSDIR)/$(TRIPLE)/sysroot

SRCDIR       = ocher
OBJDIR       = build

SRCS         = Container.cpp \
               device/Battery.cpp device/Device.cpp device/Filesystem.cpp \
               fmt/Format.cpp fmt/Layout.cpp \
               fmt/minizip/ioapi.c fmt/minizip/unzip.c \
               fmt/text/LayoutText.cpp fmt/text/Text.cpp \
               resources/Bitmaps.cpp settings/Settings.cpp \
               shelf/Meta.cpp shelf/Shelf.cpp \
               util/Debug.cpp util/DirIter.cpp util/File.cpp \
               util/LogAppenderFile.cpp util/LogAppenders.cpp util/Logger.cpp \
               util/Path.cpp util/StrUtil.cpp util/time.cpp \
               ux/Activity.cpp ux/Controller.cpp ux/Event.cpp \
               ux/Pagination.cpp ux/PowerSaver.cpp ux/Renderer.cpp \

SRCS        += ux/fb/BatteryIcon.cpp ux/fb/bitmap.cpp \
               ux/fb/BootActivityFb.cpp ux/fb/ClockIcon.cpp \
               ux/fb/fontcontext.cpp ux/fb/FontEngine.cpp \
               ux/fb/FrameBuffer.cpp ux/fb/HomeActivityFb.cpp \
               ux/fb/JPEG.cpp ux/fb/LibraryActivityFb.cpp \
               ux/fb/NavBar.cpp ux/fb/ReadActivityFb.cpp \
               ux/fb/RendererFb.cpp ux/fb/SettingsActivityFb.cpp \
               ux/fb/SleepActivityFb.cpp ux/fb/SyncActivityFb.cpp \
               ux/fb/SystemBar.cpp ux/fb/UxControllerFb.cpp \
               ux/fb/Widgets.cpp
CPPFLAGS    += -DUX_FB

SRCS        += ux/fb/FbLinux.cpp
CPPFLAGS    += -DUX_FB_LINUX

SRCS        += ux/fb/mx50/FrameBufferMx50.cpp device/kobo/KoboEvents.cpp \
               device/ntx.cpp
CPPFLAGS    += -DOCHER_TARGET_KOBO -DUX_FB_MX50

SRCS        += fmt/epub/LayoutEpub.cpp fmt/epub/UnzipCache.cpp \
               fmt/epub/Epub.cpp
CPPFLAGS    += -DFMT_EPUB

SRCS        += ux/fb/JPEG.cpp
CPPFLAGS    += -DFMT_JPEG

# NOP(?)
CPPFLAGS += -DFMT_PNG

SRCS        := $(addprefix $(SRCDIR)/, $(SRCS))
OBJS         = $(SRCS:%=$(OBJDIR)/%.o)
DEPS         = $(SRCS:%=$(OBJDIR)/%.d)

CPPFLAGS    := $(CPPFLAGS) -I$(OBJDIR)

#-include $(OBJDIR)/Makefile.dep

$(OBJDIR)/Makefile.dep: $(DEPS)
	@mkdir -p $(dir $(@))
	@cat $^ > $@

$(OBJDIR)/%.d: %
	@mkdir -p $(dir $(@))
	@$(CXX) $(CXXFLAGS) $(CPPFLAGS) -MG -MM $^ -MF $@ -MQ $(subst .d,.o,$@)

$(OBJDIR)/%.c.o: %.c
	@mkdir -p $(dir $(@))
	$(CC) $(CFLAGS) $(CPPFLAGS) -g -c -o $@ $<

$(OBJDIR)/%.cpp.o: %.cpp
	@mkdir -p $(dir $(@))
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -g -c -o $@ $<

$(OBJDIR)/libocher.a: $(OBJDIR)/ocher_config.h $(OBJS)
	$(AR) rcs $@ $^

$(OBJDIR)/%: $(OBJDIR)/%_g
	$(STRIP) -o $@ $<

$(OBJDIR)/ocher_config.h:
	touch $@

$(OBJDIR)/kocher_g: ocher/ocher.cpp $(OBJDIR)/libocher.a
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -o $@ $^ \
	-L$(SYSROOT)/lib -lmxml -lev -lz -lfreetype

all: $(OBJDIR)/kocher

.PHONY: clean
clean:
	rm -rf obj
