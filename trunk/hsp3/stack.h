
//
//	stack.cpp header
//
#ifndef __stack_h
#define __stack_h

#define STM_MAX_DEFAULT 256
#define STM_STRSIZE_DEFAULT 64

#define STMMODE_SELF 0
#define STMMODE_ALLOC 1

//	STMDATA structure
//
typedef struct
{
	//	Memory Data structure
	//
	short type;
	short mode;
	char *ptr;
	int ival;
	char itemp[STM_STRSIZE_DEFAULT-4];		// data area peding
} STMDATA;

void StackInit( void );
void StackTerm( void );
void StackReset( void );
void StackPush( int type, char *data, int size );
void StackPush( int type, char *str );
void *StackPushSize( int type, int size );
void StackPushi( int val );
void StackPushStr( char *str );
void StackPushType( int type );
void StackPushTypeVal( int type, int val, int val2 );
void StackPop( void );

extern int stm_max;
extern int stm_cur;
extern STMDATA *mem_stm;


#define STM_GETPTR( pp ) ( pp->ptr ) 

#define StackPeek (&mem_stm[ stm_cur-1 ])
#define StackPeek2 (&mem_stm[ stm_cur-2 ])
#define PeekPtr ((void *)mem_stm[ stm_cur-1 ].ptr)

#define StackGetLevel (stm_cur)
#define StackDecLevel stm_cur--



#endif
