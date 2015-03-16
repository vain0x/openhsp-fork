
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

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

#include "errormsg.h"

#include <assert.h>

AxCode::AxCode(CToken* tk)
	: tk_(tk)
	, hed_buf(new HSPHED)
	, cs_buf(new CMemBuf)
	, ds_buf(new CMemBuf)
	, ot_buf(new CMemBuf)
	, di_buf(new CMemBuf)
	, li_buf(new CMemBuf)
	, fi_buf(new CMemBuf)
	, mi_buf(new CMemBuf)
	, fi2_buf(new CMemBuf)
	, hpi_buf(new CMemBuf)
	, working_ot_buf(new std::decay_t<decltype(*working_ot_buf)>())
	, cg_varhpi(0)
	, cg_stnum(0)
	, cg_stsize(0)
	, cg_stptr(0)
{
	if ( tk->CG_optShort() ) {
		string_literal_table.reset(new std::map<std::string, int>());
		double_literal_table.reset(new std::map<double, int>());

		otindex_table.reset(new std::decay_t<decltype(*otindex_table)>());
		label_reference_table.reset(new std::decay_t<decltype(*label_reference_table)>());
	}
}

unsigned short* AxCode::GetCSBuffer() const
{
	return reinterpret_cast<unsigned short*>(cs_buf->GetBuffer());
}
STRUCTDAT* AxCode::GetFIBuffer() const
{
	return reinterpret_cast<STRUCTDAT*>(fi_buf->GetBuffer());
}
STRUCTPRM* AxCode::GetMIBuffer() const
{
	return reinterpret_cast<STRUCTPRM*>(mi_buf->GetBuffer());
}
size_t AxCode::GetFICount() const {
	return fi_buf->GetSize() / sizeof(STRUCTDAT);
}
int* AxCode::GetOTBuffer() const {
	return reinterpret_cast<int*>(ot_buf->GetBuffer());
}
HSPHED const& AxCode::GetHeader() const {
	return *hed_buf;
}

void AxCode::PutCS(int type, int value, int exflg)
{
	//		Register command code
	//		(HSP ver3.3以降用)
	//			type=0-0xfff ( -1 to debug line info )
	//			val=16,32bit length supported
	//
	assert(type != TYPE_XLABEL);
	if ( tk_->CG_optShort() && type == TYPE_LABEL ) {
		label_reference_table->insert({ value, GetCS() });
		//Mesf("#ラベル参照 (cs#%d -> ot#%d)", GetCS(), value);
	}

	int a;
	unsigned int v;
	v = (unsigned int)value;

	a = (type & CSTYPE) | exflg;
	if ( v < 0x10000 ) {						// when 16bit encode
		cs_buf->Put((short)(a));
		cs_buf->Put((short)(v));
	} else {									// when 32bit encode
		cs_buf->Put((short)(EXFLG_3 | a));
		cs_buf->Put((int)value);
	}
}

void AxCode::PutCS(int type, double value, int exflg)
{
	//		Register command code (double)
	//
	int i = ds_buf->GetSize();
	bool needsToPutDS = true;

	// double literal pool
	if ( tk_->CG_optShort() ) {
		auto const it = double_literal_table->find(value);
		if ( it != double_literal_table->end() ) {
			i = it->second;
			needsToPutDS = false;
			if ( tk_->CG_optInfo() ) { tk_->Mesf("#double_literal_pool(%f) %s", value, tk_->CG_scriptPositionString()); }
		} else {
			double_literal_table->insert({ value, i });
		}
	}

	if ( needsToPutDS ) {
		ds_buf->Put(value);
	}
	PutCS(type, i, exflg);
}

int AxCode::PutCSJumpOffsetPlaceholder()
{
	int const cs_index = GetCS();
	cs_buf->Put(static_cast<short>(0));
	return cs_index;
}

int AxCode::GetCS(void)
{
	//		Get current CS index
	//
	return (cs_buf->GetSize()) >> 1;
}

void AxCode::SetCS(int csindex, int type, int value)
{
	// コードセグメントに上書きする
	// bit 数は固定されているので注意

	assert(0 <= csindex && csindex < GetCS());
	unsigned short* const cscode = &GetCSBuffer()[csindex];
	auto const _type = *cscode & CSTYPE;
	auto const _exf = *cscode &~CSTYPE;

	*cscode = type | _exf;
	if ( _exf & EXFLG_3 ) {
		*reinterpret_cast<int*>(cscode + 1) = value;
	} else {
		assert(static_cast<unsigned int>(value) < 0x10000);  // when 16 bit encode
		cscode[1] = value;
	}
}

