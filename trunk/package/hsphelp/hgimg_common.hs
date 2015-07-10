;
;	HSP help manager用 HELPソースファイル
;	(先頭が「;」の行はコメントとして処理されます)
;
%type
拡張命令
%ver
3.32
%note
hgimg3.asまたはhgimg4.asをインクルードすること。
%author
onitama
%dll
hgimg3,hgimg4
%date
2013/07/01
%author
onitama
%url
http://www.onionsoft.net/
%port
Win
%portinfo
HGIMG3はDirectX8、HGIMG4はOpenGL3.1環境で動作


%index
fvseti
整数値からベクトル設定
%group
拡張画面制御命令
%prm
fv,x,y,z
fv      = FV値が代入される変数名
(x,y,z) = 整数値
%inst
(x,y,z)で指定された整数値をベクトルとしてFV値に代入する。
%href
fvset
fvadd
fvsub
fvmul
fvdiv
fvdir
fvmin
fvmax
fvouter
fvinner
fvface
fvunit


%index
fvset
ベクトル設定
%group
拡張画面制御命令
%prm
fv,x,y,z
fv      = FV値が代入される変数名
(x,y,z) = 計算値(実数値)
%inst
(x,y,z)で指定された小数値(X,Y,Z)をベクトルとしてFV値に代入する。
%href
fvseti
fvadd
fvsub
fvmul
fvdiv
fvdir
fvmin
fvmax
fvouter
fvinner
fvface
fvunit


%index
fvadd
ベクトル加算
%group
拡張画面制御命令
%prm
fv,x,y,z
fv      = FV値が代入されている変数名
(x,y,z) = 計算値(実数値)
%inst
(x,y,z)で指定された小数値(X,Y,Z)をFV値に加算する。
%href
fvseti
fvset
fvsub
fvmul
fvdiv
fvmin
fvmax


%index
fvsub
ベクトル減算
%group
拡張画面制御命令
%prm
fv,x,y,z
fv      = FV値が代入されている変数名
(x,y,z) = 計算値(実数値)
%inst
(x,y,z)で指定された小数値(X,Y,Z)をFV値から減算する。
%href
fvseti
fvset
fvadd
fvmul
fvdiv
fvmin
fvmax


%index
fvmul
ベクトル乗算
%group
拡張画面制御命令
%prm
fv,x,y,z
fv      = FV値が代入されている変数名
(x,y,z) = 計算値(実数値)
%inst
(x,y,z)で指定された小数値(X,Y,Z)をFV値に並列で乗算する。
%href
fvseti
fvset
fvadd
fvsub
fvdiv
fvmin
fvmax


%index
fvdiv
ベクトル除算
%group
拡張画面制御命令
%prm
fv,x,y,z
fv      = FV値が代入されている変数名
(x,y,z) = 計算値(実数値)
%inst
(x,y,z)で指定された小数値(X,Y,Z)をFV値に並列で除算する。
%href
fvseti
fvset
fvadd
fvsub
fvmul
fvmin
fvmax


%index
fvdir
ベクトル回転
%group
拡張画面制御命令
%prm
fv,x,y,z
fv      = FV値が代入されている変数名
(x,y,z) = 回転角度(実数値)
%inst
fvで指定された変数に格納されているFV値をX,Y,Z角度として、
小数値(X,Y,Z)で指定されたベクトルを回転させた結果を、変数fvに代入します。
%href
fvset
fvdir
fvface


%index
fvface
座標から角度を得る
%group
拡張画面制御命令
%prm
fv,x,y,z
fv      = FV値が代入されている変数名
(x,y,z) = X,Y,Z座標値(実数値)
%inst
fvで指定された変数に格納されているベクトル(FV値)を基点とするX,Y,Z座標から、指定されたX,Y,Z座標を直線で見るためのX,Y,Z回転角度を求めて変数fvに代入します。
%href
fvset
fvdir


