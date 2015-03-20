
//
//	token.cpp structures
//
#ifndef __token_h
#define __token_h

#include <vector>
#include <map>
#include <set>
#include <memory>

// token type
#define TK_NONE 0
#define TK_OBJ 1
#define TK_STRING 2
#define TK_DNUM 3
#define TK_NUM 4
#define TK_CODE 6
#define TK_LABEL 7
#define TK_VOID 0x1000
#define TK_SEPARATE 0x1001
//#define TK_OPERATOR 0x1002
#define TK_EOL 0x1002
#define TK_EOF 0x1003
#define TK_ERROR -1
#define TK_CALCERROR -2
#define TK_CALCSTOP -3

#define DUMPMODE_RESCMD 3
#define DUMPMODE_DLLCMD 4
#define DUMPMODE_ALL 15

#define CMPMODE_ERROR 0
#define CMPMODE_PPOUT 1        // output proprocessed code
#define CMPMODE_OPTCODE 2      // optimize code
#define CMPMODE_CASE 4         // case sensitive switch
#define CMPMODE_OPTINFO 8      // log optimization info
#define CMPMODE_PUTVARS 16     // output VAR names (DInfo)
#define CMPMODE_VARINIT 32     // check VAR initialization
#define CMPMODE_OPTPRM 64      // parameter optimization switch
#define CMPMODE_SKIPJPSPC 128  // skip japanese space code switch
#define CMPMODE_OPTSHORT 512   // optimaze to code short
#define CMPMODE_AXIOUT 1024    // output ax inspection file

enum class CGFlag : unsigned char {
	Enable = 0,
	Disable,
};

enum class CGLastCmd : unsigned char {
	None = 0,   // 未出力
	Let,        // 代入文
	Cmd,        // 一般のコマンド文
	CmdIf,  // (未実装)
	CmdMIf,
	CmdElse,
	CmdMElse,
};

static size_t const CGIfLevelMax = 128;
static size_t const CGRepeatLevelMax = 128;

// option for 'GetTokenCG'
#define GETTOKEN_DEFAULT 0
#define GETTOKEN_NOFLOAT 1		// '.'を小数点と見なさない(整数のみ取得)
#define GETTOKEN_LABEL 2		// '*'に続く名前をラベルとして取得
#define GETTOKEN_EXPRBEG 4		// 式の先頭

static size_t const CG_LOCALSTRUCT_MAX = 256;

enum class CGIfScope : unsigned char {
	Block = 0,
	Line
};

enum class CGLibMode {
	None = 0,
	Dll,      // #uselib 状態
	DllNew,   // #uselib 状態 (Dll名の指定が初回の場合)
	Com,      // #usecom 状態
	ComNew,   // #usecom 状態 (Dll名の指定が初回の場合)
};

using CALCVAR = double;

#define LINEBUF_MAX 0x10000
#define INCLUDE_LEVEL_MAX 64
#define MACRO_LOOP_MAX 999   // 一行に対してマクロ展開を行う限界の回数

// line mode type
enum class LineMode : unsigned char {
	On = 0,
	String,
	Comment,
	Off,
};

// macro default data storage
typedef struct MACDEF {
	int		index[32];				// offset to data
	char	data[1];
} MACDEF;

// module related define
#define OBJNAME_MAX 60
#define MODNAME_MAX 20

#define COMP_MODE_DEBUG 1
#define COMP_MODE_DEBUGWIN 2
#define COMP_MODE_UTF8 4

static size_t const SWSTACK_MAX = 32;
static int const MacroArityMax = 32;

#define HEDINFO_RUNTIME 0x1000		// 動的ランタイムを有効にする
#define HEDINFO_NOMMTIMER 0x2000	// マルチメディアタイマーを無効にする
#define HEDINFO_NOGDIP 0x4000		// GDI+による描画を無効にする
#define HEDINFO_FLOAT32 0x8000		// 実数を32bit floatとして処理する
#define HEDINFO_ORGRND 0x10000		// 標準の乱数発生を使用する

