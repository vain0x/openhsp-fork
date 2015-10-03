
//
//		Easy Data Access Plugin for HSP3
//				onion software/onitama 1999
//				               onitama 2005/5
//

#include <windows.h>
#include <stdio.h>
#include <stdarg.h>
#include <map>

#include "../hpi3sample/hsp3plugin.h"
#include "membuf.h"
#include "ccsv.h"
#include "MTRand.h"

static ccsv *csv;


void Alertf( char *format, ... )
{
	char textbf[1024];
	va_list args;
	va_start(args, format);
	vsprintf(textbf, format, args);
	va_end(args);
	MessageBox( NULL, textbf, "error",MB_ICONINFORMATION | MB_OK );
}



int WINAPI hspda_DllMain (HINSTANCE hInstance, DWORD fdwReason, PVOID pvReserved)
{
	if ( fdwReason==DLL_PROCESS_ATTACH ) {
		csv = new ccsv();
		MTRandInit( -1 );
	}
	if ( fdwReason==DLL_PROCESS_DETACH ) {
		delete csv;
		csv = NULL;
	}
	return TRUE ;
}

/*------------------------------------------------------------*/
/*
		Sort Routines
*/
/*------------------------------------------------------------*/

typedef struct {
	int key;
	int info;
	double dkey;
} DATA;

static void swap(DATA *a, DATA *b)
{
    DATA t;

    t.key   = a->key;
    t.info  = a->info;
	t.dkey	= a->dkey;

	a->key  = b->key;
	a->dkey	= b->dkey;
    a->info = b->info;

	b->key  = t.key;
	b->dkey	= t.dkey;
    b->info = t.info;
}

static void rquickSort(DATA *data, int asdes, int first, int last)
{
	//		クイックソート
	//
    int i, j, x;

    i = first;
    j = last;
    x = (data[i].key + data[j].key)/2;

//  while (i < j) {

    while (1) {
        if (asdes == 0) {
            while (data[i].key < x) i++;
            while (data[j].key > x) j--;
        } else {
            while (data[i].key > x) i++;
            while (data[j].key < x) j--;
        }

        if (i >= j) break;
        swap(&data[i], &data[j]);
        i++;
        j--;
/*
        if (i < j) {
            swap(&data[i], &data[j]);
            i++;
            j--;
        }
*/
    }
    if (first < i - 1) rquickSort(data, asdes, first, i - 1);
    if (last  > j + 1) rquickSort(data, asdes, j + 1, last);
}

void QuickSort( DATA *data, int nmem, int asdes )
{
    if (nmem <= 1) return;
    rquickSort(data, asdes, 0, nmem - 1);
}


void BubbleSortStr( DATA *data, int nmem, int asdes )
{
	int i, j;
	for (i = 0; i < nmem - 1; i++) {
	  for (j = nmem - 1; j >= i + 1; j--) {
	    if (asdes == 0) {
		  if ( lstrcmp( (char *)data[j].key, (char *)data[j-1].key)<=0 )
				swap(&data[j], &data[j-1]);
		}
		else {
		  if ( lstrcmp( (char *)data[j].key, (char *)data[j-1].key)>=0 )
				swap(&data[j], &data[j-1]);
		}
	  }
	}
}


void BubbleSortDouble( DATA *data, int nmem, int asdes )
{
	int i, j;
	for (i = 0; i < nmem - 1; i++) {
	  for (j = nmem - 1; j >= i + 1; j--) {
	    if (asdes == 0) {
			if ( data[j].dkey < data[j-1].dkey ) swap(&data[j], &data[j-1]);
		}
		else {
			if ( data[j].dkey > data[j-1].dkey ) swap(&data[j], &data[j-1]);
		}
	  }
	}
}


int NoteToData( char *adr, DATA *data )
{
	int line;
	char *p;
	char a1;
	p=adr;
	line=0;
	data[line].key=(int)p;
	data[line].info=line;

	while(1) {
		a1=*p;
		if (a1==0) break;
		if ((a1==13)||(a1==10)) {
			*p++=0;					// Remove CR/LF
			if (*p==10) p++;
			line++;
			data[line].key=(int)p;
			data[line].info=line;
		}
		else p++;
	}
	line++;
	return line;
}


int GetNoteLines( char *adr )
{
	int line;
	char *p;
	char a1;
	p=adr;
	line=0;

	while(1) {
		a1=*p++;
		if (a1==0) break;
		if (a1==10) line++;
		if (a1==13) {
			if (*p==10) p++;
			line++;
		}
	}
	line++;
	return line;
}


void DataToNote( DATA *data, char *adr, int num )
{
	int a;
	char *p;
	char *s;
	p=adr;
	for(a=0;a<num;a++) {
		s=(char *)data[a].key;
		lstrcpy( p, s );
		p+=lstrlen( s );
		*p++=13; *p++=10;			// Add CR/LF
	}
	*p=0;
}


void StrToData( char *adr, int num, int len, DATA *data )
{
	int a;
	char *p;
	p=adr;
	for(a=0;a<num;a++) {
		data[a].key=(int)p;
		data[a].info=a;
		p+=len;
	}
}


void DataToStr( DATA *data, char *adr, int num, int len )
{
	int a;
	char *p;
	char *s;
	p=adr;
	for(a=0;a<num;a++) {
		s=(char *)data[a].key;
		lstrcpyn( p, s, len );
		p+=len;
	}
}


/*------------------------------------------------------------*/
/*
		HSP interface
*/
/*------------------------------------------------------------*/

static	DATA *dtmp = NULL;

static void DataBye( void )
{
	if (dtmp!=NULL) {
		free(dtmp);
	}
}

static void DataIni( int size )
{
	DataBye();
	dtmp=(DATA *)malloc( sizeof(DATA)*size );
}


static void *Hsp3GetBlockSize( HSPEXINFO *hei, PVal *pv, APTR ap, int *size )
{
	//		(HSP3用)
	//		pv,apからメモリブロックを取得する
	//
	PDAT *pd;
	HspVarProc *proc;
	proc = hei->HspFunc_getproc( pv->flag );
	pv->offset = ap;
	pd =  proc->GetPtr( pv );
	return proc->GetBlockSize( pv,pd,size );
}


