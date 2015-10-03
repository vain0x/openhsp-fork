
//
//		Configure for HSP3
//
#ifndef __hsp3config_h
#define __hsp3config_h

//		システム関連ラベル
//
#define HSPTITLE "OpenHSP ver."
#define hspver "3.2beta3"
#define mvscode 3		// minor version code
#define vercode 0x3203	// version code

#define HSPERR_HANDLE		// HSPエラー例外を有効にします
#define SYSERR_HANDLE		// システムエラー例外を有効にします


//
//		移植用のラベル
//
#define JPN			// IME use flag
#define JPNMSG		// japanese message flag

//
//	Debug mode functions
//
#define HSPDEBUGLOG	// Debug Log Version

//		Debug Window Message Buffer Size
//
#define dbsel_size 0x10000
#define dbmes_size 0x10000

//
//		以下のラベルはコンパイルオプションで設定されます
//
//#define HSPWIN		// Windows(WIN32) version flag
//#define HSPWINGUI		// Windows(WIN32) version flag
//#define HSPMAC		// Macintosh version flag
//#define HSPLINUX		// Linux(CLI) version flag
//#define HSPLINUXGUI	// Linux(GUI) version flag

//#define HSPDEBUG	// Debug version flag

//
//		移植用の定数
//
#ifdef HSPWIN
#define HSP_MAX_PATH	260
#define HSP_PATH_SEPARATOR '\\'
#endif
#ifdef HSPLINUX
#define HSP_MAX_PATH	256
#define HSP_PATH_SEPARATOR '/'
#endif

#endif
