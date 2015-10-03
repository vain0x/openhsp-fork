
//
//		HSP3.0 plugin sample
//		onion software/onitama 2005/5
//

#define WIN32_LEAN_AND_MEAN		// Exclude rarely-used stuff from Windows headers
#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include "../hpi3sample/hsp3plugin.h"

#include "czhttp.h"
#include "czcrypt.h"

/*----------------------------------------------------------------*/

static CzHttp *http;

/*------------------------------------------------------------*/
/*
		interface
*/
/*------------------------------------------------------------*/

int WINAPI DllMain (HINSTANCE hInstance, DWORD fdwReason, PVOID pvReserved)
{
	if ( fdwReason==DLL_PROCESS_ATTACH ) {
		http = NULL;
	}
	if ( fdwReason==DLL_PROCESS_DETACH ) {
		if ( http != NULL ) { delete http; http = NULL; }
	}
	return TRUE ;
}

 /*------------------------------------------------------------*/
/*
		controller
*/
/*------------------------------------------------------------*/

EXPORT BOOL WINAPI netinit( int p1, int p2, int p3, int p4 )
{
	//	(type$00)
	http = new CzHttp;
	if ( http->GetMode() != CZHTTP_MODE_READY ) {
		delete http; http = NULL;
		return -1;
	}
	return 0;
}


EXPORT BOOL WINAPI netterm( int p1, int p2, int p3, int p4 )
{
	//	(type$00)
	if ( http != NULL ) { delete http; http = NULL; }
	return 0;
}


EXPORT BOOL WINAPI netexec( int *p1, int p2, int p3, int p4 )
{
	//	(type$01)
	*p1 = -1;
	if ( http == NULL ) return -1;
	*p1 = http->Exec();
	return 0;
}


EXPORT BOOL WINAPI netmode( int *p1, int p2, int p3, int p4 )
{
	//	(type$01)
	*p1 = -1;
	if ( http == NULL ) return -1;
	*p1 = http->GetMode();
	return 0;
}


EXPORT BOOL WINAPI netsize( int *p1, int p2, int p3, int p4 )
{
	//	(type$01)
	*p1 = -1;
	if ( http == NULL ) return -1;
	*p1 = http->GetSize();
	return 0;
}


EXPORT BOOL WINAPI neturl( BMSCR *p1, char *p2, int p3, int p4 )
{
	//	(type$06)
	if ( http == NULL ) return -1;
	http->SetURL( p2 );
	return 0;
}


EXPORT BOOL WINAPI netdlname( BMSCR *p1, char *p2, int p3, int p4 )
{
	//	(type$06)
	if ( http == NULL ) return -1;
	http->SetLocalName( p2 );
	return 0;
}


EXPORT BOOL WINAPI netproxy( BMSCR *p1, char *p2, int p3, int p4 )
{
	//	(type$06)
	if ( http == NULL ) return -1;
	http->SetProxy( p2, p3, p4 );
	return 0;
}


EXPORT BOOL WINAPI netagent( BMSCR *p1, char *p2, int p3, int p4 )
{
	//	(type$06)
	if ( http == NULL ) return -1;
	http->SetAgent( p2 );
	return 0;
}


EXPORT BOOL WINAPI netheader( BMSCR *p1, char *p2, int p3, int p4 )
{
	//	(type$06)
	if ( http == NULL ) return -1;
	http->SetHeader( p2 );
	return 0;
}


EXPORT BOOL WINAPI netrequest( BMSCR *p1, char *p2, int p3, int p4 )
{
	//	(type$06)
	if ( http == NULL ) return -1;
	http->RequestFile( p2 );
	return 0;
}


EXPORT BOOL WINAPI netfileinfo( HSPEXINFO *hei, int p1, int p2, int p3 )
{
	//	(type$202)
	//	エラー文字列を得る
	//	(変数にエラー文字列を代入)
	//		neterror 変数
	//
	PVal *pv;
	APTR ap;
	char *ss;
	char *res;
	ap = hei->HspFunc_prm_getva( &pv );		// パラメータ1:変数
	ss = hei->HspFunc_prm_gets();			// パラメータ2:文字列

	if ( http == NULL ) return -1;
	res = http->RequestFileInfo( ss );
	if ( res == NULL ) return -1;

	hei->HspFunc_prm_setva( pv, ap, TYPE_STRING, res );	// 変数に値を代入
	return 0;
}


