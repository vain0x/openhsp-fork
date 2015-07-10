
//
//	hsp3gr.cpp header
//
#ifndef __hsp3gr_wingui_h
#define __hsp3gr_wingui_h

#include "../hsp3struct.h"

void hsp3typeinit_extcmd( HSP3TYPEINFO *info, int sx, int sy, int wd, int xx, int yy );
void hsp3typeinit_extfunc( HSP3TYPEINFO *info );
void hsp3gui_mref( PVal *pval, int prm );
void hsp3gr_nextobj( void );

void hsp3gr_dbg_gui( void );

#endif
