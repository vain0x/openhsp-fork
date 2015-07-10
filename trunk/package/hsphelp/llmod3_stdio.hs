;
;	HSP help manager用 HELPソースファイル
;	(先頭が「;」の行はコメントとして処理されます)
;

%type
拡張命令
%ver
3.3
%note
llmod3.hspをインクルードする。必要に応じてabout.hsp,msgdlg.hsp,multiopen.hsp,console.hsp,unicode.hsp,dragdrop.hsp,input.hspをインクルードする

%date
2009/08/01
%author
tom
%dll
llmod3
%url
http://www5b.biglobe.ne.jp/~diamond/hsp/hsp2file.htm


%index
about
プログラムのバージョンを表示するダイアログを作成
%group
拡張入出力制御命令
%prm
"s1","s2"
s1 : アプリケーション名が入った文字列変数または文字列
s2 : 製作者名が入った文字列変数または文字列

%inst
プログラムのバージョンを表示する時などに使われるダイアログを表示します。
アプリケーション名s1を"my.exeのﾊﾞｰｼﾞｮﾝ情報#my.exe ver 1.00"
のように#で区切ると'Microsoft my.exe ver 1.00'という表示が加わります。


%index
msgdlg
拡張dialog(type 0～3 )
%group
オブジェクト制御命令
%prm
"s1","s2",n3,n4
s1 : メッセージが入った文字列変数または文字列
s2 : タイトルが入った文字列変数または文字列
n3 : タイプ
n4 : アイコンタイプ

%inst
HSPのdialog命令の拡張版です。
^p
タイプ
 0 Ok
 1 Ok ｷｬﾝｾﾙ
 2 中止　再試行　無視
 3 はい　いいえ　ｷｬﾝｾﾙ
 4 はい　いいえ
 5 再開試行 ｷｬﾝｾﾙ
^
アイコンタイプ
 0 アイコン無し
 1 エラー(x)
 2 クエスチョンマーク(?)
 3 警告(!)
 4 情報(i)
 5 EXEが持っているアイコン
^
この命令を呼び出した後のstatの値
値 選択されたボタン
 1 Ok
 2 ｷｬﾝｾﾙ
 3 中止
 4 再試行
 5 無視
 6 はい
 7 いいえ
-1 エラー発生
^p
タイプに以下の値を加えるとデフォルトボタンが変えられます。
    0       ボタン1
    $100    ボタン2
    $200    ボタン3
アイコンタイプに以下の値を加えるとビープ音が変えられます。
    0       高い音(ノーマル)
    $100    警告音

%sample
msgdlg "今日はここで終了しますか？","プログラムの終了",3,5
if stat=6 : dialog "はい　が選択されました"
if stat=7 : dialog "いいえ　が選択されました"
if stat=2 : dialog "ｷｬﾝｾﾙ　が選択されました"


%index
multiopen
複数のファイル名を取得
%group
オブジェクト制御命令
%prm
v1,v2,n3,n4
v1 : 選択されたファイル名を受け取るための変数
v2 : 情報
n3 : フィルタのインデックス(1から)
n4 : Read Onlyボックスを付ける

%inst
HSPのdialog(type 16,17)で複数のファイルを選択できるようにしたものです。
multiopen呼び出し時に、v1.0,v1.1にそれぞれv1,v2のサイズを代入しておきます。
v2には例のような形式でフィルタを代入します。
n3を省略、またはマイナスの値を使ったときの動作は備考参照。
n4を1にするとReadOnlyボックスを付けます。2にするとReadOnlyボックスをチェックした状態にします。
^
この命令を呼び出した後のstatの値
^p
0 キャンセルされた
1 ファイルが選択されてOKボタンが押された
2 ファイルが選択されてOKボタンが押された(ReadOnlyがチェックされている。ただし複数選択されていない場合のみ)
^p
p3を0(省略)にしてp1,p2に文字列を入れるとp1がタイトルになり、p2は初期フォルダになります。
p3をマイナス値にすると保存するファイル名を得るときに使うことができます。(ただし複数選択はできません)
^
複数のファイルが選択されたかはnotesel,notemaxを使って調べます。
ファイルが一つしか選択されなかった場合、p1にはファイル名のフルパスが代入され、p2にはファイルの拡張子が代入されます。
ファイルが複数選ばれた場合は、p1にnotegetで取得できる形式でファイル名が複数入っていて、p2には選択されたファイルがあるフォルダが代入されます。(p1のファイル名は'\r'($0d)で区切られています。)

%sample
	buf_size=512 : info_size=128
	alloc buf,buf_size
	alloc info,info_size
^
	buf="ﾌｧｲﾙを開くtest title" : info="a:\\windows"
	multiopen buf,info

	buf=buf_size
	buf.1=info_size
	info="HSP2 ｽｸﾘﾌﾟﾄﾌｧｲﾙ(*.hsp)|*.hsp|ﾃｷｽﾄﾌｧｲﾙ(*.txt)|*.txt|全てのﾌｧｲﾙ|*.*|"
	multiopen buf,info,1
	if stat=0 : mes "キャンセルされました" : else {
		notesel buf
		notemax mx
		mes "選択されたファイル数 "+mx
		repeat mx
			noteget a,cnt
			mes a
		loop
		if mx=1 : mes "拡張子は"+info : else mes "フォルダ "+info
	}


