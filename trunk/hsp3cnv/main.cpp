
//
//	HSP3CNV : HSP Code Converter Manager
//				   onion software 2008/4
//

#include <stdio.h>
#include <windows.h>
#include <direct.h>
#include "chsp3.h"
#include "chsp3rev.h"
#include "chsp3cpp.h"

//#define HSP3CNV_DEBUG			// デバッグモード用

/*----------------------------------------------------------*/

int GetFilePath( char *bname )
{
	//		フルパス名から、ファイルパスの取得(\を残す)
	//
	int a,b,len;
	char a1;
	b=-1;
	len=(int)strlen(bname);
	for(a=0;a<len;a++) {
		a1=bname[a];
		if (a1=='\\') b=a;
		if (a1<0) a++; 
	}
	if (b<0) return 1;
	bname[b+1]=0;
	return 0;
}

/*----------------------------------------------------------*/

void usage1( void )
{
static 	char *p[] = {
	"usage: hsp3cnv [options] [filename]",
	"       -o??? set output file to ???",
	NULL };
	int i;
	for(i=0; p[i]; i++)
		printf( "%s\n", p[i]);
	return;
}

/*----------------------------------------------------------*/

int main( int argc, char *argv[] )
{
	int st;
	int cmpopt,ppopt;
	char fname[_MAX_PATH];
	char fname2[_MAX_PATH];
	char oname[_MAX_PATH];

	//	check switch and prm

	st = 0; ppopt = 0; cmpopt = 0;
	fname[0]=0;
	fname2[0]=0;
	oname[0]=0;

#ifndef HSP3CNV_DEBUG

	if (argc<2) { usage1();return -1; }

	int b;
	char a1,a2;
	for (b=1;b<argc;b++) {
		a1=*argv[b];a2=tolower(*(argv[b]+1));
		if ((a1!='/')&&(a1!='-')) {
			strcpy(fname,argv[b]);
		} else {
			switch (a2) {
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
#else
	strcpy( fname,"test" );
#endif

	if (oname[0]==0) {
		strcpy( oname,fname );addext( oname,"cpp" );
	}
	strcpy( fname2, fname ); addext( fname2,"hsp" );
	addext( fname,"ax" );

	//		call main
	{
		int i;
		CHsp3Cpp hsp3;
		i = hsp3.LoadObjectFile( fname );
		if (i) {
			printf( "File open error.[%s](%d)\n", fname, i );
			return 1;
		}
		hsp3.MakeSource( 0, NULL );

#ifndef HSP3CNV_DEBUG
		hsp3.SaveOutBuf( oname );
#else
		hsp3.SaveOutBuf( "test.cpp" );
		puts( hsp3.GetOutBuf() );
#endif

	}

	return st;
}

