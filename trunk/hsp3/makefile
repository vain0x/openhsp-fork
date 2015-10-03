#/*-------------------------------------------------------------------------*/
#
#   HSPランタイムのビルド。
#
#   GNU make 用メイクファイル
#
#   (使い方)
#   make ( <PLATFORM> [ <OBJ> ... ] [ release ] [ all ] ) | ( <PLATFORM> clean ) | cleanall
#
#   <PLATFORM> は
#       linux
#       win32_mingw
#       win32gui_mingw
#   のどれか。all, clean を指定する場合も PLATFORM を指定する。
#
#   <OBJ> にファイルを指定すると指定したファイルのみをビルド対象にする。
#   指定しなかった場合は <PLATFORM> に対応した実行ファイルを対象にする。
#
#   release を指定するとリリースビルド、それ以外はデバッグビルド。
#
#   all を指定すると <PLATFORM> に関係したオブジェクトファイル・実行ファイル全てのリビルド。
#   clean を指定すると <PLATFORM> に関係したオブジェクトファイル・実行ファイルの削除。
#   cleanall を指定するとそのフォルダ内のすべてのオブジェクトファイル・実行ファイルの削除。
#
#/*-------------------------------------------------------------------------*/

#/*-----------------------------------------------------------*/
#
#   必要ならば環境に合わせて includedir, libdir を設定する。
#   パスを空白で区切って列挙する。(半角スペースを含むパスは""で囲む)
#

includedir =
libdir =

#/*-----------------------------------------------------------*/

RM = rm -f

#/*-----------------------------------------------------------*/
#
#   プラットフォーム判定
#

PLATFORM =

#/*------------------------------------------*/

ifneq ($(filter linux,$(MAKECMDGOALS)),)
    PLATFORM := $(PLATFORM) linux
endif

ifneq ($(filter win32_mingw,$(MAKECMDGOALS)),)
    PLATFORM := $(PLATFORM) win32_mingw
endif

ifneq ($(filter win32gui_mingw,$(MAKECMDGOALS)),)
    PLATFORM := $(PLATFORM) win32gui_mingw
endif

#/*------------------------------------------*/

ifneq ($(words $(PLATFORM)),1)
    PLATFORM =
endif

#/*------------------------------------------*/

#/*-----------------------------------------------------------*/
#
#   プラットフォームごとの設定
#

#/*------------------------------------------*/
#
#   gcc で linux 版ランタイムをビルド。
#
#   動作未確認。問題があれば makefile.linux の内容を参照してください。
#

ifneq ($(filter linux,$(PLATFORM)),)

    includedir := $(includedir)
    libdir := $(libdir)

    vpath
    vpath %.c   ./linux
    vpath %.cpp ./linux
    vpath %.h   ./linux
    vpath %.hpp ./linux

    CC = gcc
    CFLAGS_B = -Wall -finput-charset=cp932 -fexec-charset=cp932 \
               -DHSPLINUX $(addprefix -I,$(includedir))
    CFLAGS_D = $(CFLAGS_B) -DHSPDEBUG
    CFLAGS_R = $(CFLAGS_B) -O3 -DNDEBUG

    CXX = $(CC)
    CXXFLAGS_B = $(CFLAGS_B)
    CXXFLAGS_D = $(CFLAGS_D)
    CXXFLAGS_R = $(CFLAGS_R)

    LD = $(CC)
    LDFLAGS_B = $(addprefix -L,$(libdir)) $(addprefix -l,$(LIBS))
    LDFLAGS_D = $(LDFLAGS_B)
    LDFLAGS_R = $(LDFLAGS_B) -s

    PF_TARGET_D = hsp3
    PF_TARGET_R = $(PF_TARGET_D)

    OBJS = linux/main.o hsp3.o hsp3code.o hsp3debug.o hsp3int.o \
           hspvar_core.o hspvar_double.o hspvar_int.o hspvar_label.o \
           hspvar_str.o hspvar_struct.o stack.o strbuf.o strnote.o \
           dpmread.o linux/supio_linux.o linux/hsp3cl.o \
           linux/hsp3ext_linux.o linux/hsp3gr_linux.o
    RESES =
    LIBS = m stdc++