void AxCode::SetCSJumpOffset(int csindex, short offset)
{
	GetCSBuffer()[csindex] = offset;
}

void AxCode::SetCSAddExflag(int csindex, int exflag)
{
	auto const p = &GetCSBuffer()[csindex];
	*p |= exflag & ~CSTYPE;
}

int AxCode::PutDS(char *str)
{
	//		Register strings to data segment (script string)
	//

	// output as UTF8 format
	if ( tk_->CG_OutputsUtf8() ) {
		int const i = ds_buf->GetSize();
		char* const p = tk_->ExecSCNV(str, SCNV_OPT_SJISUTF8);
		size_t size = strlen(p) + 1;
		ds_buf->PutData(p, static_cast<int>(size));
		return i;
	}

	return PutDSBuf(str);
}

int AxCode::PutDSBuf(char *str)
{
	//		Register strings to data segment (direct)
	//
	int i;
	i = ds_buf->GetSize();

	// string literal pool
	// todo: UTF8に対応。そのまま適用できるか調べるか、または対応できるようにする
	if ( tk_->CG_optShort() ) {
		auto const it = string_literal_table->find(str);
		if ( it != string_literal_table->end() ) {
			i = it->second;
			if ( tk_->CG_optInfo() ) tk_->Mesf("#string_literal_pool {\"%s\"} %s", str, tk_->CG_scriptPositionString());
			return i;
		} else {
			string_literal_table->insert({ std::string(str), i });
		}
	}

	ds_buf->PutStr(str);
	ds_buf->Put((char)0);
	return i;
}

int AxCode::PutDSBuf(char *str, int size)
{
	//		Register strings to data segment (direct)
	//
	int i;
	i = ds_buf->GetSize();
	ds_buf->PutData(str, size);
	return i;
}


int AxCode::PutOT(int value)
{
	// ラベル(cs位置参照)オブジェクトを確保し、そのIDを返す
	// 参照先のcs位置が未確定の場合 (if文のジャンプ先など)、value < 0 で登録される。
	//
	int const i = GetOTCount();
	working_ot_buf->push_back(value);
	return i;
}


void AxCode::SetOT(int id, int value)
{
	// ラベル(cs位置参照)オブジェクトの参照先を確定させる
	//
	assert(0 <= id && id < (int)working_ot_buf->size());

	auto& ref = working_ot_buf->at(id);
	assert(ref < 0); // 未確定でなければならない

	ref = value;
}

int AxCode::GetOT(int id)
{
	assert(0 <= id && id < (int)working_ot_buf->size());
	return working_ot_buf->at(id);
}
int AxCode::GetOTCount() { return working_ot_buf->size(); }

void AxCode::PutOTBuf()
{
	// OTバッファを書き出す
	// 最適化: ラベルの重複を取り除き、otindex を割り振りなおす

	assert(ot_buf->GetSize() == 0);
	int ot_count = 0;

	for ( int i = 0; i < static_cast<int>(working_ot_buf->size()); ++i ) {
		auto const csindex = working_ot_buf->at(i);
		assert(csindex >= 0);  // すべてのラベルが確定済みのはず

		if ( tk_->CG_optShort() ) {
			//同じ参照先をもつ既存ラベルをみつける
			int const new_ot_index = GetNewOTFromOldOT(i);
			if ( new_ot_index >= 0 ) {
				//Mesf("#重複ラベルを発見 (otindex = %d -> %d; csindex = %d)", i, new_ot_index, csindex);
				continue;  // skip output
			} else {
				otindex_table->insert({ csindex, ot_count });
			}
		}
		ot_buf->Put(csindex); ot_count++;
	}

	if ( tk_->CG_optShort() ) {
		// cs からの参照を書き換える
		for ( auto kv : *label_reference_table ) {
			int const new_ot_index = GetNewOTFromOldOT(kv.first);
			assert(new_ot_index >= 0);
			if ( kv.second != new_ot_index ) {
				//Mesf("#ラベル参照の書き換え (cs#%d, ot#%d -> %d)", kv.second, kv.first, new_ot_index);
				SetCS(kv.second, TYPE_LABEL, new_ot_index);
			}
		}
		// deffunc/defcfunc の呼び出し先を書き換える
		for ( size_t i = 0; i < GetFICount(); ++i ) {
			auto const stdat = &GetFIBuffer()[i];
			if ( stdat->index == STRUCTDAT_INDEX_FUNC || stdat->index == STRUCTDAT_INDEX_CFUNC ) {
				int const new_ot_index = GetNewOTFromOldOT(stdat->otindex);
				//Mesf("#ラベル参照の書き換え (stdat#%d, ot#%d -> %d)", i, stdat->otindex, new_ot_index);
				stdat->otindex = new_ot_index;
			}
		}
	}
}

