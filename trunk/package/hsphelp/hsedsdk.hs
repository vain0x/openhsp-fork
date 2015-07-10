%dll
hsedsdk

%ver
3.3

%date
2009/08/01

%author
onitama

%url
; 関連 URL を記入

%note
hsedsdk.asをインクルードすること。

%type
ユーザー拡張命令

%port
Win

%group
HSPスクリプトエディタ 外部ツール作成用

%index
hsed_exist
HSPスクリプトエディタの起動状態を取得

%inst
HSPスクリプトエディタが起動しているかチェックします。
起動していれば1が、起動していなければ0がシステム変数statに代入されます。

%sample
#include "hsedsdk.as"
	hsed_exist
	if ( stat ) {
		mes "HSPスクリプトエディタが起動しています。"
	} else {
		mes "HSPスクリプトエディタは起動していません。"
	}
	stop

%group
情報取得命令

%index
hsed_capture
HSPスクリプトエディタのAPIウィンドウを捕捉

%inst
hsedsdkモジュール内の変数hIFにHSPスクリプトエディタのAPIウィンドウのハンドルを代入します。
^
取得に成功した場合はシステム変数statに0が代入されます。
^
この命令はhsedsdk.as内で利用される命令であり、通常は利用する必要はありません。

%group
ハンドル取得命令

%href
hsed_getwnd
%index
hsed_gettext
編集中のテキストを取得

%prm
p1, p2
p1 : テキストを代入する変数
p2 : 取得したいFootyのID

%inst
HSPスクリプトエディタで編集しているテキストを取得し、p1に代入します。
^
取得に成功した場合はシステム変数statに0が代入されます。

%sample
#include "hsedsdk.as"
	nTabID = 0
	hsed_getfootyid nFootyID, nTabID
	if ( stat == 0 ) : hsed_gettext buf, nFootyID
	mesbox buf, ginfo_winx, ginfo_winy
	stop

%href
hsed_settext

%group
テキスト取得命令
%index
hsed_sendstr
文字列を貼り付け

%prm
p1
p1 : スクリプトに挿入する文字列を格納した文字列型変数

%inst
編集中のテキストにp1に格納した文字列を貼り付けます。

%sample
#include "hsedsdk.as"
	sIns = "スクリプトエディタに送る文字列"
	hsed_sendstr sIns

%href
hsed_settext

%group
テキスト編集命令
%index
hsed_cancopy
コピーの可否を取得

%prm
p1, p2
p1 : 結果を格納する変数
p2 : FootyのID

%inst
コピーの可否を取得します。
指定されたFootyからクリップボードにコピーすることができる場合はp1に1が返ります。
^
実際にコピーや切り取りを行う場合はhsed_copyまたはhsed_cutを利用してください。

%sample
#include "hsedsdk.as"
	hsed_gettabcount nTabs
	if ( stat ) {
		dialog "HSPエディタが見つかりません。", 1
		end
	}
	repeat nTabs
		hsed_getfootyid idFooty, cnt
		hsed_cancopy ret, idFooty
		if ( ret ) {
			mes "ID" + str( cnt ) + "のタブはコピーできます。"
		} else {
			mes "ID" + str( cnt ) + "のタブはコピーできません。"
		}
	loop
	stop

%group
情報取得命令

%href
hsed_copy
hsed_cut
hsed_canpaste
%index
hsed_cut
指定したFootyから文字列を切り取る

%prm
p1
p1 : 文字列を切り取るFootyのID

%inst
指定したFootyへ文字列をクリップボードに切り取るよう要請します。
切り取りが行えるかどうかはhsed_cancopyで調べてください。

%sample
#include "hsedsdk.as"
	hsed_gettabcount nTabs
	if ( stat ) {
		dialog "HSPエディタが見つかりません。", 1
		end
	}
	repeat nTabs
		hsed_getfootyid idFooty, cnt
		hsed_cancopy ret, idFooty
		if ( ret ) {
			hsed_cut idFooty
			mes "ID" + str( cnt ) + "のタブから切り取りました。"
		}
	loop
	stop

%href
hsed_cancopy
hsed_copy