endif

#/*------------------------------------------*/

#/*------------------------------------------*/
#
#   mingw で Windows コンソール版ランタイムをビルド。
#
#   mingw32(gcc-3.4.5-20060117-1) + msys で動作確認。
#

ifneq ($(filter win32_mingw,$(PLATFORM)),)

    includedir := $(includedir)
    libdir := $(libdir)

    vpath
    vpath %.c   ./win32 ./win32gui
    vpath %.cpp ./win32 ./win32gui
    vpath %.h   ./win32 ./win32gui
    vpath %.hpp ./win32 ./win32gui
    vpath %.rc  ./win32 ./win32gui

    CC = gcc
    CFLAGS_B = -Wall -Wno-unused -fexceptions -fsigned-char \
               -finput-charset=cp932 -fexec-charset=cp932 \
               -mwindows -mconsole \
               -DWINVER=0x0400 -D_WIN32_IE=0x0500 -DHSPWIN -DHSPCL_WIN \
               $(addprefix -I,$(includedir))
    CFLAGS_D = $(CFLAGS_B) -DHSPDEBUG
    CFLAGS_R = $(CFLAGS_B) -O3 -DNDEBUG

    CXX = g++
    CXXFLAGS_B = $(CFLAGS_B)
    CXXFLAGS_D = $(CFLAGS_D)
    CXXFLAGS_R = $(CFLAGS_R)

    LD = g++
    LDFLAGS_B = -mwindows -mconsole \
                $(addprefix -L,$(libdir)) $(addprefix -l,$(LIBS))
    LDFLAGS_D = $(LDFLAGS_B)
    LDFLAGS_R = $(LDFLAGS_B) -s

    PF_TARGET_D = hsp3cl.exe
    PF_TARGET_R = $(PF_TARGET_D)

    OBJS = dpmread.o hsp3.o hsp3code.o hsp3debug.o hsp3int.o hspvar_core.o \
           hspvar_double.o hspvar_int.o hspvar_label.o hspvar_str.o \
           hspvar_struct.o stack.o strbuf.o strnote.o \
           hsp3cl.o hsp3gr_win.o main.o \
           comobj.o comobj_event.o filedlg.o hsp3ext_win.o hsp3extlib.o \
           hspvar_comobj.o hspvar_variant.o supio_win.o
    RESES =
    LIBS = comctl32 ole32 oleaut32 uuid

endif

#/*------------------------------------------*/

#/*------------------------------------------*/
#
#   mingw で Windows GUI 版ランタイムをビルド。
#
#   mingw32(gcc-3.4.5-20060117-1) + msys で動作確認。
#

ifneq ($(filter win32gui_mingw,$(PLATFORM)),)

    includedir := $(includedir)
    libdir := $(libdir)

    vpath
    vpath %.c   ./win32gui
    vpath %.cpp ./win32gui
    vpath %.h   ./win32gui
    vpath %.hpp ./win32gui
    vpath %.rc  ./win32gui

    CC = gcc
    CFLAGS_B = -Wall -Wno-unused -fexceptions -fsigned-char \
               -finput-charset=cp932 -fexec-charset=cp932 -mwindows \
               -DWINVER=0x0400 -D_WIN32_IE=0x0500 -DHSPWIN -DHSPWINGUI \
               $(addprefix -I,$(includedir))
    CFLAGS_D = $(CFLAGS_B) -DHSPDEBUG
    CFLAGS_R = $(CFLAGS_B) -O3 -DNDEBUG

    CXX = g++
    CXXFLAGS_B = $(CFLAGS_B)
    CXXFLAGS_D = $(CFLAGS_D)
    CXXFLAGS_R = $(CFLAGS_R)

    LD = g++
    LDFLAGS_B = -mwindows $(addprefix -L,$(libdir)) $(addprefix -l,$(LIBS))
    LDFLAGS_D = $(LDFLAGS_B)
    LDFLAGS_R = $(LDFLAGS_B) -s

	WINDRES = windres

    PF_TARGET_D = hsp3.exe
    PF_TARGET_R = hsprt.exe

    OBJS = dpmread.o hsp3.o hsp3code.o hsp3debug.o hsp3int.o hspvar_core.o \
           hspvar_double.o hspvar_int.o hspvar_label.o hspvar_str.o \
           hspvar_struct.o stack.o strbuf.o strnote.o \
           comobj.o comobj_event.o fcpoly.o filedlg.o hsp3ext_win.o \
           hsp3extlib.o hsp3gr_wingui.o hsp3win.o hspvar_comobj.o \
           hspvar_variant.o hspwnd_obj.o hspwnd_win.o main.o mmman.o supio_win.o \
           $(RESES)
    RESES = hsp3.res
    LIBS = comctl32 ole32 oleaut32 uuid winmm

