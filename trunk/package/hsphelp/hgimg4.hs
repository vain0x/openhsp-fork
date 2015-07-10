;
;	HSP help manager用 HELPソースファイル
;	(先頭が「;」の行はコメントとして処理されます)
;
%type
拡張命令
%ver
3.5
%note
hgimg4.asをインクルードすること。
%date
2015/03/05
%author
onitama
%dll
hgimg4
%url
http://www.onionsoft.net/
%port
Win
%portinfo
Windows+OpenGL3.1以降のシステム上でのみ動作します。



%index
gpreset
HGIMG4の初期化
%group
拡張画面制御命令
%prm
option
option(0) : 初期化オプション
%inst
HGIMG4の初期化を行ないます。
シーンを再構築する場合に使用してください。
optionで設定した内容によって初期化の内容が変わります。
^p
	オプション値  内容
	---------------------------------------------------------------
	    0         すべてのオブジェクトを破棄して初期状態に戻す
	    1         シーンに存在するオブジェクトのみ破棄する
^p
%href


%index
gpdraw
シーン内の全オブジェクトを描画する
%group
拡張画面制御命令
%prm
option
option(0) : 描画オプション
%inst
シーン内のオブジェクトをすべて描画します。
optionパラメーターを指定することで、限られた項目の描画だけを行なうことができます。
^p
        マクロ名                      内容
    --------------------------------------------------------------------
	GPDRAW_OPT_OBJUPDATE          オブジェクトの自動移動処理
	GPDRAW_OPT_DRAWSCENE          3Dシーン描画処理
	GPDRAW_OPT_DRAWSCENE_LATE     3Dシーン描画処理(OBJ_LATE)
	GPDRAW_OPT_DRAW2D             2Dスプライト描画処理
	GPDRAW_OPT_DRAW2D_LATE        2Dスプライト描画処理(OBJ_LATE)
^p
optionパラメーターを省略した場合は、すべての項目が選択されている状態になります。
通常は、optionパラメーターを指定しなくても問題ありません。
また、2Dの直接描画命令だけを使用して、オブジェクトによる描画が不要な場合は、gpdraw命令を記述する必要もありません。
OBJ_LATEのモードが付加されたもの(半透明α値が設定されているものを含む)は、不透明のオブジェクトよりも後に描画するため、項目が分けられています。
複数の項目を「|」で区切って指定することもできます。
^p
	例:
	gpdraw GPDRAW_OPT_DRAW2D|GPDRAW_OPT_DRAW2D_LATE
^p
上の例では、2Dスプライト描画処理、2Dスプライト描画処理(OBJ_LATE)だけを実行します。
これを利用すると、3Dシーン描画と2Dスプライト描画の間にgcopy命令など別な描画命令による
表示を行なうことが可能になります。

%href


%index
gpusescene
シーンの切り替え
%group
拡張画面制御命令
%prm
id
id(0) : 選択するシーンID
%inst
(今後のバージョンでサポートするための予約キーワードです。機能は現在まだ実装されていません。)
%href


%index
gpsetprm
オブジェクトのコアパラメーター設定
%group
拡張画面制御命令
%prm
objid,prmid,value
objid(0) : オブジェクトID
prmid(0) : コアパラメーターID
value(0) : 設定する値(整数値)
%inst
オブジェクトごとに保持されているコアパラメーターに値を設定します。
コアパラメーターは、32bit整数値で、様々な情報を管理しています。
コアパラメーターIDとして指定可能な項目は以下の通りです。
^p
	マクロ名             | 内容
	--------------------------------------------------------------
	PRMSET_FLAG            オブジェクト登録フラグ(*)
	PRMSET_MODE            モード値
	PRMSET_ID              オブジェクトID(*)
	PRMSET_ALPHA           透明度(α値)
	PRMSET_TIMER           タイマー値
	PRMSET_MYGROUP         自身のコリジョングループ
	PRMSET_COLGROUP        衝突検出するコリジョングループ
	PRMSET_SHAPE           形状ID(*)
	PRMSET_USEGPMAT        マテリアルID
	PRMSET_USEGPPHY        物理設定ID
	PRMSET_COLILOG         コリジョンログID(*)
	PRMSET_SPRID           ソースバッファID(スプライトのみ)
	PRMSET_SPRCELID        ソースのセルID(スプライトのみ)
	PRMSET_SPRGMODE        コピーモード(スプライトのみ)

	(*)の項目は読み出しのみ
^p
%href
gpgetprm


