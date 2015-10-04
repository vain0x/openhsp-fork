
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "hspvar_core.h"
#include "hsp3debug.h"
#include "strbuf.h"

/*------------------------------------------------------------*/
/*
HSPVAR core interface (int64)
*/
/*------------------------------------------------------------*/

#define GetPtr(pdat) ((int64 *)pdat)

static short *aftertype;

// Core
static PDAT *HspVarInt64_GetPtr(PVal *pval)
{
	return (PDAT *)(((int64 *)(pval->pt)) + pval->offset);
}

void *HspVarInt64_Cnv(const void *buffer, int flag)
{
	//		リクエストされた型 -> 自分の型への変換を行なう
	//		(組み込み型にのみ対応でOK)
	//		(参照元のデータを破壊しないこと)
	//
	static int64 conv;

	switch ( flag ) {
		case HSPVAR_FLAG_STR:
			conv = (int64)_atoi64((char *)buffer);
			break;
		case HSPVAR_FLAG_INT:
			conv = (int64)(*(int *)buffer);
			break;
		case HSPVAR_FLAG_DOUBLE:
			conv = (int64)(*(double *)buffer);
			break;
		case HSPVAR_FLAG_INT64:
			return (void *)buffer;
		default:
			throw HSPERR_TYPE_MISMATCH;
	}
	return &conv;
}


static int GetVarSize(PVal *pval)
{
	//		PVALポインタの変数が必要とするサイズを取得する
	//		(sizeフィールドに設定される)
	//
	int size;
	size = pval->len[1];
	if ( pval->len[2] ) size *= pval->len[2];
	if ( pval->len[3] ) size *= pval->len[3];
	if ( pval->len[4] ) size *= pval->len[4];
	size *= sizeof(int64);
	return size;
}


static void HspVarInt64_Free(PVal *pval)
{
	//		PVALポインタの変数メモリを解放する
	//
	if ( pval->mode == HSPVAR_MODE_MALLOC ) { sbFree(pval->pt); }
	pval->pt = NULL;
	pval->mode = HSPVAR_MODE_NONE;
}


static void HspVarInt64_Alloc(PVal *pval, const PVal *pval2)
{
	//		pval変数が必要とするサイズを確保する。
	//		(pvalがすでに確保されているメモリ解放は呼び出し側が行なう)
	//		(flagの設定は呼び出し側が行なう)
	//		(pval2がNULLの場合は、新規データ)
	//		(pval2が指定されている場合は、pval2の内容を継承して再確保)
	//
	int i, size;
	char *pt;
	if ( pval->len[1] < 1 ) pval->len[1] = 1;		// 配列を最低1は確保する
	size = GetVarSize(pval);
	pval->mode = HSPVAR_MODE_MALLOC;
	pt = sbAlloc(size);
	memset(pt, 0, size);
	if ( pval2 != NULL ) {
		memcpy(pt, pval->pt, pval->size);
		sbFree(pval->pt);
	}
	pval->pt = pt;
	pval->size = size;
}

// Size
static int HspVarInt64_GetSize(const PDAT *pval)
{
	return sizeof(int64);
}

// Set
static void HspVarInt64_Set(PVal *pval, PDAT *pdat, const void *in)
{
	*GetPtr(pdat) = *((int64 *)(in));
}

// Add
static void HspVarInt64_AddI(PDAT *pval, const void *val)
{
	*GetPtr(pval) += *((int64 *)(val));
}

// Sub
static void HspVarInt64_SubI(PDAT *pval, const void *val)
{
	*GetPtr(pval) -= *((int64 *)(val));
}

// Mul
static void HspVarInt64_MulI(PDAT *pval, const void *val)
{
	*GetPtr(pval) *= *((int64 *)(val));
}

// Div
static void HspVarInt64_DivI(PDAT *pval, const void *val)
{
	int64 p = *((int64 *)(val));
	if ( p == 0 ) throw(HSPVAR_ERROR_DIVZERO);
	*GetPtr(pval) /= p;
}

// Mod
static void HspVarInt64_ModI(PDAT *pval, const void *val)
{
	int64 p = *((int64 *)(val));
	if ( p == 0 ) throw(HSPVAR_ERROR_DIVZERO);
	*GetPtr(pval) %= p;
}