endif

#/*------------------------------------------*/

#/*-----------------------------------------------------------*/

#/*------------------------------------------*/
#
# リリース・デバッグの切り替え。
#

ifneq ($(filter release,$(MAKECMDGOALS)),)
    CFLAGS = $(CFLAGS_R)
    CXXFLAGS = $(CXXFLAGS_R)
    LDFLAGS = $(LDFLAGS_R)
    PF_TARGET = $(PF_TARGET_R)
else
    CFLAGS = $(CFLAGS_D)
    CXXFLAGS = $(CXXFLAGS_D)
    LDFLAGS = $(LDFLAGS_D)
    PF_TARGET = $(PF_TARGET_D)
endif

#/*------------------------------------------*/

TARGET = $(filter *.o,$(MAKECMDGOALS)) $(filter *.exe,$(MAKECMDGOALS)) $(filter *.dll,$(MAKECMDGOALS))

ifeq ($(words $(TARGET)),0)
    TARGET = $(PF_TARGET)
endif

#/*-----------------------------------------------------------*/

EXECMODE =
RMFILE =

ifneq ($(filter cleanall,$(MAKECMDGOALS)),)
    EXECMODE = exec_clean
    RMFILE = *.o *.exe *.out *.dll *.res
else
    ifeq ($(words $(PLATFORM)),1)
        EXECMODE = exec_target
    endif

    ifneq ($(filter clean,$(MAKECMDGOALS)),)
        EXECMODE = exec_clean
        RMFILE = $(OBJS) $(TARGET)
    endif

    ifneq ($(filter all,$(MAKECMDGOALS)),)
        EXECMODE = exec_alltarget
    endif

    ifneq ($(words $(PLATFORM)),1)
        EXECMODE = exec_error_platform
    endif
endif

#/*-----------------------------------------------------------*/

.SUFFIXES:
.SUFFIXES: .c .cpp .h .hpp .o .rc .res

.PHONY: all clean cleanall release \
        linux win32_mingw win32gui_mingw \
        exec_alltarget exec_clean exec_error_platform exec_pre_alltarget exec_target

#/*-----------------------------------------------------------*/

linux win32_mingw win32gui_mingw all clean cleanall release: $(EXECMODE)
	@echo -n

#/*-------------------------------------------*/

exec_error_platform:
	@echo only one platform must be specified.
	@exit 1

exec_clean:
	$(RM) $(RMFILE)

exec_target: $(TARGET)
	@echo -n

exec_alltarget: exec_pre_alltarget $(TARGET)
	@echo -n

exec_pre_alltarget:
	$(RM) $(OBJS) $(TARGET)

#/*-------------------------------------------*/

$(TARGET): $(OBJS)
	$(LD) $(OBJS) $(LDFLAGS) -o $@

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@

.cpp.o:
	$(CXX) $(CXXFLAGS) -c $< -o $@

.rc.res:
	$(WINDRES) -i $< --input-format=rc -o $@ -O coff --include-dir $(<D)

#/*-------------------------------------------*/

#/*-----------------------------------------------------------*/

#/*-------------------------------------------*/
#
#  ../hsp3
#

dpmread.o: dpmread.cpp hsp3config.h dpmread.h supio.h
hsp3.o: hsp3.cpp hsp3.h hsp3debug.h hsp3struct.h hspvar_core.h hsp3ext.h \
  hsp3code.h hsp3config.h dpmread.h supio.h