%index
gpgetprm
オブジェクトのコアパラメーター取得
%group
拡張画面制御命令
%prm
var,objid,prmid
var      : 値が代入される変数名
objid(0) : オブジェクトID
prmid(0) : コアパラメーターID
%inst
オブジェクトごとに保持されているコアパラメーターに値を取得します。
コアパラメーターは、32bit整数値で、様々な情報を管理しています。
コアパラメーターIDとして指定可能な項目は以下の通りです。
^p
	マクロ名             | 内容
	--------------------------------------------------------------
	PRMSET_FLAG            オブジェクト登録フラグ(*)
	PRMSET_MODE            モード値
	PRMSET_ID              オブジェクトID(*)
	PRMSET_ALPHA           透明度(α値)
	PRMSET_TIMER           タイマー値
	PRMSET_MYGROUP         自身のコリジョングループ
	PRMSET_COLGROUP        衝突検出するコリジョングループ
	PRMSET_SHAPE           形状ID(*)
	PRMSET_USEGPMAT        マテリアルID
	PRMSET_USEGPPHY        物理設定ID
	PRMSET_COLILOG         コリジョンログID(*)
	PRMSET_SPRID           ソースバッファID(スプライトのみ)
	PRMSET_SPRCELID        ソースのセルID(スプライトのみ)
	PRMSET_SPRGMODE        コピーモード(スプライトのみ)

	(*)の項目は読み出しのみ
^p
%href
gpsetprm



%index
gppostefx
ポストエフェクト生成
%group
拡張画面制御命令
%prm
var
var     : エフェクトIDが代入される変数名
%inst
(今後のバージョンでサポートするための予約キーワードです。機能は現在まだ実装されていません。)
%href


%index
gpuselight
ライトオブジェクトの切り替え
%group
拡張画面制御命令
%prm
id
id(0) : 選択するライトオブジェクトのID
%inst
指定したノードオブジェクトを有効なライトオブジェクトとして選択します。
必ず、ライトとして初期化されているノードオブジェクトを指定する必要があります。
ライトを切り替えることで、以降に生成されるオブジェクトを照らすライトが変更されます。
%href
gpusecamera


%index
gpusecamera
カメラオブジェクトの切り替え
%group
拡張画面制御命令
%prm
id
id(0) : 選択するカメラオブジェクトのID
%inst
指定したノードオブジェクトを有効なカメラオブジェクトとして選択します。
必ず、カメラとして初期化されているノードオブジェクトを指定する必要があります。
以降は、切り替えられたカメラを視点としてシーンの描画が行なわれます。
%href
gpuselight


%index
gpmatprm
マテリアルのパラメーター設定
%group
拡張画面制御命令
%prm
id,"name",x,y,z
id(0)  : マテリアルID
"name" : パラメーター名
x(0.0) : Xの設定値(実数値)
y(0.0) : Yの設定値(実数値)
z(0.0) : Zの設定値(実数値)
%inst
生成されたマテリアルのシェーダーパラメーターを設定します。
^p
	例:
	gpmatprm objid,"u_diffuseColor",1,0,0.5 ; マテリアルのパラメーター設定
^p
上の例では、u_diffuseColorという名称のパラメーターに( 1.0, 0.0, 0.5 )のベクトル値を設定します。
シェーダーパラメーターに設定する項目の数に応じて、gpmatprm1、gpmatprm4命令が用意されています。
(x,y,z)の3項目を設定する場合は、gpmatprmを使用してください。
%href
gpmat
gpmatprm1
gpmatprm4


%index
gpmatstate
マテリアルのステート設定
%group
拡張画面制御命令
%prm
objid,"name","value"
id(0)   : マテリアルID
"name"  : 設定項目名(文字列)
"value" : 設定値(文字列)
%inst
生成されたマテリアルの表示ステート設定を変更します。
文字列としてnameで指定された項目に対して、valueで指定された内容を設定します。
項目名と設定内容はすべて文字列で行なうので注意してください。
項目名と設定内容はすべて文字列で行なうので注意してください。(項目名及び設定値は大文字小文字を区別しません。)
^p
	name             value
    --------------------------------------------------------------------
	"blend"          プレンドの有効/無効切り替え
	                         (true または false を指定)
	"blendSrc"       ブレンド元を選択(下記参照)
	"blendDst"       ブレンド先を選択(下記参照)
	"cullFace"       隠面除去(カリング)の有効/無効切り替え
	                         (true または false を指定)
	"cullFaceSide"   隠面除去(カリング)の面指定
	"depthTest"      true または false
	                         (true または false を指定)
	"depthWrite"     Zバッファ書き込みの有効/無効切り替え
	                         (true または false を指定)
	"depthFunc"      Z値比較方法を選択(下記参照)

	(*)blendSrc,blendDstで設定できる文字列

	"ZERO"                     即値(0)
	"ONE"                      即値(1)
	"SRC_COLOR"                書き込み元カラー
	"ONE_MINUS_SRC_COLOR"      書き込み元カラー(反転値)
	"DST_COLOR"                書き込み先カラー
	"ONE_MINUS_DST_COLOR"      書き込み先カラー(反転値)
	"SRC_ALPHA"                書き込み元α
	"ONE_MINUS_SRC_ALPHA"      書き込み元α(反転値)
	"DST_ALPHA"                書き込み先α
	"ONE_MINUS_DST_ALPHA"      書き込み先α(反転値)
	"CONSTANT_ALPHA"           α固定値
	"ONE_MINUS_CONSTANT_ALPHA" α固定値(反転値)
	"SRC_ALPHA_SATURATE"       書き込み元α反転値

	(*)cullFaceSideで設定できる文字列

	BACK             裏面をカリング
	FRONT            表面をカリング
	FRONT_AND_BACK   両面をカリング

	(*)depthFuncで設定できる文字列

	NEVER            常に拒否
	LESS             小さい値の時のみ許可
	EQUAL            同一値のみ許可
	LEQUAL           同一か小さい値の時のみ許可
	GREATER          大きい値の時のみ許可
	NOTEQUAL         同一でない値のみ許可
	GEQUAL           同一か大きい値の時のみ許可
	ALWAYS           常に許可
