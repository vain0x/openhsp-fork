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
#include "axcode.h"
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

static char const* inspectInternalType(int type);
static char const* inspectLibDatFlag(int flag);
static char const* inspectMPType(int mptype);

int CToken::SaveAxInspection(char* fname)
{
	return (axi_buf ? axi_buf->SaveFile(fname) : -1);
}

void CToken::InspectAxCode()
{
	assert(!axi_buf);
	axi_buf.reset(new CMemBuf());
	AxCodeInspector inspector { *axcode, axi_buf };
	return;
}

AxCodeInspector::AxCodeInspector(AxCode& ax, std::shared_ptr<CMemBuf> buf)
	: ax_(ax)
	, axi_buf(buf)
{
	PutCodeSegment();
	PutFInfoSegment();
	PutLInfoSegment();
	PutHpiSegment();
}

void AxCodeInspector::PutSegmentTitle(char const* segment_title)
{
	axi_buf->PutStrf("[%s]", segment_title);
	axi_buf->PutCR();
}

void AxCodeInspector::PutCodeSegment()
{
	//todo: タブ文字ではなく桁数指定で揃えたい
	PutSegmentTitle("CodeSegment");
	axi_buf->PutStr("位置\tタイプ\t\t値\t単項\t文頭\tカンマ\t分岐先\t値の意味");
	axi_buf->PutCR();
	for ( int i = 0; i < ax_.GetCS(); ) {
		i += PutCSElemInspection(i);
	}
	axi_buf->PutCR();
}

size_t AxCodeInspector::PutCSElemInspection(int csindex)
{
	auto const cur_cs = &ax_.GetCSBuffer()[csindex];
	//analyze single code
	int const c = cur_cs[0];
	int const type = c & CSTYPE;
	bool const exflags[] =
		{ (c & EXFLG_0) != 0, (c & EXFLG_1) != 0, (c & EXFLG_2) != 0, (c & EXFLG_3) != 0 };
	int const value =
		exflags[3] ? *reinterpret_cast<int*>(&cur_cs[1]) : cur_cs[1];
	size_t code_size =
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
		<< InspectType(type) << '\t'
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
				output << inspectCalcCode(value);
			} else {
				assert(value == '(' || value == ')' || value == '[' || value == ']' || value == '?');
				output << static_cast<char>(value);
			}
			break;
		}
		case TYPE_STRING:
			output << "{\"" << (ax_.GetDS(value)) << "\"}";
			break;
		case TYPE_DNUM:
			output << *reinterpret_cast<double*>(ax_.GetDS(value));
			break;
		case TYPE_INUM: output << value; break;
		case TYPE_VAR:  InspectVar(output, value); break;
		case TYPE_LABEL: InspectLabel(output, value); break;
		case TYPE_MODCMD: InspectModcmd(output, value); break;
		case TYPE_STRUCT: InspectParam(output, value); break;
		default: {
			assert(type >= TYPE_INTCMD);
			char const* const registered_command = TryFindIdentName(type, value);
			if ( registered_command ) {
				output << registered_command;
			} else {
				output << "unknown";
			}
			break;
		}
	}

	axi_buf->PutStr(output.str().c_str());
	axi_buf->PutCR();
	return code_size;
}

char const* AxCodeInspector::TryFindIdentName(int type, int opt) const
{
	// コンパイラがもつ識別子表からの検索を行うヘルパ関数
	// button, onexit などのgoto/gosubと連鎖する命令は opt に 0x10000 がついているので注意
	// #cmd で定義されるプラグインコマンドも一緒にみつかるはず

	if ( type == TYPE_PROGCMD && opt == 0x00C ) { //識別子未定義の隠しコマンド
		return "_foreach_check@hsp";
	}

	auto const lb = ax_.tk_->GetLabelInfo();
	int id = 0;
	for ( ; id < lb->GetNumEntry(); ++id ) {
		if ( lb->GetType(id) == type && (lb->GetOpt(id) & 0xFFFF) == opt ) {
			return lb->GetName(id);
		}
	}
	return nullptr;
}

