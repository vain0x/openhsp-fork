
//
//		System request manager
//			onion software/onitama 2001/6
//
#include <stdio.h>
#include <stdarg.h>
#include "sysreq.h"

#include "hgio.h"
#include "supio.h"

static int	sysreq[SYSREQ_MAX];		// 初期設定データプール
static char dbgmsg[512];			// デバッグ用メッセージプール

void InitSysReq( void )
{
	int i;
	for(i=0;i<SYSREQ_MAX;i++) sysreq[i]=0;
	sysreq[ SYSREQ_MAXMODEL ] = 128;
	sysreq[ SYSREQ_MAXOBJ ] = 1024;
	sysreq[ SYSREQ_MAXTEX ] = 128;
	sysreq[ SYSREQ_MAXMOC ] = 4096;
	sysreq[ SYSREQ_PKTSIZE ] = 0x100000;
	sysreq[ SYSREQ_MAXEVENT ] = 256;
	sysreq[ SYSREQ_MDLANIM ] = 16;
	sysreq[ SYSREQ_MAXEMITTER ] = 16;
	sysreq[ SYSREQ_OBAQMATBUF ] = 1024;

	sysreq[ SYSREQ_2DFILTER ] = 1;			// D3DTEXF_POINT
	sysreq[ SYSREQ_2DFILTER2 ] = 1;			// D3DTEXF_POINT
	sysreq[ SYSREQ_3DFILTER ] = 2;			// D3DTEXF_LINEAR

#ifdef HSPIOS
    sysreq[ SYSREQ_PLATFORM ] = PLATFORM_IOS;
#endif    
#ifdef HSPNDK
    sysreq[ SYSREQ_PLATFORM ] = PLATFORM_ANDROID;
#endif    
    
	dbgmsg[0] = 0;
}


void SetSysReq( int reqid, int val )
{
	sysreq[ reqid ] = val;
}


int GetSysReq( int reqid )
{
	switch( reqid ) {
	case SYSREQ_TIMER:
		return hgio_gettick();
	default:
		break;
	}
	return sysreq[ reqid ];
}


void DebugMsg( char *format, ... )
{
	va_list args;
	va_start(args, format);
	vsprintf(dbgmsg, format, args);
	va_end(args);
}

char *GetDebug( void )
{
	return dbgmsg;
}