EXPORT BOOL WINAPI neterror( HSPEXINFO *hei, int p1, int p2, int p3 )
{
	//	(type$202)
	//	エラー文字列を得る
	//	(変数にエラー文字列を代入)
	//		neterror 変数
	//
	PVal *pv;
	APTR ap;
	char *ss;
	ap = hei->HspFunc_prm_getva( &pv );		// パラメータ1:変数
	if ( http == NULL ) return -1;
	ss = http->GetError();
	hei->HspFunc_prm_setva( pv, ap, TYPE_STRING, ss );	// 変数に値を代入
	return 0;
}


EXPORT BOOL WINAPI filecrc( HSPEXINFO *hei, int p1, int p2, int p3 )
{
	//	(type$202)
	//	ファイルのCRCを求める
	//	(変数にCRC32、strsizeにファイルサイズを代入)
	//		filecrc 変数, ファイル名
	//
	PVal *pv;
	APTR ap;
	char fname[_MAX_PATH];
	char *ss;
	int i;
	int num;
	CzCrypt crypt;
	HSPCTX *ctx;

	ap = hei->HspFunc_prm_getva( &pv );		// パラメータ1:変数
	ss = hei->HspFunc_prm_gets();			// パラメータ2:文字列
	strncpy( fname, ss, _MAX_PATH );
	i = crypt.DataLoad( fname );
	if ( i ) return -1;

	ctx = (HSPCTX *)hei->hspctx;

	num = crypt.GetCRC32();
	hei->HspFunc_prm_setva( pv, ap, TYPE_INUM, &num );	// 変数に値を代入
	ctx->strsize = crypt.GetSize();

	return 0;
}


EXPORT BOOL WINAPI filemd5( HSPEXINFO *hei, int p1, int p2, int p3 )
{
	//	(type$202)
	//	ファイルのMD5を求める
	//	(変数にMD5文字列、strsizeにファイルサイズを代入)
	//		filemd5 変数, ファイル名
	//
	PVal *pv;
	APTR ap;
	char fname[_MAX_PATH];
	char *ss;
	int i;
	char md5str[ 128 ];
	CzCrypt crypt;
	HSPCTX *ctx;

	ap = hei->HspFunc_prm_getva( &pv );		// パラメータ1:変数
	ss = hei->HspFunc_prm_gets();			// パラメータ2:文字列
	strncpy( fname, ss, _MAX_PATH );
	i = crypt.DataLoad( fname );
	if ( i ) return -1;

	ctx = (HSPCTX *)hei->hspctx;

	crypt.GetMD5( md5str );
	hei->HspFunc_prm_setva( pv, ap, TYPE_STRING, md5str );	// 変数に値を代入
	ctx->strsize = crypt.GetSize();

	return 0;
}

/*----------------------------------------------------------------*/


EXPORT BOOL WINAPI ftpresult( HSPEXINFO *hei, int p1, int p2, int p3 )
{
	//	(type$202)
	//	FTPサーバー返信文字列を得る
	//	(変数に文字列を代入)
	//		ftpresult 変数
	//
	PVal *pv;
	APTR ap;
	char *ss;
	ap = hei->HspFunc_prm_getva( &pv );		// パラメータ1:変数
	if ( http == NULL ) return -1;
	ss = http->GetTempBuffer();
	hei->HspFunc_prm_setva( pv, ap, TYPE_STRING, ss );	// 変数に値を代入
	return 0;
}


EXPORT BOOL WINAPI ftpopen( HSPEXINFO *hei, int p1, int p2, int p3 )
{
	//	(type$202)
	//		FTP接続
	//		ftpopen "アドレス","ユーザー","パスワード"
	//
	int i;
	char *ss;

	ss = hei->HspFunc_prm_gets();			// パラメータ1:文字列
	http->SetURL( ss );
	ss = hei->HspFunc_prm_gets();			// パラメータ2:文字列
	http->SetUserName( ss );
	ss = hei->HspFunc_prm_gets();			// パラメータ3:文字列
	http->SetUserPassword( ss );
	i = http->FtpConnect();
	return i;
}


EXPORT BOOL WINAPI ftpclose( HSPEXINFO *hei, int p1, int p2, int p3 )
{
	//	(type$202)
	//		FTP切断
	//		ftpclose
	//
	http->FtpDisconnect();
	return 0;
}


EXPORT BOOL WINAPI ftpdir( HSPEXINFO *hei, int p1, int p2, int p3 )
{
	//	(type$202)
	//	FTPサーバーディレクトリを得る
	//	(変数に文字列を代入)
	//		ftpdir 変数,変更dir
	//
	PVal *pv;
	APTR ap;
	char *ss;
	char *n;
	ap = hei->HspFunc_prm_getva( &pv );		// パラメータ1:変数
	n = hei->HspFunc_prm_getds("");		// パラメータ2:文字列
	if ( http == NULL ) return -1;

	if ( *n != 0 ) {
		http->SetFtpDir( n );
	}
	ss = http->GetFtpCurrentDir();
	hei->HspFunc_prm_setva( pv, ap, TYPE_STRING, ss );	// 変数に値を代入
	return 0;
}


