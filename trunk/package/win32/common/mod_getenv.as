
;	getenvモジュール
;	getenv命令を使用するには以下の行を最初に入れてください
;
;	#include "mod_getenv.as"
;
#module
#uselib "Kernel32.dll"
#func GetEnvironmentVariable "GetEnvironmentVariableA" str,var,int

	;	getenv命令
	;	getenv 変数, "環境変数名"
	;
	;	環境変数の値を変数に取得します。
	;
#deffunc getenv var _p1,str _p2

	GetEnvironmentVariable _p2, _p1,0
	size=stat+1
	memexpand _p1,size ; バッファ確保
	_p1=""
	GetEnvironmentVariable _p2,_p1,size
	return
#global


