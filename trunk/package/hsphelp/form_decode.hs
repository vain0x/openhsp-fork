%dll
form_decode

%ver
3.3

%date
2009/08/01

%author
onitama

%url
http://hsp.tv/

%note
form_decode.asをインクルードすること。

%type
ユーザー定義命令

%group
文字列操作命令

%port
Win
Cli
Let
%index
form_decode
テキストをデコード

%prm
p1, p2, p3
p1=変数 : 変換結果を格納する文字列型変数
p2=変数 : 変換する文字列を代入した文字列型変数
p3=0～(0) : 変換スイッチ(0)

%inst
送信用にエンコードされたテキストを元の日本語にデコードします。

p3を1にすると'&'を改行に変換し、2にすると'+'を空白に変換します。
3にすると両方変換します。

文字コードの変換は行いませんので、文字コード変換が必要な場合はデコード後に行う必要があります。

%sample
#include "form_decode.as"
#include "encode.as"
	// ウィキペディアの「ウィキペディア」に関するページのURL
	before = "http://ja.wikipedia.org/wiki/%E3%82%A6%E3%82%A3%E3%82%AD%E3%83%9A%E3%83%87%E3%82%A3%E3%82%A2"

	// デコードの実行
	result = ""
	form_decode result, before

	// 結果の表示（UTF-8をシフトJISへ変換）
	mes utf8n2sjis(result)
	stop