hsp3code.o: hsp3code.cpp hspwnd.h supio.h dpmread.h stack.h strbuf.h \
  hsp3code.h hsp3debug.h hsp3struct.h hspvar_core.h hsp3config.h \
  hsp3int.h
hsp3debug.o: hsp3debug.cpp hsp3config.h hsp3.h hsp3debug.h hsp3struct.h \
  hspvar_core.h hsp3ext.h hsp3code.h
hsp3int.o: hsp3int.cpp hsp3config.h hspwnd.h supio.h dpmread.h strbuf.h \
  strnote.h hsp3int.h hsp3struct.h hspvar_core.h hsp3debug.h hsp3code.h
hspvar_core.o: hspvar_core.cpp hspvar_core.h hspvar_label.h hsp3debug.h \
  strbuf.h supio.h
hspvar_double.o: hspvar_double.cpp hspvar_core.h hsp3debug.h strbuf.h
hspvar_int.o: hspvar_int.cpp hspvar_core.h hsp3debug.h strbuf.h supio.h
hspvar_label.o: hspvar_label.cpp hsp3code.h hsp3debug.h hsp3struct.h \
  hspvar_core.h hspvar_label.h strbuf.h supio.h
hspvar_str.o: hspvar_str.cpp hspvar_core.h hsp3debug.h strbuf.h supio.h
hspvar_struct.o: hspvar_struct.cpp hsp3code.h hsp3debug.h hsp3struct.h \
  hspvar_core.h strbuf.h supio.h
stack.o: stack.cpp stack.h hspvar_core.h hsp3debug.h
strbuf.o: strbuf.cpp supio.h strbuf.h hsp3debug.h
strnote.o: strnote.cpp strnote.h


#/*-------------------------------------------*/
#
#  ../hsp3/linux
#

linux/Main.o: hsp3cl.h hsp3config.h
linux/hsp3cl.o: strbuf.h hsp3.h hsp3debug.h \
  hsp3struct.h hspvar_core.h hsp3ext.h hsp3code.h \
  hsp3config.h supio.h hsp3gr.h
linux/hsp3ext_linux.o: hsp3ext.h hsp3code.h hsp3debug.h \
  hsp3struct.h hspvar_core.h
linux/hsp3gr_linux.o: hsp3code.h hsp3debug.h hsp3struct.h \
  hspvar_core.h supio.h strbuf.h hsp3gr.h
hsp3.o: hsp3.h hsp3debug.h hsp3struct.h \
  hspvar_core.h hsp3ext.h hsp3code.h hsp3config.h \
  dpmread.h supio.h
hsp3code.o: hspwnd.h hsp3code.h hsp3debug.h \
  hsp3struct.h hspvar_core.h supio.h dpmread.h stack.h \
  strbuf.h hsp3config.h hsp3int.h
hsp3debug.o: hsp3config.h hsp3.h hsp3debug.h \
  hsp3struct.h hspvar_core.h hsp3ext.h hsp3code.h
hsp3int.o: hspwnd.h hsp3code.h hsp3debug.h \
  hsp3struct.h hspvar_core.h supio.h dpmread.h strbuf.h \
  strnote.h hsp3int.h
hspvar_core.o: hspvar_core.h hspvar_label.h \
  hsp3debug.h strbuf.h supio.h
hspvar_double.o: hspvar_core.h hsp3debug.h \
  strbuf.h
hspvar_int.o: hspvar_core.h hsp3debug.h \
  strbuf.h supio.h
hspvar_label.o: hsp3code.h hsp3debug.h \
  hsp3struct.h hspvar_core.h hspvar_label.h strbuf.h \
  supio.h
hspvar_str.o: hspvar_core.h hsp3debug.h \
  strbuf.h supio.h
hspvar_struct.o: hsp3code.h hsp3debug.h \
  hsp3struct.h hspvar_core.h strbuf.h supio.h
stack.o: stack.h hspvar_core.h hsp3debug.h
strbuf.o: supio.h strbuf.h hsp3debug.h
strnote.o: strnote.h
Dpmread.o: dpmread.h supio.h
linux/supio_linux.o: linux/supio_linux.h supio.h dpmread.h strbuf.h


