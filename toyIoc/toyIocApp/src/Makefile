TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Use typed rset structure (see 3.16.1 release notes)
USR_CPPFLAGS += -DUSE_TYPED_RSET

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord

# Install xxxSupport.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Build an IOC support library
LIBRARY_IOC += toyIocSupport

# Compile and add code to the support library
toyIocSupport_SRCS += xxxRecord.c
toyIocSupport_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application, that
# causes problems on Windows DLL builds
toyIocSupport_SRCS += dbSubExample.c
toyIocSupport_SRCS += devtoyIocVersion.c
toyIocSupport_SRCS += toyIocHello.c
toyIocSupport_SRCS += initTrace.c

toyIocSupport_LIBS += $(EPICS_BASE_IOC_LIBS)

# Auto-generate a header file containing a version string.
# Version comes from the VCS if available, else date+time.
GENVERSION = toyIocVersion.h
# Macro name
GENVERSIONMACRO = toyIocVERSION

# Build the IOC application
PROD_IOC = toyIoc

# toyIoc.dbd will be created and installed
DBD += toyIoc.dbd

# toyIoc.dbd will include these files:
toyIoc_DBD += base.dbd
toyIoc_DBD += xxxSupport.dbd
toyIoc_DBD += dbSubExample.dbd
toyIoc_DBD += devtoyIocVersion.dbd
toyIoc_DBD += toyIocHello.dbd
toyIoc_DBD += initTrace.dbd

# toyIoc_registerRecordDeviceDriver.cpp derives from toyIoc.dbd
toyIoc_SRCS += toyIoc_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
toyIoc_SRCS_DEFAULT += toyIocMain.cpp
toyIoc_SRCS_vxWorks += -nil-

# Link in the code from our support library
toyIoc_LIBS += toyIocSupport

# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncExample into toyIocSupport
    sncExample_SNCFLAGS += +r
    toyIoc_DBD += sncExample.dbd
    # A .stt sequence program is *not* pre-processed:
    toyIocSupport_SRCS += sncExample.stt
    toyIocSupport_LIBS += seq pv
    toyIoc_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    # A .st sequence program *is* pre-processed:
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Link QSRV (pvAccess Server) if available
ifdef EPICS_QSRV_MAJOR_VERSION
    toyIoc_LIBS += qsrv
    toyIoc_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
    toyIoc_DBD += PVAServerRegister.dbd
    toyIoc_DBD += qsrv.dbd
endif

# Finally link IOC to the EPICS Base libraries
toyIoc_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

# Explicit dependency needed for generated header file
devtoyIocVersion$(DEP): $(COMMON_DIR)/$(GENVERSION)
