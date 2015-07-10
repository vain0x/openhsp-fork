
//
//	HSP3 External program manager (dummy)
//	onion software/onitama 2011/11
//
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../hsp3config.h"
#include "hsp3ext_ndk.h"

#include "../hgio.h"
#include "../sysreq.h"
#include "../../hsp3embed/hsp3embed.h"
#include "../../javafunc.h"

/*----------------------------------------------------------*/
//		DevInfo Call
/*----------------------------------------------------------*/
static HSP3DEVINFO *mem_devinfo;
static int devinfo_dummy;
static char *devres_none;

static int hsp3dish_devprm( char *name, char *value )
{
	return -1;
}

static int hsp3dish_devcontrol( char *cmd, int p1, int p2, int p3 )
{
	if ( strcmp( cmd, "vibrate" )==0 ) {
		j_callVibrator( p1 );
        //AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
		return 0;
	}
	if ( strcmp( cmd, "setflag" )==0 ) {
		j_addWindowFlag( p1 );
		return 0;
	}
	if ( strcmp( cmd, "clearflag" )==0 ) {
		j_clearWindowFlag( p1 );
		return 0;
	}
	if ( strcmp( cmd, "AdMob" )==0 ) {
		j_callAdMob( p1 );
		return 0;
	}
	return -1;
}

static int *hsp3dish_devinfoi( char *name, int *size )
{
	*size = -1;
	return NULL;
    //	return &devinfo_dummy;
}

static char *hsp3dish_devinfo( char *name )
{
	if ( strcmp( name, "name" )==0 ) {
		return mem_devinfo->devname;
	}
	if ( strcmp( name, "locale" )==0 ) {
		return j_getinfo( JAVAFUNC_INFO_LOCALE );
	}
	if ( strcmp( name, "error" )==0 ) {
		return mem_devinfo->error;
	}
	return NULL;
}

void hsp3dish_setdevinfo( void )
{
	//		Initalize DEVINFO
    HSP3DEVINFO *devinfo;
    devinfo = (HSP3DEVINFO *)hsp3eb_getDevInfo();
    mem_devinfo = devinfo;
	devinfo_dummy = 0;
    devres_none = (char *)&devinfo_dummy;
	devinfo->devname = (char *)"Androiddev";
	devinfo->error = (char *)"";
	devinfo->devprm = hsp3dish_devprm;
	devinfo->devcontrol = hsp3dish_devcontrol;
	devinfo->devinfo = hsp3dish_devinfo;
	devinfo->devinfoi = hsp3dish_devinfoi;
}

/*----------------------------------------------------------*/

void hsp3typeinit_dllcmd( HSP3TYPEINFO *info )
{
}

void hsp3typeinit_dllctrl( HSP3TYPEINFO *info )
{
}