int AxCode::GetNewOTFromOldOT(int old_otindex)
{
	if ( !tk_->CG_optShort() ) return old_otindex;

	assert(0 <= old_otindex && old_otindex < (int)working_ot_buf->size());
	auto iter = otindex_table->find(working_ot_buf->at(old_otindex));
	return (iter != otindex_table->end()) ? iter->second : -1;
};

void AxCode::PutDIOffset(int offset)
{
	//		Debug code register
	//
	//		mem_di formats :
	//			0-250           = offset to old mcs
	//			252,x(16)       = big offset
	//			253,x(24),y(16) = used val (x=mds ptr.)
	//			254,x(24),y(16) = new filename accepted (x=mds ptr.)
	//			255             = end of debug data
	//
	if ( offset < DInfoCode::CodeMin ) {
		di_buf->Put((unsigned char)offset);
	} else {
		di_buf->Put((unsigned char)DInfoCode::WideOffset);
		di_buf->Put(static_cast<unsigned char>((offset >> 0) & 0xFF));
		di_buf->Put(static_cast<unsigned char>((offset >> 8) & 0xFF));
	}
}

void AxCode::PutDI(int dbg_code, int value, int subid)
{
	//		special Debug code register
	//			in : -1=end of code
	//				254=(a=file ds ptr./subid=line num.)
	//
	if ( dbg_code < 0 ) {
		ds_buf->Put(DInfoCode::ChangeContext);
		ds_buf->Put(DInfoCode::ChangeContext);
	} else {
		di_buf->Put(static_cast<unsigned char>(dbg_code));
		di_buf->Put(static_cast<unsigned char>((value >>  0) & 0xFF));
		di_buf->Put(static_cast<unsigned char>((value >>  8) & 0xFF));
		di_buf->Put(static_cast<unsigned char>((value >> 16) & 0xFF));
		di_buf->Put(static_cast<unsigned char>(subid));
		di_buf->Put(static_cast<unsigned char>(subid >> 8));
	}
}

void AxCode::PutDIFinal(CLabel& lb_ref, bool is_debug_compile, bool includes_varnames)
{
	CLabel* const lb = &lb_ref;

	if ( is_debug_compile || includes_varnames ) {
		PutDIVars(lb);
	}
	if ( is_debug_compile ) {
		PutDILabels(lb);
		PutDIParams(lb);
	}
	PutDI(-1, 0, 0);   // デバッグ情報終端
	return;
}

void AxCode::PutDIVars(CLabel* lb)
{
	//		Debug info register for vals
	//
	char vtmpname[256]; // [OBJNAME_MAX + 4]
	char *p;

	strcpy(vtmpname, "I_");
	for ( int id = 0; id < lb->GetNumEntry(); ++id ) {
		auto const lab = lb->GetLabel(id);
		if ( lab->type == TK_OBJ ) {
			switch ( lab->typefix ) {
				case LAB_TYPEFIX_INT:
					vtmpname[0] = 'I';
					p = vtmpname;
					strcpy(p + 2, lab->name);
					break;
				case LAB_TYPEFIX_DOUBLE:
					vtmpname[0] = 'D';
					p = vtmpname;
					strcpy(p + 2, lab->name);
					break;
				case LAB_TYPEFIX_NONE:
				default:
					p = lab->name;
					break;
			}
			int const ds_index = PutDSBuf(p);
			PutDI(DInfoCode::VarName, ds_index, lab->opt);
		}
	}
}

// ラベル名の情報を出力する
// 識別子表(lb)は古い ot_index を用いて書かれているので注意
void AxCode::PutDILabels(CLabel* lb)
{
	int const num = GetOTCount();  // old ot_index の数
	std::vector<int> table;
	table.resize(num, -1);  // 無効値で初期化

	//識別子表からラベル名を抽出し、ラベルの名前として登録する
	for ( int i = 0; i < lb->GetNumEntry(); i++ ) {
		if ( lb->GetType(i) == TYPE_LABEL ) {
			int id = lb->GetOpt(i);
			table[id] = i;
		}
	}

	//ラベル名のリストを書き出す
	ds_buf->Put(DInfoCode::ChangeContext);
	for ( int i = 0; i < num; i++ ) {
		if ( table[i] == -1 ) continue;
		char *name = lb->GetName(table[i]);
		int dsPos = PutDSBuf(name);
		PutDI(DInfoCode::DebugIdent, dsPos, GetNewOTFromOldOT(i));
	}
}


