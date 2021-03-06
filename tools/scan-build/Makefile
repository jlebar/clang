##===- tools/scan-build/Makefile ---------------------------*- Makefile -*-===##
# 
#                     The LLVM Compiler Infrastructure
#
# This file is distributed under the University of Illinois Open Source
# License. See LICENSE.TXT for details.
# 
##===----------------------------------------------------------------------===##

CLANG_LEVEL := ../..

include $(CLANG_LEVEL)/../../Makefile.config
include $(CLANG_LEVEL)/Makefile

ifeq ($(HOST_OS),MingW)
  Suffix := .bat
endif

CLANG_INSTALL_SCANBUILD ?= 1

ifeq ($(CLANG_INSTALL_SCANBUILD), 1)
  InstallTargets := $(ToolDir)/scan-build$(Suffix) \
                    $(LibexecDir)/c++-analyzer$(Suffix) \
                    $(LibexecDir)/ccc-analyzer$(Suffix) \
                    $(ShareDir)/scan-build/scanview.css \
                    $(ShareDir)/scan-build/sorttable.js \
                    $(ShareDir)/man/man1/scan-build.1

  ifeq ($(HOST_OS),Darwin)
    InstallTargets := $(InstallTargets) $(ToolDir)/set-xcode-analyzer
  endif
endif

all:: $(InstallTargets)

$(ToolDir)/%: bin/% Makefile $(ToolDir)/.dir
	$(Echo) "Copying $(notdir $<) to the 'bin' directory..."
	$(Verb)cp $< $@
	$(Verb)chmod +x $@

$(LibexecDir)/%: libexec/% Makefile $(LibexecDir)/.dir
	$(Echo) "Copying $(notdir $<) to the 'libexec' directory..."
	$(Verb)cp $< $@
	$(Verb)chmod +x $@

$(ShareDir)/man/man1/%: man/% Makefile $(ShareDir)/man/man1/.dir
	$(Echo) "Copying $(notdir $<) to the 'man' directory..."
	$(Verb)cp $< $@

$(ShareDir)/scan-build/%: share/scan-build/% Makefile $(ShareDir)/scan-build/.dir
	$(Echo) "Copying $(notdir $<) to the 'share' directory..."
	$(Verb)cp $< $@