EXPORT BOOL WINAPI sortval( HSPEXINFO *hei, int p2, int p3, int p4 )
{
	//
	//		sortval val, order (type$202)
	//
	int a,i;
	int *p;
	double *dp;
	PVal *p1;
	APTR ap;
	int order;

	ap = hei->HspFunc_prm_getva( &p1 );		// パラメータ1:変数
	order = hei->HspFunc_prm_getdi( 0 );	// パラメータ2:数値

	i=p1->len[1];
	if (i<=0) return -1;
	switch(p1->flag) {
	case 3:						// double
		dp=(double *)p1->pt;
		DataIni( i );
		for(a=0;a<i;a++) {
			dtmp[a].dkey=dp[a];
			dtmp[a].info=a;
		}
		BubbleSortDouble( dtmp, i, p2 );
		for(a=0;a<i;a++) {
			//dp[a]=dtmp[a].dkey;
			hei->HspFunc_prm_setva( p1, a, TYPE_DNUM, &(dtmp[a].dkey) );	// 変数に値を代入
		}
		break;
	case 4:						// int
		p=(int *)p1->pt;
		DataIni( i );
		for(a=0;a<i;a++) {
			dtmp[a].key=p[a];
			dtmp[a].info=a;
		}
		QuickSort( dtmp, i, p2 );
		for(a=0;a<i;a++) {
			p[a]=dtmp[a].key;
		}
		break;
	default:
		return -1;
	}

	return 0;
}


EXPORT BOOL WINAPI sortstr( HSPEXINFO *hei, int p1, int p2, int p3 )
{
	//
	//		sortstr val, order (type$202)
	//
	int i,len,sflag,size;
	char *p;
	char *psrc;
	PVal *pv;
	APTR ap;
	CMemBuf buf;

	ap = hei->HspFunc_prm_getva( &pv );		// パラメータ1:変数
	sflag = hei->HspFunc_prm_getdi( 0 );	// パラメータ2:数値

	if (( pv->flag != 2 )||( pv->len[2] != 0 )||( ap != 0 )) return -1;
	len = pv->len[1];
	DataIni( len );

	for(i=0;i<len;i++) {
		p = (char *)Hsp3GetBlockSize( hei, pv, i, &size );
		psrc = buf.GetCurrentPtr();
		buf.PutStrBlock( p );

		dtmp[i].key = (int)psrc;
		dtmp[i].info = i;
	}

	BubbleSortStr( dtmp, len, sflag );

	for(i=0;i<len;i++) {
		psrc = (char *)dtmp[i].key;
		hei->HspFunc_prm_setva( pv, i, TYPE_STRING, psrc );	// 変数に値を代入
	}

	return 0;
}


/*
EXPORT BOOL WINAPI sortstr( PVAL2 *p1, int p2, int p3, int p4 )
{
	//
	//		sortstr val, order (type$83)
	//
	int i,len;
	char *p;
	char *stmp;

	len=(p1->len[1])<<2;
	i=p1->len[2];
	p=p1->pt;

	if (p1->flag!=2) return -1;
	if (i<=0) return -1;

	DataIni( i );

	stmp=(char *)malloc( len*i );
	memcpy( stmp, p, len*i );
	StrToData( stmp, i, len, dtmp );
	BubbleSortStr( dtmp, i, p2 );
	DataToStr( dtmp, p, i, len );
	free(stmp);
	
	
//	for(a=0;a<i;a++) {
//		p[0]=48+a;
//		p+=len<<2;
//	}

	return 0;
}
*/



EXPORT BOOL WINAPI sortnote( HSPEXINFO *hei, int p1, int p2, int p3 )
{
	//
	//		sortnote val, order (type$202)
	//
	int i,size,sflag;
	char *p;
	char *stmp;
	PVal *pv;
	APTR ap;

	ap = hei->HspFunc_prm_getva( &pv );		// パラメータ1:変数
	sflag = hei->HspFunc_prm_getdi( 0 );	// パラメータ2:数値

	p = (char *)Hsp3GetBlockSize( hei, pv, ap, &size );
	i = GetNoteLines(p);
	if ( i <= 0 ) return -1;

	//Alertf( "%d[%s]", size,p );

	DataIni( i );
	stmp = (char *)malloc( size );

	NoteToData( p, dtmp );
	BubbleSortStr( dtmp, i, sflag );
	DataToNote( dtmp, stmp, i );

	hei->HspFunc_prm_setva( pv, ap, TYPE_STRING, stmp );	// 変数に値を代入

	free( stmp );

/*
	len=p1->len[1];
	p=p1->pt;

	if (p1->flag!=2) return -1;

	i=GetNoteLines(p);
	if (i<=0) return -1;

	DataIni( i );
	stmp=(char *)malloc( len<<2 );
	NoteToData( p, dtmp );
	BubbleSortStr( dtmp, i, p2 );
	DataToNote( dtmp, stmp, i );
	lstrcpy( p,stmp );
	free(stmp);
*/

	return 0;
}


EXPORT BOOL WINAPI sortget( PVal *p1, int p2, int p3, int p4 )
{
	//
	//		sortget val,index  (type$83)
	//
	int *p;

	p=(int *)(p1->pt);
	//p1->flag = 4;

	*p=dtmp[p2].info;
	return 0;
}


EXPORT BOOL WINAPI csvnote( PVal *p1, char *p2, int p3, int p4 )
{
	//
	//		csvnote val,csvdata,spchr  (type$87)
	//
	int len;
	unsigned char *stmp;
	unsigned char *p;
	unsigned char *s;
	unsigned char a1;
	unsigned char spchr;

	if ( p3==0 ) spchr=','; else spchr=p3;
	len=p1->len[1];
	p=(unsigned char *)p1->pt;
	//p1->flag = 2;
	stmp=NULL;
	s=(unsigned char *)p2;

	if (s==p) {
		stmp=(unsigned char *)malloc( len<<2 );
		memcpy( stmp, s, len<<2 );
		s=stmp;
	}

	while(1) {
		a1=*s++;if (a1==0) break;
		if (a1==spchr) {
			*p++=13; *p++=10;			// Add CR/LF
		}
		else {
			*p++=a1;
			if (a1>=129) {					// 全角文字チェック
				if ((a1<=159)||(a1>=224)) {
					a1=*s++;if (a1==0) break;
					*p++=a1;
				}
			}
		}
	}
	*p=0;

	if (stmp!=NULL) free(stmp);
	return 0;
}