^p
%href


%index
gpviewport
ビューポート設定
%group
拡張画面制御命令
%prm
x,y,sx,sy
x(0)  : ビューポート左上X座標
y(0)  : ビューポート左上Y座標
sx    : ビューポートのXサイズ
sy    : ビューポートのYサイズ
%inst
HGIMG4が描画を行なう領域(ビューポート)を設定します。
スクリーン座標の(x,y)から(sx,sy)で指定したサイズの領域に対して描画が行なわれます。
sx,syを省略すると、現在の表示X,Yサイズがデフォルトとして指定されます。
%href


%index
setobjname
オブジェクトのノード名を設定する
%group
拡張画面制御命令
%prm
objid,"name"
objid(0) : オブジェクトのID
"name"   : 設定される名称(文字列)
%inst
ノードオブジェクトに指定された名称を設定します。
すべてのノードオブジェクトは、任意に指定した名称を設定することが可能です。
%href
getobjname


%index
getobjname
オブジェクトのノード名を取得する
%group
拡張画面制御命令
%prm
var,objid
var      : 結果が代入される変数名
objid(0) : オブジェクトのID
%inst
ノードオブジェクトに指定された名称を取得します。
varで指定された変数に名称が文字列型として代入されます。
すべてのノードオブジェクトは、任意に指定した名称が設定されています。
%href
setobjname


%index
gpcolormat
カラーマテリアルの生成
%group
拡張画面制御命令
%prm
var,color,opt
var      : 生成されたマテリアルIDが代入される変数名
color(0) : マテリアルカラー(24bitRGB値)
opt(0)   : マテリアルオプション値
%inst
指定された色を持つカラーマテリアルの生成を行ないます。
colorパラメーターは、24bitRGB値(0xRRGGBBで示される値)を指定します。省略した場合は、白色(0xffffff)が設定されます。
マテリアルを独自に生成することにより、詳細な質感の設定が可能になります。

^p
	例:
	gpcolormat mat_id,0xff00ff,GPOBJ_MATOPT_NOLIGHT
	gpbox id_model, 1, , mat_id
^p
上の例では、RGBカラーが0xff00ff(紫)の、ライティングを行なわないマテリアルを持った、立方体のノードオブジェクトが生成されます。
optパラメーターにより、マテリアルの設定を変更することができます。
これらの設定は、gpmatstate命令で別途設定することも可能です。
^p
        マクロ名                内容
    -------------------------------------------------------------------
	GPOBJ_MATOPT_NOLIGHT    ライティングを行なわない
	GPOBJ_MATOPT_NOMIPMAP   MIPMAPを生成しない
	GPOBJ_MATOPT_NOCULL     カリングを無効にする
	GPOBJ_MATOPT_NOZTEST    Zテストを無効にする
	GPOBJ_MATOPT_NOZWRITE   Zバッファ書き込みを無効にする
	GPOBJ_MATOPT_BLENDADD   プレンドモードを加算に設定する
^p
正常にマテリアルが生成できなかった場合は、エラー3(パラメータの値が異常です)が発生します。
正しく生成された場合は、varで指定された変数にマテリアルID(整数値)が代入されます。

%href
gptexmat
gpusermat


%index
gptexmat
テクスチャマテリアルの生成
%group
拡張画面制御命令
%prm
var,"file",opt
var     : 生成されたマテリアルIDが代入される変数名
opt(0)  : マテリアルオプション値
%inst
テクスチャ(画像)マテリアルの生成を行ないます。
マテリアルを独自に生成することにより、詳細な質感の設定が可能になります。
^p
	例:
	gptexmat id_texmat, "res/qbox.png"	; テクスチャマテリアル作成
	gpbox id_model, 1, , id_texmat		; 箱ノードを追加
^p
上の例では、resフォルダ内のqbox.pngをテクスチャとして持ったマテリアルを持った、立方体のノードオブジェクトが生成されます。
optパラメーターにより、マテリアルの設定を変更することができます。
これらの設定は、gpmatstate命令で別途設定することも可能です。
^p
        マクロ名                内容
    -------------------------------------------------------------------
	GPOBJ_MATOPT_NOLIGHT    ライティングを行なわない
	GPOBJ_MATOPT_NOMIPMAP   MIPMAPを生成しない
	GPOBJ_MATOPT_NOCULL     カリングを無効にする
	GPOBJ_MATOPT_NOZTEST    Zテストを無効にする
	GPOBJ_MATOPT_NOZWRITE   Zバッファ書き込みを無効にする
	GPOBJ_MATOPT_BLENDADD   プレンドモードを加算に設定する