enum ppresult_t {
	PPRESULT_SUCCESS,				// 成功
	PPRESULT_ERROR,					// エラー
	PPRESULT_UNKNOWN_DIRECTIVE,		// 不明なプリプロセッサ命令（PreprocessNM）
	PPRESULT_INCLUDED,				// #include された
	PPRESULT_WROTE_LINE,			// 1行書き込まれた
	PPRESULT_WROTE_LINES,			// 2行以上書き込まれた
};

class CLabel;
class CMemBuf;
class CTagStack;
class CStrNote;
class AHTMODEL;
class AxCode;

#define SCNVBUF_DEFAULTSIZE 0x8000
#define SCNV_OPT_NONE 0
#define SCNV_OPT_SJISUTF8 1

//  token analysis class
class CToken
{
public:
	CToken();
	~CToken();
	std::shared_ptr<CLabel> GetLabelInfo();
	void SetLabelInfo( std::shared_ptr<CLabel> lbinfo );

	void InitSCNV( int size );
	char *ExecSCNV( char *srcbuf, int opt );

	void Error( char *mes );
	void LineError( char *mes, int line, char const *fname );
	void SetError( char *mes );
	void Mes( char *mes );
	void Mesf( char *format, ...);
	void SetErrorBuf( CMemBuf *buf );
	void SetAHT( AHTMODEL *aht );
	void SetAHTBuffer( CMemBuf *aht );

	void ResetCompiler( void );
	int GetToken( void );
	int PeekToken( void );
	int Calc( CALCVAR &val );
	char *CheckValidWord( void );

	//		For preprocess
	//
	ppresult_t Preprocess( char *str );
	ppresult_t PreprocessNM( char *str );
	void PreprocessCommentCheck( char *str );

	int ExpandLine( CMemBuf *buf, CMemBuf *src, char const *refname );
	int ExpandFile( CMemBuf *buf, char *fname, char const *refname );
	void FinishPreprocess( CMemBuf *buf );
	void SetCommonPath( char *path );
	int SetAdditionMode( int mode );

	void SetLook( char *buf );
	char *GetLook( void );
	char *GetLookResult( void );
	int GetLookResultInt( void );
	int LabelRegist( char **list, int mode );
	int LabelRegist2( char **list );
	int LabelRegist3( char **list );
	int LabelDump( CMemBuf *out, int option );
	int GetLabelBufferSize( void );
	int RegistExtMacroPath( char *name, char *str );
	int RegistExtMacro( char *name, char *str );
	int RegistExtMacro( char *keyword, int val );
	void SetPackfileOut( CMemBuf *pack );
	int AddPackfile( char *name, int mode );


	//		For Code Generate
	//
	int GenerateCode( char *fname, char *oname, int mode );
	int GenerateCode( CMemBuf *srcbuf, char *oname, int mode );

	int GetCS();
	void PutCS(int type, int value, int exflg);
	void PutCSSymbol(int label_id, int exflag);
	void PutCS(int type, double value, int exflg);
	void SetCS(int csindex, int type, int value);
	int PutOT(int value);
	int PutDS(char *str);
	int PutDSBuf(char *str);
	int PutDSBuf(char *str, int size);
	char *GetDS(int ptr);
	void PutDI(int dbgcode, int value, int subid);
	void PutDIOffset();
	
	void CalcCG( int ex );

	// others
	struct HeaderInfo {
		int option;
		char runtime[64];
		int cmpmode;
		int autoopt_timer;
	};
	int GetHeaderOption(void) { return hed_info.option; }
	char *GetHeaderRuntimeName(void) { return hed_info.runtime; }
	void SetHeaderOption(int opt, char *name) { hed_info.option = opt; strcpy(hed_info.runtime, name); }
	int GetCmpOption(void) { return hed_info.cmpmode; }
	void SetCmpOption(int cmpmode) { hed_info.cmpmode = cmpmode; }
	
	bool skipsJaSpaces() const;
	bool CG_optCode() const { return (hed_info.cmpmode & CMPMODE_OPTCODE) != 0; }
	bool CG_optInfo() const { return (hed_info.cmpmode & CMPMODE_OPTINFO) != 0; }
	bool CG_optShort() const { return CG_optCode() && (hed_info.cmpmode & CMPMODE_OPTSHORT) != 0; }
	bool CG_OutputsUtf8() const { return cg_utf8out; }