EXPORT BOOL WINAPI ftpdirlist( HSPEXINFO *hei, int p1, int p2, int p3 )
{
	//	(type$202)
	//		FTPファイルリスト
	//		ftpdirlist
	//
	http->GetFtpDirList();
	return 0;
}


EXPORT BOOL WINAPI ftpdirlist2( HSPEXINFO *hei, int p1, int p2, int p3 )
{
	//	(type$202)
	//		FTPファイルリスト取得
	//		ftpdirlist2 変数
	//
	PVal *pv;
	APTR ap;
	char *ss;
	int i;
	ap = hei->HspFunc_prm_getva( &pv );		// パラメータ1:変数
	if ( http == NULL ) return -1;

	i = http->GetMode();
	if ( i == CZHTTP_MODE_FTPDIR ) return -3;
	if ( i != CZHTTP_MODE_FTPREADY ) return -2;

	ss = http->GetFlexBuffer();
	hei->HspFunc_prm_setva( pv, ap, TYPE_STRING, ss );	// 変数に値を代入
	return 0;
}


EXPORT BOOL WINAPI ftpcmd( HSPEXINFO *hei, int p1, int p2, int p3 )
{
	//	(type$202)
	//		FTPコマンド(結果はftpdirlist2で取得する)
	//		ftpcmd "command"
	//
	char *ss;
	ss = hei->HspFunc_prm_gets();			// パラメータ1:文字列
	return http->FtpSendCommand( ss );
}


EXPORT BOOL WINAPI ftprmdir( HSPEXINFO *hei, int p1, int p2, int p3 )
{
	//	(type$202)
	//		FTPディリクトリ削除
	//		ftprmdir "name"
	//
	char *ss;
	ss = hei->HspFunc_prm_gets();			// パラメータ1:文字列
	return http->KillFtpDir( ss );
}


EXPORT BOOL WINAPI ftpmkdir( HSPEXINFO *hei, int p1, int p2, int p3 )
{
	//	(type$202)
	//		FTPディレクトリ作成
	//		ftpmkdir "name"
	//
	char *ss;
	ss = hei->HspFunc_prm_gets();			// パラメータ1:文字列
	return http->MakeFtpDir( ss );
}


EXPORT BOOL WINAPI ftpget( HSPEXINFO *hei, int p1, int p2, int p3 )
{
	//	(type$202)
	//		FTPファイル取得
	//		ftpget "name","localname",mode
	//
	char name[256];
	char *ss;
	int _p1;
	ss = hei->HspFunc_prm_gets();			// パラメータ1:文字列
	strncpy( name, ss, 255 );
	ss = hei->HspFunc_prm_getds(name);		// パラメータ2:文字列
	_p1 = hei->HspFunc_prm_getdi(0);		// パラメータ3:整数値
	return http->GetFtpFile( name, ss, _p1 );
}


EXPORT BOOL WINAPI ftpput( HSPEXINFO *hei, int p1, int p2, int p3 )
{
	//	(type$202)
	//		FTPファイル送信
	//		ftpput "name","localname",mode
	//
	char name[256];
	char *ss;
	int _p1;
	ss = hei->HspFunc_prm_gets();			// パラメータ1:文字列
	strncpy( name, ss, 255 );
	ss = hei->HspFunc_prm_getds(name);		// パラメータ2:文字列
	_p1 = hei->HspFunc_prm_getdi(0);		// パラメータ3:整数値
	return http->PutFtpFile( name, ss, _p1 );
}


EXPORT BOOL WINAPI ftprename( HSPEXINFO *hei, int p1, int p2, int p3 )
{
	//	(type$202)
	//		FTPファイルリネーム
	//		ftpput "name","newname"
	//
	char name[256];
	char *ss;
	ss = hei->HspFunc_prm_gets();			// パラメータ1:文字列
	strncpy( name, ss, 255 );
	ss = hei->HspFunc_prm_getds(name);		// パラメータ2:文字列
	return http->RenameFtpFile( name, ss );
}


EXPORT BOOL WINAPI ftpdelete( HSPEXINFO *hei, int p1, int p2, int p3 )
{
	//	(type$202)
	//		FTPファイル削除
	//		ftpdelete "name"
	//
	char *ss;
	ss = hei->HspFunc_prm_gets();			// パラメータ1:文字列
	return http->RenameFtpFile( ss, NULL );
}


