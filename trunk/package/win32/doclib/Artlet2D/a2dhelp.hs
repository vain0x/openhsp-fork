;--------------------------------------------------
; Artlet2D for HSP3 help
;--------------------------------------------------

%dll
Artlet2D

%ver
1.01 R2

%date
2010/02/04

%author
S.Programs

%url
http://sprocket.babyblue.jp/

%note
a2d.hsp をインクルードしてください。

%type
ユーザー拡張命令

%port
Win

%portinfo
実行環境に GDI+ (gdiplus.dll) が必要です。



%index
alClipModeRect
クリッピングする領域を指定

%prm
px, py, pw, ph
px, py : クリッピング領域 (矩形) の左上座標 (0, 0)
pw, ph : クリッピングする矩形の幅・高さ (0, 0)

%inst
クリッピングする矩形領域を指定します。

Artlet2D の描画命令は、ここで指定した領域の中にのみ描画を行うようになります。

クリッピングモードは、alDraw～, alFill～, alCopy～ などのさまざまな描画命令に適用されます。

%href
alResetClipMode

%group
クリッピング

%index
alResetClipMode
クリッピングする領域を解除

%inst
クリッピングモードをデフォルトに戻します。

クリッピングモードは、alDraw～, alFill～, alCopy～ などのさまざまな描画命令に適用されます。

%href
alClipModeRect

%group
クリッピング



%index
alColor
描画色を設定

%prm
R, G, B, A
R, G, B	: 描画色 RGB [0-255] (0)
A	: 描画アルファ値 [0-255] (255)

%inst
Artlet2D で描画する色を設定します。

R, G, B は color 命令で指定するものと同じ、各 8bit の RGB 値です。

A には描画時のアルファ値 (透明度) を指定します。A = 0 の場合完全に透明で、255 の場合完全に不透明な色となります。A 値を省略すると、255 が与えられます。

(この命令の実行により、gsel 命令で選択された HSP スクリーンの描画色も連動して変更されます。)

%href
alHsvColor
alSysColor

%sample
#include "a2d.hsp"

	alCreateImage 0, 640, 480 ; 仮想イメージを作成
	if stat = -1 {
		dialog "GDI+ を初期化できませんでした。"
		end
	}

	alColor 255, 0, 0, 128 ; 描画色を「半透明の赤」に設定
	alFillEllip  0,  0, 100, 100
	alColor 0, 255, 0, 128 ; 描画色を「半透明の緑」に設定
	alFillEllip 30, 50, 100, 100
	alColor 0, 0, 255, 128 ; 描画色を「半透明の青」に設定
	alFillEllip 60,  0, 100, 100

	alCopyImageToScreen 0, 0 ; 仮想イメージから HSP screen に画像転送
	redraw ; HSP screen 再描画

%group
ブラシ設定



%index
alGradientColor
グラデーションブラシを設定

%prm
x1, y1, x2, y2, ARGB1, ARGB2, mode
x1, y1	: ポイント 1
x2, y2	: ポイント 2
ARGB1	: 色 1
ARGB2	: 色 2
mode	: ラップモード (0)

%inst
グラデーションブラシを設定します。

設定されるグラデーションのパターンは、ポイント (x1, y1) から ポイント (x2, y2) にかけて、色が ARGB1 から ARGB2 に変化するものとなります。

mode には、定数 WrapModeTile (= 0) と WrapModeTileFlipX (= 1) が使用できます。

ARGB 値は、R, G, B, A の値を 1 つの整数値にまとめた形式で、16 進数表記のそれぞれの桁の意味は 0xAARRGGBB となります。モジュールに内蔵のマクロ ARGB(A, R, G, B) もしくは RGBA(R, G, B, A) を使用すると、値を簡単に記述できます。

%sample
#include "a2d.hsp"

	alCreateImage 0, 640, 480 ; 仮想イメージを作成
	if stat = -1 {
		dialog "GDI+ を初期化できませんでした。"
		end
	}

	; グラデーションブラシ設定
	alGradientColor 100, 100, 400, 200, RGBA(255,0,0), RGBA(0,0,255)
	alFillEllip 100, 100, 200, 100

	alCopyImageToScreen 0, 0 ; 仮想イメージから HSP screen に画像転送
	redraw ; HSP screen 再描画

%href
alColor

%group
ブラシ設定



%index
alHsvColor
描画色を HSV で設定

%prm
H, S, V, A
H, S, V	: 描画色 HSV (0)
A	: 描画アルファ値 [0-255] (255)

%inst
Artlet2D で描画する色を HSV (色相, 彩度, 明度) で設定します。

H, S, V は hsvcolor 命令と同じフォーマットで指定します。

A には描画時のアルファ値 (透明度) を指定します。A = 0 の場合完全に透明で、255 の場合完全に不透明な色となります。A 値を省略すると、255 が与えられます。

(この命令の実行により、gsel 命令で選択された HSP スクリーンの描画色も連動して変更されます。)

%href
alColor
alSysColor

%group
ブラシ設定



%index
alSysColor
システムカラーから描画色を設定

%prm
p1, A
p1	: システムカラー No. (0)
A	: 描画アルファ値 [0-255] (255)

%inst
Artlet2D で描画する色をシステムカラーから設定します。

p1 にはシステムカラーの番号を指定します。この番号は、syscolor 命令と同じもの使用します。

