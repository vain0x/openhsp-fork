// partial CToken
// cf. knowbug/CAx::analyzeDInfo

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <cassert>

#include <sstream>
#include <algorithm>

#include "../hsp3/hsp3config.h"
#include "../hsp3/hsp3debug.h"
#include "../hsp3/hsp3struct.h"

#include "supio.h"
#include "token.h"
#include "label.h"
#include "tagstack.h"
#include "membuf.h"
#include "strnote.h"
#include "comutil.h"

#include "token.h"

#ifdef HSPINSPECT

extern char *hsp_prestr[];  // hspcmp.cpp
extern char *hsp_prepp[];

#define assert_sentinel do { assert(false); throw; } while(false)

//treat membuf as _TYPE[]
#define MEMBUF_COUNT(_TYPE, _SELF) ((_SELF).GetSize() / sizeof(_TYPE))
#define MEMBUF_BEGIN(_TYPE, _SELF) (reinterpret_cast<std::add_pointer_t<_TYPE>>((_SELF).GetBuffer()))
#define MEMBUF_END(_TYPE, _SELF)  (&MEMBUF_BEGIN(_TYPE, _SELF)[MEMBUF_COUNT(_TYPE, _SELF)])
#define MEMBUF_RANGE(_TYPE, _SELF) MEMBUF_BEGIN(_TYPE, _SELF), MEMBUF_END(_TYPE, _SELF)

int CToken::SaveAxInspection(char* fname)
{
	return axi_buf ? axi_buf->SaveFile(fname) : -1;
}

void CToken::InspectAxCode()
{
	assert(!axi_buf);
	axi_buf.reset(new CMemBuf());

	Inspect_AnalyzeDInfo();

	Inspect_CodeSegment();
	Inspect_FInfoSegment();
	//Inspect_LInfoSegment();
	//Inspect_HpiSegment();
}

void CToken::Inspect_BeginSegment(char const* segment_title)
{
	assert(!!axi_buf);
	axi_buf->PutStrf("[%s]", segment_title);
	axi_buf->PutCR();
}

void CToken::Inspect_CodeSegment()
{
	//todo: タブ文字ではなく桁数指定で揃えたい
	Inspect_BeginSegment("CodeSegment");
	axi_buf->PutStr("位置\tタイプ\t\t値\t単項\t文頭\tカンマ\t分岐先\t値の意味");
	axi_buf->PutCR();

	for ( int i = 0; i < GetCS(); ) {
		i += Inspect_CSElem(i);
	}

	axi_buf->PutCR();
}