#/*-------------------------------------------*/
#
#  ../hsp3/win32
#

win32/hsp3cl.o: hsp3cl.cpp hsp3gr_win.h hsp3struct.h hspvar_core.h \
  hsp3debug.h hsp3config.h strbuf.h hsp3.h hsp3struct.h hsp3ext.h hsp3code.h \
  hsp3gr.h supio.h hsp3ext_win.h hsp3code.h hspvar_comobj.h comobj.h \
  hsp3extlib.h hspvar_comobj.h hspvar_variant.h
win32/hsp3gr_win.o: hsp3gr_win.cpp hsp3code.h hsp3debug.h hsp3struct.h \
  hspvar_core.h hsp3debug.h supio.h strbuf.h filedlg.h hsp3gr_win.h \
  hsp3struct.h
win32/main.o: main.cpp hsp3cl.h


#/*-------------------------------------------*/
#
#  ../hsp3/win32gui
#

win32gui/comobj.o: comobj.cpp hsp3code.h hsp3debug.h hsp3struct.h \
  hspvar_core.h comobj.h comobj_event.h hsp3ext.h strbuf.h
win32gui/comobj_event.o: comobj_event.cpp hsp3code.h hsp3debug.h \
  hsp3struct.h hspvar_core.h comobj_event.h hspvar_comobj.h \
  comobj.h
win32gui/fcpoly.o: fcpoly.cpp fcpoly.h supio.h
win32gui/filedlg.o: filedlg.cpp
win32gui/hsp3ext_win.o: hsp3ext_win.cpp supio.h hsp3ext.h hsp3extlib.h \
  hsp3code.h hsp3debug.h hsp3struct.h hspvar_core.h \
  hspvar_comobj.h comobj.h hspvar_variant.h comobj_event.h hsp3win.h \
  hspwnd.h strbuf.h
win32gui/hsp3extlib.o: hsp3extlib.cpp supio.h dpmread.h hsp3ext.h \
  hsp3extlib.h hsp3code.h hsp3debug.h hsp3struct.h \
  hspvar_core.h hspvar_comobj.h comobj.h hsp3win.h hspwnd.h \
  strbuf.h
win32gui/hsp3gr_wingui.o: hsp3gr_wingui.cpp hspwnd.h mmman.h filedlg.h \
  supio.h dpmread.h stack.h strbuf.h fcpoly.h hsp3gr.h \
  hsp3code.h hsp3debug.h hsp3struct.h hspvar_core.h \
  hsp3debug.h
win32gui/hsp3win.o: hsp3win.cpp strbuf.h hsp3.h hsp3debug.h \
  hsp3struct.h hspvar_core.h hsp3ext.h hsp3code.h \
  hsp3ext.h hsp3gr.h hspvar_comobj.h comobj.h hspvar_variant.h \
  supio.h
win32gui/hspvar_comobj.o: hspvar_comobj.cpp hsp3code.h hsp3debug.h \
  hsp3struct.h hspvar_core.h hsp3struct.h hsp3ext.h \
  hspvar_core.h comobj.h hspvar_comobj.h comobj_event.h strbuf.h \
  supio.h
win32gui/hspvar_variant.o: hspvar_variant.cpp hsp3code.h hsp3debug.h \
  hsp3struct.h hspvar_core.h hsp3struct.h hsp3ext.h \
  hspvar_core.h comobj.h hspvar_comobj.h hspvar_variant.h \
  comobj_event.h strbuf.h supio.h
win32gui/hspwnd_obj.o: hspwnd_obj.cpp hsp3config.h hsp3debug.h hspwnd.h \
  dpmread.h strbuf.h strnote.h supio.h
win32gui/hspwnd_win.o: hspwnd_win.cpp hsp3config.h hsp3debug.h hspwnd.h \
  dpmread.h strbuf.h strnote.h supio.h
win32gui/main.o: main.cpp hsp3win.h
win32gui/mmman.o: mmman.cpp supio.h dpmread.h strbuf.h mmman.h
win32gui/supio_win.o: supio_win.cpp hsp3config.h supio_win.h dpmread.h \
  strbuf.h

win32gui/hsp3.res: hsp3.rc