	//		For inspection
	void InspectAxCode();
	int SaveAxInspection(char* fname);
	char const* CG_scriptPositionString() const;

private:
	//		For preprocess
	//
	void Pickstr( void );
	char *Pickstr2( char *str );
	void Calc_token( void );
	void Calc_factor( CALCVAR &v );
	void Calc_unary( CALCVAR &v );
	void Calc_muldiv( CALCVAR &v );
	void Calc_addsub( CALCVAR &v );
	void Calc_bool( CALCVAR &v );
	void Calc_bool2( CALCVAR &v );
	void Calc_compare( CALCVAR &v );
	void Calc_start( CALCVAR &v );

	ppresult_t PP_Define( void );
	ppresult_t PP_Const( void );
	ppresult_t PP_Enum( void );
	ppresult_t PP_SwitchStart( int sw );
	ppresult_t PP_SwitchEnd( void );
	ppresult_t PP_SwitchReverse( void );
	ppresult_t PP_Include( bool is_addition );
	ppresult_t PP_Module( void );
	ppresult_t PP_Global( void );
	ppresult_t PP_Deffunc( int mode );
	ppresult_t PP_Defcfunc( int mode );
	ppresult_t PP_Struct( void );
	ppresult_t PP_Func( char *name );
	ppresult_t PP_Cmd( char *name );
	ppresult_t PP_Pack( int mode );
	ppresult_t PP_PackOpt( void );
	ppresult_t PP_RuntimeOpt( void );
	ppresult_t PP_CmpOpt( void );
	ppresult_t PP_Usecom( void );
	ppresult_t PP_Aht( void );
	ppresult_t PP_Ahtout( void );
	ppresult_t PP_Ahtmes( void );
	ppresult_t PP_BootOpt( void );

	void SetModuleName( char *name );
	char *GetModuleName( void );
	void AddModuleName( char *str );
	void FixModuleName( char *str );
	int IsGlobalMode( void );
	int CheckModuleName( char *name );

	char *SkipLine( char *str, int *pline );
	char *ExpandStr( char *str, int opt );
	char *ExpandStrEx( char *str );
	char *ExpandStrComment( char *str, int opt );
	char *ExpandStrComment2( char *str );
	char *ExpandAhtStr( char *str );
	char *ExpandBin( char *str, int *val );
	char *ExpandHex( char *str, int *val );
	char *ExpandToken( char *str, int *type, int ppmode );
	int ExpandTokens( char *vp, CMemBuf *buf, int *lineext, int is_preprocess_line );
	char *SendLineBuf( char *str );
	char *SendLineBufPP( char *str, int *lines );
	int ReplaceLineBuf( char *str1, char *str2, char const *repl, int macopt, MACDEF *macdef );

	ppresult_t SetErrorSymbolOverloading(char* keyword, int labelId);

	//		For Code Generate
	//
	int GenerateCodeMain( CMemBuf *src );
	void RegisterFuncLabels( void );
	int GenerateCodeBlock( void );
	int GenerateCodeSub( void );
	void GenerateCodePP( char *buf );
	void GenerateCodeCMD( int id );
	void GenerateCodeLET( int id );
	void GenerateCodeVAR( int id, int ex );
	void GenerateCodePRM( void );
	void GenerateCodePRMN( void );
	int GenerateCodePRMF( void );
	void GenerateCodePRMF2( void );
	void GenerateCodePRMF3( void );
	int GenerateCodePRMF4( int t );
	void GenerateCodeMethod( void );
	void GenerateCodeLabel( char *name, int ex );
	int GenerateOTIndex(char *name);

	void GenerateCodePP_regcmd( void );
	void GenerateCodePP_cmd( void );
	void GenerateCodePP_deffunc0( bool is_command );
	void GenerateCodePP_deffunc( void );
	void GenerateCodePP_defcfunc( void );
	void GenerateCodePP_uselib( void );
	void GenerateCodePP_module( void );
	void GenerateCodePP_struct( void );
	void GenerateCodePP_func( int deftype );
	void GenerateCodePP_usecom( void );
	void GenerateCodePP_comfunc( void );
	void GenerateCodePP_defvars( int fixedvalue );