%group
クリップボード操作命令
%index
hsed_redo
リドゥを行う

%prm
p1
p1 : リドゥを行うFootyのID

%inst
指定したFootyに対してリドゥを行うように要請します。
リドゥが行えるかどうかはhsed_canredoで調べてください。

%sample
#include "hsedsdk.as"
	hsed_gettabcount nTabs
	if ( stat ) {
		dialog "HSPエディタが見つかりません。", 1
		end
	}
	repeat nTabs
		hsed_getfootyid idFooty, cnt
		hsed_canredo ret, idFooty
		if ( ret ) {
			hsed_redo idFooty
			mes "ID" + idFooty + "のFootyをリドゥしました。"
		} else {
			mes "ID" + idFooty + "のFootyはリドゥできませんでした。"
		}
	loop
	stop

%href
hsed_undo
hsed_canredo

%group
テキスト編集命令
%index
hsed_undo
アンドゥを行う

%prm
p1
p1 : アンドゥを行うFootyのID

%inst
指定したFootyに対してアンドゥを行うように要請します。
アンドゥが行えるかどうかはhsed_canundoで調べてください。

%sample
#include "hsedsdk.as"
	hsed_gettabcount nTabs
	if ( stat ) {
		dialog "HSPエディタが見つかりません。", 1
		end
	}
	repeat nTabs
		hsed_getfootyid idFooty, cnt
		hsed_canundo ret, idFooty
		if ( ret ) {
			hsed_undo idFooty
			mes "ID" + idFooty + "のFootyをアンドゥしました。"
		} else {
			mes "ID" + idFooty + "のFootyはアンドゥできませんでした。"
		}
	loop
	stop

%href
hsed_redo
hsed_canundo

%group
テキスト編集命令
%index
hsed_indent
インデントを行う

%prm
p1
p1 : インデントを行うFootyのID

%inst
Footyに対してインデントを行うように要請します。
インデントは選択範囲に対して行われます。

%sample
#include "hsedsdk.as"
	hsed_gettabcount nTabs
	if ( stat ) {
		dialog "HSPエディタが見つかりません。", 1
		end
	}
	repeat nTabs
		hsed_getfootyid idFooty, cnt
		hsed_selectall idFooty
		hsed_indent idFooty
	loop
	stop

%href
hsed_unindent

%group
テキスト編集命令
%index
hsed_unindent
アンインデントを行う

%prm
p1
p1 : アンインデントを行うFootyのID

%inst
Footyに対してアンインデントを行うように要請します。
アンインデントは選択範囲に対して行われます。

%sample
#include "hsedsdk.as"
	hsed_gettabcount nTabs
	if ( stat ) {
		dialog "HSPエディタが見つかりません。", 1
		end
	}
	repeat nTabs
		hsed_getfootyid idFooty, cnt
		hsed_selectall idFooty
		hsed_unindent idFooty
	loop
	stop

%href
hsed_indent

%group
テキスト編集命令
%index
hsed_uninitduppipe
パイプハンドルの解放

%inst
; 解説文 を記入

%href
hsed_initduppipe

%group
パイプ操作命令
%index
hsed_initduppipe
パイプハンドルの作成

%prm
p1
p1 : 文字列の長さ

%inst
; 解説文 を記入

%href
hsed_uninitduppipe

%group
パイプ操作命令
%index
hsed_getmajorver
メジャーバージョンを抽出

%prm
(p1)
p1 : バージョンを表す整数値

%inst
p1で指定されたバージョンからメジャー バージョンのみを抽出します。
ここで指定できる値は、hsed_getverにHGV_PUBLICVERもしくはHGV_PRIVATEVERを指定して取得したバージョンのみです。

%href
hsed_getver
hsed_getminorver
hsed_getbetaver


%group
バージョン抽出関数
%index
hsed_getminorver
マイナーバージョンを抽出

%prm
(p1)
p1 : バージョンを表す整数値

%inst
p1で指定されたバージョンからマイナー バージョンのみを抽出します。
ここで指定できる値は、hsed_getverにHGV_PUBLICVERもしくはHGV_PRIVATEVERを指定して取得したバージョンのみです。