%index
fvmin
ベクトル最小値
%group
拡張画面制御命令
%prm
fv,x,y,z
fv      = FV値が代入されている変数名
(x,y,z) = 比較値(実数値)
%inst
fvで指定された変数に格納されているFV値と、小数値(X,Y,Z)を比較して、値の大きいものを代入します。
FV値の各要素を最小値までに切り詰める場合に使用します。
%href
fvseti
fvset
fvadd
fvsub
fvmul
fvdiv
fvmax


%index
fvmax
ベクトル最大値
%group
拡張画面制御命令
%prm
fv,x,y,z
fv      = FV値が代入されている変数名
(x,y,z) = 比較値(実数値)
%inst
fvで指定された変数に格納されているFV値と、小数値(X,Y,Z)を比較して、値の小さいものを代入します。
FV値の各要素を最大値までに切り詰める場合に使用します。
%href
fvseti
fvset
fvadd
fvsub
fvmul
fvdiv
fvmin


%index
fvouter
ベクトル外積
%group
拡張画面制御命令
%prm
fv,x,y,z
fv      = FV値が代入されている変数名
(x,y,z) = 演算するベクトル値(実数値)
%inst
fvで指定された変数に格納されているFV値と、小数値(X,Y,Z)で指定するベクトルの外積を求めて代入します。
%href
fvseti
fvset
fvinner


%index
fvinner
ベクトル内積
%group
拡張画面制御命令
%prm
fv,x,y,z
fv      = FV値が代入されている変数名
(x,y,z) = 演算するベクトル値(実数値)
%inst
fvで指定された変数に格納されているFV値と、小数値(X,Y,Z)で指定するベクトルの内積を求めてfv.0に代入します。
%href
fvseti
fvset
fvouter


%index
fvunit
ベクトル正規化
%group
拡張画面制御命令
%prm
fv
fv      = FV値が代入されている変数名
%inst
fvで指定された変数に格納されているベクトル(FV値)を正規化します。
%href
fvseti
fvset


%index
fsin
サインを求める
%group
拡張画面制御命令
%prm
fval,frot
fval    = 実数値が代入される変数名
frot    = 回転角度(ラジアン)
%inst
frotで指定された角度のサイン値をfvalで指定した変数に代入します。
角度の単位はラジアン(2π=360度)になります。
%href
fcos
fsqr
froti



%index
fcos
コサインを求める
%group
拡張画面制御命令
%prm
fval,frot
fval    = 実数値が代入される変数名
frot    = 回転角度(ラジアン)
%inst
frotで指定された角度のコサイン値をfvalで指定した変数に代入します。
角度の単位はラジアン(2π=360度)になります。
%href
fsin
fsqr
froti



%index
fsqr
平方根を求める
%group
拡張画面制御命令
%prm
fval,fprm
fval    = 実数値が代入される変数名
fprm    = 演算に使われる値(実数)
%inst
fprmで指定された値の平方根をfvalで指定した変数に代入します。
%href
fsin
fcos
froti



%index
str2fv
文字列をベクトルに変換
%group
拡張画面制御命令
%prm
fv,"x,y,z"
fv      = FV値が代入される変数名
"x,y,z" = 「,」で区切られた実数値が格納された文字列
%inst
"x,y,z"で指定された文字列情報を「,」で区切られたX,Y,Z小数値として読み出し、fvで指定された変数に格納します。
それぞれの項目が正しく数値として認識できない(不正な)文字列があった場合には、それ以降の項目も含めて0.0が代入されます。
%href
fv2str
str2f
f2str
f2i


%index
fv2str
ベクトルを文字列に変換
%group
拡張画面制御命令
%prm
fv
fv      = FV値が代入されている変数名
%inst
fvで指定された変数に格納されているベクトル(FV値)を文字列に変換してシステム変数refstrに結果を返します。
%href
str2fv
str2f
f2str
f2i


%index
str2f
文字列を小数値に変換
%group
拡張画面制御命令
%prm
fval,"fval"
fval    = 実数値が代入される変数名
"fval"  = 実数値が格納された文字列
%inst
"fval"で指定された文字列情報を小数値として読み出し、fvalで指定された変数に格納します。
%href
fv2str
str2fv
f2str
f2i


