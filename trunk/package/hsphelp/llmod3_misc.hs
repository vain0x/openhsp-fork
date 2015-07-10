;
;	HSP help manager用 HELPソースファイル
;	(先頭が「;」の行はコメントとして処理されます)
;

%type
拡張命令
%ver
3.3
%note
llmod3.hsp,misc.hspをインクルードする

%date
2009/08/01
%author
tom
%dll
llmod3
%url
http://www5b.biglobe.ne.jp/~diamond/hsp/hsp2file.htm



%index
tooltip
ツールチップを付ける
%group
オブジェクト制御命令
%prm
n1,n2,n3
n1 :  button,input,treeboxなどのID
n2 : ツールチップ上に表示する文字列
n3 : ツールチップの背景色 (IE3.0以上)
%inst
オブジェクトにツールチップを付けます。
ツールチップとはマウスカーソルがbuttonなどのオブジェクト上で一定時間停止したときに現れる小さなウィンドウです。
%sample
	button "test",label	: btn_id=0
	tooltip btn_id,"テストします"
*label
	stop



%index
strtoint
文字列を数値に変換
%group
オブジェクト制御命令
%prm
s1,n2
s1 : 数値に変換する文字列
n2 : 基数(2～36)
%inst
文字列を数値に変換します。
%sample
	strtoint "111101",2	;2進数とみなして変換
	mes stat

	strtoint "0x1F"		;先頭が"0x"だと16進数とみなされる(Base省略時)
	mes stat

	strtoint "0376"		;先頭が"0"だと8進数とみなされる(Base省略時)
	mes stat

	strtoint "23413",7	;7進数とみなして変換
	mes stat

	strtoint "za",36	;36進数とみなして変換
	mes stat
stop







%index
btnimg
buttonに画像を貼りつける
%group
オブジェクト制御命令
%prm
n1, n2, n3, n4, n5, n6
n1 : イメージを貼りつけるボタンのID(0～63)
n2 : イメージが描画されているウィンドウのID(0～7)
n3 : イメージの位置
n4 : イメージの位置
n5 : イメージの幅
n6 : イメージの高さ

%inst
buttonに画像を貼りつけます。

%sample
	buffer 1
	picload "mybmp.bmp"	;ウィンドウID 1 にビットマップを表示
	bmp_w=winx:bmp_h=winy
	gsel 0
	button "",*label : btn_id=0
^
	;ウィンドウID 1の(0,0)-(bmp_w,bmp_h)の範囲の画像をボタンに描画する
	btnimg btn_id,1,0,0,bmp_w,bmp_h
*label
stop