	char *GetTokenCG( char *str, int option );
	char *GetTokenCG( int option );
	char *GetSymbolCG( char *str );
	char *GetLineCG( void );
	char *PickStringCG( char *str, int sep );
	char *PickStringCG2( char *str, char **strsrc );
	char *PickLongStringCG( char *str );
	int PickNextCodeCG( void );
	void CheckInternalListenerCMD(int opt);
	void CheckInternalProgCMD( int opt, int orgcs );
	void CheckInternalIF( int opt );
	void CheckCMDIF_Set( int mode );
	void CheckCMDIF_Fin( int mode );

	int SetVarsFixed( char *varname, int fixedvalue );
	int RegistIdentCG(char const* name, int type, int opt);

	void CalcCG_token( void );
	void CalcCG_token_exprbeg( void );
	void CalcCG_token_exprbeg_redo( void );
	void CalcCG_regmark( int mark );
	void CalcCG_factor( void );
	void CalcCG_unary( void );
	void CalcCG_muldiv( void );
	void CalcCG_addsub( void );
	void CalcCG_shift( void );
	void CalcCG_bool( void );
	void CalcCG_compare( void );
	void CalcCG_start( void );

	struct ConstCode;
	ConstCode CalcCG_evalConstExpr(int op, ConstCode const& lhs, ConstCode const& rhs);
	void CalcCG_putConstElem(ConstCode&& elem);
	void CalcCG_putCSCalcElem(ConstCode const&);
	void CalcCG_ceaseConstFolding();

	void CG_MesLabelDefinition(int label_id);

	//		Data
	//
	std::shared_ptr<CLabel> lb;         // label object
	std::shared_ptr<CLabel> tmp_lb;     // label object (preprocessor reference)
	std::unique_ptr<CTagStack> tstack;  // tag stack object
	CMemBuf *errbuf;
	CMemBuf *wrtbuf;
	CMemBuf *packbuf;
	CMemBuf *ahtbuf;
	CStrNote *note;
	AHTMODEL *ahtmodel;				// AHT process data
	char common_path[HSP_MAX_PATH];	// common path
	char search_path[HSP_MAX_PATH];	// search path
	std::unique_ptr<std::set<std::string>> filename_table;  // スクリプトファイルの名前のプール。CLabelより長い寿命をもつ。

	int line;
	int val;
	int ttype;						// last token type
	int texflag;
	char *lasttoken;				// last token point
	float val_f;
	double val_d;
	double fpbit;
	unsigned char const *wp;
	unsigned char s2[1024];         // ExpandToken, GetTokenCG で使われる一時バッファ？
	unsigned char *s3;              // GetTokenで使われる一時バッファ？
	char linebuf[LINEBUF_MAX];		// Line expand buffer
	char linetmp[LINEBUF_MAX];		// Line expand temp
	char errtmp[128];				// temp for error message
	char mestmp[128];				// meseage temp
	int incinf;						// include level
	LineMode mulstr;				// multiline string flag
	struct PPSwitchCtx {     // generator switch (#if/#else) context info
		bool is_enabled;     // enable flag
		bool in_else;        // (0=if/1=else)
		LineMode lmode;
	};
	int ppswlev;						// generator sw stack pointer
	PPSwitchCtx ppswctx_stack[SWSTACK_MAX];
	PPSwitchCtx ppswctx;
	int fileadd;					// File Addition Mode (1=on)
	char *ahtkeyword;				// keyword for AHT

	char modname[MODNAME_MAX+2];	// Module Name Prefix
	int	modgc;						// Global counter for Module
	int enumgc;						// Global counter for Enum
	typedef struct undefined_symbol_t {
		int pos;
		int len_include_modname;
		int len;
	} undefined_symbol_t;
	std::vector<undefined_symbol_t> undefined_symbols;
	char modcmdname[OBJNAME_MAX + 2]; // current userdef command name

	int cs_lastptr;					// パラメーターの初期CS位置
	int cs_lasttype;				// パラメーターのタイプ(単一時)
	int calccount;					// パラメーター個数 (正確ではないが、ちょうど1個かどうかの判断にしか使われない)

	//		for CodeGenerator
	//
	CGFlag cg_flag;  // 削除されるモジュールの内部コードを出力抑制するフラグ
	bool cg_debug;
	int cg_iflev;
	int cg_valcnt;
	int cg_typecnt;
	int cg_pptype;
	int cg_locallabel;
	int cg_defvarfix;
	bool cg_utf8out;
	char *cg_ptr;
	char *cg_ptr_bak;
	char *cg_str;
	unsigned char *cg_wp;
	char cg_libname[1024];