%index
f2str
小数値を文字列に変換
%group
拡張画面制御命令
%prm
sval,fval
sval    = 文字列が代入される変数名
fval    = 変換元の実数値
%inst
fvalで指定された小数値を文字列に変換して、valで指定された文字列型の変数に結果を返します。
%href
fv2str
str2fv
str2f
f2i


%index
delobj
オブジェクトの削除
%group
拡張画面制御命令
%prm
ObjID
ObjID  : オブジェクトID
%inst
指定されたオブジェクトを削除します。
%href
regobj


%index
setpos
posグループ情報を設定
%group
拡張画面制御命令
%prm
id,x,y,z
id      : オブジェクトID
(x,y,z) : 設定する値 (デフォルト=0)

%inst
オブジェクトの持つパラメーターを設定します。
posグループ(表示座標)に(x,y,z)で指定された値を設定します。
(x,y,z)には、実数または整数値を指定することができます。

%href
setang
setangr
setscale
setdir
setefx
setwork


%index
setang
angグループ情報を設定
%group
拡張画面制御命令
%prm
id,x,y,z
id      : オブジェクトID
(x,y,z) : 設定する値 (デフォルト=0)

%inst
オブジェクトの持つパラメーターを設定します。
angグループ(表示角度)に(x,y,z)で指定された値を設定します。
(x,y,z)には、実数または整数値を指定することができます。
角度の単位はラジアンになります。
整数で角度を設定するためのsetangr命令も用意されています。

%href
setpos
setangr
setscale
setdir
setefx
setwork


%index
setangr
angグループ情報を設定
%group
拡張画面制御命令
%prm
id,x,y,z
id      : オブジェクトID
(x,y,z) : 設定する値 (デフォルト=0)

%inst
オブジェクトの持つパラメーターを設定します。
angグループ(表示角度)に(x,y,z)で指定された値を設定します。
(x,y,z)には、実数または整数値を指定することができます。
角度の単位は整数で0～255で一周する値を使用します。
ラジアンで角度を設定するためのsetang命令も用意されています。

%href
setpos
setang
setscale
setdir
setefx
setwork


%index
setscale
scaleグループ情報を設定
%group
拡張画面制御命令
%prm
id,x,y,z
id      : オブジェクトID
(x,y,z) : 設定する値 (デフォルト=0)

%inst
オブジェクトの持つパラメーターを設定します。
scaleグループ(表示倍率)に(x,y,z)で指定された値を設定します。
(x,y,z)には、実数または整数値を指定することができます。

%href
setpos
setang
setangr
setdir
setefx
setwork


%index
setdir
dirグループ情報を設定
%group
拡張画面制御命令
%prm
id,x,y,z
id      : オブジェクトID
(x,y,z) : 設定する値 (デフォルト=0)

%inst
オブジェクトの持つパラメーターを設定します。
dirグループ(移動ベクトル)に(x,y,z)で指定された値を設定します。
(x,y,z)には、実数または整数値を指定することができます。
移動ベクトルに登録された値は、オブジェクトの自動移動モード(OBJ_MOVE)時に参照されます。

%href
setpos
setang
setangr
setscale
setefx
setwork


%index
setwork
workグループ情報を設定
%group
拡張画面制御命令
%prm
id,x,y,z
id      : オブジェクトID
(x,y,z) : 設定する値 (デフォルト=0)

%inst
オブジェクトの持つパラメーターを設定します。
workグループ(ワーク値)に(x,y,z)で指定された値を設定します。
(x,y,z)には、実数または整数値を指定することができます。

%href
setpos
setang
setangr
setscale
setdir
setefx


%index
addpos
posグループ情報を加算
%group
拡張画面制御命令
%prm
id,x,y,z
id      : オブジェクトID
(x,y,z) : 加算する値 (デフォルト=0)

%inst
オブジェクトの持つパラメーターを設定します。
posグループ(表示座標)に(x,y,z)で指定された値を設定します。
(x,y,z)には、実数または整数値を指定することができます。

%href
addang
addangr
addscale
adddir
addefx
addwork


