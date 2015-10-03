//
//	cz http header
//
#ifndef __czhttp_h
#define __czhttp_h

#include <wininet.h>
#define INETBUF_MAX 4096

enum {
CZHTTP_MODE_NONE = 0,
CZHTTP_MODE_READY,
CZHTTP_MODE_REQUEST,
CZHTTP_MODE_REQSEND,
CZHTTP_MODE_DATAWAIT,
CZHTTP_MODE_DATAEND,
CZHTTP_MODE_INFOREQ,
CZHTTP_MODE_INFORECV,
CZHTTP_MODE_FTPREADY,
CZHTTP_MODE_FTPDIR,
CZHTTP_MODE_FTPREAD,
CZHTTP_MODE_FTPWRITE,
CZHTTP_MODE_FTPCMD,
CZHTTP_MODE_FTPRESULT,
CZHTTP_MODE_ERROR,
CZHTTP_MODE_MAX
};

class CzHttp {
public:
	CzHttp();
	~CzHttp();
	void Terminate( void );
	void Reset( void );
	int Exec( void );									// 毎フレームごとに呼ばれる
	int GetMode( void ) { return mode; };				// 現在のモードを返す
	char *GetError( void );								// エラー文字列のポインタを取得
	int RequestFile( char *path );						// サーバーにファイルを要求
	char *RequestFileInfo( char *path );				// サーバーにファイル情報を要求
	void SetURL( char *url );							// サーバーのURLを設定
	void SetLocalName( char *name );					// ダウンロード名を設定
	int GetSize( void );								// 取得ファイルのサイズを返す
	char *GetData( void );								// 取得ファイルデータへのポインタを返す
	void SetAgent( char *agent );						// エージェントの設定
	void SetProxy( char *url, int port, int local );	// プロキシの設定
	void SetHeader( char *header );						// ヘッダ文字列の設定
	void SetUserName( char *name );						// ユーザー名の設定
	void SetUserPassword( char *pass );					// パスワードの設定
	void SetFtpPort( int port );						// ポートの設定

	int FtpConnect( void );								// FTP接続
	void FtpDisconnect( void );							// FTP切断
	char *GetFtpResponse( void );						// FTPレスポンスへのポインタを返す
	char *GetFtpCurrentDir( void );						// FTPカレントディレクトリ名を取得
	void SetFtpDir( char *name );						// FTPカレントディレクトリを変更
	void GetFtpDirList( void );							// FTPカレントディレクトリ内容を取得
	int KillFtpDir( char *name );						// FTPディリクトリ削除
	int MakeFtpDir( char *name );						// FTPディレクトリ作成
	int GetFtpFile( char *name, char *downname, int tmode );	// FTPファイル取得
	int PutFtpFile( char *name, char *downname, int tmode );	// FTPファイル送信
	int RenameFtpFile( char *name, char *newname );		// FTPファイルリネーム
	int FtpSendCommand( char *cmd );					// FTPコマンド送信

	char *GetTempBuffer( void );						// 内部バッファへのポインタを返す
	char *GetFlexBuffer( void ) { return pt; };			// 可変バッファへのポインタを返す

private:
	void SetError( char *mes );	

	void ResetFlexBuf( int defsize );
	void AllocFlexBuf( int size );
	void AddFlexBuf( char *data, int size );
	int GetFlexBufSize( void ) { return pt_cur; };

	HINTERNET hSession;
	HINTERNET hService;
    HINTERNET hFtpEnum;
    HINTERNET hResponse;
    WIN32_FIND_DATA	finddata;

	char *str_agent;		// User Agent (optonal)
	int mode;				// Current Mode
	int size;				// File Size

	char *pt;				// Memory Ptr
	int pt_cur;				// Flax Mem Size ( Current )
	int pt_size;			// Flax Mem Size ( Allocated )

	FILE *fp;
	int proxy_local;		// ProxyLocal flag
	int ftp_port;			// Ftp port

	char req_url[1024];		// Request URL
	char req_path[512];		// Request PATH
	char down_path[512];	// Download PATH
	char proxy_url[1024];	// Proxy URL
	char *req_header;		// Request Header (optonal)
	char username[256];		// User Name string buffer
	char userpass[256];		// User Pass string buffer
	char buf[INETBUF_MAX];	// temp
	char errstr[256];		// Error string buffer
};


#endif
