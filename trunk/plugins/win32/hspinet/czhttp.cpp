
#include <windows.h>
#include <process.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
//#include <tchar.h>

#include "czhttp.h"

#pragma comment( lib,"Wininet.lib" )

void CzHttp::Terminate( void )
{
	//	Delete Session
	if ( pt != NULL ) {
		free( pt );	pt = NULL;
	}
	if ( hSession != NULL ) {
		InternetCloseHandle( hSession );
		hSession = NULL;
	}
	errstr[0] = 0;
	req_url[0] = 0;
	req_path[0] = 0;
	down_path[0] = 0;

	//	Clear headers
	if ( req_header != NULL ) { free( req_header ); req_header = NULL; }

	ClearVarData();
}


void CzHttp::Reset( void )
{
	// Initalize
	//
	char *agent;
	Terminate();

	agent = str_agent;
	if ( agent == NULL ) agent = "HSPInet(HSP3.1; Windows)";

	if ( proxy_url[0] != 0 ) {
		char *local_prm = NULL;
		if ( proxy_local ) local_prm = "<local>";
		hSession = InternetOpen( agent, INTERNET_OPEN_TYPE_PROXY, proxy_url, local_prm, 0 );
	} else {
		hSession = InternetOpen( agent, INTERNET_OPEN_TYPE_DIRECT, NULL, NULL, 0 );
	}
	if ( hSession == NULL ) {
		mode = CZHTTP_MODE_NONE;
		SetError( "初期化に失敗しました" ); return;
	}

	strcpy( username, "anonymous" );
	strcpy( userpass, "aaa@aaa.com" );
	ftp_port = INTERNET_DEFAULT_FTP_PORT;
	ftp_flag = 0;

	// Reset Value
	mode = CZHTTP_MODE_READY;
}


CzHttp::CzHttp( void )
{
	//	コンストラクタ
	//
	str_agent = NULL;
	pt = NULL;
	mode = CZHTTP_MODE_NONE;
	hSession = NULL;
	proxy_local = 0;
	proxy_url[0] = 0;
	req_header = NULL;
	vardata = NULL;

	//	接続可能か?
	if( InternetAttemptConnect(0) ){
		SetError( "ネット接続が確認できませんでした" ); return;
	}

	//	初期化を行う
	Reset();
}


CzHttp::~CzHttp( void )
{
	//	デストラクタ
	//
	Terminate();
	if ( str_agent != NULL ) { free( str_agent ); str_agent = NULL; }
}


//--------------------------------------------------------------//
//				External functions
//--------------------------------------------------------------//