A には描画時のアルファ値 (透明度) を指定します。A = 0 の場合完全に透明で、255 の場合完全に不透明な色となります。A 値を省略すると、255 が与えられます。

(この命令の実行により、gsel 命令で選択された HSP スクリーンの描画色も連動して変更されます。)

%href
alColor
alHsvColor

%group
ブラシ設定



%index
alCopyImageToImage
画像コピー (Image → Image)

%prm
sID, dID, dx, dy, w, h, sx, sy
sID	: コピー元 Image ID
dID	: コピー先 Image ID
dx, dy	: コピー先矩形 左上座標 (0)
w, h	: コピー矩形 幅・高さ (9999)
sx, sy	: コピー元矩形 左上座標 (0)

%inst
コピー元 Image ID からコピー先 Image ID へ、画像をコピーします。

座標を示す引数を省略した場合は、コピー先、コピー元とも座標 0, 0、画像全域 (最大 9999, 9999) がコピーされます。

Image ID と HSP スクリーン間の画像転送については、alCopyImageToScreen, alCopyScreenToImage を参照してください。

%href
alCopyImageToScreen
alCopyScreenToImage

%group
コピー・ズーム



%index
alCopyImageToScreen
画像コピー (Image → HSP screen)

%prm
sID, dID, dx, dy, w, h, sx, sy
sID	: コピー元 Image ID
dID	: コピー先 HSP スクリーン ID
dx, dy	: コピー先矩形 左上座標 (0)
w, h	: コピー矩形 幅・高さ (9999)
sx, sy	: コピー元矩形 左上座標 (0)

%inst
コピー元 Image ID からコピー先 HSP スクリーン ID へ、画像をコピーします。

座標を示す引数を省略した場合は、コピー先、コピー元とも座標 0, 0、画像全域 (最大 9999, 9999) がコピーされます。

%href
alCopyImageToImage
alCopyScreenToImage

%group
コピー・ズーム



%index
alCopyScreenToImage
画像コピー (HSP screen → Image)

%prm
sID, dID, dx, dy, w, h, sx, sy
sID	: コピー元 HSP スクリーン ID
dID	: コピー先 Image ID
dx, dy	: コピー先矩形 左上座標 (0)
w, h	: コピー矩形 幅・高さ (9999)
sx, sy	: コピー元矩形 左上座標 (0)

%inst
コピー元 HSP スクリーン ID からコピー先 Image ID へ、画像をコピーします。

座標を示す引数を省略した場合は、コピー先、コピー元とも座標 0, 0、画像全域 (最大 9999, 9999) がコピーされます。

%href
alCopyImageToImage
alCopyImageToScreen

%group
コピー・ズーム



%index
alCopyModeAlpha
半透明コピーモードを設定

%prm
p1
p1	: アルファ値 [0.0-1.0] double

%inst
画像コピー時に半透明でコピーするように設定します。

透明度は、パラメータ p1 で設定します。p1 が 0.0 の場合は完全に透明で、1.0 の場合は完全に不透明になります。

設定したコピーモードは、下記の命令に適用されます。

alCopyImageToImage
alCopyImageToScreen
alCopyScreenToImage
alStretchImageToImage
alStretchImageToScreen
alStretchScreenToImage

目的の処理が完了したら、alResetCopyMode 命令でデフォルトのコピーモードに戻すことができます。

コピーモードは、描画先の HSP Screen ID, 仮想イメージ ID を問わずに適用されます。

%sample
; サンプルスクリプト を記入

%href
alResetCopyMode

%group
コピーモード



%index
alResetCopyMode
コピーモードをリセット

%inst
画像コピーモードをデフォルト状態に戻します。

コピーモードは、下記の命令に適用されます。

alCopyImageToImage
alCopyImageToScreen
alCopyScreenToImage
alStretchImageToImage
alStretchImageToScreen
alStretchScreenToImage

コピーモードは、描画先の HSP Screen ID, 仮想イメージ ID を問わずに適用されます。

%href
alCopyModeColorMatrix
alCopyModeAlpha
alCopyModeGamma
alCopyModeColorKey

%group
コピーモード



%index
alCopyModeColorKey
カラーキー コピーモードを設定

%prm
color1, color2
color1	: キー範囲下限 RGB 値
color2	: キー範囲上限 RGB 値

%inst
画像コピー時に透過色として扱う色の範囲を設定します。

color 引数は、R, G, B の値を 1 つの整数値にまとめた形式で、16 進数表記のそれぞれの桁の意味は 0xRRGGBB となります。(COLORREF 型とは異なります。) モジュールに内蔵のマクロ RGBA(R, G, B) を使用すると、値を簡単に記述できます。

たとえば、下記のコードは、紫色 (255, 0, 255) のみを透明色としてコピーするモードを設定します。

alCopyModeColorKey 0xff00ff, 0xff00ff

設定したコピーモードは、下記の命令に適用されます。

alCopyImageToImage
alCopyImageToScreen
alCopyScreenToImage
alStretchImageToImage
alStretchImageToScreen
alStretchScreenToImage

目的の処理が完了したら、alResetCopyMode 命令でデフォルトのコピーモードに戻すことができます。

コピーモードは、描画先の HSP Screen ID, 仮想イメージ ID を問わずに適用されます。

