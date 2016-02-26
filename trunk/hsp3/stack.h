
//
//	stack.cpp header
//
#ifndef __stack_h
#define __stack_h

#include <assert.h>
#include "hsp3config.h"

#define STM_MAX_DEFAULT 2048
#define STM_STRSIZE_DEFAULT 64

#include "hspvar_core.h"
#include "hsp3debug.h"

//	STMDATA structure
//
typedef struct
{
	//	Memory Data structure
	//
	short type;
	short _padding;
	int prev_len; // 1つ下の要素が占有する、STMDATA の個数
	union
	{
		char ptr[STM_STRSIZE_DEFAULT];
		int ival;
		double dval;
	} HSP_ALIGN_DOUBLE;
} STMDATA;

void StackInit( void );
void StackTerm( void );
void StackReset( void );
void StackPush( int type, char *data, int size );
void StackPush( int type, char *str );
void *StackPushSize( int type, int size );
void StackPushi( int val );
void StackPushStr( char *str );

extern int stm_cur_len; // 現在のトップ要素の長さ
extern int stm_max;
extern STMDATA *mem_stm;
extern STMDATA *stm_cur;
extern STMDATA *stm_maxptr;

#define STM_GETPTR( pp ) ( pp->ptr ) 

#define StackPeek (stm_cur - stm_cur_len)
#define StackPeek2 (stm_cur - (stm_cur_len + StackPeek->prev_len))
#define PeekPtr ((void *)StackPeek->ptr)

#define StackGetLevel (stm_cur-mem_stm)
#define StackPop StackDecLevel

inline void StackIncLevel(int len)
{
	// スタックポインタを進める

	stm_cur->prev_len = stm_cur_len;
	stm_cur += len;
	stm_cur_len = len;

	if ( stm_cur > stm_maxptr ) throw HSPERR_STACK_OVERFLOW;
}

inline void StackDecLevel()
{
	// スタックポインタを戻す

	stm_cur -= stm_cur_len;
	stm_cur_len = stm_cur->prev_len;

	assert(mem_stm <= stm_cur && stm_cur < stm_maxptr);
}

inline void StackPushi( int val )
{
	stm_cur->type = HSPVAR_FLAG_INT;
	stm_cur->ival = val;
	StackIncLevel(1);
}

inline void StackPushl( int val )
{
	stm_cur->type = HSPVAR_FLAG_LABEL;
	stm_cur->ival = val;
	StackIncLevel(1);
}

inline void StackPushd( double val )
{
	stm_cur->type = HSPVAR_FLAG_DOUBLE;
	stm_cur->dval = val;
	StackIncLevel(1);
}

#endif
