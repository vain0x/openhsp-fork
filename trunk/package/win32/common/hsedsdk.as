#ifndef __hsedsdk__
#define global __hsedsdk__

#module "hsedsdk"

//
// Win32API 関数
#uselib "user32.dll"
#func FindWindow@hsedsdk "FindWindowA" sptr, sptr
#func GetWindowThreadProcessId@hsedsdk "GetWindowThreadProcessId" int, var

#func OpenClipboard@hsedsdk "OpenClipboard" int
#cfunc IsClipboardFormatAvailable@hsedsdk "IsClipboardFormatAvailable" int
#func  CloseClipboard@hsedsdk "CloseClipboard"
#cfunc GetClipboardData@hsedsdk "GetClipboardData" int
#func  EmptyClipboard@hsedsdk "EmptyClipboard"
#func  SetClipboardData@hsedsdk "SetClipboardData" int,int

#uselib "kernel32.dll"
#func OpenProcess@hsedsdk "OpenProcess" int, int, int
#func GetCurrentProcess@hsedsdk "GetCurrentProcess"
#func DuplicateHandle@hsedsdk "DuplicateHandle" int, int, int, var, int, int, int
#func CloseHandle@hsedsdk "CloseHandle" int
#func CreatePipe@hsedsdk "CreatePipe" var, var, int, int
#func ReadFile@hsedsdk "ReadFile" int, var, int, var, int
#func WriteFile@hsedsdk "WriteFile" int, var, int, var, int
#func PeekNamedPipe@hsedsdk "PeekNamedPipe" int, int, int, int, var, int

#cfunc  GlobalLock@hsedsdk "GlobalLock" int
#cfunc  GlobalSize@hsedsdk "GlobalSize" int
#func   GlobalUnlock@hsedsdk "GlobalUnlock" int
#cfunc  GlobalAlloc@hsedsdk "GlobalAlloc" int,int
#cfunc  lstrcpy@hsedsdk "lstrcpy" int,int

// Win32API 定数(ウィンドウ メッセージを除く)
#const PROCESS_ALL_ACCESS@hsedsdk    0x001F0FFF
#const DUPLICATE_SAME_ACCESS@hsedsdk 0x00000002
#define  CF_OEMTEXT       $00000007

//
// 文字列定数
#define HSED_INTERFACE_NAME "HspEditorInterface"

//
// ウィンドウ メッセージ
#const WM_APP@hsedsdk 0x00008000
#const _HSED_GETVER          (WM_APP + 0x000)
#const _HSED_GETWND          (WM_APP + 0x100)
#const _HSED_GETPATH         (WM_APP + 0x101)

#const _HSED_GETTABCOUNT     (WM_APP + 0x200)
#const _HSED_GETTABID        (WM_APP + 0x201)
#const _HSED_GETFOOTYID      (WM_APP + 0x202)
#const _HSED_GETACTTABID     (WM_APP + 0x203)
#const _HSED_GETACTFOOTYID   (WM_APP + 0x204)

#const _HSED_CANCOPY         (WM_APP + 0x300)
#const _HSED_CANPASTE        (WM_APP + 0x301)
#const _HSED_CANUNDO         (WM_APP + 0x302)
#const _HSED_CANREDO         (WM_APP + 0x303)
#const _HSED_GETMODIFY       (WM_APP + 0x304)

#const _HSED_COPY            (WM_APP + 0x310)
#const _HSED_CUT             (WM_APP + 0x311)
#const _HSED_PASTE           (WM_APP + 0x312)
#const _HSED_UNDO            (WM_APP + 0x313)
#const _HSED_REDO            (WM_APP + 0x314)
#const _HSED_INDENT          (WM_APP + 0x315)
#const _HSED_UNINDENT        (WM_APP + 0x316)
#const _HSED_SELECTALL       (WM_APP + 0x317)

#const _HSED_SETTEXT         (WM_APP + 0x320)
#const _HSED_GETTEXT         (WM_APP + 0x321)
#const _HSED_GETTEXTLENGTH   (WM_APP + 0x322)
#const _HSED_GETLINES        (WM_APP + 0x323)
#const _HSED_SETSELTEXT      (WM_APP + 0x324)
#const _HSED_GETSELTEXT      (WM_APP + 0x325)
#const _HSED_GETLINETEXT     (WM_APP + 0x326)
#const _HSED_GETLINELENGTH   (WM_APP + 0x327)
#const _HSED_GETLINECODE     (WM_APP + 0x328)

#const _HSED_SETSELA         (WM_APP + 0x330)
#const _HSED_SETSELB         (WM_APP + 0x331)
#const _HSED_GETSELA         (WM_APP + 0x332)
#const _HSED_GETSELB         (WM_APP + 0x333)