%sample
; サンプルスクリプト を記入

%href
alResetCopyMode

%group
コピーモード



%index
alCopyModeColorMatrix
カラーマトリックス コピーモードを設定

%prm
arr
arr	: カラーマトリックスを表す配列

%inst
画像コピー時にカラーマトリックス変換を行うように設定します。

引数 arr は、カラーマトリックスを表す double 型の 1 次元配列で、

arr = m00,m01,m02,m03,m04, m10,m11,m12,m13,m14, m20,m21,m22,m23,m24, m30,m31,m32,m33,m34

となる値を指定します。それぞれの配列要素 (行列要素) は、コピー元の色 (R G B A) を下記のように変換してをコピー先の色 (R' G' B' A') へ出力することを示します。

R' = m00 * R + m01 * G + m02 * B + m03 * A + m04
G' = m10 * R + m11 * G + m12 * B + m13 * A + m14
B' = m20 * R + m21 * G + m22 * B + m23 * A + m24
A' = m30 * R + m31 * G + m32 * B + m33 * A + m34

それぞれの要素は、最大輝度を 1.0 とする値で記述します。

引数配列は、モジュールに内蔵のマクロ MAT_R, MAT_G, MAT_B, MAT_A (= 0, 5, 10, 15) を使用して以下のように記述するとコードが見やすくなります。

	cmatrix(MAT_R) = m00, m01, m02, m03, m04
	cmatrix(MAT_G) = m10, m11, m12, m13, m14
	cmatrix(MAT_B) = m20, m21, m22, m23, m24
	cmatrix(MAT_A) = m30, m31, m32, m33, m34
	alCopyModeColorMatrix cmatrix

マラーマトリクスを用いると、画像の明るさの調整、ネガポジ反転、半透明化、グレースケール変換、セピア色変換、RGB 交換、アルファチャネルのグレースケール画像化など、さまざまな効果を得ることができます。

	(マトリックスの例)

	; 無変換 (基本)
	cmatrix(MAT_R) = 1.0, 0.0, 0.0, 0.0, 0.0
	cmatrix(MAT_G) = 0.0, 1.0, 0.0, 0.0, 0.0
	cmatrix(MAT_B) = 0.0, 0.0, 1.0, 0.0, 0.0
	cmatrix(MAT_A) = 0.0, 0.0, 0.0, 1.0, 0.0

	; 全体を明るくする
	cmatrix(MAT_R) = 1.0, 0.0, 0.0, 0.0, 0.2
	cmatrix(MAT_G) = 0.0, 1.0, 0.0, 0.0, 0.2
	cmatrix(MAT_B) = 0.0, 0.0, 1.0, 0.0, 0.2
	cmatrix(MAT_A) = 0.0, 0.0, 0.0, 1.0, 0.2

	; 全体を暗くする
	cmatrix(MAT_R) = 1.0, 0.0, 0.0, 0.0, -0.2
	cmatrix(MAT_G) = 0.0, 1.0, 0.0, 0.0, -0.2
	cmatrix(MAT_B) = 0.0, 0.0, 1.0, 0.0, -0.2
	cmatrix(MAT_A) = 0.0, 0.0, 0.0, 1.0, -0.2

	; 半透明でコピーする
	cmatrix(MAT_R) = 1.0, 0.0, 0.0, 0.0, 0.0
	cmatrix(MAT_G) = 0.0, 1.0, 0.0, 0.0, 0.0
	cmatrix(MAT_B) = 0.0, 0.0, 1.0, 0.0, 0.0
	cmatrix(MAT_A) = 0.0, 0.0, 0.0, 0.5, 0.0

	; グレースケールに変換
	cmatrix(MAT_R) = 0.299, 0.587, 0.114, 0.0, 0.0
	cmatrix(MAT_G) = 0.299, 0.587, 0.114, 0.0, 0.0
	cmatrix(MAT_B) = 0.299, 0.587, 0.114, 0.0, 0.0
	cmatrix(MAT_A) = 0.0, 0.0, 0.0, 1.0, 0.0

	; セピア色に変換
	cmatrix(MAT_R) = 0.393, 0.769, 0.189, 0.0, 0.0
	cmatrix(MAT_G) = 0.349, 0.686, 0.168, 0.0, 0.0
	cmatrix(MAT_B) = 0.272, 0.534, 0.131, 0.0, 0.0
	cmatrix(MAT_A) = 0.0, 0.0, 0.0, 1.0, 0.0

	; ネガポジ反転
	cmatrix(MAT_R) = -1.0, 0.0, 0.0, 0.0, 0.0
	cmatrix(MAT_G) = 0.0, -1.0, 0.0, 0.0, 0.0
	cmatrix(MAT_B) = 0.0, 0.0, -1.0, 0.0, 0.0
	cmatrix(MAT_A) = 0.0, 0.0, 0.0, 1.0, 0.0

	; アルファチャネルをグレースケールに変換
	cmatrix(MAT_R) = 0.0, 0.0, 0.0, 1.0, 0.0
	cmatrix(MAT_G) = 0.0, 0.0, 0.0, 1.0, 0.0
	cmatrix(MAT_B) = 0.0, 0.0, 0.0, 1.0, 0.0
	cmatrix(MAT_A) = 0.0, 0.0, 0.0, 0.0, 1.0