%href
hsed_getver
hsed_getmajorver
hsed_getbetaver


%group
バージョン抽出関数
%index
hsed_getbetaver
ベータバージョンを抽出

%prm
(p1)
p1 : バージョンを表す整数値

%inst
p1で指定されたバージョンからベータ バージョンのみを抽出します。
ここで指定できる値は、hsed_getverにHGV_PUBLICVERもしくはHGV_PRIVATEVERを指定して取得したバージョンのみです。

%href
hsed_getmajorver
hsed_getminorver
hsed_getver


%group
バージョン抽出関数
%index
hsed_getver
スクリプトエディタのバージョンを取得

%prm
p1, p2
p1 : 結果を格納する変数
p2 : バージョンの種類を指定するための整数値

%inst
p2で指定された種類のエディタのバージョンを取得し、p1に代入します。
取得に失敗した場合は、原則としてp1に-1を代入します。ただし、p2にHGV_HSPCMPVERが指定されていた場合は、"Error"を代入します。
^
statに代入される値は以下の通りです。
0: 取得に成功
1: エディタが見つからなかった
2: パイプが作れなかった
3: エディタが正しい値を返せなかった(p2が正しくない場合含む)
^
p2に指定する値は以下の通りです。HGV_で始まる定数を用いても、括弧内の数字を用いても構いません。
html{
<table border="1"><tr><th>HGV_PUBLICVER(0)</th>
<td>パブリック バージョン(エディタ公開時点での次のバージョン)。
16進数で<ul><li>上4桁メジャー バージョン</li><li>5～6桁目マイナー バージョン</li><li>
7～8桁目βバージョン(βでなければ0)</li></ul>を表します。(例:Ver1.02b3→$00010203)<br />
hsed_getmajorver(), hsed_getminorver(), hsed_getbetaver()で各値を取得できます。<br />
また、hsed_cnvverstrで、文字列に変換することも可能です。</td></tr>
<tr><th>HGV_PRIVATEVER(1)</th>
<td>プライベート バージョン。HGV_PUBLICBERと同じ形式です。</td></tr>
<tr><th>HGV_HSPCMPVER(2)</th>
<td>hspcmp.dllからhsc_verで取得したバージョン(文字列)が代入されます。</td></tr>
<tr><th>HGV_FOOTYVER(3)</th>
<td>FootyからGetFootyVerで取得したバージョンが代入されます。
バージョンを100倍した数値が返ります。(例:Ver1.23→123)</td></tr>
<tr><th nowrap>HGV_FOOTYBETAVER(4)</th>
<td>FootyからGetFootyBetaVerで取得したバージョンが代入されます。
ベータ バージョンがそのまま代入されます。
ベータ バージョンではない場合は0が代入されます。</td></tr>
</table>
}html


%href
hsed_getmajorver
hsed_getminorver
hsed_getbetaver

%group
情報取得命令
%index
hsed_getwnd
スクリプトエディタの各種ハンドルを取得

%prm
p1, p2, p3

%inst
p2で指定された種類のエディタのウィンドウ ハンドルを取得し、p1に代入します。
p2でHGW_EDITを指定した場合は、p3でFootyのIDを指定する必要があります。
取得に失敗した場合は、p1に0を代入します。

statに代入される値は以下の通りです。
0: 取得に成功
1: エディタが見つからなかった
2: エディタが正しい値を返せなかった(p2が正しくない場合含む)

p2に指定する値は以下の通りです。HGW_で始まる定数を用いても、括弧内の数字を用いても構いません。
HGW_MAIN(0): メイン ウィンドウ
HGW_CLIENT(1): クライアント ウィンドウ
HGW_TAB(2): タブ ウィンドウ
HGW_EDIT(3): Footy ウィンドウ
HGW_TOOLBAR(4): ツールバー
HGW_STATUSBAR(5): ステータスバー

%href
hsed_capture

%group
ハンドル取得命令
%index
hsed_cnvverstr
バージョンの数値を文字列に変換

%prm
p1
p1 : バージョンを表す整数値