int CzHttp::Exec( void )
{
	//	毎フレーム実行
	//
	static char hdr[] = "Content-Type: application/x-www-form-urlencoded\r\n";
	char req_name[1024];
	char *name;
	BOOL res;

	switch( mode ) {
	case CZHTTP_MODE_REQUEST:			// httpに接続
		strcpy( req_name, req_url );
		strcat( req_name, req_path );
		hService = InternetOpenUrl( hSession, req_name, req_header, -1L, 0, INTERNET_FLAG_RELOAD );
		if ( hService == NULL ) {
			SetError( "無効なURLが指定されました" );
			break;
		}
		mode = CZHTTP_MODE_REQSEND;
	case CZHTTP_MODE_REQSEND:
		name = down_path;
		if ( name[0] == 0 ) name = req_path;
		fp = fopen( name, "wb");
		if ( fp == NULL ) {
			SetError( "ダウンロードファイルが作成できません" );
			break;
		}
		size = 0;
		mode = CZHTTP_MODE_DATAWAIT;
	case CZHTTP_MODE_DATAWAIT:
		{
		DWORD dwBytesRead = INETBUF_MAX;
		if ( InternetReadFile( hService, buf, INETBUF_MAX, &dwBytesRead ) == 0 ) {
			fclose( fp );
			InternetCloseHandle( hService );
			SetError( "ダウンロード中にエラーが発生しました" );
			break;
		}
		if( dwBytesRead == 0 ) {
			mode = CZHTTP_MODE_DATAEND;
			break;
		}
		fwrite( buf, dwBytesRead, 1, fp );
		size += dwBytesRead;
		break;
		}
	case CZHTTP_MODE_DATAEND:
		fclose( fp );
		InternetCloseHandle( hService );
		mode = CZHTTP_MODE_READY;
		break;



	case CZHTTP_MODE_VARREQUEST:

		strcpy( req_name, req_url2 );
		strcat( req_name, req_path );

		// HTTPに接続
		hHttpSession = ::InternetConnectA( hSession, varserver, varport, NULL, NULL, INTERNET_SERVICE_HTTP, 0, 0 );
		if ( hHttpSession == NULL ) {
			SetError( "無効なサーバーが指定されました" );
			break;
		}

		// HTTP要求の作成
		hHttpRequest = ::HttpOpenRequestA( hHttpSession, varstr, req_name, HTTP_VERSION, NULL, NULL, INTERNET_FLAG_RELOAD|INTERNET_FLAG_NO_UI, 0 );
		if ( hHttpSession == NULL ) {
			SetError( "無効なURLが指定されました" );
			break;
		}
		mode = CZHTTP_MODE_VARREQSEND;
		// FALL THROUGH
	case CZHTTP_MODE_VARREQSEND:

		// 作成したHTTP要求の発行
		if ( postdata != NULL ) {
			char *additional_header = req_header != NULL ? req_header : "";
			char *header = (char *)malloc( strlen(hdr) + strlen(additional_header) + 1 );
			strcpy(header, hdr);
			strcat(header, additional_header);
			res = ::HttpSendRequestA( hHttpRequest, header, -1L, postdata, (int)strlen(postdata) );
			free(header);
		} else {
			res = ::HttpSendRequestA( hHttpRequest, req_header, -1L, NULL, 0 );
		}
		if ( res == false ) {
			InternetCloseHandle( hHttpSession );
			SetError( "リクエストができませんでした" );
			break;
		}
/*
		{
		// 返されたコンテンツの長さを取得
		DWORD dwSize = INETBUF_MAX;
		*buf = 0;
		res = HttpQueryInfo( hHttpRequest, HTTP_QUERY_CONTENT_LENGTH, buf, &dwSize, 0 );
		if ( res == false ) {
			InternetCloseHandle( hHttpRequest );
			InternetCloseHandle( hHttpSession );
			SetError( "データサイズ取得ができませんでした" );
			break;
		}
		varsize = atoi(buf);
		if ( varsize == 0 ) {
			InternetCloseHandle( hHttpRequest );
			InternetCloseHandle( hHttpSession );
			SetError( "ダウンロードできませんでした" );
			break;
		}
		}
*/
		varsize = 0x40000;
		ClearVarData();
		vardata = (char *)malloc( varsize );
		size = 0;
		mode = CZHTTP_MODE_VARDATAWAIT;
		// FALL THROUGH
	case CZHTTP_MODE_VARDATAWAIT:
		{
		DWORD dwBytesRead;
		int needed_size = size + INETBUF_MAX + 1;
		if ( needed_size > varsize ) {
			while ( needed_size > varsize ) {
				varsize *= 2;
			}
			vardata = (char *)realloc( vardata, varsize );
		}
		if ( InternetReadFile( hHttpRequest, vardata+size, INETBUF_MAX, &dwBytesRead ) == 0 ) {
			InternetCloseHandle( hHttpRequest );
			InternetCloseHandle( hHttpSession );
			SetError( "ダウンロード中にエラーが発生しました" );
			break;
		}
		size += dwBytesRead;
		if( dwBytesRead == 0 ) {
			mode = CZHTTP_MODE_VARDATAEND;
			vardata[size] = 0;
			break;
		}
		break;
		}
	case CZHTTP_MODE_VARDATAEND:
		InternetCloseHandle( hHttpRequest );
		InternetCloseHandle( hHttpSession );
		mode = CZHTTP_MODE_READY;
		break;



	case CZHTTP_MODE_INFOREQ:
		strcpy( req_name, req_url );
		strcat( req_name, req_path );
		hService = InternetOpenUrl( hSession, req_name, req_header, -1L, 0, 0 );
		if ( hService == NULL ) {
			SetError( "無効なURLが指定されました" );
			break;
		}
		mode = CZHTTP_MODE_INFORECV;
	case CZHTTP_MODE_INFORECV:
		{
		DWORD dwSize = INETBUF_MAX;
		buf[0] = 0;
		HttpQueryInfo( hService, HTTP_QUERY_RAW_HEADERS_CRLF, buf, &dwSize, 0 );
		InternetCloseHandle( hService );
		mode = CZHTTP_MODE_READY;
		break;
		}

	case CZHTTP_MODE_FTPREADY:
		return 2;

	case CZHTTP_MODE_FTPDIR:
		{
		char tx[512];
		char dname[64];
		char *fname;
		SYSTEMTIME t;

		fname = finddata.cFileName;
		if( finddata.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) {
			strcpy( dname, "<DIR>" );
        }
        else{
			sprintf( dname, "%d", finddata.nFileSizeLow );
        }
		FileTimeToSystemTime( &finddata.ftLastWriteTime,&t );
		sprintf( tx, "\"%s\",%s,%4d/%02d/%02d,%02d:%02d:%02d\r\n", fname, dname, t.wYear, t.wMonth, t.wDay, t.wHour, t.wMinute, t.wSecond );
		AddFlexBuf( tx, (int)strlen(tx) );
		if ( !InternetFindNextFile( hFtpEnum, &finddata ) ) {
			InternetCloseHandle( hFtpEnum );
			mode = CZHTTP_MODE_FTPREADY;
		}
		break;
		}

	case CZHTTP_MODE_FTPREAD:
		break;
	case CZHTTP_MODE_FTPWRITE:
		break;
	case CZHTTP_MODE_FTPCMD:
		{
		char tx[1024];
	    DWORD dwBytesRead;
		if( InternetReadFile( hResponse, buf, 1024, &dwBytesRead ) ){
			AddFlexBuf( tx, dwBytesRead );
		}
		if ( dwBytesRead == 0 ) {
			InternetCloseHandle( hResponse );
			mode = CZHTTP_MODE_FTPREADY;
		}
		break;
		}
	case CZHTTP_MODE_FTPRESULT:
		GetFtpResponse();
		break;

	case CZHTTP_MODE_ERROR:
		return -1;
	default:
		return 1;
	}
	return 0;
}


