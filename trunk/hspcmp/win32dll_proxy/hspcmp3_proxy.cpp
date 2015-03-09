
// hsp3 compiler proxy
// forward all processes to real compiler

#include <stdio.h>
#include <windows.h>
#include <direct.h>
#include <memory>
#include <cassert>

#include "../../hsp3/hsp3config.h"

#include "../../hsp3/hsp3debug.h"			// hsp3 error code
#include "../../hsp3/hsp3struct.h"			// hsp3 core define
#include "../../hsp3/hspwnd.h"				// hsp3 windows define

#include "../hsc3.h"
#include "../token.h"

//	VC++の場合
#ifdef __cplusplus
#define EXPORT extern "C" __declspec (dllexport)
#else
#define EXPORT __declspec (dllexport)
#endif

static char compilerPath[_MAX_PATH];
static char defaultCompilerPath[_MAX_PATH];
static char const* DefaultCompilerName = "hspcmp_default.dll";

static CHsc3 *hsc3;

typedef BOOL(CALLBACK *DLLFUNC)(int, int, int, int);
static HMODULE hDll;

//----------------------------------------------------------

// フルパス名から、ファイル名を削除する
// destructive. Leave delimiter '\\' on the tail.
static int CutOffFileName(char *filepath)
{
	size_t const len = strlen(filepath);
	size_t indexLastDelimiter = (len + 1);  // set invalid value
	for ( size_t i = 0; i < len; ++i ) {
		char const c = filepath[i];
		if (c == '\\') indexLastDelimiter = i;
		if (c < 0) ++i;  // 2byte char
	}
	if ( indexLastDelimiter > len ) return 1;  // error
	filepath[indexLastDelimiter + 1] = 0;
	return 0;
}

// set "substance" hspcmp path
// 本当にコンパイラのパスを表す文字列であるかはチェックしない。
EXPORT BOOL WINAPI hsc_setproxy(char *filepath, int, int, int)
{
	// set current compiler path
	if ( filepath ) {
		strncpy_s(compilerPath, filepath, _MAX_PATH - 1);

	} else {
		// initialize default compiler path
		if ( !defaultCompilerPath[0] ) {
			GetModuleFileName(NULL, defaultCompilerPath, _MAX_PATH);
			int const res = CutOffFileName(defaultCompilerPath);
			if ( res ) {
				defaultCompilerPath[0] = '\0';
				MessageBox(nullptr, "default compiler not found.", "hspcmp proxy", MB_ICONWARNING);
				return TRUE;
			}

			strcat_s(defaultCompilerPath, DefaultCompilerName);
		}

		strncpy_s(compilerPath, defaultCompilerPath, _MAX_PATH - 1);
	}

	// reload Dll
	if ( hDll ) { FreeLibrary(hDll); hDll = nullptr; }

	hDll = LoadLibrary(compilerPath);
	if ( !hDll ) {
		MessageBox(nullptr, compilerPath, "hspcmp proxy: LoadLibrary error", MB_ICONWARNING);
		return TRUE;
	}
	return FALSE;
}

//----------------------------------------------------------
// 公開関数の定義

