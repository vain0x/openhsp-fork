%dll
mod_fontdlg

%author
onitama

%note
mod_fontdlg.asをインクルードすること。

%type
ユーザー拡張命令

%group
画面制御命令

%port
Win
Cli
%ver
3.3
%date
2009/08/01
%index
fontdlg
フォント選択ダイアログを開く

%prm
p1, p2
p1 : 戻り値を格納する数値型配列変数
p2 = 0～(0) : オプション

%inst
フォント選択ダイアログを開きます。
フォント名はrefstrに、その他の情報はp1で指定した配列変数に代入されます。

p2にはオプションを指定します。0x100を指定すると、打ち消し線・下線・文字色を指定できるようになります。

正常に終了した場合、statには0以外が返ります。キャンセルされた場合やエラーが発生した場合はstatに0が返ります。

%sample
#include "mod_fontdlg.as"
	dim result, 8
	fontdlg result, 0

	if stat != 0 {
		mes "フォント名 : " + refstr
		mes "フォントサイズ（HSPで利用する論理サイズ）：" + result(0)
		mes "フォント書体 : " + result(1)
		pos 40 : mes "0 = 通常\n1 = 太字\n2 = 斜体\n3 = 太字斜体"
		pos  0 : mes "フォントサイズ（pt） : " + result(2)
		mes "フォントカラー（赤） : " + result(3)
		mes "フォントカラー（緑） : " + result(4)
		mes "フォントカラー（青） : " + result(5)
		mes "下線の有無 : " + result(6)
		mes "打ち消し線の有無 : " + result(7)
	}
	stop

%href
font
dialog
