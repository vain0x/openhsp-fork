;----------------------------------------------------------------
; ジョイスティック入力モジュール MIA 2004 / onitama 2005
;  使用に関する制限はありません。ご自由にお使いください。
;----------------------------------------------------------------

#module "joy"

#const BORDER_LOW   32768 - 4096
#const BORDER_HIGH  32768 + 4096

#uselib "winmm.dll"
#func _joyGetPosEx "joyGetPosEx" int, var

#deffunc joyGetPosEx array p1, int p2
	p1.15=0:p1=52,255
	_joyGetPosEx p2,p1
	return

#deffunc jstick var p1, int p2
	;	jstick 変数,ポート番号
	;	(stick命令互換の値を変数に返す)
	;
	jdata.15=0:jdata=52,255
	_joyGetPosEx p2,jdata
	if stat!=0 : p1=0 : return
	res=(jdata.8)<<4
	if jdata.2<BORDER_LOW : res|=1
	if jdata.2>BORDER_HIGH : res|=4
	if jdata.3<BORDER_LOW : res|=2
	if jdata.3>BORDER_HIGH : res|=8
	p1=res
	return

#global


;----------------------------------------------------------------
; サンプルコード
;----------------------------------------------------------------
;----------------------------------------------------------------
; joyGetPosEx data, ポート番号
;   stat = 0 であれば入力は正常です。
;	data.0 = 常に 52  が入ります
;	data.1 = 常に 255 が入ります
;	data.2 = 第 1 軸の状態（普通のジョイスティックの X 軸）
;	data.3 = 第 2 軸の状態（普通のジョイスティックの Y 軸）
;	data.4 = 第 3 軸の状態（スロットル等）
;	data.5 = 第 4 軸の状態
;	data.6 = 第 5 軸の状態
;	data.7 = 第 6 軸の状態
;	data.8 = ボタンの状態（最大32ボタン）
;	data.9 = 同時に押されているボタンの数
;	data.10 = POV スイッチの状態
;	data.11 = 予備情報1
;	data.12 = 予備情報2
;----------------------------------------------------------------
/*
	repeat
		redraw 0
		color 255,255,255 : boxf : color 0,0,0
		joyGetPosEx data, 0
		pos 0,0 : mes "stat = " + stat
		repeat 13 : mes data.cnt : loop
		redraw 1 : await 30
	loop
*/
