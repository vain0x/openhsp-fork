;
;	HSP help manager用 HELPソースファイル
;	(先頭が「;」の行はコメントとして処理されます)
;

%type
拡張命令
%ver
3.4
%note
hspcv.asをインクルードすること。

%date
2009/08/01
%author
onitama
%dll
hspcv
%url
http://hsp.tv/
%port
Win


%index
cvreset
HSPCVの初期化
%group
拡張画面制御命令
%inst
HSPCVが持つ「CVバッファ」をすべて破棄して、初期状態に戻します。
HSPCVの開始、終了時には自動的に初期化が行なわれます。
明示的に初期化したい時にcvreset命令を使用してください。



%index
cvsel
対象CVバッファの設定
%group
拡張画面制御命令
%prm
p1
p1 : CVバッファID
%inst
標準の操作先CVバッファIDを設定します。
パラメーターで、CVバッファIDを指定する時に省略した場合には、標準の操作先CVバッファIDが使用されます。



%index
cvbuffer
CVバッファを初期化
%group
拡張画面制御命令
%prm
p1,p2,p3
p1(0)   : CVバッファID
p2(640) : 横のピクセルサイズ
p3(480) : 縦のピクセルサイズ
%inst
指定したサイズでCVバッファを初期化します。
バッファを初期化することにより、各種画像処理が可能になります。
CVバッファは、フルカラーモード(RGB各8bit)で初期化されます。
%href
cvload



%index
cvresize
画像のリサイズ
%group
拡張画面制御命令
%prm
p1,p2,p3,p4
p1(0) : 横のピクセルサイズ
p2(0) : 縦のピクセルサイズ
p3 : CVバッファID
p4(1) : 補間アルゴリズム
%inst
CVバッファを(p1,p2)で指定したサイズに変更します。
p3で対象となるCVバッファIDを指定します。
省略された場合は、cvsel命令で設定されたIDが使用されます。
p4で補間アルゴリズムを指定します。
p4で指定する内容は以下から1つ選ぶことができます。
^p
	CV_INTER_NN - ニアレストネイバー
	CV_INTER_LINEAR - バイリニア(デフォルト)
	CV_INTER_AREA - ピクセル周辺をリサンプリング
	                (モアレを低減することができます)
	CV_INTER_CUBIC - バイキュービック
^p



%index
cvgetimg
画像の取得
%group
拡張画面制御命令
%prm
p1,p2
p1(0) : CVバッファID
p2(0) : 取得モード
%inst
CVバッファの内容をHSPのウィンドウバッファに転送します。
転送先となるHSPのウィンドウバッファは、gsel命令で指定されている現在の操作先ウィンドウIDとなります。
p1で転送元となるCVバッファIDを指定します。
省略された場合は、ID0が使用されます。
p2で、転送時の方法を指定することができます。
p2が0の場合は、HSPのウィンドウバッファサイズはそのままで転送を行ないます。
p2に1を指定した場合は、CVバッファと同じサイズにHSPのウィンドウバッファサイズを変更した上で転送を行ないます。
%href
cvputimg



%index
cvputimg
CVバッファに書き込み
%group
拡張画面制御命令
%prm
p1
p1 : CVバッファID
%inst
HSPのウィンドウバッファ内容をCVバッファに転送します。
転送元となるHSPのウィンドウバッファは、gsel命令で指定されている現在の操作先ウィンドウIDとなります。
p1で転送先となるCVバッファIDを指定します。
省略された場合は、cvsel命令で設定されたIDが使用されます。
%href
cvgetimg


%index
cvload
画像ファイル読み込み
%group
拡張画面制御命令
%prm
"filename",p1
"filename" : 画像ファイル名
p1 : CVバッファID
%inst
CVバッファを指定された画像ファイルの内容で初期化します。
p1で対象となるCVバッファIDを指定します。
省略された場合は、cvsel命令で設定されたIDが使用されます。