void CzHttp::ClearVarData( void )
{
	if ( vardata == NULL ) return;
	free( vardata );
	vardata = NULL;
}


char *CzHttp::GetError( void )
{
	// エラー文字列のポインタを取得
	//
	return errstr;
}


int CzHttp::RequestFile( char *path )
{
	// サーバーにファイルを要求
	//
	if ( mode != CZHTTP_MODE_READY ) {
		return -1;
	}
	strcpy( req_path, path );
	mode = CZHTTP_MODE_REQUEST;
	return 0;
}


char *CzHttp::RequestFileInfo( char *path )
{
	// サーバーにファイル情報を要求
	//
	char req_name[1024];
	DWORD dwSize = INETBUF_MAX;

	if ( mode != CZHTTP_MODE_READY ) {
		return NULL;
	}
	strcpy( req_name, req_url );
	strcat( req_name, path );

	hService = InternetOpenUrl( hSession, req_name, req_header, -1L, 0, 0 );
	if ( hService == NULL ) return NULL;

	buf[0] = 0;
	HttpQueryInfo( hService, HTTP_QUERY_RAW_HEADERS_CRLF, buf, &dwSize, 0 );
	InternetCloseHandle( hService );
	return buf;
}


void CzHttp::SetURL( char *url )
{
	// サーバーのURLを設定
	//
	strncpy( req_url, url, 1024 );
}


void CzHttp::SetLocalName( char *name )
{
	// サーバーのURLを設定
	//
	strncpy( down_path, name, 512 );
}


int CzHttp::GetSize( void )
{
	// 取得ファイルのサイズを返す
	//
	if ( mode != CZHTTP_MODE_READY ) return 0;
	return size;
}


char *CzHttp::GetData( void )
{
	// 取得ファイルデータへのポインタを返す
	//
	if ( mode != CZHTTP_MODE_READY ) return NULL;
	return pt;
}