%inst
p1で指定されたバージョンを文字列に変換し、refstrに代入します。"(メジャーバージョン).(マイナーバージョン)"の形式です。ただし、ベータバージョンの場合は末尾に"b(ベータバージョン)"が加えられます。
ここで指定できる値は、hsed_getverにHGV_PUBLICVERもしくはHGV_PRIVATEVERを指定して取得したバージョンのみです。

%group
バージョン変換命令

%index
hsed_selectall
テキストをすべて選択

%prm
p1
p1 : テキストを選択するFootyのID

%inst
Footyに対してテキストをすべて選択するように要請します。

%sample
#include "hsedsdk.as"
	hsed_gettabcount nTabs
	if ( stat ) {
		dialog "HSPエディタが見つかりません。", 1
		end
	}
	repeat nTabs
		hsed_getfootyid idFooty, cnt
		hsed_selectall idFooty
	loop
	stop

%group
テキスト編集命令
%index
hsed_gettextlength
テキストの文字列長を取得

%prm
p1, p2
p1 : 文字列長を代入する変数
p2 : 文字列長を取得するFootyのID

%inst
テキストの文字列長を取得し、p1へ代入します。

%sample
#include "hsedsdk.as"
	hsed_gettabcount nTabs
	if ( stat ) {
		dialog "HSPエディタが見つかりません。", 1
		end
	}
	repeat nTabs
		hsed_getfootyid idFooty, cnt
		hsed_gettextlength lText, idFooty
		mes "ID" + idFooty + "のFootyの文字列長は" + lText + "です。"
	loop
	stop

%href
hsed_getlinelength

%group
情報取得命令
%index
hsed_getlines
テキストの行数を取得

%prm
p1, p2
p1 : 行数を代入する変数
p2 : 行数を取得するFootyのID

%inst
テキストの行数をp1に代入します。コメント行や空行も1行としてカウントされます。

%sample
#include "hsedsdk.as"
	hsed_gettabcount nTabs
	if ( stat ) {
		dialog "HSPエディタが見つかりません。", 1
		end
	}
	lText = ""
	repeat nTabs
		hsed_getfootyid idFooty, cnt
		hsed_getlines nLines, idFooty
		mes "ID" + idFooty + "のFootyの行数は" + nLines + "です。"
	loop
	stop


%href
hsed_getlinelength

%group
情報取得命令
%index
hsed_getlinelength
行の文字列長を取得

%prm
p1, p2, p3
p1 : 文字列長を代入する変数
p2 : 文字列長を取得するFootyのID
p3 : 文字列長を取得する行の番号（1～）

%inst
テキストのp3行目の文字列長を取得し、p1へ代入します。

%sample
#include "hsedsdk.as"
	hsed_gettabcount nTabs
	if ( stat ) {
		dialog "HSPエディタが見つかりません。", 1
		end
	}
	repeat nTabs
		hsed_getfootyid idFooty, cnt
		hsed_getlinelength lLine, idFooty, 1
		mes "ID" + idFooty + "のFootyの1行目の文字列長は" + lLine + "です。"
	loop
	stop

%href
hsed_getlines
hsed_gettextlength

%group
情報取得命令
%index
hsed_getlinecode
改行コードを取得

%prm
p1, p2

%inst
; 解説文 を記入

%href
; 関連項目 を記入

%group
情報取得命令
%index
hsed_copy
指定したFootyから文字列をコピー

%prm
p1
p1 : 文字列をコピーするFootyのID

%inst
指定したFootyへ文字列をクリップボードにコピーするよう要請します。
コピーが行えるかどうかはhsed_cancopyで調べてください。

%sample
#include "hsedsdk.as"
	hsed_gettabcount nTabs
	if ( stat ) {
		dialog "HSPエディタが見つかりません。", 1
		end
	}
	repeat nTabs
		hsed_getfootyid idFooty, cnt
		if ( stat == 0 ) {
			hsed_cancopy ret, idFooty
			if ( ret ) {
				hsed_copy idFooty
				mes "ID" + str( cnt ) + "のタブからコピーしました。"
			}
		}
	loop
	stop

%href
hsed_cancopy
hsed_cut