EXPORT BOOL WINAPI csvstr( HSPEXINFO *hei, int _p1, int _p2, int _p3 )
{
	//
	//		csvstr val,csvdata,sepchr  (type$202)
	//
	int p3,len,limit,i,a,b;
	unsigned char *pbase;
	unsigned char *s;
	unsigned char a1;
	unsigned char spchr;
	PVal *pv;
	APTR ap;
	PVal *pv2;
	APTR ap2;

	ap = hei->HspFunc_prm_getva( &pv );		// パラメータ1:変数
	ap2 = hei->HspFunc_prm_getva( &pv2 );	// パラメータ2:変数
	p3 = hei->HspFunc_prm_getdi( 0 );		// パラメータ3:数値

	if ( p3==0 ) spchr=','; else spchr=p3;

//	len=p1->len[1]<<2;

	i = pv->len[1];
	if (i<=0) return -1;

//	limit=len-1;
	pbase=(unsigned char *)Hsp3GetBlockSize( hei, pv, 0, &limit );
	limit--;
	//p1->flag = 2;
	s=(unsigned char *)Hsp3GetBlockSize( hei, pv2, ap2, &len );
	a=0;b=1;

	while(1) {
		a1=*s++;if (a1==0) break;
		if (a1==spchr) {
			if (b<i) {
				pbase[a]=0;
				pbase=(unsigned char *)Hsp3GetBlockSize( hei, pv, b, &limit );
				limit--;
				a=0;b++;
			}
		}
		else {
			if (a<limit) pbase[a++]=a1;

			if (a1>=129) {					// 全角文字チェック
				if ((a1<=159)||(a1>=224)) {
					a1=*s++;if (a1==0) break;
					if (a<limit) pbase[a++]=a1;
				}
			}
		}
	}
	pbase[a]=0;
	return 0;
}


EXPORT BOOL WINAPI sortbye( int p1, int p2, int p3, int p4 )
{
	//
	//		sortbye (type$100)
	//
	DataBye();
	return 0;
}

/*------------------------------------------------------------*/
/*
		Exclusive Data Routines
*/
/*------------------------------------------------------------*/

static	PVal	*xn_base;
static	int		xn_count;
static	int		xn_max;
static	char	*xn_ptr;

EXPORT BOOL WINAPI xnotesel( PVal *p1, int p2, int p3, int p4 )
{
	//
	//		xnotesel notedat, maxnum  (type$83)
	//
	int a,i;

	i=p2;if (i==0) i=256;			// default value
	xn_max=i;
	xn_ptr=p1->pt;
	if (p1->flag!=2) return -1;

	DataIni( i );
	for(a=0;a<i;a++) {
		dtmp[a].key=0;
		dtmp[a].info=0;
	}
	xn_base=p1;
	xn_count=0;
	return 0;
}


EXPORT BOOL WINAPI xnoteadd( BMSCR *bm, char *p1, int p2, int p3 )
{
	//
	//		xnoteadd "strings" (type$6)
	//
	char *s1;
	char *s3;
	char s2[4096];
	int line;
	unsigned char a1;

	s1=xn_ptr;
	line=0;
	while(1) {
		if (*s1==0) break;
		s3=s2;
		while(1) {
			a1=(unsigned char)*s1;
			if ((a1==13)||(a1==0)) break;
			*s3++=a1; s1++;
		}
		*s3=0;
		if (strcmp(p1,s2)==0) {				// compare
			dtmp[line].info++;
			return -line;
		}
		if (a1==13) {						// CR/LF check
			s1++;if (*s1==10) s1++;
			line++;
		}
	}

	strcpy( s2,p1 );
	strcat( s2,"\r\n" );
	strcpy( s1,s2 );
	dtmp[line].info++;
	return -line;
}

/*------------------------------------------------------------*/
/*
		Extra CSV Routines
*/
/*------------------------------------------------------------*/

EXPORT BOOL WINAPI csvsel( char *p1, int p2, int p3, int p4 )
{
	//
	//		csvsel val,sepchr  (type$1)
	//			( sepchr=0 / "," )
	//
	csv->SetBuffer( p1 );
	if ( p2 != 0 ) csv->SetSeparate( p2 );
			  else csv->SetSeparate( ',' );
	return 0;
}


EXPORT BOOL WINAPI csvres( PVal *p1, int p2, int p3, int p4 )
{
	//
	//		csvres val  (type$83)
	//
	int i;
	i=p1->len[1]<<2;
	csv->SetResultBuffer( p1->pt, i );
	return -i;
}


EXPORT BOOL WINAPI csvflag( int p1, int p2, int p3, int p4 )
{
	//
	//		csvflag id,val  (type$0)
	//
	csv->SetFlag( p1, p2 );
	return 0;
}


EXPORT BOOL WINAPI csvopt( int p1, int p2, int p3, int p4 )
{
	//
	//		csvopt option  (type$0)
	//
	csv->SetOption( p1 );
	return 0;
}


EXPORT BOOL WINAPI csvfind( BMSCR *bm, char *p1, int p2, int p3 )
{
	//
	//		csvfind "strings",max,start (type$6)
	//
	int i;
	i = csv->Search( p1, p2, p3 );
	return -i;
}


/*------------------------------------------------------------*/
/*
		Additional string service
*/
/*------------------------------------------------------------*/

/*------------------------------------------------------------*/
/*
		Extra random service
*/
/*------------------------------------------------------------*/

EXPORT BOOL WINAPI rndf_ini( HSPEXINFO *hei, int _p1, int _p2, int _p3 )
{
	//
	//		rndf_ini seed  (type$202)
	//
	int p1;
	p1 = hei->HspFunc_prm_getdi( -1 );		// パラメータ1:数値
	MTRandInit( p1 );
	return 0;
}


EXPORT BOOL WINAPI rndf_get( HSPEXINFO *hei, int _p1, int _p2, int _p3 )
{
	//
	//		rndf_get var  (type$202)
	//
	PVal *pv;
	APTR ap;
	double dval;
	ap = hei->HspFunc_prm_getva( &pv );		// パラメータ1:変数
	dval = MTRandGet();
	hei->HspFunc_prm_setva( pv, ap, TYPE_DNUM, &dval );	// 変数に値を代入
	return 0;
}


EXPORT BOOL WINAPI rndf_geti( HSPEXINFO *hei, int _p1, int _p2, int _p3 )
{
	//
	//		rndf_geti var, range  (type$202)
	//
	PVal *pv;
	APTR ap;
	int p1,p2;
	ap = hei->HspFunc_prm_getva( &pv );		// パラメータ1:変数
	p1 = hei->HspFunc_prm_getdi( 100 );		// パラメータ2:数値
	p2 = MTRandGetInt( p1 );
	hei->HspFunc_prm_setva( pv, ap, TYPE_INUM, &p2 );	// 変数に値を代入
	return 0;
}


/*------------------------------------------------------------*/
/*
		HSP Variable service
*/
/*------------------------------------------------------------*/

#define HSP3VARFILEVER 0x1000
#define HSP3VARFILECODE "hspv"
#define HSP3VARFILEFXCODE 0x55aa0000