#const _HSED_GETCARETLINE    (WM_APP + 0x340)
#const _HSED_GETCARETPOS     (WM_APP + 0x341)
#const _HSED_GETCARETTHROUGH (WM_APP + 0x342)
#const _HSED_GETCARETVPOS    (WM_APP + 0x343)
#const _HSED_SETCARETLINE    (WM_APP + 0x344)
#const _HSED_SETCARETPOS     (WM_APP + 0x345)
#const _HSED_SETCARETTHROUGH (WM_APP + 0x346)

#const _HSED_SETMARK         (WM_APP + 0x350)
#const _HSED_GETMARK         (WM_APP + 0x351)
#const _HSED_SETHIGHLIGHT    (WM_APP + 0x352)

//
// HSED_GETVER用の定数
#const global HGV_PUBLICVER    0
#const global HGV_PRIVATEVER   1
#const global HGV_HSPCMPVER    2
#const global HGV_FOOTYVER     3
#const global HGV_FOOTYBETAVER 4

//
// HSED_GETWND用の定数
#const global HGW_MAIN      0
#const global HGW_CLIENT    1
#const global HGW_TAB       2
#const global HGW_EDIT      3
#const global HGW_TOOLBAR   4
#const global HGW_STATUSBAR 5

//
// マクロ
#define global ctype hsed_getmajorver(%1) (%1 >> 16 & 0xFFFF)
#define global ctype hsed_getminorver(%1) (%1 >> 8 & 0xFF)
#define global ctype hsed_getbetaver(%1)  (%1 & 0xFF)

//
// パイプ ハンドルの解放
#deffunc hsed_uninitduppipe
	if hReadPipe:  CloseHandle hReadPipe:  hReadPipe  = 0
	if hWritePipe: CloseHandle hWritePipe: hWritePipe = 0

	if hDupReadPipe:  CloseHandle hDupReadPipe:  hDupReadPipe  = 0
	if hDupWritePipe: CloseHandle hDupWritePipe: hDupWritePipe = 0
	return

//
// パイプ ハンドルの作成
#deffunc hsed_initduppipe int nSize
	CreatePipe@hsedsdk hReadPipe, hWritePipe, 0, nSize
	if hReadPipe == 0 || hWritePipe == 0: return 1

	GetWindowThreadProcessID@hsedsdk hIF, dwProcessID
	OpenProcess@hsedsdk PROCESS_ALL_ACCESS@hsedsdk, 0, dwProcessID
	hHsedProc = stat

	GetCurrentProcess@hsedsdk
	hCurProc = stat

	DuplicateHandle@hsedsdk hCurProc, hReadPipe,  hHsedProc, hDupReadPipe,  0, 0, DUPLICATE_SAME_ACCESS@hsedsdk
	DuplicateHandle@hsedsdk hCurProc, hWritePipe, hHsedProc, hDupWritePipe, 0, 0, DUPLICATE_SAME_ACCESS@hsedsdk

	CloseHandle@hsedsdk hHsedProc
	if hDupReadPipe == 0 | hDupWritePipe == 0: hsed_uninitduppipe: return 1
	return 0

//
// スクリプト エディタのAPIウィンドウの捕捉
#deffunc hsed_capture
	FindWindow@hsedsdk HSED_INTERFACE_NAME, HSED_INTERFACE_NAME
	hIF = stat
	if hIF == 0: return 1
	return 0

//
// スクリプト エディタが起動しているかチェック
#deffunc hsed_exist
	hsed_capture
	return stat == 0

//
// スクリプト エディタのバージョンを取得
#deffunc hsed_getver var ret, int nType
	hsed_capture
	if stat: ret = 0: return 1

	if(nType == HGV_HSPCMPVER){

		hsed_initduppipe 4096
		if stat: return 2

		sendmsg hIF, _HSED_GETVER, nType, hDupWritePipe
		if stat < 0: ret = "Error": hsed_uninitduppipe: return 3
		
		PeekNamedPipe hReadPipe, 0, 0, 0, dwTotalBytesAvail, 0
		if stat == 0: hsed_uninitduppipe: return 4
		
		sdim ret, dwTotalBytesAvail + 1
		if dwTotalBytesAvail > 0 {
			ReadFile hReadPipe, ret, dwTotalBytesAvail, dwNumberOfBytesRead, 0
		}
		hsed_uninitduppipe

	} else {
		sendmsg hIF, _HSED_GETVER, nType, 0
		ret = stat
		if ret < 0: return 3
	}
	return 0

//
// スクリプト エディタの各種ハンドルを取得
#deffunc hsed_getwnd var ret, int nType, int nID
	hsed_capture
	if stat: ret = 0: return 1

	if nType == HGW_EDIT{
		sendmsg hIF, _HSED_GETWND, nType, nID
	} else {
		sendmsg hIF, _HSED_GETWND, nType, 0
	}
	ret = stat
	if ret = 0: return 2: else: return 0