%index
addang
angグループ情報を加算
%group
拡張画面制御命令
%prm
id,x,y,z
id      : オブジェクトID
(x,y,z) : 加算する値 (デフォルト=0)

%inst
オブジェクトの持つパラメーターを設定します。
angグループ(表示角度)に(x,y,z)で指定された値を加算します。
(x,y,z)には、実数または整数値を指定することができます。
角度の単位はラジアンになります。
整数で角度を設定するためのsetangr命令も用意されています。

%href
addpos
addangr
addscale
adddir
addefx
addwork


%index
addangr
angグループ情報を加算
%group
拡張画面制御命令
%prm
id,x,y,z
id      : オブジェクトID
(x,y,z) : 加算する値 (デフォルト=0)

%inst
オブジェクトの持つパラメーターを設定します。
angグループ(表示角度)に(x,y,z)で指定された値を加算します。
(x,y,z)には、実数または整数値を指定することができます。
角度の単位は整数で0～255で一周する値を使用します。
ラジアンで角度を設定するためのsetang命令も用意されています。

%href
addpos
addang
addscale
adddir
addefx
addwork


%index
addscale
scaleグループ情報を加算
%group
拡張画面制御命令
%prm
id,x,y,z
id      : オブジェクトID
(x,y,z) : 加算する値 (デフォルト=0)

%inst
オブジェクトの持つパラメーターを設定します。
scaleグループ(表示倍率)に(x,y,z)で指定された値を加算します。
(x,y,z)には、実数または整数値を指定することができます。

%href
addpos
addang
addangr
adddir
addefx
addwork


%index
adddir
dirグループ情報を加算
%group
拡張画面制御命令
%prm
id,x,y,z
id      : オブジェクトID
(x,y,z) : 加算する値 (デフォルト=0)

%inst
オブジェクトの持つパラメーターを設定します。
dirグループ(移動ベクトル)に(x,y,z)で指定された値を加算します。
(x,y,z)には、実数または整数値を指定することができます。

%href
addpos
addang
addangr
addscale
addefx
addwork


%index
addwork
workグループ情報を加算
%group
拡張画面制御命令
%prm
id,x,y,z
id      : オブジェクトID
(x,y,z) : 加算する値 (デフォルト=0)

%inst
オブジェクトの持つパラメーターを設定します。
workグループ(ワーク値)に(x,y,z)で指定された値を加算します。
(x,y,z)には、実数または整数値を指定することができます。

%href
addpos
addang
addangr
addscale
adddir
addefx


%index
getpos
posグループ情報を取得
%group
拡張画面制御命令
%prm
id,x,y,z
id      : オブジェクトID
(x,y,z) : 取得する変数

%inst
オブジェクトの持つパラメーターを取得します。
posグループ(表示座標)の内容が(x,y,z)で指定された変数に代入されます。
(x,y,z)は、実数型の変数として設定されます。
命令の最後に「i」を付加することで、整数値として値を取得することができます。

%href
getposi
getang
getangr
getscale
getdir
getefx
getwork


%index
getscale
scaleグループ情報を取得
%group
拡張画面制御命令
%prm
id,x,y,z
id      : オブジェクトID
(x,y,z) : 取得する変数

%inst
オブジェクトの持つパラメーターを取得します。
scaleグループ(表示倍率)の内容が(x,y,z)で指定された変数に代入されますます。
(x,y,z)は、実数型の変数として設定されます。
命令の最後に「i」を付加することで、整数値として値を取得することができます。

%href
getscalei
getpos
getang
getangr
getdir
getefx
getwork


%index
getdir
dirグループ情報を取得
%group
拡張画面制御命令
%prm
id,x,y,z
id      : オブジェクトID
(x,y,z) : 取得する変数

%inst
オブジェクトの持つパラメーターを取得します。
dirグループ(移動ベクトル)の内容が(x,y,z)で指定された変数に代入されます。
(x,y,z)は、実数型の変数として設定されます。
命令の最後に「i」を付加することで、整数値として値を取得することができます。

%href
getdiri
getpos
getang
getangr
getscale
getefx
getwork


