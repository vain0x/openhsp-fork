
//
//	HSP3 C++ runtime manager
//	onion software/onitama 2008/5
//
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "hsp3r.h"
#include "../hsp3/hsp3config.h"
#include "../hsp3/hsp3debug.h"
#include "../hsp3/dpmread.h"
#include "../hsp3/supio.h"


extern void code_reset_(); // FIXME

static char startax[]={ 'S'-40,'T'-40,'A'-40,'R'-40,'T'-40,
			 '.'-40,'A'-40,'X'-40, 0 };

/*------------------------------------------------------------*/
/*
		constructor
*/
/*------------------------------------------------------------*/

Hsp3r::Hsp3r()
{
	//		初期化
	//
	memset( &hspctx, 0, sizeof(HSPCTX) );
	code_setctx( &hspctx );
	code_init();
	hspctx.mem_mcs = NULL;
	axfile = NULL;
	axname = NULL;
}

Hsp3r::~Hsp3r()
{
	//		すべて破棄
	//
	code_termfunc();
	Dispose();
	code_bye();
	VarUtilTerm();
}

/*------------------------------------------------------------*/
/*
		interface
*/
/*------------------------------------------------------------*/

void Hsp3r::SetFileName( char *name )
{
	if ( *name == 0 ) { axname = NULL; return; }
	axname = name;
}

void Hsp3r::Dispose( void )
{
	//		axを破棄
	//
	if ( hspctx.mem_var != NULL ) {
		int i;
		for(i=0;i<maxvar;i++) {
			HspVarCoreDispose( &hspctx.mem_var[i] );
		}
		delete [] hspctx.mem_var;	hspctx.mem_var = NULL;
	}
}

int Hsp3r::Reset( int ext_vars, int ext_hpi )
{
#if 0
	//		HSP3Rを初期化
	//			ext_vars = 変数IDの数
	//			ext_hpi  = 拡張HPIの数
	//
//	int i;
//	char *ptr;
//	char fname[512];
	if ( hspctx.mem_mcs != NULL ) Dispose();

	//		load HSP execute object
	//
	dpm_ini( "data.dpm",0,-1,-1 );				// original EXE mode

	maxvar = ext_vars;
	max_varhpi = ext_hpi;
	hspctx.mem_mcs = (unsigned short *)this;
/*
	hspctx.hsphed = hsphed;
	hspctx.mem_mcs = (unsigned short *)( ptr + hsphed->pt_cs );
	hspctx.mem_mds = (char *)( ptr + hsphed->pt_ds );
	hspctx.mem_ot = (int *)( ptr + hsphed->pt_ot );
	hspctx.mem_di = (unsigned char *)( ptr + hsphed->pt_dinfo );

	hspctx.mem_linfo = (LIBDAT *)( ptr + hsphed->pt_linfo );
	hspctx.mem_minfo = (STRUCTPRM *)( ptr + hsphed->pt_minfo );
	hspctx.mem_finfo = (STRUCTDAT *)( ptr + hsphed->pt_finfo );
*/
#else
	//		axを初期化

	int i;
	char *ptr;
	char fname[512];
	HSPHED *hsphed;
	int axtype;							// axファイルの設定(hsp3imp用)
	int mode = 0;						//mode: 0 = normal(debug) mode
	if ( hspctx.mem_mcs != NULL ) Dispose();

	//		load HSP execute object
	//
	axtype = HSP3_AXTYPE_NONE;
	if ( mode ) {									// "start.ax"を呼び出す
		i = dpm_ini( "", mode, hsp_sum, hsp_dec );	// customized EXE mode
		//axname = NULL;
	} else {
		dpm_ini( "data.dpm",0,-1,-1 );				// original EXE mode
	}

#ifdef HSP3IMP
	//		HSP3IMP用読み込み(暗号化ax対応)
	if ( axname == NULL ) {
		ptr = dpm_readalloc( "start.ax" );
		if ( ptr == NULL ) {
			int sz;
			CzCrypt crypt;
			if ( crypt.DataLoad( "start.axe" ) ) return -1;
			crypt.SetSeed( hsp_sum, hsp_dec );
			crypt.Decrypt();
			sz = crypt.GetSize();
			ptr = mem_ini( sz );
			memcpy( ptr, crypt.GetData(), sz );
			axtype |= HSP3_AXTYPE_ENCRYPT;
		}
	} else {
		ptr = dpm_readalloc( axname );
		if ( ptr == NULL ) return -1;
	}
#else
	//		start.ax読み込み
	if ( axname == NULL ) {
		unsigned char *p;
		unsigned char *s;
		unsigned char ap;
		int sum;
		sum = 0;
		p = (unsigned char *)fname;
		s = (unsigned char *)startax;
		while(1) {
			ap = *s++;if ( ap==0 ) break;
			ap += 40; *p++ = ap;
			sum = sum*17 + (int)ap;
		}
		*p = 0;
		if ( sum != 0x6cced385 ) return -1;
		if ( mode ) {
			if ( dpm_filebase( fname ) != 1 ) return -1;	// DPM,packfileからのみstart.axを読み込む
		}
	} else {
		strcpy( fname, axname );
	}

	ptr = dpm_readalloc( fname );
	if ( ptr == NULL ) return -1;
#endif

	axfile = ptr;

	//		memory location set
	//
	hsphed = (HSPHED *)ptr;

	if ((hsphed->h1!='H')||(hsphed->h2!='S')||(hsphed->h3!='P')||(hsphed->h4!='3')) {
		mem_bye( axfile );
		return -1;
	}

	maxvar = ext_vars;
	max_varhpi = ext_hpi;
	hspctx.mem_mcs = (unsigned short *)this;

//	maxvar = hsphed->max_val;
	hspctx.hsphed = hsphed;
//	hspctx.mem_mcs = (unsigned short *)( ptr + hsphed->pt_cs );
	hspctx.mem_mds = (char *)( ptr + hsphed->pt_ds );
	hspctx.mem_ot = (int *)( ptr + hsphed->pt_ot );
	hspctx.mem_di = (unsigned char *)( ptr + hsphed->pt_dinfo );

	hspctx.mem_linfo = (LIBDAT *)( ptr + hsphed->pt_linfo );
	hspctx.mem_minfo = (STRUCTPRM *)( ptr + hsphed->pt_minfo );
	hspctx.mem_finfo = (STRUCTDAT *)( ptr + hsphed->pt_finfo );
#endif
	code_resetctx( &hspctx );		// hsp3code setup
	HspVarCoreResetVartype( max_varhpi );		// 型の初期化

	code_reset_();//FIXME

	//		HspVar setup
	hspctx.mem_var = NULL;
	if ( maxvar ) {
		int i;
		hspctx.mem_var = new PVal[maxvar];

		for(i=0;i<maxvar;i++) {
			PVal *pval = &hspctx.mem_var[i];
			pval->mode = HSPVAR_MODE_NONE;
			pval->flag = HSPVAR_FLAG_INT;				// 仮の型
			HspVarCoreClear( pval, HSPVAR_FLAG_INT );	// グローバル変数を0にリセット
		}
	}

	return 0;
}


void Hsp3r::SetPackValue( int sum, int dec )
{
	hsp_sum = sum;
	hsp_dec = dec;
}

void Hsp3r::SetFInfo( STRUCTDAT *finfo, int finfo_max )
{
	hspctx.mem_finfo = finfo;
	hsphed.max_finfo = finfo_max;
}
