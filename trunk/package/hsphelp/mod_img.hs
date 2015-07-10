%group
画面制御命令
%ver
3.3
%type
ユーザー拡張命令
%note
mod_img.asをインクルードすること。
%author
onitama
%dll
mod_img
%port
Win
%date
2009/08/01
%index
imgload
画像ファイル読み込み

%prm
"ファイル名"
"ファイル名" : 読み込むファイル名

%inst
ImgCtxを利用して画像ファイルを読み込みます。
BMP,JPEG,GIF,ICO,PNG形式の画像ファイルに対応しています。

picloadとは異なり、ウィンドウのリサイズは行われませんので注意してください。
また、パックされたファイルは読み込めません。

%sample
#include "mod_img.as"
	chdir dir_exe + "/docs"
	imgload "hsp3ttl.jpg"
	stop

%href
picload