%group
クリップボード操作命令
%index
hsed_paste
指定したFootyへ文字列を貼り付け

%prm
p1
p1 : 文字列を貼り付けるFootyのID

%inst
指定したFootyへ文字列をクリップボードから貼り付けるよう要請します。
貼り付けが行えるかどうかはhsed_canpasteで調べてください。

%sample
#include "hsedsdk.as"
	hsed_gettabcount nTabs
	if ( stat ) {
		dialog "HSPエディタが見つかりません。", 1
		end
	}
	hsed_canpaste ret
	if ( ret ) {
		repeat nTabs
			hsed_getfootyid idFooty, cnt
			if ( stat == 0 ) {
				hsed_paste idFooty
				mes "ID" + str( cnt ) + "のタブへ貼り付けました。"
			}
		loop
	} else {
		mes "貼り付けできません。"
	}
	stop
%href
hsed_canpaste


%group
クリップボード操作命令
%index
hsed_canpaste
貼り付けの可否を取得

%prm
p1
p1 : 結果を格納する変数

%inst
貼り付けの可否を取得します。
クリップボードから貼り付けすることができる場合はp1に1が返ります。
^
実際に貼り付けを行う場合はhsed_pasteを利用してください。

%sample
#include "hsedsdk.as"
	hsed_gettabcount nTabs
	if ( stat ) {
		dialog "HSPエディタが見つかりません。", 1
		end
	}
	hsed_canpaste ret
	if ( ret ) {
		mes "貼り付けできます。"
	} else {
		mes "貼り付けできません。"
	}
	stop

%href
hsed_paste
hsed_cancopy

%group
情報取得命令
%index
hsed_canundo
アンドゥの可否を取得

%prm
p1, p2
p1 : 結果を格納する変数
p2 : FootyのID

%inst
指定したFootyのアンドゥの可否を取得します。
アンドゥが可能ならばp1に1が返ります。
^
実際にアンドゥを行う場合はhsed_undoを利用してください。

%sample
#include "hsedsdk.as"
	hsed_gettabcount nTabs
	if ( stat ) {
		dialog "HSPエディタが見つかりません。", 1
		end
	}
	repeat nTabs
		hsed_getfootyid idFooty, cnt
		hsed_canundo ret, idFooty
		if ( ret ) {
			hsed_undo idFooty
			mes "ID" + idFooty + "のFootyをアンドゥしました。"
		} else {
			mes "ID" + idFooty + "のFootyはアンドゥできませんでした。"
		}
	loop
	stop

%href
hsed_undo
hsed_canredo

%group
情報取得命令
%index
hsed_canredo
リドゥの可否を取得

%prm
p1, p2
p1 : 結果を格納する変数
p2 : FootyのID

%inst
指定したFootyのリドゥの可否を取得します。
リドゥが可能ならばp1に1が返ります。
^
実際にリドゥを行う場合はhsed_redoを利用してください。

%sample
#include "hsedsdk.as"
	hsed_gettabcount nTabs
	if ( stat ) {
		dialog "HSPエディタが見つかりません。", 1
		end
	}
	repeat nTabs
		hsed_getfootyid idFooty, cnt
		hsed_canredo ret, idFooty
		if ( ret ) {
			hsed_redo idFooty
			mes "ID" + idFooty + "のFootyをリドゥしました。"
		} else {
			mes "ID" + idFooty + "のFootyはリドゥできませんでした。"
		}
	loop
	stop

%href
hsed_redo
hsed_canundo

%group
情報取得命令
%index
hsed_getmodify
変更フラグを取得

%prm
p1, p2
p1 : 結果を格納する変数
p2 : FootyのID

%inst
指定したFootyの変更フラグを取得します。
変更されていればp1には1が返ります。

%sample
#include "hsedsdk.as"
	hsed_gettabcount nTabs
	if ( stat ) {
		dialog "HSPエディタが見つかりません。", 1
		end
	}
	repeat nTabs
		hsed_getfootyid idFooty, cnt
		hsed_getmodify ret, idFooty
		if ( ret ) {
			mes "ID" + idFooty + "のFootyは変更されています。"
		} else {
			mes "ID" + idFooty + "のFootyは変更されていません。"
		}
	loop
	stop