^p
正常にマテリアルが生成できなかった場合は、エラー3(パラメータの値が異常です)が発生します。
正しく生成された場合は、varで指定された変数にマテリアルID(整数値)が代入されます。

%href
gpcolormat
gpusermat


%index
gpusermat
カスタムマテリアルの生成
%group
拡張画面制御命令
%prm
var,"vsh","fsh","defs",color,opt
var       : 生成されたマテリアルIDが代入される変数名
"vsh"     : バーテックスシェーダーファイル名
"fsh"     : フラグメントシェーダーファイル名
"defs"    : 追加のラベル定義
color(-1) : マテリアルカラー(24bitRGB値)
opt(0)    : マテリアルオプション値
%inst
カスタムマテリアルを生成します。
カスタムマテリアルは、バーテックスシェーダー及びフラグメントシェーダーを指定した独自の描画を行ないます。
OpenGLのシェーダー言語(GLSL)で記述されたシェーダーファイル名を、"vsh"、"fsh"パラメーターに指定します。
"defs"パラメーターには、シェーダーコンパイル時に追加されるラベル定義を記述します。
colorパラメーターでデフォルトのカラーを設定することができます。省略した場合は、白色(0xffffff)が設定されます。
optパラメーターにより、マテリアルの設定を変更することができます。
これらの設定は、gpmatstate命令で別途設定することも可能です。
^p
        マクロ名                内容
    -------------------------------------------------------------------
	GPOBJ_MATOPT_NOLIGHT    ライティングを行なわない
	GPOBJ_MATOPT_NOMIPMAP   MIPMAPを生成しない
	GPOBJ_MATOPT_NOCULL     カリングを無効にする
	GPOBJ_MATOPT_NOZTEST    Zテストを無効にする
	GPOBJ_MATOPT_NOZWRITE   Zバッファ書き込みを無効にする
	GPOBJ_MATOPT_BLENDADD   プレンドモードを加算に設定する
^p
正常にマテリアルが生成できなかった場合は、エラー3(パラメータの値が異常です)が発生します。
正しく生成された場合は、varで指定された変数にマテリアルID(整数値)が代入されます。
^
カスタムマテリアルにより、任意のシェーダーを使って描画のすべてをコントロールすることができるようになります。
これは、シェーダーについての知識がある上級者向けの拡張機能ですので、通常は使用する必要はありません。
カスタムマテリアルを生成した場合は、gpmatprm命令によってシェーダーパラメーターに渡すための値を設定することができます。

%href
gpmatprm
gpcolormat
gptexmat


%index
gpclone
ノードを複製
%group
拡張画面制御命令
%prm
var,objid
var      : 複製されたオブジェクトのIDが代入される変数名
objid(0) : 複製元のオブジェクトID
%inst
既に存在するオブジェクトと同じ設定で、新しいオブジェクトを生成します。
varで指定された変数に、複製されたオブジェクトのIDが代入されます。
同一の形状、パラメーター設定(物理設定を除く)を持ちますが座標や角度などを新しく設定することができます。
同一の物体を複数生成する場合に、設定や読み込みを何度も行なう手間を軽減し高速化にもつながります。
^p
	例:
	gpload id_model,"res/duck"	; モデル読み込み
	gpclone i, id_model		; 同じものをクローン
^p
上の例では、res/duck.gpbファイルによる3Dモデルノード(id_model)をクローンして変数iに新しいオブジェクトIDを代入します。
※現在のバージョンでは、シーン内に存在する表示可能なオブジェクト以外はクローンすることができませんので注意してください。%href
gpdraw


%index
gpnull
ヌルノードを生成
%group
拡張画面制御命令
%prm
var
var : 生成されたオブジェクトIDが代入される変数名
%inst
空のノードオブジェクト(ヌルノード)を生成します。
varで指定された変数に、複製されたオブジェクトのIDが代入されます。
ヌルノードは、カメラやライトなどモデルを持つ必要のないノードを作成する場合などに使用します。
生成されたノードは、他のノードと同様に3D空間の中で自由に操作することが可能になります。
%href
gpcamera
gplight


