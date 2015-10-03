;
; HSP3.0 Utility macros and functions
;
#ifndef __obj__
#define __obj__

#module "llmod_obj"

#uselib "user32.dll"
#func _IsWindowEnabled "IsWindowEnabled" int
#func _EnableWindow "EnableWindow" int,int
#func _GetWindowRect "GetWindowRect" int,int
#func _MoveWindow "MoveWindow" int,int,int,int,int,int
#func _ScreenToClient "ScreenToClient" int,int

#deffunc objgray int v1,int v2

	;================================================================================
	; objgray n1,n2		オブジェクトの使用可、不可設定
	;
	;  n1 : オブジェクトのID
	;  n2 : 使用可にするか不可するかのフラグ
	;================================================================================
	; buttonなどのオブジェクトを使用可にしたり、不可にしたりします。
	; n1にはbuttonやlistviewなどのIDを代入します。
	; n2を0にするとオブジェクトを使用できない状態にし、1にすると使用できる
	; 状態にします。
	; n2を-1にするとそのオブジェクトが使用可か不可かを調べます。
	;
	if v2<0 {
		_IsWindowEnabled objinfo_hwnd(v1)
	}else{
		_EnableWindow objinfo_hwnd(v1),v2
	}
	return stat


#deffunc p_scrwnd array v4

	;================================================================================
	; p_scrwnd v1			スクリーン座標系をウィンドウ座標系に変換
	;
	;  v1 : スクリーン座標系が入った数値変数
	;================================================================================
	;
	;<>説明
	; スクリーン座標系をウィンドウ座標系に変換します。
	; v1にx座標、y座標を代入しておきます。
	; 描画対象となっているウィンドを基準にします。
	;例)
	;	ginfo
	;	x=prmx,prmy
	;	p_scrwnd x	;スクリーン座標系をウィンドウ座標系に変換
	;
	mref bmscr,67
	prm=bmscr.13
	_ScreenToClient prm, varptr(v4)
	return


#deffunc getobjsize array v1,int v2

	;================================================================================
	; getobjsize v1,n2		オブジェクトのサイズと位置取得
	;
	;  v1 : オブジェクトのサイズ、位置を取得するための数値変数
	;  n2 : オブジェクトのID
	;================================================================================
	;
	;<>説明
	; オブジェクトのサイズと位置を取得します。
	; n2にはbuttonやlistviewなどのIDを代入します。
	; v1にはオブジェクトのサイズ、位置が以下のように代入されます。
	;	v1.0	幅
	;	v1.1	高さ
	;	v1.2	左上のx座標
	;	v1.3	左上のy座標
	;	v1.4	右下のx座標
	;	v1.5	右下のy座標
	; 各座標はウィンドウ座標系です。
	;
	;typedef struct _RECT {    // rc  
	;    LONG left; 
	;    LONG top; 
	;    LONG right; 
	;    LONG bottom; 
	;} RECT; 

	mref bmscr,67
	prm=bmscr.13
	v1.5=0

	_GetWindowRect objinfo_hwnd(v2), varptr(v1)+8
	res=stat
	v1=v1.4-v1.2 , v1.5-v1.3
	_ScreenToClient prm, varptr(v1)+8
	_ScreenToClient prm, varptr(v1)+16
	return res


#deffunc resizeobj int v1,array v2,int v3

	;================================================================================
	; resizeobj n1,v2,n3		オブジェクトのサイズ変更
	;
	;  n1 : オブジェクトのID
	;  v2 : サイズ、位置が入った数値変数
	;  n3 : 位置、サイズを変更しないかどうかのフラグ
	;================================================================================
	;
	;<>説明
	; オブジェクトn1のサイズを変更します。
	; v2には幅、高さ、x座標,y座表の順に代入しておきます。
	; n3を1にすると位置を変えずにサイズだけ変更します。
	; n3を2にするとサイズを変えずに位置だけ変更します。
	;
	;例)
	;	button "width*2",wx2
	;	button "height*2",hx2
	;	input s,100,20
	;	ipt_id=2
	;	;幅を40、高さを30にして(0,80)に移動する
	;	s=40,30,0,80
	;	resizeobj ipt_id,s
	;	stop
	;*wx2
	;	;幅を2倍にする
	;	getobjsize s,ipt_id
	;	s=s*2
	;	resizeobj ipt_id,s
	;	stop
	;*hx2
	;	;高さを2倍にする
	;	getobjsize s,ipt_id
	;	s.1=s.1*2
	;	resizeobj ipt_id,s
	;	stop
	;
	sx=v2(0):sy=v2(1):x=v2(2):y=v2(3)
	if v3 {			
		getobjsize m,v1		;getobjsizeでm.0からw,h,x,yが代入される
		if stat=-1 : return stat
		if v3=1 : x=m(2):y=m(3)		;位置を変更しない
		if v3=2 : sx=m:sy=m(1)		;サイズを変更しない
	}
	_MoveWindow objinfo_hwnd(v1),x,y,sx,sy,1
	return stat


#global


#endif