typedef struct HSP3VARFILEHED
{
	//	VAR File Header structure
	//
	char magic[4];				// magic code 'hspv'
	int ver;					// version code
	int num;					// num of data structure
	int pt_data;				// data block offset

} HSP3VARFILEHED;


typedef struct HSP3VARFILEDATA
{
	//	VAR File Data structure
	//
	int	name;					// name ptr
	int data;					// data ptr
	unsigned int flags;			// flags
	int encode;					// encode param (reserved)
	PVal master;				// PVal Master Data

} HSP3VARFILEDATA;

#define HVFDATA_FLAG_TYPE_MASK 3
#define HVFDATA_TYPE_VAR 0
#define HVFDATA_TYPE_STRUCT 1
#define HVFDATA_TYPE_MODULE 2
#define HVFDATA_TYPE_MEMBER 3
#define HVFDATA_GET_TYPE(hvfdata) ((hvfdata)->flags & HVFDATA_FLAG_TYPE_MASK)
#define HVFDATA_IS_VAR(hvfdata)    (HVFDATA_GET_TYPE(hvfdata) == HVFDATA_TYPE_VAR)
#define HVFDATA_IS_STRUCT(hvfdata) (HVFDATA_GET_TYPE(hvfdata) == HVFDATA_TYPE_STRUCT)
#define HVFDATA_IS_MODULE(hvfdata) (HVFDATA_GET_TYPE(hvfdata) == HVFDATA_TYPE_MODULE)
#define HVFDATA_IS_MEMBER(hvfdata) (HVFDATA_GET_TYPE(hvfdata) == HVFDATA_TYPE_MEMBER)

//	for save
static	HSP3VARFILEHED varhed;
static	CMemBuf *varinfo;
static	CMemBuf *vardata;
typedef std::map< STRUCT *, int > saved_struct_t;
static	saved_struct_t *saved_struct;
typedef std::map< int, int > saved_module_t;
static	saved_module_t *saved_module;

//	for load
static	HSP3VARFILEHED *vmem;
static	char *vload_tmp;
static	HSP3VARFILEDATA *vmem_infos;
static	char *vmem_buf;
typedef std::map< int, STRUCT_REF * > loaded_struct_t;
static	loaded_struct_t *loaded_struct;
typedef std::map< int, STRUCTDAT * > loaded_module_t;
static	loaded_module_t *loaded_module;

#define MODNAME_SIZE 64

/*------------------------------------------------------------*/

static void pv_dispose( HSPEXINFO *hei, PVal *pv )
{
	HspVarProc *varproc;
	varproc = hei->HspFunc_getproc( pv->flag );
	varproc->Free( pv );
}


static void pv_alloc( HSPEXINFO *hei, PVal *pv, PVal *pv2 )
{
	HspVarProc *varproc;
	varproc = hei->HspFunc_getproc( pv->flag );
	varproc->Alloc( pv, pv2 );
}

static char *pv_getblock( HSPEXINFO *hei, PVal *pv, int offset, int *size )
{
	PDAT *p;
	HspVarProc *varproc;
	pv->offset=offset;
	varproc = hei->HspFunc_getproc( pv->flag );
	p = varproc->GetPtr( pv );
	varproc->GetBlockSize( pv, p, size );
	return (char *)p;
}

static void pv_allocblock( HSPEXINFO *hei, PVal *pv, int offset, int size )
{
	PDAT *p;
	HspVarProc *varproc;
	pv->offset=offset;
	varproc = hei->HspFunc_getproc( pv->flag );
	p = varproc->GetPtr( pv );
	varproc->AllocBlock( pv, p, size );
}

static int pv_seekstruct( HSPEXINFO *hei, char *name )
{
	//		特定名称のモジュールを検索する
	//
	HSPCTX *hspctx;
	STRUCTDAT *st;
	char *p;
	int i,max;

	hspctx = (HSPCTX *)hei->hspctx;
	max = hspctx->hsphed->max_finfo / sizeof(STRUCTDAT);

	for(i=0;i<max;i++) {
		st = &hspctx->mem_finfo[ i ];
		p = hspctx->mem_mds + st->nameidx;
		if ( st->index == STRUCTDAT_INDEX_STRUCT ) {
			if ( strcmp( p, name ) == 0 ) return i;
		}
	}
	return -1;
}

static PVal *create_struct_members_buffer( HSPEXINFO *hei, STRUCTDAT *st )
{
	int max = st->prmmax - 1;
	int len = st->size + sizeof(int);
	PVal *members = (PVal *)hei->HspFunc_malloc( len );
	memset( members, 0, len );
	for ( int i = 0; i < max; i ++ ) {
		members[i].mode = HSPVAR_MODE_NONE;
		members[i].flag = HSPVAR_FLAG_INT;
	}
	*(int *)(members + max) = st->prmmax;
	return members;
}


/*------------------------------------------------------------*/

static int varsave_putvar( HSPEXINFO *hei, PVal *pv, int encode );
static int varload_getvar( HSPEXINFO *hei, char *vdata, PVal *pv, PVal *pv2, int encode );

static void varsave_init( void )
{
	strcpy( varhed.magic, HSP3VARFILECODE );
	varhed.ver = HSP3VARFILEVER;
	varhed.num = 0;
	varhed.pt_data = 0;
	varinfo = new CMemBuf;
	vardata = new CMemBuf;
	saved_struct = NULL;
	saved_module = NULL;
}


static int varsave_bye( char *fname )
{
	int res;
	FILE *fp;
	int hedsize, infosize, datasize;

	res = 0;
	fp=fopen( fname, "wb" );
	if (fp != NULL) {

		hedsize = sizeof( HSP3VARFILEHED );
		infosize = varinfo->GetSize();
		datasize = vardata->GetSize();

		varhed.pt_data = hedsize + infosize;

		fwrite( &varhed, hedsize, 1, fp );
		fwrite( varinfo->GetBuffer(), infosize, 1, fp );
		fwrite( vardata->GetBuffer(), datasize, 1, fp );

		fclose(fp);
	} else {
		res = -1;
	}

	delete vardata;
	delete varinfo;
	delete saved_struct;
	delete saved_module;
	return res;
}


static void varsave_put_module_direct( HSPEXINFO *hei, STRUCTDAT *st, int encode )
{
	HSP3VARFILEDATA *dat = (HSP3VARFILEDATA *)varinfo->PreparePtr( sizeof(HSP3VARFILEDATA) );

	dat->name = vardata->GetSize();
	vardata->PutStrBlock( "" );
	dat->data = vardata->GetSize();
	dat->flags = HVFDATA_TYPE_MODULE;
	dat->encode = encode;
	memset( &dat->master, 0, sizeof(PVal) );
	
	// メンバの数を記録する
	vardata->Put( st->prmmax - 1 );

	// モジュール名を記録する
	char *modname = vardata->PreparePtr( MODNAME_SIZE );
	memset( modname, 0, MODNAME_SIZE );
	strncpy( modname, ((HSPCTX *)hei->hspctx)->mem_mds + st->nameidx, MODNAME_SIZE - 1 );
}