%index
gpload
3Dモデルノードを生成
%group
拡張画面制御命令
%prm
var,"file","name"
var     : 生成されたオブジェクトIDが代入される変数名
"file"  : 読み込みを行なうgpbファイル名
"name"  : 読み込み対象となるノード名
%inst
ファイル化された3Dモデルデータ(.gpbファイル)をノードとして生成します。
varで指定された変数に、生成されたオブジェクトのIDが代入されます。
生成されたノードは3D空間の中で自由に操作することが可能になります。
"file"でフォルダ及びファイル名を指定します。「.gpb」などの拡張子は指定する必要ありません。
ファイルの中で特定の名前を持ったノードだけを読み込みたい場合は、"name"で指定することができます。
"name"の指定を省略した場合は、ファイルに含まれている階層構造をすべて読み込みノードとして生成します。
ノードに物理設定を行なう場合は、gppbind命令を使用してください。
3Dモデルデータの接触判定は、全体を包む球(バウンディング球)が使用されます。
^
生成されたオブジェクト(ノード)の描画はgpdraw命令によりまとめて行なわれます。
^p
	例:
	gpload id_model,"res/duck"		; モデル読み込み
^p
上の例では、resフォルダ内にあるduck.gpbファイルを読み込みます。
その際に、マテリアル情報が書かれているduck.materialファイルが参照されます。
さらに、テクスチャが必要な場合は、同じフォルダ内の画像ファイルも読み込まれます。
^
gpload命令で読み込むためのファイル(.gpb形式)は、gameplay3Dで標準的に使用されているデータ形式です。
HGIMG4では、.gpb形式を生成するためのGPBコンバーター(gpbconv.exe)を用意しています。
詳しくは、HGIMG4マニュアルを参照してください。
%href
gpdraw
gppbind


%index
gpplate
板ノードを生成
%group
拡張画面制御命令
%prm
var,sizex,sizey,color,matobj
var        : 生成されたオブジェクトIDが代入される変数名
sizex(1)   : 生成されるXサイズ
sizey(1)   : 生成されるYサイズ
color(-1)  : マテリアルカラー(24bitRGB値)
matobj(-1) : マテリアルID
%inst
垂直に立った1枚の板(四角形)を3Dモデルデータとしてノードを生成します。
varで指定された変数に、生成されたオブジェクトのIDが代入されます。
生成されたノードは3D空間の中で自由に操作することが可能になります。
モデルのX,Yサイズをsizex,sizeyパラメーターで指定することができます。
colorパラメーターでモデルの色(マテリアルカラー)を24bitRGB値(0xRRGGBBで示される値)により指定します。
colorパラメーターが省略された場合は、白色(0xffffff)が使用されます。
matobjパラメーターで、マテリアルIDを指定することができます。
gpcolormat命令などにより、ユーザーが生成したマテリアルを使用する場合は指定してください。
matobjパラメーターが省略された場合は、標準のマテリアルが使用されます。
^
生成されたオブジェクト(ノード)の描画はgpdraw命令によりまとめて行なわれます。
^
ノードに物理設定を行なう場合は、gppbind命令を使用してください。
ノードの接触判定は、もとのモデルと同じ形状が使用されます。
%href
gpdraw
gppbind


%index
gpfloor
床ノードを生成
%group
拡張画面制御命令
%prm
var,sizex,sizey,color,matobj
var     : 生成されたオブジェクトIDが代入される変数名
%inst
1枚の床(四角形)を3Dモデルデータとしてノードを生成します。
varで指定された変数に、生成されたオブジェクトのIDが代入されます。
生成されたノードは3D空間の中で自由に操作することが可能になります。
モデルのX,Yサイズをsizex,sizeyパラメーターで指定することができます。
colorパラメーターでモデルの色(マテリアルカラー)を24bitRGB値(0xRRGGBBで示される値)により指定します。
colorパラメーターが省略された場合は、白色(0xffffff)が使用されます。
matobjパラメーターで、マテリアルIDを指定することができます。
gpcolormat命令などにより、ユーザーが生成したマテリアルを使用する場合は指定してください。
matobjパラメーターが省略された場合は、標準のマテリアルが使用されます。
^
生成されたオブジェクト(ノード)の描画はgpdraw命令によりまとめて行なわれます。
^
ノードに物理設定を行なう場合は、gppbind命令を使用してください。
(床モデルは標準で、同じ場所に固定された物理特性が設定されます)
ノードの接触判定は、もとのモデルと同じ形状が使用されます。
%href
gpdraw
gppbind


%index
gpbox
箱ノードを生成
%group
拡張画面制御命令
%prm
var,size,color,matobj
var     : 生成されたオブジェクトIDが代入される変数名
%inst
指定サイズの立方体を3Dモデルデータとしてノードを生成します。
varで指定された変数に、生成されたオブジェクトのIDが代入されます。
生成されたノードは3D空間の中で自由に操作することが可能になります。
モデルのX,Yサイズをsizex,sizeyパラメーターで指定することができます。
colorパラメーターでモデルの色(マテリアルカラー)を24bitRGB値(0xRRGGBBで示される値)により指定します。
colorパラメーターが省略された場合は、白色(0xffffff)が使用されます。
matobjパラメーターで、マテリアルIDを指定することができます。
gpcolormat命令などにより、ユーザーが生成したマテリアルを使用する場合は指定してください。
matobjパラメーターが省略された場合は、標準のマテリアルが使用されます。
^
生成されたオブジェクト(ノード)の描画はgpdraw命令によりまとめて行なわれます。
^
ノードに物理設定を行なう場合は、gppbind命令を使用してください。
ノードの接触判定は、もとのモデルと同じ形状が使用されます。
%href
gpdraw
gppbind