カラーマトリックス コピーモードは、下記の命令に適用されます。

alCopyImageToImage
alCopyImageToScreen
alCopyScreenToImage
alStretchImageToImage
alStretchImageToScreen
alStretchScreenToImage

目的の処理が完了したら、alResetCopyMode 命令でデフォルトのコピーモードに戻すことができます。

コピーモードは、描画先の HSP Screen ID, 仮想イメージ ID を問わずに適用されます。

%sample
; サンプルスクリプト を記入

%href
alResetCopyMode

%group
コピーモード



%index
alCopyModeGamma
ガンマ調整コピーモードを設定

%prm
p1
p1	: ガンマ値 double

%inst
画像コピー時にガンマ値を調整してコピーするように設定します。

設定したコピーモードは、下記の命令に適用されます。

alCopyImageToImage
alCopyImageToScreen
alCopyScreenToImage
alStretchImageToImage
alStretchImageToScreen
alStretchScreenToImage

目的の処理が完了したら、alResetCopyMode 命令でデフォルトのコピーモードに戻すことができます。

コピーモードは、描画先の HSP Screen ID, 仮想イメージ ID を問わずに適用されます。

%sample
; サンプルスクリプト を記入

%href
alResetCopyMode

%group
コピーモード



%index
alCreateImage
仮想イメージを作成

%prm
ID, pw, ph
ID	: Image ID [0-511] (0)
pw	: 横幅 [1-] (640)
ph	: 高さ [1-] (480)

%inst
Artlet2D モジュールの仮想イメージ (仮想画面, Image) を作成します。

ID には、作成する仮想イメージの Image ID を指定します。すでに存在する Image ID を指定した場合、既存の仮想イメージは破棄されて新しい仮想イメージが作成されます。

pw, ph には、作成する仮想イメージの大きさをピクセル単位で指定します。

この命令で作成される仮想イメージは、ARGB 32bpp 形式のアルファチャネル付きビットマップです。Artlet2D の描画命令を使ってこのバッファに画像を描画したり、画像イメージをディスクに保存したりすることができます。また、Artlet2D では、この仮想イメージごとにブラシ、ペン、フォントのステータスを保持しています。

仮想イメージを複数作成した場合は、alSelectImage 命令を使用して操作先を切り替えることができます。仮想イメージの削除には、alDeleteImage を使用します。いずれの命令も、引数には alCreateImage 命令で指定した Image ID を使用します。alCreateImage 命令の実行後は、作成した仮想イメージが選択された状態になります。

仮想イメージは直接画面には描画されませんので、仮想イメージの内容を表示するためには alCopyImageToScreen 命令などを使用して HSP スクリーンに内容を転送する必要があります。

画像ファイルから直接仮想イメージを作成する場合は、alCreateImageByFile 命令を使用します。

コンピュータに GDI+ が導入されていない環境 (gdiplus.dll がない環境) では仮想イメージは作成できず、システム変数 stat に -1 が返ります。この場合、Artlet2D は使用できません。alCreateImage 命令で正常に仮想イメージが作成された場合は、stat に 0 が返ります。

%href
alSelectImage
alDeleteImage
alCreateImageByFile

%sample
#include "a2d.hsp"

	alCreateImage 0, 640, 480 ; 仮想イメージを作成
	if stat = -1 {
		dialog "GDI+ を初期化できませんでした。"
		end
	}

	alFillEllip 0, 0, 200, 100 ; 仮想イメージに楕円を描画

	alCopyImageToScreen 0, 0 ; 仮想イメージから HSP screen に画像転送
	redraw ; HSP screen 再描画

%group
イメージ管理


%index
alCreateImageByFile
画像ファイルから仮想イメージを作成

%prm
ID, "file"
ID	: Image ID
"file"	: 読み込みファイル名

%inst
画像ファイルを読み込んで仮想イメージを作成します。

ID には、作成する仮想イメージの Image ID を指定します。すでに存在する Image ID を指定した場合、既存の仮想イメージは破棄されて新しい仮想イメージが作成されます。

この命令で初期化される仮想イメージは、画像ファイルの形式に関わらず、ARGB 32bpp 形式のアルファチャネル付きビットマップとなります。

画像を正しく読み込めなかった場合、もしくはコンピュータに GDI+ が導入されていない場合は、システム変数 stat の値は -1 になります。正常に終了した場合は、stat は 0 となります。

%href
; 関連項目 を記入

%group
ファイル操作



%index
alDeleteImage
仮想イメージを削除

%prm
ID
ID	: Image ID [0-511] (0)

%inst
指定した仮想イメージを削除します。

この命令の実行後は、仮想イメージは選択されていない状態となりますので、他の仮想イメージに描画を行う場合は alSelectImage 命令で別の仮想イメージを選択してください。

すべての仮想イメージが削除されると、Artlet2D は自動的に GDI+ を開放します。

%href
alCreateImage
alDeleteAll

%group
イメージ管理



%index
alSelectImage
仮想イメージを選択

%prm
ID
ID	: Image ID [0-511] (0)

%inst
操作の対象となる仮想イメージを選択します。

引数 ID には、alCreateImage 命令などで作成したイメージを指定します。

Artlet2D の描画命令やブラシ、フォント選択命令は、alSelectImage 命令で選択された仮想イメージに対して行われます。