static int varsave_put_module( HSPEXINFO *hei, STRUCTDAT *st, int encode )
{
	// モジュールの情報を書き込んでその varinfo インデックスを返す
	if ( saved_module != NULL ) {
		saved_module_t::iterator it = saved_module->find( st->prmindex );
		if ( it != saved_module->end() ) {
			return it->second;
		}
	}
	int index = varhed.num++;
	if ( saved_module == NULL ) {
		saved_module = new saved_module_t;
	}
	(*saved_module)[st->prmindex] = index;
	varsave_put_module_direct( hei, st, encode );
	return index;
}


static int varsave_put_member( HSPEXINFO *hei, PVal *pval, int encode )
{
	// struct オブジェクトのメンバの情報を書き込み、その varinfo インデックスを返す
	HSP3VARFILEDATA *dat = (HSP3VARFILEDATA *)varinfo->PreparePtr( sizeof(HSP3VARFILEDATA) );
	int index = varhed.num++;

	dat->name = vardata->GetSize();
	vardata->PutStrBlock( "" );
	dat->data = vardata->GetSize();
	dat->flags = HVFDATA_TYPE_MEMBER;
	dat->encode = encode;
	dat->master = *pval;
	varsave_putvar( hei, pval, encode );
	return index;
}

static void varsave_put_struct_direct( HSPEXINFO *hei, STRUCT *obj, int encode )
{
	HSPCTX *hspctx = (HSPCTX *)hei->hspctx;
	STRUCTPRM *prm = &hspctx->mem_minfo[ STRUCT_GET_MODULE( obj ) ];
	STRUCTDAT *st = &hspctx->mem_finfo[ prm->subid ];

	HSP3VARFILEDATA *dat = (HSP3VARFILEDATA *)varinfo->PreparePtr( sizeof(HSP3VARFILEDATA) );

	dat->name = vardata->GetSize();
	vardata->PutStrBlock( "" );
	dat->data = vardata->GetSize();
	dat->flags = HVFDATA_TYPE_STRUCT;
	dat->encode = encode;
	memset( &dat->master, 0, sizeof(PVal) );

	int max = st->prmmax - 1;
	prm ++;

	// モジュールを指す varinfo インデックスと、
	// メンバを指す varinfo インデックスをメンバの数だけ書き込む
	int pos = vardata->GetSize();
	vardata->PreparePtr( sizeof(int) + sizeof(int) * max );

	int module_index = varsave_put_module( hei, st, encode );
	*(int *)(vardata->GetBuffer() + pos) = module_index;
	pos += sizeof(int);

	PVal *p = (PVal *)GET_STRUCT_MEMBERS_BUFFER(obj);
	PVal *pend = p + max;
	while ( p < pend ) {
		int member_index = varsave_put_member( hei, p, encode );
		*(int *)(vardata->GetBuffer() + pos) = member_index;
		pos += sizeof(int);
		p ++;
	}
}


static int varsave_put_struct( HSPEXINFO *hei, STRUCT *obj, int encode )
{
	//	struct オブジェクトの情報を書き込んでその varinfo インデックスを返す
	//	同一のオブジェクトをすでに書き込んでいる場合は同じインデックスを返す
	//	struct オブジェクトが empty (NULL) の場合は 0 を返す
	//	( varinfo の 0 番目は HVFDATA_TYPE_VAR のデータが格納されていて、
	//    HVFDATA_TYPE_STRUCT のデータが格納されていることはありえないはず）
	if ( obj == NULL ) {
		return 0;
	}
	if ( saved_struct != NULL ) {
		saved_struct_t::iterator it = saved_struct->find( obj );
		if ( it != saved_struct->end() ) {
			return it->second;
		}
	}
	int index = varhed.num++;
	if ( saved_struct == NULL ) {
		saved_struct = new saved_struct_t;
	}
	(*saved_struct)[obj] = index;
	varsave_put_struct_direct( hei, obj, encode );
	return index;
}


static int varsave_put_storage_struct( HSPEXINFO *hei, PVal *pv, int encode )
{
	STRUCT **p = (STRUCT **)pv->pt;
	int len = pv->size / sizeof(STRUCT *);
	STRUCT **pend = p + len;
	int pos = vardata->GetSize();
	vardata->PreparePtr( sizeof(int) * len );
	
	// struct オブジェクト情報の varinfo インデックスを配列のサイズ分書き込む
	while ( p < pend ) {
		int struct_index = varsave_put_struct( hei, *p, encode );
		*(int *)(vardata->GetBuffer() + pos) = 0x80000000 | struct_index;
		pos += sizeof(int);
		p ++;
	}
	return 0;
}


static int varsave_put_storage( HSPEXINFO *hei, PVal *pv, int encode )
{
	//		固定長ストレージの保存
	//
	if ( pv->mode != HSPVAR_MODE_MALLOC ) return -1;
	switch ( pv->flag ) {
	case HSPVAR_FLAG_LABEL:
		{
		unsigned short **labels = (unsigned short **)pv->pt;
		int len = pv->size / sizeof(unsigned short *);
		unsigned short *mem_mcs = ((HSPCTX *)hei->hspctx)->mem_mcs;
		int i;
		for ( i = 0; i < len; i ++ ) {
			unsigned short *label = labels[i];
			if ( label == NULL ) {
				vardata->Put( -1 );
			} else {
				vardata->Put( (int)(label - mem_mcs) );
			}
		}
		}
		break;
	case HSPVAR_FLAG_STRUCT:
		varsave_put_storage_struct( hei, pv, encode );
		break;
	case HSPVAR_FLAG_COMSTRUCT:							// COMOBJ型は無効にする
	case 7:												// Variant型は無効にする
		return -1;
	default:
		vardata->PutData( pv->pt, pv->size );			// 変数の持つメモリ全体を保存する
		break;
	}
	return 0;
}


static int varsave_put_flexstorage( HSPEXINFO *hei, PVal *pv, int encode )
{
	//		可変長ストレージの保存
	//
	int i,max;
	int size;
	char *p;
	if ( pv->mode != HSPVAR_MODE_MALLOC ) return -1;

	max = pv->size / sizeof(char *);
	for(i=0;i<max;i++) {
		p = pv_getblock( hei, pv, i, &size );

		//		タグコード, size(int), 実データ(size)を記録する
		vardata->Put( (int)HSP3VARFILEFXCODE );
		vardata->Put( size );
		vardata->PutData( p, size );					// 変数の持つメモリ全体を保存する
	}
	return 0;
}


