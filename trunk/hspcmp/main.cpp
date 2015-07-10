
//
//	HSPCC : HSP Code Compiler Manager
//				onion software 2002/12
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include "../hsp3/hsp3config.h"
#include "supio.h"

#include "hsc3.h"
#include "token.h"

/*----------------------------------------------------------*/

static void usage1( void )
{
static 	char *p[] = {
	"usage: hspcmp [options] [filename]",
	"       -o??? set output file to ???",
	"       -d    add debug information",
	"       -p    preprocessor only",
	"       -c    HSP2.55 compatible mode",
	"       --compath=??? set common path to ???",
	NULL };
	int i;
	for(i=0; p[i]; i++)
		printf( "%s\n", p[i]);
}

/*----------------------------------------------------------*/

int main( int argc, char *argv[] )
{
	char a1,a2;
	int b,st;
	int cmpopt,ppopt;
	char fname[HSP_MAX_PATH];
	char fname2[HSP_MAX_PATH];
	char oname[HSP_MAX_PATH];
	char compath[HSP_MAX_PATH];
	CHsc3 *hsc3=NULL;

	//	check switch and prm

	if (argc<2) { usage1();return -1; }

	st = 0; ppopt = 0; cmpopt = 0;
	fname[0]=0;
	fname2[0]=0;
	oname[0]=0;
	
#ifdef HSPLINUX
	strcpy( compath,"common/" );
#else
	strcpy( compath,"common\\" );
#endif

	for (b=1;b<argc;b++) {
		a1=*argv[b];a2=tolower(*(argv[b]+1));
#ifdef HSPLINUX
		if (a1!='-') {
#else
		if ((a1!='/')&&(a1!='-')) {
#endif
			strcpy(fname,argv[b]);
		} else {
			if (strncmp(argv[b], "--compath=", 10) == 0) {
				strcpy( compath, argv[b] + 10 );
				continue;
			}
			switch (a2) {
			case 'c':
				ppopt=1;break;
			case 'p':
				cmpopt=2;break;
			case 'd':
				cmpopt=1;break;
			case 'o':
				strcpy( oname,argv[b]+2 );
				break;
			default:
				st=1;break;
			}
		}
	}

	if (st) { printf("Illegal switch selected.\n");return 1; }
	if (fname[0]==0) { printf("No file name selected.\n");return 1; }


	if (oname[0]==0) {
		strcpy( oname,fname ); cutext( oname ); addext( oname,"ax" );
	}
	strcpy( fname2, fname ); cutext( fname2 ); addext( fname2,"i" );
	addext( fname,"hsp" );			// Šg’£Žq‚ª‚È‚¯‚ê‚Î’Ç‰Á‚·‚é

	//		call main

	hsc3 = new CHsc3;

	hsc3->SetCommonPath( compath );

	st = hsc3->PreProcess( fname, fname2, ppopt, fname );
	if (( cmpopt < 2 )&&( st == 0 )) {
		st = hsc3->Compile( fname2, oname, cmpopt );
	}
	puts( hsc3->GetError() );
	hsc3->PreProcessEnd();
	if ( hsc3 != NULL ) { delete hsc3; hsc3=NULL; }
	return st;
}

