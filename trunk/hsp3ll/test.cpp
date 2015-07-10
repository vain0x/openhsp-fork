//
//	hsp3cnv generated source
//	[exgoto.ax]
//
#include "hsp3r.h"

#if 0
#define _HSP3CNV_DATE "2008/10/01"
#define _HSP3CNV_TIME "16:20:42"
#define _HSP3CNV_MAXVAR 1
#define _HSP3CNV_MAXHPI 0
#define _HSP3CNV_VERSION 0x301
#define _HSP3CNV_BOOTOPT 0

/*-----------------------------------------------------------*/

static PVal *Var__HspVar0;

/*-----------------------------------------------------------*/

void __HspInit( Hsp3r *hsp3 ) {
	hsp3->Reset( _HSP3CNV_MAXVAR, _HSP3CNV_MAXHPI );
}

/*-----------------------------------------------------------*/

void __HspEntry( void ) {
	// Var initalize
	Var__HspVar0 = &mem_var[0];

	// _HspVar0 =0
	PushInt(0); 
	VarSet(Var__HspVar0,0,1);
	TaskSwitch(0);
}

static void L0000( void ) {
	// exgoto
	PushLabel(1); 
	PushInt(5); 
	PushInt(1); 
	PushVAP(Var__HspVar0,0); 
	PushLabel(4); Prgcmd(24,5); return;
	TaskSwitch(4);
}

static void L0004( void ) {
	// _HspVar0 ++
	VarInc(Var__HspVar0,0);
	// mes "A="+_HspVar0
	PushStr("A="); PushVar(Var__HspVar0,0); CalcAddI(); 
	Extcmd(15,1);
	// goto *L0000
	PushLabel(0); 
	Prgcmd(0,1);
	return;
	TaskSwitch(1);
}

static void L0001( void ) {
	// mes "Done."
	PushStr("Done."); 
	Extcmd(15,1);
	TaskSwitch(2);
}

static void L0002( void ) {
	// stop 
	Prgcmd(17,0);
	return;
	// goto *L0002
	PushLabel(2); 
	Prgcmd(0,1);
	return;
	TaskSwitch(3);
}

static void L0003( void ) {
	// stop 
	Prgcmd(17,0);
	return;
	// goto *L0003
	PushLabel(3); 
	Prgcmd(0,1);
	return;
}

//-End of Source-------------------------------------------

CHSP3_TASK __HspTaskFunc[]={
(CHSP3_TASK) L0000,
(CHSP3_TASK) L0001,
(CHSP3_TASK) L0002,
(CHSP3_TASK) L0003,
(CHSP3_TASK) L0004,

};

/*-----------------------------------------------------------*/
#endif