画像ファイルのフォーマットはファイル拡張子によって判断されます。
使用できるフォーマットと拡張子は以下の通りです。
^p
	Windows bitmaps - BMP, DIB
	JPEG files - JPEG, JPG, JPE
	Portable Network Graphics - PNG
	Portable image format - PBM, PGM, PPM
	Sun rasters - SR, RAS
	TIFF files - TIFF, TIF
	OpenEXR HDR images - EXR
	JPEG 2000 images - JP2
^p
処理が正常に終了した場合には、システム変数statが0になります。
何らかのエラーが発生した場合には、システム変数statが0以外の値となります。
#pack、#epack等で実行ファイル及びDPMファイルに埋め込まれたファイルは読み込むことができませんので注意してください。
%href
cvsave



%index
cvsave
画像ファイル書き込み
%group
拡張画面制御命令
%prm
"filename",p1,p2
"filename" : 画像ファイル名
p1 : CVバッファID
p2 : オプション値
%inst
CVバッファの内容を指定された画像ファイル名で保存します。
p1で対象となるCVバッファIDを指定します。
省略された場合は、cvsel命令で設定されたIDが使用されます。

画像ファイルのフォーマットはファイル拡張子によって判断されます。
使用できるフォーマットと拡張子は以下の通りです。
^p
	Windows bitmaps - BMP, DIB
	JPEG files - JPEG, JPG, JPE
	Portable Network Graphics - PNG
	Portable image format - PBM, PGM, PPM
	Sun rasters - SR, RAS
	TIFF files - TIFF, TIF
	OpenEXR HDR images - EXR
	JPEG 2000 images - JP2
^p
p2で指定するオプション値は、フォーマットごとの設定を指定するためのものです。
現在は、JPEGフォーマット保存時の品質(0～100)のみ指定可能です。
p2の指定を省略した場合は、JPEGフォーマット保存時に、品質95が使用されます。
処理が正常に終了した場合には、システム変数statが0になります。
何らかのエラーが発生した場合には、システム変数statが0以外の値となります。
%href
cvload



%index
cvgetinfo
CVバッファ情報を取得
%group
拡張画面制御命令
%prm
p1,p2,p3
p1 : CVバッファ情報が取得される変数
p2 : CVバッファID
p3 : CVバッファ情報ID
%inst
CVバッファに関する情報を取得してp1の変数に代入します。
p2で対象となるCVバッファIDを指定します。
省略された場合は、cvsel命令で設定されたIDが使用されます。

p3で取得する情報の種類を指定することができます。
p3に指定できるマクロは以下の通りです。
^p
	マクロ               内容
	-------------------------------------------
	CVOBJ_INFO_SIZEX     横方向サイズ
	CVOBJ_INFO_SIZEY     縦方向サイズ
	CVOBJ_INFO_CHANNEL   チャンネル数
	CVOBJ_INFO_BIT       チャンネルあたりのビット数
^p
%href
cvbuffer
cvload



%index
cvsmooth
画像のスムージング
%group
拡張画面制御命令
%prm
p1,p2,p3,p4,p5
p1 : スムージングのタイプ
p2 : param1
p3 : param2
p4 : param3
p5 : CVバッファID
%inst
CVバッファにスムージングを適用します。
p5で対象となるCVバッファIDを指定します。
省略された場合は、cvsel命令で設定されたIDが使用されます。

p1で指定することのできるマクロは以下の通りです。

CV_BLUR_NO_SCALE
(param1×param2の領域でピクセル値を足し合わせる)

CV_BLUR
(param1×param2の領域でピクセル値を足し合わせた後、
 1/(param1*param2)でスケーリングする)

CV_GAUSSIAN
(param1×param2ガウシアンフィルタ)

CV_MEDIAN
(param1×param2メディアンフィルタ)

CV_BILATERAL
(3×3バイラテラルフィルタ(param1=色分散, param2=空間分散))
^p
http://www.dai.ed.ac.uk/CVonline/LOCAL_COPIES/MANDUCHI1/Bilateral_Filtering.html
^p
「param1×param2」のパラメーターは、1以上の奇数を指定する必要があります。