static int varsave_putvar( HSPEXINFO *hei, PVal *pv, int encode )
{
	int res;
	unsigned short	support;
	res = -1;
	support = pv->support;
	if ( support & HSPVAR_SUPPORT_STORAGE ) res = varsave_put_storage( hei, pv, encode );
	if ( support & HSPVAR_SUPPORT_FLEXSTORAGE ) res = varsave_put_flexstorage( hei, pv, encode );
	return res;
}


static int varsave_put( HSPEXINFO *hei, int varid, int encode )
{
	HSPCTX *hspctx;
	PVal *mem_var;
	char *name;
	char tmp[64];
	int res;

	hspctx = (HSPCTX *)hei->hspctx;
	if (( varid < 0 )||( varid >= hspctx->hsphed->max_val )) return -1;
	mem_var = hspctx->mem_var + varid;

	name = hei->HspFunc_varname( varid );
	if ( *name == 0 ) {
		sprintf( tmp,"var#%d",varid );
		name = tmp;
	}

	HSP3VARFILEDATA *dat = (HSP3VARFILEDATA *)varinfo->PreparePtr( sizeof(HSP3VARFILEDATA) );
	varhed.num++;
	dat->name = vardata->GetSize();
	vardata->PutStrBlock( name );			// 変数名を保存する
	dat->data = vardata->GetSize();
	dat->flags = HVFDATA_TYPE_VAR;
	dat->encode = encode;
	dat->master = *mem_var;					// とりあえずPValを保存する

	res = varsave_putvar( hei, mem_var, encode );
	if ( res ) return res;

	return 0;
}


static int varload_init( void *mem )
{
	vmem = (HSP3VARFILEHED *)mem;
	if ( strcmp( vmem->magic, HSP3VARFILECODE ) ) return -1;
	vmem_infos = (HSP3VARFILEDATA *)(vmem+1);
	vmem_buf = ((char *)vmem) + vmem->pt_data;
	loaded_struct = NULL;
	loaded_module = NULL;
	return 0;
}


static void varload_bye( HSPEXINFO *hei )
{
	if ( loaded_struct != NULL ) {
		loaded_struct_t::iterator it;
		for ( it = loaded_struct->begin(); it != loaded_struct->end(); ++it ) {
			hei->HspFunc_remove_struct_ref( it->second );
		}
	}
	delete loaded_struct;
	delete loaded_module;
}


#define FLEXVAL_TYPE_NONE 0
#define FLEXVAL_TYPE_ALLOC 1
#define FLEXVAL_TYPE_CLONE 2
typedef struct
{
	short type;			// typeID
	short myid;			// 固有ID(未使用)
	short customid;		// structure ID
	short clonetype;	// typeID for clone
	int size;			// data size
	void *ptr;			// data ptr
} FlexValue;

static int varload_get_storage_struct_ver31_compatible( HSPEXINFO *hei, char *vdata, PVal *pv, PVal *pv2, int encode )
{
	//	ver 3.1のvsaveで保存されたstruct型のフォーマットから読み込む
	char *mem = vdata;
	int vmax = pv2->size / sizeof(FlexValue);

	pv_dispose( hei,pv );								// 変数を破棄
	*pv = *pv2;
	pv->size = vmax * sizeof(STRUCT *);
	pv_alloc( hei, pv, NULL );							// 変数を再確保


	// モジュール変数個数を取得
	int max = *(int *)mem & 0xffff;
	mem += sizeof(int);

	// モジュール名を取得
	char modname[MODNAME_SIZE];
	memcpy( modname, mem, MODNAME_SIZE );
	mem += MODNAME_SIZE;

	int custid = pv_seekstruct( hei, modname );
	if ( custid < 0 ) {
		return -1;
	}

	HSPCTX *hspctx = (HSPCTX *)hei->hspctx;
	STRUCTDAT *st = &hspctx->mem_finfo[ custid ];
	char *orgname = hspctx->mem_mds + st->nameidx;
	int orgmax = st->prmmax - 1;
	if ( orgmax != max ) {
		return -1;
	}

	STRUCT **p = (STRUCT **)pv->pt;

	for ( int i = 0; i < vmax; i ++ ) {
		//		タグコード + typeを取得する
		int code = *(int *)mem;
		int type = code & 0xffff;
		code &= 0xffff0000;
		if ( code != HSP3VARFILEFXCODE ) {
			return -1;
		}
		mem += sizeof(int);

		if ( type == FLEXVAL_TYPE_ALLOC ) {
			PVal *members = create_struct_members_buffer( hei, st );
			*p = hei->HspFunc_new_struct( st, members );
			for ( int j = 0; j < max; j++ ) {
				PVal *base = (PVal *)mem;
				mem += sizeof(PVal);
				int nextcnt = *(int *)mem;
				mem += sizeof(int);
				varload_getvar( hei, mem, &members[j], base, encode );
				mem += nextcnt;
			}
		}
		p ++;
	}
	return 0;
}

static STRUCTDAT *varload_get_module_direct( HSPEXINFO *hei, int index, int encode )
{
	if ( index < 0 || index >= vmem->num ) {
		return NULL;
	}
	HSP3VARFILEDATA *info = &vmem_infos[index];
	if ( !HVFDATA_IS_MODULE(info) ) {
		return NULL;
	}
	char *mem = vmem_buf + info->data;
	int max = *(int *)mem;
	mem += sizeof(int);
	char modname[MODNAME_SIZE];
	memcpy( modname, mem, MODNAME_SIZE );
	int custid = pv_seekstruct( hei, modname );
	if ( custid < 0 ) {
		return NULL;
	}
	HSPCTX *hspctx = (HSPCTX *)hei->hspctx;
	STRUCTDAT *st = &hspctx->mem_finfo[ custid ];
	int orgmax = st->prmmax - 1;
	if ( orgmax != max ) {
		return NULL;
	}
	return st;
}


static STRUCTDAT *varload_get_module( HSPEXINFO *hei, int index, int encode )
{
	if ( loaded_module != NULL ) {
		loaded_module_t::iterator it = loaded_module->find( index );
		if ( it != loaded_module->end() ) {
			return it->second;
		}
	}
	STRUCTDAT *st = varload_get_module_direct( hei, index, encode );
	if ( loaded_module == NULL ) {
		loaded_module = new loaded_module_t;
	}
	(*loaded_module)[index] = st;
	return st;
}