存在しない Image ID が指定された場合、システム変数 stat に -1 が返ります。正常にイメージが切り替えられた場合は、stat に 0 が返ります。

%href
alCreateImage

%group
イメージ管理


%index
alDeleteAll
仮想イメージをすべて削除

%inst
Artlet2D の仮想イメージをすべて削除し、GDI+ を開放します。

この命令実行後も、alCreateImage 命令でイメージを作成すれば、また Artlet2D を使用することができます。

この命令は、HSP スクリプトの実行終了時に自動的に実行されます。

%href
alDeleteImage

%group
イメージ管理



%index
alGetID
現在選択されている Image ID を取得

%prm
()

%inst
現在選択されている仮想イメージの ID (Image ID) を取得します。

現在有効な Image ID が選択されていない場合は、-1 が返ります。

%href
alSelectImage

%group
イメージ管理



%index
alDrawArc
円弧の描画

%prm
x, y, w, h, ang0, ang1
x, y	: 基準楕円に外接する矩形の左上座標
w, h	: 基準楕円に外接する矩形のサイズ
ang0	: 開始角度
ang1	: 終了角度

%inst
円弧を描画します。

%href
alDrawPie
alFillPie

%group
図形描画



%index
alDrawPie
扇形の描画

%prm
x, y, w, h, ang0, ang1
x, y	: 基準楕円に外接する矩形の左上座標
w, h	: 基準楕円に外接する矩形のサイズ
ang0	: 開始角度
ang1	: 終了角度

%inst
扇形を描画します。

この扇形は、塗りつぶしではなく線で枠を描画した図形です。

%href
alDrawArc
alFillPie

%group
図形描画



%index
alFillPie
塗りつぶし扇形の描画

%prm
x, y, w, h, ang0, ang1
x, y	: 基準楕円に外接する矩形の左上座標
w, h	: 基準楕円に外接する矩形のサイズ
ang0	: 開始角度
ang1	: 終了角度

%inst
扇形を描画します。

%href
alDrawArc
alDrawPie

%group
図形描画



%index
alDrawClosedCurve
閉曲線の描画

%prm
arr, p1, p2
arr	: 座標データが入った int 配列
p1	: 座標データの数
p2	: カーブ強度 (0.5)

%inst
与えられた配列に基づいて曲線を描画します。

配列 arr のデータは、x1, y1, x2, y2, ..., xN, yN となる数列です。p1 には、配列にいくつのポイントが入っているかを指定します。この命令は、指定されたすぺての点を通る曲線を描画します。p2 には、カーブの強さを指定します。この値が 0 だと、折れ線に等しい描画結果となります。

例えば、オニギリ型の図形を描画するには、

arr = 0, 100,  50, 0,  100, 100
alDrawClosedCurve arr, 3

とします。

%group
図形描画



%index
alDrawCurve
曲線の描画

%prm
arr, p1, p2
arr	: 座標データが入った int 配列
p1	: 座標データの数
p2	: カーブ強度 (0.5)

%inst
与えられた配列に基づいて曲線を描画します。

配列 arr のデータは、x1, y1, x2, y2, ..., xN, yN となる数列です。p1 には、配列にいくつのポイントが入っているかを指定します。この命令は、指定されたすぺての点を通る曲線を描画します。p2 には、カーブの強さを指定します。この値が 0 だと、折れ線に等しい描画結果となります。

例えば、アーチ型の図形を描画するには、

arr = 0, 100,  50, 0,  100, 100
alDrawCurve arr, 3

とします。

%group
図形描画



%index
alDrawEllip
楕円の描画

%prm
x, y, w, h
x, y	: 外接する矩形の左上座標
w, h	: 外接する矩形のサイズ

%inst
引数で指定した位置・サイズの矩形に内接する楕円を描画します。

%href
alFillEllip

%group
図形描画



%index
alFillEllip
塗りつぶし楕円の描画

%prm
x, y, w, h
x, y	: 外接する矩形の左上座標
w, h	: 外接する矩形のサイズ

%inst
引数で指定した位置・サイズの矩形に内接する楕円を描画します。

%href
alDrawEllip

%group
図形描画



%index
alDrawLine
線分を描画

%prm
x1, y1, x2, y2
x1, y1	: ポイント 1
x2, y2	: ポイント 2

%inst
(x1, y1) から (x2, y2) に伸びる線分を描画します。

Artlet2D (GDI+) には、「カレントポジション」という概念はありません。HSP 標準の line 命令と違い、2 つのポイントを省略せず指定する必要があります。

%group
図形描画



%index
alDrawLines
折れ線の描画

%prm
arr, p1
arr	: 座標データが入った int 配列
p1	: 座標データの数

%inst
与えられた配列に基づいて折れ線を描画します。

配列 arr のデータは、x1, y1, x2, y2, ..., xN, yN となる数列です。p1 には、配列にいくつのポイントが入っているかを指定します。

例えば、V 字型の図形を描画するには、

arr = 0, 0,  50, 100,  100, 0
alDrawLines arr, 3

とします。

折れ線が閉じた形の図形 (多角形) を描画する場合は、alDrawPoly, alFillPoly を参照してください。また、折れ線を滑らかにカーブさせて描画する場合は、alDrawCurve を参照してください。

%group
図形描画



