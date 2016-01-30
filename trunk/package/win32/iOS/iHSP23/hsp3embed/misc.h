#ifndef MISC_H

#include <stdio.h>

//#define ENABLE_DEBUGMESSAGE

#ifdef ENABLE_DEBUGMESSAGE
#define DebugMessage(...) DebugMessage0(__VA_ARGS__);
#else
#define DebugMessage(...) ;
#endif

void Alertf( const char* pszFormat, ...);

int sgn(int i);

void strScan(FILE* fp, char* str);
float floatScan(FILE* fp);
int intScan(FILE* fp);

#endif
#define MISC_H
