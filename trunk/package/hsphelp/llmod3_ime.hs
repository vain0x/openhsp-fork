;
;	HSP help manager用 HELPソースファイル
;	(先頭が「;」の行はコメントとして処理されます)
;

%type
拡張命令
%ver
3.3
%note
llmod3.hsp,ime.hspをインクルードする

%date
2009/08/01
%author
tom
%dll
llmod3
%url
http://www5b.biglobe.ne.jp/~diamond/hsp/hsp2file.htm


%index
imeinit
IME情報を取得
%group
拡張入出力制御命令
%prm
v1,n2
v1 : IME情報を代入する変数
n2 : mesboxのID
%inst
IME情報を取得します。
n2にmesboxのIDを代入します。
%href
imeopen
imestr
imesend
linesel
selget
%sample
	#include "llmod3.hsp"
	#include "ime.hsp"
^
	alloc buf,64*1024 : buf=""
	mesbox buf,winx,winy,1
	mb0_id=0
	imeinit mb0_ime,mb0_id



%index
imeopen
IMEウィンドウを開く
%group
拡張入出力制御命令
%prm
v1,n2
v1 : imeinitに使用した変数
n2 : 開くか閉じるかを示すフラグ
%inst
imeinitで取得したIMEを開きます。
n2を1にするとIMEウィンドウを閉じることができます。
%href
imeinit
imestr
imesend
linesel
selget
%sample
	#include "llmod3.hsp"
	#include "ime.hsp"
^
	alloc buf,64*1024 : buf=""
	mesbox buf,winx,winy,1
	mb0_id=0
	imeinit mb0_ime,mb0_id
	imeopen mb0_ime



%index
imestr
IMEに文字列を送る
%group
拡張入出力制御命令
%prm
v1,"s2"
v1 : imeinitに使用した変数
s2 : IMEに送る文字列
%inst
IMEに文字列を送ります。
文字列内にタブや改行があっては行けません。
文字列には半角文字(英字、かな)、全角文字(英字、ひらがな、カタカナ)が使用できます。
%href
imeinit
imeopen
imesend
linesel
selget
%sample
	#include "llmod3.hsp"
	#include "ime.hsp"
^
	alloc buf,64*1024 : buf=""
	mesbox buf,winx,winy,1
	mb0_id=0
	imeinit mb0_ime,mb0_id
	imeopen mb0_ime			;IMEを開く
	imestr  mb0_ime,"ｱｲｳｴｵ"		;文字列"ｱｲｳｴｵ"をIMEに送る



%index
imesend
IMEにメッセージを送る
%group
拡張入出力制御命令
%prm
v1,n2,n3,n4
v1 : imeinitに使用した変数
n2 : IMEに送るメッセージ
n3 : パラメータ1
n4 : パラメータ2
%inst
IMEへメッセージを送ります。
^p
n2の値
0       候補ウィンドウを開く
1       候補ウィンドウを閉じる
2       n3ページのn4番目の候補を選択
3       候補ウィンドウのn4番目のページを表示
4       決定(0)、変換実行(1)、戻す(2)、キャンセル(3)(括弧内はn3の値)
5       候補ウィンドウのサイズを変える(n3:0～31)
%href
imeinit
imeopen
imestr
linesel
selget
%sample
	#include "llmod3.hsp"
	#include "ime.hsp"
^
	alloc buf,64*1024 : buf=""
	mesbox buf,winx,winy,1
	mb0_id=0
	imeinit mb0_ime,mb0_id
	imeopen mb0_ime			;IMEを開く
^
	imestr  mb0_ime,"ﾅﾂﾒｿｳｾｷ"	;文字列"ﾅﾂﾒｿｳｾｷ"をIMEに送る
	imesend mb0_ime,4,1		;"ﾅﾂﾒｿｳｾｷ"を変換実行
	imesend mb0_ime,4,0		;決定
^
	imestr  mb0_ime,"のいえ"	;文字列"のいえ"をIMEに送る
	imesend mb0_ime,4,1		;"のいえ"を変換実行
	imesend mb0_ime,4,0		;決定
^
	imestr	mb0_ime,"ｱｵｲ"
	imesend mb0_ime,0		;候補ウィンドウを開く



%index
linesel
mesbox内の一行を選択
%group
拡張入出力制御命令
%prm
n1.n2
n1 : mesboxのID
n2 : 選択する行
%inst
mesbox n1 内のn2行を選択します。n2は0から数えます。
n2を-1にするとカーソルがある行を選択します。
n2を-2にするとmesbox内の文字全てを選択します。
%href
imeinit
imeopen
imestr
imesend
selget
%sample
	#include "llmod3.hsp"
	#include "ime.hsp"
^
	alloc buf,1024 : buf="123456\n7890"
	mesbox buf,300,200,1
	mb_id=0
	linesel mb_id,1		;1行目を選択(7890が選択される)



%index
selget
mesbox内の選択部分の文字列を取得
%group
拡張入出力制御命令
%prm
v1,n2
v1 : mesbox内の選択されている部分を代入する変数
n2 : mesboxのID
%inst
mesbox n2 の選択されている部分を取得します。
%href
imeinit
imeopen
imestr
imesend
linesel
%sample
	#include "llmod3.hsp"
	#include "ime.hsp"
^
	alloc buf,1024 : buf="123456\n7890"
	mesbox buf,300,200,1
	mb_id=0
	linesel mb_id,1
	selget line_buf,mb_id
	dialog line_buf