//
// ファイルパスを取得
#deffunc hsed_getpath var ret, int nTabID
	hsed_capture
	if stat: return 1

	hsed_initduppipe 260
	if stat: return 2

	sendmsg hIF, _HSED_GETPATH, nTabID, hDupWritePipe
	if stat < 0: ret = "Error": hsed_uninitduppipe: return 3

	PeekNamedPipe hReadPipe, 0, 0, 0, dwTotalBytesAvail, 0
	if stat == 0: hsed_uninitduppipe: return 4

	sdim ret, dwTotalBytesAvail + 1
	if dwTotalBytesAvail > 0 {
		ReadFile hReadPipe, ret, dwTotalBytesAvail, dwNumberOfBytesRead, 0
	}
	hsed_uninitduppipe
	return 0

//
// バージョンの数値を文字列に変換
#deffunc hsed_cnvverstr int nVersion
	sdim _refstr, 4096
	_refstr = "" + hsed_getmajorver(nVersion) + "." + strf("%02d", hsed_getminorver(nVersion))
	if hsed_getbetaver(nVersion): _refstr += "b" + hsed_getbetaver(nVersion)
	return _refstr

//
// タブ数の取得
#deffunc hsed_gettabcount var ret
	hsed_capture
	if stat: ret = -1: return 1

	sendmsg hIF, _HSED_GETTABCOUNT
	ret = stat
	return 0

//
// FootyのIDからタブのIDを取得
#deffunc hsed_gettabid var ret, int nFootyID
	hsed_capture
	if stat: ret = -1: return 1

	sendmsg hIF, _HSED_GETTABID, nFootyID
	if ret < 0{
		ret = -1
		return 2
	} else {
		ret = stat
		return 0
	}

//
// タブのIDからFootyのIDを取得
#deffunc hsed_getfootyid var ret, int nTabID
	hsed_capture
	if stat: ret = -1: return 1

	sendmsg hIF, _HSED_GETFOOTYID, nTabID
	if ret < 0{
		ret = -1
		return 2
	} else {
		ret = stat
		return 0
	}

//
// コピーの可否を取得
#deffunc hsed_cancopy var ret, int nFootyID
	hsed_capture
	if stat: ret = -1: return 1

	sendmsg hIF, _HSED_CANCOPY, nFootyID
	ret = stat
	if ret < 0: return 2: else: return 0

//
// 貼り付けの可否を取得
#deffunc hsed_canpaste var ret
	hsed_capture
	if stat: ret = -1: return 1

	sendmsg hIF, _HSED_CANPASTE
	ret = stat
	return 0

//
// アンドゥの可否を取得
#deffunc hsed_canundo var ret, int nFootyID
	hsed_capture
	if stat: ret = -1: return 1

	sendmsg hIF, _HSED_CANUNDO, nFootyID
	ret = stat
	if ret < 0: return 2: else: return 0

//
// リドゥの可否を取得
#deffunc hsed_canredo var ret, int nFootyID
	hsed_capture
	if stat: ret = -1: return 1

	sendmsg hIF, _HSED_CANREDO, nFootyID
	ret = stat
	if ret < 0: return 2: else: return 0

//
// 変更フラグを取得
#deffunc hsed_getmodify var ret, int nFootyID
	hsed_capture
	if stat: ret = -1: return 1

	sendmsg hIF, _HSED_GETMODIFY, nFootyID
	ret = stat
	if ret < 0: return 2: else: return 0

//
// コピー
#deffunc hsed_copy int nFootyID
	hsed_capture
	if stat: return 1

	sendmsg hIF, _HSED_COPY, nFootyID
	if stat == -1: return 0: else: return

//
// 切り取り
#deffunc hsed_cut int nFootyID
	hsed_capture
	if stat: return 1

	sendmsg hIF, _HSED_CUT, nFootyID
	if stat == -1: return 0: else: return

//
// 貼り付け
#deffunc hsed_paste int nFootyID
	hsed_capture
	if stat: return 1

	sendmsg hIF, _HSED_PASTE, nFootyID
	if stat == -1: return 0: else: return

//
// アンドゥ
#deffunc hsed_undo int nFootyID
	hsed_capture
	if stat: return 1

	sendmsg hIF, _HSED_UNDO, nFootyID
	if stat == -1: return 0: else: return

//
// リドゥ
#deffunc hsed_redo int nFootyID
	hsed_capture
	if stat: return 1

	sendmsg hIF, _HSED_REDO, nFootyID
	if stat == -1: return 0: else: return

//
// インデント
#deffunc hsed_indent int nFootyID
	hsed_capture
	if stat: return 1

	sendmsg hIF, _HSED_INDENT, nFootyID
	if stat == -1: return 0: else: return