char const* AxCodeInspector::TryFindLabelName(int ot_index) const
{
	int const old_ot_index = ax_.GetOldOTIndex(ot_index);
	return TryFindIdentName(TYPE_LABEL, old_ot_index);
}
char const* AxCodeInspector::TryFindParamName(int mi_index) const
{
	return TryFindIdentName(TYPE_STRUCT, mi_index);
}
char const* AxCodeInspector::TryFindVarName(int var_index) const
{
	return TryFindIdentName(TYPE_VAR, var_index);
}

void AxCodeInspector::InspectVar(std::ostringstream& os, int var_index) const
{
	char const* const name = TryFindVarName(var_index);
	if ( name ) {
		os << name;
	} else {
		os << "(var#" << var_index << ')';
	}
}

void AxCodeInspector::InspectLabel(std::ostringstream& os, int ot_index) const
{
	os << '*';

	char const* const name = TryFindLabelName(ot_index);
	if ( name ) {
		os << name;
	} else {
		os << "(lb#" << ot_index << ')';
	}

	int const cs_index = ax_.GetOTBuffer()[ot_index];
	os << "->" << cs_index;
}

void AxCodeInspector::InspectParam(std::ostringstream& os, int mi_index) const
{
	if ( mi_index < 0 ) {
		os << "thismod";
		return;
	}

	auto const stprm = &ax_.GetMIBuffer()[mi_index];
	auto stdat = (stprm->subid >= 0)
		? &ax_.GetFIBuffer()[stprm->subid]
		: nullptr;

	// module tag (newmod の第2引数)
	if ( stdat && stprm->mptype == MPTYPE_STRUCTTAG ) {
		os << ax_.GetDS(stdat->nameidx);
		return;
	}

	// パラメータエイリアス、またはローカル変数(メンバ変数)
	if (stprm->mptype == MPTYPE_LOCALVAR || stprm->subid == STRUCTPRM_SUBID_STACK) {
		//識別子表から検索
		char const* const registered_param_name = TryFindParamName(mi_index);
		if ( registered_param_name ) {
			os << registered_param_name;
			return;
		}

		//どの関数のパラメータかを検索
		if ( !stdat ) {
			auto const found = std::find_if(MEMBUF_RANGE(STRUCTDAT, *ax_.fi_buf), [&](STRUCTDAT& it) {
				return ((mi_index - it.prmindex) < it.prmmax);
			});
			stdat = (found != MEMBUF_END(STRUCTDAT, *ax_.fi_buf)) ? found : nullptr;
		}
		if ( stdat ) {
			char const* const funcname = ax_.GetDS(stdat->nameidx);
			os << "(prm#" << mi_index << ": " << funcname << "#" << (mi_index - stdat->prmindex) << ")";
		} else {
			os << "(prm#" << mi_index << ")";
		}
	}
}

void AxCodeInspector::InspectModcmd(std::ostringstream& os, int fi_index) const
{
	assert(0 <= fi_index && static_cast<size_t>(fi_index) < ax_.GetFICount());
	auto const stdat = &ax_.GetFIBuffer()[fi_index];
	os << ax_.GetDS(stdat->nameidx);
}

char const* AxCodeInspector::InspectType(int type) const
{
	//todo:プラグインの個数を超えていないことをassertしたい
	assert(type >= 0);
	return ( type < TYPE_USERDEF )
		? inspectInternalType(type)
		: "TYPE_USERDEF";
}

void AxCodeInspector::PutFInfoSegment()
{
	size_t const fi_count = ax_.GetFICount();
	if ( fi_count == 0 ) return;

	PutSegmentTitle("FInfo");
	axi_buf->PutStr("番号\t種類\t名前\tパラメータ");
	axi_buf->PutCR();

	for ( size_t i = 0; i < fi_count; ++i ) {
		auto const& stdat = ax_.GetFIBuffer()[i];
		char const* const name = ax_.GetDS(stdat.nameidx);
		bool const isCType = (stdat.index == STRUCTDAT_INDEX_CFUNC);

		std::ostringstream output;
		switch ( stdat.index ) {
			case STRUCTDAT_INDEX_FUNC:
			case STRUCTDAT_INDEX_CFUNC:
				output << "deffunc"; break;
			case STRUCTDAT_INDEX_STRUCT:
				output << "modcls"; break;
			default:
				assert(0 <= stdat.index && static_cast<size_t>(stdat.index) < MEMBUF_COUNT(LIBDAT, *ax_.li_buf));
				output << "lib#" << stdat.index; break;
		}

		output << '\t' << name << '\t';

		if ( stdat.index < 0 && stdat.funcflag & STRUCTDAT_FUNCFLAG_CLEANUP ) {
			output << " onexit";
		} else {
			//parameter list
			if ( isCType ) { output << '('; }
			for ( int i = 0; i < stdat.prmmax; ++i ) {
				if ( i != 0 ) { output << ", "; }
				int const mi_index = stdat.prmindex + i;
				auto& stprm = MEMBUF_BEGIN(STRUCTPRM, *ax_.mi_buf)[mi_index];

				output << inspectMPType(stprm.mptype);

				if ( stdat.index < 0 ) { // 外部関数でなければエイリアス識別子をつける
					output << ' ';
					InspectParam(output, mi_index);
				}
			}
			if ( isCType ) { output << ')'; }
		}
		axi_buf->PutStrf("%2d\t%s", i, output.str().c_str());
		axi_buf->PutCR();
	}

	axi_buf->PutCR();
}

