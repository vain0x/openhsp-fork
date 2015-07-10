;
; HSPTV define and macros
;
#ifndef __hsptv__
#define __hsptv__
#runtime "hsptv"
#regcmd 18
#cmd hsptv_send $00

#module hsptv
#define global HSPTV_RANK_MAX 30

#deffunc hsptv_up int _p1, str _p2, int _p3

	;	HSPTVデータを更新します
	;	hsptv_up score,"comment",option
	;	score,comment情報を反映させて最新データを取得します。
	;	(scoreがマイナス値の場合は最新データのみ取得します)
	;
	buf=""
	hsptv_send buf,_p1,_p2,_p3
	return

#deffunc hsptv_getrank var _p1, var _p2, var _p3, int _p4

	;	HSPTVデータを取得します
	;	hsptv_getrank var1,var2,var3,rank
	;	(変数var1にrankで指定した順位のスコア情報を代入します)
	;	(変数var2にrankで指定した順位のユーザー名を代入します)
	;	(変数var3にrankで指定した順位のコメント情報を代入します)
	;	(rankは0が1位、29が30位となる)
	;	(var1は数値型、var2,var3は文字列型となります)
	;	(最新データの更新はhsptv_upで行なってください)
	;
	notesel buf
	i=_p4*3
	noteget _p2, i
	_p1=0+_p2
	noteget _p2, i+1
	noteget _p3, i+2
	noteunsel
	return

#global
#endif
