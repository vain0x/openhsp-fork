;
; ステータスバー作成モジュール
;
#ifndef __mod_stbar__
#define __mod_stbar__

#module stbar
#uselib "user32"
#func	GetWindowRect "GetWindowRect" int, var

#deffunc stbar_bye
	; ステータスバー破棄(通常は呼ばなくてもOKです)
	act=ginfo_sel
	if sthwnd(act)=0 : return
	clrobj stbar(act)
	return

#deffunc stbar_ini
	; ステータスバー作成
	;
	act=ginfo_sel
	winobj "msctls_statusbar32","",0,$50000000
	stbar(act) = stat		; ステータスバーのオブジェクトID
	if stbar(act)<0 : dialog "ステータスバー作成に失敗しました" : return
	sthwnd(act) = objinfo(stbar(act), 2)	; ステータスバーのhWnd
	dim stsize, 4 		; RECT構造体
	GetWindowRect sthwnd, stsize
	stbar_sx(act) = stsize(2) - stsize(0)	; ステータスバーの幅
	stbar_sy(act) = stsize(3) - stsize(1)	; ステータスバーの高さ
	return

#deffunc stbar_text str _p1
	; ステータスバーにテキストを設定
	act=ginfo_sel
	if sthwnd(act)=0 : return
	msg=_p1
	sendmsg sthwnd(act), 0x0401, 0, varptr(msg) ; SB_SETTEXTを送る
	return

#deffunc stbar_resize
	; ステータスバーのリサイズメッセージ(WM_SIZE)処理
	act=ginfo_sel
	if sthwnd(act)=0 : return
	sendmsg sthwnd(act), 0x0005, 0, 0	 ; WM_SIZEを送る
	return

#global
#endif