%index
getwork
workグループ情報を取得
%group
拡張画面制御命令
%prm
id,x,y,z
id      : オブジェクトID
(x,y,z) : 取得する変数

%inst
オブジェクトの持つパラメーターを取得します。
workグループ(ワーク値)の内容が(x,y,z)で指定された変数に代入されます。
(x,y,z)は、実数型の変数として設定されます。
命令の最後に「i」を付加することで、整数値として値を取得することができます。

%href
getworki
getpos
getang
getangr
getscale
getdir
getefx


%index
getposi
posグループ情報を整数で取得
%group
拡張画面制御命令
%prm
id,x,y,z
id      : オブジェクトID
(x,y,z) : 取得する変数

%inst
オブジェクトの持つパラメーターを取得します。
posグループ(表示座標)の内容が(x,y,z)で指定された変数に代入されます。
(x,y,z)は、整数型の変数として設定されます。

%href
getpos
getangi
getangri
getscalei
getdiri
getefxi
getworki


%index
getscalei
scaleグループ情報を整数で取得
%group
拡張画面制御命令
%prm
id,x,y,z
id      : オブジェクトID
(x,y,z) : 取得する変数

%inst
オブジェクトの持つパラメーターを取得します。
scaleグループ(表示倍率)の内容が(x,y,z)で指定された変数に代入されますます。
(x,y,z)は、整数型の変数として設定されます。

%href
getscale
getposi
getangi
getangri
getdiri
getefxi
getworki


%index
getdiri
dirグループ情報を整数で取得
%group
拡張画面制御命令
%prm
id,x,y,z
id      : オブジェクトID
(x,y,z) : 取得する変数

%inst
オブジェクトの持つパラメーターを取得します。
dirグループ(移動ベクトル)の内容が(x,y,z)で指定された変数に代入されます。
(x,y,z)は、整数型の変数として設定されます。

%href
getdir
getposi
getangi
getangri
getscalei
getefxi
getworki


%index
getworki
workグループ情報を整数で取得
%group
拡張画面制御命令
%prm
id,x,y,z
id      : オブジェクトID
(x,y,z) : 取得する変数

%inst
オブジェクトの持つパラメーターを取得します。
workグループ(ワーク値)の内容が(x,y,z)で指定された変数に代入されます。
(x,y,z)は、整数型の変数として設定されます。

%href
getwork
getposi
getangi
getangri
getscalei
getdiri
getefxi


%index
selpos
移動座標をMOC情報に設定
%group
拡張画面制御命令
%prm
id
id     : オブジェクトID
%inst
MOC設定命令の対象となるMOCグループをpos(座標)に設定します
idは、オブジェクトIDとなります。
%href
selmoc
selang
selscale
seldir
selefx
selcam
selcpos
selcang
selcint


%index
selang
回転角度をMOC情報に設定
%group
拡張画面制御命令
%prm
id
id     : オブジェクトID
%inst
MOC設定命令の対象となるMOCグループをang(回転角度)に設定します
idは、オブジェクトIDとなります。
%href
selmoc
selpos
selscale
seldir
selefx
selcam
selcpos
selcang
selcint


%index
selscale
スケールをMOC情報に設定
%group
拡張画面制御命令
%prm
id
id     : オブジェクトID
%inst
MOC設定命令の対象となるMOCグループをscale(スケール)に設定します
idは、オブジェクトIDとなります。
%href
selmoc
selpos
selang
selefx
seldir
selcam
selcpos
selcang
selcint


%index
seldir
移動量をMOC情報に設定
%group
拡張画面制御命令
%prm
id
id     : オブジェクトID
%inst
MOC設定命令の対象となるMOCグループをdir(移動量)に設定します
idは、オブジェクトIDとなります。
%href
selmoc
selpos
selang
selscale
selefx
selcam
selcpos
selcang
selcint


%index
selwork
オブジェクトワークをMOC情報に設定
%group
拡張画面制御命令
%prm
id
id     : オブジェクトID
%inst
MOC設定命令の対象となるMOCグループをwork(ワーク)に設定します
idは、オブジェクトIDとなります。
%href
selmoc
selpos
selang
selscale
selefx
selcam
selcpos
selcang
selcint


