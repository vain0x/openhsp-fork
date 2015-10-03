
//
//	hsp3.cpp header
//
#ifndef __hsp3_h
#define __hsp3_h

#include "hsp3debug.h"
#include "hsp3struct.h"
#include "hsp3ext.h"
#include "hsp3code.h"

//	HSP3 class
//
class Hsp3 {
public:
	//	Functions
	//
	Hsp3( void );
	~Hsp3( void );
	void Dispose( void );						// HSP axの破棄
	int Reset( int mode );						// HSP axの初期化を行なう
	void SetPackValue( int sum, int dec );		// packfile用の設定データを渡す
	void SetFileName( char *name );				// axファイル名を指定する

	//	Data
	//
	HSPCTX hspctx;
	char *axname;
	char *axfile;
	int	maxvar;
	int hsp_sum, hsp_dec;

private:
};


#endif