// 引数名の情報を出力する
void AxCode::PutDIParams(CLabel* lb)
{
	ds_buf->Put(DInfoCode::ChangeContext);
	for ( int i = 0; i < lb->GetNumEntry(); i++ ) {
		if ( lb->GetType(i) == TYPE_STRUCT ) {
			int id = lb->GetOpt(i);
			if ( id < 0 ) continue;
			char *name = lb->GetName(i);
			int dsPos = PutDSBuf(name);
			PutDI(DInfoCode::DebugIdent, dsPos, id);
		}
	}
}

char *AxCode::GetDS(int ptr)
{
	if ( ptr >= ds_buf->GetSize() ) return nullptr;
	return &ds_buf->GetBuffer()[ptr];
}

int AxCode::PutLIB(int flag, char *name)
{
	int a, i = -1, p;
	LIBDAT lib;
	LIBDAT *l;
	p = li_buf->GetSize() / sizeof(LIBDAT);
	l = (LIBDAT *)li_buf->GetBuffer();

	if ( flag == LIBDAT_FLAG_DLL ) {
		if ( *name != 0 ) {
			for ( a = 0; a<p; a++ ) {
				if ( l->flag == flag ) {
					if ( strcmp(GetDS(l->nameidx), name) == 0 ) {
						return a;
					}
				}
				l++;
			}
			i = PutDSBuf(name);
		} else {
			i = -1;
		}
	}
	if ( flag == LIBDAT_FLAG_COMOBJ ) {
		COM_GUID guid;
		if ( ConvertIID(&guid, name) ) return -1;
		i = PutDSBuf((char *)&guid, sizeof(COM_GUID));
	}

	lib.flag = flag;
	lib.nameidx = i;
	lib.hlib = NULL;
	lib.clsid = -1;
	li_buf->PutData(&lib, sizeof(LIBDAT));
	//Mesf( "LIB#%d:%s",flag,name );

	return p;
}


void AxCode::SetLIBIID(int id, char *clsid)
{
	LIBDAT *l;
	l = (LIBDAT *)li_buf->GetBuffer();
	l += id;
	if ( *clsid == 0 ) {
		l->clsid = -1;
	} else {
		l->clsid = PutDSBuf(clsid);
	}
}


int AxCode::PutStructParam(short mptype, int extype)
{
	int size;
	int i;
	STRUCTPRM prm;

	i = mi_buf->GetSize() / sizeof(STRUCTPRM);

	prm.mptype = mptype;
	if ( extype == STRUCTPRM_SUBID_STID ) {
		prm.subid = (short)GetFICount();
	} else {
		prm.subid = extype;
	}
	prm.offset = cg_stsize;

	size = 0;
	switch ( mptype ) {
		case MPTYPE_INUM:
		case MPTYPE_STRUCT:
			size = sizeof(int);
			break;
		case MPTYPE_LOCALVAR:
			size = sizeof(PVal);
			break;
		case MPTYPE_DNUM:
			size = sizeof(double);
			break;
		case MPTYPE_FLOAT:
			size = sizeof(float);
			break;
		case MPTYPE_LOCALSTRING:
		case MPTYPE_STRING:
		case MPTYPE_LABEL:
		case MPTYPE_PPVAL:
		case MPTYPE_PBMSCR:
		case MPTYPE_PVARPTR:
		case MPTYPE_IOBJECTVAR:
		case MPTYPE_LOCALWSTR:
		case MPTYPE_FLEXSPTR:
		case MPTYPE_FLEXWPTR:
		case MPTYPE_PTR_REFSTR:
		case MPTYPE_PTR_EXINFO:
		case MPTYPE_PTR_DPMINFO:
		case MPTYPE_NULLPTR:
			size = sizeof(char *);
			break;
		case MPTYPE_SINGLEVAR:
		case MPTYPE_ARRAYVAR:
			size = sizeof(MPVarData);
			break;
		case MPTYPE_MODULEVAR:
		case MPTYPE_IMODULEVAR:
		case MPTYPE_TMODULEVAR:
			size = sizeof(MPModVarData);
			break;
		default:
			return i;
	}
	cg_stsize += size;
	cg_stnum++;
	mi_buf->PutData(&prm, sizeof(STRUCTPRM));
	return i;
}


