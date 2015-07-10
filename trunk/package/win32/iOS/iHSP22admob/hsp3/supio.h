
//
//	supio.cpp functions
//
#ifndef __supio_h
#define __supio_h

#ifdef HSPWIN
#include "win32/supio_win.h"
#endif

#ifdef HSPIOS
#include "ios/supio_ios.h"
#endif

#ifdef HSPNDK
#include "ndk/supio_ndk.h"
#endif

#ifdef HSPLINUX
#include "linux/supio_linux.h"
#endif


#endif

