
//
//	HSPVAR core module
//	onion software/onitama 2003/4
//
#define WIN32_LEAN_AND_MEAN		// Exclude rarely-used stuff from Windows headers
#include <windows.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "hsp3plugin.h"
#include "hspvar_core.h"
#include "hsp3debug.h"

/*------------------------------------------------------------*/
/*
		HSPVAR core interface (float)
*/
/*------------------------------------------------------------*/

#define GetPtr(pval) ((float *)pval)
#define sbAlloc hspmalloc
#define sbFree hspfree

static int mytype;
static float conv;
static short *aftertype;
static char custom[64];

// Core
static PDAT *HspVarFloat_GetPtr( PVal *pval )
{
	return (PDAT *)(( (float *)(pval->pt))+pval->offset);
}

static void *HspVarFloat_Cnv( const void *buffer, int flag )
{
	//		リクエストされた型 -> 自分の型への変換を行なう
	//		(組み込み型にのみ対応でOK)
	//		(参照元のデータを破壊しないこと)
	//
	switch( flag ) {
	case HSPVAR_FLAG_STR:
		conv = (float)atof( (char *)buffer );
		return &conv;
	case HSPVAR_FLAG_INT:
		conv = (float)( *(int *)buffer );
		return &conv;
	case HSPVAR_FLAG_DOUBLE:
		conv = (float)( *(double *)buffer );
		break;
	default:
		throw HSPVAR_ERROR_TYPEMISS;
	}
	return (void *)buffer;
}


static void *HspVarFloat_CnvCustom( const void *buffer, int flag )
{
	//		(カスタムタイプのみ)
	//		自分の型 -> リクエストされた型 への変換を行なう
	//		(組み込み型に対応させる)
	//		(参照元のデータを破壊しないこと)
	//
	float p;
	p = *(float *)buffer;
	switch( flag ) {
	case HSPVAR_FLAG_STR:
		sprintf( custom, "%f", p );
		break;
	case HSPVAR_FLAG_INT:
		*(int *)custom = (int)p;
		break;
	case HSPVAR_FLAG_DOUBLE:
		*(double *)custom = (double)p;
		break;
	default:
		throw HSPVAR_ERROR_TYPEMISS;
	}
	return custom;
}


static int GetVarSize( PVal *pval )
{
	//		PVALポインタの変数が必要とするサイズを取得する
	//		(sizeフィールドに設定される)
	//
	int size;
	size = pval->len[1];
	if ( pval->len[2] ) size*=pval->len[2];
	if ( pval->len[3] ) size*=pval->len[3];
	if ( pval->len[4] ) size*=pval->len[4];
	size *= sizeof(float);
	return size;
}


static void HspVarFloat_Free( PVal *pval )
{
	//		PVALポインタの変数メモリを解放する
	//
	if ( pval->mode == HSPVAR_MODE_MALLOC ) { sbFree( pval->pt ); }
	pval->pt = NULL;
	pval->mode = HSPVAR_MODE_NONE;
}


static void HspVarFloat_Alloc( PVal *pval, const PVal *pval2 )
{
	//		pval変数が必要とするサイズを確保する。
	//		(pvalがすでに確保されているメモリ解放は呼び出し側が行なう)
	//		(flagの設定は呼び出し側が行なう)
	//		(pval2がNULLの場合は、新規データ)
	//		(pval2が指定されている場合は、pval2の内容を継承して再確保)
	//
	int i,size;
	char *pt;
	float *fv;
	if ( pval->len[1] < 1 ) pval->len[1] = 1;		// 配列を最低1は確保する
	size = GetVarSize( pval );
	pval->mode = HSPVAR_MODE_MALLOC;
	pt = sbAlloc( size );
	fv = (float *)pt;
	for(i=0;i<(int)(size/sizeof(float));i++) { fv[i]=0.0; }
	if ( pval2 != NULL ) {
		memcpy( pt, pval->pt, pval->size );
		sbFree( pval->pt );
	}
	pval->pt = pt;
	pval->size = size;
}

/*
static void *HspVarFloat_ArrayObject( PVal *pval, int *mptype )
{
	//		配列要素の指定 (文字列/連想配列用)
	//
	throw HSPERR_UNSUPPORTED_FUNCTION;
	return NULL;
}
*/

// Size
static int HspVarFloat_GetSize( const PDAT *pval )
{
	return sizeof(float);
}

// Set
static void HspVarFloat_Set( PVal *pval, PDAT *pdat, const void *in )
{
	*GetPtr(pdat) = *((float *)(in));
}

// Add
static void HspVarFloat_AddI( PDAT *pval, const void *val )
{
	*GetPtr(pval) += *((float *)(val));
	*aftertype = mytype;
}

