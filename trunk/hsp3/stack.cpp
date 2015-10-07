
//
//	HSP3 stack support
//	(汎用スタックマネージャー)
//	(int,double,stringなどの可変長データをpush,popできます)
//	onion software/onitama 2004/6
//
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "stack.h"

/*------------------------------------------------------------*/
/*
		system data
*/
/*------------------------------------------------------------*/

int stm_cur_len;
int stm_max;
STMDATA *mem_stm;
STMDATA *stm_cur;
STMDATA *stm_maxptr;

/*------------------------------------------------------------*/
/*
		interface
*/
/*------------------------------------------------------------*/

void StackInit( void )
{
	stm_max = STM_MAX_DEFAULT;
	mem_stm = (STMDATA *)malloc( sizeof( STMDATA ) * stm_max );
	stm_maxptr = mem_stm + stm_max;
	stm_cur = mem_stm;
	stm_cur_len = 0;

	for ( STMDATA *stm = mem_stm; stm != stm_maxptr; stm++ ) {
		stm->type = HSPVAR_FLAG_INT;
		stm->prev_len = 1;
	}
}

void StackTerm( void )
{
	StackReset();
	free( mem_stm );
}

void StackReset( void )
{
	while(1) {
		if ( stm_cur == mem_stm ) break;
		StackPop();
	}
}

static inline int CalcLen( int size )
{
	if ( size <= STM_STRSIZE_DEFAULT ) {
		return 1;
	} else {
		return 1 + ((size - STM_STRSIZE_DEFAULT) + sizeof(STMDATA) - 1) / sizeof(STMDATA);
	}
}

void StackPush( int type, char *data, int size )
{
	switch( type ) {
	case HSPVAR_FLAG_LABEL:
		StackPushl(*(int *)data);
		return;
	case HSPVAR_FLAG_INT:
		StackPushi(*(int *)data);
		return;
	case HSPVAR_FLAG_DOUBLE:
		StackPushd(*(double *)data);
		return;
	default:
		break;
	}
	int len = CalcLen(size);
	STMDATA *stm = stm_cur;
	stm->type = type;
	memcpy( stm->ptr, data, size );
	StackIncLevel(len);
}

void StackPush( int type, char *str )
{
	StackPush( type, str, (int)strlen(str)+1 );
}

void *StackPushSize( int type, int size )
{
	int len = CalcLen(size);
	STMDATA *stm = stm_cur;
	stm->type = type;
	StackIncLevel(len);
	return stm->ptr;
}

void StackPushStr( char *str )
{
	StackPush( HSPVAR_FLAG_STR, str, (int)strlen(str)+1 );
}