%index
cvthreshold
画像を閾値で取得
%group
拡張画面制御命令
%prm
p1,p2,p3,p4
p1 : ２値化タイプ
p2 : 閾値(実数)
p3 : 二値化後の画素値(実数)
p4 : CVバッファID
%inst
CVバッファに対して閾値をもとに２値化を行ないます。
p4で対象となるCVバッファIDを指定します。
省略された場合は、cvsel命令で設定されたIDが使用されます。
p1で指定することのできるマクロは以下の通りです。
^p
CV_THRESH_BINARY     : val = (val > thresh ? MAX:0)
CV_THRESH_BINARY_INV : val = (val > thresh ? 0:MAX)
CV_THRESH_TRUNC      : val = (val > thresh ? thresh:val)
CV_THRESH_TOZERO     : val = (val > thresh ? val:0)
CV_THRESH_TOZERO_INV : val = (val > thresh ? 0:val)
^p




%index
cvrotate
画像の回転
%group
拡張画面制御命令
%prm
p1,p2,p3,p4,p5,p6
p1(0) : 角度(実数)
p2(1) : スケール(実数)
p3(0) : 中心座標のXオフセット(実数)
p4(0) : 中心座標のYオフセット(実数)
p5 : 補間アルゴリズム
p6 : CVバッファID
%inst
CVバッファ全体を回転させます。
p1で角度(360度で一周)を、p2でスケールを設定します。
(p3,p4)で中心のオフセットを指定することがてきます。
p5で、回転時の補間アルゴリズムを指定します。
p5で指定する内容は以下から1つ選ぶことができます。
^p
	CV_INTER_NN - ニアレストネイバー
	CV_INTER_LINEAR - バイリニア(デフォルト)
	CV_INTER_AREA - ピクセル周辺をリサンプリング
	                (モアレを低減することができます)
	CV_INTER_CUBIC - バイキュービック
^p
また、p5に同時指定できるオプションが用意されています。
^p
	CV_WARP_FILL_OUTLIERS - 外部ピクセルを埋める
	CV_WARP_INVERSE_MAP - 回転を逆行列で行なう
^p
デフォルトでは、CV_INTER_LINEAR+CV_WARP_FILL_OUTLIERSが指定されています。
p6で対象となるCVバッファIDを指定します。
省略された場合は、cvsel命令で設定されたIDが使用されます。



%index
cvarea
コピー元領域の指定
%group
拡張画面制御命令
%prm
p1,p2,p3,p4
p1(0) : コピー元 X座標
p2(0) : コピー元 Y座標
p3(0) : コピー領域 Xサイズ
p4(0) : コピー領域 Yサイズ
%inst
cvcopy命令で画像のコピーを行なう際のコピー元領域を指定します。
パラメーターがすべて0の場合や、すべて省略してcvarea命令を実行した場合は、CVバッファ全体が対象になります。
%href
cvcopy



%index
cvcopy
画像のコピー
%group
拡張画面制御命令
%prm
p1,p2,p3,p4,p5
p1(0) : コピー元CVバッファID
p2(0) : コピー先 X座標
p3(0) : コピー先 Y座標
p4 : コピー先CVバッファID
p5(0) : 演算オプション
%inst
CVバッファの内容を別なCVバッファにコピーします。
p1で指定されたCVバッファIDがコピー元として使用されます。
バッファの一部をコピーする場合には、cvarea命令で位置やサイズをあらかじめ設定しておく必要があります。
p5の演算オプションにより、コピー時にいくつかの演算を行なうことが可能です。p5に指定できるマクロは以下の通りです。
^p
	CVCOPY_SET (上書きコピー)
	CVCOPY_ADD (加算)
	CVCOPY_SUB (減算)
	CVCOPY_MUL (乗算)
	CVCOPY_DIF (差分)
	CVCOPY_AND (論理積)
^p
p4でコピー先となるCVバッファIDを指定します。
省略された場合は、cvsel命令で設定されたIDが使用されます。