%index
alDrawPoly
多角形の描画

%prm
arr, p1
arr	: 座標データが入った int 配列
p1	: 座標データの数

%inst
与えられた配列に基づいて多角形を描画します。

配列 arr のデータは、x1, y1, x2, y2, ..., xN, yN となる数列です。p1 には、配列にいくつのポイントが入っているかを指定します。

例えば、三角形を描画するには、

arr = 0, 100,  50, 0,  100, 100
alDrawPoly arr, 3

とします。

%group
図形描画



%index
alDrawRect
矩形の描画

%prm
x, y, w, h
x, y	: 矩形の左上座標
w, h	: 矩形のサイズ

%inst
引数で指定した位置・サイズの矩形を描画します。

この矩形は、塗りつぶしではなく線で枠を描画した図形です。

%href
alFillRect

%group
図形描画



%index
alFillRect
塗りつぶし矩形の描画

%prm
x, y, w, h
x, y	: 矩形の左上座標
w, h	: 矩形のサイズ

%inst
引数で指定した位置・サイズの矩形を描画します。

%href
alDrawRect

%group
図形描画



%index
alDrawText
文字列の描画

%prm
"str", px, py, w, h, ax, ay
"str"	: 描画する文字列
px, py	: 描画する位置 (0, 0)
w, h	: 描画領域の幅と高さ (9999, 9999)
ax, ay	: アラインメント モード (0, 0)

%inst
仮想イメージに文字列を描画します。

引数 "str" の文字列を、左上座標を px, py とする 幅 w, 高さ h の矩形領域内に描画します。文字列が矩形領域の幅を超える場合は、自動的に折り返して描画されます。

引数 ax, ay で、横方向, 縦方向のアラインメントを指定できます。

ax : 0 = 左寄せ, 1 = 中央寄せ, 2 = 右寄せ
ay : 0 = 上寄せ, 1 = 中央寄せ, 2 = 下寄せ

たとえば、(0, 0)-(640, 480) の矩形領域内に上下共にセンタリングされた状態で文字列を描画する場合は、

alDrawText "string", 0, 0, 640, 480, 1, 1

とします。

alDrawText 命令を実行する前に、必ず alFont 命令でフォントを選択する必要があります。

%sample
#include "a2d.hsp"

	alCreateImage 0, 640, 480 ; 仮想イメージを作成
	if stat = -1 {
		dialog "GDI+ を初期化できませんでした。"
		end
	}

	alFont "Times New Roman", 40 ; フォントを設定
	alDrawText "Artlet2D test" ; テキストを描画

	; 画面全体にセンタリングして描画
	alDrawText "centering", 0, 0, 640, 480, 1, 1

	alCopyImageToScreen 0, 0 ; 仮想イメージから HSP screen に画像転送
	redraw ; HSP screen 再描画

%href
alFont

%group
図形描画



%index
alFont
フォントを設定

%prm
"font", p1, p2
"font"	: フォント名 ("Arial")
p1	: フォントサイズ [1-] (16)
p2	: フォントスタイル (0)

%inst
alDrawText 命令で描画するフォントを指定します。

引数は、HSP 標準の font 命令と同じものです。ただし、フォントの種類には、ビットマップフォントは使用できません。必ずベクタデータを持った TrueType フォントを使用する必要があります。

(この命令の実行により、gsel 命令で選択された HSP スクリーンのフォント設定も連動して変更されます。)

%sample
; サンプルスクリプト を記入

%href
alDrawText

%group
ブラシ設定



%index
alErase
仮想イメージ全体を消去

%inst
仮想イメージのビットマップ全体を、黒色・透明 (ARGB(0, 0, 0, 0)) の状態に消去します。

%group
ピクセル操作



%index
alEraserBrush
消しゴムブラシの設定

%inst
ブラシを消しゴムブラシに設定します。

このブラシを選択して描画されたピクセルは、黒色・透明 (ARGB(0, 0, 0, 0)) として消去されます。

%sample
alEraserBrush
alFillRect 10, 10, 10, 10 ; この矩形領域を消去

%group
ブラシ設定



%index
alFillClosedCurve
塗りつぶし閉曲線の描画

%prm
arr, p1, p2
arr	: 座標データが入った int 配列
p1	: 座標データの数
p2	: カーブ強度 (0.5)

%inst
与えられた配列に基づいて曲線を描画します。

配列 arr には、ポイント x1, y1, x2, y2, ..., xN, yN となる数列を指定します。この命令は、指定されたすぺての点を通る曲線を描画します。

p1 には、配列にいくつのポイントが入っているかを指定します。

p2 には、カーブの強さを指定します。この値が 0 だと、折れ線に等しい描画結果となります。

例えば、オニギリ型の図形を描画するには、

arr = 0, 100,  50, 0,  100, 100
alFillClosedCurve arr, 3

とします。

%group
図形描画



%index
alFillPoly
塗りつぶし多角形の描画

%prm
arr, p1
arr	: 座標データが入った int 配列
p1	: 座標データの数

%inst
与えられた配列に基づいて多角形を描画します。

配列 arr には、ポイント x1, y1, x2, y2, ..., xN, yN となる数列を指定します。

p1 には、配列にいくつのポイントが入っているかを指定します。

例えば、三角形を描画するには、

