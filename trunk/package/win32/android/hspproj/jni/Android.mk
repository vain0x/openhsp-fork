LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := hspproj
LOCAL_CFLAGS := -D__ANDROID__ -Wno-psabi -DHSPNDK -DHSPEMBED -DHSPDISH
LOCAL_CPPFLAGS  += -fexceptions
LOCAL_C_INCLUDES += ../hsplib35b3

LOCAL_SRC_FILES := hsp3embed/hsp3r.cpp hsp3embed/hspsource.cpp javafunc.cpp main.c \
../../hsplib35b3/hsp_native_app_glue.c \
../../hsplib35b3/hsp3embed/hsp3code.cpp \
../../hsplib35b3/hsp3embed/hsp3embed.cpp \
../../hsplib35b3/hsp3embed/hspvar_util.cpp \
../../hsplib35b3/hsp3embed/misc.cpp \
../../hsplib35b3/hsp3/dpmread.cpp \
../../hsplib35b3/hsp3/hsp3debug.cpp \
../../hsplib35b3/hsp3/hsp3gr_dish.cpp \
../../hsplib35b3/hsp3/hsp3int.cpp \
../../hsplib35b3/hsp3/hspvar_core.cpp \
../../hsplib35b3/hsp3/hspvar_double.cpp \
../../hsplib35b3/hsp3/hspvar_int.cpp \
../../hsplib35b3/hsp3/hspvar_label.cpp \
../../hsplib35b3/hsp3/hspvar_str.cpp \
../../hsplib35b3/hsp3/hspvar_struct.cpp \
../../hsplib35b3/hsp3/hspwnd_dish.cpp \
../../hsplib35b3/hsp3/hspwnd_obj.cpp \
../../hsplib35b3/hsp3/random.cpp \
../../hsplib35b3/hsp3/stack.cpp \
../../hsplib35b3/hsp3/strbuf.cpp \
../../hsplib35b3/hsp3/strnote.cpp \
../../hsplib35b3/hsp3/sysreq.cpp \
../../hsplib35b3/hsp3/ndk/supio_ndk.cpp \
../../hsplib35b3/hsp3/ndk/hsp3ext_ndk.cpp \
../../hsplib35b3/hsp3/ndk/hgiox.cpp \
../../hsplib35b3/hsp3/ndk/hgtex.cpp \
../../hsplib35b3/hsp3/ndk/stb_image.c \
../../hsplib35b3/hsp3/ndk/mmman.cpp \
../../hsplib35b3/hsp3/ndk/webtask_ndk.cpp

LOCAL_LDLIBS    := -llog -landroid -lEGL -lGLESv1_CM -lOpenSLES -ljnigraphics -Llibs/$(TARGET_ARCH_ABI) -lobaqlib
LOCAL_STATIC_LIBRARIES := obaqlib

include $(BUILD_SHARED_LIBRARY)

$(call import-module,android/native_app_glue)
