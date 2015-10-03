
;	form_decodeモジュール
;	form_decode命令を使用するには以下の行を最初に入れてください
;
;	#include "form_decode.as"
;
#module
	;	form_decode命令
	;	form_decode 文字変数1, 文字変数2, 変換スイッチ
	;
	;	送信用にエンコードされたテキストを元の日本語にデコードします。
	;	文字変数2の内容をデコードして文字変数1に格納します。
	;	変換スイッチの効果は以下のとおりです。
	;		1にすると'&'を改行に変換
	;		2にすると'+'を空白に変換
	;		3にすると両方とも変換
	;
/*
	2008/02/01 変更点
		コードを整理・若干高速化。
	既知の不具合
		第1引数（cnvbf）が充分に確保されていないと
		バッファオーバーフローを引き起こす可能性があります。
*/
#deffunc form_decode var cnvbf,var txtbf,int sw
	i = 0                  		// テキストの読み出し位置
	txtsize = strlen(txtbf)		// テキストの長さ
	code = -1              		// 読みだした文字コード
	repeat
		if (code == 0)|(i >= txtsize) : break
		code = peek(txtbf, i)
		i+
		if code == '%' {
			// 日本語変換
			code = int("$" + strmid(txtbf, i, 2))
			i += 2
		}
		if sw & (code == '&') {
			// '&'は改行に
			wpoke cnvbf, cnt, $0A0D
			continue cnt + 2
		}
		if (sw >> 1) & (code == '+') {
			// '+'は空白に
			code = 32
		}
		poke cnvbf, cnt, code
	loop
	return

#global
