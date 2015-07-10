
//
//	hsp3r.cpp header
//
#ifndef __hsp3r_h
#define __hsp3r_h

#include "../hsp3/hsp3debug.h"
#include "../hsp3/hsp3struct.h"
#include "../hsp3/hsp3code.h"
#include "../hsp3/stack.h"
#include "hspvar_util.h"

#define HSP3_AXTYPE_NONE 0
#define HSP3_AXTYPE_ENCRYPT 1

//	HSP3r class
//
class Hsp3r {
public:
	//	Functions
	//
	Hsp3r( void );
	~Hsp3r( void );
	void Dispose( void );						// HSP3Rの破棄
	int Reset( int ext_vars, int ext_hpi );		// HSP3Rの初期化を行なう
	void SetPackValue( int sum, int dec );		// packfile用の設定データを渡す
	void SetFileName( char *name );				// axファイル名を指定する
	void SetFInfo( STRUCTDAT *finfo, int finfo_max );	// FInfo設定

	//	Data
	//
	HSPHED hsphed;
	HSPCTX hspctx;
	char *axname;
	char *axfile;
	int	maxvar;
	int max_varhpi;
	int hsp_sum, hsp_dec;

private:
};


#endif
