;
;	HSP help manager用 HELPソースファイル
;	(先頭が「;」の行はコメントとして処理されます)
;

%type
拡張命令
%ver
3.3
%note
llmod3.hsp,scrsvr.hspをインクルードする
(Windows9xのみ利用可能です)

%date
2009/08/01
%author
tom
%dll
llmod3
%url
http://www5b.biglobe.ne.jp/~diamond/hsp/hsp2file.htm


%index
ss_running
スクリーンセーバーが作動しているかシステムに知らせる
%group
OSシステム制御命令
%prm
n1
n1 : 作動しているか、いないかのフラグ

%inst
スクリーンセーバーが作動しているかシステム(Windows)に知らせます。
n1に1を代入すると、システム(Windows)にスクリーンセーバーが作動中であることを知らせます。
n1に0を代入すると、スクリーンセーバーは作動してない、とシステムに知らせます。
^
※ n1を1にしてこの命令を実行すると、ALT+CTRL+DEL,ALT+TAB,winボタンなどのキーが効かなくなります。
n1を1にしてこの命令を実行したら、必ずn1を0にしてもう一度この命令を実行してください。
^
この命令を呼び出した後のstatの値
0         エラー
0以外     エラー無し




%index
ss_chkpwd
Windows標準のパスワードチェックダイアログ
%group
OSシステム制御命令
%inst
Windows標準のパスワードチェックダイアログを呼び出します。
ただし、コントロールパネルの'画面のプロパティ'で'ﾊﾟｽﾜｰﾄﾞによる保護'がチェックされている場合のみです。
^
この命令を呼び出した後のstatの値
0         キャンセルされた
0以外     正確なパスワードが入力された
         ('ﾊﾟｽﾜｰﾄﾞによる保護'がチェックされていない場合も含む)




%index
ss_chgpwd
Windows標準のパスワード変更ダイアログ
%group
OSシステム制御命令
%inst
Windows標準のパスワード変更ダイアログを呼び出します。
^
この命令を呼び出した後のstatの値
0       パスワードが変更された
0以外   キャンセルされた

%href
ss_chkpwd