void CzHttp::SetProxy( char *url, int port, int local )
{
	// PROXYサーバーの設定
	//	(URLにNULLを指定するとPROXY無効となる)
	//
	if ( url == NULL ) {
		proxy_url[0] = 0;
	} else {
		sprintf( proxy_url, "%s:%d", url, port );
		proxy_local = local;
	}
	Reset();
}


void CzHttp::SetAgent( char *agent )
{
	// エージェントの設定
	//	(URLにNULLを指定するとデフォルトになる)
	//
	if ( str_agent != NULL ) { free( str_agent ); str_agent = NULL; }
	if ( agent == NULL ) str_agent = agent; else {
		str_agent = (char *)malloc( strlen( agent ) + 1 );
		strcpy( str_agent, agent );
	}
	Reset();
}


void CzHttp::SetHeader( char *header )
{
	// ヘッダ文字列の設定
	//
	if ( req_header != NULL ) { free( req_header ); req_header = NULL; }
	if ( header == NULL ) return;
	//
	req_header = (char *)malloc( strlen( header ) + 1 );
	strcpy( req_header, header );
}


void CzHttp::SetUserName( char *name )
{
	// ユーザー名の設定
	//
	strncpy( username, name, 255 );
}


void CzHttp::SetUserPassword( char *pass )
{
	// パスワードの設定
	//
	strncpy( userpass, pass, 255 );
}


void CzHttp::SetFtpPort( int port )
{
	// ポートの設定
	//
	ftp_port = port;
}


void CzHttp::SetFtpFlag( int flag )
{
	// パッシブモードの設定
	//
	if ( flag ) {
		ftp_flag = INTERNET_FLAG_PASSIVE;
	} else {
		ftp_flag = 0;
	}
}


void CzHttp::ResetFlexBuf( int defsize )
{
	if ( pt != NULL ) {	free( pt );	}
	pt = (char *)malloc( defsize );
	pt_size = defsize;
	pt_cur = 0;
}


void CzHttp::AllocFlexBuf( int size )
{
	char *p;
	if ( pt_size >= size ) return;
	p = (char *)malloc( size );
	memcpy( p, pt, pt_size );
	free( pt );
	pt_size = size;
	pt = p;
}


void CzHttp::AddFlexBuf( char *data, int size )
{
	int i;
	int req_size;
	i = pt_cur + size + 1;
	if ( i > pt_size ) {
		req_size = ( i + 0x0fff ) & 0x7ffff000;
		AllocFlexBuf( req_size );
	}
	memcpy( pt + pt_cur, data, size );
	pt_cur += size;
	pt[ pt_cur ] = 0;									// Terminate
}



void CzHttp::SetVarServerFromURL( void )
{
	char *p;
	char *wr;
	char a1;
	p = req_url;
	wr = varserver;
	*wr = 0;
	varport = INTERNET_DEFAULT_HTTP_PORT;

	while(1)				// '//'を探す
	{
		a1 = *p++;
		if ( a1 == 0 ) return;
		if ( a1 == '/' ) {
			if ( *p == '/' ) { p++; break; }
		}
	}
	while(1) {				// '/'までを取り出す
		a1 = *p;
		if ( a1 == 0 ) break;
		p++;
		if ( a1 == '/' ) break;
		if ( a1 == ':' ) {
			//	ポート番号を取り出す
			int i = 0;
			while(isdigit(p[i])) {
				i ++;
			}
			if (p[i] == '/' || p[i] == 0) {
				if (i != 0) varport = atoi(p);
				p += i;
				if (*p == '/') p ++;
				break;
			}
		}
		*wr++ = a1;
	}
	*wr = 0;

	wr = req_url2;
	*wr++ = '/';

	while(1) {				// 最後まで取り出す
		a1 = *p++;
		if ( a1 == 0 ) break;
		*wr++ = a1;
	}
	*wr = 0;

}


void CzHttp::SetVarRequestGet( char *path )
{
	// サーバーにファイルを要求(GET)
	//
	if ( mode != CZHTTP_MODE_READY ) {
		return;
	}
	SetVarServerFromURL();
	strcpy( varstr, "GET" );
	strcpy( req_path, path );
	postdata = NULL;
	mode = CZHTTP_MODE_VARREQUEST;
}