	int	replev;
	int repend[CGRepeatLevelMax];
	int iflev;
	struct CGIfInfo {
		int type;          // 0: if, 1: else
		int base_index;    // cs_index after if/else symbol
		int offset_index;  // cs_index of jump offset
		CGIfScope scope;   // scope type (line or block)
		bool is_term;      // is terminated?
	};
	CGIfInfo cg_if[CGIfLevelMax];

	CGLastCmd cg_lastcmd;  // 前行のコマンド; cmdif等は未実装
	int cg_lasttype;
	int cg_lastval;
	int cg_lastcs;

	std::shared_ptr<AxCode> axcode;

	struct ConstCode final  // represents a const code
	{
		int type; //TYPE_STRING/DNUM/INUM; or _MARK (stack bottom)
		union { char* str; double dval; int inum; };
		int exflag;

		static ConstCode makeStr(const char* str, int exf);
		static ConstCode makeDouble(double dval, int exf);
		static ConstCode makeInt(int ival, int exf);
		static ConstCode const mark;
		bool isConst() const;
		std::string toString() const;
		ConstCode castTo(int destType) const;
		~ConstCode();

		ConstCode(ConstCode&&) _NOEXCEPT; // movable
		ConstCode& operator = (ConstCode&&) _NOEXCEPT;
		ConstCode(ConstCode const&);
		ConstCode& operator = (ConstCode const&);
	private:
		ConstCode(int type, int exflag) : type(type), exflag(exflag) { }
	};
	std::unique_ptr<std::vector<ConstCode>> stack_calculator; // for const folding

	//		for Header info
	HeaderInfo hed_info;

	//		for Struct
	int cg_libindex;
	CGLibMode cg_libmode;
	int cg_localstruct[CG_LOCALSTRUCT_MAX];  // 今の文脈で定義されている引数エイリアスの、label_idの列(値はlabel_id)
	int cg_localcur;  // cg_local_structの現在の長さ

	//		for Error
	//
	int cg_errline;
	int cg_orgline;
	char const* cg_orgfile;

	//		for SCNV
	//
	char *scnvbuf;			// SCNV変換バッファ
	int	scnvsize;			// SCNV変換バッファサイズ

#ifdef HSPINSPECT
	//		for Inspection
	std::shared_ptr<CMemBuf> axi_buf;
#endif
};

extern char const* stringFromCalcCode(int op);

/*----------------------------------------------------------*/
//		Lexical Analyze Support

template<int N>
static void strcpy_safe(char dst[N], char const* src)
{
	strncpy(dst, src, N - 1);
	dst[N - 1] = '\0';
	return;
}

static bool is_mark_char(unsigned char c)
{
	return((c < 0x30)
		|| (0x3a <= c && c <= 0x3f)
		|| (0x5b <= c && c <= 0x5e)
		|| (0x7b <= c && c <= 0x7f));
}

template<typename T>
T* skip_blanks(T* p, bool skips_multibyte_space)
{
	static_assert
		(  std::is_same<std::decay_t<T>, unsigned char>::value
		|| std::is_same<std::decay_t<T>, char>::value, "" );
	for ( ;; ) {
		auto const c = *p;
		if ( c == ' ' || c == '\t' ) {
			p++;
		} else if ( skips_multibyte_space && c == 0x81 && p[1] == 0x40 ) {
			p += 2;
		} else {
			return p;
		}
	}
}
template<typename T, typename U>
static void strcpy_moving(T*& dst, U*& src, U* src_end = nullptr)
{
	while ( src != src_end ) {
		T c = static_cast<T>(*(src ++));
		if ( c == '\0' ) return;
		*(dst ++) = c;
	}
}

extern int* read_hex_literal(unsigned char const* src, size_t& len);
extern int* read_bin_literal(unsigned char const* src, size_t& len);
extern int* read_digit_literal(unsigned char const* src, size_t& len);
extern int read_operator(unsigned char const* src, size_t& len);
extern void read_ident(unsigned char const* src, size_t& len);

#endif
