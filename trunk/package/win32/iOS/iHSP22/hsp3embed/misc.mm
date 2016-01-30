#include "misc.h"

void Alertf( const char* pszFormat, ...)
{
	va_list argp;
	char pszBuf[4096];
	va_start(argp, pszFormat);
	vsprintf(pszBuf, pszFormat, argp);
	va_end(argp);
	NSString *nsstr = [[NSString alloc] initWithUTF8String:pszBuf];
	NSLog(nsstr);
	[nsstr release];
}

void Alert( const char* msg )
{
    NSString *nsstr = [[NSString alloc] initWithUTF8String:msg];
    NSLog(nsstr);
    [nsstr release];
}

int sgn(int i)
{
	if(i > 0) {
		return 1;
	}
	if (i < 0) {
		return -1;
	}
	return 0;
}

/*void strScan(FILE* fp, char* str)
{
	char tmpstr[1024];

	while(1) {
		fscanf_s(fp, "%s", tmpstr);
		if(tmpstr[0] != '/' || tmpstr[1] != '/') {
			break;
		}
		while(getc(fp) != '\n') ;
	}

	strcpy_s(str, 1024, tmpstr);
}

float floatScan(FILE* fp)
{
	char tmpstr[1024];
	strScan(fp, tmpstr);
	return (float)atof(tmpstr);
}

int intScan(FILE* fp)
{
	char tmpstr[1024];
	strScan(fp, tmpstr);
	return atoi(tmpstr);
}
*/