%index
gpspr
2Dスプライトノード生成
%group
拡張画面制御命令
%prm
var,bufid,celid,gmode
var     : 生成されたオブジェクトIDが代入される変数名
%inst
2Dスプライトを表示するためのノードを生成します。
varで指定された変数に、生成されたオブジェクトのIDが代入されます。
生成されたノードは2Dスクリーンの中で自由に操作することが可能になります。
bufidパラメーターで表示元の画像が読み込まれているバッファIDを、celidパラメーターで表示するセルIDを指定します。
また、gmodeパラメーターでgcopy命令で指定するものと同様のコピーモードを指定します。
^p
	 gmode値  |  内容
	---------------------------------------------------
	    0,1      アルファチャンネル無効
	    2        アルファチャンネル有効
	    5        色加算・アルファチャンネル有効
^p
生成されたオブジェクト(ノード)の描画はgpdraw命令によりまとめて行なわれます。
^p
	; スプライト1個あたりの描画
	gmode [gmode設定値]
	pos [ノードX座標],[ノードY座標]
	celput [バッファID], [セルID], [ノードXスケール], [ノードYスケール], [ノードZ回転]
^p
つまり、2Dスプライトノードは上のような処理をあらかじめ登録した設定をまとめて行なう機能と考えることができます。
また、getcoli命令による2Dスプライトノード同士の接触判定を手軽に行なうことが可能です。
%href
gpdraw


%index
gplight
ライトノードを設定
%group
拡張画面制御命令
%prm
id,opt,range,inner,outer
id(0)     : オブジェクトのID
opt(0)    : ライト生成オプション
range(1)  : 影響範囲パラメーター
inner(0.5): 内側の減衰パラメーター
outer(1)  : 外側の減衰パラメーター
%inst
生成済みのノードにライトとしての機能を追加します。
idパラメーターで、ノードのオブジェクトIDを指定します。
optパラメーターでライト生成オプション値を指定することができます。
^p
	  opt値               |  内容
	--------------------------------------------------------------
	  GPOBJ_LGTOPT_NORMAL    平行光源(ディレクショナルライト)
	  GPOBJ_LGTOPT_POINT     点光源(ポイントライト)
	  GPOBJ_LGTOPT_SPOT      スポットライト
^p
rangeパラメーターは、点光源及びスポットライトの影響範囲に関する設定を行ないます。
また、inner,outerパラメーターは、スポットライトの減衰効果に関する設定を行ないます。
現在のバージョンでは平行光源のみサポートされています。
^p
	例:
	gpnull id_alight			; ヌルノードを生成する
	gplight id_alight, GPOBJ_LGTOPT_NORMAL	; ライトとして登録する
	gpuselight id_alight			; デフォルトのライトに設定
^p
シーン内に配置されたライトは、gpuselight命令により切り替えてからマテリアルを生成することで反映されます。
%href
gpuselight
gpnull


%index
gpcamera
カメラノードを設定
%group
拡張画面制御命令
%prm
id,fov,aspect,near,far
id(0)      : オブジェクトのID
fov(45)    : 視野(FOV)パラメーター
aspect(1.5): アスペクト比
near(0.5)  : ニアクリップZ値
far(768)   : ファークリップZ値
%inst
生成済みのノードにカメラとしての機能を追加します。
idパラメーターで、ノードのオブジェクトIDを指定します。
fovパラメーターで視野(FOV)を設定します。45を指定した場合は、45度の視野となります。
aspectパラメーターでアスペクト比(縦横比)を指定します。
また、near,farパラメーターにより近くと遠くのZ座標(クリッピングに使われるZ座標)を指定することができます。
^p
	例:
	gpnull id_camera			; ヌルノードを生成する
	gpcamera id_camera, 45, 1.5, 0.5, 768	; カメラとして設定する
	gpusecamera id_camera			; 使用するカメラを選択する
	setpos id_camera, 0,20,20		; カメラ位置を設定する
^p
シーン内に配置されたカメラは、gpusecamera命令により切り替えることができます。

%href
gpusecamera
gpnull


%index
gplookat
指定座標に向けてノードを回転
%group
拡張画面制御命令
%prm
objid,x,y,z
objid(0)  : オブジェクトID
x(0)      : 目標となるX座標
y(0)      : 目標となるY座標
z(0)      : 目標となるZ座標
%inst
3Dノードを、指定した座標に向けて回転させます。
カメラに適用した場合は、指定座標を注視する角度に設定されます。
%href