// Sub
static void HspVarFloat_SubI( PDAT *pval, const void *val )
{
	*GetPtr(pval) -= *((float *)(val));
	*aftertype = mytype;
}

// Mul
static void HspVarFloat_MulI( PDAT *pval, const void *val )
{
	*GetPtr(pval) *= *((float *)(val));
	*aftertype = mytype;
}

// Div
static void HspVarFloat_DivI( PDAT *pval, const void *val )
{
	float p = *((float *)(val));
	if ( p == 0 ) throw( HSPVAR_ERROR_DIVZERO );
	*GetPtr(pval) /= p;
	*aftertype = mytype;
}

// Eq
static void HspVarFloat_EqI( PDAT *pval, const void *val )
{
	*((int *)pval) = ( *GetPtr(pval) == *((float *)(val)) );
	*aftertype = HSPVAR_FLAG_INT;
}

// Ne
static void HspVarFloat_NeI( PDAT *pval, const void *val )
{
	*((int *)pval) = ( *GetPtr(pval) != *((float *)(val)) );
	*aftertype = HSPVAR_FLAG_INT;
}

// Gt
static void HspVarFloat_GtI( PDAT *pval, const void *val )
{
	*((int *)pval) = ( *GetPtr(pval) > *((float *)(val)) );
	*aftertype = HSPVAR_FLAG_INT;
}

// Lt
static void HspVarFloat_LtI( PDAT *pval, const void *val )
{
	*((int *)pval) = ( *GetPtr(pval) < *((float *)(val)) );
	*aftertype = HSPVAR_FLAG_INT;
}

// GtEq
static void HspVarFloat_GtEqI( PDAT *pval, const void *val )
{
	*((int *)pval) = ( *GetPtr(pval) >= *((float *)(val)) );
	*aftertype = HSPVAR_FLAG_INT;
}

// LtEq
static void HspVarFloat_LtEqI( PDAT *pval, const void *val )
{
	*((int *)pval) = ( *GetPtr(pval) <= *((float *)(val)) );
	*aftertype = HSPVAR_FLAG_INT;
}

/*
// INVALID
static void HspVarFloat_Invalid( PDAT *pval, const void *val )
{
	throw( HSPVAR_ERROR_INVALID );
}
*/

static void *GetBlockSize( PVal *pval, PDAT *pdat, int *size )
{
	*size = pval->size - ( ((char *)pdat) - pval->pt );
	return (pdat);
}

static void AllocBlock( PVal *pval, PDAT *pdat, int size )
{
}


/*------------------------------------------------------------*/

EXPORT int HspVarFloat_typeid( void )
{
	return mytype;
}


EXPORT void HspVarFloat_Init( HspVarProc *p )
{
	aftertype = &p->aftertype;

	p->Set = HspVarFloat_Set;
	p->Cnv = HspVarFloat_Cnv;
	p->GetPtr = HspVarFloat_GetPtr;
	p->CnvCustom = HspVarFloat_CnvCustom;
	p->GetSize = HspVarFloat_GetSize;
	p->GetBlockSize = GetBlockSize;
	p->AllocBlock = AllocBlock;

//	p->ArrayObject = HspVarFloat_ArrayObject;
	p->Alloc = HspVarFloat_Alloc;
	p->Free = HspVarFloat_Free;

	p->AddI = HspVarFloat_AddI;
	p->SubI = HspVarFloat_SubI;
	p->MulI = HspVarFloat_MulI;
	p->DivI = HspVarFloat_DivI;
//	p->ModI = HspVarFloat_Invalid;

//	p->AndI = HspVarFloat_Invalid;
//	p->OrI  = HspVarFloat_Invalid;
//	p->XorI = HspVarFloat_Invalid;

	p->EqI = HspVarFloat_EqI;
	p->NeI = HspVarFloat_NeI;
	p->GtI = HspVarFloat_GtI;
	p->LtI = HspVarFloat_LtI;
	p->GtEqI = HspVarFloat_GtEqI;
	p->LtEqI = HspVarFloat_LtEqI;

//	p->RrI = HspVarFloat_Invalid;
//	p->LrI = HspVarFloat_Invalid;

	p->vartype_name = "float";				// タイプ名
	p->version = 0x001;					// 型タイプランタイムバージョン(0x100 = 1.0)
	p->support = HSPVAR_SUPPORT_STORAGE|HSPVAR_SUPPORT_FLEXARRAY;
										// サポート状況フラグ(HSPVAR_SUPPORT_*)
	p->basesize = sizeof(float);		// １つのデータが使用するサイズ(byte) / 可変長の時は-1
	mytype = p->flag;
}

/*------------------------------------------------------------*/

