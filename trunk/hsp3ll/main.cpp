
//
//	HSP3CNV : HSP Code Converter Manager
//				   onion software 2008/4
//

#include <stdio.h>
#include <windows.h>
#include <direct.h>

#include "chsp3.h"
#include "chsp3rev.h"
#include "chsp3llvm.h"
#include "../hsp3/win32gui/hsp3win.h"


//#define HSP3CNV_DEBUG			// デバッグモード用
extern void DumpResult();

CHsp3Op* hsp3;
bool printDebugDump = false;
int llSkipTypeCheckLimit = -1;
bool llProfile = false;
bool llNoOpt = false;
bool llNoRangeCheck = false;

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
static char *p[] = {
	"usage: hsp3cnv [options] [filename]",
	"       -o??? set output file to ???",
	NULL };
	int i;
	for(i=0; p[i]; i++)
		printf( "%s\n", p[i]);
	return;
}


static int initHsp( char *fname )
{
	int st = 0;

	if (fname[0]==0) {
		printf("No file name selected.\n");
		return 1;
	}

	hsp3 = new CHsp3Op();
	int i = hsp3->LoadObjectFile( fname );
	if (i) {
		char buffer[1024];
		sprintf(buffer,  "File open error.[%s](%d)\n", fname, i );
		MessageBox(NULL , buffer, TEXT("hsp") , MB_ICONINFORMATION);
		return 1;
	}
	hsp3->MakeSource( 0, NULL );
	MakeSource( hsp3, 0, NULL );
/*
#ifndef HSP3CNV_DEBUG
		hsp3->SaveOutBuf( oname2 );
#else
		hsp3->SaveOutBuf( "test.cpp" );
		puts( hsp3->GetOutBuf() );
#endif
*/
	return st;
}


/*----------------------------------------------------------*/

int APIENTRY WinMain ( HINSTANCE hInstance,
					   HINSTANCE hPrevInstance,
					   LPSTR lpCmdParam,
					   int iCmdShow )
{
	char *p = nullptr;
	if ( __argc <= 1 ) {
		return 1;
	} else {
		for (int i = 0; i < __argc; ++i) {
			if (strcmp("--debug-dump", __argv[i]) == 0) {
				printDebugDump = true;
			} else if (strcmp("--profile", __argv[i]) == 0) {
				llProfile = true;
			} else if (strcmp("--no-opt", __argv[i]) == 0) {
				llNoOpt = true;
			} else if (strcmp("--no-range-check", __argv[i]) == 0) {
				llNoRangeCheck = true;
			} else if (strcmp("--skip-type-check", __argv[i]) == 0) {
				i++;
				llSkipTypeCheckLimit = atoi(__argv[i]);
				if (llSkipTypeCheckLimit <= 0) {
					printf("--skip-type-check n (n > 0)\n");;
					return 1;
				}
			} else {
				p = __argv[i];
			}
		}
	}

	initHsp(p);

	int res;
//#ifdef HSPDEBUG
	res = hsp3win_init( hInstance, p );
//#else
//	res = hsp3win_init( hInstance, NULL );
//#endif
	if ( res == 0 ) {
		res = hsp3win_exec();
	}

	if (printDebugDump)
		DumpResult();

	return res;
}
