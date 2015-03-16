#pragma once

#include <memory>
#include <map>
#include <vector>
#include <string>

struct HSPHED;
class CLabel;
class CMemBuf;
class CToken;
class AxCodeInspector;

namespace DInfoCode {
	static unsigned char const
		ChangeContext = 0xFF,   // 255; 次の文脈に移行する。2連続なら末尾を表す。
		SourceFile = 0xFE,      // 254; ソースファイル指定
		VarName = 0xFD,         // 253; 変数名の記録
		DebugIdent = 0xFB,      // 251; デバッグ時識別子(ラベル、仮引数名)の記録
		WideOffset = 0xFC,      // 252; 次の命令までのCSオフセット値 (16bit)
		CodeMin = 0xFB;         // 251: (特別な意味で扱うコードの最小値)
};

#define STRUCTDAT_INDEX_DUMMY ((short)0x8000)

class AxCode
{
	friend AxCodeInspector;
private:
	CToken* tk_;

	std::unique_ptr<HSPHED> hed_buf;
	std::unique_ptr<CMemBuf> cs_buf;
	std::unique_ptr<CMemBuf> ds_buf;
	std::unique_ptr<CMemBuf> ot_buf;
	std::unique_ptr<CMemBuf> di_buf;
	std::unique_ptr<CMemBuf> li_buf;
	std::unique_ptr<CMemBuf> fi_buf;
	std::unique_ptr<CMemBuf> mi_buf;
	std::unique_ptr<CMemBuf> fi2_buf;
	std::unique_ptr<CMemBuf> hpi_buf;

	std::unique_ptr<std::map<std::string, int>> string_literal_table;
	std::unique_ptr<std::map<double, int>> double_literal_table;
	std::unique_ptr<std::vector<int>> working_ot_buf; // コードの解析中にラベル(cs位置)の情報を記憶しておく。あとでまとめて ot_buf に書き出される
	std::unique_ptr<std::multimap<int, int>> label_reference_table; // キーであるラベル(otindex)を参照しているcs位置の表。otindexの重複除去に使う。
	std::unique_ptr<std::map<int, int>> otindex_table; //csindex -> new otindex (or -1)

	int cg_varhpi;  // hpi が宣言した変数型の数

	// for Struct
	int	cg_stnum;
	int	cg_stsize;
	int cg_stptr;

public:
	AxCode(CToken* tk);

	HSPHED const& GetHeader() const;
	STRUCTDAT* GetFIBuffer() const;
	size_t GetFICount() const;
	STRUCTPRM* GetMIBuffer() const;

	//		for Code Generator
	int GetCS();
	void PutCS(int type, double value, int exflg);
	void PutCS(int type, int value, int exflg);
	void PutCSSymbol(int label_id, int exflag);
	int PutCSJumpOffsetPlaceholder();
	void SetCS(int csindex, int type, int value);
	void SetCSJumpOffset(int csindex, short offset);
	void SetCSAddExflag(int csindex, int exflag);

	int PutOT(int value);
	void PutOTBuf();
	int PutDS(char *str);
	int PutDSBuf(char *str);
	int PutDSBuf(char *str, int size);
	char *GetDS(int ptr);
	void SetOT(int id, int value);
	int GetOT(int id); int GetOTCount();
	int GetNewOTFromOldOT(int old_otindex);

	void PutDI(int dbg_code, int value, int subid);
	void PutDIOffset(int offset);
	void PutDIFinal(CLabel& lb, bool is_debug_compile, bool includes_varnames);
private:
	void PutDIVars(CLabel* lb);
	void PutDILabels(CLabel* lb);
	void PutDIParams(CLabel* lb);
public:
	void PutHPI(short flag, short option, char *libname, char *funcname, int var_type_cnt);
	int PutLIB(int flag, char *name);
	void SetLIBIID(int id, char *clsid);

	int PutStructParam(short mptype, int extype);
	int PutStructParamTag();
	void PutStructStart();
	int PutStructEnd(char *name, int libindex, int otindex, int funcflag);
	int PutStructEnd(int i, char *name, int libindex, int otindex, int funcflag);
	int PutStructEndDll(char *name, int libindex, int subid, int otindex);
	int PutStructDummy(int label_id);

	void WriteToBuf(CMemBuf& axbuf,
		CToken::HeaderInfo& hi, int mode, int cg_valcnt);

private:
	unsigned short* GetCSBuffer() const;  // codegen側からcsに書き込むため
	int* GetOTBuffer() const;

};

class AxCodeInspector
{
	//		For inspection
public:
	AxCodeInspector(AxCode& owner);

#ifdef HSPINSPECT
	std::shared_ptr<CMemBuf> GetBuffer() { return axi_buf; }
private:
	void CodeSegment();
	int  CSElem(int csindex);
	void FInfoSegment();
	void LInfoSegment();
	void HpiSegment();

	void AnalyzeDInfo();
	void BeginSegment(char const* segment_title);

	char const* TypeName(int type);

private:
	AxCode& ax_;

	std::shared_ptr<CMemBuf> axi_buf;

	using identTable_t = std::map<int, char const*>;
	std::unique_ptr<identTable_t> inspect_var_names;
	std::unique_ptr<identTable_t> inspect_lab_names;
	std::unique_ptr<identTable_t> inspect_prm_names;
#endif
};