static int varload_get_member( HSPEXINFO *hei, int index, PVal *member, int encode )
{
	if ( index < 0 || index >= vmem->num ) {
		return -1;
	}
	HSP3VARFILEDATA *info = &vmem_infos[index];
	if ( !HVFDATA_IS_MEMBER(info) ) {
		return -1;
	}
	return varload_getvar( hei, vmem_buf + info->data, member, &info->master, encode );
}


static int varload_get_struct( HSPEXINFO *hei, int index, STRUCT **result, int encode )
{
	if ( loaded_struct != NULL ) {
		loaded_struct_t::iterator it = loaded_struct->find( index );
		if ( it != loaded_struct->end() ) {
			*result = it->second->obj;
			return 0;
		}
	}
	if ( index < 0 || index >= vmem->num ) {
		return -1;
	}
	if ( index == 0 ) {
		*result = NULL;
		return 0;
	}
	HSP3VARFILEDATA *info = &vmem_infos[index];
	if ( !HVFDATA_IS_STRUCT(info) ) {
		return -1;
	}
	char *mem = vmem_buf + info->data;
	int module_index = *(int *)mem;
	mem += sizeof(int);
	STRUCTDAT *st = varload_get_module( hei, module_index, encode );
	if ( st == NULL ) {
		return -1;
	}
	PVal *members = create_struct_members_buffer( hei, st );
	int max = st->prmmax - 1;
	STRUCT *obj = hei->HspFunc_new_struct( st, members );
	STRUCT_REF *ref = hei->HspFunc_add_struct_ref( obj );
	if ( loaded_struct == NULL ) {
		loaded_struct = new loaded_struct_t;
	}
	(*loaded_struct)[index] = ref;
	for ( int i = 0; i < max; i ++ ) {
		int member_index = *(int *)mem;
		mem += sizeof(int);
		if ( varload_get_member( hei, member_index, &members[i], encode ) ) {
			return -1;
		}
	}
	*result = obj;
	return 0;
}


static int varload_get_storage_struct( HSPEXINFO *hei, char *vdata, PVal *pv, PVal *pv2, int encode )
{
	//		固定長ストレージ(STRUCT)の取得
	//
	char *mem = vdata;
	unsigned int code = *(unsigned int *)mem;
	if ( (code & 0xffff0000) == HSP3VARFILEFXCODE ) {
		return varload_get_storage_struct_ver31_compatible( hei, vdata, pv, pv2, encode );
	}

	pv_dispose( hei,pv );								// 変数を破棄
	*pv = *pv2;
	pv_alloc( hei, pv, NULL );							// 変数を再確保

	int len = pv->size / sizeof(STRUCT *);
	STRUCT **p = (STRUCT **)pv->pt;
	for ( int i = 0; i < len; i ++ ) {
		unsigned int code = *(unsigned int *)mem;
		mem += sizeof(int);
		if ( (code & 0x80000000) == 0 ) {
			return -1;
		}
		int struct_index = code & 0x7fffffff;
		if ( varload_get_struct( hei, struct_index, p, encode ) ) {
			return -1;
		}
		p ++;
	}
	return 0;
}


static int varload_get_storage_label( HSPEXINFO *hei, char *vdata, PVal *pv, PVal *pv2, int encode )
{
	//		固定長ストレージ(LABEL)の取得
	//
	int *offsets;
	int len;
	int i;
	unsigned short **p;
	unsigned short *mem_mcs = ((HSPCTX *)hei->hspctx)->mem_mcs;
	pv_dispose( hei,pv );								// 変数を破棄
	*pv = *pv2;
	pv_alloc( hei, pv, NULL );							// 変数を再確保
	offsets = (int *)vdata;
	p = (unsigned short **)pv->pt;
	len = pv->size / sizeof(unsigned short *);
	for ( i = 0; i < len; i ++ ) {
		int offset = offsets[i];
		if ( offset == -1 ) {
			p[i] = NULL;
		} else {
			p[i] = mem_mcs + offset;
		}
	}
	return 0;
}


static int varload_get_storage( HSPEXINFO *hei, char *vdata, PVal *pv, PVal *pv2, int encode )
{
	//		固定長ストレージの取得
	//
	pv_dispose( hei,pv );								// 変数を破棄
	*pv = *pv2;
	pv_alloc( hei, pv, NULL );							// 変数を再確保
	memcpy( pv->pt, vdata, pv->size );					// データをコピー
	return 0;
}


static int varload_get_flexstorage( HSPEXINFO *hei, char *vdata, PVal *pv, PVal *pv2, int encode )
{
	//		可変長ストレージの取得
	//
	int i,code,max;
	int size;
	char *p;
	char *mem;

	pv_dispose( hei,pv );								// 変数を破棄
	*pv = *pv2;
	pv_alloc( hei, pv, NULL );							// 変数を再確保

	mem = vdata;
	max = pv->size / sizeof(char *);
	for(i=0;i<max;i++) {
		code = *(int *)mem;
		if ( code != HSP3VARFILEFXCODE ) return -1;
		mem += sizeof(int);
		size = *(int *)mem;
		mem += sizeof(int);
		pv_allocblock( hei, pv, i, size );
		p = pv_getblock( hei, pv, i, &code );
		memcpy( p, mem, size );							// データをコピー
		mem += size;
	}

	return 0;
}


static int varload_getvar( HSPEXINFO *hei, char *vdata, PVal *pv, PVal *pv2, int encode )
{
	int res;
	unsigned short	support;
	support = pv2->support;
	res = -1;
	if ( support & HSPVAR_SUPPORT_STORAGE ) {
		switch( pv2->flag ) {
		case HSPVAR_FLAG_LABEL:
			res = varload_get_storage_label( hei, vdata, pv, pv2, encode );
			break;
		case HSPVAR_FLAG_STRUCT:
			res = varload_get_storage_struct( hei, vdata, pv, pv2, encode );
			break;
		default:
			res = varload_get_storage( hei, vdata, pv, pv2, encode );
			break;
		}
	}
	if ( support & HSPVAR_SUPPORT_FLEXSTORAGE ) {
		res = varload_get_flexstorage( hei, vdata, pv, pv2, encode );
	}
	return res;
}