void CzHttp::SetVarRequestPost( char *path, char *post )
{
	// サーバーにファイルを要求(POST)
	//
	if ( mode != CZHTTP_MODE_READY ) {
		return;
	}
	SetVarServerFromURL();
	strcpy( varstr, "POST" );
	strcpy( req_path, path );
	postdata = post;
	mode = CZHTTP_MODE_VARREQUEST;
}


//--------------------------------------------------------------//
//				FTP functions
//--------------------------------------------------------------//

int CzHttp::FtpConnect( void )
{
	// FTP接続
	//
	*buf = 0;
	if ( mode != CZHTTP_MODE_READY ) {
		return -1;
	}

	hService = InternetConnect( hSession,
                                req_url,
                                ftp_port,
                                username,
                                userpass,
                                INTERNET_SERVICE_FTP,
                                ftp_flag,
                                0 );


	GetFtpResponse();
	if ( mode != CZHTTP_MODE_FTPREADY ) return -1;
	return 0;
}


void CzHttp::FtpDisconnect( void )
{
	// FTP切断
	//
	if ( mode != CZHTTP_MODE_FTPREADY ) {
		return;
	}
	InternetCloseHandle( hService );
	mode = CZHTTP_MODE_READY;
}


char *CzHttp::GetFtpResponse( void )
{
	// FTPレスポンスへのポインタを返す
	//
	DWORD dwSize = INETBUF_MAX;
	DWORD dwError;
	if ( InternetGetLastResponseInfo( &dwError, buf, &dwSize ) ) {
		mode = CZHTTP_MODE_FTPREADY;
	} else {
		InternetCloseHandle( hService );
		mode = CZHTTP_MODE_ERROR;
	}
	return buf;
}


char *CzHttp::GetFtpCurrentDir( void )
{
	// FTPカレントディレクトリを取得
	//
	DWORD dwSize = INETBUF_MAX;

	if ( mode != CZHTTP_MODE_FTPREADY ) {
		*buf = 0;
		return buf;
	}
	FtpGetCurrentDirectory( hService, buf, &dwSize );
	return buf;
}


void CzHttp::SetFtpDir( char *name )
{
	// FTPカレントディレクトリを変更
	//
	if ( mode != CZHTTP_MODE_FTPREADY ) {
		return;
	}
	FtpSetCurrentDirectory( hService, name );
	GetFtpResponse();
}


void CzHttp::GetFtpDirList( void )
{
	// FTPカレントディレクトリ内容を取得
	//
	if ( mode != CZHTTP_MODE_FTPREADY ) {
		return;
	}
	ResetFlexBuf( 1024 );
    hFtpEnum = FtpFindFirstFile( hService, NULL, &finddata, INTERNET_FLAG_RELOAD | INTERNET_FLAG_DONT_CACHE, 0 );
	if ( hFtpEnum != NULL ) mode = CZHTTP_MODE_FTPDIR;
}


char *CzHttp::GetTempBuffer( void )
{
	// 内部バッファへのポインタを返す
	//
	return buf;
}


int CzHttp::GetFtpFile( char *name, char *downname, int tmode )
{
	// FTPファイルを取得
	//
	int i;
	DWORD type;
	if ( mode != CZHTTP_MODE_FTPREADY ) {
		return -1;
	}
	type = FTP_TRANSFER_TYPE_BINARY;
	if ( tmode ) type = FTP_TRANSFER_TYPE_ASCII;
	i = FtpGetFile( hService, name, downname, FALSE, FILE_ATTRIBUTE_ARCHIVE, type, 0 );
	if ( i == 0 ) return -1;
	GetFtpResponse();
	return 0;
}


int CzHttp::PutFtpFile( char *name, char *downname, int tmode )
{
	// FTPファイルを送信
	//
	int i;
	DWORD type;
	if ( mode != CZHTTP_MODE_FTPREADY ) {
		return -1;
	}
	type = FTP_TRANSFER_TYPE_BINARY;
	if ( tmode ) type = FTP_TRANSFER_TYPE_ASCII;
	i = FtpPutFile( hService, downname, name, type, 0 );
	if ( i == 0 ) return -1;
	GetFtpResponse();
	return 0;
}


