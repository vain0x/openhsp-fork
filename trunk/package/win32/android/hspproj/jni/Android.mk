LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := block3
LOCAL_CPPFLAGS  += -fexceptions
LOCAL_CFLAGS    := -D__ANDROID__ -Wno-psabi -DHSPNDK -DHSPEMBED -DHSPDISH

LOCAL_SRC_FILES := hsp_native_app_glue.c javafunc.cpp main.c hsp3embed/hsp3r.cpp hsp3embed/hspsource.cpp
LOCAL_LDLIBS    := -llog -landroid -lEGL -lGLESv1_CM -lOpenSLES -ljnigraphics -Llibs/$(TARGET_ARCH_ABI) -lhsp3lib
LOCAL_STATIC_LIBRARIES := hsp3lib

include $(BUILD_SHARED_LIBRARY)

$(call import-module,android/native_app_glue)