CVバッファの色モードは、コピー元とコピー先で合わせておく必要があります。
グレイスケール(白黒)画面とフルカラー画面を混在してコピーすることはできません。
%href
cvarea



%index
cvxors
画像のXOR演算
%group
拡張画面制御命令
%prm
p1,p2,p3,p4
p1(255) : XOR演算で使用するR値
p2(255) : XOR演算で使用するG値
p3(255) : XOR演算で使用するB値
p4 : コピー先CVバッファID
%inst
CVバッファの内容に対してXOR演算を行ないます。
p1～p3までで、RGB値に対する演算値(0～255)を指定します。
p4で対象となるCVバッファIDを指定します。
省略された場合は、cvsel命令で設定されたIDが使用されます。
%href
cvcopy



%index
cvflip
画像の反転
%group
拡張画面制御命令
%prm
p1,p2
p1(0) : 反転のモード
p2 : コピー先CVバッファID
%inst
CVバッファの内容を反転させます。
p1で反転のモードを指定することができます。
p1が0の場合は、上下反転になります。
p1が1以上の場合は、左右反転になります。
p1がマイナス値の場合は、上下左右ともに反転されます。

p2で対象となるCVバッファIDを指定します。
省略された場合は、cvsel命令で設定されたIDが使用されます。



%index
cvloadxml
XMLファイルの読み込み
%group
拡張画面制御命令
%prm
"filename"
"filename" : 読み込むXMLファイル名
%inst
"filename"で指定されたファイルをXMLファイルとして読み込みます。
XMLファイルは、画像の顔認識等で必要な場合にあらかじめ読み込んでおく必要があります。

処理が正常に終了した場合には、システム変数statが0になります。
何らかのエラーが発生した場合には、システム変数statが0以外の値となります。

#pack、#epack等で実行ファイル及びDPMファイルに埋め込まれたファイルは読み込むことができませんので注意してください。
%href
cvfacedetect



%index
cvfacedetect
画像の顔認識
%group
拡張画面制御命令
%prm
p1,p2
p1 : CVバッファID
p2(1) : スケール値(実数)
%inst
CVバッファの画像から特定のパターンを認識します。
パターンのパラメーターを持つxmlファイルを、あらかじめcvloadxml命令で読み込んでおく必要があります。

p1で対象となるCVバッファIDを指定します。
省略された場合は、cvsel命令で設定されたIDが使用されます。

p2で処理時のスケールを設定することができます。
ここで1より大きい値を指定すると、処理時にバッファサイズを縮小して処理されるようになります。大きな画像等で時間が
かかる場合などに指定するといいでしょう。

実行後に、システム変数statに認識された数が返されます。
statが0の場合は、まったく認識されていないことを示します。
statが1以上の場合は、cvgetface命令によって認識された領域を取得することができます。
%href
cvgetface
cvloadxml



%index
cvgetface
認識された座標の取得
%group
拡張画面制御命令
%prm
p1,p2,p3,p4
p1 : 認識されたX座標が代入される変数
p2 : 認識されたY座標が代入される変数
p3 : 認識されたXサイズが代入される変数
p4 : 認識されたYサイズが代入される変数
%inst
cvfacedetect命令によって認識された領域を取得します。
p1からp4までの変数に、座標値が整数で代入されます。
cvfacedetect命令によって認識された個数だけ、繰り返して領域を取得することができます。

正常に取得できた場合には、実行後にシステム変数statが0になります。
取得できるデータがない場合には、システム変数statは1になります。
%href
cvfacedetect



%index
cvmatch
画像のマッチング検査
%group
拡張画面制御命令
%prm
p1,p2,p3,p4,p5
p1 : 認識されたX座標が代入される変数
p2 : 認識されたY座標が代入される変数
p3 : マッチングのタイプ
p4 : マッチング元のCVバッファID
p5 : マッチング先のCVバッファID
%inst
マッチング先のCVバッファの中から、マッチング元のCVバッファに最も近い領域を探し出して結果を返します。
実行後、(p1,p2)に指定した変数へ結果となる座標を代入します。
p3でマッチングで使用する評価方法のタイプを指定します。
p3で指定することのできるマクロは以下の通りです。
^p
CV_TM_SQDIFF
	R(x,y)=sumx',y'[T(x',y')-I(x+x',y+y')]^2

