
#include "hsp_compiler_api.h"
#include "support.h"

extern char szDllDir[_MAX_PATH]; //main.cpp

std::stack<std::shared_ptr<HspCompilerApi>> HspCompilerLoader::hspcmp_stack;

HspCompilerLoader::HspCompilerLoader()
	: api_(new HspCompilerApi)
{
	hspcmp_stack.push(nullptr);

	dll_ = LoadLibrary(szDllDir);
	if ( !dll_ ) {
		dllflg_ = 0;

		msgboxf(NULL,
#ifdef JPNMSG
			"%sが見つかりませんでした。"
#else
			"%s not found."
#endif
			, "Startup error", MB_OK | MB_ICONEXCLAMATION, szDllDir);
		return;
	}

	HspCompilerApi& hspcmp = *api_;
	dllflg_ = 1;
	hspcmp.hsc_ini      = loadFunc("hsc_ini");
	hspcmp.hsc_refname  = loadFunc("hsc_refname");
	hspcmp.hsc_objname  = loadFunc("hsc_objname");
	hspcmp.hsc_comp     = loadFunc("hsc_comp");
	hspcmp.hsc_getmes   = loadFunc("hsc_getmes");
	hspcmp.hsc_clrmes   = loadFunc("hsc_clrmes");
	hspcmp.hsc_ver      = loadFunc("hsc_ver");
	hspcmp.hsc_bye      = loadFunc("hsc_bye");
	hspcmp.pack_ini     = loadFunc("pack_ini");
	hspcmp.pack_make    = loadFunc("pack_make");
	hspcmp.pack_exe     = loadFunc("pack_exe");
	hspcmp.pack_opt     = loadFunc("pack_opt");
	hspcmp.pack_rt      = loadFunc("pack_rt");
	hspcmp.hsc3_getsym  = loadFunc("hsc3_getsym");
	hspcmp.hsc3_make    = loadFunc("hsc3_make");
	hspcmp.hsc3_messize = loadFunc("hsc3_messize");

	// 3.0用の追加
	if ( dllflg_ > 0 ) {
		hspcmp.hsc3_getruntime = loadFunc("hsc3_getruntime");
		hspcmp.hsc3_run        = loadFunc("hsc3_run");
	}

	//いずれかの loadFunc に失敗した
	if ( dllflg_ < 0 ) {
		msgboxf(NULL, "%s", "Startup error", MB_OK | MB_ICONEXCLAMATION, errmsg_.c_str());
	} else {
		hspcmp_stack.top() = api_;
	}
}

HspCompilerLoader::~HspCompilerLoader()
{
	//		Release DLL entry
	//
	hspcmp_stack.pop();

	if ( dllflg_ == 1 ) {
		api_->hsc_bye(0, 0, 0, 0);
	}
	if ( dllflg_ != 0 ) {
		FreeLibrary(dll_);
	}
}

DLLFUNC HspCompilerLoader::loadFunc(char const* name)
{
	//		DLL関数を割り当てる
	//
	// 失敗したら dllflg を負にし、エラーメッセージを errmsg_ に書き込む。

	if ( !(*this) ) return nullptr;

	char funcname[128];
	sprintf_s(funcname, "_%s@16", name);

	auto const entity = (DLLFUNC)GetProcAddress(dll_, funcname);
	if ( entity ) {
		return entity;

	} else {
		dllflg_ = -1; // error flag
		errmsg_.append("関数「")
			.append(funcname)
			.append("」が見つかりません。\r\n");
		return nullptr;
	}
}

std::shared_ptr<HspCompilerApi> HspCompilerLoader::lastHspcmp()
{
	return (hspcmp_stack.empty()
		? nullptr
		: hspcmp_stack.top());
}
