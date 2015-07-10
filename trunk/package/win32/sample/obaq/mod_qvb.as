
;
;	qvb module for OBAQ
;

#module
#deffunc qvbload var _p1, str _p2

	;	qvbload命令
	;	qvbload 変数, "ファイル名"
	;	指定されたファイル名(qvbファイル)のモデルデータを変数に読み込みます。
	;	読み込んだデータは、そのままqaddmodel命令で指定することができます。
	;	(データは整数形式のため表示スケールを小さめに設定してください)
	;	qvbファイルは、別途ツール(obaqme.hsp)で作成してください。
	;
	exist _p2
	if strsize<=0 : dialog "No file ["+_p2+"]" : return
	qvxmax=strsize/4
	dim _p1,qvxmax
	bload _p2,_p1
	return

#global