%group
情報取得命令
%index
hsed_settext
テキストを変更

%prm
p1, p2
p1 : 変更したいFootyのID
p2 : 変更するテキスト

%inst
HSPスクリプトエディタで編集中のテキストをp2に変更します。
^
変更に成功した場合はシステム変数statに0が代入されます。

%sample
#include "hsedsdk.as"
	nTabID = 0
	hsed_getfootyid nFootyID, nTabID
	if ( stat == 0 ) : hsed_settext nFootyID, "変更されたテキスト"
	stop

%href
hsed_gettext
hsed_sendstr

%group
テキスト編集命令
%index
hsed_getfootyid
タブのIDからFootyのIDを取得

%prm
p1, p2
p1 : FootyのIDを代入する変数
p2 : タブのID

%inst
; 解説文 を記入

%sample
#include "hsedsdk.as"
	hsed_gettabcount nTab
	repeat nTab
		hsed_getfootyid idFooty, cnt
		mes str( cnt ) + "番目のFootyのIDは" + idFooty + "です。"
	loop
	stop

%href
hsed_getactfootyid
hsed_gettabid
hsed_getacttabid

%group
情報取得命令
%index
hsed_gettabid
FootyのIDからタブのIDを取得

%prm
p1, p2
p1 : タブのIDを代入する変数
p2 : FootyのID

%inst
; 解説文 を記入

%href
hsed_getacttabid
hsed_getfootyid
hsed_getactfootyid

%group
情報取得命令
%index
hsed_gettabcount
タブ数の取得

%prm
p1
p1 : タブ数を代入する変数

%inst
HSPスクリプトエディタのエディタ部上部に表示されているタブ数を取得してp1に代入します。
^
取得に成功した場合はシステム変数statに0が代入されます。

%sample
#include "hsedsdk.as"
	hsed_gettabcount nTab
	if ( stat == 0 ) : mes "HSPスクリプトエディタのタブ数は" + nTab + "です。"

%group
情報取得命令
%index
hsed_getactfootyid
アクティブなFootyのIDの取得

%prm
p1
p1 : FootyのIDを代入する変数

%inst
HSPスクリプトエディタのアクティブなタブに表示されているFootyのIDを取得してp1に代入します。
^
取得に成功した場合はシステム変数statに0が代入されます。
^
取得に失敗した場合はシステム変数statに1が代入され、p1に-1が代入されます。

%sample
#include "hsedsdk.as"
	hsed_getactfootyid idFooty
	if ( stat == 0 ) : mes "アクティブなFootyのIDは" + idFooty + "です。"

%href
hsed_getacttabid
hsed_gettabid
hsed_getfootyid

%group
情報取得命令

%index
hsed_getacttabid
アクティブなタブのIDの取得

%prm
p1
p1 : タブのIDを代入する変数

%inst
HSPスクリプトエディタのアクティブなタブのIDを取得してp1に代入します。
^
取得に成功した場合はシステム変数statに0が代入されます。
^
取得に失敗した場合はシステム変数statに1が代入され、p1に-1が代入されます。

%sample
#include "hsedsdk.as"
	hsed_getactfootyid idTab
	if ( stat == 0 ) : mes "アクティブなタブのIDは" + idTab + "です。"

%href
hsed_getactfootyid
hsed_getfootyid
hsed_gettabid

%group
情報取得命令

%index
hsed_getpath
タブIDからファイルパスを取得

%prm
p1, p2
p1 : ファイルパスを代入する変数
p2 : タブのID

%inst
HSPスクリプトエディタで開いているファイルのパス名を取得し、p1に代入します。
^
取得に成功した場合はシステム変数statに0が代入されます。

%sample
#include "hsedsdk.as"
	hsed_gettabcount nTabs
	if ( stat ) {
		dialog "HSPエディタが見つかりません。", 1
		end
	}
	repeat nTabs
		hsed_getpath path, cnt
		if stat == 0 {
			mes "ID" + cnt + "のタブのファイルパスは\""+path+"\"です。"
		}
	loop
	stop

%group
情報取得命令