%index
gppbind
ノードに標準的な物理特性を設定
%group
拡張画面制御命令
%prm
objid,mass,friction
objid(0)      : オブジェクトID
mass(1)       : 重さ
friction(0.5) : 摩擦係数
%inst
ノードオブジェクトに対して、基本的な物理設定を行ないます。
massパラメーターは物体の重さ。frictionパラメーターは摩擦係数です。値を省略した場合は、デフォルト値が使用されます。
重さ(mass)を0にすることで静的剛体(衝突はするが、動かない)として設定されます。
それ以外の場合は、物理法則に従って床のある場所まで落下します。
^
※物理挙動を設定する場合は、必ず床(地面)となる部分を作成しておいてください。
gpfloor命令によって生成された床に標準的な物理特性を設定することで、固定された床面を生成することができます。
床が存在しなかった場合、物体は永遠に落下を続けることになります。
^
物理設定を行なったノードオブジェクトは、それ以降自立して動作するようになり、setposなどの座標変更は無効となります。
物体に力を加えたい場合は、gppapply命令を使用してください。

%href
gppapply


%index
getwork2
ノードワーク値2を取得
%group
拡張画面制御命令
%prm
id,x,y,z
id      : オブジェクトID
(x,y,z) : 取得する変数
%inst
オブジェクトの持つwork2パラメーターを取得します。
(x,y,z)は、実数型の変数として設定されます。
命令の最後に「i」を付加することで、整数値として値を取得することができます。
%href
getwork2i


%index
getwork2i
ノードワーク値2を取得(整数値)
%group
拡張画面制御命令
%prm
id,x,y,z
id      : オブジェクトID
(x,y,z) : 取得する変数
%inst
オブジェクトの持つwork2パラメーターを取得します。
(x,y,z)は、整数型の変数として設定されます。
getwork2命令を使用することで、実数値として値を取得することができます。
%href
getwork2


%index
selquat
オブジェク回転情報をMOC情報に設定
%group
拡張画面制御命令
%prm
id
id(0) : オブジェクトID
%inst
MOC設定命令の対象となるMOCグループをquat(クォータニオン回転情報)に設定します
idは、オブジェクトIDとなります。
%href


%index
selwork2
オブジェクトワーク2をMOC情報に設定
%group
拡張画面制御命令
%prm
id
id(0) : オブジェクトID
%inst
MOC設定命令の対象となるMOCグループをwork2(ワーク2)に設定します
idは、オブジェクトIDとなります。
%href


%index
setwork2
work2グループ情報を設定
%group
拡張画面制御命令
%prm
id,x,y,z
id      : オブジェクトID
(x,y,z) : 設定する値 (デフォルト=0)
%inst
オブジェクトの持つパラメーターを設定します。
work2グループ(ワーク2値)に(x,y,z)で指定された値を設定します。
(x,y,z)には、実数または整数値を指定することができます。
%href
setwork


%index
addwork2
work2グループ情報を加算
%group
拡張画面制御命令
%prm
id,x,y,z
id      : オブジェクトID
(x,y,z) : 設定する値 (デフォルト=0)
%inst
オブジェクトの持つパラメーターを設定します。
work2グループ(ワーク2値)に(x,y,z)で指定された値を加算します。
(x,y,z)には、実数または整数値を指定することができます。
%href
addwork


%index
gpcnvaxis
3D座標の変換を行なう
%group
拡張画面制御命令
%prm
var_x,var_y,var_z,x,y,z,mode
var_x   : X値が代入される変数
var_y   : Y値が代入される変数
var_z   : Z値が代入される変数
x(0.0)  : 変換元のX値
y(0.0)  : 変換元のY値
z(0.0)  : 変換元のZ値
mode(0) : 変換モード
%inst
(今後のバージョンでサポートするための予約キーワードです。機能は現在まだ実装されていません。)
%href


%index
gppset
ノードの物理パラメーターを設定
%group
拡張画面制御命令
%prm
objid,prmid,x,y,z
objid(0)  : オブジェクトID
prmid(0)  : パラメーターID
x(0.0)    : 設定パラメーターX値
y(0.0)    : 設定パラメーターY値
z(0.0)    : 設定パラメーターZ値
%inst
objidで指定されたノードの詳細な物理パラメーターを設定します。
prmidパラメーターで、設定する項目を指定し、X,Y,Zに指定された値が、それぞれの項目に対応した値として適用されます。
^p
        マクロ名                          内容
    ----------------------------------------------------------------------------
	GPPSET_ENABLE                     X=物理挙動のON/OFF(0=無効)
	GPPSET_FRICTION                   X=摩擦係数, Y=弾力設定
	GPPSET_DAMPING                    X=linear反発(0～1.0), Y=angular反発(0～1.0)
	GPPSET_KINEMATIC                  X=Kinematic設定のON/OFF(0=無効)
	GPPSET_ANISOTROPIC_FRICTION       X,Y,Z=異方性の摩擦
	GPPSET_GRAVITY                    X,Y,Z=重力
	GPPSET_LINEAR_FACTOR              X,Y,Z=ベクトルに沿った移動の設定
	GPPSET_ANGULAR_FACTOR             X,Y,Z=ベクトルに沿った回転の設定
	GPPSET_ANGULAR_VELOCITY           X,Y,Z=回転ベロシティー
	GPPSET_LINEAR_VELOCITY            X,Y,Z=リニアベロシティー