int CToken::Inspect_CSElem(int csindex)
{
	auto const cur_cs = &reinterpret_cast<unsigned short*>(cs_buf->GetBuffer())[csindex];

	//analyze single code
	int const c = cur_cs[0];
	int const type = c & CSTYPE;
	bool const exflags[] =
		{ (c & EXFLG_0) != 0, (c & EXFLG_1) != 0, (c & EXFLG_2) != 0, (c & EXFLG_3) != 0 };
	int const value =
		exflags[3] ? *reinterpret_cast<int*>(&cur_cs[1]) : cur_cs[1];
	int code_size =
		exflags[3] ? 3 : 2;

	//Mesf("inspect cs elem #%d (c = %X, type = %d, value = %d)", csindex, c, type, value);

	//if/elseのスキップ量
	int cmp_dest = -1;
	if ( type == TYPE_CMPCMD ) {
		int const skip_offset = cur_cs[code_size];
		code_size ++;
		cmp_dest = code_size + skip_offset;
	}

	//出力
	std::ostringstream output;
	output
		<< csindex << '\t'
		<< Inspect_TypeName(type) << '\t'
		<< value << '\t';
	for ( int i = 0; i < 3; ++ i) {
		output << (exflags[i] ? "yes" : "-") << '\t';
	}
	if ( cmp_dest >= 0 ) {
		output << cmp_dest << '\t';
	} else {
		output << '-' << '\t';
	}

	switch ( type ) {
		case TYPE_MARK: {
			if ( value < CALCCODE_MAX ) {
				output << stringFromCalcCode(value);
			} else {
				assert(value == '(' || value == ')' || value == '[' || value == ']' || value == '?');
				output << static_cast<char>(value);
			}
			break;
		}
		case TYPE_STRING:
			output << "{\"" << (&ds_buf->GetBuffer()[value]) << "\"}";
			break;
		case TYPE_DNUM:
			output << reinterpret_cast<double*>(&ds_buf->GetBuffer()[value]);
			break;
		case TYPE_INUM:
			output << value;
			break;
		case TYPE_VAR: {
			auto it = inspect_var_names->find(value);
			if ( it != inspect_var_names->end() ) {
				output << it->second;
			} else {
				output << "(var#" << value << ")";
			}
			break;
		}
		case TYPE_LABEL: {
			auto it = inspect_lab_names->find(value);
			if ( it != inspect_lab_names->end() ) {
				output << '*' << it->second;
			} else {
				int const csindex = reinterpret_cast<int*>(ot_buf->GetBuffer())[value];
				output << "*(lb#" << value << ": " << csindex << ")";
			}
			break;
		}
		case TYPE_MODCMD: {
			auto it = inspect_prm_names->find(value);
			if ( it != inspect_prm_names->end() ) {
				output << it->second;
			} else {
				//todo: STRUCTDAT::prmindex を調べて、元の関数名の第N引数、と表示したほうがよい
				output << "(modcmd#" << value << ")";
			}
			break;
		}
		case TYPE_STRUCT: {
			if ( value < 0 ) { output << "thismod"; break; }
			auto const stprm = &reinterpret_cast<STRUCTPRM*>(mi_buf->GetBuffer())[value];
			auto stdat = (stprm->subid >= 0)
				? &reinterpret_cast<STRUCTDAT*>(fi_buf->GetBuffer())[stprm->subid]
				: nullptr;

			// moduletag (newmod の第2引数)
			if ( stdat && stprm->mptype == MPTYPE_STRUCTTAG ) {
				output << (&ds_buf->GetBuffer()[stdat->nameidx]);
				break;
			}

			// パラメータエイリアス、またはローカル変数(メンバ変数)
			assert(stprm->mptype == MPTYPE_LOCALVAR || stprm->subid == STRUCTPRM_SUBID_STACK);
			auto it = inspect_prm_names->find(value);
			if ( it != inspect_prm_names->end() ) {
				output << it->second;
			} else {
				//どの関数のパラメータかを検索
				if ( !stdat ) {
					auto const found = std::find_if(MEMBUF_RANGE(STRUCTDAT, *fi_buf), [&](STRUCTDAT& it) {
						return ((value - it.prmindex) < it.prmmax);
					});
					stdat = (found != MEMBUF_END(STRUCTDAT, *fi_buf)) ? found : nullptr;
				}
				if ( stdat ) {
					char const* funcname = &ds_buf->GetBuffer()[stdat->nameidx];
					output << "(prm#" << value << ": " << funcname << "#" << (value - stdat->prmindex) << ")";
				} else {
					output << "(prm#" << value << ")";
				}
			}
			break;
		}
		default: assert(type >= TYPE_INTCMD);
			//(type, value)に対応するコマンドの名前を検索する
			// button, onexit などのgoto/gosubと連鎖する命令は opt に 0x10000 がついているので注意
			// #cmd で定義されるプラグインコマンドも一緒にみつかるはず
			if ( type == TYPE_PROGCMD && value == 0x00C ) { //隠しコマンド
				output << "_foreach_check@hsp";
				break;
			}

			int id = 0;
			for ( ; id < lb->GetNumEntry(); ++id ) {
				if ( lb->GetType(id) == type && (lb->GetOpt(id) & 0xFFFF) == value ) break;
			}

			assert(id < lb->GetNumEntry());
			output << (id < lb->GetNumEntry() ? lb->GetName(id) : "unknown");
			break;
	}

	axi_buf->PutStr(const_cast<char*>(output.str().c_str()));
	axi_buf->PutCR();
	return code_size;
}

char const* CToken::Inspect_TypeName(int type) {
	assert(type >= 0);
	static char const* internalTypeNames[] = {
		"TYPE_MARK", "TYPE_VAR", "TYPE_STRING", "TYPE_DNUM", "TYPE_INUM", "TYPE_STRUCT",
		"TYPE_XLABEL", "TYPE_LABEL", "TYPE_INTCMD", "TYPE_EXTCMD", "TYPE_EXTSYSVAR", "TYPE_CMPCMD", "TYPE_MODCMD",
		"TYPE_INTFUNC", "TYPE_SYSVAR", "TYPE_PROGCMD", "TYPE_DLLFUNC", "TYPE_DLLCTRL",
		"TYPE_USERDEF" };
	if ( type < TYPE_USERDEF ) {
		return internalTypeNames[type];
	} else {
		//todo:プラグインの個数を超えていないことをassertしたい
		return "TYPE_USERDEF";
	}
}

