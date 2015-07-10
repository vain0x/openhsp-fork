;
; HSP2.61 Compatible macros
;
#ifndef __hsp261cmp__
#define __hsp261cmp__

;	システム変数
#undef curdir
#define global curdir dirinfo(0)
#undef exedir
#define global exedir dirinfo(1)
#define global windir dirinfo(2)
#define global sysdir dirinfo(3)
#undef winx
#define global winx ginfo@hsp(12)
#undef winy
#define global winy ginfo@hsp(13)
#define global rval ginfo@hsp(16)
#define global gval ginfo@hsp(17)
#define global bval ginfo@hsp(18)
#define global paluse ginfo@hsp(19)
#define global dispx ginfo@hsp(20)
#define global dispy ginfo@hsp(21)
#define global csrx ginfo@hsp(22)
#define global csry ginfo@hsp(23)

#undef rnd
#define rnd(%1,%2) %1=rnd@hsp(%2)
#undef gettime
#define gettime(%1,%2) %1=gettime@hsp(%2)
#undef wpeek
#define wpeek(%1,%2,%3) %1=wpeek@hsp(%2,%3)
#undef peek
#define peek(%1,%2,%3) %1=peek@hsp(%2,%3)
#undef notemax
#define notemax(%1) %1=noteinfo@hsp(0)
#undef strlen
#define strlen(%1,%2) %1=strlen@hsp(%2)
#undef sysinfo
#define sysinfo(%1,%2) %1=sysinfo@hsp(%2)
#undef getpath
#define getpath(%1,%2,%3) %1=getpath@hsp(%2,%3)
#undef strmid
#define strmid(%1,%2,%3,%4) %1=strmid@hsp(%2,%3,%4)
#undef instr
#define instr(%1,%2,%3,%4) %1=instr@hsp(%2,%4,%3)

;	マルチメディア制御命令
#define global sndload mmload
#define global snd     mmplay
#define global sndoff  mmstop

;	パレット関連
#define global getpal  palcolor

;	objsend
#define global objsend(%1 = 0, %2 = 0, %3 = 0, %4 = 0, %5 = 0) \
        if (%2) == -1 { \
                objsel %1 \
        } else { \
                if %5 { \
                        sendmsg objinfo(%1,2), %2, %3, %4 \
                } else { \
                        sendmsg objinfo(%1,2), %2, %3, varptr(%4) \
                } \
        }


;	互換命令
#undef ginfo
#module _hsp261cmp

#deffunc ginfo int p1
	prmx@=ginfo@hsp(p1*2)
	prmy@=ginfo@hsp(p1*2+1)
	return

#deffunc palcopy int p1
	return

#global

#ifndef alloc
#define global alloc sdim
#endif

#endif
