
//
//	iOSBridge.cpp structures
//
#ifndef __iosbridge_h
#define __iosbridge_h

void gb_init( void );
void gb_reset( int sx, int sy );
void gb_sethspview( void *view );

int gb_render_start( void );
int gb_render_end( void );

void gb_colorset( struct BMSCR *bm );
void gb_font( int size, int style, char *msg );
int gb_mes( struct BMSCR *bm, char *msg );

void gb_dbgtest( void );
void gb_mouse( int xx, int yy, int button );
int gb_getmousex( void );
int gb_getmousey( void );
int gb_getmousebtn( void );

char *gb_filepath( char *base );
int gb_existdata(char* key);
int gb_loaddata(char* key, char* data, int size, int offset);
void gb_savedata(char* key, char* data, int size, int offset);

int gb_dialog( int type, char *msg, char *msg2 );
int gb_exec( int type, char *name );

void gb_getSysModel( char *outbuf );
void gb_getSysVer( char *outbuf );

#endif