#define EXPORT_FUNCTION_TMP(_NAME, _PRMS, _ARGS) \
	EXPORT BOOL WINAPI _NAME _PRMS \
	{ \
		auto f = (hDll ? (DLLFUNC)GetProcAddress(hDll, ("_" #_NAME "@16")) : nullptr); \
		int result = (f ? ((*f) _ARGS) : -1); \
		return result; \
	} //

// 引数の型ごとに分けている
// 結局全部 int にキャストするけど
#define EXPORT_FUNCTION_TYPE_0x000(_NAME) EXPORT_FUNCTION_TMP(_NAME, (int p1, int p2, int p3, int p4),         (p1, p2, p3, p4))
#define EXPORT_FUNCTION_TYPE_0x001(_NAME) EXPORT_FUNCTION_TMP(_NAME, (void *p1, int p2, int p3, int p4),       ((int)p1, p2, p3, p4))
#define EXPORT_FUNCTION_TYPE_0x005(_NAME) EXPORT_FUNCTION_TMP(_NAME, (void *p1, void *p2, int p3, int p4),     ((int)p1, (int)p2, p3, p4))
#define EXPORT_FUNCTION_TYPE_0x006(_NAME) EXPORT_FUNCTION_TMP(_NAME, (BMSCR *bm, char *p1, int p2, int p3),    ((int)bm, (int)p1, p2, p3))
#define EXPORT_FUNCTION_TYPE_0x010(_NAME) EXPORT_FUNCTION_TMP(_NAME, (int p1, int p2, int p3, void *p4),       (p1, p2, p3, (int)p4))
#define EXPORT_FUNCTION_TYPE_0x202(_NAME) EXPORT_FUNCTION_TMP(_NAME, (HSPEXINFO *hei, int p1, int p2, int p3), ((int)hei, p1, p2, p3))

EXPORT_FUNCTION_TYPE_0x006(hsc_ini);
EXPORT_FUNCTION_TYPE_0x006(hsc_refname);
EXPORT_FUNCTION_TYPE_0x006(hsc_objname);
EXPORT_FUNCTION_TYPE_0x010(hsc_ver);
EXPORT_FUNCTION_TYPE_0x000(hsc_bye);
EXPORT_FUNCTION_TYPE_0x001(hsc_getmes);
EXPORT_FUNCTION_TYPE_0x000(hsc_clrmes);
EXPORT_FUNCTION_TYPE_0x006(hsc_compath);
EXPORT_FUNCTION_TYPE_0x000(hsc_comp);
EXPORT_FUNCTION_TYPE_0x006(pack_ini);
EXPORT_FUNCTION_TYPE_0x000(pack_view);
EXPORT_FUNCTION_TYPE_0x000(pack_make);
EXPORT_FUNCTION_TYPE_0x000(pack_opt);
EXPORT_FUNCTION_TYPE_0x006(pack_rt);
EXPORT_FUNCTION_TYPE_0x000(pack_exe);
EXPORT_FUNCTION_TYPE_0x006(pack_get);
EXPORT_FUNCTION_TYPE_0x000(hsc3_getsym);
EXPORT_FUNCTION_TYPE_0x001(hsc3_messize);;
EXPORT_FUNCTION_TYPE_0x006(hsc3_make);
EXPORT_FUNCTION_TYPE_0x005(hsc3_getruntime);
EXPORT_FUNCTION_TYPE_0x001(hsc3_run);
EXPORT_FUNCTION_TYPE_0x202(aht_source);
EXPORT_FUNCTION_TYPE_0x006(aht_ini);
EXPORT_FUNCTION_TYPE_0x001(aht_stdbuf);
EXPORT_FUNCTION_TYPE_0x001(aht_stdsize);
EXPORT_FUNCTION_TYPE_0x005(aht_getopt);
EXPORT_FUNCTION_TYPE_0x001(aht_getpropcnt);
EXPORT_FUNCTION_TYPE_0x005(aht_getpropid);
EXPORT_FUNCTION_TYPE_0x001(aht_getprop);
EXPORT_FUNCTION_TYPE_0x001(aht_getproptype);
EXPORT_FUNCTION_TYPE_0x001(aht_getpropmode);
EXPORT_FUNCTION_TYPE_0x005(aht_make);
EXPORT_FUNCTION_TYPE_0x000(aht_makeinit);
EXPORT_FUNCTION_TYPE_0x006(aht_makeend);
EXPORT_FUNCTION_TYPE_0x006(aht_makeput);
EXPORT_FUNCTION_TYPE_0x006(aht_setprop);
EXPORT_FUNCTION_TYPE_0x001(aht_sendstr);
EXPORT_FUNCTION_TYPE_0x001(aht_getmodcnt);
EXPORT_FUNCTION_TYPE_0x001(aht_getmodaxis);
EXPORT_FUNCTION_TYPE_0x000(aht_setmodaxis);
EXPORT_FUNCTION_TYPE_0x006(aht_prjload);
EXPORT_FUNCTION_TYPE_0x006(aht_prjsave);
EXPORT_FUNCTION_TYPE_0x202(aht_getprjmax);
EXPORT_FUNCTION_TYPE_0x202(aht_getprjsrc);
EXPORT_FUNCTION_TYPE_0x202(aht_prjload2);
EXPORT_FUNCTION_TYPE_0x202(aht_prjloade);
EXPORT_FUNCTION_TYPE_0x000(aht_delmod);
EXPORT_FUNCTION_TYPE_0x000(aht_linkmod);
EXPORT_FUNCTION_TYPE_0x000(aht_unlinkmod);
EXPORT_FUNCTION_TYPE_0x000(aht_setpage);
EXPORT_FUNCTION_TYPE_0x202(aht_getpage);
EXPORT_FUNCTION_TYPE_0x202(aht_propupdate);
EXPORT_FUNCTION_TYPE_0x202(aht_parts);
EXPORT_FUNCTION_TYPE_0x202(aht_getparts);
EXPORT_FUNCTION_TYPE_0x202(aht_listparts);
EXPORT_FUNCTION_TYPE_0x202(aht_findstart);
EXPORT_FUNCTION_TYPE_0x202(aht_findparts);
EXPORT_FUNCTION_TYPE_0x202(aht_findend);
EXPORT_FUNCTION_TYPE_0x202(aht_getexid);

//----------------------------------------------------------
// エントリーポイント

#if defined( __GNUC__ ) && defined( __cplusplus )
extern "C"
#endif
BOOL WINAPI DllMain(HINSTANCE hInstance, DWORD fdwReason, PVOID pvReserved)
{
	if ( fdwReason == DLL_PROCESS_ATTACH ) {
		//hsc3 = new CHsc3;
		if ( hsc_setproxy(nullptr, 0, 0, 0) ) {
			return FALSE;
		}
	}
	if ( fdwReason == DLL_PROCESS_DETACH ) {
		if ( hDll ) { FreeLibrary(hDll); hDll = nullptr; }
		// delete hsc3; hsc3 = NULL;
	}
	return TRUE;
}