arr = 0, 100,  50, 0,  100, 100
alFillPoly arr, 3

とします。

%group
図形描画



%index
alGetFileWidth
画像ファイルの幅、高さを取得

%prm
"file", vx, vy
"file"	: ファイル名
vx, vy	: 値を受け取る変数

%inst
画像ファイルの幅、高さをピクセル単位で取得します。

BMP, GIF, JPEG, PNG, TIFF など GDI+ が読み出せる形式をサポートします。

画像を正しく読み込めなかった場合、システム変数 stat の値は -1 になります。正常に終了した場合は、stat は 0 となります。

%href
alLoadFile

%group
ファイル操作



%index
alLoadFile
画像ファイルをロード

%prm
"file", px, py
"file"	: ファイル名
px, py	: 描画位置 (0)

%inst
現在の仮想イメージ上に画像ファイルをロードします。

BMP, GIF, JPEG, PNG, TIFF など GDI+ が読み出せる形式をサポートします。

引数 px, py で、描画先の左上座標を指定します。

画像ファイルから仮想イメージを直接作成したい場合は、alCreateImageFromFile 命令が便利です。

画像を正しく読み込めなかった場合、システム変数 stat の値は -1 になります。正常に終了した場合は、stat は 0 となります。

%href
; 関連項目 を記入

%group
ファイル操作



%index
alGetHeight
仮想イメージの高さを取得

%prm
()

%inst
現在選択されている仮想イメージの Y サイズ (height) を取得します。

現在有効な Image ID が選択されていない場合は、-1 が返ります。

%href
alGetWidth

%group
イメージ管理



%index
alGetWidth
仮想イメージの横幅を取得

%prm
()

%inst
現在選択されている仮想イメージの X サイズ (width) を取得します。

現在有効な Image ID が選択されていない場合は、-1 が返ります。

%href
alGetHeight

%group
イメージ管理



%index
alGetPixel
ピクセルの値を取得

%prm
(px, py)
px, py	: 値を取得するピクセル

%inst
現在の仮想イメージ上の 1 ピクセルの値を取得します。取得される値は、ARGB 形式の数値です。

ARGB 値は、R, G, B, A の値を 1 つの整数値にまとめた形式で、16 進数表記のそれぞれの桁の意味は 0xAARRGGBB となります。R, G, B, A それぞれの値は、マクロ ARGB_A(), ARGB_R(), ARGB_G(), ARGB_B() で取得することができます。

例
; 仮想イメージ (0, 0) の R 値
r = RGBA_R( alGetPixel(0, 0) )

%href
alSetPixel

%group
ピクセル操作



%index
alSetPixel
ピクセルの値を設定

%prm
px, py, ARGB
px, py	: 値を取得するピクセル
ARGB	: 設定する ARGB 値

%inst
現在の仮想イメージ上の 1 ピクセルに値を設定します。

ARGB 値は、R, G, B, A の値を 1 つの整数値にまとめた形式で、16 進数表記のそれぞれの桁の意味は 0xAARRGGBB となります。モジュールに内蔵のマクロ ARGB(A, R, G, B) もしくは RGBA(R, G, B, A) を使用すると、値を簡単に記述できます。

%href
alGetPixel

%group
ピクセル操作



%index
alPenStyle
ペンのスタイルを設定

%prm
p1
p1	: ペンのスタイル No.

%inst
ペンのスタイルを設定します。

ペンのスタイルとして、以下の定数が定義されています。

DashStyleSolid		(= 0) (デフォルト)
DashStyleDash		(= 1)
DashStyleDot		(= 2)
DashStyleDashDot	(= 3)
DashStyleDashDotDot	(= 4)

ここで設定したペンのスタイルは、alDrawLine など線を描画する命令に適用されます。

%sample
; サンプルスクリプト を記入

%href
alPenWidth

%group
ブラシ設定



%index
alPenWidth
ペンの太さを設定

%prm
p1
p1	: ペンの太さ [1-] int

%inst
ペンの太さをピクセル単位で設定します。

ここで設定したペンの太さは、alDrawLine や alDrawEllip など線を描画する命令に適用されます。

%sample
; サンプルスクリプト を記入

%href
alPenStyle

%group
ブラシ設定



%index
alResetTransMode
座標変換モードをリセット

%inst
座標変換モードをデフォルト状態 (無変換) に戻します。

座標変換モードは、alDraw～, alFill～, alCopy～ などのさまざまな描画命令に適用されます。

座標変換モードは、モード変更命令を実行したときに選択されている仮想イメージ ID に対して適用されます。

%href
alTransModeMatrix
alTransModeOffsetRotateZoom
alTransModeRotateAt

%group
座標変換モード



%index
alTransModeMatrix
座標変換マトリクスを設定

%prm
m11, m12, m21, m22, dx, dy
m11, m12, 
m21, m22  : 2x2 座標変換マトリクス
dx, dy    : オフセット

%inst
座標変換モードとしてマトリクスを設定します。

座標変換モードは、alDraw～, alFill～, alCopy～ などのさまざまな描画命令に適用されます。

座標変換モードは、モード変更命令を実行したときに選択されている仮想イメージ ID に対して適用されます。

%href
alResetTransMode

%group
座標変換モード



%index
alTransModeOffsetRotateZoom
座標変換パラメータを設定