%index
objset3
MOC情報を設定
%group
拡張画面制御命令
%prm
x,y,z
x   : 設定する値
y   : 設定する値2
z   : 設定する値3

%inst
MOC情報を設定します。
オフセット番号0から3つのパラメータが対象になります。
%href
objset3
objadd3
objset3r
objsetf3
objaddf3


%index
objsetf3
MOC情報を設定
%group
拡張画面制御命令
%prm
fx,fy,fz
fx  : 設定する値(実数値)
fy  : 設定する値2(実数値)
fz  : 設定する値3(実数値)

%inst
MOC情報を設定します。
オフセット番号0から3つのパラメータが対象になります。
%href
objset3
objadd3
objset3r
objsetf3
objaddf3


%index
objadd3
MOC情報を加算
%group
拡張画面制御命令
%prm
x,y,z
x   : 加算する値
y   : 加算する値2
z   : 加算する値3

%inst
MOC情報に設定されている値にx,y,zを加算します。
オフセット番号0から3つのパラメータが対象になります。
%href
objset3
objadd3r
objset3r
objsetf3
objaddf3


%index
objaddf3
MOC情報を加算
%group
拡張画面制御命令
%prm
fx,fy,fz
fx  : 加算する値(実数値)
fy  : 加算する値2(実数値)
fz  : 加算する値3(実数値)

%inst
MOC情報に設定されている値にfx,fy,fzを加算します。
オフセット番号0から3つのパラメータが対象になります。
%href
objset3
objadd3
objset3r
objsetf3
objaddf3


%index
objadd3r
MOC情報を加算
%group
拡張画面制御命令
%prm
ofs,fx,fy,fz
ofs : MOCのオフセット番号
fx  : 加算する値(整数角度値)
fy  : 加算する値2(整数角度値)
fz  : 加算する値3(整数角度値)
%inst
MOC情報に設定されている値にfx,fy,fzを加算します。
ただし整数値(256で１回転)をラジアン単位に変換したパラメーターを加算します。
角度を指定するパラメーター以外では正常な値にならないので注意してください。
%href
objset3
objadd3
objset3r
objsetf3
objaddf3


%index
objset3r
MOC情報を設定
%group
拡張画面制御命令
%prm
x,y,z
x   : 設定する値
y   : 設定する値2
z   : 設定する値3

%inst
MOC情報に角度情報を設定します。
オフセット番号0から3つのパラメータが対象になります。
整数値(256で１回転)をラジアン単位に変換してパラメーターを書き込みます。
角度を指定するパラメーター以外では正常な値にならないので注意してください。
%href
objset3
objadd3
objset3r
objsetf3
objaddf3


%index
setobjmode
オブジェクトのモード設定
%group
拡張画面制御命令
%prm
ObjID,mode,sw
ObjID    : オブジェクトID
mode     : モード値
sw       : 設定スイッチ
%inst
指定されたオブジェクトのモードを変更します。
モード値は、regobj命令で指定するものと同様です。
swは、以下のように動作します。
^p
	sw = 0 : 指定したモード値を追加
	sw = 1 : 指定したモード値を削除
	sw = 2 : 指定したモード値だけを設定
^p
%href
regobj
setobjmodel


%index
setcoli
オブジェクトのコリジョン設定
%group
拡張画面制御命令
%prm
id,mygroup,enegroup
id       : オブジェクトID
mygroup  : 自分が属するグループ値
enegroup : 衝突を検出する対象となるグループ値
%inst
オブジェクトに対してコリジョン情報を設定します。
グループ値は、1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768の中から1つだけを選択可能です。
%href
getcoli
findobj
nextobj