int AxCode::PutStructParamTag()
{
	int i;
	STRUCTPRM prm;

	i = mi_buf->GetSize() / sizeof(STRUCTPRM);

	prm.mptype = MPTYPE_STRUCTTAG;
	prm.subid = (short)GetFICount();
	prm.offset = -1;

	cg_stnum++;
	mi_buf->PutData(&prm, sizeof(STRUCTPRM));
	return i;
}


void AxCode::PutStructStart()
{
	cg_stnum = 0;
	cg_stsize = 0;
	cg_stptr = mi_buf->GetSize() / sizeof(STRUCTPRM);
}


int AxCode::PutStructEnd(int i, char *name, int libindex, int otindex, int funcflag)
{
	//		STRUCTDATを登録する(モジュール用)
	//

	if ( i < 0 ) {
		i = GetFICount();
		fi_buf->PreparePtr(sizeof(STRUCTDAT));
	}

	STRUCTDAT st;
	st.index = libindex;
	st.nameidx = PutDSBuf(name);
	st.subid = i;
	st.prmindex = cg_stptr;
	st.prmmax = cg_stnum;
	st.funcflag = funcflag;
	st.size = cg_stsize;
	if ( otindex < 0 ) {
		st.otindex = 0;
		st.subid = otindex;
	} else {
		st.otindex = otindex;
	}
	GetFIBuffer()[i] = st;
	//Mesf( "#%d : %s(LIB%d) prm%d size%d ot%d", i, name, libindex, cg_stnum, cg_stsize, otindex );
	return i;
}


int AxCode::PutStructEnd(char *name, int libindex, int otindex, int funcflag)
{
	return PutStructEnd(-1, name, libindex, otindex, funcflag);
}

int AxCode::PutStructEndDll(char *name, int libindex, int subid, int otindex)
{
	//		STRUCTDATを登録する(DLL用)
	//
	int i;
	STRUCTDAT st;
	i = GetFICount();
	st.index = libindex;
	st.nameidx = (name ? PutDSBuf(name) : -1);
	st.subid = subid;
	st.prmindex = cg_stptr;
	st.prmmax = cg_stnum;
	st.proc = NULL;
	st.size = cg_stsize;
	st.otindex = otindex;
	fi_buf->PutData(&st, sizeof(STRUCTDAT));
	//Mesf( "#%d : %s(LIB%d) prm%d size%d ot%d", i, name, libindex, cg_stnum, cg_stsize, otindex );
	return i;
}

int AxCode::PutStructDummy(int label_id)
{
	int const subid = GetFICount();
	STRUCTDAT st = { STRUCTDAT_INDEX_DUMMY };
	st.otindex = label_id;
	fi_buf->PutData(&st, sizeof(STRUCTDAT));
	return subid;
}

void AxCode::PutHPI(short flag, short option, char *libname, char *funcname, int var_type_cnt)
{
	HPIDAT hpi;
	hpi.flag = flag;
	hpi.option = option;
	hpi.libname = PutDSBuf(libname);
	hpi.funcname = PutDSBuf(funcname);
	hpi.libptr = NULL;
	hpi_buf->PutData(&hpi, sizeof(HPIDAT));

	cg_varhpi += var_type_cnt;
}

