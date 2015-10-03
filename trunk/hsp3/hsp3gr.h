
//
//	hsp3gr.cpp header
//
#ifndef __hsp3gr_h
#define __hsp3gr_h

#ifdef HSPWIN
#ifdef HSPWINGUI
#include "win32gui/hsp3gr_wingui.h"
#else
#include "win32/hsp3gr_win.h"
#endif
#endif
#ifdef HSPLINUX
#include "linux/hsp3gr_linux.h"
#endif

#endif