CV_TM_SQDIFF_NORMED
	R(x,y)=sumx',y'[T(x',y')-I(x+x',y+y')]^2/sqrt[sumx',y'T(x',y')^2・sumx',y'I(x+x',y+y')^2]

CV_TM_CCORR
	R(x,y)=sumx',y'[T(x',y')・I(x+x',y+y')]

CV_TM_CCORR_NORMED
	R(x,y)=sumx',y'[T(x',y')・I(x+x',y+y')]/sqrt[sumx',y'T(x',y')^2・sumx',y'I(x+x',y+y')^2]

CV_TM_CCOEFF
	R(x,y)=sumx',y'[T'(x',y')・I'(x+x',y+y')],
	where T'(x',y')=T(x',y') - 1/(w・h)・sumx",y"T(x",y")
	I'(x+x',y+y')=I(x+x',y+y') - 1/(w・h)・sumx",y"I(x+x",y+y")

CV_TM_CCOEFF_NORMED
	R(x,y)=sumx',y'[T'(x',y')・I'(x+x',y+y')]/sqrt[sumx',y'T'(x',y')^2・sumx',y'I'(x+x',y+y')^2]
^p
p5で対象となるCVバッファIDを指定します。
省略された場合は、cvsel命令で設定されたIDが使用されます。

cvmatch命令は、あくまでも最も近い領域を検索するだけで、完全に同じであることを保障するものではありません。



%index
cvconvert
色モードの変換
%group
拡張画面制御命令
%prm
p1,p2
p1(0) : 変換モード
p2 : CVバッファID
%inst
CVバッファをp1で指定された色モードに変換します。
p1が0の場合は、フルカラー画面をグレイスケール(白黒)画面に。
p1が1の場合は、グレイスケール(白黒)画面をフルカラー画面に、それぞれ変換します。
p2で対象となるCVバッファIDを指定します。
省略された場合は、cvsel命令で設定されたIDが使用されます。



%index
cvcapture
カメラキャプチャの開始
%group
拡張画面制御命令
%prm
p1,p2
p1(0) : カメラID
p2 : CVバッファID
%inst
キャプチャデバイスからの入力を開始します。
p1で、カメラを特定するためのカメラIDを指定します。
p1で指定できる値は以下の通りです。
複数のデバイスが接続されている場合は、1づつ値を加算することで特定することが可能です。
^p
マクロ          値      内容
-------------------------------------------------
CV_CAP_ANY      0  	利用可能なデバイスすべて
CV_CAP_MIL      100	Matrox Imaging Library
CV_CAP_VFW      200	Video for Windows
CV_CAP_IEEE1394 300	IEEE1394(現バージョンでは未対応です)
^p
p2でキャプチャした画像を保存する対象となるCVバッファIDを指定します。
省略された場合は、cvsel命令で設定されたIDが使用されます。

カメラキャプチャの開始後は、cvgetcapture命令によってフレームごとの画像を取得することができます。
また、不要になった場合には必ずcvendcapture命令でキャプチャを終了させる必要があります。
%href
cvgetcapture
cvendcapture



%index
cvgetcapture
キャプチャ画像の取得
%group
拡張画面制御命令
%inst
cvcapture命令によって開始されたキャプチャのフレーム画像を取得します。
取得されるCVバッファは、cvcapture命令で設定されたIDになります。
%href
cvcapture



%index
cvendcapture
カメラキャプチャの終了
%group
拡張画面制御命令
%inst
cvcapture命令によって開始されたキャプチャを終了します。
%href
cvcapture



%index
cvopenavi
aviファイル取得の開始
%group
拡張画面制御命令
%prm
"filename",p1
"filename" : avi動画ファイル名
p1 : CVバッファID
%inst
avi動画ファイルからの入力を開始します。
指定されたファイル内のフレームを取得することができるようになります。