void AxCode::WriteToBuf(CMemBuf& axbuf, CToken::HeaderInfo& hed_info, int mode, int cg_valcnt)
{
	HSPHED& hsphed = *hed_buf;
	size_t hed_size = sizeof(HSPHED);
	size_t const cs_size = cs_buf->GetSize();
	size_t const ds_size = ds_buf->GetSize();
	size_t const ot_size = ot_buf->GetSize();
	size_t const di_size = di_buf->GetSize();
	size_t const li_size = li_buf->GetSize();
	size_t const fi_size = fi_buf->GetSize();
	size_t const mi_size = mi_buf->GetSize();
	size_t const fi2_size = fi2_buf->GetSize();
	size_t const hpi_size = hpi_buf->GetSize();

	CMemBuf optbuf;    // オプション文字列用バッファ

	if ( hed_info.option & HEDINFO_RUNTIME ) {
		optbuf.PutStr(hed_info.runtime);
	}
	size_t opt_size = optbuf.GetSize();
	if ( opt_size ) {
		for (;;) {
			size_t const adjsize = (opt_size + 15) & 0xfff0;
			if ( adjsize == opt_size ) break;
			optbuf.Put((char)0);
			opt_size = optbuf.GetSize();
		}
		hsphed.bootoption |= HSPHED_BOOTOPT_RUNTIME;
		hsphed.runtime = hed_size;
		hed_size += opt_size;
	}

	hsphed.bootoption |= ( 0
		//		デバッグウインドゥ表示
		| (( mode & COMP_MODE_DEBUGWIN) ? HSPHED_BOOTOPT_DEBUGWIN : 0)
		//		起動オプションの設定
		| (( hed_info.autoopt_timer == 0 || (( hed_info.option & HEDINFO_NOMMTIMER) != 0))
			? HSPHED_BOOTOPT_NOMMTIMER : 0)
		| (((hed_info.option & HEDINFO_NOGDIP ) != 0) ?  HSPHED_BOOTOPT_NOGDIP : 0)
		| (((hed_info.option & HEDINFO_FLOAT32) != 0) ?  HSPHED_BOOTOPT_FLOAT32 : 0)
		| (((hed_info.option & HEDINFO_ORGRND ) != 0) ?  HSPHED_BOOTOPT_ORGRND : 0)
	);

	hsphed.h1 = 'H';
	hsphed.h2 = 'S';
	hsphed.h3 = 'P';
	hsphed.h4 = '3';
	hsphed.version = 0x0350;						// version3.5
	hsphed.max_val = cg_valcnt;						// max count of VAL Object
	hsphed.allsize =
		hed_size + cs_size + ds_size + ot_size + di_size
		+ li_size + fi_size + mi_size + fi2_size + hpi_size;

	hsphed.pt_cs = hed_size;						// ptr to Code Segment
	hsphed.max_cs = cs_size;						// size of CS
	hsphed.pt_ds = hed_size + cs_size;				// ptr to Data Segment
	hsphed.max_ds = ds_size;						// size of DS
	hsphed.pt_ot = hsphed.pt_ds + ds_size;			// ptr to Object Temp
	hsphed.max_ot = ot_size;						// size of OT
	hsphed.pt_dinfo = hsphed.pt_ot + ot_size;		// ptr to Debug Info
	hsphed.max_dinfo = di_size;						// size of DI

	hsphed.pt_linfo = hsphed.pt_dinfo + di_size;	// ptr to Debug Info
	hsphed.max_linfo = li_size;						// size of LINFO

	hsphed.pt_finfo = hsphed.pt_linfo + li_size;	// ptr to Debug Info
	hsphed.max_finfo = fi_size;						// size of FINFO

	hsphed.pt_minfo = hsphed.pt_finfo + fi_size;	// ptr to Debug Info
	hsphed.max_minfo = mi_size;						// size of MINFO

	hsphed.pt_finfo2 = hsphed.pt_minfo + mi_size;	// ptr to Debug Info
	hsphed.max_finfo2 = fi2_size;					// size of FINFO2

	hsphed.pt_hpidat = hsphed.pt_finfo2 + fi2_size;	// ptr to Debug Info
	hsphed.max_hpi = hpi_size;						// size of HPIDAT
	hsphed.max_varhpi = cg_varhpi;					// Num of Vartype Plugins

	hsphed.pt_sr = hed_size;						// ptr to Option Segment
	hsphed.max_sr = opt_size;						// size of Option Segment
	hsphed.opt1 = 0;
	hsphed.opt2 = 0;

	axbuf.PutData(&hsphed, sizeof(HSPHED));
	if ( opt_size ) axbuf.PutData(optbuf.GetBuffer(), opt_size);

	axbuf.PutData(cs_buf->GetBuffer(), cs_size);
	axbuf.PutData(ds_buf->GetBuffer(), ds_size);
	axbuf.PutData(ot_buf->GetBuffer(), ot_size);
	axbuf.PutData(di_buf->GetBuffer(), di_size);
	axbuf.PutData(li_buf->GetBuffer(), li_size);
	axbuf.PutData(fi_buf->GetBuffer(), fi_size);
	axbuf.PutData(mi_buf->GetBuffer(), mi_size);
	axbuf.PutData(fi2_buf->GetBuffer(), fi2_size);
	axbuf.PutData(hpi_buf->GetBuffer(), hpi_size);

	return;
}
