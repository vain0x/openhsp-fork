;
;	HSP help manager用 HELPソースファイル
;	(先頭が「;」の行はコメントとして処理されます)
;

%type
拡張命令
%ver
3.3
%note
llmod3.hsp,winver.hspをインクルードする

%date
2009/08/01
%author
tom
%dll
llmod3
%url
http://www5b.biglobe.ne.jp/~diamond/hsp/hsp2file.htm


%index
winver
Windowsのバージョン取得
%group
その他の命令
%prm
v1
v1 : バージョンを受け取るための数値変数

%inst
ウィンドウズのバージョンを取得します。
変数には以下の値が入ります。
^p
v.0     プラットフォーム
  0     Windows 3.1
  95    Windows 95
  98    Windows 98
  100   Windows Me
  $100  Windows NT 3.5
  $101  Windows NT 4.0
  2000  Windows 2000
  2001  Windows XP
v.1    メジャーバージョン
v.2    マイナーバージョン
v.3    ビルドナンバー
v.4    メジャー&マイナーバージョン(プラットフォームが Windows 95,98,Meの時のみ)
^p
%sample
	winver ver : s = refstr
	if ver<100  : v = ""+ver
	if ver=100  : v = "Me"
	if ver=$100 : v = "NT 3.5"
	if ver=$101 : v = "NT 4.0"
	if ver=2000 : v = "2000"
	if ver=2001 : v = "XP"
	mes "platform = Windows "+v
	mes "メジャーバージョン = "+ver.1
	mes "マイナーバージョン = "+ver.2
	mes "ビルドナンバー = "+ver.3
	if ver<=100 : mes "メジャー&マイナーバージョン"+ver.4
	mes "szCSDVersion:"+s






%index
verinfo
バージョン情報取得
%group
その他の命令
%prm
"s1",n2
s1 : ファイル名
n2 : 取得するタイプ

%inst
s1で指定したファイルから、バージョン情報を取得します。
s1にはdllやexeなどのバイナリファイルを指定します。
refstrにバージョン情報が代入されます。
^
16bitファイルからはバージョンを取得できません。
エラーが起きた場合はstatに1が代入されます。
^
^p
n2の値   取得するもの
0        会社名
1        ファイルの説明
2        ファイルバージョン
3        内部ファイル名
4        著作権
5        もとのファイル名
6        製品名
7        製品バージョン
^p

%sample
	#include "llmod3.hsp"
	#include "winver.hsp"
^
	file="user32.dll"   : gosub get_verinfo
	file="comctl32.dll" : gosub get_verinfo
	stop
^
*get_verinfo
	s=windir+"\\system\\"+file
	mes "●ファイル"+s+"のバージョン情報"
	repeat 8
		verinfo s,cnt
		mes refstr
	loop
	return