p1でキャプチャした画像を保存する対象となるCVバッファIDを指定します。
省略された場合は、cvsel命令で設定されたIDが使用されます。

aviファイル取得の開始後は、cvgetavi命令によってフレームごとの画像を取得することができます。
また、不要になった場合には必ずcvcloseavi命令でaviファイル取得を終了させる必要があります。

cvopenavi命令は、あくまでもaviファイルの内容を簡易的に取り出すための機能で、正常な動画再生を行なうためのものではありません。あくまでも、フレームを取り出して処理を行なうための補助機能だとお考えください。
また、cvopenavi命令が扱うことのできるaviファイルは、古い形式のaviフォーマットに限られており、すべてのaviファイルを開くことができるわけではありません。
%href
cvgetavi
cvcloseavi



%index
cvgetavi
aviファイル画像の取得
%group
拡張画面制御命令
%inst
cvopenavi命令によって開始されたaviファイルのフレーム画像を取得します。
取得されるCVバッファは、cvcapture命令で設定されたIDになります。
%href
cvopenavi



%index
cvcloseavi
aviファイル取得の終了
%group
拡張画面制御命令
%prm
%inst
cvopenavi命令によって開始されたaviファイル取得を終了します。
%href
cvopenavi



%index
cvmakeavi
aviファイル出力の開始
%group
拡張画面制御命令
%prm
"filename",p1,p2,p3
"filename" : 出力するavi動画ファイル名
p1(-1) : 32bit Codecコード
p2(29.97) : 実数によるフレームレート(fps)
p3 : CVバッファID
%inst
avi動画ファイルへの出力を開始します。
指定されたファイル名でaviファイルを作成します。

p1でコーデックが持つ32bitのコード(FOURCC)を指定します。
p1に-1を指定した場合は、コーデックを選択するダイアログが開きます。
p2で実数によるフレームレート(fps)を指定します。
p2の指定が省略された場合には、29.97fpsとなります。

p3で出力画像を保持するCVバッファIDを指定します。
省略された場合は、cvsel命令で設定されたIDが使用されます。

出力の開始後は、cvputavi命令によってフレームごとの画像を登録して、最後にcvendavi命令を呼び出す必要があります。
%href
cvputavi
cvendavi



%index
cvputavi
aviファイルに画像を出力
%group
拡張画面制御命令
%inst
cvmakeavi命令によって開始されたaviファイルに、フレーム画像を追加します。
参照されるCVバッファは、cvmakeavi命令で設定されたIDになります。
%href
cvmakeavi



%index
cvendavi
aviファイル出力の終了
%group
拡張画面制御命令
%inst
cvmakeavi命令によって開始されたaviファイル出力を終了します。
%href
cvmakeavi



%index
cvj2opt
JPEG-2000保存オプション設定
%group
拡張画面制御命令
%prm
"format","option"
"format" : フォーマット文字列
"option" : オプション文字列
%inst
cvsave命令でJPEG-2000形式(.jp2)を指定した際の詳細設定を行ないます。
フォーマット文字列には、以下のいずれかを指定することができます。
(JPEG以外のフォーマットを指定した場合でも、拡張子はjp2のままになるので注意してください)
^p
	フォーマット文字列     形式
	----------------------------------------
		mif	    My Image Format
		pnm	    Portable Graymap/Pixmap
		bmp	    Microsoft Bitmap
		ras	    Sun Rasterfile
		jp2	    JPEG2000 JP2 File Format Syntax
		jpc	    JPEG2000 Code Stream Syntax
		jpg	    JPEG
		pgx	    JPEG2000 VM Format
^p
オプション文字列により、付加設定を行なうことができます。
^p
	例:
		cvj2opt "jp2","rate=0.1"
		cvsave "test2000.jp2"
^p
オプション文字列は、フォーマットごとに設定方法が異なります。
詳しくは、jasperライブラリに含まれる、コマンドラインツール
jasperのオプションを参照してください。
^p
http://www.ece.uvic.ca/~mdadams/jasper/
^p
%href
cvsave