static int varload_get( HSPEXINFO *hei, int varid, char *getname, int encode )
{
	HSPCTX *hspctx;
	HSP3VARFILEDATA *dat;
	PVal *mem_var;
	char *name;
	char *p;
	char *vdata;
	char tmp[64];
	int i,max;
	int res;

	hspctx = (HSPCTX *)hei->hspctx;
	if (( varid < 0 )||( varid >= hspctx->hsphed->max_val )) return -1;
	mem_var = hspctx->mem_var + varid;

	name = getname;
	if ( name == NULL ) {
		name = hei->HspFunc_varname( varid );
	}
	if ( *name == 0 ) {
		sprintf( tmp,"var#%d",varid );
		name = tmp;
	}

	max = vmem->num;
	dat = vmem_infos;
	for(i=0;i<max;i++) {
		p = vmem_buf + dat->name;
		vdata = vmem_buf + dat->data;
		if ( strcmp( p, name ) == 0 ) {
			res = varload_getvar( hei, vdata, mem_var, &dat->master, encode );
			return res;
		}
		dat++;
	}

	return -1;
}



/*------------------------------------------------------------*/

EXPORT BOOL WINAPI getvarid( HSPEXINFO *hei, int _p1, int _p2, int _p3 )
{
	//
	//		getvarid var,"name"  (type$202)
	//
	PVal *pv;
	APTR ap;
	char *p1;
	int p2;
	ap = hei->HspFunc_prm_getva( &pv );		// パラメータ1:変数
	p1 = hei->HspFunc_prm_gets();			// パラメータ2:文字列
	p2 = hei->HspFunc_seekvar( p1 );
	hei->HspFunc_prm_setva( pv, ap, TYPE_INUM, &p2 );	// 変数に値を代入
	return 0;
}


EXPORT BOOL WINAPI getvarname( HSPEXINFO *hei, int _p1, int _p2, int _p3 )
{
	//
	//		getvarname var,id  (type$202)
	//
	PVal *pv;
	APTR ap;
	int p1;
	char *p2;
	ap = hei->HspFunc_prm_getva( &pv );		// パラメータ1:変数
	p1 = hei->HspFunc_prm_getdi( 0 );		// パラメータ2:数値
	p2 = hei->HspFunc_varname( p1 );
	hei->HspFunc_prm_setva( pv, ap, TYPE_STRING, p2 );	// 変数に値を代入
	return 0;
}


EXPORT BOOL WINAPI getmaxvar( HSPEXINFO *hei, int _p1, int _p2, int _p3 )
{
	//
	//		getmaxvar var  (type$202)
	//
	PVal *pv;
	APTR ap;
	HSPCTX *hspctx;
	int p2;
	ap = hei->HspFunc_prm_getva( &pv );		// パラメータ1:変数
	hspctx = (HSPCTX *)hei->hspctx;
	p2 = hspctx->hsphed->max_val;
	hei->HspFunc_prm_setva( pv, ap, TYPE_INUM, &p2 );	// 変数に値を代入
	return 0;
}


EXPORT BOOL WINAPI vsave( HSPEXINFO *hei, int _p1, int _p2, int _p3 )
{
	//
	//		vsave "filename"  (type$202)
	//
	int i,max,res;
	char *p1;
	HSPCTX *hspctx;

	p1 = hei->HspFunc_prm_gets();			// パラメータ1:文字列

	hspctx = (HSPCTX *)hei->hspctx;
	max = hspctx->hsphed->max_val;

	varsave_init();
	for(i=0;i<max;i++) {
		varsave_put( hei, i, 0 );
	}
	res = varsave_bye( p1 );
	return res;
}


EXPORT BOOL WINAPI vload( HSPEXINFO *hei, int _p1, int _p2, int _p3 )
{
	//
	//		vload "filename"  (type$202)
	//
	int i,max,res;
	char *p1;
	char *tmp;
	HSPCTX *hspctx;

	p1 = hei->HspFunc_prm_gets();			// パラメータ1:文字列

	hspctx = (HSPCTX *)hei->hspctx;
	max = hspctx->hsphed->max_val;

	res = hei->HspFunc_fsize( p1 );
	if ( res <= 0 ) return -1;

	tmp = (char *)malloc( res );
	hei->HspFunc_fread( p1, tmp, res, 0 );

	res = varload_init( tmp );
	if ( res == 0 ) {
		for(i=0;i<max;i++) {
			varload_get( hei, i, NULL, 0 );
		}
	}
	varload_bye( hei );
	free( tmp );
	return res;
}


EXPORT BOOL WINAPI vsave_start( HSPEXINFO *hei, int _p1, int _p2, int _p3 )
{
	//
	//		vsave_start  (type$202)
	//
	varsave_init();
	return 0;
}


EXPORT BOOL WINAPI vsave_put( HSPEXINFO *hei, int _p1, int _p2, int _p3 )
{
	//
	//		vsave_put var  (type$202)
	//
	PVal *pv;
	APTR ap;
	int res;
	int val,type;

	type = *(hei->nptype);
	val = *(hei->npval);
	ap = hei->HspFunc_prm_getva( &pv );		// パラメータ1:変数

	if ( type != TYPE_VAR ) return -2;
	res = varsave_put( hei, val, 0 );
	return res;
}


EXPORT BOOL WINAPI vsave_end( HSPEXINFO *hei, int _p1, int _p2, int _p3 )
{
	//
	//		vsave_end "filename"  (type$202)
	//
	int res;
	char *p1;
	p1 = hei->HspFunc_prm_gets();			// パラメータ1:文字列
	res = varsave_bye( p1 );
	return res;
}


EXPORT BOOL WINAPI vload_start( HSPEXINFO *hei, int _p1, int _p2, int _p3 )
{
	//
	//		vload_start "filename"  (type$202)
	//
	int res;
	char *p1;

	p1 = hei->HspFunc_prm_gets();			// パラメータ1:文字列

	res = hei->HspFunc_fsize( p1 );
	if ( res <= 0 ) return -1;

	vload_tmp = (char *)malloc( res );
	hei->HspFunc_fread( p1, vload_tmp, res, 0 );

	res = varload_init( vload_tmp );
	if ( res ) {
		varload_bye( hei );
		free( vload_tmp );
	}
	return res;
}


EXPORT BOOL WINAPI vload_get( HSPEXINFO *hei, int _p1, int _p2, int _p3 )
{
	//
	//		vload_get var  (type$202)
	//
	PVal *pv;
	APTR ap;
	int res;
	int val,type;

	type = *(hei->nptype);
	val = *(hei->npval);
	ap = hei->HspFunc_prm_getva( &pv );		// パラメータ1:変数

	if ( type != TYPE_VAR ) return -2;
	res = varload_get( hei, val, NULL, 0 );
	return res;
}


EXPORT BOOL WINAPI vload_end( HSPEXINFO *hei, int _p1, int _p2, int _p3 )
{
	//
	//		vload_end  (type$202)
	//
	varload_bye( hei );
	free( vload_tmp );
	return 0;
}