%index
console_end
コンソールウィンドウを閉じる
%group
命令概要
%inst
コンソールウィンドウを閉じます。
%href
console



%index
console
コンソールウィンドウを作成
%group
命令概要
%inst
コンソールウィンドウを作成します。

%href
console_end
gets
puts
console_color
console_pos




%index
puts
コンソールに文字列を書き込む
%group
命令概要
%prm
v1
v1 : コンソールに表示する文字列が入った文字列変数

%inst
コンソールに文字列を表示します。
(putzを使うとv1に直接文字列を使用することができます。)

%href
gets
console




%index
gets
コンソールから文字列を読み込む
%group
命令概要
%prm
v1,n2
v1 : コンソールからの文字列を取得する変数
n2 : 取得する文字の数

%inst
コンソールから文字列を取得します。
n2を省略したときの値は63です。

%href
puts
console




%index
console_color
コンソールのテキストの色設定
%group
命令概要
%prm
n1
n1 : コンソールの文字列の色

%inst
コンソールに表示する文字列の色を設定します。
n1は以下の値を組み合わせて使います。1+4だと紫になります。
1+4+8で明るい紫になります。
^
^p
n1の値  色
1       青
2       緑
4       赤
8       強調
$10     青(背景)
$20     緑(背景)
$40     赤(背景)
$80     強調(背景)
^p

%href
puts
console



%index
console_pos
コンソールの文字表示位置設定
%group
命令概要
%prm
n1,n2
n1 : x座標
n2 : y座標

%inst
文字列を表示する座標を設定します。

%href
puts
console


%index
to_uni
Unicodeへ変換
%group
文字列操作命令
%prm
v1,v2,n3
v1 : Unicodeを格納する変数
v2 : Unicodeに変換する文字列変数
n3 : Unicodeに変換する文字列の長さ

%inst
ANSI文字列(SJIS)をUNICODEに変換します。
^
この命令を呼び出した後、statにバッファに書き込まれたUnicode文字の数が代入されます。
0ならエラーです。
^
unicode呼び出し後にstatに入る値の'バッファに書き込まれたUnicode文字の数'は、1バイト(半角)文字は1文字､2バイト(全角)文字も1文字と数えます。
例えば
	s="abcあいう"
をすべてUnicodeに変換したあとのstat値は6+1(*注 +1は最後の文字列終結文字ぶん)。となります。
^
n3を-1にすると指定した文字列全てを変換します。
n3を0にするとUnicodeを格納するのに必要な変数のサイズを返します。(バイト単位)

%href
from_uni

%sample
	s="Unicodeに変換する文字列"
	strlen sl,s
	;alloc buf,(sl+1)*2	;この場合(sl+1)*2が64に満たないのでallocは必要ない
	to_uni buf,s,sl+1
	usize=stat
	if usize=-1 : dialog "エラーが発生しました"
	if usize=0 : dialog "変換が失敗しました"
	if usize>0 : bsave "unicode.dat",buf,usize*2




%index
from_uni
UnicodeからANSIに変換
%group
文字列操作命令
%prm
v1,v2,n3
v1 : Multibyteを格納する変数
v2 : Multibyteに変換するUnicode文字列が入っている変数
n3 : Multibyteに変換するUnicode文字列の長さ

%inst
UNICODEをANSI文字列に変換します。
^
この命令を呼び出した後、statにバッファに書き込まれたMultibyte文字の数が代入されます。
0ならエラーです。
^
この命令を呼び出した後のstatの値、'バッファに書き込まれたMultibyte文字の数'は1バイト(半角)文字は1文字､2バイト(全角)文字は2文字と数えます。
^
'Multibyteに変換するUnicode文字列の長さ'を-1にすると全て変換します。
'Multibyteに変換するUnicode文字列の長さ'を0にするとMultibyteを格納するのに必要な変数のサイズを返します。(バイト単位)

%href
to_uni

%sample
	exist "unicode.dat"
	bload "unicode.dat",uni,strsize
	buf=""
	from_uni buf,uni,-1
	mbsize=stat
	if mbsize=-1 : dialog "エラーが発生しました"
	if mbsize=0 : dialog "変換が失敗しました"
	if mbsize>0 : dialog buf


%index
dd_accept
ドラッグ&ドロップをできるようにする
%group
命令概要
%prm
v1,v2,n3
v1 : ドラッグ&ドロップされたファイル名を入れる変数
v2 : ドラッグ&ドロップされたファイル数を入れる変数
n3 : ウィンドウID
%inst
n3で指定したウィンドウにドラッグ&ドロップ(以下D&D)をできるようにします。
ただし、ウィンドウID 1は設定できません。
dd_acceptを実行した後、ウィンドウにファイルがD&Dされるとv1で指定した変数にD&Dされたファイル名が入ります。
v2にはD&Dされたファイルの数、D&Dされた座標、ウィンドウIDが代入されます。
^
D&Dされたファイル名は"\n"で区切られています(D&Dされたファイルが1つの場合でも)。
1つのファイル名を取り出したいときはノートパッド命令を使うと便利です。
^
dd_accept実行後は、v1,v2に設定した変数はalloc,dim,sdimなどに使用しないで下さい。