void AxCodeInspector::PutLInfoSegment()
{
	size_t const li_count = MEMBUF_COUNT(LIBDAT, *ax_.li_buf);
	if ( li_count == 0 ) return;

	PutSegmentTitle("LInfo");
	axi_buf->PutStr("番号\t名称\tフラグ\tクラス");
	axi_buf->PutCR();

	for ( size_t i = 0; i < li_count; ++ i ) {
		auto const& libdat = MEMBUF_BEGIN(LIBDAT, *ax_.li_buf)[i];
		axi_buf->PutStrf("%2d\t%s\t%s\t%s",
			i,
			ax_.GetDS(libdat.nameidx),
			inspectLibDatFlag(libdat.flag),
			(libdat.clsid >= 0 ? ax_.GetDS(libdat.clsid) : "-"));
		axi_buf->PutCR();
	}
	axi_buf->PutCR();
}

void AxCodeInspector::PutHpiSegment()
{
	size_t const hpi_count = MEMBUF_COUNT(LIBDAT, *ax_.hpi_buf);
	if ( hpi_count == 0 ) return;

	PutSegmentTitle("HpiInfo");
	axi_buf->PutStr("番号\t名称\t初期化関数\t新規タイプ");
	axi_buf->PutCR();

	int i = 0;
	for ( size_t i = 0; i < hpi_count; ++i ) {
		auto const& hpidat = MEMBUF_BEGIN(HPIDAT, *ax_.hpi_buf)[i];
		axi_buf->PutStrf("%2d\t%s\t%s\t%s",
			i,
			ax_.GetDS(hpidat.libname),
			ax_.GetDS(hpidat.funcname),
			(hpidat.flag == HPIDAT_FLAG_TYPEFUNC ? "yes" : "-"));
		axi_buf->PutCR();
	}

	axi_buf->PutCR();
}

#endif

char const* inspectInternalType(int type)
{
	static char const* internalTypeNames[] = {
		"TYPE_MARK", "TYPE_VAR", "TYPE_STRING", "TYPE_DNUM", "TYPE_INUM", "TYPE_STRUCT",
		"TYPE_XLABEL", "TYPE_LABEL", "TYPE_INTCMD", "TYPE_EXTCMD", "TYPE_EXTSYSVAR", "TYPE_CMPCMD", "TYPE_MODCMD",
		"TYPE_INTFUNC", "TYPE_SYSVAR", "TYPE_PROGCMD", "TYPE_DLLFUNC", "TYPE_DLLCTRL",
		"TYPE_USERDEF"
	};
	assert(0 <= type && type < TYPE_USERDEF);
	return internalTypeNames[type];
}

char const* inspectLibDatFlag(int flag)
{
	switch ( flag ) {
		case LIBDAT_FLAG_DLL: return "Dll";
		case LIBDAT_FLAG_COMOBJ: return "COM";
		//case LIBDAT_FLAG_DLLINIT:
		//case LIBDAT_FLAG_MODULE:
		default: return "unknown";
	}
}

char const* inspectMPType(int mptype)
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

char const* inspectCalcCode(int op)
{
	static char const* table[] = {
		"+", "-", "*", "/", "\\", "&", "|", "^",
		"=", "!", ">", "<", ">=", "<=", ">>", "<<"
	};
	assert(0 <= op && op < CALCCODE_MAX);
	return table[op];
}