// And
static void HspVarInt64_AndI(PDAT *pval, const void *val)
{
	*GetPtr(pval) &= *((int64 *)(val));
}

// Or
static void HspVarInt64_OrI(PDAT *pval, const void *val)
{
	*GetPtr(pval) |= *((int64 *)(val));
}

// Xor
static void HspVarInt64_XorI(PDAT *pval, const void *val)
{
	*GetPtr(pval) ^= *((int64 *)(val));
}

// Rr
static void HspVarInt64_RrI(PDAT *pval, const void *val)
{
	*GetPtr(pval) >>= *((int64 *)(val));
}

// Lr
static void HspVarInt64_LrI(PDAT *pval, const void *val)
{
	*GetPtr(pval) <<= *((int64 *)(val));
}

// Eq
static void HspVarInt64_EqI(PDAT *pval, const void *val)
{
	*((int *)pval) = (*GetPtr(pval) == *((int64 *)(val)));
	*aftertype = HSPVAR_FLAG_INT;
}

// Ne
static void HspVarInt64_NeI(PDAT *pval, const void *val)
{
	*((int *)pval) = (*GetPtr(pval) != *((int64 *)(val)));
	*aftertype = HSPVAR_FLAG_INT;
}

// Gt
static void HspVarInt64_GtI(PDAT *pval, const void *val)
{
	*((int *)pval) = (*GetPtr(pval) > *((int64 *)(val)));
	*aftertype = HSPVAR_FLAG_INT;
}

// Lt
static void HspVarInt64_LtI(PDAT *pval, const void *val)
{
	*((int *)pval) = (*GetPtr(pval) < *((int64 *)(val)));
	*aftertype = HSPVAR_FLAG_INT;
}

// GtEq
static void HspVarInt64_GtEqI(PDAT *pval, const void *val)
{
	*((int *)pval) = (*GetPtr(pval) >= *((int64 *)(val)));
	*aftertype = HSPVAR_FLAG_INT;
}

// LtEq
static void HspVarInt64_LtEqI(PDAT *pval, const void *val)
{
	*((int *)pval) = (*GetPtr(pval) <= *((int64 *)(val)));
	*aftertype = HSPVAR_FLAG_INT;
}

static void *GetBlockSize(PVal *pval, PDAT *pdat, int *size)
{
	*size = pval->size - (((char *)pdat) - pval->pt);
	return (pdat);
}

static void AllocBlock(PVal *pval, PDAT *pdat, int size)
{}

/*------------------------------------------------------------*/

void HspVarInt64_Init(HspVarProc *p)
{
	aftertype = &p->aftertype;

	p->Set = HspVarInt64_Set;
	p->Cnv = HspVarInt64_Cnv;
	p->GetPtr = HspVarInt64_GetPtr;
	p->GetSize = HspVarInt64_GetSize;
	p->GetBlockSize = GetBlockSize;
	p->AllocBlock = AllocBlock;

	p->Alloc = HspVarInt64_Alloc;
	p->Free = HspVarInt64_Free;

	p->AddI = HspVarInt64_AddI;
	p->SubI = HspVarInt64_SubI;
	p->MulI = HspVarInt64_MulI;
	p->DivI = HspVarInt64_DivI;
	p->ModI = HspVarInt64_ModI;

	p->AndI = HspVarInt64_AndI;
	p->OrI = HspVarInt64_OrI;
	p->XorI = HspVarInt64_XorI;

	p->EqI = HspVarInt64_EqI;
	p->NeI = HspVarInt64_NeI;
	p->GtI = HspVarInt64_GtI;
	p->LtI = HspVarInt64_LtI;
	p->GtEqI = HspVarInt64_GtEqI;
	p->LtEqI = HspVarInt64_LtEqI;

	p->RrI = HspVarInt64_RrI;
	p->LrI = HspVarInt64_LrI;

	p->vartype_name = "int64";
	p->version = 0x001;
	p->support = HSPVAR_SUPPORT_STORAGE | HSPVAR_SUPPORT_FLEXARRAY;
	p->basesize = sizeof(int64);
}

/*------------------------------------------------------------*/
