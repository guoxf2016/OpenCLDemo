LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

# To allow building native part of application with OpenCL,
# OpenCL header files and statically linked library are required.
# They are used from Intel OpenCL SDK installation directories,
# that are determined below: 

ifneq ($(OS),Windows_NT)
    ifndef INTELOCLSDKROOT
        INTELOCLSDKROOT := /etc/alternatives/opencl-intel-tools
    endif
    OCL_POSTFIX := android-preinstall

    # Setting LOCAL_CFLAGS with -I is not good in comparison to LOCAL_C_INCLUDES
    # according to NDK documentation, but this only variant that works correctly

    LOCAL_CFLAGS    += -I$(INTELOCLSDKROOT)/include
    LOCAL_MODULE    := step
    LOCAL_SRC_FILES := step.cpp
    LOCAL_LDFLAGS   += -llog -ljnigraphics -L$(INTELOCLSDKROOT)/$(OCL_POSTFIX) -lOpenCL
else
    OCL_POSTFIX := lib\android32

    # Setting LOCAL_CFLAGS with -I is not good in comparison to LOCAL_C_INCLUDES
    # according to NDK documentation, but this only variant that works correctly

    LOCAL_CFLAGS    += -I"$(INTELOCLSDKROOT)\include"
    LOCAL_MODULE    := step
    LOCAL_SRC_FILES := step.cpp
    LOCAL_LDFLAGS   += -llog -ljnigraphics -L"$(INTELOCLSDKROOT)\$(OCL_POSTFIX)" -lOpenCL
endif




include $(BUILD_SHARED_LIBRARY)
