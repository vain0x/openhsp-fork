
//
//	CHsp3.cpp structures
//
#ifndef __CHsp3_h
#define __CHsp3_h

#include <string>
#include "../hsp3/hsp3config.h"
#include "../hsp3/hsp3debug.h"
#include "../hsp3/hsp3struct.h"
#include "../hspcmp/localinfo.h"
#include "../hspcmp/label.h"
#include "membuf.h"
#include "csstack.h"
#include "supio.h"

#define MAX_IFLEVEL 32			// ifのネスト読み出し最大レベル
#define VAREXP_BUFFER_MAX 1024	// 配列要素の読み出し用バッファ最大サイズ

//	HSP3ライブラリ用定義
//
typedef struct HSP3RLIBCNF {

	//		HSP3RLIB上で動作させるために必要な設定
	//
	int		version;			// version number info
	int		max_val;			// max count of VAL Object
	short	max_hpi;			// size of HPIDAT(3.0)
	short	max_varhpi;			// Num of Vartype Plugins(3.0)
	int		bootoption;			// bootup options


} HSP3RLIBCNF;

//	HSP3解析コンテキスト用定義
//
typedef struct MCSCONTEXT {

	//		オブジェクトコード解析に必要な設定
	//
	unsigned short *mcs;				// CS Code read pointer
	unsigned short *mcs_last;			// CS Code read pointer (original)
	int cstype;
	int csval;
	int exflag;

} MCSCONTEXT;


//	HSP3(.ax)操作用クラス
//
class CHsp3Parser {
public:
	CHsp3Parser();
	virtual ~CHsp3Parser();

	void NewObjectHeader( void );
	void DeleteObjectHeader( void );

	virtual int LoadObjectFile( char *fname );

	//		Data Retrieve
	//
	const LIBDAT *GetLInfo( int index ) const;
	const STRUCTDAT *GetFInfo( int index ) const;
	const STRUCTPRM *GetMInfo( int index ) const;
	const HSPHED *GetHSPHed( void ) const;

	int GetOTCount( void ) const;
	int GetLInfoCount( void ) const;
	int GetFInfoCount( void ) const;
	int GetFInfo2Count( void ) const;
	int GetMInfoCount( void ) const;

	void initCS( void *ptr );
	int getCS( void );
	int getNextCS( int *type ) const;
	int getEXFLG( void ) const ;
	const char * GetDS( int offset ) const;
	double GetDSf( int offset ) const;
	int GetOT( int index ) const;
	int GetOTInfo( int index ) const;

protected:
	//		Settings
	//
	CMemBuf *buf;
	HSPHED *hsphed;


	CMemBuf *mem_cs;
	CMemBuf *mem_ds;
	CMemBuf *mem_ot;
	CMemBuf *dinfo;

	CMemBuf *linfo;
	CMemBuf *finfo;
	CMemBuf *minfo;
	CMemBuf *finfo2;
	CMemBuf *hpidat;

	CMemBuf *ot_info;

	unsigned short *mcs;				// CS Code read pointer
	unsigned short *mcs_last;			// CS Code read pointer (original)
	unsigned short *mcs_start;			// CS Code start pointer
	unsigned short *mcs_end;			// CS Code end pointer
	unsigned char *mem_di_val;			// Debug VALS info ptr
	int cstype;
	int csval;
	int exflag;

	char orgname[HSP_MAX_PATH];

	//	for Program Trace
	//
	CLabel *lb;							// label object

	//		Private function
	//
	int UpdateValueName( void );
	void MakeOTInfo( void );

public:
	std::string GetHSPVarName( int varid ) const;
	std::string GetHSPName( int type, int val ) const;

	static std::string GetHSPOperator( int val );
	static std::string GetHSPOperator2( int val );
	static std::string GetHSPVarTypeName( int type );
	static std::string GetHSPCmdTypeName( int type );
};

class CHsp3 : public CHsp3Parser {
public:
	CHsp3();
	~CHsp3();

	int LoadObjectFile( char *fname );
	int SaveOutBuf( char *fname );
	int SaveOutBuf2( char *fname );
	char *GetOutBuf( void );

	//		Data Output
	//
	void OutMes( char *format, ... );
	void OutLine( char *format, ... );
	void OutLineBuf( CMemBuf *outbuf, char *format, ... );
	void OutCR( void );
	void SetIndent( int val );

	//		Data Retrieve
	//
	void GetContext( MCSCONTEXT *ctx ) const;
	void SetContext( MCSCONTEXT *ctx );

	//		Test Function
	//
	void MakeObjectInfo( void );
	void MakeProgramInfo( void );

	//		Virtual Function
	//
	virtual int MakeSource( int option, void *ref );

protected:
	//		Settings
	//
	CMemBuf *out;
	CMemBuf *out2;

	CLocalInfo localinfo;

	//	for Program Trace
	//
	int iflevel;
	int ifmode[MAX_IFLEVEL];
	unsigned short *ifptr[MAX_IFLEVEL];
	int iftaskid[MAX_IFLEVEL];
	int indent;

	//		Private function
	//
	int MakeProgramInfoParam( void );
	int MakeProgramInfoParam2( void );
	void MakeProgramInfoLabel( void );
	void MakeProgramInfoFuncParam( int structid );
	void MakeProgramInfoHSPName( bool putadr = true );

public:
	int MakeImmidiateName( char *mes, int type, int val );
	int MakeImmidiateHSPName( char *mes, int type, int val, char *opt = NULL );
	void MakeHspStyleString( char *str, CMemBuf *eout );

protected:
	int GetHSPExpression( CMemBuf *eout );
	int GetHSPVarExpression( char *mes );

};

#endif
