;
;	HSP help manager用 HELPソースファイル
;	(先頭が「;」の行はコメントとして処理されます)
;

%type
拡張命令
%ver
3.3
%note
llmod3.hsp,obj.hspをインクルードする

%date
2009/08/01
%author
tom
%dll
llmod3
%url
http://www5b.biglobe.ne.jp/~diamond/hsp/hsp2file.htm


%index
objgray
オブジェクトの使用可、不可設定
%group
オブジェクト制御命令
%prm
n1,n2
n1 : オブジェクトのID
n2 : 使用可にするか不可するかのフラグ

%inst
buttonなどのオブジェクトを使用可にしたり、不可にしたりします。
n1にはbuttonやlistviewなどのIDを代入します。
n2を0にするとオブジェクトを使用できない状態にし、1にすると使用できる状態にします。
n2を-1にするとそのオブジェクトが使用可か不可かを調べます。
^p
この命令を呼び出した後のstatの値
    1       エラー無し
    0,-1    エラー
n2を-1にしたとき
    1       使用可
    0       使用不可



%index
p_wndscr
ウィンドウ座標系をスクリーン座標系に変換
%group
拡張入出力制御命令
%prm
v1
v1 : ウィンドウ座標系が入った数値変数
%inst
ウィンドウ座標系をスクリーン座標系に変換します。
v1にx座標、y座標を代入しておきます。
描画対象となっているウィンドを基準にします。

%href
p_scrwnd
%sample
	x=mousex,mousey
	p_wndscr x	;ウィンドウ座標(100,30)をスクリーン座標に変換




%index
resizeobj
オブジェクトのサイズ変更
%group
オブジェクト制御命令
%prm
n1,v2,n3
n1 : オブジェクトのID
v2 : サイズ、位置が入った数値変数
n3 : 位置、サイズを変更しないかどうかのフラグ

%inst
オブジェクトn1のサイズを変更します。
v2には幅、高さ、x座標,y座表の順に代入しておきます。
n3を1にすると位置を変えずにサイズだけ変更します。
n3を2にするとサイズを変えずに位置だけ変更します。

%href
getobjsize
%sample
	button "width*2",wx2
	button "height*2",hx2
	input s,100,20
	ipt_id=2
	;幅を40、高さを30にして(0,80)に移動する
	s=40,30,0,80
	resizeobj ipt_id,s
	stop
*wx2
	;幅を2倍にする
	getobjsize s,ipt_id
	s=s*2
	resizeobj ipt_id,s
	stop
*hx2
	;高さを2倍にする
	getobjsize s,ipt_id
	s.1=s.1*2
	resizeobj ipt_id,s
	stop




%index
getobjsize
オブジェクトのサイズと位置取得
%group
オブジェクト制御命令
%prm
v1,n2
v1 : オブジェクトのサイズ、位置を取得するための数値変数
n2 : オブジェクトのID

%inst
オブジェクトのサイズと位置を取得します。
n2にはbuttonやlistviewなどのIDを代入します。
v1にはオブジェクトのサイズ、位置が以下のように代入されます。
^p
v1.0	幅
v1.1	高さ
v1.2	左上のx座標
v1.3	左上のy座標
v1.4	右下のx座標
v1.5	右下のy座標
^p
各座標はウィンドウ座標系です。

%href
resizeobj



%index
p_scrwnd
スクリーン座標系をウィンドウ座標系に変換
%group
拡張入出力制御命令
%prm
v1
v1 : スクリーン座標系が入った数値変数

%inst
スクリーン座標系をウィンドウ座標系に変換します。
v1にx座標、y座標を代入しておきます。
描画対象となっているウィンドウを基準にします。

%href
p_wndscr

%sample
	ginfo
	x=prmx,prmy
	p_scrwnd x	;スクリーン座標系をウィンドウ座標系に変換