int CzHttp::RenameFtpFile( char *name, char *newname )
{
	// FTPファイルをリネーム
	//
	int i;
	if ( mode != CZHTTP_MODE_FTPREADY ) {
		return -1;
	}
	if ( newname == NULL ) {
		i = FtpDeleteFile( hService, name );
	} else {
		i = FtpRenameFile( hService, name, newname );
	}
	if ( i == 0 ) return -1;
	GetFtpResponse();
	return 0;
}


int CzHttp::MakeFtpDir( char *name )
{
	// FTPディレクトリ作成
	//
	int i;
	if ( mode != CZHTTP_MODE_FTPREADY ) {
		return -1;
	}
	i = FtpCreateDirectory( hService, name );
	if ( i == 0 ) return -1;
	GetFtpResponse();
	return 0;
}


int CzHttp::KillFtpDir( char *name )
{
	// FTPディレクトリ削除
	//
	int i;
	if ( mode != CZHTTP_MODE_FTPREADY ) {
		return -1;
	}
	i = FtpRemoveDirectory( hService, name );
	if ( i == 0 ) return -1;
	GetFtpResponse();
	return 0;
}


int CzHttp::FtpSendCommand( char *cmd )
{
	// FTPコマンド送信
	//
	int i;
	if ( mode != CZHTTP_MODE_FTPREADY ) {
		return -1;
	}
	ResetFlexBuf( 1024 );
	i = FtpCommand( hService, TRUE, FTP_TRANSFER_TYPE_ASCII, cmd, 0, &hResponse );
	if ( i ) {
		mode = CZHTTP_MODE_FTPCMD;
		return 0;
	}
	return -1;
}


//--------------------------------------------------------------//
//				Utility functions
//--------------------------------------------------------------//

int CzHttp::UrlEncode( char *dst, int dstsize, char *src )
{
	//	URLエンコード
	//
	int len;
	unsigned char *p;
	unsigned char *wrt;
	int a1;
	p = (unsigned char *)src;
	wrt = (unsigned char *)dst;
	len =0;
	while(1) {
		if ( len >= (dstsize-1) ) break;
		a1 = *p++;
		if ( a1 == 0 ) break;
		if(isalnum(a1) || a1 == ',' ||a1 == '-' || a1 == '_') {
			wrt[len++] = a1;
		} else if (a1 == ' ') {
			wrt[len++] = '+';
		} else {
			wrt[len++] = '%';
			sprintf( (char *)&wrt[len], "%02X",a1 );
			len+=2;
		}
	}
	wrt[len] = 0;
	return len;
}


int CzHttp::UrlDecode( char *dst, int dstsize, char *src )
{
	//	URLデコード
	//
	int len,val1,val2;
	unsigned char *p;
	unsigned char *wrt;
	int a1,a2;
	p = (unsigned char *)src;
	wrt = (unsigned char *)dst;
	len =0;
	while(1) {
		if ( len >= (dstsize-1) ) break;
		a1 = *p++;
		if ( a1 == 0 ) break;
		if( a1 == '%' ) {
			a1 = *p++;
			a2 = *p++;
			val1 = CheckHexCode( a1 );
			val2 = CheckHexCode( a2 );
			if (( val1 >= 0 )&&( val2 >= 0 )) {
				wrt[len++] = (val1<<4)+val2;
			} else {
				wrt[len++] = '%';
				wrt[len++] = a1;
				wrt[len++] = a2;
			}
		} else if (a1 == '+') {
			wrt[len++] = ' ';
		} else {
			wrt[len++] = a1;
		}
	}
	wrt[len] = 0;
	return len;
}


//--------------------------------------------------------------//
//				Internal functions
//--------------------------------------------------------------//

int CzHttp::CheckHexCode( int code )
{
	if (( code >= '0' )&&( code <='9' )) {
		return (code-'0');
	}
	if (( code >= 'a' )&&( code <='f' )) {
		return (code-'a'+10);
	}
	if (( code >= 'A' )&&( code <='F' )) {
		return (code-'A'+10);
	}
	return -1;
}


void CzHttp::SetError( char *mes )
{
	//	エラー文字列を設定
	//
	mode = CZHTTP_MODE_ERROR;
	strcpy( errstr,mes );
}