%index
getcoli
オブジェクトのコリジョン判定
%group
拡張画面制御命令
%prm
val,id,distance
val      : 結果が代入される変数名
id       : オブジェクトID
distance : 衝突を検出する範囲(実数値)
%inst
指定したオブジェクトが持つコリジョン情報をもとに、そのオブジェクトが衝突している別なオブジェクトのIDを調べます。
distanceは、衝突する範囲(半径)を実数値で指定します。
衝突が検出された場合は、変数にオブジェクトIDが代入されます。
何も衝突が検出されなかった場合は、-1が代入されます。
%href
setcoli
findobj
nextobj


%index
getobjcoli
オブジェクトのコリジョングループ取得
%group
拡張画面制御命令
%prm
var,id
var      : 結果が代入される変数名
id       : オブジェクトID
%inst
指定したオブジェクトが所属するコリジョングループを取得し、varで指定された変数に代入します。
コリジョングループ値は、setcoli命令で設定されたものになります。

%href
setcoli
getcoli



%index
findobj
オブジェクト検索
%group
拡張画面制御命令
%prm
exmode,group
exmode  : 検索を除外するモード
group   : 検索対象コリジョングループ値
%inst
指定したコリジョングループのオブジェクトだけを検索します。
最初にfindobjを実行して、次にnextobj命令で該当するオブジェクトを検索することができます。
また、exmodeで指定したモード(regobjで指定するモード値と同じ)は検索から除外されます。
%href
setcoli
nextobj


%index
nextobj
次のオブジェクト検索
%group
拡張画面制御命令
%prm
val
val      : 結果が代入される変数名
%inst
findobj命令で指定された条件をもとにオブジェクトを検索します。
検索されると、変数にオブジェクトIDが代入されます。
検索対象がなくなった時には-1が代入されます。
%href
setcoli
findobj


%index
setborder
オブジェクト有効範囲設定
%group
拡張画面制御命令
%prm
fx,fy,fz,option
( fx,fy,fz ) : ボーダー領域の設定値(実数値)
option(0) : 設定オプション(0～2)
%inst
ボーダー領域(オブジェクト有効範囲)を設定します。
optionパラメーターにより、( fx,fy,fz )に設定する内容が変わります。
optionパラメーターを省略するか、または0の場合は、
( 0,0,0 )を中心にした、( fx,fy,fz )サイズの立方体がボーダー領域となります。
optionパラメーターが1の場合は、( fx,fy,fz )の座標を数値が小さい側のボーダー領域として設定します。
optionパラメーターが2の場合は、( fx,fy,fz )の座標を数値が大きい側のボーダー領域として設定します。

%href
regobj
setobjmode


%index
selmoc
MOC情報を設定
%group
拡張画面制御命令
%prm
id, mocofs
id     : オブジェクトID
mocofs : MOCのグループ指定
%inst
MOC設定命令の対象となるMOCグループを指定します。
idは、オブジェクトIDとなります。
通常は、selpos,selang,selscale,seldir命令をお使いください。
%href
selpos
selang
selscale
seldir
selcam
selcpos
selcang
selcint


%index
objgetfv
MOC情報を取得
%group
拡張画面制御命令
%prm
fv
fv      = FV値が代入される変数名
%inst
MOCに設定されている値を変数fvに代入します。
%href
objsetfv
fvset
fvadd
fvsub
fvmul
fvdiv


%index
objsetfv
MOC情報を設定
%group
拡張画面制御命令
%prm
fv
fv      = FV値が代入されている変数名
%inst
変数fvの内容をMOCに設定します。
%href
objgetfv
fvset
fvadd
fvsub
fvmul
fvdiv


%index
objaddfv
MOC情報を加算
%group
拡張画面制御命令
%prm
fv
fv      = FV値が代入されている変数名
%inst
変数fvの内容をMOCに加算します。
%href
objgetfv
fvset
fvadd
fvsub
fvmul
fvdiv


%index
objexist
オブジェクトIDが有効か調べる
%group
拡張画面制御命令
%prm
p1
p1(0) : オブジェクトID
%inst
p1で指定されたオブジェクトIDが有効であるか調べます。
オブジェクトIDが有効(登録済み)の場合は、システム変数statに0が代入されます。
オブジェクトIDが無効(未登録)の場合は、システム変数statに-1が代入されます。

%href
regobj
delobj