^p
必ずgppbind命令で基本的な物理特性を設定した後で詳細設定を行なうようにしてください。
設定値が正しくない場合は、エラーが発生します。
%href
gppbind


%index
gpobjpool
オブジェクトID生成の設定
%group
拡張画面制御命令
%prm
start,num
start(0) : 割り当て開始番号
num(-1)  : 最大割り当て数
%inst
オブジェクトIDの割り当て方法を変更します。
オブジェクトIDは、あらかじめ決められた最大数の中で、使用されていないID番号が割り当てられます。
オブジェクト最大数は、デフォルトで1024個となっており、sysreq命令によって拡張することが可能です。
^p
	例:
	setreq SYSREQ_MAXOBJ,4096	; オブジェクト最大数を4096に拡張する
^p
gpobjpool命令は、ID番号の割り当て範囲を任意に変更することができます。
startパラメーターで指定された番号を割り当て開始番号に設定します。
numパラメーターで指定された番号を割り当てられる最大数に設定します。
numパラメーターがマイナス値か省略されていた場合は、割り当て開始番号から最大限取れる範囲が設定されます。
^p
	例:
	gpobjpool 100,50	; オブジェクトID生成の設定変更
^p
上の例では、ID番号100～150のみを割り当て対象に変更します。
これ以降のオブジェクト生成命令(gpboxやgpnullなど)では、指定された範囲内のオブジェクトIDのみが割り当てられます。
オブジェクト全体の中で特定の個数までしか生成されないように制限したい場合や、
表示順序をある程度コントロールしたい場合に利用できます。
gpobjpool命令によって、あらかじめ設定されたオブジェクト最大数を拡張することはできません。
必ず最大数の範囲内で設定を行なうよう注意してください。
%href
delobj


%index
gppapply
ノードに物理的な力を適用する
%group
拡張画面制御命令
%prm
objid,action,x,y,z
objid(0)  : オブジェクトID
action(0) : 力の種類(タイプ)
x(0.0)    : 設定パラメーターX値
y(0.0)    : 設定パラメーターY値
z(0.0)    : 設定パラメーターZ値
%inst
ノードに対して(x,y,z)で指定したベクトルの物理的な力を適用します。
actionパラメーターで設定できるタイプは、以下の通りです。
^p
        マクロ名                     内容
    ----------------------------------------------------------------------------
	GPPAPPLY_FORCE               移動しようとする力を加算する
	GPPAPPLY_IMPULSE             瞬間的な衝撃を与える
	GPPAPPLY_TORQUE              トルク(ねじる)力を与える
	GPPAPPLY_TORQUE_IMPULSE      トルク+衝撃を与える
^p
必ずgppbind命令で基本的な物理特性を設定した後で力を適用するようにしてください。
設定値が正しくない場合は、エラーが発生します。
%href
gppbind


%index
gpmatprm1
マテリアルのパラメーター設定(2)
%group
拡張画面制御命令
%prm
id,"name",value
id(0)      : マテリアルID
"name"     : パラメーター名
value(0.0) : Xの設定値(実数値)
%inst
生成されたマテリアルのシェーダーパラメーターを設定します。
gpmatprm命令と基本的に同じ機能です。
gpmatprm1命令は、1項目のみの実数パラメーターを指定します。
%href
gpmat
gpmatprm
gpmatprm4


%index
gpmatprm4
マテリアルのパラメーター設定(3)
%group
拡張画面制御命令
%prm
id,"name",x,y,z,w
id(0)  : マテリアルID
"name" : パラメーター名
x(0.0) : Xの設定値(実数値)
y(0.0) : Yの設定値(実数値)
z(0.0) : Zの設定値(実数値)
w(0.0) : Wの設定値(実数値)
%inst
生成されたマテリアルのシェーダーパラメーターを設定します。
gpmatprm命令と基本的に同じ機能です。
gpmatprm4命令は、4項目(x,y,z,w)の実数パラメーターを指定します。
%href
gpmat
gpmatprm
gpmatprm1


%index
setalpha
オブジェクトの透明度(α値)設定
%group
拡張画面制御命令
%prm
objid,value
objid(0)   : オブジェクトID
value(255) : 設定する値(整数値)(0～255)
%inst
オブジェクトの透明度(α値)を設定します。
valueパラメーターで指定された値を、objidパラメーターのオブジェクトに設定します。
valueパラメーターで指定する値は、透明度を示す0～255の整数値(α値)となります。
0は完全な透明、255は不透明が適用されます。
α値が255以外(半透明)の状態となったオブジェクトは、描画順序が前面に変更されます。
(OBJ_LATEのモードが指定されたのと同じ状態)
%href
gpsetprm


