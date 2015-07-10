/*------------------------------------------------------------*/
/*
		Sort Routines (from hspda)
*/
/*------------------------------------------------------------*/

#include <stdio.h>
#include <string.h>
#include <windows.h>
#include "supio.h"

typedef struct {
    int key;
    int info;
} SORTDATA;

static	SORTDATA *dtmp = NULL;

static void swap(SORTDATA *a, SORTDATA *b)
{
    SORTDATA t;

    t.key   = a->key;
    t.info  = a->info;
    a->key  = b->key;
    a->info = b->info;
    b->key  = t.key;
    b->info = t.info;
}


static void BubbleSortStr( SORTDATA *data, int nmem, int asdes )
{
	int i, j;
	for (i = 0; i < nmem - 1; i++) {
	  for (j = nmem - 1; j >= i + 1; j--) {
	    if (asdes == 0) {
		  if ( lstrcmp( (char *)data[j].key, (char *)data[j-1].key)<=0 )
				swap(&data[j], &data[j-1]);
		}
		else {
		  if ( lstrcmp( (char *)data[j].key, (char *)data[j-1].key)>=0 )
				swap(&data[j], &data[j-1]);
		}
	  }
	}
}


static int NoteToData( char *adr, SORTDATA *data )
{
	int line;
	char *p;
	char a1;
	p=adr;
	line=0;
	data[line].key=(int)p;
	data[line].info=line;

	while(1) {
		a1=*p;
		if (a1==0) break;
		if ((a1==13)||(a1==10)) {
			*p++=0;					// Remove CR/LF
			if (*p==10) p++;
			line++;
			data[line].key=(int)p;
			data[line].info=line;
		}
		else p++;
	}
	line++;
	return line;
}


static int GetNoteLines( char *adr )
{
	int line;
	char *p;
	char a1;
	p=adr;
	line=0;

	while(1) {
		a1=*p++;
		if (a1==0) break;
		if (a1==10) line++;
		if (a1==13) {
			if (*p==10) p++;
			line++;
		}
	}
	line++;
	return line;
}


static void DataToNote( SORTDATA *data, char *adr, int num )
{
	int a;
	int len;
	char *p;
	char *s;
	p=adr;
	for(a=0;a<num;a++) {
		s=(char *)data[a].key;
		len=lstrlen( s );
		if ( len>0 ) {
			lstrcpy( p, s );
			p+=len;
			*p++=13; *p++=10;			// Add CR/LF
		}
	}
	*p=0;
}


static void DataBye( void )
{
	if (dtmp!=NULL) {
		free(dtmp);
		dtmp = NULL;
	}
}


static void DataIni( int size )
{
	DataBye();
	dtmp=(SORTDATA *)malloc( sizeof(SORTDATA)*size );
}


void SortNote( char *str )
{
	int i,len;
	char *p;
	char *stmp;

	p = str;
	len = (int)strlen(str)+4;

	i=GetNoteLines(p);
	if (i<=0) return;

	DataIni( i );
	stmp=(char *)malloc( len );

	i = NoteToData( p, dtmp );
	BubbleSortStr( dtmp, i, 1 );
	DataToNote( dtmp, stmp, i );
	lstrcpy( p,stmp );

	free(stmp);
	DataBye();
	return;
}