static char const* stringFromMPType(int mptype)
{
	switch ( mptype ) {
		case MPTYPE_VAR: return "var";
		case MPTYPE_STRING: return "str";
		case MPTYPE_DNUM: return "double";
		case MPTYPE_INUM: return "int";
		case MPTYPE_STRUCT: return "struct";
		case MPTYPE_LABEL: return "label";
		case MPTYPE_LOCALVAR: return "local";
		case MPTYPE_ARRAYVAR: return "array";
		case MPTYPE_SINGLEVAR: return "var";
		case MPTYPE_FLOAT: return "float";
		case MPTYPE_STRUCTTAG: return "structtag";
		case MPTYPE_LOCALSTRING: return "str";
		case MPTYPE_MODULEVAR: return "modvar";
		case MPTYPE_PPVAL: return "pval";
		case MPTYPE_PBMSCR: return "bmscr";
		case MPTYPE_PVARPTR: return "var";
		case MPTYPE_IMODULEVAR: return "modinit";
		case MPTYPE_IOBJECTVAR: return "comobj";
		case MPTYPE_LOCALWSTR: return "wstr";
		case MPTYPE_FLEXSPTR: return "sptr";
		case MPTYPE_FLEXWPTR: return "wptr";
		case MPTYPE_PTR_REFSTR: return "prefstr";
		case MPTYPE_PTR_EXINFO: return "pexinfo";
		case MPTYPE_PTR_DPMINFO: return "pdpminfo";  // ( MPTYPE_PTR_DPMINFO ) #func に 0x20 を指定すると第四引数がこれになる
		case MPTYPE_NULLPTR: return "nullptr";
		case MPTYPE_TMODULEVAR: return "modterm";
		case MPTYPE_NONE:
		default: assert_sentinel;
	}
}

void CToken::Inspect_FInfoSegment()
{
	Inspect_BeginSegment("FInfo");
	std::for_each(MEMBUF_RANGE(STRUCTDAT, *fi_buf), [this](STRUCTDAT& stdat) {
		char const* const name = &ds_buf->GetBuffer()[stdat.nameidx];
		bool const isCType = (stdat.index == STRUCTDAT_INDEX_CFUNC);

		std::ostringstream output;
		output << name;
		if ( isCType ) { output << '('; }
		if ( stdat.funcflag & STRUCTDAT_FUNCFLAG_CLEANUP ) {
			output << "onexit";
		} else {
			//parameters
			for ( int i = 0; i < stdat.prmmax; ++i ) {
				if ( i != 0 ) { output << ", "; }
				auto& stprm = MEMBUF_BEGIN(STRUCTPRM, *mi_buf)[stdat.prmindex];
				output << stringFromMPType(stprm.mptype);
			}
		}
		if ( isCType ) { output << ')'; }


	});
}
//void CToken::Inspect_LInfoSegment() {}
//void CToken::Inspect_HpiSegment() {}


static unsigned short wpeek(unsigned char const* p) { return *reinterpret_cast<unsigned short const*>(p); }
static unsigned int tripeek(unsigned char const* p) { return (p[0] | p[1] << 8 | p[2] << 16); }

void CToken::Inspect_AnalyzeDInfo()
{
	assert(!inspect_var_names);
	assert(!inspect_lab_names);
	assert(!inspect_prm_names);
	inspect_var_names.reset(new std::decay_t<decltype(*inspect_var_names)>());
	inspect_lab_names.reset(new std::decay_t<decltype(*inspect_lab_names)>());
	inspect_prm_names.reset(new std::decay_t<decltype(*inspect_prm_names)>());

	return;
	//

	enum DInfoCtx {	// ++ したいので enum class にしない
		DInfoCtx_Default = 0,
		DInfoCtx_LabelNames,
		DInfoCtx_PrmNames,
		DInfoCtx_Max
	};
	auto getIdentTableFromCtx = [&](int dictx) -> identTable_t* {
		switch ( dictx ) {
			case DInfoCtx_Default:    return inspect_var_names.get();
			case DInfoCtx_LabelNames: return inspect_lab_names.get();
			case DInfoCtx_PrmNames:   return inspect_prm_names.get();
			default: throw;
		}
	};

	auto const dinfo = reinterpret_cast<unsigned char const*>(di_buf->GetBuffer());
	int const max_di = di_buf->GetSize() / sizeof(unsigned char);

	int dictx = DInfoCtx_Default;
	for ( int i = 0; i < max_di; ) {
		switch ( dinfo[i] ) {
			case 0xFF:
				++dictx;  // enum を ++ する業
				++i;
				if ( dictx == DInfoCtx_Max ) goto break_loop;
				break;

			// ソースファイル指定
			case 0xFE: i += 6; break;

			// 識別子指定
			case 0xFD:
			case 0xFB:
				if ( auto* tbl = getIdentTableFromCtx(dictx) ) {
					char* const ident = &ds_buf->GetBuffer()[tripeek(&dinfo[i + 1])];
					int const iparam = wpeek(&dinfo[i + 4]);
					tbl->insert({ iparam, ident });
				}
				i += 6;
				break;

			// 次の命令までのCSオフセット値
			case 0xFC: i += 3; break;
			default: ++i; break;
		}
	}
break_loop:
	return;
}

#endif

char const* stringFromCalcCode(int op)
{
	static char const* table[] = {
		"+", "-", "*", "/", "\\", "&", "|", "^",
		"=", "!", ">", "<", ">=", "<=", ">>", "<<"
	};
	assert(0 <= op && op < CALCCODE_MAX);
	return table[op];
}
