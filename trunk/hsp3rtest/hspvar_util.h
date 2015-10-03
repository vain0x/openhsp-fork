
//
//	hspvar_util.cpp header
//
#ifndef __hspvar_util_h
#define __hspvar_util_h

//	CHSP3 Task callback function
//
typedef void (* CHSP3_TASK) (void);

//	CHSP3 original type (for stack)
//
#define HSPVAR_FLAG_MARK 0
#define HSPVAR_FLAG_VAR -1


//	Utility
//
void VarUtilInit( HSPCTX *ctx );
void VarUtilTerm( void );

void TaskExec( void );
void TaskSwitch( int label );

bool HspIf( void );

void Extcmd( int cmd, int pnum );
void Modcmd( int cmd, int pnum );
void Dllcmd( int cmd, int pnum );
void Prgcmd( int cmd, int pnum );
void Intcmd( int cmd, int pnum );

//  HSPVAR support functions
//
extern PVal *mem_var;

void PushInt( int val );
void PushStr( char *st );
void PushDouble( double val );
void PushLabel( int val );
void PushVar( PVal *pv, int aval );
void PushVAP( PVal *pval, int aval );
void PushDefault( void );
void PushFuncEnd( void );

void PushExtvar( int val, int pnum );
void PushIntfunc( int val, int pnum );
void PushSysvar( int val, int pnum );
void PushDllfunc( int val, int pnum );

void CalcAddI( void );
void CalcSubI( void );
void CalcMulI( void );
void CalcDivI( void );
void CalcModI( void );
void CalcAndI( void );
void CalcOrI( void );
void CalcXorI( void );
void CalcEqI( void );
void CalcNeI( void );
void CalcGtI( void );
void CalcLtI( void );
void CalcGtEqI( void );
void CalcLtEqI( void );
void CalcRrI( void );
void CalcLrI( void );

void VarSet( PVal *pv, int aval, int pnum );
void VarInc( PVal *pv, int aval );
void VarDec( PVal *pv, int aval );
void VarCalc( PVal *pv, int aval, int op );




#endif