%prm
dx, dy, pa, sx, sy
dx, dy : オフセット (0)
pa     : 回転角度 (0)
sx, sy : ズーム (1.0)

%inst
座標変換モードとしてパラメータを設定します。

dx, dy は、描画位置を平行移動するオフセットを指定します。
pa は、(元の原点を中心に) 回転させる角度を指定します。
sx, sy は、(元の座標系を基準に) 縦・横方向に引き伸ばす量を指定します。

座標変換モードは、alDraw～, alFill～, alCopy～ などのさまざまな描画命令に適用されます。

座標変換モードは、モード変更命令を実行したときに選択されている仮想イメージ ID に対して適用されます。

%href
alResetTransMode

%group
座標変換モード



%index
alTransModeRotateAt
座標変換パラメータを設定

%prm
pa, px, py
pa     : 回転角度
px, py : 回転の中心座標 (0)

%inst
座標変換モードとして、任意の点を中心とした回転を設定します。

pa は、回転させる角度を指定します。
px, py は、回転の中心となる点を指定します。

座標変換モードは、alDraw～, alFill～, alCopy～ などのさまざまな描画命令に適用されます。

座標変換モードは、モード変更命令を実行したときに選択されている仮想イメージ ID に対して適用されます。

%href
alResetTransMode

%group
座標変換モード



%index
alSaveFile
画像ファイルを保存

%prm
"file", "MIME", px, py, w, h
"file"	: 保存ファイル名
"MIME"	: MIME タイプ ("image/png")
px, py	: 保存対象矩形 左上 (0, 0)
w, h	: 保存対象矩形 幅・高さ (currentWidth, currentHeight)

%inst
現在の仮想イメージをファイルとして保存します。

保存形式は、引数 MIME で指定します。指定することができる MIME タイプは、"image/bmp", "image/jpeg", "image/gif", "image/tiff", "image/png" のいずれかです。引数を省略した場合のデフォルト値は、"image/png" です。ピクセルフォーマットは、(その形式でサポートされている場合) 32bpp ARGB となります。

引数 px, py, w, h を指定すると、仮想イメージの一部を保存できます。これらの引数を省略した場合は、仮想イメージ全体が対象となります。

画像を保存できなかった場合、システム変数 stat の値は -1 になります。正常に終了した場合は、stat は 0 となります。

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
ファイル操作



%index
alStretchImageToImage
画像ストレッチコピー (Image → Image)

%prm
sID, dID, sx, sy, sw, sh, dx, dy, dw, dh
sID	: コピー元 Image ID
dID	: コピー先 Image ID
sx, sy	: コピー元矩形 左上座標
sw, sh	: コピー元矩形 幅・高さ
dx, dy	: コピー先矩形 左上座標
dw, dh	: コピー先矩形 幅・高さ

%inst
コピー元 Image ID の任意の矩形領域からコピー先 Image ID の任意の矩形領域へ、画像を拡大/縮小してコピーします。

Image ID と HSP スクリーン間の画像転送については、alStretchImageToScreen, alStretchScreenToImage を参照してください。

%href
alStretchImageToScreen
alStretchScreenToImage

%group
コピー・ズーム



%index
alStretchImageToScreen
画像ストレッチコピー (Image → HSP screen)

%prm
sID, dID, sx, sy, sw, sh, dx, dy, dw, dh
sID	: コピー元 Image ID
dID	: コピー先 HSP スクリーン ID
sx, sy	: コピー元矩形 左上座標
sw, sh	: コピー元矩形 幅・高さ
dx, dy	: コピー先矩形 左上座標
dw, dh	: コピー先矩形 幅・高さ

%inst
コピー元 Image ID の任意の矩形領域からコピー先 HSP スクリーン ID の任意の矩形領域へ、画像を拡大/縮小してコピーします。

%href
alStretchImageToImage
alStretchScreenToImage

%group
コピー・ズーム



%index
alStretchScreenToImage
画像ストレッチコピー (HSP screen → Image)

%prm
sID, dID, sx, sy, sw, sh, dx, dy, dw, dh
sID	: コピー元 HSP スクリーン ID
dID	: コピー先 Image ID
sx, sy	: コピー元矩形 左上座標
sw, sh	: コピー元矩形 幅・高さ
dx, dy	: コピー先矩形 左上座標
dw, dh	: コピー先矩形 幅・高さ

%inst
コピー元 HSP スクリーン ID の任意の矩形領域からコピー先 Image ID の任意の矩形領域へ、画像を拡大/縮小してコピーします。

%href
alStretchImageToImage
alStretchImageToScreen

%group
コピー・ズーム



%index
alTextureImage
テクスチャブラシを設定

%prm
ID, mode
ID	: テクスチャの Image ID [0-511] (0)
mode	: ラップモード (0)

%inst
テクスチャブラシを設定します。

ID で、テクスチャの画像データを保持している仮想イメージの ID を指定します。

mode には、定数 WrapModeTile (= 0), WrapModeTileFlipX (= 1), WrapModeTileFlipY (= 2), WrapModeTileFlipXY (= 3) を指定することができます。

テクスチャ用画像ファイルから仮想イメージを作成する場合、alCreateImageByFile 命令を使用すると簡潔です。

%sample
; サンプルスクリプト を記入

%href
; 関連項目 を記入

%group
ブラシ設定



