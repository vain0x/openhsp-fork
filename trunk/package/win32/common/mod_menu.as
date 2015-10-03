
; メニューバー作成モジュール
; http://quasiquote.org/hspwiki/
;       thanks ちょくと さん
;               http://yokohama.cool.ne.jp/chokuto/urawaza/menu1.html
;               http://yokohama.cool.ne.jp/chokuto/urawaza/menu2.html

#ifndef __mod_menu__
#define __mod_menu__

; DLLのロードと関数の宣言・初期化など
#uselib "user32.dll"
#func global CreateMenu         "CreateMenu"
#func global CreatePopupMenu    "CreatePopupMenu"
#func global AppendMenu         "AppendMenuA"           int, int, int, str
#func global SetMenu            "SetMenu"               int, int
#func global DrawMenuBar        "DrawMenuBar"           int
#func global PostMessage        "PostMessageA"          int, int, sptr, sptr

; ウィンドウメッセージを定義
#const global WM_CLOSE                          0x0010
#const global WM_COMMAND                        0x0111

#module "menumod"

#deffunc newmenu var _p1, int _p2
	;
	;	新しいメニューハンドルを取得する
	;
	;	newmenu p1,p2
	;		p1 : 結果を格納する変数名
	;		p2 : 0=メニュー項目用 / 1=ポップアップ項目用
	;
	if _p2=0 : CreateMenu
	if _p2=1 : CreatePopupMenu
	_p1 = stat
	return

#deffunc addmenu int _p1, str _p2, int _p3, int _p4
	;
	;	メニュー項目を追加する
	;
	;	addmenu p1,p2,p3,p4
	;		p1 : メニューハンドル
	;		p2 : メニュー文字列
	;		p3 : メニューアイテムID値
	;		p4 : メニュー項目属性
	;
        AppendMenu _p1, _p4, _p3, _p2
	return

#deffunc applymenu int _p1
	;
	;	メニューをウィンドウに割り当てる
	;
	;	applymenu p1
	;		p1 : メニューハンドル
	;
        SetMenu hwnd, _p1      ; メニューをウィンドウに割り当てる
        DrawMenuBar hwnd         ; メニューを再描画
	return

#global

#endif