//
// アンインデント
#deffunc hsed_unindent int nFootyID
	hsed_capture
	if stat: return 1

	sendmsg hIF, _HSED_UNINDENT, nFootyID
	if stat == -1: return 0: else: return

//
// すべて選択
#deffunc hsed_selectall int nFootyID
	hsed_capture
	if stat: return 1

	sendmsg hIF, _HSED_SELECTALL, nFootyID
	if stat == -1: return 0: else: return

//
// 文字列長を取得
#deffunc hsed_gettextlength var ret, int nFootyID
	hsed_capture
	if stat: return 1

	sendmsg hIF, _HSED_GETTEXTLENGTH, nFootyID
	if stat < 0: return 1: else: ret = stat: return 0

//
// 行数を取得
#deffunc hsed_getlines var ret, int nFootyID
	hsed_capture
	if stat: return 1

	sendmsg hIF, _HSED_GETLINES, nFootyID
	if stat < 0: return 1: else: ret = stat: return 0

//
// 行の文字列長を取得
#deffunc hsed_getlinelength var ret, int nFootyID, int nLine
	hsed_capture
	if stat: return 1

	sendmsg hIF, _HSED_GETLINELENGTH, nFootyID, nLine
	if stat < 0: return 1: else: ret = stat: return 0

//
// 改行コードの取得
#deffunc hsed_getlinecode var ret, int nFootyID
	hsed_capture
	if stat: return 1

	sendmsg hIF, _HSED_GETLINECODE, nFootyID
	if stat == -5{
		ret = -1
		return 1
	} else {
		ret = stat
		return 0
	}

//
// 文字列の取得
#deffunc hsed_gettext var ret, int nFootyID
	hsed_capture
	if stat: return 1

	hsed_gettextlength nLength, nFootyID
	if stat: return 2

	sdim ret, nLength + 1
	if nLength == 0 : return 0
	hsed_initduppipe nLength + 1
	if stat: return 3

	sendmsg hIF, _HSED_GETTEXT, nFootyID, hDupWritePipe
	if stat < 0: ret = "Error": hsed_uninitduppipe: return 4

	ReadFile hReadPipe, ret, nLength, dwNumberOfBytesRead, 0
	hsed_uninitduppipe
	return 0

#deffunc hsed_sendtext_msg int nFootyID, int msg, var sText
	hsed_capture
	if stat: return 1

	nLength = strlen(sText)

	hsed_initduppipe nLength + 1
	if stat: return 3

	WriteFile hWritePipe, sText, nLength + 1, dwNumberOfBytesWritten, 0

	sendmsg hIF, msg, nFootyID, hDupReadPipe
	if stat < 0: hsed_uninitduppipe: return 4
	
	hsed_uninitduppipe
	return 0

#deffunc hsed_settext int nFootyID, str sText
	vText = sText
	hsed_sendtext_msg nFootyID, _HSED_SETTEXT, vText
	sdim vText
	return

//
// アクティブなFootyのIDの取得
#deffunc hsed_getactfootyid var ret
	hsed_capture
	if stat: ret = -1: return 1

	sendmsg hIF, _HSED_GETACTFOOTYID
	ret = stat
	return 0


//
// アクティブなタブのIDの取得
#deffunc hsed_getacttabid var ret
	hsed_capture
	if stat: ret = -1: return 1

	sendmsg hIF, _HSED_GETACTTABID
	ret = stat
	return 0


//
// 指定された文字列をエディタに送る
#deffunc hsed_sendstr var _p1
	hsed_getactfootyid actid
	if stat : return 1

	vinfo=sysinfo(0)
	if instr(vinfo,0,"WindowsNT")<0 : goto *sendbyclip
	vdbl=0.0+strmid(vinfo,13,8)
	if vdbl<5.1 : goto *sendbyclip

	;	直接文字列データを送信する
	hsed_sendtext_msg actid, _HSED_SETSELTEXT, _p1
	return
*sendbyclip
	;	クリップボード経由で文字列を送信する
	;	(WindowsXPより前の環境用)
	OpenClipboard
	ret=stat : if ret!0 : EmptyClipboard

	;クリップボードにテキストデータを設定
	ls=strlen(_p1)+1
	lngHwnd=GlobalAlloc(2,ls)
	if lngHwnd!0 {
		lngMem=GlobalLock(lngHwnd)
		if lngMem!0 {
			ret=lstrcpy(lngMem,varptr(_p1))
			if ret!0 {
				SetClipboardData CF_OEMTEXT,lngHwnd
			}
			GlobalUnlock lngHwnd : lngRet=stat
		}
	}
	CloseClipboard
	sendmsg hIF, _HSED_PASTE,-1, 0
	return


#global

#endif