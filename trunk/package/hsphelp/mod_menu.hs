%ver
3.3
%date
2009/08/01
%author
onitama（thanks ちょくと さん）

%dll
mod_menu

%note
mod_menu.asをインクルードすること。

%port
Win
Let

%url
http://yokohama.cool.ne.jp/chokuto/urawaza/api/AppendMenu.html

%type
ユーザー拡張命令

%group
メニューバー作成


%index
addmenu
メニュー項目を追加する

%prm
p1, p2, p3, p4
p1 : メニューハンドル
p2 : メニュー文字列
p3 : メニューアイテムID値
p4 : メニュー項目属性

%inst
newmenuで作成したメニューに項目を追加します。
メニューの作成に失敗するとstatに0が返ります。
^
p1には項目を追加するメニューのハンドルを指定します。
^
p2にはメニューアイテムに表示する文字列を指定します。半角の&に続けて半角アルファベットを記述すると、ショートカットキーとして割り当てることができます。
^
p3にはメニューアイテムのIDを指定します。p4に0x0010を指定した場合は、ドロップダウンメニューまたはサブメニューのハンドルを指定します。
^
p4にはメニューアイテムのオプションを指定します。オプションは加算あるいはOR演算で組み合わせて使用できます。
html{
<table border="1">
<caption>addmenu命令の第4パラメータ（一部）</caption>
<tr><td>0x0000</td><td>デフォルト表示</td></tr>
<tr><td>0x0003</td><td>灰色表示・選択不可</td></tr>
<tr><td>0x0008</td><td>アイテムにチェックマークを付ける</td></tr>
<tr><td>0x0010</td><td>ドロップダウンメニューまたはサブメニューを開くアイテムを追加</td></tr>
<tr><td>0x0800</td><td>セパレータ（区切り線）を表示</td></tr>
</table>
}html

%sample
#include "mod_menu.as"
#define CMD_A		1
#define CMD_B		2
#define CMD_D		3
#define CMD_QUIT	4

	oncmd gosub *OnCommand, WM_COMMAND	//  メッセージ割り込み
	// メニューC直下のサブメニュー作成
	newmenu hsubmenu2, 1
	addmenu hsubmenu2, "メニューD(&D)", CMD_D
	// サブメニュー作成
	newmenu hsubmenu, 1
	addmenu hsubmenu, "メニューA(&A)", CMD_A, 0x0003    	// 灰色表示・選択不可
	addmenu hsubmenu, "メニューB(&B)", CMD_B, 0x0008    	// チェックマーク付き
	addmenu hsubmenu, "メニューC(&C)", hsubmenu2, 0x0010	// サブメニューあり
	addmenu hsubmenu, "", 0, 0x0800                     	// セパレータ
	addmenu hsubmenu, "終了(&Q)", CMD_QUIT
	// トップメニュー作成
	newmenu hmenu, 0
	addmenu hmenu, "メニュー(&M)", hsubmenu, 0x10

	applymenu hmenu
	stop

//メッセージの処理
*OnCommand
	cmd = wparam & 0xFFFF
	switch cmd
		case CMD_A	// メニューAは使用不可
		case CMD_QUIT
			dialog "終了が選択されました"
			end
		case CMD_B
			dialog "メニューBが選択されました"
			swbreak
		case CMD_D
			dialog "メニューDが選択されました"
			swbreak
	swend
	return

%href
newmenu
applymenu
%index
applymenu
メニューをウィンドウに割り当てる

%prm
p1
p1 : メニューハンドル

%inst
newmenuで作成したメニューを現在選択されているウィンドウに割り当てます。必ずメニュー作成終了後に実行してください。

%sample
// newmenuのサンプルスクリプトを参照

%href
addmenu
newmenu
%index
newmenu
新しいメニューハンドルを取得する

%prm
p1, p2
p1 : 結果を格納する変数名
p2 : 種類の指定

%inst
新しくメニューを作成し、そのハンドルをp1へ代入します。
p2で作成するメニューの種類を指定します。0ならばメニュー項目用、1ならばポップアップ項目用のメニューが作成されます。

%sample
#include "mod_menu.as"
#define CMD_QUIT 1
	oncmd gosub *OnCommand, WM_COMMAND	//  メッセージ割り込み
	// サブメニュー作成
	newmenu hsubmenu, 1
	addmenu hsubmenu, "終了(&Q)", CMD_QUIT
	// トップメニュー作成
	newmenu hmenu, 0
	addmenu hmenu, "メニュー(&M)", hsubmenu, 0x10

	applymenu hmenu
	stop

//メッセージの処理
*OnCommand
	cmd = wparam & 0xFFFF
	if cmd == CMD_QUIT : end
	return

%href
addmenu
applymenu