%href
dd_reject
%sample
	#include "llmod3.hsp"
	#include "dragdrop.hsp"
^
	alloc buf,1024*64	;ドラッグ&ドロップされたファイル名を入れる変数
	dd_accept buf,a
^
*@
	wait 1
	if a {
		cls
		pos 0,0
		mes "ドラッグ&ドロップされたファイル数:"+a
		mes "ドラッグ&ドロップされたファイル位置 x:"+a.1+" y:"+a.2
		mes "ドラッグ&ドロップされたウィンドウID :"+a.3
		mes buf
		a=0		; aをリセットしてください
	}
	goto @b




%index
dd_reject
ドラッグ&ドロップをできないようにする
%group
拡張入出力制御命令
%prm
n1,n2
n1 : ウィンドウID
n2 : フラグ
%inst
ドラッグ&ドロップをできないようにします。
dd_acceptを実行していない場合には効果がありません。
n2を1にするともう一度ドラッグ&ドロップをできるようにします。
%href
dd_accept



%index
keybd_event
キーボード操作
%group
拡張入出力制御命令
%prm
n1,n2,n3
n1 : キーコード
n2 : キーを放すフラグ
n3 : オプション

%inst
キーボード操作を行います。
n1に押したいキーのキーコードを指定します。
n2を0にしてこの命令を実行するとn1を前回実行したときと同じキーコード、
n2を1にしてもう一度この命令を実行しないとキーを放したことになりません。
n2を-1にすると押して放したことになります。
n3のオプションはスクリーンショットキーを押すときに使用します。n3を0にするとフルスクリーン、1にするとアクティブなウィンドウがクリップボードにコピーされます。
^
keybd_eventは他のプログラムのウィンドウがアクティブな場合でも実行されます。
^
<>キーコード
キーコードはgetkeyで使用するものと同じです。
ほかにも以下のようなものがあります。
^p
n1の値
44       スクリーンショット
45       INS
46       DEL
106      テンキーの'*'
107      テンキーの'+'
108      テンキーの','
109      テンキーの'-'
110      テンキーの'.'
111      テンキーの'/'
^p
%sample
	#include "llmod3.hsp"
	#include "input.hsp"
^
	exec "notepad"
	s="ABCDEFG" : strlen L,s
^
	repeat L
		peek c,s,cnt
		keybd_event c,-1
	loop
^
	keybd_event 18,-1	;ALT
	keybd_event 'F',-1	;ﾌｧｲﾙ(F)
	keybd_event 'O',-1	;開く(O)
^
	keybd_event 'N',-1	;セーブ確認ダイアログのいいえ(N)
^
	s="INPUTnAS" : strlen L,s	;'n'はキーコードで'.'(110)を表す
^
	;ここのコメントを外すとSHIFTを押したことになり大文字になります
	;keybd_event 16
^
	repeat L
		peek c,s,cnt
		keybd_event c,-1
	loop
^
	;上のコメントを外したときはここのコメントも外してください
	;keybd_event 16,1
^
	keybd_event 13,-1	;ENTER
^
	stop



%index
mouse_event
マウス操作
%group
拡張入出力制御命令
%prm
n1,n2,n3
n1 : 操作タイプ
n2 : 水平方向の移動量
n3 : 垂直方向の移動量

%inst
マウス操作を行います。
n1に指定するタイプでマウス操作を行うことができます。
水平方向の移動量は、画面左から右へ移動させるときが正、その逆が負
垂直方向の移動量は、画面上から下へ移動させるときが正、その逆が負
であることに注意してください。
^
mouse_eventはHSPのプログラムがアクティブでないときでもマウス操作に影響します。
^
<>操作タイプ
n1の値は以下のものを組み合わせて使用することができます。
^p
n1の値
$1       マウス移動
$2       左のボタンを押す
$4       左のボタンを放す
$8       右のボタンを押す
$10      右のボタンを放す
$20      中のボタンを押す
$40      中のボタンを放す
^p
%sample
	#include "llmod3.hsp"
	#include "input.hsp"
^
*lp
	movx=0 : movy=0
	getkey k,37 : if k : movx-	;←キー
	getkey k,38 : if k : movy-	;↑キー
	getkey k,39 : if k : movx+	;→キー
	getkey k,40 : if k : movy+	;↓キー
^
	;SHIFTが押されたら左ボタンを押す
	getkey kSHIFT,16 : if kSHIFT : Lbtn=$2 : else Lbtn=0
	mouse_event $1+Lbtn, movx, movy
^
	;SHIFTを押すとマウスの左ボタンを押したことになりkが1になる
	getkey k,1 : if k : pset mousex,mousey
^
	;SHIFTが押されてたら左ボタンを放す
	if kSHIFT : mouse_event $4
^
	await 1
	goto lp

