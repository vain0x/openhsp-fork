;(2009/4/21)
; HSP HELP Browser II用 HELPソースファイル
; Easy3D for HSP3
;
;http://www5d.biglobe.ne.jp/~ochikko/e3dhsp3_func.htm から
;HS形式への移殖 Easy3DHelp2Hs Ver1.20
;HP : http://www.geocities.jp/yutopp/index.html
%type
Easy3D For HSP3 命令
%ver
5.0.4.0

%note
e3dhsp3.asをインクルードすること。
%date
2009/04/20

%author
おちゃっこ
%dll
Easy3D For HSP3
%url
http://www5d.biglobe.ne.jp/~ochikko/

%index
E3DInit
Direct3Dの初期化をする。
%group
Easy3D For HSP3 : 初期化

%prm
p1,p2,p3,p4,p5,p6,p7,p8
p1 : [IN] 変数または、数値　：　wid
p2 : [IN] 変数または、数値　：　objid
p3 : [IN] 変数または、数値　：　fullscreenflag
p4 : [IN] 変数または、数値　：　bits
p5 : [IN] 変数または、数値　：　multisamplenum
p6 : [OUT] 変数　：　scid
p7 : [IN] 変数または、数値　：　gpuflag
p8 : [IN] 変数または、数値　：　enablereverb

%inst
Direct3Dの初期化をする。

フルスクリーンにも対応しています。

フルスクリーンの解像度は、
指定したウインドウＩＤの幅に
一番近いものを自動で選びます。

６４０×４８０、
８００×６００、
１０２４×７６８、
１２８０×１０２４、
１４００×１０５０、
１６００×１２００
の中から選びます。


ＨＡＬ（ハードウェアの機能）が使えない場合は、エラーになります。

指定したビット数が使えない場合にも、
エラーになります。


エラーでアプリケーションが終了するのが
嫌な場合は、
この命令を呼ぶ前に、E3DCheckFullScreenParamsを呼んで
チェックすることをおすすめします。

フルスクリーンの具体的な使用例は、
e3dhsp3_fullscreen.hsp
に書きましたので、ご覧ください。



アンチエイリアスについて。
multisamplenumは０または２から１６の値を指定してください。
multisamplenumの値が大きいほど、
画像のエッジがなめらかになります。
０を指定するとアンチエイリアスは使えません。

multisamplenumに０以外を指定する場合は、
その前に、
E3DGetMaxMultiSampleNumで
指定できる最大値を取得してください。

html{
<strong>アンチエイリアスをオンにすると（０以外を指定すると）、
ＢＭＰ保存や、ＡＶＩ保存の命令が使えなくなります。
</strong>
}html
（E3DWriteDisplay2BMP、E3DCreateAVIFileと他のＡＶＩ関連関数が使用できなくなります。）


アンチエイリアスを有効にするには、
作成した全てのhsidに対して、
E3DSetRenderState hsid, -1, D3DRS_MULTISAMPLEANTIALIAS, 1 を呼んでください。


アンチエイリアスの具体的な使用例は、
e3dhsp3_antialias.hsp
に書きましたので、ご覧ください。




→引数

1. [IN] 変数または、数値　：　wid
　　ウインドウのＩＤを渡してください。
　　screen命令やbgscr命令に指定したのと同じ番号を
　　指定してください。

2. [IN] 変数または、数値　：　objid
　　オブジェクトＩＤ。
　　ＨＳＰでボタンなどのオブジェクトを作り、
　　その上に３Ｄ表示したい場合に、この引数を使います。
　　ＨＳＰでは、オブジェクト作成直後のstat変数に、
　　オブジェクトＩＤが入っています。
　　このＩＤを指定してください。
　　widで指定したウインドウ全体に、
　　3D描画を行いたい場合は、
　　この引数には-1を指定してください。


3. [IN] 変数または、数値　：　fullscreenflag
　　フルスクリーンにするときは１を、
　　しないとき（ウインドウモード）は０を指定してください。
　　省略した場合は、ウインドウモードになります。


4. [IN] 変数または、数値　：　bits
　　色数を決めるビット数を指定してください。
　　１６あるいは、３２のみ有効です。
　　fullscreenflagに１を指定したときのみ、結果に反映されます。


5. [IN] 変数または、数値　：　multisamplenum
　　マルチサンプルの数。
　　詳しくは、右記をご覧ください。


6. [OUT] 変数　：　scid
　　スワップチェインＩＤが代入されます。
　　このＩＤは、どの部分に描画を行うかを指定するのに
　　使います。
　　E3DChkInView, E3DRender, E3DBeginScene, E3DPresent 　　などで
　　必要になります。


7. [IN] 変数または、数値　：　gpuflag
　　１を指定するとビデオカードに頂点シェーダー、
　　ピクセルシェーダーがある場合には、
　　それを使って頂点処理します。
　　０を指定すると、ソフトウェアで頂点処理します。

　　省略した場合は１が適用されます。

8. [IN] 変数または、数値　：　enablereverb
　　１を指定するとステレオサウンドのリバーブが
　　オンになります。
　　０を指定するとリバーブがオフになります。

　　省略した場合は、１が適用されます。


バージョン : ver1.0.0.1

%index
E3DBye
Direct3Dの後処理をする。
%group
Easy3D For HSP3 : 後処理

%prm
なし

%inst
Direct3Dの後処理をする。

作成したメモリなどの解放を行います。
アプリケーションの終了時に呼んでください。




→引数
なし

バージョン : ver1.0.0.1

%index
E3DSigLoad
形状データ（*.sig）を読み込んで、hsidを得る。
%group
Easy3D For HSP3 : モデルデータ

%prm
p1,p2,p3,p4
p1 : [IN] 文字列または、文字列の変数　：　fname
p2 : [OUT] 変数　：　hsid
p3 : [IN] 変数または、数値　：　adjustuvflag
p4 : [IN] 変数または、数値　：　mult

%inst
形状データ（*.sig）を読み込んで、hsidを得る。


→引数
1. [IN] 文字列または、文字列の変数　：　fname
　　*.sig のパス文字列。

2. [OUT] 変数　：　hsid
　　読み込んだ形状データを識別するhsid

3. [IN] 変数または、数値　：　adjustuvflag
　　ＵＶ値を正規化するかどうかのフラグ
　　正規化する場合は１を指定
　　しない場合は０を指定

4. [IN] 変数または、数値　：　mult
　　読み込み倍率を指定してください。
　　実数。



バージョン : ver1.0.0.1

%index
E3DCreateSwapChain
スワップチェインを作成します。
%group
Easy3D For HSP3 : スワップチェイン

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　wid
p2 : [IN] 変数または、数値　：　objid
p3 : [OUT] 変数　：　scid

%inst
スワップチェインを作成します。

スワップチェインとは、複数の画面に描画を行うためのものです。
E3DInitで指定したウインドウとオブジェクト以外のところに、
描画したい場合に、この命令を呼びます。

この命令で取得したscidを、
E3DChkInView, E3DBeginScene, E3DRender, E3DPresentなどに渡すことにより、
複数画面に３Ｄ描画できるようになります。

具体的な使用例は、
e3dhsp3_SwapChain.hsp
に書きましたので、ご覧ください。





→引数
 1. [IN] 変数または、数値　：　wid
　　ウインドウのＩＤを渡してください。
　　screen命令やbgscr命令に指定したのと同じ番号を
　　指定してください。

2. [IN] 変数または、数値　：　objid
　　オブジェクトＩＤ。
　　ＨＳＰでボタンなどのオブジェクトを作り、
　　その上に３Ｄ表示したい場合に、この引数を使います。
　　ＨＳＰでは、オブジェクト作成直後のstat変数に、
　　オブジェクトＩＤが入っています。
　　このＩＤを指定してください。
　　widで指定したウインドウ全体に、
　　3D描画を行いたい場合は、
　　この引数には-1を指定してください。

3. [OUT] 変数　：　scid
　　スワップチェインＩＤが代入されます。
　　このＩＤは、どの部分に描画を行うかを指定するのに
　　使います。
　　E3DChkInView, E3DRender, E3DBeginScene, E3DPresent　　などで
　　必要になります。



バージョン : ver1.0.0.1

%index
E3DDestroySwapChain
スワップチェインを破棄します。
%group
Easy3D For HSP3 : スワップチェイン

%prm
p1
p1 : [IN] 変数または、数値　：　scid

%inst
スワップチェインを破棄します。

E3DCreateSwapChainで作成したスワップチェインが、
もういらなくなった場合に、呼んでください。

E3DInitで取得したscidに対しては、呼び出さないでください。




→引数
1. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DCreateSwapChainで取得したＩＤを指定してください。



バージョン : ver1.0.0.1

%index
E3DRender
バックバッファにレンダリングする。
%group
Easy3D For HSP3 : 描画

%prm
p1,p2,p3,p4,p5,p6,p7,p8
p1 : [IN] 変数または、数値　：　scid
p2 : [IN] 変数または、数値　：　hsid
p3 : [IN] 変数または、数値　：　withalpha
p4 : [IN] 変数または、数値　：　framecnt
p5 : [IN] 変数または、数値　：　projection mode
p6 : [IN] 変数または、数値　：　lastparent
p7 : [IN] 変数または、数値　：　sigLightFlag
p8 : [IN] 変数または、数値　：　transskip

%inst
バックバッファにレンダリングする。


変更したボーンの中で、
一番親の番号をlastparentに指定すると、
そのボーンツリーの影響を受ける頂点のみを
抽出して、計算します。

lastparentは、高速化のためのものです。
E3DIKRotateBetaで取得できるlastparentの値を
渡すことを想定しています。

キャラクター全体が移動した場合や、
カメラが移動した場合には、使わないでください。
また、E3DRenderの初回の呼び出し時にも
使わないでください。

html{
<strong>lastparentを使用したくない場合は、
０をセットしてください。</strong>
}html





→引数
1. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。

2. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

3. [IN] 変数または、数値　：　withalpha
　　０を指定すると、不透明パーツのみレンダリングする。
　　１を指定すると、半透明パーツのみレンダリングする。

4. [IN] 変数または、数値　：　framecnt
　　E3DSetNewPose実行後のnextframeの値を指定する。

5. [IN] 変数または、数値　：　projection mode
　　プロジェクションの、モードを指定する。
　　０を指定すると、通常の表示。
　　１を指定すると、画面中央にレンズがあるように表示される。

6. [IN] 変数または、数値　：　lastparent
　　変更が生じた一番親のボーンの番号を指定します。
　　詳しくは、左記をご覧ください。

7. [IN] 変数または、数値　：　sigLightFlag
　　sigのライティング計算を有効にしたいときは１を、
　　無効にしたいときは０を指定してください。
　　デフォルトは１です。

　　背面カリングを行わずに、
　　全ての頂点の色計算をしたい場合には、
　　２を指定してください。

8. [IN] 変数または、数値　：　transskip
　　transskipに１をセットすると、
　　頂点変換処理がスキップされます。
　　不透明、半透明と、２回、E3DRenderを呼び出す場合は、
　　２回目の呼び出し時に、transskipに１を指定してください。






バージョン : ver1.0.0.1<BR>
      <BR>
      ver1.0.0.5で引数追加<BR>
      

%index
E3DPresent
バックバッファの内容を、
プライマリバッファに転送する。
%group
Easy3D For HSP3 : 描画

%prm
p1
p1 : [IN] 変数または、数値　：　scid

%inst
バックバッファの内容を、
プライマリバッファに転送する。



→引数
1. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。



バージョン : ver1.0.0.1

%index
E3DBeginScene
アプリケーションでは、レンダリングを実行する前には必ずこのメソッドを呼び出し、
レンダリングの終了時、
および再度E3DBeginSceneを呼び出す前には、
必ず E3DEndSceneを呼び出す。
%group
Easy3D For HSP3 : 描画

%prm
p1,p2
p1 : [IN] 変数または、数値　：　scid
p2 : [IN] 変数または、数値　：　skipflag

%inst
アプリケーションでは、レンダリングを実行する前には必ずこのメソッドを呼び出し、
レンダリングの終了時、
および再度E3DBeginSceneを呼び出す前には、
必ず E3DEndSceneを呼び出す。

具体的には、
E3DRender, E3DDrawText, E3DDrawBigTextを、
E3DBeginSceneと、E3DEndSceneでサンドイッチするように記述する。





→引数

1. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。

2. [IN] 変数または、数値　：　skipflag
　　skipflagに０以外を指定すると、
　　バックバッファのクリア、背景の表示をスキップします。
　
　　E3DCopyTextureToBackBufferを使うときなどに、
　　使用してください。



バージョン : ver1.0.0.1

%index
E3DEndScene
このメソッドが成功すると、シーンがレンダリングされ、レンダリング後のシーンがデバイス サーフェスに保持される。
%group
Easy3D For HSP3 : 描画

%prm
なし

%inst
このメソッドが成功すると、シーンがレンダリングされ、レンダリング後のシーンがデバイス サーフェスに保持される。


→引数
なし

バージョン : ver1.0.0.1

%index
E3DCreateBG
画面の一番奥に表示される背景をセットします。
%group
Easy3D For HSP3 : 背景

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 変数または、数値　：　scid
p2 : [IN] 文字列または、文字列変数　：　filename1
p3 : [IN] 文字列または、文字列変数　：　filename2
p4 : [IN] 変数または、数値　：　u
p5 : [IN] 変数または、数値　：　v
p6 : [IN] 変数または、数値　：　isround
p7 : [IN] 変数または、数値　：　fogdist

%inst
画面の一番奥に表示される背景をセットします。

画像ファイルは、２つまで、指定できます。
２個目の画像は、雲や、もや用を想定しています。
１つ目の画像と２つ目の画像は、モジュレートされて、表示されます。

isroundに１をセットすると、
背景が、視点の回転に対応して、回転するようになります。


ビデオカードがマルチテクスチャに対応していない場合、
または、モジュレート処理が出来ない場合は、
1個目のテクスチャーしか表示しないように
なっています。





→引数
1. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。

2. [IN] 文字列または、文字列変数　：　filename1
　　１つ目の画像ファイル名。


3. [IN] 文字列または、文字列変数　：　filename2
　　２つ目の画像ファイル名。
　　２つ目が不必要な場合は、存在しないファイル名を、
　　渡してください。

4. [IN] 変数または、数値　：　u
5. [IN] 変数または、数値　：　v
　　２枚目の画像の、ＵＶ座標を、毎フレーム、どれくらい、
　　移動させるかを指定します。
　　通常は、0から１までの値を指定してください。
　　実数。

6. [IN] 変数または、数値　：　isround
　　isroundに、１を指定すると、
　　ビューの回転に対応して、
　　一つ目の画像ファイルのＵＶ座標が、回転します。
　　この際、画像ファイルの左端と、右端が、
　　連続するようなデータでないと、
　　つなぎ目が見えてしまいますので、注意してください。
　　isroundに０を指定すると、
　　１つ目の画像は、回転しません。

7. [IN] 変数または、数値　：　fogdist
　　フォグの計算に使う、カメラからの距離を指定します。
　　この引数に、E3DSetLinearFogParamsで指定する
　　endより小さい値を指定すれば、
　　背景は、フォグの色に染まりながらも、
　　うっすらと見えるように出来ます。





バージョン : ver1.0.0.1<BR>
      <BR>
      ver2.0.0.9で引数追加<BR>
      

%index
E3DSetBGU
背景のＵＶ座標のＵ座標を指定します。
%group
Easy3D For HSP3 : 背景

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　scid
p2 : [IN] 数値または、変数　：　startu
p3 : [IN] 数値または、変数　：　endu

%inst
背景のＵＶ座標のＵ座標を指定します。

画面の左端のＵ座標の値をstartu引数に、

画面の右端のＵ座標の値をendu引数に、
それぞれ、指定してください。

この機能を使った、背景のスクロールの例は、
e3dhsp3_scrollBG.hsp
にあります。




→引数

1. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。

2. [IN] 数値または、変数　：　startu
　　画面左端のＵ座標の値。
　　実数。

3. [IN] 数値または、変数　：　endu
　　画面右端のＵ座標の値。
　　実数。



バージョン : ver1.0.0.1

%index
E3DSetBGV
背景のＵＶ座標のＶ座標を指定します。
%group
Easy3D For HSP3 : 背景

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　scid
p2 : [IN] 数値または、変数　：　startv
p3 : [IN] 数値または、変数　：　endv

%inst
背景のＵＶ座標のＶ座標を指定します。

画面の一番上のＶ座標の値をstartv引数に、

画面の一番下のＶ座標の値をendv引数に、
それぞれ、指定してください。


この機能を使った、背景のスクロールの例は、
e3dhsp3_scrollBG.hsp
にあります。



→引数
1. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。

2. [IN] 数値または、変数　：　startv
　　画面左端のV座標の値。
　　実数。

3. [IN] 数値または、変数　：　endv
　　画面右端のV座標の値。
　　実数。



バージョン : ver1.0.0.1

%index
E3DDestroyBG
背景を破棄します。
%group
Easy3D For HSP3 : 背景

%prm
p1
p1 : [IN] 変数または、数値　：　scid

%inst
背景を破棄します。


→引数
1. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。



バージョン : ver1.0.0.1

%index
E3DAddMotion
モーションデータ(*.qua)を読み込む。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4,p5
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 文字列または、文字列の変数　：　fname
p3 : [OUT] 変数　：　mk
p4 : [OUT] 変数　：　maxframe
p5 : [IN] 変数または、数値　：　mvmult

%inst
モーションデータ(*.qua)を読み込む。


→引数
1. [IN] 変数または、数値　：　hsid
　　どのモデルデータに対するモーションかを指定する。

2. [IN] 文字列または、文字列の変数　：　fname
　　*.quaのパス文字列。

3. [OUT] 変数　：　mk
　　読み込んだモーションを識別する番号

4. [OUT] 変数　：　maxframe
　　読み込んだモーションの最大フレーム番号
　　（総フレーム数 - 1 と同じ）

5. [IN] 変数または、数値　：　mvmult
　　モーションの移動成分に掛ける倍率
　　省略すると１．０
　　実数



バージョン : ver1.0.0.1<BR>
      ver4.0.1.6で引数追加<BR>
      

%index
E3DSetMotionKind
カレントの、モーション番号を指定する。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　mk

%inst
カレントの、モーション番号を指定する。
（カレントモーションを変更する。）

この関数を実行すると、
モーションのフレーム番号は、
０にセットされる。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　mk
　　モーションを識別する番号



バージョン : ver1.0.0.1

%index
E3DGetMotionKind
カレントの、モーション番号を取得する。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2
p1 : [IN] 変数または、数値　：　hsid
p2 : [OUT] 変数　：　mk

%inst
カレントの、モーション番号を取得する。


→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [OUT] 変数　：　mk
　　モーションを識別する番号



バージョン : ver1.0.0.1

%index
E3DSetNewPose
カレントのモーションを、
E3DSetMotionStepでセットしたstepフレーム数分、
進ませる。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2
p1 : [IN] 変数または、数値　：　hsid
p2 : [OUT] 変数　：　nextframe

%inst
カレントのモーションを、
E3DSetMotionStepでセットしたstepフレーム数分、
進ませる。

nextframeに、
次に再生するフレーム番号がセットされる。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [OUT] 変数　：　nextframe
　　次に再生されるフレーム番号が代入されます。



バージョン : ver1.0.0.1

%index
E3DSetMotionStep
モーションのステップ数を指定する。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　mk
p3 : [IN] 変数または、数値　：　step

%inst
モーションのステップ数を指定する。
例えば、stepに、２を指定すると、
２フレームごとに（１フレームおきに）、
モーションを再生するようになる。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　mk
　　モーションを識別する番号

3. [IN] 変数または、数値　：　step
　　何フレームごとに、モーションを再生するかを指定する。



バージョン : ver1.0.0.1

%index
E3DChkConflict
２つの形状データが、衝突しているかどうかを判定する。
%group
Easy3D For HSP3 : 当たり判定

%prm
p1,p2,p3,p4
p1 : [IN] 変数または、数値　：　hsid1
p2 : [IN] 変数または、数値　：　hsid2
p3 : [OUT] 変数　：　confflag
p4 : [OUT] 変数　：　inviewflag

%inst
２つの形状データが、衝突しているかどうかを判定する。

（判定の元になるデータは、
E3DChkInView命令によって更新される。）


hsid1が視野外にある場合は、inviewflagに１が、
hsid2が視野外にある場合は、inviewflagに２が、
両方とも視野外の場合は、inviewflagに３が、
両方とも視野内の場合は、inviewflagに０が代入されます。

現在は、
html{
<strong>E3DChkConflict2</strong>
}htmlがあります。
パーツ同士のあたり判定が出来るようになりました。
モデル全体のあたり判定も出来ます。
モデル全体のあたり判定をする場合でも、
E3DChkConflict2の方が、パーツごとの計算をするので、この関数よりも計算精度が高いです。

新しい、E3DChkConflict2をお使いください。




→引数
1. [IN] 変数または、数値　：　hsid1
　　形状データを識別するid

2. [IN] 変数または、数値　：　hsid2
　　形状データを識別するid

3. [OUT] 変数　：　confflag
　　hsid1, hsid2で識別される形状同士が、
　　衝突している場合は、１が、
　　衝突していない場合は０がセットされる。

4. [OUT] 変数　：　inviewflag
　　 hsid1が視野外にある場合は、inviewflagに１を、
　　hsid2が視野外にある場合は、inviewflagに２を、
　　両方とも視野外の場合は、inviewflagに３を、
　　両方とも視野内の場合は、inviewflagに０を代入します。




バージョン : ver1.0.0.1

%index
E3DChkConflict2
２つの形状データの指定したパーツ同士が、衝突しているかどうを判定します。
%group
Easy3D For HSP3 : 当たり判定

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 変数または、数値　：　hsid1
p2 : [IN] 変数または、数値　：　partno1
p3 : [IN] 変数または、数値　：　hsid2
p4 : [IN] 変数または、数値　：　partno2
p5 : [OUT] 変数　：　confflag
p6 : [OUT] 変数　：　inviewflag

%inst
２つの形状データの指定したパーツ同士が、衝突しているかどうを判定します。

partno1, partno2には、
E3DGetPartNoByNameで取得した、
パーツの番号を渡してください。

partnoに-1を指定すると、
モデル全体とあたり判定をします。


（判定の元になるデータは、
E3DChkInView命令によって、更新されます。）


hsid1が視野外にある場合は、inviewflagに１が、
hsid2が視野外にある場合は、inviewflagに２が、
両方とも視野外の場合は、inviewflagに３が、
両方とも視野内の場合は、inviewflagに０が代入されます。





→引数
1. [IN] 変数または、数値　：　hsid1
　　形状データを識別するid
2. [IN] 変数または、数値　：　partno1
　　hsid1のモデル中のパーツの番号

3. [IN] 変数または、数値　：　hsid2
　　形状データを識別するid
4. [IN] 変数または、数値　：　partno2
　　hsid2のモデル中のパーツの番号

5. [OUT] 変数　：　confflag
　　hsid1, hsid2で識別される形状同士が、
　　衝突している場合は１が、
　　衝突していない場合は０がセットされる。

6. [OUT] 変数　：　inviewflag
　　 hsid1が視野外にある場合は、inviewflagに１を、
　　hsid2が視野外にある場合は、inviewflagに２を、
　　両方とも視野外の場合は、inviewflagに３を、
　　両方とも視野内の場合は、inviewflagに０を代入します。




バージョン : ver1.0.0.1

%index
E3DCreateAfterImage
この関数は、現在、機能していません。
%group
Easy3D For HSP3 : 残像

%prm
p1,p2
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　imagenum

%inst
この関数は、現在、機能していません。


→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid
2. [IN] 変数または、数値　：　imagenum
　　表示する残像の数を指定する。



バージョン : ver1.0.0.1

%index
E3DDestroyAfterImage
E3DCreateAfterImageで作成した、残像用のオブジェクトを破棄する。
%group
Easy3D For HSP3 : 残像

%prm
p1
p1 : [IN] 変数または、数値　：　hsid

%inst
E3DCreateAfterImageで作成した、残像用のオブジェクトを破棄する。
（残像が表示されなくなる。）

必要回数より多く実行しても、害はないが、
実行し忘れると、
メモリリークするので注意してください。



→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid


バージョン : ver1.0.0.1

%index
E3DSetAlpha
半透明の設定。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　usealphaflag
p3 : [IN] 変数または、数値　：　updateflag

%inst
半透明の設定。
この関数は、過去のバージョンとの互換性のためだけに、存在します。
半透明の設定は、
E3DSetAlpha2 関数を、ご使用ください。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　usealphaflag
　　０を指定すると、不透明で描画され、
　　１を指定すると、alpha = 0.5 で描画されます。

3. [IN] 変数または、数値　：　updateflag
　　1を指定してください。



バージョン : ver1.0.0.1

%index
E3DSetAlpha2
ビルボードの頂点のアルファ値を設定します。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　alphaval
p3 : [IN] 数値または、変数　：　partno
p4 : [IN] 変数または、数値　：　updateflag

%inst
ビルボードの頂点のアルファ値を設定します。

sigモデルデータのアルファの設定は
E3DSetMaterialAlphaをお使いください。


alphaval が１．０の時は、不透明に、
alphavalが０．０の時は、完全に透明になります。

alphavalに１．０以外の値を指定した場合は、
E3DRenderの2番目の引数withalphaに、
１を指定して描画します。


具体的な使用例はzip中の、
e3dhsp3_alpha.hsp　をご覧ください。



→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ
　　-1を指定すると、ビルボードの透明度を設定できます。

2. [IN] 数値または、変数　：　alphaval
　　頂点のアルファ値を指定します。
　　
　　頂点のアルファ値は、０．０から１．０の値で
　　指定してください。
　　範囲外の値は、クランプしてセットします。
　　実数。

3. [IN] 数値または、変数　：　partno
　　設定したいパーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。

　　hsidに-1を指定した場合は、
　　E3DCreateBillboardで取得した、
　　ビルボードidを渡してください。

　　partnoに-1を渡すと、
　　全てのパーツにアルファをセットできます。

4. [IN] 変数または、数値　：　updateflag
　　1を指定してください。




バージョン : ver1.0.0.1

%index
E3DSetPos
形状データの位置をセットする。
%group
Easy3D For HSP3 : モデル位置

%prm
p1,p2,p3,p4
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　posx
p3 : [IN] 変数または、数値　：　posy 
p4 : [IN] 変数または、数値　：　posz

%inst
形状データの位置をセットする。


→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　posx
3. [IN] 変数または、数値　：　posy 
4. [IN] 変数または、数値　：　posz
　実数。
　形状データを　( posx, posy, posz) に移動する。



バージョン : ver1.0.0.1

%index
E3DGetPos
形状データの位置を取得する。
%group
Easy3D For HSP3 : モデル位置

%prm
p1,p2,p3,p4
p1 : [IN] 変数または、数値　：　hsid
p2 : [OUT] 変数　：　posx
p3 : [OUT] 変数　：　posy 
p4 : [OUT] 変数　：　posz

%inst
形状データの位置を取得する。


→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [OUT] 変数　：　posx
3. [OUT] 変数　：　posy 
4. [OUT] 変数　：　posz
　　実数型の変数。
　　形状データの位置を取得する。



バージョン : ver1.0.0.1

%index
E3DSetDir
形状データの向きを指定する。
%group
Easy3D For HSP3 : モデル向き

%prm
p1,p2,p3,p4
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　degx
p3 : [IN] 変数または、数値　：　degy 
p4 : [IN] 変数または、数値　：　degz

%inst
形状データの向きを指定する。
X軸、Y軸、Z軸の順番に、
指定した角度だけ回転します。



→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　degx
3. [IN] 変数または、数値　：　degy 
4. [IN] 変数または、数値　：　degz
　　形状データの向きを、
　　X,Y,Z軸のそれぞれの角度（degree）で指定する。
　　実数。



バージョン : ver1.0.0.1

%index
E3DRotateInit
形状データの向きを初期化します。
%group
Easy3D For HSP3 : モデル向き

%prm
p1
p1 : [IN] 変数または、数値　：　hsid

%inst
形状データの向きを初期化します。


→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid


バージョン : ver1.0.0.1

%index
E3DRotateX
形状データを、X軸に関して、degx 度だけ回転します。
%group
Easy3D For HSP3 : モデル向き

%prm
p1,p2
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　degx

%inst
形状データを、X軸に関して、degx 度だけ回転します。


→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　degx
　　回転角度。
　　実数。



バージョン : ver1.0.0.1

%index
E3DRotateY
形状データを、Ｙ軸に関して、degy 度だけ回転します。
%group
Easy3D For HSP3 : モデル向き

%prm
p1,p2
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　degy

%inst
形状データを、Ｙ軸に関して、degy 度だけ回転します。


→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　degy
　　回転角度。
　　実数。



バージョン : ver1.0.0.1

%index
E3DRotateZ
形状データを、Z軸に関して、degz 度だけ回転します。
%group
Easy3D For HSP3 : モデル向き

%prm
p1,p2
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　degz

%inst
形状データを、Z軸に関して、degz 度だけ回転します。


→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　degz
　　回転角度。
　　実数。



バージョン : ver1.0.0.1

%index
E3DTwist
形状データを、現在向いている方向を軸として、deg度だけ、回転します。
%group
Easy3D For HSP3 : モデル向き

%prm
p1,p2
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　deg

%inst
形状データを、現在向いている方向を軸として、deg度だけ、回転します。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　deg
　　回転角度。
　　実数。



バージョン : ver1.0.0.1

%index
E3DPosForward
形状データを、現在向いている方向に、stepだけ移動する。
%group
Easy3D For HSP3 : モデル位置

%prm
p1,p2
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　step

%inst
形状データを、現在向いている方向に、stepだけ移動する。

ただし、形状データが、default状態で、
Z軸の方向を向いていると仮定する。



→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　step
　　移動距離を指定する。
　　実数。



バージョン : ver1.0.0.1

%index
E3DCloseTo
hsid1で識別される形状を、hsid2で識別される形状の方向に、動かす。
%group
Easy3D For HSP3 : モデル位置

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid1
p2 : [IN] 変数または、数値　：　hsid2
p3 : [IN] 変数または、数値　：　step

%inst
hsid1で識別される形状を、hsid2で識別される形状の方向に、動かす。

内部で、E3DDirToTheOtherを呼び出します。




→引数
1. [IN] 変数または、数値　：　hsid1
　　移動する形状データを、識別するid

2. [IN] 変数または、数値　：　hsid2
　　hsid2で指定した形状データの方向に移動する。

3. [IN] 変数または、数値　：　step
　　移動距離を指定する。
　　実数。



バージョン : ver1.0.0.1

%index
E3DDirToTheOtherXZ
hsid1で識別される形状を、XZ平面で、hsid2で識別される形状の方向を、向くようにする。
%group
Easy3D For HSP3 : モデル向き

%prm
p1,p2
p1 : [IN] 変数または、数値　：　hsid1
p2 : [IN] 変数または、数値　：　hsid2

%inst
hsid1で識別される形状を、XZ平面で、hsid2で識別される形状の方向を、向くようにする。

ただし、形状データが、初期状態で、
Z軸の負の方向(0.0, 0.0, -1.0)を向いているものと仮定しています。




→引数
1. [IN] 変数または、数値　：　hsid1
　　向きを変える形状データを、識別するid

2. [IN] 変数または、数値　：　hsid2
　　hsid2で指定した形状データの方向を向く。



バージョン : ver1.0.0.1

%index
E3DDirToTheOther
E3DDirToTheOtherXZの３次元版。
%group
Easy3D For HSP3 : モデル向き

%prm
p1,p2
p1 : [IN] 変数または、数値　：　hsid1
p2 : [IN] 変数または、数値　：　hsid2

%inst
E3DDirToTheOtherXZの３次元版。

ただし、形状データが、初期状態で、
Z軸の負の方向(0.0, 0.0, -1.0)を向いているものと仮定しています。




→引数
1. [IN] 変数または、数値　：　hsid1
　　向きを変える形状データを、識別するid

2. [IN] 変数または、数値　：　hsid2
　　hsid2で指定した形状データの方向を向く。



バージョン : ver1.0.0.1

%index
E3DSeparateFrom
hsid1で識別される形状を、hsid2で識別される形状と、逆の方向に、動かす。
%group
Easy3D For HSP3 : モデル位置

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid1
p2 : [IN] 変数または、数値　：　hsid2
p3 : [IN] 変数または、数値　：　dist

%inst
hsid1で識別される形状を、hsid2で識別される形状と、逆の方向に、動かす。


→引数
1. [IN] 変数または、数値　：　hsid1
　　移動する形状データを、識別するid

2. [IN] 変数または、数値　：　hsid2
　　hsid2で指定した形状データと反対方向に移動する。

3. [IN] 変数または、数値　：　dist
　　形状同士をどのくらいの距離、離すかを指定する。
　　実数。



バージョン : ver1.0.0.1

%index
E3DGetCameraPos
カメラの位置を取得する。
%group
Easy3D For HSP3 : カメラ

%prm
p1,p2,p3
p1 : [OUT] 変数　：　posx
p2 : [OUT] 変数　：　posy 
p3 : [OUT] 変数　：　posz

%inst
カメラの位置を取得する。


→引数
1. [OUT] 変数　：　posx
2. [OUT] 変数　：　posy 
3. [OUT] 変数　：　posz
　　実数型の変数。
　　カメラの位置、　( posx, posy, posz) を取得する。



バージョン : ver1.0.0.1

%index
E3DSetCameraPos
カメラの位置を指定する。
%group
Easy3D For HSP3 : カメラ

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　posx
p2 : [IN] 変数または、数値　：　posy 
p3 : [IN] 変数または、数値　：　posz

%inst
カメラの位置を指定する。


→引数
1. [IN] 変数または、数値　：　posx
2. [IN] 変数または、数値　：　posy 
3. [IN] 変数または、数値　：　posz
　　カメラを　( posx, posy, posz) に移動する。
　　実数。



バージョン : ver1.0.0.1

%index
E3DGetCameraDeg
カメラの向きを取得する。
%group
Easy3D For HSP3 : カメラ

%prm
p1,p2
p1 : [OUT] 変数　：　degxz
p2 : [OUT] 変数　：　degy

%inst
カメラの向きを取得する。


→引数
1. [OUT] 変数　：　degxz
　　カメラのXZ平面での角度を取得する。
　　実数型の変数。

2. [OUT] 変数　：　degy
　　カメラの仰ぎ角度を取得する。
　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DSetCameraDeg
カメラの向きを指定する。
%group
Easy3D For HSP3 : カメラ

%prm
p1,p2
p1 : [IN] 変数または、数値　：　degxz
p2 : [IN] 変数または、数値　：　degy

%inst
カメラの向きを指定する。


→引数
1. [IN] 変数または、数値　：　degxz
　　カメラのXZ平面での角度を指定する。
　　実数。

2. [IN] 変数または、数値　：　degy
　　カメラの仰ぎ角度を指定する。
　　実数。



バージョン : ver1.0.0.1

%index
E3DSetCameraTarget
カメラの注視点を指定する。
%group
Easy3D For HSP3 : カメラ

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 変数または、数値　：　targetx
p2 : [IN] 変数または、数値　：　targety 
p3 : [IN] 変数または、数値　：　targetz
p4 : [IN] 変数または、数値　：　upvecx
p5 : [IN] 変数または、数値　：　upvecy 
p6 : [IN] 変数または、数値　：　upvecz

%inst
カメラの注視点を指定する。


→引数
1. [IN] 変数または、数値　：　targetx
2. [IN] 変数または、数値　：　targety 
3. [IN] 変数または、数値　：　targetz
　　カメラの注視点を(targetx, targety, targetz)にセットする。
　　実数。

4. [IN] 変数または、数値　：　upvecx
5. [IN] 変数または、数値　：　upvecy 
6. [IN] 変数または、数値　：　upvecz
　　カメラの上方向のベクトルを指定する。
　　内部で、正規化して使用される。
　　実数。



バージョン : ver1.0.0.1

%index
E3DChkInView
hsidで識別されるモデルが、視野内にあるかどうかを、判定します。
%group
Easy3D For HSP3 : 描画準備

%prm
p1,p2
p1 : [IN] 変数または、数値　：　scid
p2 : [IN] 変数または、数値　：　hsid

%inst
hsidで識別されるモデルが、視野内にあるかどうかを、判定します。

結果は、E3DHSPの内部データに、セットされます。

視野外のオブジェクトや、パーツは、
E3DRender時に、
自動的に、処理をスキップするようになります。

html{
<strong>必ず、E3DSetPosや、E3DSetNewPoseより後、
E3DRenderや、あたり判定より前に、
呼び出してください。
</strong>
}htmlこの命令を呼び出した直後のstatシステム変数には、
ひとつも視野内にパーツがない場合は０が、
少なくとも１つは視野内にパーツがある場合は１がセットされます。





→引数
1. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。

2. [IN] 変数または、数値　：　hsid
　　形状データを識別するid



バージョン : ver1.0.0.1

%index
E3DEnableDbgFile
デバッグ情報を、dbg.txtに出力するように、します。
%group
Easy3D For HSP3 : デバッグ

%prm
なし

%inst
デバッグ情報を、dbg.txtに出力するように、します。


→引数
なし

バージョン : ver1.0.0.1

%index
E3DSetProjection
プロジェクションを指定する。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　near
p2 : [IN] 変数または、数値　：　far 
p3 : [IN] 変数または、数値　：　fovdeg

%inst
プロジェクションを指定する。

この関数を呼び出さなかった場合は、
near面：100.0, far面：10000.0, 視野角：45.0度
がdefaultで適用される。

引数に不正な値が渡された場合も、
default値が適用される。




→引数
1. [IN] 変数または、数値　：　near
　　クリッピングの近い側の距離
　　実数。

2. [IN] 変数または、数値　：　far 
　　クリッピングの遠い側の距離
　　実数。

3. [IN] 変数または、数値　：　fovdeg
　　視野角（degree）
　　実数。



バージョン : ver1.0.0.1

%index
E3DGetKeyboardState
256 個の仮想キーの状態を、指定されたバッファkeybufへコピーします。
%group
Easy3D For HSP3 : キーボード

%prm
p1
p1 : [OUT] 変数　：　keybuf

%inst
256 個の仮想キーの状態を、指定されたバッファkeybufへコピーします。

keybuf は、この関数を使用する前に、
dim keybuf, 256
で、確保してください。

複数のキーの状態を、一度の呼び出しで、
取得できます。

例えば、Ａキーが押されているかどうかを
確かめる場合は、
E3DGetKeyboardState
呼び出し後に、
keybuf('A') の値を調べます。
（　’　を忘れずに。　）
０が入っていた場合は、押されていません。
１が入っていた場合は、押されています。

具体的な使用例は、zip中の、hsp ファイルをご覧ください。

バーチャルキー情報は、zip中の、
e3dhsp3.as で、
VK_ で始まる定数として、宣言しています。

html{
<table border="1">
	<tr><th>定数</th>	<th>キー操作</th>	<th>キー操作</th></tr>
	<tr><td>VK_LBUTTON</td>	<td>マウス　左クリック</td>	<td></td></tr>
	<tr><td>VK_RBUTTON</td>	<td>マウス　右クリック</td>	<td></td></tr>
	<tr><td>VK_CANCEL </td>	<td>Ctrl + Break</td>	<td></td></tr>

	<tr><td>VK_MBUTTON</td>	<td>ホイールクリック</td>	<td></td></tr>
	<tr><td>VK_BACK   </td>	<td>Back Space</td>	<td></td></tr>
	<tr><td>VK_TAB    </td>	<td>Tabキー</td>	<td></td></tr>

	<tr><td>VK_CLEAR  </td>	<td>NumLock を外した状態のテンキー5</td>	<td></td></tr>
	<tr><td>VK_RETURN </td>	<td>Enter</td>	<td></td></tr>
	<tr><td>VK_SHIFT  </td>	<td>Shift</td>	<td></td></tr>

	<tr><td>VK_CONTROL</td>	<td>Ctrl</td>	<td></td></tr>
	<tr><td>VK_MENU   </td>	<td>Alt</td>	<td></td></tr>
	<tr><td>VK_PAUSE  </td>	<td>Pause</td>	<td>Ctrl + NumLock</td></tr>

	<tr><td>VK_CAPITAL</td>	<td>Shift + CapsLock</td>	<td></td></tr>
	<tr><td>VK_HANJA  </td>	<td>Alt + 半角／全角（漢字）</td>	<td></td></tr>
	<tr><td>VK_KANJI  </td>	<td>Alt + 半角／全角（漢字）</td>	<td></td></tr>
	<tr><td>VK_ESCAPE </td>	<td>Esc</td>	<td></td></tr>
	<tr><td>VK_SPACE   </td>	<td>スペースキー</td>	<td></td></tr>

	<tr><td>VK_PRIOR   </td>	<td>PageUp</td>	<td></td></tr>
	<tr><td>VK_NEXT    </td>	<td>PageDown</td>	<td></td></tr>
	<tr><td>VK_END     </td>	<td>End</td>	<td>Shift + テンキー1</td></tr>

	<tr><td>VK_HOME    </td>	<td>Home</td>	<td>Shift + テンキー7</td></tr>
	<tr><td>VK_LEFT    </td>	<td>左矢印キー</td>	<td>Shift + テンキー4</td></tr>
	<tr><td>VK_UP      </td>	<td>上矢印キー</td>	<td>Shift + テンキー8</td></tr>
	<tr><td>VK_RIGHT   </td>	<td>右矢印キー</td>	<td>Shift + テンキー6</td></tr>
	<tr><td>VK_DOWN    </td>	<td>下矢印キー</td>	<td>Shift + テンキー2</td></tr>
	<tr><td>VK_SNAPSHOT</td>	<td>PrintScreen</td>	<td></td></tr>
	<tr><td>VK_INSERT  </td>	<td>Insert</td>	<td>Shift + テンキー0</td></tr>

	<tr><td>VK_DELETE  </td>	<td>Delete</td>	<td>Shift + テンキー.</td></tr>
	<tr><td>'0'</td>	<td>0</td>	<td></td></tr>
	<tr><td>...</td>	<td>...</td>	<td></td></tr>
	<tr><td>'9'</td>	<td>9</td>	<td></td></tr>
	<tr><td>'A'</td>	<td>A</td>	<td></td></tr>
	<tr><td>...</td>	<td>...</td>	<td></td></tr>
	<tr><td>'Z'</td>	<td>Z</td>	<td></td></tr>
	<tr><td>VK_LWIN </td>	<td>ウィンドウズキー（左）</td>	<td></td></tr>
	<tr><td>VK_RWIN </td>	<td>ウィンドウズキー（右）</td>	<td></td></tr>
	<tr><td>VK_APPS </td>	<td>Applicationキー	（右クリックと同等機能のキーのことです。）</td>	<td></td></tr>

	<tr><td>VK_NUMPAD0  </td>	<td>テンキーの０</td>	<td></td></tr>
	<tr><td>...</td>	<td>...</td>	<td></td></tr>
	<tr><td>VK_NUMPAD9  </td>	<td>テンキーの９</td>	<td></td></tr>

	<tr><td>VK_MULTIPLY </td>	<td>テンキーの *</td>	<td></td></tr>
	<tr><td>VK_ADD      </td>	<td>テンキーの +</td>	<td></td></tr>
	<tr><td>VK_SUBTRACT </td>	<td>テンキーの -</td>	<td></td></tr>
	<tr><td>VK_DECIMAL  </td>	<td>テンキーの .</td>	<td></td></tr>
	<tr><td>VK_DIVIDE   </td>	<td>テンキーの /</td>	<td></td></tr>

	<tr><td>VK_F1 </td>	<td>F1</td>	<td></td></tr>
	<tr><td>...</td>	<td>...</td>	<td></td></tr>
	<tr><td>VK_F12</td>	<td>F12</td>	<td></td></tr>
	<tr><td>VK_NUMLOCK</td>	<td>NumLock</td>	<td></td></tr>
	<tr><td>VK_SCROLL </td>	<td>ScrollLock</td>	<td></td></tr>
</table>

<br>
<table border="1">
	<tr><th>定数</th>	<th>キー操作</th>	<th>キー操作</th></tr>

	<tr><td>VK_LSHIFT  </td>	<td>Shift（左）</td>	<td></td></tr>
	<tr><td>VK_RSHIFT  </td>	<td>Shift（右）</td>	<td></td></tr>
	<tr><td>VK_LCONTROL</td>	<td>Ctrl（左）</td>	<td></td></tr>

	<tr><td>VK_RCONTROL</td>	<td>Ctrl（右）</td>	<td></td></tr>
	<tr><td>VK_LMENU   </td>	<td>Alt（左）</td>	<td></td></tr>
	<tr><td>VK_RMENU   </td>	<td>Alt（右）</td>	<td></td></tr>

	<tr><td>VK_OEM_1     </td>	<td>';:' for US</td>	<td>:*</td></tr>
	<tr><td>VK_OEM_PLUS  </td>	<td>'+' any country</td>	<td>;+</td></tr>
	<tr><td>VK_OEM_COMMA </td>	<td>',' any country</td>	<td>,&lt;</td></tr>

	<tr><td>VK_OEM_MINUS </td>	<td>'-' any country</td>	<td>-=</td></tr>
	<tr><td>VK_OEM_PERIOD</td>	<td>'.' any country</td>	<td>.&gt;</td></tr>
	<tr><td>VK_OEM_2     </td>	<td>'/?' for US</td>	<td>/?</td></tr>

	<tr><td>VK_OEM_3     </td>	<td>'`~' for US</td>	<td>@`</td></tr>
	<tr><td>VK_OEM_4</td>	<td>'[{' for US</td>	<td>[{</td></tr>
	<tr><td>VK_OEM_5</td>	<td>'\|' for US</td>	<td>\ |</td></tr>

	<tr><td>VK_OEM_6</td>	<td>']}' for US</td>	<td>]}</td></tr>
	<tr><td>VK_OEM_7</td>	<td>''"' for US</td>	<td>^~</td></tr>
</table>

<br>
<table border="1">
	<tr><th>定数</th>	<th>キー操作</th>	<th>キー操作</th></tr>
	<tr><td>VK_OEM_102  </td>	<td>"<>" or "\|" on RT 102-key kbd.</td>	<td>_ろ</td></tr>
</table>
}html


→引数
1. [OUT] 変数　：　keybuf
　　keybufに、キーの状態が、代入されます。
　　keybufは、dim keybuf, 256 で、
　　作成されている必要があります。



バージョン : ver1.0.0.1

%index
E3DCos
cosを取得する。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2
p1 : [IN] 変数または、数値　：　degree
p2 : [OUT] 変数　：　ret

%inst
cosを取得する。


→引数
1. [IN] 変数または、数値　：　degree
　　degree度のcosを計算します。
　　実数。

2. [OUT] 変数　：　ret
　　cos の結果がセットされる。
　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DSin
sinを取得する。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2
p1 : [IN] 変数または、数値　：　degree
p2 : [OUT] 変数　：　ret

%inst
sinを取得する。


→引数
1. [IN] 変数または、数値　：　degree
　　degree度のsinを計算します。
　　実数。

2. [OUT] 変数　：　ret
　　sin の結果がセットされる。
　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DACos
acosを取得する。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2
p1 : [IN] 変数または、数値　：　dot
p2 : [OUT] 変数　：　degree

%inst
acosを取得する。


→引数
1. [IN] 変数または、数値　：　dot
　　たとえば、内積をいれる。

2. [OUT] 変数　：　degree
　　acos( dot ) が
　　degreeにセットされる。
　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DDot
(vecx1, vecy1, vecz1)と、（vecx2, vecy2, vecz2）を、それぞれ正規化したもの同士の内積を取得する。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 変数または、数値　：　vecx1
p2 : [IN] 変数または、数値　：　vecy1 
p3 : [IN] 変数または、数値　：　vecz1
p4 : [IN] 変数または、数値　：　vecx2
p5 : [IN] 変数または、数値　：　vecy2 
p6 : [IN] 変数または、数値　：　vecz2
p7 : [OUT] 変数　：　ret

%inst
(vecx1, vecy1, vecz1)と、（vecx2, vecy2, vecz2）を、それぞれ正規化したもの同士の内積を取得する。




→引数
1. [IN] 変数または、数値　：　vecx1
2. [IN] 変数または、数値　：　vecy1 
3. [IN] 変数または、数値　：　vecz1
　　実数。

4. [IN] 変数または、数値　：　vecx2
5. [IN] 変数または、数値　：　vecy2 
6. [IN] 変数または、数値　：　vecz2
　　実数。

7. [OUT] 変数　：　ret
　　結果が代入される。
　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DCross
(vecx1, vecy1, vecz1)と、（vecx2, vecy2, vecz2）の両方に垂直で、大きさが１ なベクトル(retx, rety,
retz)を取得する。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9
p1 : [IN] 変数または、数値　：　vecx1
p2 : [IN] 変数または、数値　：　vecy1 
p3 : [IN] 変数または、数値　：　vecz1
p4 : [IN] 変数または、数値　：　vecx2
p5 : [IN] 変数または、数値　：　vecy2 
p6 : [IN] 変数または、数値　：　vecz2
p7 : [OUT] 変数　：　retx
p8 : [OUT] 変数　：　rety
p9 : [OUT] 変数　：　retz

%inst
(vecx1, vecy1, vecz1)と、（vecx2, vecy2, vecz2）の両方に垂直で、大きさが１ なベクトル(retx, rety,
retz)を取得する。




→引数
1. [IN] 変数または、数値　：　vecx1
2. [IN] 変数または、数値　：　vecy1 
3. [IN] 変数または、数値　：　vecz1
　　実数。

4. [IN] 変数または、数値　：　vecx2
5. [IN] 変数または、数値　：　vecy2 
6. [IN] 変数または、数値　：　vecz2
　　実数。

7. [OUT] 変数　：　retx
8. [OUT] 変数　：　rety
9. [OUT] 変数　：　retz
　　結果が代入される。
　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DAtan
atan ( val ) のdegreeを取得します。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2
p1 : [IN] 変数または、数値　：　val
p2 : [OUT] 変数　：　retdeg

%inst
atan ( val ) のdegreeを取得します。


→引数
1. [IN] 変数または、数値　：　val
　　実数。

2. [OUT] 変数　：　retdeg
　　retdegに、atan( val ) の角度(degree)が入ります。
　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DAtan2
atan2( y, x ) のdegreeを取得します。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　y
p2 : [IN] 変数または、数値　：　x 
p3 : [OUT] 変数　：　retdeg

%inst
atan2( y, x ) のdegreeを取得します。


→引数
1. [IN] 変数または、数値　：　y
2. [IN] 変数または、数値　：　x 
　　実数。

3. [OUT] 変数　：　retdeg
　　retdegに、atan2( y, x ) の角度(degree)が入ります。
　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DSqrt
sqrt( val ) を取得します。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2
p1 : [IN] 変数または、数値　：　val
p2 : [OUT] 変数　：　ret

%inst
sqrt( val ) を取得します。


→引数
1. [IN] 変数または、数値　：　val
　　実数。

2. [OUT] 変数　：　ret
　　retに、sqrt( val ) が入ります。
　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DDrawText
画面上の(posx, posy) に、r, g, b で指定した色で、strの文字列を書く。
%group
Easy3D For HSP3 : テキスト

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 変数または、数値　：　posx
p2 : [IN] 変数または、数値　：　posy 
p3 : [IN] 変数または、数値　：　scale
p4 : [IN] 変数または、数値　：　r 
p5 : [IN] 変数または、数値　：　g
p6 : [IN] 変数または、数値　：　b 
p7 : [IN] 文字列または、文字列変数　：　str

%inst
画面上の(posx, posy) に、r, g, b で指定した色で、strの文字列を書く。

英数字のみ。
scaleが１.0のときは、１２ポイントの大きさ。




→引数
1. [IN] 変数または、数値　：　posx
2. [IN] 変数または、数値　：　posy 
　　座標。整数。

3. [IN] 変数または、数値　：　scale
　　実数。

4. [IN] 変数または、数値　：　r 
5. [IN] 変数または、数値　：　g
6. [IN] 変数または、数値　：　b 
　　色（０から２５５）

7. [IN] 文字列または、文字列変数　：　str
　　表示文字列。



バージョン : ver1.0.0.1

%index
E3DDrawBigText
画面上の(posx, posy) に、r, g, b で指定した色で、strの文字列を書く。
%group
Easy3D For HSP3 : テキスト

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 変数または、数値　：　posx
p2 : [IN] 変数または、数値　：　posy 
p3 : [IN] 変数または、数値　：　scale
p4 : [IN] 変数または、数値　：　r 
p5 : [IN] 変数または、数値　：　g
p6 : [IN] 変数または、数値　：　b 
p7 : [IN] 文字列または、文字列変数　：　str

%inst
画面上の(posx, posy) に、r, g, b で指定した色で、strの文字列を書く。

英数字のみ。
scaleが１のときは、３６ポイントの大きさ。




→引数
1. [IN] 変数または、数値　：　posx
2. [IN] 変数または、数値　：　posy 
　　座標。整数。

3. [IN] 変数または、数値　：　scale
　　実数。

4. [IN] 変数または、数値　：　r 
5. [IN] 変数または、数値　：　g
6. [IN] 変数または、数値　：　b 
　　色（０から２５５）

7. [IN] 文字列または、文字列変数　：　str
　　表示文字列。



バージョン : ver1.0.0.1

%index
E3DRand
0から（range - 1）までの間の、乱数を取得する。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2
p1 : [IN] 変数または、数値　：　range
p2 : [OUT] 変数　：　rand

%inst
0から（range - 1）までの間の、乱数を取得する。


→引数
1. [IN] 変数または、数値　：　range
　　乱数の範囲を指定する。
　　整数。

2. [OUT] 変数　：　rand
　　乱数がセットされる。
　　整数。



バージョン : ver1.0.0.1

%index
E3DSeed
乱数の初期化をする。
%group
Easy3D For HSP3 : 算術

%prm
p1
p1 : [IN] 変数または、数値　：　seed

%inst
乱数の初期化をする。
（乱数のseedをセットする。）
srand( (unsigned)seed )を実行する。



→引数
1. [IN] 変数または、数値　：　seed
　　srandに渡す値を指定する。



バージョン : ver1.0.0.1

%index
E3DWaitByFPS
指定したfpsに、近くなるように、waitします。
%group
Easy3D For HSP3 : 同期

%prm
p1,p2
p1 : [IN] 変数または、数値　：　ｆｐｓ
p2 : [OUT] 変数　：　retfps

%inst
指定したfpsに、近くなるように、waitします。

ｆｐｓとは、1秒間に描画するのこと回数です。

指定したｆｐｓ以上、
処理を行わないようにするための命令です。

遅いマシンが、速くなるわけではないので、
注意してください。

必ず、HSPの標準命令、”await 0”と
セットで使用してください。

実際のｆｐｓが、retfps変数に、代入されます。




→引数
1. [IN] 変数または、数値　：　ｆｐｓ
　　指定したｆｐｓに、近くなるように、waitします。
　　整数。

2. [OUT] 変数　：　retfps
　　実際のfpsが代入されます。
　　整数。


バージョン : ver1.0.0.1

%index
E3DGetFPS
fpsを計測します。
%group
Easy3D For HSP3 : 同期

%prm
p1
p1 : [OUT] 変数　：　retfps

%inst
fpsを計測します。

メインループの最後などで呼び出すことを想定しています。
E3DGetFPSが呼ばれる時間間隔から、
1秒間あたりに、何回呼び出されるかを計算します。





→引数
1. [OUT] 変数　：　retfps
　　fpsが代入されます。
　　整数。


バージョン : ver1.0.0.1

%index
E3DCreateLight
光源を作成します。
%group
Easy3D For HSP3 : ライト

%prm
p1
p1 : [OUT] 変数　：　lightID

%inst
光源を作成します。

光源の識別番号、lightIDが取得できます。
以後、光源のパラメータの設定には、
この、lightIDを使用します。




→引数
1. [OUT] 変数　：　lightID
　　作成したライトを識別するID。


バージョン : ver1.0.0.1

%index
E3DSetDirectionalLight
lightIDで識別される光源に、平行光源のパラメータをセットする。
%group
Easy3D For HSP3 : ライト

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 変数または、数値　：　lightID
p2 : [IN] 変数または、数値　：　dirx
p3 : [IN] 変数または、数値　：　diry 
p4 : [IN] 変数または、数値　：　dirz
p5 : [IN] 変数または、数値　：　r
p6 : [IN] 変数または、数値　：　g 
p7 : [IN] 変数または、数値　：　b

%inst
lightIDで識別される光源に、平行光源のパラメータをセットする。




→引数
1. [IN] 変数または、数値　：　lightID
　　光源を識別するid

2. [IN] 変数または、数値　：　dirx
3. [IN] 変数または、数値　：　diry 
4. [IN] 変数または、数値　：　dirz
　　平行光源の向きを、
　　ベクトル(dirx, diry, dirz)を正規化したベクトルに、
　　設定する。
　　実数。

5. [IN] 変数または、数値　：　r
6. [IN] 変数または、数値　：　g 
7. [IN] 変数または、数値　：　b
　　平行光源の色を、
　　（r, g, b）に設定する。
　　各色の値は、０から２５５までの値とする。



バージョン : ver1.0.0.1

%index
E3DSetPointLight
lightIDで識別される光源に、ポイントライトのパラメータをセットする。
%group
Easy3D For HSP3 : ライト

%prm
p1,p2,p3,p4,p5,p6,p7,p8
p1 : [IN] 変数または、数値　：　lightID
p2 : [IN] 変数または、数値　：　posx
p3 : [IN] 変数または、数値　：　posy 
p4 : [IN] 変数または、数値　：　posz
p5 : [IN] 変数または、数値　：　dist
p6 : [IN] 変数または、数値　：　r
p7 : [IN] 変数または、数値　：　g 
p8 : [IN] 変数または、数値　：　b

%inst
lightIDで識別される光源に、ポイントライトのパラメータをセットする。


→引数
1. [IN] 変数または、数値　：　lightID
　　光源を識別するid

2. [IN] 変数または、数値　：　posx
3. [IN] 変数または、数値　：　posy 
4. [IN] 変数または、数値　：　posz
　　ポイントライトの位置を、
　　（posx, posy, posz）に設定する。
　　実数。

5. [IN] 変数または、数値　：　dist
　　ポイントライトの光が届く距離を設定します。
　　実数。

6. [IN] 変数または、数値　：　r
7. [IN] 変数または、数値　：　g 
8. [IN] 変数または、数値　：　b
　　ポイントライトの色を、
　　（r, g, b）に設定する。
　　各色の値は、０から２５５までの値とする。



バージョン : ver1.0.0.1

%index
E3DSetSpotLight
lightIDで識別される光源に、スポットライトのパラメータをセットする。
%group
Easy3D For HSP3 : ライト

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12
p1 : [IN] 変数または、数値　：　lightID
p2 : [IN] 変数または、数値　：　posx
p3 : [IN] 変数または、数値　：　posy 
p4 : [IN] 変数または、数値　：　posz
p5 : [IN] 変数または、数値　：　dirx
p6 : [IN] 変数または、数値　：　diry 
p7 : [IN] 変数または、数値　：　dirz
p8 : [IN] 変数または、数値　：　dist
p9 : [IN] 変数または、数値　：　angle
p10 : [IN] 変数または、数値　：　r
p11 : [IN] 変数または、数値　：　g 
p12 : [IN] 変数または、数値　：　b

%inst
lightIDで識別される光源に、スポットライトのパラメータをセットする。


この命令は、現在サポートされていません。



→引数
1. [IN] 変数または、数値　：　lightID
　　光源を識別するid


2. [IN] 変数または、数値　：　posx
3. [IN] 変数または、数値　：　posy 
4. [IN] 変数または、数値　：　posz
　　スポットライトの位置を、
　　（posx, posy, posz）に設定する。
　　実数。

5. [IN] 変数または、数値　：　dirx
6. [IN] 変数または、数値　：　diry 
7. [IN] 変数または、数値　：　dirz
　　スポットライトの向きを、
　　ベクトル(dirx, diry, dirz)を正規化したベクトルに、
　　設定する。
　　実数。

8. [IN] 変数または、数値　：　dist
　　スポットライトの光が届く距離を設定します。
　　実数。

9. [IN] 変数または、数値　：　angle
　　スポットライトの照らす角度（degree）を設定します。
　　実数。

10. [IN] 変数または、数値　：　r
11. [IN] 変数または、数値　：　g 
12. [IN] 変数または、数値　：　b
　　スポットライトの色を、
　　（r, g, b）に設定する。
　　各色の値は、０から２５５までの値とする。



バージョン : ver1.0.0.1

%index
E3DDestroyLight
ライトを破棄します。
%group
Easy3D For HSP3 : ライト

%prm
p1
p1 : [IN] 変数または、数値　：　lightID

%inst
ライトを破棄します。


→引数
1. [IN] 変数または、数値　：　lightID
　　削除する光源を、識別するid



バージョン : ver1.0.0.1

%index
E3DClearZ
Ｚバッファーをクリアーします。
%group
Easy3D For HSP3 : 描画

%prm
なし

%inst
Ｚバッファーをクリアーします


→引数
なし

バージョン : ver1.0.0.1

%index
E3DDestroyHandlerSet
E3DSigLoad, E3DAddMotionで作成した、
オブジェクトを破棄します。
%group
Easy3D For HSP3 : 後処理

%prm
p1
p1 : [IN] 変数または、数値　：　hsid

%inst
E3DSigLoad, E3DAddMotionで作成した、
オブジェクトを破棄します。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid


バージョン : ver1.0.0.1

%index
E3DSetDispSwitch
ディスプレイスイッチのオン、オフを
行うことが出来ます。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1,p2,p3,p4,p5
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　mk
p3 : [IN] 変数または、数値　：　switchID
p4 : [IN] 変数または、数値　：　frameno
p5 : [IN] 変数または、数値　：　flag

%inst
ディスプレイスイッチのオン、オフを
行うことが出来ます。

ディスプレイスイッチの詳細は、
(Link http://www5d.biglobe.ne.jp/~ochikko/rdb2_dispswitch.htm )ディスプレイスイッチの説明をご覧ください。



mk引数に-1を指定すると、
モーションを読み込んでいなくても、
ディスプレイスイッチをオンオフすることが出来ます。
mkに-1を指定して、
スイッチを一個でもオンにした場合は、
モーションを読み込んだ場合も、
モーションのスイッチ状態よりも優先されます。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　mk
　　モーションを識別する番号

3. [IN] 変数または、数値　：　switchID
　　変更したいスイッチの番号

4. [IN] 変数または、数値　：　frameno
　　フレーム番号、framenoより後のフレームの
　　スイッチを、
　　flagに基づいて、オン、オフします。

5. [IN] 変数または、数値　：　flag
　　flagに１を指定すると、スイッチをオンに、
　　０を指定すると、スイッチをオフにします。



バージョン : ver1.0.0.1

%index
E3DSetMotionFrameNo
E3DSetMotionKindの拡張版です。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　mk
p3 : [IN] 変数または、数値　：　frameno

%inst
E3DSetMotionKindの拡張版です。

モーションの種類と、フレーム番号を
セットすることが出来ます。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　mk
　　モーションを識別する番号

3. [IN] 変数または、数値　：　frameno
　　フレーム番号



バージョン : ver1.0.0.1

%index
E3DCreateSprite
スプライトを作成します。
%group
Easy3D For HSP3 : スプライト

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 文字列または、文字列変数　：　filename
p2 : [IN] 変数または、数値　：　transparentflag
p3 : [OUT] 変数　：　spriteID
p4 : [IN] 変数または、数値　：　tpR
p5 : [IN] 変数または、数値　：　tpG
p6 : [IN] 変数または、数値　：　tpB

%inst
スプライトを作成します。
spriteIDで、スプライトを識別するＩＤを、
取得できます。

スプライトの操作時には、この、spriteIDを
使用します。

作成されるスプライトのサイズは、
元の画像ファイルの大きさと、
異なる場合があります。

サイズは、E3DGetSpriteSize で、
確認してください。




→引数
1. [IN] 文字列または、文字列変数　：　filename
　　画像ファイル名。

2. [IN] 変数または、数値　：　transparentflag
　　透過フラグ。

　　画像ファイルのアルファをもとに透過する場合、
　　あるいは、画像ファイルにアルファが無く透過もしない場合、
　　０を指定してください。

　　１をセットすると、黒色を透過色として色抜きします。

　　２をセットすると、（tpR, tpG, tpB）で指定した色を
　　透過色とします

　　この関数のtransparetflagの意味は、
　　他の関数のtransparentとは、違うので、
　　気を付けてください。


3. [OUT] 変数　：　spriteID
　　作成したスプライトを識別するＩＤ。

4. [IN] 変数または、数値　：　tpR
5. [IN] 変数または、数値　：　tpG
6. [IN] 変数または、数値　：　tpB
　　transparentflag = 2 のとき、
　　透過色を、(tpR, tpG, tpB)で指定します。



バージョン : ver1.0.0.1

%index
E3DBeginSprite
スプライトを描画できるように、
デバイスを準備します。
%group
Easy3D For HSP3 : スプライト

%prm
なし

%inst
スプライトを描画できるように、
デバイスを準備します。

E3DRenderSprite命令を、
E3DBeginSpriteと、E3DEndSpriteで、
サンドイッチするように、記述してください。

E3DBeginSpriteとE3DEndSpriteは、
E3DBeginSceneとE3DEndSceneの間に記述してください。

スプライトを描画すると、レンダーステートが変化するので、
hsidなどを描画した後、最後に、スプライトの描画命令を書くことをおすすめします。




→引数
なし

バージョン : ver1.0.0.1

%index
E3DEndSprite

E3DRenderSprite命令を、
E3DBeginSpriteと、E3DEndSpriteで、
サンドイッチするように、記述してください。
%group
Easy3D For HSP3 : スプライト

%prm
なし

%inst

E3DRenderSprite命令を、
E3DBeginSpriteと、E3DEndSpriteで、
サンドイッチするように、記述してください。



→引数
なし

バージョン : ver1.0.0.1

%index
E3DRenderSprite
spriteIDで識別される、スプライトを、レンダリングします。
%group
Easy3D For HSP3 : スプライト

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 変数または、数値　：　spriteID
p2 : [IN] 変数または、数値　：　scalex
p3 : [IN] 変数または、数値　：　scaley
p4 : [IN] 変数または、数値　：　trax
p5 : [IN] 変数または、数値　：　tray
p6 : [IN] 変数または、数値　：　traz

%inst
spriteIDで識別される、スプライトを、レンダリングします。


→引数
1. [IN] 変数または、数値　：　spriteID
　　スプライトを識別するＩＤ。

2. [IN] 変数または、数値　：　scalex
3. [IN] 変数または、数値　：　scaley
　　スプライトのｘ軸、ｙ軸方向の倍率を指定します。
　　実数を指定。（等倍は１．０）


4. [IN] 変数または、数値　：　trax
5. [IN] 変数または、数値　：　tray
　　スプライトの描画位置（trax, tray）を指定します。
　　指定した位置が、スプライトの左上の座標となります。
　　整数。

6. [IN] 変数または、数値　：　traz
　　描画時の奥行き情報。
　　３D描画との前後関係にも、反映されます。

　　0.0から1.0の実数を指定してください。
　　0.0のとき、一番手前に描画され、
　　1.0のとき、一番奥に描画されます。

　　0.0から1.0の間は、均等な効果ではありません。
　　値を増やしても、あまり効果の無い場所や、
　　少し、値を増やしただけで、効果が大きくなる範囲が　　あります。
　　Easy3Dの場合は、0.99以降が、
　　少し値を増やしただけで、
　　効果が大きい範囲となります。



バージョン : ver1.0.0.1<BR>
      <BR>
      ver2.0.0.4で引数追加<BR>
      

%index
E3DGetSpriteSize
spriteIDで識別される、スプライトの、サイズを取得します。
%group
Easy3D For HSP3 : スプライト

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　spriteID
p2 : [OUT] 変数　：　spriteWidth
p3 : [OUT] 変数　：　spriteHeight

%inst
spriteIDで識別される、スプライトの、サイズを取得します。


→引数
1. [IN] 変数または、数値　：　spriteID
　　スプライトを識別するＩＤ。

2. [OUT] 変数　：　spriteWidth
3. [OUT] 変数　：　spriteHeight
　　幅と、高さが、それぞれ、spriteWidth, spriteHeightに
　　代入されます。
　　整数型変数。



バージョン : ver1.0.0.1

%index
E3DSetSpriteRotation
E3DCreateSprite命令で作成したスプライトを回転させます。
%group
Easy3D For HSP3 : スプライト

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　spid
p2 : [IN] 数値または、変数　：　centerx
p3 : [IN] 数値または、変数　：　centery
p4 : [IN] 数値または、変数　：　rotdeg

%inst
E3DCreateSprite命令で作成したスプライトを回転させます。

（centerx, centery）の座標を中心に回転します。
（0, 0）を指定すると、スプライトの左上を中心に回転します。

スプライトの中央を中心に回転したいときは、
まず、E3DGetSpriteSize命令で、
スプライトのサイズ、sizex, sizey を取得します。
centerx = sizex / 2
centery = sizey / 2
の値をこの関数に渡せば、ＯＫです。

回転角度は、絶対量です。
相対量ではありません。

E3DSetSpriteRotation命令は、
一度、呼び出せば、内部で、情報を記憶しますので、次に異なるパラメータで呼び出すまで、
その値が有効になります。





→引数
1. [IN] 数値または、変数　：　spid
　　スプライトデータを識別するＩＤ

2. [IN] 数値または、変数　：　centerx
3. [IN] 数値または、変数　：　centery
　　(centerx, centery)の座標を中心に回転します。
　　実数対応。

4. [IN] 数値または、変数　：　rotdeg
　　rotdeg 度だけ、スプライトを回転します。
　　実数。


バージョン : ver1.0.0.1

%index
E3DSetSpriteARGB
スプライトに乗算する色を指定します。
%group
Easy3D For HSP3 : スプライト

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　spid
p2 : [IN] 数値または、変数　：　alpha
p3 : [IN] 数値または、変数　：　r
p4 : [IN] 数値または、変数　：　g
p5 : [IN] 数値または、変数　：　b

%inst
スプライトに乗算する色を指定します。

alpha, r, g, b には、それぞれ、
html{
<strong>０から２５５までの値</strong>
}htmlを渡してください。

alpha に255より小さい値を渡せば、
半透明のスプライトの描画が出来ます。

スプライトの色を変えたくない場合には、
r, g, bには、255を渡してください。




→引数
1. [IN] 数値または、変数　：　spid
　　スプライトデータを識別するＩＤ

2. [IN] 数値または、変数　：　alpha
3. [IN] 数値または、変数　：　r
4. [IN] 数値または、変数　：　g
5. [IN] 数値または、変数　：　b
　　スプライトに乗算する色を指定します。
　　半透明にする場合には、
　　alphaに255より小さい値を入れます。



バージョン : ver1.0.0.1

%index
E3DDestroySprite
spriteIDで識別される、スプライトを、
破棄します。
%group
Easy3D For HSP3 : スプライト

%prm
p1
p1 : [IN] 変数または、数値　：　spriteID

%inst
spriteIDで識別される、スプライトを、
破棄します。



→引数
1. [IN] 変数または、数値　：　spriteID
　　スプライトを識別するＩＤ。



バージョン : ver1.0.0.1

%index
E3DChkConfBillboard2
指定した境界球（中心と半径）と、全てのビルボードとのあたり判定をします。
%group
Easy3D For HSP3 : ビルボード

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9
p1 : [IN] 変数または、数値　：　centerx
p2 : [IN] 変数または、数値　：　centery
p3 : [IN] 変数または、数値　：　centerz
p4 : [IN] 変数または、数値　：　r
p5 : [IN] 変数または、数値　：　confrate
p6 : [OUT] 変数　：　resultptr
p7 : [OUT] 変数　：　confbbid
p8 : [IN] 変数または、数値　：　arrayleng
p9 : [OUT] 変数　：　confnum

%inst
指定した境界球（中心と半径）と、全てのビルボードとのあたり判定をします。

hsidの代わりに、境界球を指定すること以外は、
E3DChkConfBillboardと同じです。

衝突したビルボードのＩＤが取得できます。




→引数

1. [IN] 変数または、数値　：　centerx
2. [IN] 変数または、数値　：　centery
3. [IN] 変数または、数値　：　centerz
　　境界球の中心座標( centerx, centery, centerz )
　　実数。

4. [IN] 変数または、数値　：　r
　　境界球の半径
　　実数。

5. [IN] 変数または、数値　：　confrate
　　ビルボードの境界球の半径に、掛ける係数
　　半径　×　confrate
　　で計算されます。
　　実数。

6. [OUT] 変数　：　resultptr
　　あたり判定の結果が代入されます。
　　当たった場合は１が、
　　当たらなかった場合は０が代入されます。


7. [OUT] 変数　：　confbbid
8. [IN] 変数または、数値　：　arrayleng
　　衝突したビルボードのＩＤを格納するための配列
　　dim confbbid, arrayleng
　　などの命令で、配列を作成して、
　　この関数に指定してください。

　　arrayleng個以上のビルボードと、
　　同時に衝突した場合には、エラーになるので、
　　配列長のarraylengは、少し大きめの値にしてください。

9. [OUT] 変数　：　confnum
　　衝突したビルボードの個数が代入されます。
　　maxno = confnum - 1
　　とすると、
　　confbbid(0) から、confbbid(maxno) までの間に、
　　衝突したビルボードのＩＤが代入されます。



バージョン : ver1.0.0.1

%index
E3DChkConfBillboard
hsidで識別されるモデルデータと、全てのビルボードのあたり判定をします。
%group
Easy3D For HSP3 : ビルボード

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　confrate
p3 : [OUT] 変数　：　result
p4 : [OUT] 変数　：　confbbid
p5 : [IN] 変数または、数値　：　arrayleng
p6 : [OUT] 変数　：　confnum

%inst
hsidで識別されるモデルデータと、全てのビルボードのあたり判定をします。

境界球による判定を行います。

当たらなかった場合は、
resultに０が代入され、
当たった場合は、
resultに１が代入されます。

confrateで、ビルボードの境界球の大きさを変更することが出来ます。


例えば、confrateに0.5を入れると、
　実際の半径×0.5
つまり、半分の半径で計算されます。

confrateに小さな値を入れることで、
モデルがビルボードの近くを
すり抜けることが出来るようになります。


衝突したビルボードのＩＤが取得できます。

具体的な使用例は、
html{
<strong>e3dhsp3_ground.hsp</strong>
}html
をご覧ください。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別する番号

2. [IN] 変数または、数値　：　confrate
　　ビルボードの境界球の半径に、掛ける係数
　　半径　×　confrate
　　で計算されます。
　　実数。

3. [OUT] 変数　：　result
　　あたり判定の結果が代入されます。
　　当たった場合は１が、
　　当たらなかった場合は０が代入されます。

4. [OUT] 変数　：　confbbid
5. [IN] 変数または、数値　：　arrayleng
　　衝突したビルボードのＩＤを格納するための配列
　　dim confbbid, arrayleng
　　などの命令で、配列を作成して、
　　この関数に指定してください。

　　arrayleng個以上のビルボードと、
　　同時に衝突した場合には、エラーになるので、
　　配列長のarraylengは、少し大きめの値にしてください。

6. [OUT] 変数　：　confnum
　　衝突したビルボードの個数が代入されます。
　　maxno = confnum - 1
　　とすると、
　　confbbid(0) から、confbbid(maxno) までの間に、
　　衝突したビルボードのＩＤが代入されます。



バージョン : ver1.0.0.1

%index
E3DChkConfBySphere
境界球によるあたり判定を行います。
%group
Easy3D For HSP3 : 当たり判定

%prm
p1,p2,p3,p4
p1 : [IN] 変数または、数値　：　hsid1
p2 : [IN] 変数または、数値　：　hsid2
p3 : [IN] 変数または、数値　：　conflevel
p4 : [OUT] 変数　：　confflag

%inst
境界球によるあたり判定を行います。
判定の際に、E3DChkInViewでセットした
データを使用します。

conflevelに１を指定した場合は、
モデル単位の粗い判定のみを行います。

conflevelに２を指定した場合は、
パーツ単位の判定を行います。


現在は、
任意のパーツ同士のあたり判定の出来る、
E3DChkConfBySphere2があります。





→引数
1. [IN] 変数または、数値　：　hsid1
　　形状データを識別するid

2. [IN] 変数または、数値　：　hsid2
　　形状データを識別するid

3. [IN] 変数または、数値　：　conflevel
　　１を指定した場合は、モデル単位の判定を、
　　２を指定した場合は、パーツ単位の判定をします。

4. [OUT] 変数　：　confflag
　　hsid1, hsid2で識別される形状同士が、
　　衝突している場合は、１が、
　　衝突していない場合は０がセットされる。



バージョン : ver1.0.0.1

%index
E3DChkConfBySphere2
境界球によるあたり判定を、任意のパーツごとに行います。
%group
Easy3D For HSP3 : 当たり判定

%prm
p1,p2,p3,p4,p5
p1 : [IN] 変数または、数値　：　hsid1
p2 : [IN] 変数または、数値　：　partno1
p3 : [IN] 変数または、数値　：　hsid2
p4 : [IN] 変数または、数値　：　partno2
p5 : [OUT] 変数　：　confflag

%inst
境界球によるあたり判定を、任意のパーツごとに行います。

判定の際に、E3DChkInViewでセットした
データを使用します。


partno1, partno2には、
E3DGetPartNoByNameで取得した
パーツの番号を渡してください。

partnoに-1を指定すると、
モデル全体とあたり判定をします。





→引数
1. [IN] 変数または、数値　：　hsid1
　　形状データを識別するid
2. [IN] 変数または、数値　：　partno1
　　hsid1のモデル中のパーツの番号

3. [IN] 変数または、数値　：　hsid2
　　形状データを識別するid
4. [IN] 変数または、数値　：　partno2
　　hsid2のモデル中のパーツの番号

5. [OUT] 変数　：　confflag
　　hsid1, hsid2で識別される形状同士が、
　　衝突している場合は、１が、
　　衝突していない場合は０がセットされる。



バージョン : ver1.0.0.1

%index
E3DCreateProgressBar
メインウインドウの下の部分に、プログレスバーを作ります。
%group
Easy3D For HSP3 : プログレスバー

%prm
なし

%inst
メインウインドウの下の部分に、プログレスバーを作ります。




→引数
なし

バージョン : ver1.0.0.1

%index
E3DSetProgressBar
作業の達成率などを、
プログレスバーに表示させます。
%group
Easy3D For HSP3 : プログレスバー

%prm
p1
p1 : [IN] 変数または、数値　：　newpos

%inst
作業の達成率などを、
プログレスバーに表示させます。

newpos は、０から１００の間の数を、
セットしてください。




→引数
1. [IN] 変数または、数値　：　newpos
　　0から１００の値。



バージョン : ver1.0.0.1

%index
E3DDestroyProgressBar
プログレスバーを削除します。
%group
Easy3D For HSP3 : プログレスバー

%prm
なし

%inst
プログレスバーを削除します。




→引数
なし

バージョン : ver1.0.0.1

%index
E3DLoadGroundBMP
BMPデータから、地面を生成します。
%group
Easy3D For HSP3 : 地面

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9,p10
p1 : [IN] 文字列または、文字列変数　：　filename1
p2 : [IN] 文字列または、文字列変数　：　filename2
p3 : [IN] 文字列または、文字列変数　：　filename3
p4 : [IN] 文字列または、文字列変数　：　filename4
p5 : [IN] 変数または、数値　：　maxx
p6 : [IN] 変数または、数値　：　maxz
p7 : [IN] 変数または、数値　：　divx
p8 : [IN] 変数または、数値　：　divz
p9 : [IN] 変数または、数値　：　maxheight
p10 : [OUT] 変数　：　hsid

%inst
BMPデータから、地面を生成します。

詳しくは、(Link http://www5d.biglobe.ne.jp/~ochikko/e3dhsp_ground.htm )地面データの作り方をご覧ください。



→引数
1. [IN] 文字列または、文字列変数　：　filename1
　　地面の座標情報の元となる、ＢＭＰファイル名

2. [IN] 文字列または、文字列変数　：　filename2
　　地面の道の情報の元となる、ＢＭＰファイル名

3. [IN] 文字列または、文字列変数　：　filename3
　　地面の川の情報の元となる、ＢＭＰファイル名

4. [IN] 文字列または、文字列変数　：　filename4
　　地面、道、川の模様を決める、ＢＭＰファイル名

5. [IN] 変数または、数値　：　maxx
　　地面のＸ座標の最大値
　　実数。

6. [IN] 変数または、数値　：　maxz
　　地面のＺ座標の最大値
　　実数。

7. [IN] 変数または、数値　：　divx
　　X方向の分割数

8. [IN] 変数または、数値　：　divz
　　Z方向の分割数

9. [IN] 変数または、数値　：　maxheight
　　地面の高さの最大値
　　実数。

10. [OUT] 変数　：　hsid
　　作成した地面データを識別する、ＩＤ



バージョン : ver1.0.0.1

%index
E3DCameraPosForward
カメラを、向いている方向に、
stepの距離だけ
移動させます。
%group
Easy3D For HSP3 : カメラ

%prm
p1
p1 : [IN] 変数または、数値　：　step

%inst
カメラを、向いている方向に、
stepの距離だけ
移動させます。

stepにマイナスを与えると、
後ろに進めます。




→引数
1. [IN] 変数または、数値　：　step
　　進む距離を指定してください。
　　実数。



バージョン : ver1.0.0.1

%index
E3DSetBeforePos
E3DChkConfGroundで使用する座標を保存します。
%group
Easy3D For HSP3 : モデル位置

%prm
p1
p1 : [IN] 変数または、数値　：　charahsid

%inst
E3DChkConfGroundで使用する座標を保存します。
一つ前の座標を保存するための命令です。
保存した値は、内部で、当たり判定命令で使用します。

メインループの最後の部分などで、
呼んでください。
一番最初のE3DPosの直後でも、
呼んでください。




→引数
1. [IN] 変数または、数値　：　charahsid
　　形状データを識別するid



バージョン : ver1.0.0.1

%index
E3DChkConfGround
groundhsidで識別される地面と、charahsidで識別されるキャラクターとのあたり判定をします。
%group
Easy3D For HSP3 : 当たり判定

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12
p1 : [IN] 変数または、数値　：　charahsid
p2 : [IN] 変数または、数値　：　groundhsid
p3 : [IN] 変数または、数値　：　mode
p4 : [IN] 変数または、数値　：　diffmaxy
p5 : [IN] 変数または、数値　：　mapminy
p6 : [OUT] 変数　：　result
p7 : [OUT] 変数　：　adjustx
p8 : [OUT] 変数　：　adjusty
p9 : [OUT] 変数　：　adjustz
p10 : [OUT] 変数　：　nx
p11 : [OUT] 変数　：　ny
p12 : [OUT] 変数　：　nz

%inst
groundhsidで識別される地面と、charahsidで識別されるキャラクターとのあたり判定をします。

groundhsidは、E3DLoadGroundBMP、
または、E3DLoadMQOFileAsGroundで取得したものでなければいけません。

キャラクターの現在の座標と、html{
<strong>E3DSetBeforePos</strong>
}htmlで保存された古い座標とを結ぶ線分と、
地面の各ポリゴンとのあたり判定をします。

地面の上を這うように動くためのモードと、
飛行機のように飛ぶためのモードの
２種類あります。

這うモードの時は、毎回、adjustx,y,zに
地面の座標が返されます。
飛ぶモードの時は、地面と衝突したときに、
その座標がadjustx,y,zに返されます。





→引数
1. [IN] 変数または、数値　：　charahsid
　　移動する形状データを識別するid

2. [IN] 変数または、数値　：　groundhsid
　　E3DLoadGroundBMP、
　　または、E3DLoadMQOFileAsGroundで
　　作成した形状データを
　　識別するid

3. [IN] 変数または、数値　：　mode
　　０を指定すると、飛ぶモード
　　１を指定すると、地面を這うモード

4. [IN] 変数または、数値　：　diffmaxy
　　一度の移動で登ることが出来る高さの最大値を
　　指定してください。
　　実数。

5. [IN] 変数または、数値　：　mapminy
　　groundhsidで識別されるデータの一番低いＹ座標の値
　　通常は、0.0です。
　　実数。

6. [OUT] 変数　：　result
　　あたり判定の結果が代入されます。
　　
　　mode == 0 のとき
　　　　ぶつからなかった場合は、resutl = 0
　　　　ぶつかった場合は、result = 1
　　mode == 1のとき
　　　　キャラクターの下に地面が無かった場合、
　　　　または、全く移動しなかった場合、
　　　　result = 0

　　　　diffmaxyより高い高さを登ろうとしたとき、
　　　　result = 1

　　　　地面を下に降りたとき、
　　　　または、diffmaxyより低い高さを登ったとき、
　　　　result = 2

　　となります。

7. [OUT] 変数　：　adjustx
8. [OUT] 変数　：　adjusty
9. [OUT] 変数　：　adjustz
　　result != 0 のときに、
　　　　mode == 0のときは、ぶつかった座標
　　　　mode == 1のときは、地面の座標が
　　　　(adjustx, adjusty, adjustz)に代入されます。
　　実数型の変数。


10. [OUT] 変数　：　nx
11. [OUT] 変数　：　ny
12. [OUT] 変数　：　nz
　　result != 0 のときに、
　　　　mode == 0のときは、ぶつかったポリゴン
　　　　mode == 1のときは、地面のポリゴンの
　　　　法線ベクトルが、
　　　　(nx ny, nz)に代入されます。
　　　　
　　　　跳ね返る方向を決めるときなどに
　　　　使用できるのではないかと思い、
　　　　加えてみました。

　　　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DChkConfGround2
befposとnewposを結ぶ線分と、groundhsidで識別される地面との
あたり判定をします。
%group
Easy3D For HSP3 : 当たり判定

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17
p1 : [IN] 変数または、数値　：　befposx
p2 : [IN] 変数または、数値　：　befposy
p3 : [IN] 変数または、数値　：　befposz
p4 : [IN] 変数または、数値　：　newposx
p5 : [IN] 変数または、数値　：　newposy
p6 : [IN] 変数または、数値　：　newposz
p7 : [IN] 変数または、数値　：　groundhsid
p8 : [IN] 変数または、数値　：　mode
p9 : [IN] 変数または、数値　：　diffmaxy
p10 : [IN] 変数または、数値　：　mapminy
p11 : [OUT] 変数　：　result
p12 : [OUT] 変数　：　adjustx
p13 : [OUT] 変数　：　adjusty
p14 : [OUT] 変数　：　adjustz
p15 : [OUT] 変数　：　nx
p16 : [OUT] 変数　：　ny
p17 : [OUT] 変数　：　nz

%inst
befposとnewposを結ぶ線分と、groundhsidで識別される地面との
あたり判定をします。

線分の座標を、ユーザーが指定すること以外は、
E3DChkConfGroundと全く、同じです。




→引数
1. [IN] 変数または、数値　：　befposx
2. [IN] 変数または、数値　：　befposy
3. [IN] 変数または、数値　：　befposz
　　線分の始点を（befposx, befposy, befposz）で
　　指定します。
　　実数。

4. [IN] 変数または、数値　：　newposx
5. [IN] 変数または、数値　：　newposy
6. [IN] 変数または、数値　：　newposz
　　線分の終点を（newposx, newposy, newposz）で
　　指定します。
　　実数。

7. [IN] 変数または、数値　：　groundhsid
　　E3DLoadGroundBMP、
　　または、E3DLoadMQOFileAsGroundで
　　作成した形状データを
　　識別するid

8. [IN] 変数または、数値　：　mode
　　０を指定すると、飛ぶモード
　　１を指定すると、地面を這うモード

9. [IN] 変数または、数値　：　diffmaxy
　　一度の移動で登ることが出来る高さの最大値を
　　指定してください。
　　実数。

10. [IN] 変数または、数値　：　mapminy
　　groundhsidで識別されるデータの一番低いＹ座標の値
　　通常は、０．０です。
　　実数。

11. [OUT] 変数　：　result
　　あたり判定の結果が代入されます。
　　
　　mode == 0 のとき
　　　　ぶつからなかった場合は、resutl = 0
　　　　ぶつかった場合は、result = 1
　　mode == 1のとき
　　　　キャラクターの下に地面が無かった場合、
　　　　または、全く移動しなかった場合、
　　　　result = 0

　　　　diffmaxyより高い高さを登ろうとしたとき、
　　　　result = 1

　　　　地面を下に降りたとき、
　　　　または、diffmaxyより低い高さを登ったとき、
　　　　result = 2

12. [OUT] 変数　：　adjustx
13. [OUT] 変数　：　adjusty
14. [OUT] 変数　：　adjustz
　　result != 0 のときに、
　　　　mode == 0のときは、ぶつかった座標
　　　　mode == 1のときは、地面の座標が
　　　　(adjustx, adjusty, adjustz)に代入されます。
　　実数型の変数。


15. [OUT] 変数　：　nx
16. [OUT] 変数　：　ny
17. [OUT] 変数　：　nz
　　result != 0 のときに、
　　　　mode == 0のときは、ぶつかったポリゴン
　　　　mode == 1のときは、地面のポリゴンの
　　　　法線ベクトルが、
　　　　(nx, ny, nz)に代入されます。
　　　　
　　　　跳ね返る方向を決めるときなどに
　　　　使用できるのではないかと思い、
　　　　加えてみました。

　　　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DGetPartNoByName
モデル内のパーツの名前から、パーツの番号を取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 文字列または、文字列変数　：　partname
p3 : [OUT] 変数　：　partno

%inst
モデル内のパーツの名前から、パーツの番号を取得します。

パーツの名前は、RokDeBone2で確認してください。

ver1.0.6.1以前のRokDeBone2では、
メタセコイアから読み込んだデータの、
パーツの名前には、　&quot;　が付いているので、
注意してください。

昔のファイルの場合、
例えば、名前が、&quot;obj1&quot; である場合、
引数partname には、
&quot;\&quot;obj1\&quot;&quot;
というように、\&quot; を使用しなくては、いけません。
（　現在のRokDeBone2で新規作成したファイルでは、
パーツ名に”は付いていません。　）


また、同じ名前のパーツが、複数ある場合、
常に、一番最初に、見つかったパーツの番号が、取得されることに、注意してください。





→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 文字列または、文字列変数　：　partname
　　RokDeBone2で表示される、パーツの名前。

3. [OUT] 変数　：　partno
　　名前がpartnameである、パーツの番号。



バージョン : ver1.0.0.1

%index
E3DGetVertNumOfPart
partnoで識別されるパーツに、いくつの頂点が含まれるかを取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　partno
p3 : [OUT] 変数　：　vertnum

%inst
partnoで識別されるパーツに、いくつの頂点が含まれるかを取得します。

E3DGetVertPos, E3DSetVertPos
に渡す、vertno は、
0 ～ (vertnum - 1) の間でなくては、なりません。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　partno
　　パーツを識別する番号

3. [OUT] 変数　：　vertnum
　　パーツに含まれる頂点数。



バージョン : ver1.0.0.1

%index
E3DGetVertPos
partnoで識別されるパーツ内の、頂点番号vertnoの、頂点の座標を取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　partno
p3 : [IN] 変数または、数値　：　vertno
p4 : [OUT] 変数　：　vertx
p5 : [OUT] 変数　：　verty
p6 : [OUT] 変数　：　vertz
p7 : [IN] 変数または、数値　：　kind

%inst
partnoで識別されるパーツ内の、頂点番号vertnoの、頂点の座標を取得します。



ver5.0.0.4からローカル座標とグローバル座標のどちらかを
取得できるようになりました。



→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　partno
　　パーツを識別する番号

3. [IN] 変数または、数値　：　vertno
　　頂点の番号

4. [OUT] 変数　：　vertx
5. [OUT] 変数　：　verty
6. [OUT] 変数　：　vertz
　　頂点の座標が（vx, vy, vz）に代入されます。
　　実数型の変数。

7. [IN] 変数または、数値　：　kind
　　０を指定するとローカル座標
　　１を指定するとグローバル座標が
　　取得できます。




バージョン : ver1.0.0.1<BR>
      ver5.0.0.4で拡張

%index
E3DSetVertPos
 partnoで識別されるパーツ内の、頂点番号vertnoの、頂点の座標（ローカル座標）をセットします。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　partno
p3 : [IN] 変数または、数値　：　vertno
p4 : [IN] 変数または、数値　：　vertx
p5 : [IN] 変数または、数値　：　verty
p6 : [IN] 変数または、数値　：　vertz

%inst
 partnoで識別されるパーツ内の、頂点番号vertnoの、頂点の座標（ローカル座標）をセットします。


ユーザーが、座標、姿勢を、
全て、自分で管理することを想定した、
上級者向けの機能です。


例えば、目標地点に頂点座標を近づけていきたい場合などは、
E3DSetPos hsid, 0.0, 0.0, 0.0
E3DSetDir hsid, 0.0, 0.0, 0.0
でワールド変換が行われないようにした状態で、
E3DSetVertPosを使い、希望位置へ、
頂点座標をセットする。
などの、使用方法が、考えられます。


AddMotionを行った、モデルデータにも、
使用しないでください。
（使用しても、ハングしたりはしませんが、
あたり判定が、正確に行われません。）


具体的な使用例は、
zip中の、html{
<strong>e3dhsp3_vertpos.hsp</strong>
}html をご覧ください。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　partno
　　パーツを識別する番号

3. [IN] 変数または、数値　：　vertno
　　頂点の番号

4. [IN] 変数または、数値　：　vertx
5. [IN] 変数または、数値　：　verty
6. [IN] 変数または、数値　：　vertz
　　（vertx, verty, vertz ）の座標を、
　　指定の頂点にセットします。
　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DSetPosOnGround
 E3DLoadGroundBMP、または、E3DLoadMQOFileAsGroundで作成した地面上の、適切な高さに、モデルデータを配置するための、関数です。
%group
Easy3D For HSP3 : モデル位置

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　groundid
p3 : [IN] 変数または、数値　：　mapmaxy
p4 : [IN] 変数または、数値　：　mapminy
p5 : [IN] 変数または、数値　：　posx
p6 : [IN] 変数または、数値　：　posz

%inst
 E3DLoadGroundBMP、または、E3DLoadMQOFileAsGroundで作成した地面上の、適切な高さに、モデルデータを配置するための、関数です。

(posx, mapmaxy, posz)と、
(posx, mapminy, posz)を結ぶ線分と、
地面データとの交点を求めて、
その位置に、hsidのモデルデータを配置します。

交点が複数ある場合は、
(posx, mapmaxy, posz)から、一番近い交点が、選ばれます。

この命令を使う前に、少なくとも、一回は、
E3DChkInView groundid
が、呼ばれていないと、ちゃんと動作しません。
 （groundid部分には、配置する地面のhsidを入れてください。）

現バージョンではgroundidは、
E3DLoadGroundBMP、または、E3DLoadMQOFileAsGround
で取得したものしか、使用できません。




→引数
1. [IN] 変数または、数値　：　hsid
　　配置したい形状データを識別するid

2. [IN] 変数または、数値　：　groundid
　　E3DLoadGroundBMP、
　　または、E3DLoadMQOFileAsGroundで
　　作成した地面を識別するid

3. [IN] 変数または、数値　：　mapmaxy
　　地面データの高さの最大値
　　実数。

4. [IN] 変数または、数値　：　mapminy
　　地面データの高さの最小値
　　実数。

5. [IN] 変数または、数値　：　posx
6. [IN] 変数または、数値　：　posz
　　地面の高さをＹとすると、
　　（posx, Y,. posz）に、hsidのモデルデータを配置します。
　　実数。



バージョン : ver1.0.0.1

%index
E3DSetPosOnGroundPart
地面パーツを指定して、地面にオブジェクトを配置します。
%group
Easy3D For HSP3 : モデル位置

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　groundid
p3 : [IN] 変数または、数値　：　groundpart
p4 : [IN] 変数または、数値　：　mapmaxy
p5 : [IN] 変数または、数値　：　mapminy
p6 : [IN] 変数または、数値　：　posx
p7 : [IN] 変数または、数値　：　posz

%inst
地面パーツを指定して、地面にオブジェクトを配置します。

パーツを指定すること以外は、
E3DSetPosOnGroundと同じです。

詳しくは、E3DSetPosOnGroundの説明をお読みください。





→引数
1. [IN] 変数または、数値　：　hsid
　　配置したい形状データを識別するid

2. [IN] 変数または、数値　：　groundid
　　E3DLoadGroundBMP、
　　または、E3DLoadMQOFileAsGroundで
　　作成した地面を識別するid

3. [IN] 変数または、数値　：　groundpart
　　地面のパーツ番号を指定します。
　　E3DGetPartNoByNameで取得した番号を
　　指定してください。

4. [IN] 変数または、数値　：　mapmaxy
　　地面データの高さの最大値
　　実数。

5. [IN] 変数または、数値　：　mapminy
　　地面データの高さの最小値
　　実数。

6. [IN] 変数または、数値　：　posx
7. [IN] 変数または、数値　：　posz
　　地面の高さをＹとすると、
　　（posx, Y,. posz）に、hsidのモデルデータを配置します。
　　実数。



バージョン : ver1.0.0.1

%index
E3DCreateBillboard
ビルボードを作成します。
%group
Easy3D For HSP3 : ビルボード

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 文字列または、文字列変数　：　filename
p2 : [IN] 変数または、数値　：　width
p3 : [IN] 変数または、数値　：　height
p4 : [IN] 変数または、数値　：　transparentflag
p5 : [OUT] 変数　：　billboardid
p6 : [IN] 変数または、数値　：　dirmode
p7 : [IN] 変数または、数値　：　orgflag

%inst
ビルボードを作成します。

1500個まで、ビルボードを作ることが出来ます。


billboardidに、作成したビルボードを識別する
番号が、代入されます。

billboardidは、
E3DSetBillboardPos,
E3DSetBillboardOnGround,
E3DDestroyBillboard,
E3DChkConfBillboard
の関数で、使用します。

billboardidは、hsidとは、全く異なるものなので、E3DSetPosなどの、hsidを使用する関数には、使えません。

E3DCreateBillboardでは、
transparentflagに、１をセットすれば、
黒色を透過色として、扱えます。




→引数
1. [IN] 文字列または、文字列変数　：　filename
　　ビルボードに貼り付けるテクスチャーのファイル名

2. [IN] 変数または、数値　：　width
　　ビルボードの幅。
　　実数。

3. [IN] 変数または、数値　：　height
　　ビルボードの高さ。
　　実数。

4. [IN] 変数または、数値　：　transparentflag
　　１を指定すると、
　　テクスチャーの黒色（r = 0, g=0, b=0）を透過色として、
　　扱います。
　　
　　０を指定すると、
　　テクスチャーファイルの、
　　アルファ値を元に、透過します。

5. [OUT] 変数　：　billboardid
　　作成したビルボードを識別する番号が、代入されます。

6. [IN] 変数または、数値　：　dirmode
　　dirmodeに０を指定すると、
　　ビルボードは、Ｙ軸に関してのみ、回転します。
　　地面に立っている木などに使用してください。

　　dirmodeの１を指定すると、
　　ビルボードは、全方向に回転します。
　　カメラの高さにかかわらず、カメラの方向を向かせたいもの
　　例えば、火や煙などに、使用してください。

7. [IN] 変数または、数値　：　orgflag
　　ビルボードの原点の位置を指定します。

　　orgflagに０を指定すると、
　　原点は、ビルボードの四角形の下の辺の中心になります。
　　地面に生やす木などの場合に、便利です。

　　orgflagに１を指定すると、
　　原点は、ビルボードの中心になります。
　　爆発などの、特殊効果に使う場合に、便利です。



バージョン : ver1.0.0.1

%index
E3DRenderBillboard
E3DCreateBillboard
で作成されたビルボード全てを、
描画します。
%group
Easy3D For HSP3 : ビルボード

%prm
p1,p2
p1 : [IN] 変数または、数値　：　scid
p2 : [IN] 変数または、数値　：　transskip

%inst
E3DCreateBillboard
で作成されたビルボード全てを、
描画します。

各ビルボードは、
視線の方向を向くようにセットされます。

また、
視点から、遠い方から順番に、描画されます。

transskip引数の意味については
E3DTransformBillboardの説明をお読みください。







→引数
1. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。

2. [IN] 変数または、数値　：　transskip
　　描画準備の計算をスキップします。
　　E3DTransformBillboardを使った場合に使用します。



バージョン : ver1.0.0.1

%index
E3DSetBillboardPos
 billboardidで識別されるビルボードの、位置を指定します。
%group
Easy3D For HSP3 : ビルボード

%prm
p1,p2,p3,p4
p1 : [IN] 変数または、数値　：　billboardid
p2 : [IN] 変数または、数値　：　posx
p3 : [IN] 変数または、数値　：　posy
p4 : [IN] 変数または、数値　：　posz

%inst
 billboardidで識別されるビルボードの、位置を指定します。




→引数
1. [IN] 変数または、数値　：　billboardid
　　ビルボードを識別する番号

2. [IN] 変数または、数値　：　posx
3. [IN] 変数または、数値　：　posy
4. [IN] 変数または、数値　：　posz
　　ビルボードの位置を、(posx, posy, posz)
　　にセットします。
　　実数。



バージョン : ver1.0.0.1

%index
E3DSetBillboardOnGround
 billboardidで識別されるビルボードの、位置を、指定したＸＺ座標の、地面の高さにセットします。
%group
Easy3D For HSP3 : ビルボード

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 変数または、数値　：　billboardid
p2 : [IN] 変数または、数値　：　groundid
p3 : [IN] 変数または、数値　：　mapmaxy
p4 : [IN] 変数または、数値　：　mapminy
p5 : [IN] 変数または、数値　：　posx
p6 : [IN] 変数または、数値　：　posz

%inst
 billboardidで識別されるビルボードの、位置を、指定したＸＺ座標の、地面の高さにセットします。

この命令を使う前に、少なくとも、一回は、
E3DChkInView　groundid
が呼ばれている必要があります。
（groundid部分には、配置する地面のhsidを入れてください。）

現バージョンではgroundidは、
E3DLoadGroundBMP、または、E3DLoadMQOFileAsGround
で取得したものしか、使用できません。




→引数
1. [IN] 変数または、数値　：　billboardid
　　ビルボードを識別する番号

2. [IN] 変数または、数値　：　groundid
　　groundidで識別される地面の上に、
　　ビルボードが配置されます。

3. [IN] 変数または、数値　：　mapmaxy
　　地面データの一番大きなＹ座標
　　実数。

4. [IN] 変数または、数値　：　mapminy
　　地面データの一番小さなＹ座標
　　（通常０．０）
　　実数。

5. [IN] 変数または、数値　：　posx
6. [IN] 変数または、数値　：　posz
　　(posx, mapmaxy, posz)と、(posx, mapminy, posz)
　　と地面データとの交点を求めて、
　　地面上の適切な高さに、ビルボードを配置します。
　　実数。



バージョン : ver1.0.0.1

%index
E3DDestroyBillboard
billboardidで識別されるビルボードを、削除します。
%group
Easy3D For HSP3 : ビルボード

%prm
p1
p1 : [IN] 変数または、数値　：　billboardid

%inst
billboardidで識別されるビルボードを、削除します。





→引数
1. [IN] 変数または、数値　：　billboardid
　　ビルボードを識別する番号



バージョン : ver1.0.0.1

%index
E3DLoadMQOFileAsGround
mqo ファイルを地面データとして、読み込みます。
%group
Easy3D For HSP3 : 地面

%prm
p1,p2,p3,p4,p5
p1 : [IN] 文字列または、文字列変数　：　filename
p2 : [IN] 変数または、数値　：　mult
p3 : [OUT] 変数　：　hsid
p4 : [IN] 変数または、数値　：　adjustuvflag
p5 : [IN] 文字列または、文字列変数　：　bonetype

%inst
mqo ファイルを地面データとして、読み込みます。
地面データを識別するidが、戻り値となります。
取得したid は、E3DChkConfGroundなどの関数で、使用できます。




→引数
1. [IN] 文字列または、文字列変数　：　filename
　　読み込む、mqo ファイル名。

2. [IN] 変数または、数値　：　mult
　　形状データの座標に掛ける数値。
　　座標値　＊　mult で計算されます。
　　等倍は１．０
　　実数。

3. [OUT] 変数　：　hsid
　　作成した地面を識別するhsidが代入されます。

4. [IN] 変数または、数値　：　adjustuvflag
　　UV座標を正規化したいときは１を、
　　そうでないときは、０を指定してください。
　　何も指定しないときは、０として扱われます。

5. [IN] 文字列または、文字列変数　：　bonetype
　　mqoにボーンが含まれている場合は
　　ボーンのタイプを指定します。
　　BONETYPE_RDB2を指定するとRokDeBone2形式の
　　線分をボーンと認識するタイプになります。
　　BONETYPE_MIKOを指定すると
　　mikoto形式のタイプになります。
　　省略するとBONETYPE_RDB2になります。
　　これらの定数はe3dhsp3.asで定義されています。





バージョン : ver1.0.0.1<BR>
      ver4.0.1.8で引数追加<BR>
      

%index
E3DSaveMQOFile
hsidで指定したモデルのデータを、mqoの形式で出力します。
%group
Easy3D For HSP3 : モデルデータ

%prm
p1,p2
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 文字列または、文字列変数　：　filename

%inst
hsidで指定したモデルのデータを、mqoの形式で出力します。

地面データの出力などに、使用してください。




→引数
1. [IN] 変数または、数値　：　hsid
　　出力するモデルのhsid

2. [IN] 文字列または、文字列変数　：　filename
　　出力するファイル名



バージョン : ver1.0.0.1

%index
E3DGetBillboardInfo
指定した番号の、ビルボード情報を、取得します。
%group
Easy3D For HSP3 : ビルボード

%prm
p1,p2,p3,p4,p5,p6,p7,p8
p1 : [IN] 変数または、数値　：　billboardid
p2 : [OUT] 変数　：　posx
p3 : [OUT] 変数　：　posy
p4 : [OUT] 変数　：　posz
p5 : [OUT] 変数　：　texname
p6 : [OUT] 変数　：　transparent
p7 : [OUT] 変数　：　width
p8 : [OUT] 変数　：　height

%inst
指定した番号の、ビルボード情報を、取得します。

ビルボードの番号には、
E3DCreateBillboardで取得した番号を、
指定してください。
　
texname には、256以上の大きさの
バッファを指定してください。
例えば、
　　sdim texname, 256, 1
などで、確保した変数を、
指定してください。




→引数
1. [IN] 変数または、数値　：　billboardid
　　情報を取得したいビルボードの番号。
　　E3DCreateBillboardで取得した番号を
　　指定してください。

2. [OUT] 変数　：　posx
3. [OUT] 変数　：　posy
4. [OUT] 変数　：　posz
　　ビルボードの座標が、
　　(posx, posy, posz)に代入されます。
　　実数型の変数。

5. [OUT] 変数　：　texname
　　ビルボードの、テクスチャファイル名が、
　　代入されます。
　　texname には、256以上の大きさのバッファを
　　指定してください。
　　例えば、sdim texname, 256, 1
　　などで、確保した変数を、指定してください。

6. [OUT] 変数　：　transparent
　　ビルボードの、透過モードが、代入されます。
　　transparent == 0 のときは、
　　ビルボードは、
　　テクスチャファイルのアルファ情報によって、
　　透過されます。
　　transparent == 1 のときは、
　　ビルボードは、
　　（R, G, B） == (0, 0, 0)を透過色として、処理されます。

7. [OUT] 変数　：　width
　　ビルボードの幅が、代入されます。
　　実数型の変数。

8. [OUT] 変数　：　height
　　ビルボードの高さが、代入されます。
　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DGetNearBillboard
指定した座標に、一番近いビルボードのIDを取得します。
%group
Easy3D For HSP3 : ビルボード

%prm
p1,p2,p3,p4,p5
p1 : [IN] 変数または、数値　：　posx
p2 : [IN] 変数または、数値　：　posy
p3 : [IN] 変数または、数値　：　posz
p4 : [IN] 変数または、数値　：　maxdist
p5 : [OUT] 変数　：　nearbbid

%inst
指定した座標に、一番近いビルボードのIDを取得します。

maxdist で指定した、距離より、遠いビルボードしか存在しない場合は、
IDに、-1 が代入されます。




→引数
1. [IN] 変数または、数値　：　posx
2. [IN] 変数または、数値　：　posy
3. [IN] 変数または、数値　：　posz
　　位置座標を、（posx, posy, posz）で指定します。
　　実数。

4. [IN] 変数または、数値　：　maxdist
　　maxdistで、指定した距離より、
　　遠いビルボードしかない場合は、
　　nearbbidに-1が代入されます。
　　実数。

5. [OUT] 変数　：　nearbbid
　　（posx, posy, posz） に一番近く、
　　maxdistより近いビルボードのＩＤを代入します。
　　存在しない場合は、-1を代入します。



バージョン : ver1.0.0.1

%index
E3DGetInvisibleFlag
hsidで識別されるモデルの、partnoのパーツのInvisibleFlag(見えないフラグ)を取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　partno
p3 : [OUT] 変数　：　flag

%inst
hsidで識別されるモデルの、partnoのパーツのInvisibleFlag(見えないフラグ)を取得します。

InvisibleFlagが、１になっているパーツは、あたり判定は、行われますが、
表示はされません。
進入禁止区域との、境目に置く、見えないオブジェクトとして、使用することなどが、
考えられます。

partno には、E3DGetPartNoByNameで取得した番号を指定してください。

また、hsidに負の値を渡し、partnoに、ビルボードのid を渡すと、
ビルボードのInvisibleFlag を取得することが出来ます。



→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するID
　　ビルボードのInvisibleFlagを取得する場合は、負の値　　を渡してください。

2. [IN] 変数または、数値　：　partno
　　パーツの番号。
　　E3DGetPartNoByNameで取得した番号、
　　または、ビルボードのＩＤ。

3. [OUT] 変数　：　flag
　　指定したパーツのInvisibleFlag が代入されます。



バージョン : ver1.0.0.1

%index
E3DSetInvisibleFlag
hsidで識別されるモデルの、partnoのパーツのInvisibleFlag(見えないフラグ)をセットします。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　partno
p3 : [IN] 変数または、数値　：　flag

%inst
hsidで識別されるモデルの、partnoのパーツのInvisibleFlag(見えないフラグ)をセットします。

partno には、E3DGetPartNoByNameで取得した番号を指定してください。

また、hsidに負の値を渡し、partnoに、ビルボードのid を渡すと、
ビルボードのInvisibleFlag をセットすることが出来ます。

InvisibleFlag == 0 のとき可視状態（デフォルト）で、
InvisibleFlag == 1 のとき、表示されず、あたり判定だけとなります。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するID
　　ビルボードのInvisibleFlagを取得する場合は、
　　負の値を渡してください。

2. [IN] 変数または、数値　：　partno
　　パーツの番号。
　　E3DGetPartNoByNameで取得した番号、
　　または、ビルボードのＩＤ。

3. [IN] 変数または、数値　：　flag
　　指定したパーツのInvisibleFlag をセットします。



バージョン : ver1.0.0.1

%index
E3DSetMovableArea
移動可能領域を、ＢＭＰファイルから、自動生成します。
%group
Easy3D For HSP3 : 壁

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 文字列または、文字列変数　：　filename1
p2 : [IN] 変数または、数値　：　maxx
p3 : [IN] 変数または、数値　：　maxz
p4 : [IN] 変数または、数値　：　divx
p5 : [IN] 変数または、数値　：　divz
p6 : [IN] 変数または、数値　：　wallheight
p7 : [OUT] 変数　：　hsid

%inst
移動可能領域を、ＢＭＰファイルから、自動生成します。
（色の付いた部分と、付いていない部分の
境界部分に、地面に垂直な、非表示の壁ポリゴンを生成します。）

E3DChkConfWall 命令と併用すれば、
ＢＭＰで、濃い色を付けた部分のみ、移動できるようになります。

具体的な使用例は、zip中の、
html{
<strong>e3dhsp3_wall.hsp</strong>
}html をご覧ください。


メタセコイアデータで、
壁データを作りたい場合は、
メタセコイアのプラグイン、MakeWallをご使用ください。
（おちゃっこＬＡＢのトップページにリンクがあります。）




→引数
1. [IN] 文字列または、文字列変数　：　filename1
　　壁の座標情報の元となる、ＢＭＰファイル名

2. [IN] 変数または、数値　：　maxx
　　壁のＸ座標の最大値
　　実数。

3. [IN] 変数または、数値　：　maxz
　　壁のＺ座標の最大値
　　実数。

4. [IN] 変数または、数値　：　divx
　　X方向の分割数

5. [IN] 変数または、数値　：　divz
　　Z方向の分割数

6. [IN] 変数または、数値　：　wallheight
　　作成する壁の高さ
　　実数。

7. [OUT] 変数　：　hsid
　　作成した壁データを識別する、ＩＤ



バージョン : ver1.0.0.1

%index
E3DChkConfWall
E3DSetMovableArea, または、E3DLoadMQOFileAsMovableAreaで作成した壁データと、キャラクターのあたり判定を行います。
%group
Easy3D For HSP3 : 当たり判定

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9,p10
p1 : [IN] 変数または、数値　：　charahsid
p2 : [IN] 変数または、数値　：　groundhsid
p3 : [IN] 変数または、数値　：　dist
p4 : [OUT] 変数　：　result
p5 : [OUT] 変数　：　adjustx
p6 : [OUT] 変数　：　adjusty
p7 : [OUT] 変数　：　adjustz
p8 : [OUT] 変数　：　nx
p9 : [OUT] 変数　：　ny
p10 : [OUT] 変数　：　nz

%inst
E3DSetMovableArea, または、E3DLoadMQOFileAsMovableAreaで作成した壁データと、キャラクターのあたり判定を行います。

キャラクターの現在の座標と、html{
<strong>E3DSetBeforePos</strong>
}htmlで保存された古い座標とを結ぶ線分と、
壁の各ポリゴンとのあたり判定をします。

壁に沿って位置を移動するために
使用します。

壁の外側から内側へは移動できますが、内側から外側へは移動できないようにします。

具体的な使用例は、zip中の、
html{
<strong>e3dhsp3_wall.hsp</strong>
}html をご覧ください。





→引数
1. [IN] 変数または、数値　：　charahsid
　　移動する形状データを識別するid

2. [IN] 変数または、数値　：　groundhsid
　　E3DSetMovableArea、
　　または、E3DLoadMQOFileAsMovableAreaで
　　作成した形状データを
　　識別するid

3. [IN] 変数または、数値　：　dist
　　跳ね返る距離。
　　distに大きな値を入れると、
　　ぶつかった際に大きく、跳ね返るようになります。
　　実数。

4. [OUT] 変数　：　result
　　あたり判定の結果が代入されます。
　　壁とぶつかった場合は、１が、
　　ぶつからなかった場合は、０が、代入されます。

5. [OUT] 変数　：　adjustx
6. [OUT] 変数　：　adjusty
7. [OUT] 変数　：　adjustz
　　result != 0 のときに、
　　修正後の座標が、
　　(adjustx, adjusty, adjustz)に代入されます。
　　実数型の変数。

8. [OUT] 変数　：　nx
9. [OUT] 変数　：　ny
10. [OUT] 変数　：　nz
　　result != 0 のときに、
　　ぶつかった面の法線ベクトルの値が
　　代入されます。
　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DChkConfWall2
E3DSetMovableArea, または、E3DLoadMQOFileAsMovableAreaで作成した壁データと、キャラクターのあたり判定を行います。
%group
Easy3D For HSP3 : 当たり判定

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15
p1 : [IN] 変数または、数値　：　befposx
p2 : [IN] 変数または、数値　：　befposy
p3 : [IN] 変数または、数値　：　befposz
p4 : [IN] 変数または、数値　：　newposx
p5 : [IN] 変数または、数値　：　newposy
p6 : [IN] 変数または、数値　：　newposz
p7 : [IN] 変数または、数値　：　groundhsid
p8 : [IN] 変数または、数値　：　dist
p9 : [OUT] 変数　：　result
p10 : [OUT] 変数　：　adjustx
p11 : [OUT] 変数　：　adjusty
p12 : [OUT] 変数　：　adjustz
p13 : [OUT] 変数　：　nx
p14 : [OUT] 変数　：　ny
p15 : [OUT] 変数　：　nz

%inst
E3DSetMovableArea, または、E3DLoadMQOFileAsMovableAreaで作成した壁データと、キャラクターのあたり判定を行います。

befposで指定した座標と、
newposで指定した座標を結ぶ線分と、
壁の各ポリゴンとのあたり判定をします。

壁に沿って位置を移動するために
使用します。

壁の外側から内側へは移動できますが、内側から外側へは移動できないようにします。





→引数
1. [IN] 変数または、数値　：　befposx
2. [IN] 変数または、数値　：　befposy
3. [IN] 変数または、数値　：　befposz
　　線分の始点を（befposx, befposy, befposz）で
　　指定します。
　　実数。

4. [IN] 変数または、数値　：　newposx
5. [IN] 変数または、数値　：　newposy
6. [IN] 変数または、数値　：　newposz
　　線分の終点を（newposx, newposy, newposz）で
　　指定します。
　　実数。

7. [IN] 変数または、数値　：　groundhsid
　　E3DSetMovableArea、
　　または、E3DLoadMQOFileAsMovableAreaで
　　作成した形状データを
　　識別するid

8. [IN] 変数または、数値　：　dist
　　壁からの距離の最小値。
　　distに大きな値を入れると、
　　ぶつかった際に大きく、跳ね返るようになります。
　　実数。

9. [OUT] 変数　：　result
　　あたり判定の結果が代入されます。
　　壁とぶつかった場合は、１が、
　　ぶつからなかった場合は、０が、代入されます。

10. [OUT] 変数　：　adjustx
11. [OUT] 変数　：　adjusty
12. [OUT] 変数　：　adjustz
　　result != 0 のときに、
　　修正後の座標が、
　　(adjustx, adjusty, adjustz)に代入されます。
　　実数型の変数。


13. [OUT] 変数　：　nx
14. [OUT] 変数　：　ny
15. [OUT] 変数　：　nz
　　result != 0 のときに、
　　ぶつかった面の法線ベクトルの値が、
　　代入されます。
　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DVec3Normalize
指定したベクトルを、正規化た値を取得します。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 変数または、数値　：　vecx
p2 : [IN] 変数または、数値　：　vecy
p3 : [IN] 変数または、数値　：　vecz
p4 : [OUT] 変数　：　newvecx
p5 : [OUT] 変数　：　newvecy 
p6 : [OUT] 変数　：　newvecz

%inst
指定したベクトルを、正規化た値を取得します。

つまり、指定したベクトルの向きを持つ、
大きさ１のベクトルが、取得できます。




→引数
1. [IN] 変数または、数値　：　vecx
2. [IN] 変数または、数値　：　vecy
3. [IN] 変数または、数値　：　vecz
　　ベクトルを、(vecx, vecy, vecz)で指定します。
　　実数。

4. [OUT] 変数　：　newvecx
5. [OUT] 変数　：　newvecy 
6. [OUT] 変数　：　newvecz
　　向きが(vecx, vecy, vecz)で、
　　大きさが1な、ベクトルを、
　　(newvecx, newvecy, newvecz)に代入します。
　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DVec2CCW
vec2 がvec1 に対して、反時計回りの時、
resultに、１を代入し、
時計回りの時、
resultに、-1を代入する。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2,p3,p4,p5
p1 : [IN] 変数または、数値　：　vecx1
p2 : [IN] 変数または、数値　：　vecy1
p3 : [IN] 変数または、数値　：　vecx2
p4 : [IN] 変数または、数値　：　vecy2
p5 : [OUT] 変数　：　result

%inst
vec2 がvec1 に対して、反時計回りの時、
resultに、１を代入し、
時計回りの時、
resultに、-1を代入する。



→引数
1. [IN] 変数または、数値　：　vecx1
2. [IN] 変数または、数値　：　vecy1
　　vec1( vecx1, vecy1 )を指定する。
　　実数。

3. [IN] 変数または、数値　：　vecx2
4. [IN] 変数または、数値　：　vecy2
　　vec2( vecx2, vecy2 )を指定する。
　　実数。

5. [OUT] 変数　：　result
　　vec2 がvec1 に対して、反時計回りの時、
　　resultに、１を代入し、
　　時計回りの時、
　　resultに、-1を代入する。



バージョン : ver1.0.0.1

%index
E3DVec3RotateY
ベクトルbefvecを、Ｙ軸に関して、degy 度だけ回転したベクトルnewvec を取得します。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 変数または、数値　：　befvecx
p2 : [IN] 変数または、数値　：　befvecy
p3 : [IN] 変数または、数値　：　befvecz
p4 : [IN] 変数または、数値　：　degy
p5 : [OUT] 変数　：　newvecx
p6 : [OUT] 変数　：　newvecy 
p7 : [OUT] 変数　：　newvecz

%inst
ベクトルbefvecを、Ｙ軸に関して、degy 度だけ回転したベクトルnewvec を取得します。




→引数
1. [IN] 変数または、数値　：　befvecx
2. [IN] 変数または、数値　：　befvecy
3. [IN] 変数または、数値　：　befvecz
　　回転したいベクトルを、
　　(befvecx, befvecy, befvecz)で指定します。
　　実数。

4. [IN] 変数または、数値　：　degy
　　回転角度を指定します。
　　degy の角度だけ回転します。
　　実数。　　

5. [OUT] 変数　：　newvecx
6. [OUT] 変数　：　newvecy 
7. [OUT] 変数　：　newvecz
　　回転後のベクトルが、
　　（newvecx, newvecy, newvecz）に代入されます。
　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DLoadMQOFileAsMovableArea
メタセコイアの、ＭＱＯファイルで作成した壁のデータを、移動可能領域情報として、読み込みます。
%group
Easy3D For HSP3 : 壁

%prm
p1,p2,p3
p1 : [IN] 文字列または、文字列変数　：　filename
p2 : [IN] 変数または、数値　：　mult
p3 : [OUT] 変数　：　hsid

%inst
メタセコイアの、ＭＱＯファイルで作成した壁のデータを、移動可能領域情報として、読み込みます。

メタセコイアで、データを作る場合には、次の２点に気を付けてください。

１．壁データは、常に、移動可能領域の内側を向くように、面の向きを設定してください。両面ポリゴンは、不可です。

２．壁データは、少しの隙間もないように、
作成してください。


自動的に壁データを作りたい場合は、
メタセコイアのプラグイン、MakeWallをご使用ください。
（おちゃっこＬＡＢのトップページにリンクがあります。）





→引数
1. [IN] 文字列または、文字列変数　：　filename
　　読み込む、mqo ファイル名。

2. [IN] 変数または、数値　：　mult
　　形状データの座標に掛ける係数の数値。
　　座標値　＊　mult で計算されます。
　　等倍は１．０
　　実数。

3. [OUT] 変数　：　hsid
　　作成した壁データを識別するhsidが代入されます。



バージョン : ver1.0.0.1

%index
E3DLoadSound
音のデータを読み込み、音を識別する番号、soundid、を取得します。
%group
Easy3D For HSP3 : サウンド

%prm
p1,p2,p3,p4
p1 : [IN] 文字列または、文字列変数　：　filename
p2 : [OUT] 変数　：　soundid
p3 : [IN] 変数または、数値　：　use3dflag
p4 : [IN] 変数または、数値　：　bufnum

%inst
音のデータを読み込み、音を識別する番号、soundid、を取得します。

ver1.0.5.0から３Ｄサウンドに対応できるように
なりました。
use3dflagに１を指定すると、
３Ｄサウンドとしてロードします。


読み込める音データの種類は、
*.wav, *.mid, *.sgt ファイルです。
html{
<strong>３Ｄサウンドは、wavファイルのモノラル形式のみ</strong>
}htmlです。


３Ｄサウンドの設定については、
E3DSet3DSoundで始まる関数名を
お調べください。


同じＩＤの、３Ｄサウンドを同時にいくつ
重ねて再生できるかはbufnum引数で指定します。

実際の使用例は、zip中の、
html{
<strong>e3dhsp3_sound.hsp</strong>
}html
をご覧ください。

３Ｄサウンドの使用例は、
html{
<strong>e3dhsp3_3Dsound.hsp</strong>
}html
をご覧ください。



→引数
1. [IN] 文字列または、文字列変数　：　filename
　　読み込む、サウンド ファイル名。

2. [OUT] 変数　：　soundid
　　作成した音データを識別する番号が代入されます。

3. [IN] 変数または、数値　：　use3dflag
　　ファイルをステレオサウンドとして読み込む場合は０を、
　　３Ｄサウンドとして読み込む場合は１を指定してください。
　　指定しなかった場合は、ステレオサウンドと見なされます。

4. [IN] 変数または、数値　：　bufnum
　　同じＩＤの、３Ｄサウンドを、同時にいくつ重ねて再生できるかを
　　指定します。

　　３Ｄサウンドではない場合は、
　　今まで通り、DirectMusicが、自動的に、
　　重ねて再生してくれます。


バージョン : ver1.0.0.1

%index
E3DPlaySound
E3DLoadSoundで、読み込んだ、音データを再生します。
%group
Easy3D For HSP3 : サウンド

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　soundid
p2 : [IN] 変数または、数値　：　isprimary
p3 : [IN] 変数または、数値　：　boundaryflag

%inst
E3DLoadSoundで、読み込んだ、音データを再生します。

isprimary 引数には、
ＢＧＭ再生時に、１を、
効果音再生時に０を指定してください。


boundaryflagには、再生境界を指定します。
e3dhsp3.as内で定義している、
DMUS_SEGF_　で始まる定数を指定してください。

それぞれの意味は、以下の通りです。

DMUS_SEGF_BEAT
　　拍の境界で演奏する。

DMUS_SEGF_DEFAULT
　　セグメントのデフォルトの境界を使用する。

DMUS_SEGF_GRID
　　グリッド(拍の小分割)境界で演奏する。

DMUS_SEGF_MEASURE
　　小節境界で演奏する。

DMUS_SEGF_QUEUE
　　プライマリ セグメント キューの最後に置く。
　　プライマリ セグメントに対してのみ
　　有効である。 

DMUS_SEGF_SEGMENTEND
　　開始タイムで演奏中のプライマリ セグメント
　　の最後で演奏する。
　　現在演奏中のプライマリ セグメント後に
　　既に挿入されているセグメントは、
　　フラッシュ (解放) される。


３Ｄサウンドの再生時には、
isprimary, boundaryflagを指定しても反映されません。




→引数
1. [IN] 変数または、数値　：　soundid
　　再生したい音を識別する番号を、指定します。

2. [IN] 変数または、数値　：　isprimary
　　isprimaryに１を指定すると、
　　プライマリセグメントとして再生されます。
　　プライマリセグメントは、一度に、一つだけ、
　　再生できます。

　　isprimaryに０を指定すると、
　　セカンダリセグメントとして、再生されます。
　　プライマリセグメントに、重ねて、再生されます。

　　ＢＧＭを再生するときには、
　　isprimaryを１に、
　　効果音を再生するときには、
　　isprimaryを０に、
　　指定すると、うまくいきます。

3. [IN] 変数または、数値　：　boundaryflag
　　右の説明をお読みください。


バージョン : ver1.0.0.1

%index
E3DStopSound
音の再生を停止します。
%group
Easy3D For HSP3 : サウンド

%prm
p1,p2
p1 : [IN] 変数または、数値　：　soundid
p2 : [IN] 変数または、数値　：　flag

%inst
音の再生を停止します。




→引数
1. [IN] 変数または、数値　：　soundid
　　停止したい音を識別する番号を、指定します。


2. [IN] 変数または、数値　：　flag

　　３Ｄサウンドの停止状態を指定します。

　　flagに０を指定すると、E3DStopSoundした後に、
　　E3DPlaySoundした場合、停止した続きの場所から
　　再生されます。

　　flagに１を指定すると、次にE3DPlaySoundした場合、
　　最初から再生されます。

　　デフォルトでは、flag 0 を指定したのと同じ状態になっています。

　　３Ｄサウンド以外は、常に、次回のE3DPlaySound時に、
　　最初から再生されます。



バージョン : ver1.0.0.1

%index
E3DSetSoundLoop
音を繰り返し再生するかどうかを、指定します。
%group
Easy3D For HSP3 : サウンド

%prm
p1,p2
p1 : [IN] 変数または、数値　：　soundid
p2 : [IN] 変数または、数値　：　loopflag

%inst
音を繰り返し再生するかどうかを、指定します。
デフォルトでは、
繰り返さない状態になっています。




→引数
1. [IN] 変数または、数値　：　soundid
　　ループ設定したい音を識別する番号を、指定します。

2. [IN] 変数または、数値　：　loopflag
　　loopflag に１を指定すると、
　　音を、無限回、再生するようになります。
　　loopflagに０を指定すると、
　　一回のみ、音を再生するようになります。



バージョン : ver1.0.0.1

%index
E3DSetSoundVolume
音の音量を設定します。
%group
Easy3D For HSP3 : サウンド

%prm
p1,p2
p1 : [IN] 変数または、数値　：　volume
p2 : [IN] 変数または、数値　：　soundid

%inst
音の音量を設定します。

３Ｄサウンドは、
音ごとに音量の設定が出来ます。
その代わり、音の増幅は出来ません。
３Ｄサウンドは、音量の設定をしても、
次のE3DPlaySound時まで、反映されません。


ステレオサウンドは、
個々に音量の設定をすることはできません。





→引数
1. [IN] 変数または、数値　：　volume
　　音量を指定します。
　　0 から -10000 の値を指定してください。

　　-10000 は、-100dB に相当します。

2. [IN] 変数または、数値　：　soundid
　　設定したい音を識別する番号を指定します。
　　-1を指定すると、全ての音の音量を設定できます。
　　何も設定しなかった場合は、-1と見なされます。



バージョン : ver1.0.0.1

%index
E3DSetSoundTempo
音のテンポを設定します。
%group
Easy3D For HSP3 : サウンド

%prm
p1
p1 : [IN] 変数または、数値　：　tempo

%inst
音のテンポを設定します。
E3DPlaySoundで、再生している、
全ての音に、影響します。
（音ごとに設定することは、出来ません）

音を早く再生したり、遅く再生したり、出来るようになります。

３Ｄサウンドには、反映されません。




→引数
1. [IN] 変数または、数値　：　tempo
　　テンポを指定します。

　　tempo には、0.01 から 100.0 の値を
　　指定してください。

　　0.01を指定した場合は、
　　0.01 倍のテンポ、
　　つまり、おそーく、再生されます。

　　100.0を指定した場合は、
　　100 倍のテンポ、
　　つまり、すごく早く再生されます。

　　1.0を指定した場合は、
　　1 倍のテンポ、
　　つまり、通常の、速さで、再生されます。



バージョン : ver1.0.0.1

%index
E3DDestroySound
読み込んだ音データを破棄します。
%group
Easy3D For HSP3 : サウンド

%prm
p1
p1 : [IN] 変数または、数値　：　soundid

%inst
読み込んだ音データを破棄します。
破棄した音は、その後、操作することは出来ません。
ただ、再生を終了させる場合は、E3DStopSound関数を使用してくださ



→引数
1. [IN] 変数または、数値　：　soundid
　　破棄したい音を識別する番号



バージョン : ver1.0.0.1

%index
E3DSetSoundFrequency
音の周波数を設定します。
%group
Easy3D For HSP3 : サウンド

%prm
p1,p2
p1 : [IN] 変数または、数値　：　soundid
p2 : [IN] 変数または、数値　：　freq

%inst
音の周波数を設定します。

３Ｄサウンドに周波数を設定しても、
次回のE3DPlaySound時まで、反映されません。


html{
<strong>ステレオサウンドでリバーブが有効になっている場合は、
この関数は失敗します。</strong>
}html
リバーブを無効にするには、E3DInitの８番目の引数に０を
指定してください。





→引数
1. [IN] 変数または、数値　：　soundid
　　設定したい音を識別する番号

2. [IN] 変数または、数値　：　freq
　　周波数を指定します。



バージョン : ver1.0.0.1

%index
E3DGetSoundVolume
現在の音量を取得します。
%group
Easy3D For HSP3 : サウンド

%prm
p1,p2
p1 : [IN] 変数または、数値　：　soundid
p2 : [OUT] 変数　：　vol

%inst
現在の音量を取得します。


→引数
1. [IN] 変数または、数値　：　soundid
　　音を識別する番号

2. [OUT] 変数　：　vol
　　音量が代入されます。



バージョン : ver1.0.0.1

%index
E3DGetSoundFrequency
現在の周波数を取得します。
%group
Easy3D For HSP3 : サウンド

%prm
p1,p2
p1 : [IN] 変数または、数値　：　soundid
p2 : [OUT] 変数　：　freq

%inst
現在の周波数を取得します。


→引数
1. [IN] 変数または、数値　：　soundid
　　音を識別する番号

2. [OUT] 変数　：　freq
　　周波数が代入されます。



バージョン : ver1.0.0.1

%index
E3DSet3DSoundListener
３Dサウンド再生時に関係するリスナー（聞き手）の
パラメータを設定します。
%group
Easy3D For HSP3 : サウンド

%prm
p1,p2
p1 : [IN] 変数または、数値　：　doppler
p2 : [IN] 変数または、数値　：　rolloff

%inst
３Dサウンド再生時に関係するリスナー（聞き手）の
パラメータを設定します。
ここで設定したパラメータは、３Dサウンド全体に影響します。


ここで設定する係数は、
DirectXのドキュメントに詳しく書いてあります。
お持ちの方は、

[DirectX9ドキュメント]-&gt;　　
　　[DirectSound]-&gt;
　　[DirectSoundの使い方]-&gt;
　　[3Dサウンド]-&gt;
　　[DirectSound の3D リスナー]-&gt;
　　[ドップラー効果]

[DirectX9ドキュメント]-&gt;　　
　　[DirectSound]-&gt;
　　[DirectSoundの使い方]-&gt;
　　[3Dサウンド]-&gt;
　　[DirectSound の3D リスナー]-&gt;
　　[ロールオフ係数]

をお読みください。


３Ｄサウンドの使用例は、
html{
<strong>e3dhsp3_3Dsound.hsp</strong>
}html
をご覧ください。




→引数
1. [IN] 変数または、数値　：　doppler
　　ドップラー係数を指定してください。
　　0.0から10.0の値が有効です。

　　0.0を指定すると、ドップラー効果なし。
　　2.0を指定すると、実世界の２倍のドップラー効果が得られます。
　　実数。

2. [IN] 変数または、数値　：　rolloff
　　ロールオフ係数を指定してください。
　　リスナーと音の距離による減衰の具合を操作できます。
　　0.0から10.0の値が有効です。

　　0.0を指定すると、減衰なし。
　　2.0を指定すると、実世界の２倍の減衰効果が得られます。
　　実数。



バージョン : ver1.0.0.1

%index
E3DSet3DSoundListenerMovement
リスナーの位置と向きを設定します。
%group
Easy3D For HSP3 : サウンド

%prm
p1
p1 : [IN] 変数または、数値　：　hsid

%inst
リスナーの位置と向きを設定します。

hsidにモデルデータの番号を渡した場合には、
そのモデルデータの位置と向きが、
リスナーの位置と向きとして設定されます。

hsidに-1を渡した場合には、
視点の位置と向きが、
リスナーの位置と向きとして設定されます。

一回呼び出せば、ずっと、hsidの更新情報を
リスナーに反映させるわけではhtml{
<strong>ありません</strong>
}html。

情報の更新が必要になるたびに、
呼び出してください。






→引数
1. [IN] 変数または、数値　：　hsid
　　モデルデータを識別する番号
　　-1のときは、視点をリスナーとします。


バージョン : ver1.0.0.1

%index
E3DSet3DSoundDistance
３Dサウンドの最小距離と最大距離を設定します。
%group
Easy3D For HSP3 : サウンド

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　soundid
p2 : [IN] 変数または、数値　：　min
p3 : [IN] 変数または、数値　：　max

%inst
３Dサウンドの最小距離と最大距離を設定します。

html{
<strong>E3DLoadSoundのuse3dflagに１を指定して
読み込んだサウンドのみに対し、有効です。
</strong>
}html

ここで設定する係数は、
DirectXのドキュメントに詳しく書いてあります。
お持ちの方は、

[DirectX9ドキュメント]-&gt;
　　[DirectSound]-&gt;
　　[DirectSoundの使い方]-&gt;
　　[3Dサウンド]-&gt;
　　[DirectSound 3D のバッファ]-&gt;
　　[最小距離と最大距離]

をお読みください。


３Ｄサウンドの使用例は、
html{
<strong>e3dhsp3_3Dsound.hsp</strong>
}html
をご覧ください。



→引数
1. [IN] 変数または、数値　：　soundid
　　３Ｄサウンドを識別する番号

2. [IN] 変数または、数値　：　min
3. [IN] 変数または、数値　：　max
　　最小距離と最大距離を指定します。
　　実数。

　　以下は、DirectXのドキュメントからの引用です。
　　リスナーが音源に近づくにつれてサウンドが大きくなり、
　　距離が半分になったときに音のボリュームは倍増する。
　　しかし、特定の点を過ぎると、ボリュームが増加し続けるのは
　　合理的ではない。これが音源の最小距離である。

　　音源の最大距離とは、
　　それ以上離れても音がより小さくならない距離を意味する。



バージョン : ver1.0.0.1

%index
E3DSet3DSoundMovement

３Dサウンドの位置と速度を設定します。
%group
Easy3D For HSP3 : サウンド

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 変数または、数値　：　soundid
p2 : [IN] 変数または、数値　：　posx
p3 : [IN] 変数または、数値　：　posy
p4 : [IN] 変数または、数値　：　posz
p5 : [IN] 変数または、数値　：　vx
p6 : [IN] 変数または、数値　：　vy
p7 : [IN] 変数または、数値　：　vz

%inst

３Dサウンドの位置と速度を設定します。

html{
<strong>E3DLoadSoundのuse3dflagに１を指定して
読み込んだサウンドのみに対し、有効です。
</strong>
}html

３Ｄサウンドの使用例は、
html{
<strong>e3dhsp3_3Dsound.hsp</strong>
}html
をご覧ください。




→引数
1. [IN] 変数または、数値　：　soundid
　　３Ｄサウンドを識別する番号

2. [IN] 変数または、数値　：　posx
3. [IN] 変数または、数値　：　posy
4. [IN] 変数または、数値　：　posz
　　３Ｄサウンドの位置を（posx, posy, posz）で指定します。
　　実数。

5. [IN] 変数または、数値　：　vx
6. [IN] 変数または、数値　：　vy
7. [IN] 変数または、数値　：　vz
　　３Ｄサウンドの速度を(vx, vy, vz)で指定します。
　　実数。



バージョン : ver1.0.0.1

%index
E3DCreateNaviLine
ナビラインを作成します。
%group
Easy3D For HSP3 : ナビライン

%prm
p1
p1 : [OUT] 変数　：　nlid

%inst
ナビラインを作成します。

ナビラインとは、複数のナビポイントからなる、双方向リンクリストのことです。

ナビポイントとは、キャラクターの自動走行時に、位置を決める基準となるポイントのことです。

この関数が成功すると、
ナビラインを識別するためのＩＤ、nlidが得られます。

失敗すると、nlidに負の値が代入されます。




→引数
1. [OUT] 変数　：　nlid
　　作成したナビラインを識別するためのＩＤが
　　代入されます。



バージョン : ver1.0.0.1

%index
E3DDestroyNaviLine
ナビラインを削除します。
%group
Easy3D For HSP3 : ナビライン

%prm
p1
p1 : [IN] 数値または、変数　：　nlid

%inst
ナビラインを削除します。


→引数
1. [IN] 数値または、変数　：　nlid
　　削除するラインを識別するＩＤ



バージョン : ver1.0.0.1

%index
E3DAddNaviPoint
ナビラインに、ナビポイントを追加します。
%group
Easy3D For HSP3 : ナビライン

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　nlid
p2 : [IN] 数値または、変数　：　befnpid
p3 : [OUT] 変数　：　npid

%inst
ナビラインに、ナビポイントを追加します。

成功すると、新しいナビポイントを識別するためのＩＤ、npid が得られます。

befnpidで指定したポイントの次の位置に
追加できる他、
先頭位置や、最後の位置にも追加することができます。


ナビポイントの編集には、
GViewer.exeを使うと便利です。
（おちゃっこＬＡＢでＤＬ可能です。）




→引数
1. [IN] 数値または、変数　：　nlid
　　ラインを識別するＩＤ

2. [IN] 数値または、変数　：　befnpid
　　befnpidで指定したポイントの次の位置に、
　　新しいポイントを追加します。

　　befnpidに-1を指定すると、
　　ナビラインの最後に追加され、
　　befnpidに-2を指定すると、
　　ナビラインの先頭に追加されます。

3. [OUT] 変数　：　npid
　　新しく追加したナビポイントのＩＤが代入されます。



バージョン : ver1.0.0.1

%index
E3DRemoveNaviPoint
ナビラインから、ナビポイントを削除します。
%group
Easy3D For HSP3 : ナビライン

%prm
p1,p2
p1 : [IN] 数値または、変数　：　nlid
p2 : [IN] 数値または、変数　：　npid

%inst
ナビラインから、ナビポイントを削除します。


→引数
1. [IN] 数値または、変数　：　nlid
　　ラインを識別するＩＤ

2. [IN] 数値または、変数　：　npid
　　削除したいナビポイントのID



バージョン : ver1.0.0.1

%index
E3DGetNaviPointPos
ナビポイントの座標を取得します。
%group
Easy3D For HSP3 : ナビライン

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　nlid
p2 : [IN] 数値または、変数　：　npid
p3 : [OUT] 変数　：　posx
p4 : [OUT] 変数　：　posy
p5 : [OUT] 変数　：　posz

%inst
ナビポイントの座標を取得します。


→引数
1. [IN] 数値または、変数　：　nlid
　　ラインを識別するＩＤ

2. [IN] 数値または、変数　：　npid
　　ナビポイントを識別するID

3. [OUT] 変数　：　posx
4. [OUT] 変数　：　posy
5. [OUT] 変数　：　posz
　　ナビポイントの座標が、
　　（posx, posy, posz）に、代入されます。
　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DSetNaviPointPos
ナビポイントの座標をセットします。
%group
Easy3D For HSP3 : ナビライン

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　nlid
p2 : [IN] 数値または、変数　：　npid
p3 : [IN] 数値または、変数　：　posx
p4 : [IN] 数値または、変数　：　poxy
p5 : [IN] 数値または、変数　：　posz

%inst
ナビポイントの座標をセットします。
この座標をもとに、
キャラクターが移動することになります。



→引数
1. [IN] 数値または、変数　：　nlid
　　ラインを識別するＩＤ

2. [IN] 数値または、変数　：　npid
　　ナビポイントを識別するID

3. [IN] 数値または、変数　：　posx
4. [IN] 数値または、変数　：　poxy
5. [IN] 数値または、変数　：　posz
　　ナビポイントの座標を
　　（posx, posy, posz）に設定します。
　　実数。



バージョン : ver1.0.0.1

%index
E3DGetNaviPointOwnerID
ナビポイントのOwnerIDを取得します。
%group
Easy3D For HSP3 : ナビライン

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　nlid
p2 : [IN] 数値または、変数　：　npid
p3 : [OUT] 変数　：　OwnerID

%inst
ナビポイントのOwnerIDを取得します。


→引数
1. [IN] 数値または、変数　：　nlid
　　ラインを識別するＩＤ

2. [IN] 数値または、変数　：　npid
　　ナビポイントを識別するID

3. [OUT] 変数　：　OwnerID
　　ナビポイントのOwnerIDが代入されます。



バージョン : ver1.0.0.1

%index
E3DSetNaviPointOwnerID
ナビポイントのOwnerIDをセットします。
%group
Easy3D For HSP3 : ナビライン

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　nlid
p2 : [IN] 数値または、変数　：　npid
p3 : [IN] 変数　：　OwnerID

%inst
ナビポイントのOwnerIDをセットします。

ナビポイントに、
排他的な、所有権を設定したいときなどに、
自由に、使用してください。




→引数
1. [IN] 数値または、変数　：　nlid
　　ラインを識別するＩＤ

2. [IN] 数値または、変数　：　npid
　　ナビポイントを識別するID

3. [IN] 変数　：　OwnerID
　　ナビポイントのOwnerIDに設定します。



バージョン : ver1.0.0.1

%index
E3DGetNextNaviPoint
npidで指定したナビポイントの、一つ後のナビポイントのＩＤを取得します。
%group
Easy3D For HSP3 : ナビライン

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　nlid
p2 : [IN] 数値または、変数　：　npid
p3 : [OUT] 変数　：　nextid

%inst
npidで指定したナビポイントの、一つ後のナビポイントのＩＤを取得します。

ナビラインは、ナビポイントを、双方向リストで、格納しています。


一つ後のナビポイントが存在しない場合は、nextid には、負の値が代入されます。




→引数
1. [IN] 数値または、変数　：　nlid
　　ラインを識別するＩＤ

2. [IN] 数値または、変数　：　npid
　　ナビポイントを識別するID

3. [OUT] 変数　：　nextid
　　一つ後のナビポイントのＩＤが代入されます。

　　npid に-1が指定されている場合は、
　　nextidには、先頭のナビポイントのIDが代入されます
　　


バージョン : ver1.0.0.1

%index
E3DGetPrevNaviPoint
npidで指定したナビポイントの、一つ前のナビポイントのＩＤを取得します。
%group
Easy3D For HSP3 : ナビライン

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　nlid
p2 : [IN] 数値または、変数　：　npid
p3 : [OUT] 変数　：　previd

%inst
npidで指定したナビポイントの、一つ前のナビポイントのＩＤを取得します。


ナビラインは、ナビポイントを、双方向リストで、格納しています。


一つ前のナビポイントが存在しない場合は、previd には、負の値が代入されます。




→引数
1. [IN] 数値または、変数　：　nlid
　　ラインを識別するＩＤ

2. [IN] 数値または、変数　：　npid
　　ナビポイントを識別するID

3. [OUT] 変数　：　previd
　　一つ後のナビポイントのＩＤが代入されます。



バージョン : ver1.0.0.1

%index
E3DGetNearestNaviPoint
指定した座標に、一番近いナビポイントのＩＤを取得します。
%group
Easy3D For HSP3 : ナビライン

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 数値または、変数　：　nlid
p2 : [IN] 数値または、変数　：　posx
p3 : [IN] 数値または、変数　：　posy 
p4 : [IN] 数値または、変数　：　posz
p5 : [OUT] 変数　：　nearid
p6 : [OUT] 変数　：　previd
p7 : [OUT] 変数　：　nextid

%inst
指定した座標に、一番近いナビポイントのＩＤを取得します。

一番近いナビポイントの前後のポイントの
ＩＤも取得できます。




→引数
1. [IN] 数値または、変数　：　nlid
　　ラインを識別するＩＤ

2. [IN] 数値または、変数　：　posx
3. [IN] 数値または、変数　：　posy 
4. [IN] 数値または、変数　：　posz
　　（posx, posy, posz）に一番近いナビポイントを
　　探します。
　　実数。

5. [OUT] 変数　：　nearid
　　一番近いナビポイントのＩＤが代入されます。

6. [OUT] 変数　：　previd
　　一番近いナビポイントの前のポイントのＩＤが
　　代入されます。

7. [OUT] 変数　：　nextid
　　一番近いナビポイントの次のポイントのＩＤが
　　代入されます。


バージョン : ver1.0.0.1

%index
E3DFillUpNaviLine
ナビポイントとナビポイントの間を、指定した分割数で、補間します。
%group
Easy3D For HSP3 : ナビライン

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　nlid
p2 : [IN] 数値または、変数　：　div
p3 : [IN] 数値または、変数　：　flag

%inst
ナビポイントとナビポイントの間を、指定した分割数で、補間します。

Catmull-Romの公式で、補間します。




→引数
1. [IN] 数値または、変数　：　nlid
　　ラインを識別するＩＤ

2. [IN] 数値または、変数　：　div
　　何分割して補間するかを指定します。

3. [IN] 数値または、変数　：　flag
　　flagに１を指定すると、
　　チェインの順番にナビポイントのＩＤをふり直します。



バージョン : ver1.0.0.1

%index
E3DSetNaviLineOnGround
ナビライン中の全てのナビポイントの座標を、地面の高さに設定します。
%group
Easy3D For HSP3 : ナビライン

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　nlid
p2 : [IN] 数値または、変数　：　grounhdis
p3 : [IN] 数値または、変数　：　mapmaxy
p4 : [IN] 数値または、変数　：　mapminy

%inst
ナビライン中の全てのナビポイントの座標を、地面の高さに設定します。




→引数
1. [IN] 数値または、変数　：　nlid
　　ラインを識別するＩＤ

2. [IN] 数値または、変数　：　grounhdis
　　地面を識別するhsid

3. [IN] 数値または、変数　：　mapmaxy
　　地面データのＹ座標の最大値を指定します。
　　実数。

4. [IN] 数値または、変数　：　mapminy
　　地面データのＹ座標の最小値を指定します。
　　実際の最小値より、少し小さな値を入れてください。
　　実数。



バージョン : ver1.0.0.1

%index
E3DControlByNaviLine
ナビラインのデータを元に、キャラクターの位置と、向きを、自動的に設定するための関数です。
%group
Easy3D For HSP3 : ナビライン

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　nlid
p3 : [IN] 数値または、変数　：　ctrlmode
p4 : [IN] 数値または、変数　：　roundflag
p5 : [IN] 数値または、変数　：　reverseflag
p6 : [IN] 数値または、変数　：　maxdist
p7 : [IN] 数値または、変数　：　posstep
p8 : [IN] 数値または、変数　：　dirstep
p9 : [OUT] 変数　：　newposx
p10 : [OUT] 変数　：　newposy
p11 : [OUT] 変数　：　newposz
p12 : [OUT] 変数　：　newqx
p13 : [OUT] 変数　：　newqy
p14 : [OUT] 変数　：　newqz
p15 : [OUT] 変数　：　newqw
p16 : [IN] [OUT] 変数　：　targetpointid

%inst
ナビラインのデータを元に、キャラクターの位置と、向きを、自動的に設定するための関数です。

引数の、モードなどのパラメータを、
色々変化させることで、
一つのナビラインから、複数の（数え切れないくらいの）走行パターンを得ることが、
可能です。



具体的な使用例は、zip中の、
html{
<strong>e3dhsp3_autorun.hsp</strong>
}html
をご覧ください。



→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　nlid
　　ラインを識別するＩＤ

3. [IN] 数値または、変数　：　ctrlmode
　　ビットの和で、モードを指定します。

　　ビット１が立っていた場合には、
　　　位置を優先した制御が行われます。
　　　引数maxdist, dirstep は無視されます。
　　　出来るだけ、ナビポイントの近くを通るように
　　　なります。

　　ビット１が立っていない場合には、
　　　向きを優先した制御が行われます。
　　　dirstepで指定した角度より大きな角度では、
　　　移動できなくなります。
　　　ただし、そのままだと、キャラクターが、
　　　ナビラインから、遠くに離れすぎてしまうので、
　　　引数maxdistで、ナビラインからどのくらい離れても
　　　良いかを指定します。
　　　maxdistよりも、遠くに離れた場合には、
　　　dirstepで指定したよりも、大きな角度で、
　　　ナビラインに近づくように修正されます。
　　　
　　　なので、dirstepに小さな値を指定すると、
　　　ジグザグにナビラインをたどるようになります。

　　ビット４が立っていた場合には、
　　　向きの設定は、ＸＺ平面のみで行われます。

　　例えば、ctrlmode に５を指定した場合は、
　　位置を優先した制御で、ＸＺ平面での向き設定をする
　　ということになります。

4. [IN] 数値または、変数　：　roundflag
　　ナビラインの最後のナビポイントに移動した後、
　　ナビラインの最初のナビポイントの位置を
　　目指すかどうかを示します。

　　１を指定すると、円形のナビラインの場合は、
　　ずっと、ぐるぐる回ることになります。

5. [IN] 数値または、変数　：　reverseflag
　　１を指定すると、
　　ナビラインのポイントを逆順にたどるようになります。

6. [IN] 数値または、変数　：　maxdist
　　ナビラインから、どのくらいまで離れても良いかを
　　指定します。
　　ctrlmodeのビット１が立っていない場合のみ有効です。
　　実数。

7. [IN] 数値または、変数　：　posstep
　　キャラクターを一度にどれくらいの距離を移動させるかを
　　指定します。
　　ただし、ナビポイント付近では、
　　posstepより小さな距離しか移動させないことがあります。
　　実数。

8. [IN] 数値または、変数　：　dirstep
　　一度の移動で、最大何度まで回転できるかを
　　指定します。
　　回転角度の値を渡してください。
　　実数。

9. [OUT] 変数　：　newposx
10. [OUT] 変数　：　newposy
11. [OUT] 変数　：　newposz
　　移動後の座標が（newposx, newposy, newposz）に
　　代入されます。
　　実数。

12. [OUT] 変数　：　newqx
13. [OUT] 変数　：　newqy
14. [OUT] 変数　：　newqz
15. [OUT] 変数　：　newqw
　　移動後の姿勢を表すクォータニオンの値が、
（newqx, newqy, newqz, newqw ）
　　に代入されます。
　　実数。

16. [IN] [OUT] 変数　：　targetpointid
　　現在目指しているナビポイントのＩＤを入れます。
　　移動後は、次に目指すべきナビポイントのＩＤが
　　代入されます。

　　ですので、一番最初の呼び出し時のみ、
　　自分でtargetpoinidを指定すれば、
　　あとは、同じ変数を渡すだけで、
　　自動的に、目指すべきポイントのＩＤが
　　代入されていくことになります。

　　targetpointidに、
　　存在しないナビポイントのＩＤを入れた場合は、
　　（例えば-1など）
　　自動的に、目指すべきナビポイントを決定します。
　　ですが、この場合、
　　向きを重視したモードのときに、
　　動きがぎこちなくなることがあるので、
　　なるべく、-1などは、使わない方が良いです。
　　




バージョン : 

%index
E3DSetDirQ
姿勢をクォータニオンで指定して、設定します。
%group
Easy3D For HSP3 : モデル向き

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　qx
p3 : [IN] 数値または、変数　：　qy
p4 : [IN] 数値または、変数　：　qz
p5 : [IN] 数値または、変数　：　qw

%inst
姿勢をクォータニオンで指定して、設定します。

E3DControlByNaviLineや、E3DGetDirQ
で得た姿勢データを
設定するときに、使用してください。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　qx
3. [IN] 数値または、変数　：　qy
4. [IN] 数値または、変数　：　qz
5. [IN] 数値または、変数　：　qw
　　姿勢を表すクォータニオンの値を
　　指定してください。
　　実数。
　　


バージョン : ver1.0.0.1

%index
E3DGetDirQ
姿勢をクォータニオンの形式で、取得します。
%group
Easy3D For HSP3 : モデル向き

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　hsid
p2 : [OUT] 変数　：　qx
p3 : [OUT] 変数　：　qy
p4 : [OUT] 変数　：　qz
p5 : [OUT] 変数　：　qw

%inst
姿勢をクォータニオンの形式で、取得します。


→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [OUT] 変数　：　qx
3. [OUT] 変数　：　qy
4. [OUT] 変数　：　qz
5. [OUT] 変数　：　qw
　　姿勢を表すクォータニオンの値が
　　代入されます。
　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DSetWallOnGround
壁データを地面の高さに配置します。
%group
Easy3D For HSP3 : 壁

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　whsid
p2 : [IN] 数値または、変数　：　ghsid
p3 : [IN] 数値または、変数　：　mapmaxy
p4 : [IN] 数値または、変数　：　mapminy
p5 : [IN] 数値または、変数　：　wheight

%inst
壁データを地面の高さに配置します。


→引数
1. [IN] 数値または、変数　：　whsid
　　壁の形状データを識別するＩＤ

2. [IN] 数値または、変数　：　ghsid
　　地面の形状データを識別するＩＤ

3. [IN] 数値または、変数　：　mapmaxy
　 地面データの最大の高さ
　　実数。

4. [IN] 数値または、変数　：　mapminy
　　地面データの最低の高さ
　　実数。

5. [IN] 数値または、変数　：　wheight
　　壁の高さ。
　　実数。





バージョン : ver1.0.0.1

%index
E3DCreateNaviPointClearFlag
キャラクターが、nlidで識別されるナビライン上の点を、どれだけ進んだかということを、格納するためのデータを作成します。
%group
Easy3D For HSP3 : ナビライン

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　nlid
p3 : [IN] 数値または、変数　：　roundnum

%inst
キャラクターが、nlidで識別されるナビライン上の点を、どれだけ進んだかということを、格納するためのデータを作成します。

hsidで識別されるモデルのデータとして
作成します。


このデータは、レースの順位を決定するときなどに、役に立ちます。


この命令は、
E3DInitNaviPointClearFlag,
E3DSetNaviPointClearFlag
E3DGetOrder
の命令を呼び出す前に、呼び出されていないといけません。

複数回、続けて呼び出してはいけません。
作り直したい場合は、必ず、
E3DDestroyNaviPointClearFlag
を呼び出してから、
E3DCreateNaviPointClearFlag
を呼び出してください。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　nlid
　　ナビラインを識別するＩＤ

3. [IN] 数値または、変数　：　roundnum
　　ナビライン上を最大、何周するのかを指定します。



バージョン : ver1.0.0.1

%index
E3DDestroyNaviPointClearFlag
E3DCreateNaviPointClearFlagで作成したデータを破棄します。
%group
Easy3D For HSP3 : ナビライン

%prm
p1
p1 : [IN] 数値または、変数　：　hsid

%inst
E3DCreateNaviPointClearFlagで作成したデータを破棄します。


→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ



バージョン : ver1.0.0.1

%index
E3DInitNaviPointClearFlag
E3DCreateNaviPointClearFlagで作成したデータを初期化します。
%group
Easy3D For HSP3 : ナビライン

%prm
p1
p1 : [IN] 数値または、変数　：　hsid

%inst
E3DCreateNaviPointClearFlagで作成したデータを初期化します。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ



バージョン : ver1.0.0.1

%index
E3DSetNaviPointClearFlag
E3DCreateNaviPointClearFlagで作成したデータに、現在どれだけのナビポイントを通過したかを、セットします。
%group
Easy3D For HSP3 : ナビライン

%prm
p1,p2,p3,p4,p5,p6,p7,p8
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　posx
p3 : [IN] 数値または、変数　：　posy
p4 : [IN] 数値または、変数　：　posz
p5 : [IN] 数値または、変数　：　maxdist
p6 : [OUT] 変数　：　npidptr
p7 : [OUT] 変数　：　roundptr
p8 : [OUT] 変数　：　distptr

%inst
E3DCreateNaviPointClearFlagで作成したデータに、現在どれだけのナビポイントを通過したかを、セットします。

キャラクターとナビポイントとの距離を元に、
データをセットします。

この関数を使う場合は、
毎フレーム、この関数を呼び出す必要があります。

この関数でセットしたデータを元に、
E3DGetOrderが順位を決定します。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　posx
3. [IN] 数値または、変数　：　posy
4. [IN] 数値または、変数　：　posz
　　キャラクターの位置を(posx, posy, posz)で指定します。
　　実数。

5. [IN] 数値または、変数　：　maxdist
　　ナビポイントとの距離がmaxdistより近かった場合、
　　そのポイントをクリアー（通過）したと見なします。
　　実数。

6. [OUT] 変数　：　npidptr
　　現在クリアーしているポイントの内、
　　一番前方のポイントのＩＤが代入されます。

7. [OUT] 変数　：　roundptr
　　キャラクターが何週目かが、代入されます。

8. [OUT] 変数　：　distptr
　　npidptrに代入された、ＩＤのポイントから、
　　どれだけ距離が離れているかが、代入されます。




バージョン : ver1.0.0.1

%index
E3DGetOrder
E3DSetNaviPointClearFlagでセットされたデータを元に、順位情報を取得するための関数です。
%group
Easy3D For HSP3 : ナビライン

%prm
p1,p2,p3,p4
p1 : [IN] 変数　：　hsidptr
p2 : [IN] 数値または、変数　：　arrayleng
p3 : [OUT] 変数　：　orderptr
p4 : [OUT] 変数　：　clearnoptr

%inst
E3DSetNaviPointClearFlagでセットされたデータを元に、順位情報を取得するための関数です。




→引数
1. [IN] 変数　：　hsidptr
　　順位を調べたい形状データを識別するＩＤの配列を
　　指定します。
　　arraylengの長さの配列でなくてはなりません。

　　例えば、
　　dim hsidptr, arrayleng
　　という命令で、作成したデータを渡してください。

2. [IN] 数値または、変数　：　arrayleng
　　配列の長さを指定します。
　　hsidptr, orderptr, clearnoptrは、
　　全て、arraylengの長さの配列でなくてはなりません。

3. [OUT] 変数　：　orderptr
　　順位順に、hsidが代入されます。
　　orderptr(0) には、1位のhsidの番号が、
　　orderptr(1) には、2位のhsidの番号が代入されます。


4. [OUT] 変数　：　clearnoptr
　　順位順に、クリアーしたポイントの数が代入されます。
　　clearnoptr(0) には、
　　1位のモデルがクリアーしたポイント数が、
　　clearnoptr(1) には、
　　２位のモデルがクリアーしたポイント数が
　　代入されます。



バージョン : ver1.0.0.1

%index
E3DDestroyAllBillboard
全てのビルボードを破棄します。
%group
Easy3D For HSP3 : ビルボード

%prm
なし

%inst
全てのビルボードを破棄します。


→引数
なし

バージョン : ver1.0.0.1

%index
E3DSetValidFlag
RokDeBone2の　”このオブジェクトを無効にする”機能を、プログラムで行えるようにしました。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　flag

%inst
RokDeBone2の　”このオブジェクトを無効にする”機能を、プログラムで行えるようにしました。

無効にしたパーツは、描画やあたり判定の際に、無視されるようになります。

ジョイントに対して、E3DSetValidFlagをした場合は、
E3DJointRemakeを呼び出してください。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ
　　-1を指定すると、ビルボードのフラグを設定できます。

2. [IN] 数値または、変数　：　partno
　　設定したいパーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。

　　hsidに-1を指定した場合は、
　　E3DCreateBillboardで取得した、
　　ビルボードidを渡してください。

　　partnoに-1を渡すと、
　　全てのパーツの有効、無効をセットできます。

3. [IN] 数値または、変数　：　flag
　　flagに０を指定すると、指定パーツが無効になります。
　　flagに１を指定すると、有効になります。



バージョン : ver1.0.0.1

%index
E3DSetDiffuse
パーツのdiffuse色をセットする関数です。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　R
p4 : [IN] 数値または、変数　：　G
p5 : [IN] 数値または、変数　：　B
p6 : [IN] 数値または、変数　：　setflag
p7 : [IN] 数値または、変数　：　vertno

%inst
パーツのdiffuse色をセットする関数です。

指定した色を、
そのまま設定、乗算して設定、加算して設定、
減算して設定の、4種類出来ます。

その時点で、表示されている色に対して、
乗算、加算、減算します。

diffuseだけかえても、Specular, Ambientを変えないと、意図した色にはならないと思いますので、注意してください。
（E3DSetSpecular, E3DSetAmbient, E3DSetEmissive, E3DSetSpecularPowerもご覧ください。）

頂点単位で色の設定が出来ます。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ
　　-1を指定すると、ビルボードの色を設定できます。

2. [IN] 数値または、変数　：　partno
　　設定したいパーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。

　　hsidに-1を指定した場合は、
　　E3DCreateBillboardで取得した、
　　ビルボードidを渡してください。

　　partnoに-1を渡すと、
　　全てのパーツに色をセットできます。

3. [IN] 数値または、変数　：　R
4. [IN] 数値または、変数　：　G
5. [IN] 数値または、変数　：　B
　　指定したい色を（Ｒ，Ｇ，Ｂ）で指定します。
　　０から２５５までの値を指定してください。

　　setflagに乗算を指定した場合は、
　　各成分に、R/255, G/255, B/255を乗算します。

6. [IN] 数値または、変数　：　setflag
　　setflagが０のときは、
　　パーツの色を（Ｒ，Ｇ，Ｂ）にセットします。

　　setflagが１のときは、
　　パーツの色に（R/255, G/255, B/255）を乗算します。

　　setflagが２のときは、
　　パーツの色に（Ｒ，Ｇ，Ｂ）を足し算します。

　　setflagが３のときは、
　　パーツの色から（Ｒ，Ｇ，Ｂ）を減算します。

7. [IN] 数値または、変数　：　vertno
　　指定した頂点番号の色をセットします。
　　この引数を省略、または、-1をセットした場合には、
　　partnoで指定したパーツ全体の色の設定をします。




バージョン : ver1.0.0.1

%index
E3DSetSpecular
パーツのspecular色をセットする関数です。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　R
p4 : [IN] 数値または、変数　：　G
p5 : [IN] 数値または、変数　：　B
p6 : [IN] 数値または、変数　：　setflag
p7 : [IN] 数値または、変数　：　vertno

%inst
パーツのspecular色をセットする関数です。

指定した色を、
そのまま設定、乗算して設定、加算して設定、
減算して設定の、4種類出来ます。

その時点で、表示されている色に対して、
乗算、加算、減算します。


頂点単位で色の設定が出来ます。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ
　　-1を指定すると、ビルボードの色を設定できます。

2. [IN] 数値または、変数　：　partno
　　設定したいパーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。

　　hsidに-1を指定した場合は、
　　E3DCreateBillboardで取得した、
　　ビルボードidを渡してください。

　　partnoに-1を渡すと、
　　全てのパーツに色をセットできます。

3. [IN] 数値または、変数　：　R
4. [IN] 数値または、変数　：　G
5. [IN] 数値または、変数　：　B
　　指定したい色を（Ｒ，Ｇ，Ｂ）で指定します。
　　０から２５５までの値を指定してください。

　　setflagに乗算を指定した場合は、
　　各成分に、R/255, G/255, B/255を乗算します。

6. [IN] 数値または、変数　：　setflag
　　setflagが０のときは、
　　パーツの色を（Ｒ，Ｇ，Ｂ）にセットします。

　　setflagが１のときは、
　　パーツの色に（R/255, G/255, B/255）を乗算します。

　　setflagが２のときは、
　　パーツの色に（Ｒ，Ｇ，Ｂ）を足し算します。

　　setflagが３のときは、
　　パーツの色から（Ｒ，Ｇ，Ｂ）を減算します。


7. [IN] 数値または、変数　：　vertno
　　指定した頂点番号の色をセットします。
　　この引数を省略、または、-1をセットした場合には、
　　partnoで指定したパーツ全体の色の設定をします。



バージョン : ver1.0.0.1

%index
E3DSetAmbient
パーツのambient色をセットする関数です。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　R
p4 : [IN] 数値または、変数　：　G
p5 : [IN] 数値または、変数　：　B
p6 : [IN] 数値または、変数　：　setflag
p7 : [IN] 数値または、変数　：　vertno

%inst
パーツのambient色をセットする関数です。

指定した色を、
そのまま設定、乗算して設定、加算して設定、
減算して設定の、4種類出来ます。

その時点で、表示されている色に対して、
乗算、加算、減算します。


頂点単位で色の設定が出来ます。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ
　　-1を指定すると、ビルボードの色を設定できます。

2. [IN] 数値または、変数　：　partno
　　設定したいパーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。

　　hsidに-1を指定した場合は、
　　E3DCreateBillboardで取得した、
　　ビルボードidを渡してください。

　　partnoに-1を渡すと、
　　全てのパーツに色をセットできます。

3. [IN] 数値または、変数　：　R
4. [IN] 数値または、変数　：　G
5. [IN] 数値または、変数　：　B
　　指定したい色を（Ｒ，Ｇ，Ｂ）で指定します。
　　０から２５５までの値を指定してください。

　　setflagに乗算を指定した場合は、
　　各成分に、R/255, G/255, B/255を乗算します。

6. [IN] 数値または、変数　：　setflag
　　setflagが０のときは、
　　パーツの色を（Ｒ，Ｇ，Ｂ）にセットします。

　　setflagが１のときは、
　　パーツの色に（R/255, G/255, B/255）を乗算します。

　　setflagが２のときは、
　　パーツの色に（Ｒ，Ｇ，Ｂ）を足し算します。

　　setflagが３のときは、
　　パーツの色から（Ｒ，Ｇ，Ｂ）を減算します。

7. [IN] 数値または、変数　：　vertno
　　指定した頂点番号の色をセットします。
　　この引数を省略、または、-1をセットした場合には、
　　partnoで指定したパーツ全体の色の設定をします。




バージョン : ver1.0.0.1

%index
E3DSetBlendingMode
ビルボードとスプライトの半透明モードを指定します。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　blendmode

%inst
ビルボードとスプライトの半透明モードを指定します。

加算モードと、頂点アルファ値による半透明モードの２つから選べます。

html{
<strong>ver2.0.0.5で、加算モードその２が増えました。</strong>
}html


sigモデルデータの半透明モードの設定は
E3DSetMaterialBlendingModeをお使いください。



→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ
　　-1を指定すると、ビルボードのモードを設定できます。

　　-2を指定すると、スプライトの設定が出来ます。


2. [IN] 数値または、変数　：　partno
　　設定したいパーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。

　　hsidに-1を指定した場合は、
　　E3DCreateBillboardで取得した、
　　ビルボードidを渡してください。

　　hsidに-2を指定した場合は、
　　E3DCreateSpriteで取得した、
　　スプライトのidを渡してください。

　　partnoに-1を渡すと、
　　全てのパーツにモードをセットできます。

3. [IN] 数値または、変数　：　blendmode
　　０を指定すると、
　　頂点アルファ値による半透明モードになります。

　　１を指定すると、　
　　アッドモードになります。

　　２を指定すると、
　　頂点アルファを考慮したアッドモードになります。




バージョン : ver1.0.0.1<BR>
      <BR>
      ver2.0.0.5で拡張

%index
E3DSetRenderState
パーツごとに、RenderStateを設定できます。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　statetype
p4 : [IN] 数値または、変数　：　value

%inst
パーツごとに、RenderStateを設定できます。

描画の度に呼ぶ必要はありません。
一度呼べば、描画時に、自動的に、設定されます。


上級者向けの関数です。
詳しくは、DirectXのヘルプの
SetRenderStateをご覧ください。

D3DRS_ALPHABLENDENABLE
は、E3DRenderのwithalpha引数を元に、
自動的に呼び出すようにしているので、
このタイプは指定しても、反映されません。

また、オリジナルの頂点計算を行っているため、設定しても、効果のないものも、多くあります。

statetypeは、zip中の、
e3dhsp3.as
で、D3DRSで始まる定数として宣言していますので、
このファイルの定数を使用してください。





→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ
　　-1を指定すると、ビルボードのステートを設定できます。

2. [IN] 数値または、変数　：　partno
　　設定したいパーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。

　　hsidに-1を指定した場合は、
　　E3DCreateBillboardで取得した、
　　ビルボードidを渡してください。

　　partnoに-1を渡すと、
　　全てのパーツにステートをセットできます。

3. [IN] 数値または、変数　：　statetype
　　設定するタイプを指定してください。
　　e3dhsp3.as中の定数を使用してください。

4. [IN] 数値または、変数　：　value
　　設定する値を指定してください。



バージョン : ver1.0.0.1

%index
E3DSetScale
パーツ単位で、形状を拡大、縮小できます。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　scalex
p4 : [IN] 数値または、変数　：　scaley
p5 : [IN] 数値または、変数　：　scalez
p6 : [IN] 数値または、変数　：　centerflag

%inst
パーツ単位で、形状を拡大、縮小できます。

特殊効果用を想定していますので、
地面データには使用できません。


倍率は、形状データ読み込み時の大きさに対する比率です。

その時点で、表示されている大きさに対する比率ではないので、注意してください。





→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ
　　-1を指定すると、ビルボードのスケールを設定できます。

2. [IN] 数値または、変数　：　partno
　　設定したいパーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。

　　hsidに-1を指定した場合は、
　　E3DCreateBillboardで取得した、
　　ビルボードidを渡してください。

　　partnoに-1を渡すと、
　　全てのパーツにスケールをセットできます。


3. [IN] 数値または、変数　：　scalex
4. [IN] 数値または、変数　：　scaley
5. [IN] 数値または、変数　：　scalez

　　Ｘ，Ｙ，Ｚのそれぞれの倍率を指定します。
　　それぞれ、
　　scalex、
　　scaleyt、
　　scalez　倍されます。
　　等倍は１．０。
　　実数。

6. [IN] 数値または、変数　：　centerflag
　　拡大縮小する際の中心を指定します。

　　０を指定すると、
　　hsidで指定したモデル全体の中心を拡大の中心とします。

　　１を指定すると、
　　それぞれのパーツの中心を拡大の中心とします。

　　2を指定すると、
　　原点を拡大の中心とします。




バージョン : ver1.0.0.1

%index
E3DGetScreenPos
形状データの画面上での2Dの座標を取得する関数です。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 変数または、数値　：　scid
p2 : [IN] 数値または、変数　：　hsid
p3 : [IN] 数値または、変数　：　partno
p4 : [OUT] 変数　：　scx
p5 : [OUT] 変数　：　scy
p6 : [IN] 数値または、変数　：　vertno
p7 : [IN] 数値または、変数　：　calcmode

%inst
形状データの画面上での2Dの座標を取得する関数です。

パーツ単位、モデル単位、ビルボード単位で
使用できます。

頂点単位での２Ｄ座標を取得できます。

３Ｄキャラクターの位置に、2Dのスプライトを表示する、などの用途に使えます。


html{
<strong>E3DChkInViewより後で、呼び出してください。</strong>
}html


具体的な使用例は、zip中の、
html{
<strong>e3dhsp3_screenpos.hsp</strong>
}html
に書きましたので、ご覧ください。





→引数
1. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。

2. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ
　　-1を指定すると、ビルボードの２Ｄ位置を取得できます。

3. [IN] 数値または、変数　：　partno
　　設定したいパーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。

　　hsidに-1を指定した場合は、
　　E3DCreateBillboardで取得した、
　　ビルボードidを渡してください。

　　partnoに-1を渡すと、
　　モデル全体の中心座標の２Ｄ座標を
　　取得できます。

4. [OUT] 変数　：　scx
5. [OUT] 変数　：　scy
　　指定したパーツの2Dスクリーン座標が代入されます。
　　整数。　

　　ただし、以下の場合には、
　　scx = -1, scy = -1が代入されます。
　　
　　１，パーツが表示用オブジェクトではない場合
　　２，パーツ全体が画面外にある場合
　　３，パーツのディスプレイスイッチがオフの場合
　　４，パーツが無効になっていた場合
　　　　（E3DSetValidFlagで０を指定した場合）

6. [IN] 数値または、変数　：　vertno
　　取得したい頂点の番号を指定します。
　　この引数を省略した場合や、-1を指定した場合は、
　　パーツの中心の２Ｄ座標を取得します。

7. [IN] 数値または、変数　：　calcmode
　　計算モードを指定します。
　　
　　１を指定すると、
　　新しいキャラクターの位置や、カメラの位置で、
　　新たに計算し直します。
　　０を指定すると、
　　calcmode 1 で、すでに計算した結果を取得します。

　　０を指定した方が、処理が軽く、高速です。


バージョン : ver1.0.0.1

%index
E3DGetScreenPos2
任意の３Ｄ座標から、スクリーン（２Ｄ）座標を取得する関数。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 変数または、数値　：　scid
p2 : [IN] 変数または、数値　：　x3d
p3 : [IN] 変数または、数値　：　y3d
p4 : [IN] 変数または、数値　：　z3d
p5 : [OUT] 変数　：　x2d
p6 : [OUT] 変数　：　y2d
p7 : [OUT] 変数　：　validflag

%inst
任意の３Ｄ座標から、スクリーン（２Ｄ）座標を取得する関数。

ラインの点の位置や、ボーンの位置に
スプライトを表示したりできます。


＃表示オブジェクトの頂点や、
パーツの中心の２Ｄ座標を取得する場合は、
既にある、E3DGetScreenPosをご利用ください。






→引数
1. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。

2. [IN] 変数または、数値　：　x3d
3. [IN] 変数または、数値　：　y3d
4. [IN] 変数または、数値　：　z3d
　　3D座標を、（x3d, y3d, z3d）に指定してください。
　　実数。


5. [OUT] 変数　：　x2d
6. [OUT] 変数　：　y2d
7. [OUT] 変数　：　validflag
　　変換後の２Ｄ座標が、（x2d, y2d）に代入されます。
　　整数型の変数。

　　２Ｄ座標が、スクリーンの大きさの内側にあるかどうかは、
　　ユーザーさんがチェックしてください。

　　指定した３Ｄ座標が、カメラより後ろにある場合や、
　　見えないくらい遠いところにある場合には、
　　validflag に　０　が代入されます。
　　validflagに０が代入されているときの、(x2d, y2d)座標は、
　　意味のない値が入っています。



バージョン : ver1.0.0.1

%index
E3DCreateQ
クォータニオンを作成し、操作用のid を取得します。
%group
Easy3D For HSP3 : 算術

%prm
p1
p1 : [OUT] 変数　：　qid

%inst
クォータニオンを作成し、操作用のid を取得します。

クォータニオンの各操作には、
この関数で取得した qidを使用します。

クォータニオンを知らない方は、
とりあえず、
姿勢情報　（回転情報）を格納できる
便利なもの、
とくらいに、考えておいてください。


モーションポイントや、モデルなどに、
クォータニオンをセットすることにより、
任意の姿勢を持たせることが出来ます。

作成方法は、工夫してみましたが、
それほど、高速ではありません。
この関数は、メインループの外で、
あらかじめ呼んでおくことが、
望ましいです。




→引数
1. [OUT] 変数　：　qid
　　新しいクォータニオンを作成し、
　　そのクォータニオンを、
　　一意に識別する番号を　qid　に代入します。
　　
　　クォータニオン操作関数に、
　　この番号を渡して使用してください。
　　



バージョン : ver1.0.0.1

%index
E3DDestroyQ
クォータニオンを削除します。
%group
Easy3D For HSP3 : 算術

%prm
p1
p1 : [IN] 数値または、変数　：　qid

%inst
クォータニオンを削除します。

この関数に渡したqidは、使用できなくなります。



→引数
1. [IN] 数値または、変数　：　qid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。



バージョン : ver1.0.0.1

%index
E3DInitQ
クォータニオンを初期化します。
%group
Easy3D For HSP3 : 算術

%prm
p1
p1 : [IN] 数値または、変数　：　qid

%inst
クォータニオンを初期化します。

姿勢情報が、初期化されます。



→引数
1. [IN] 数値または、変数　：　qid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。



バージョン : ver1.0.0.1

%index
E3DSetQAxisAndDeg
クォータニオンを、指定した軸に関して、指定した角度だけ回転した姿勢をセットします。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　qid
p2 : [IN] 数値または、変数　：　axisx
p3 : [IN] 数値または、変数　：　axisy
p4 : [IN] 数値または、変数　：　axisz
p5 : [IN] 数値または、変数　：　deg

%inst
クォータニオンを、指定した軸に関して、指定した角度だけ回転した姿勢をセットします。

既に、qidにセットしてある姿勢情報は、
上書きされます（無視されます）。





→引数
1. [IN] 数値または、変数　：　qid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。

2. [IN] 数値または、変数　：　axisx
3. [IN] 数値または、変数　：　axisy
4. [IN] 数値または、変数　：　axisz
　　回転の軸のベクトルを、
　　(axisx, axisy, axisz)に指定します。　
　　軸のベクトルは、内部で正規化されます。
　　実数。

5. [IN] 数値または、変数　：　deg
　　指定した軸に関して、
　　deg度だけ回転した姿勢をセットします。
　　実数。



バージョン : ver1.0.0.1

%index
E3DGetQAxisAndDeg
クォータニオンにセットされている姿勢情報を解析します。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　qid
p2 : [OUT] 変数　：　axisxptr
p3 : [OUT] 変数　：　axisyptr
p4 : [OUT] 変数　：　axiszptr
p5 : [OUT] 変数　：　degptr

%inst
クォータニオンにセットされている姿勢情報を解析します。

回転軸と、回転角度が得られます。




→引数
1. [IN] 数値または、変数　：　qid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。

2. [OUT] 変数　：　axisxptr
3. [OUT] 変数　：　axisyptr
4. [OUT] 変数　：　axiszptr
　　回転の軸のベクトルを、
　　(axisxptr, axisyptr, axiszptr)に代入します。　
　　実数型の変数。

5. [OUT] 変数　：　degptr
　　回転角度を代入します。
　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DRotateQX
クォータニオンの姿勢情報を、Ｘ軸に関して回転します。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2
p1 : [IN] 数値または、変数　：　qid
p2 : [IN] 数値または、変数　：　deg

%inst
クォータニオンの姿勢情報を、Ｘ軸に関して回転します。

既に、qidにセットしてある姿勢情報に対して、
さらに、Ｘ軸回転することになります。




→引数
1. [IN] 数値または、変数　：　qid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。

2. [IN] 数値または、変数　：　deg
　　X軸に関して、deg度だけ回転します。
　　実数。



バージョン : ver1.0.0.1

%index
E3DRotateQY
クォータニオンの姿勢情報を、Ｙ軸に関して回転します。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2
p1 : [IN] 数値または、変数　：　qid
p2 : [IN] 数値または、変数　：　deg

%inst
クォータニオンの姿勢情報を、Ｙ軸に関して回転します。

既に、qidにセットしてある姿勢情報に対して、
さらに、Ｙ軸回転することになります。




→引数
1. [IN] 数値または、変数　：　qid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。

2. [IN] 数値または、変数　：　deg
　　Ｙ軸に関して、deg度だけ回転します。
　　実数。


バージョン : ver1.0.0.1

%index
E3DRotateQZ
クォータニオンの姿勢情報を、Ｚ軸に関して回転します。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2
p1 : [IN] 数値または、変数　：　qid
p2 : [IN] 数値または、変数　：　deg

%inst
クォータニオンの姿勢情報を、Ｚ軸に関して回転します。

既に、qidにセットしてある姿勢情報に対して、
さらに、Ｚ軸回転することになります。




→引数
1. [IN] 数値または、変数　：　qid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。

2. [IN] 数値または、変数　：　deg
　　Ｚ軸に関して、deg度だけ回転します。
　　実数。


バージョン : ver1.0.0.1

%index
E3DMultQ
クォータニオンの掛け算をします。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　resqid
p2 : [IN] 数値または、変数　：　befqid
p3 : [IN] 数値または、変数　：　aftqid

%inst
クォータニオンの掛け算をします。

例えば、
qid1にＸ軸に関して３０度回転する姿勢が格納されていて、
qid2には、Ｙ軸に関して２０度回転する姿勢が格納されていたとします。

このとき、
E3DMultQ qid3, qid1, qid2
という命令を呼んだとします。

すると、
qid3には、
Ｘ軸に関して３０度回転した後に、
さらにＹ軸に関して２０度回転した姿勢情報が
格納されます。

気を付けなければいけないのは、
E3DMultQ qid3, qid1, qid2
と
E3DMultQ qid3, qid2, qid1
では、qid3に格納される姿勢情報が異なる
ということです。

2番目の引数に指定した回転の後に、
3番目の引数に指定した回転を適用するからです。

回転の順番によって、結果が異なるのは、
覚えておいてください。

後から処理したい方を、3番目の引数に
いれれば、ＯＫです。




→引数
1. [IN] 数値または、変数　：　resqid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。
　　このidのクォータニオンに結果が代入されます。

2. [IN] 数値または、変数　：　befqid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。

3. [IN] 数値または、変数　：　aftqid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。

　　befqidの回転の後に、aftqidの回転をした結果を、
　　resqidで識別されるクォータニオンに代入します。



バージョン : ver1.0.0.1

%index
E3DNormalizeQ
クォータニオンを正規化します。
%group
Easy3D For HSP3 : 算術

%prm
p1
p1 : [IN] 数値または、変数　：　qid

%inst
クォータニオンを正規化します。

様々なクォータニオンの操作を、
とてつもない回数繰り返していると、
計算誤差などで、
クォータニオンの情報がおかしくなることがあります。

例えば、E3DRotateQXをメインループで、
延々と繰り返す場合などに、
ひょっとしたら、不具合が出るかもしれません。

そんなときは、
ある程度の回数ごとに、
この関数を呼んでください。




→引数
1. [IN] 数値または、変数　：　qid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。



バージョン : ver1.0.0.1

%index
E3DCopyQ
srcqidで識別されるクォータニオンの情報を、dstqidで識別されるクォータニオンにコピーします。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2
p1 : [IN] 数値または、変数　：　dstqid
p2 : [IN] 数値または、変数　：　srcqid

%inst
srcqidで識別されるクォータニオンの情報を、dstqidで識別されるクォータニオンにコピーします。




→引数
1. [IN] 数値または、変数　：　dstqid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。&nbsp;

2. [IN] 数値または、変数　：　srcqid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。



バージョン : ver1.0.0.1

%index
E3DGetBoneNoByName
指定した名前を持つボーンを識別するidを取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 文字列または、文字列の変数　：　bonename
p3 : [OUT] 変数　：　boneno

%inst
指定した名前を持つボーンを識別するidを取得します。

該当するボーンが見つからなかった場合は、
bonenoに-1が代入されます。

ボーン以外の名前を指定した場合も、
bonenoに-1が代入されます。


複数のパーツやボーンに、
同じ名前があった場合、
一番最初に見つかった物のidだけしか
取得できません。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 文字列または、文字列の変数　：　bonename
　　ボーンの名前を渡してください。

3. [OUT] 変数　：　boneno
　　ボーンを識別するＩＤ



バージョン : ver1.0.0.1

%index
E3DGetNextMP
モーションポイントを識別するidを取得します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　motid
p3 : [IN] 数値または、変数　：　boneno
p4 : [IN] 数値または、変数　：　prevmpid
p5 : [OUT] 変数　：　mpid

%inst
モーションポイントを識別するidを取得します。

モーションポイントとは、
RokDeBone2のモーションダイアログ中の、
下の方に白い長いウインドウがありますが、
その中に表示されている、
点のことだと思ってください。

モーションポイントは、
ユーザーさんがＩＫで設定した姿勢を
保持しています。

モーションポイントは、ボーンごとに作られています。

気を付けて欲しいのは、
RokDeBone2で、白いウインドウ中に
点が表示されていないフレーム番号には、
モーションポイントは存在しないということです。

モーションポイントが無いフレーム番号の姿勢は
どうなっているかというと、
計算で、求めています。


モーションポイントは、フレーム番号の小さい順に、格納されています。

E3DGetNextMPは、prevmpidで指定した
モーションポイントのフレーム番号を見て、
そのフレーム番号の次に大きいフレーム番号を持つモーションポイントのidを取得します。

prevmpidに-1を指定すると、
一番小さいフレーム番号を持つ、モーションポイントのidが取得できます。

prevmpidのモーションポイントが持つフレーム番号より、大きいフレーム番号を持つモーションポイントが存在しない場合は、
mpidに-1が代入されます。


つまり、取得したmpidを
prevmpidに指定して、
再びE3DGetNextMPを呼び出す、
という作業を、
mpidに-1が代入されるまで、繰り返せば、
フレーム番号の小さい順に、
全てのモーションポイントのidが取得出来る
ということになります。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　motid
　　モーションを識別するＩＤ
　　E3DAddMotionで取得したmkを指定してください。

3. [IN] 数値または、変数　：　boneno
　　ボーンを識別するＩＤ
　　E3DGetBoneNoByNameで取得した
　　ボーンの番号を渡してください。

4. [IN] 数値または、変数　：　prevmpid
　　モーションポイントを識別するＩＤ
　　E3DGetNextMPで取得したidを渡してください。

　　-1を指定すると、一番小さなフレーム番号を持つ
　　モーションポイントのidがmpidに代入されます。

5. [OUT] 変数　：　mpid
　　mpidに、prevmpidの次に大きいフレーム番号を持つ
　　モーションポイントのidが代入されます。







バージョン : ver1.0.0.1

%index
E3DGetMPInfo
mpinfoで指定した配列に、
情報が代入されます。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　motid
p3 : [IN] 数値または、変数　：　boneno
p4 : [IN] 数値または、変数　：　mpid
p5 : [IN, OUT]　長さＭＰＩ＿ＭＡＸの配列　：　mpinfo

%inst
mpinfoで指定した配列に、
情報が代入されます。

情報は１2(MPI_MAX)種類です

mpinfoには、
dim mpinfo, MPI_MAX
で作成した配列を指定してください。

MPI_で始まる定数は、
e3dhsp3.asで、定義されています。


mpinfo(MPI_QUA)は、クォータニオン情報
mpinfo(MPI_TRAX)は、Ｘ方向の移動量の情報
mpinfo(MPI_TRAY)は、Y方向の移動量の情報
mpinfo(MPI_TRAZ)は、Z方向の移動量の情報
mpinfo(MPI_FRAMENO)は、フレーム番号の情報
mpinfo(MPI_DISPSWITCH)は、
　　　ディスプレイスイッチの情報
mpinfo(MPI_INTERP)は、補間計算方法の情報
mpinfo(MPI_SCALEX)は、Ｘ方向の拡大情報
mpinfo(MPI_SCALEY)は、Ｙ方向の拡大情報
mpinfo(MPI_SCALEZ)は、Ｚ方向の拡大情報
mpinfo(MPI_USERINT1)は、ユーザーデータの情報
mpinfo(MPI_SCALEDIV)は、拡大率の係数情報
として、使用されます。

mpinfo(MPI_QUA)には、
E3DCreateQで取得したqidを、
この関数の呼び出し前に、セットしておく必要があります。
mpinfo(MPI_QUA)に格納されているqidで
識別されるクォータニオンに、
モーションポイントの姿勢情報が代入されます。

mpinfo(MPI_DISPSWITCH)の
ディスプレイスイッチ情報は、ビットごとの和になっています。
ディスプレイスイッチ番号ds がオンの場合は、
２のds乗の値が足されていることになります。
例えば、ディスプレイスイッチ３だけがオンの場合は、２の3乗の８という値が代入されています。

mpinfo(MPI_INTERP)の
補間計算方法の情報は、
mpidで識別されるモーションポイントと、
その次に大きいフレーム番号を持つモーションポイントの間の、補間計算方法を示しています。
０の時は、球面線形補間
１の時は、スプライン補間
となります。

現バージョンでは、
スプライン補間は、大きな角度の補間時には
使用できません。
（望ましい結果が得られません）
ですので、
急激に変化することがあるかもしれない
モーションポイント間の補間計算には、
球面線形補間を使用することを、
おすすめします。

拡大率は、MPI_SCALEDIVで割った値が
適用されています。
例えば、Ｘ軸方向の拡大率は、
mpinfo(MPI_SCALEX) / mpinfo(MPI_SCALEDIV)
です。
小数点以下をセットできるように、
MPI_SCALEDIVが用意されています。


具体的な使用例は、
e3dhsp3_motionpoint.hsp
をご覧ください。



→引数
・引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　motid
　　モーションを識別するＩＤ
　　E3DAddMotionで取得したmkを指定してください。

3. [IN] 数値または、変数　：　boneno
　　ボーンを識別するＩＤ
　　E3DGetBoneNoByNameで取得した
　　ボーンの番号を渡してください。

4. [IN] 数値または、変数　：　mpid
　　モーションポイントを識別するＩＤ
　　E3DGetNextMPで取得したidを渡してください。

5. [IN, OUT]　長さＭＰＩ＿ＭＡＸの配列　：　mpinfo
　　モーションポイントの情報を格納する配列。
　　mpinfo(MPI_QUA)だけは、呼び出し前に、
　　あらかじめ設定しておく必要があります。

　　mpinfo(MPI_QUA)で識別されるクォータニオンに
　　モーションポイントの姿勢情報が
　　代入されることになります。


バージョン : ver1.0.0.1

%index
E3DSetMPInfo
mpidで識別されるモーションポイントに情報をセットします。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　motid
p3 : [IN] 数値または、変数　：　boneno
p4 : [IN] 数値または、変数　：　mpid
p5 : [IN]　長さMPI_MAXの配列　：　mpinfo
p6 : [IN]　長さMPI_MAXの配列　：　mpinfoflag

%inst
mpidで識別されるモーションポイントに情報をセットします。

mpinfo、mpinfoflagには、それぞれ
dim mpinfo, MPI_MAX
dim mpinfoflag, MPI_MAX
で作成した配列を使用してください。


mpinfoにあらかじめセットされている情報を、
mpidで識別されるモーションポイントに、
設定します。

mpinfoの、どの成分に、
何の情報をセットすれば良いかは
E3DGetMPInfoをご覧ください。

mpinfoflagは、部分的に情報をセットできるようにするために、使用します。

mpinfoflag(MPI_QUA)が１の場合は、
mpinfo(MPI_QUA)のクォータニオン情報を
モーションポイントにセットします。

mpinfoflag(MPI_TRAX)が１の場合は、
mpinfo(MPI_TRAX)のX方向の移動量情報を
モーションポイントにセットします。

以下同様に、
mpinfoflag(MPI_QUA) ～mpinfoflag(MPI_SCALEDIV)
までに、セットしたい項目に１を、
セットしたくない項目に０を指定してください。


具体的な使用例は、zip中の、
e3dhsp3_motionpoint.hsp
に書いてありますので、
ご覧ください。


モーションポイントに情報をセットしただけでは、モデルのポーズに反映されません。
ポーズに反映させるためには、
E3DFillUpMotionを呼んでください。

だたし、E3DFillUpMotionは、
とても、計算量が多く、実行時間が長いので、
なるべく呼び出し回数は少なくしてください。

つまり、必要なモーションポイントの操作が
全て終わってから、
まとめて一回だけ、E3DFillUpMotionするように
してください。



→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　motid
　　モーションを識別するＩＤ
　　E3DAddMotionで取得したmkを指定してください。

3. [IN] 数値または、変数　：　boneno
　　ボーンを識別するＩＤ
　　E3DGetBoneNoByNameで取得した
　　ボーンの番号を渡してください。

4. [IN] 数値または、変数　：　mpid
　　モーションポイントを識別するＩＤ
　　E3DGetNextMPで取得したidを渡してください。

5. [IN]　長さMPI_MAXの配列　：　mpinfo
　　モーションポイントの情報を格納する配列。

6. [IN]　長さMPI_MAXの配列　：　mpinfoflag
　　mpinfoのどの成分を有効にするのかを、
　　mpinfoflagの各成分で指定します。





バージョン : ver1.0.0.1

%index
E3DIsExistMP
framenoで指定したフレーム番号に、モーションポイントがあるかどうかを調べます。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　motid
p3 : [IN] 数値または、変数　：　boneno
p4 : [IN] 数値または、変数　：　frameno
p5 : [OUT] 変数　：　mpid

%inst
framenoで指定したフレーム番号に、モーションポイントがあるかどうかを調べます。

見つかった場合は、
mpidに、モーションポイントのidが代入され、
無かった場合は、
-1が代入されます。






→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　motid
　　モーションを識別するＩＤ
　　E3DAddMotionで取得したmkを指定してください。

3. [IN] 数値または、変数　：　boneno
　　ボーンを識別するＩＤ
　　E3DGetBoneNoByNameで取得した
　　ボーンの番号を渡してください。

4. [IN] 数値または、変数　：　frameno
　　モーションポイントがあるかどうか、
　　調べたいフレーム番号を指定します。

5. [OUT] 変数　：　mpid
　　モーションポイントを識別するＩＤ
　　framenoが示すフレーム番号に、
　　モーションポイントがあった場合は、
　　そのモーションポイントのidが代入されます。
　　無かった場合は、-1が代入されます。



バージョン : ver1.0.0.1

%index
E3DGetMotionFrameLength
motidで識別されるモーションのフレーム数を取得します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　motid
p3 : [OUT] 変数　：　leng

%inst
motidで識別されるモーションのフレーム数を取得します。

気を付けて欲しいのは、
フレーム番号は、０から始まるので、
最大のフレーム番号は、
leng - 1
だということです。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　motid
　　モーションを識別するＩＤ
　　E3DAddMotionで取得したmkを指定してください。

3. [OUT] 変数　：　leng
　　モーションのフレーム数が代入されます。



バージョン : ver1.0.0.1

%index
E3DSetMotionFrameLength
モーションのフレーム数をframelengに変更します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　motid
p3 : [IN] 数値または、変数　：　frameleng
p4 : [IN] 数値または、変数　：　initflag

%inst
モーションのフレーム数をframelengに変更します。

framelengが、変更前のフレーム数より小さかった場合は、
frameleng - 1より大きなフレーム番号を持つ
モーションポイントは、削除されます。

あたり判定情報や、視野内判定情報が
削除されます。
再構築したい場合は、
initflagに１を指定してください。
しなくてもいい、もしくは、後でする場合は、
０を指定してください。

あたり判定情報と、視野内判定情報は、
E3DFillUpMotion呼び出し時の
initflagに１を指定することでも、
再構築できます。

再構築の計算は、時間がかかります。


ポーズの情報も、削除されます。
再構築する場合には、
E3DFillUpMotionを呼んでください。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　motid
　　モーションを識別するＩＤ
　　E3DAddMotionで取得したmkを指定してください。

3. [IN] 数値または、変数　：　frameleng
　　モーションのフレーム数を指定します。

4. [IN] 数値または、変数　：　initflag
　　あたり判定情報と、視野内判定情報を
　　再構築する場合は１を、
　　しない場合は０を指定してください。



バージョン : ver1.0.0.1

%index
E3DAddMP
mpinfoで指定した情報を持つモーションポイントを、新たに作成し、作成したモーションポイントを識別するidを取得します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　motid
p3 : [IN] 数値または、変数　：　boneno
p4 : [IN]　要素数MPI_MAXの配列　：　mpinfo
p5 : [OUT] 変数　：　mpid

%inst
mpinfoで指定した情報を持つモーションポイントを、新たに作成し、作成したモーションポイントを識別するidを取得します。


mpinfoには、
html{
<strong>dim mpinfo, MPI_MAX</strong>
}html
で作成した配列を使用してください。


mpinfoの、どの成分に、
何の情報をセットすれば良いかは
E3DGetMPInfoをご覧ください。

html{
<strong>mpinfo(MPI_FRAMENO)で指定したフレーム番号に、
既に、モーションポイントが存在する場合は、エラーになりますので、
注意してください。</strong>
}html
（呼び出し前にE3DIsExistMPで、
チェックすると確実です。）


モーションポイントに情報をセットしただけでは、モデルのポーズに反映されません。
ポーズに反映させるためには、
E3DFillUpMotionを呼んでください。

だたし、E3DFillUpMotionは、
とても計算量が多く、実行時間が長いので、
なるべく呼び出し回数は少なくしてください。

つまり、必要なモーションポイントの操作が
全て終わってから、
まとめて一回だけ、E3DFillUpMotionするように
してください。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　motid
　　モーションを識別するＩＤ
　　E3DAddMotionで取得したmkを指定してください。

3. [IN] 数値または、変数　：　boneno
　　ボーンを識別するＩＤ
　　E3DGetBoneNoByNameで取得した
　　ボーンの番号を渡してください。

4. [IN]　要素数MPI_MAXの配列　：　mpinfo
　　モーションポイントの情報を格納する配列。

5. [OUT] 変数　：　mpid
　　新たに作成したモーションポイントを識別するidが
　　代入されます。




バージョン : ver1.0.0.1

%index
E3DDeleteMP
mpidで識別されるモーションポイントを削除します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　motid
p3 : [IN] 数値または、変数　：　boneno
p4 : [IN] 数値または、変数　：　mpid

%inst
mpidで識別されるモーションポイントを削除します。

この関数に渡したmpidは、
以後、使えなくなります。


モーションポイントの情報を更新しただけでは、モデルのポーズに反映されません。
ポーズに反映させるためには、
E3DFillUpMotionを呼んでください。

だたし、E3DFillUpMotionは、
とても、計算量が多く、実行時間が長いので、
なるべく呼び出し回数は少なくしてください。

つまり、必要なモーションポイントの操作が
全て終わってから、
まとめて一回だけ、E3DFillUpMotionするように
してください。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　motid
　　モーションを識別するＩＤ
　　E3DAddMotionで取得したmkを指定してください。

3. [IN] 数値または、変数　：　boneno
　　ボーンを識別するＩＤ
　　E3DGetBoneNoByNameで取得した
　　ボーンの番号を渡してください。

4. [IN] 数値または、変数　：　mpid
　　モーションポイントを識別するＩＤ
　　E3DGetNextMPで取得したidを渡してください。



バージョン : ver1.0.0.1

%index
E3DFillUpMotion
モーションを指定したフレーム番号分だけ、補間計算します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　motid
p3 : [IN] 数値または、変数　：　boneno
p4 : [IN] 数値または、変数　：　startframe
p5 : [IN] 数値または、変数　：　endframe
p6 : [IN] 数値または、変数　：　initflag

%inst
モーションを指定したフレーム番号分だけ、補間計算します。

この計算の結果、
モデルのポーズに、モーションポイントの情報が、反映されるようになります。

bonenoで指定したボーンと、
その全ての子供ボーンの計算が行われます。

そのため、
html{
<strong>変更したボーンの内で、
一番親のボーンの番号で、
1回だけこの関数を呼び出せば、
良いことになります。

</strong>
}html
具体的な使用例は、zip中の、
html{
<strong>e3dhsp3_fillupmotion.hsp</strong>
}html
に書きましたので、
ご覧ください。



→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　motid
　　モーションを識別するＩＤ
　　E3DAddMotionで取得したmkを指定してください。

3. [IN] 数値または、変数　：　boneno
　　ボーンを識別するＩＤ
　　E3DGetBoneNoByNameで取得した
　　ボーンの番号を渡してください。

　　bonenoで指定したボーンと
　　その子供ボーン全てのポーズを計算します。

　　boneno に　-1を指定した場合は、
　　全てのボーンの計算が行われます。

　　ですが、
　　bonenoを指定した方が、
　　計算量が少なくなります。


4. [IN] 数値または、変数　：　startframe
5. [IN] 数値または、変数　：　endframe
　　フレーム番号が、
　　startframeから、endframeまでの間の
　　モデルのポーズを計算します。
　　startframeとendframeには、
　　モーションポイントが存在しなくても、
　　計算可能です。

　　endframeに-1を指定した場合は、
　　startrframeから、最後のフレームまで
　　計算されます。


6. [IN] 数値または、変数　：　initflag
　　過去のバージョンと互換性を取るための引数です。
　　０を指定してください。




バージョン : ver1.0.0.1

%index
E3DCopyMotionFrame
srcmotidで識別されるモーションの、フレーム番号srcframenoの、全てのモーションポイントの情報を、dstmotidで識別されるモーションの、フレーム番号dstframenoのモーションポイントへ、コピーします。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　srcmotid
p3 : [IN] 数値または、変数　：　srcframeno
p4 : [IN] 数値または、変数　：　dstmotid
p5 : [IN] 数値または、変数　：　dstframeno

%inst
srcmotidで識別されるモーションの、フレーム番号srcframenoの、全てのモーションポイントの情報を、dstmotidで識別されるモーションの、フレーム番号dstframenoのモーションポイントへ、コピーします。

dstframenoに、モーションポイントが無い場合は、作成されます。

srcframenoにモーションポイントが無い場合は、
計算で求めて、dstframenoにコピーします。
この場合、計算時間が、余分にかかります。



モーションポイントに情報をセットしただけでは、モデルのポーズに反映されません。
ポーズに反映させるためには、
E3DFillUpMotionを呼んでください。

だたし、E3DFillUpMotionは、
とても、計算量が多く、実行時間が長いので、
なるべく呼び出し回数は少なくしてください。

つまり、必要なモーションポイントの操作が
全て終わってから、
まとめて一回だけ、E3DFillUpMotionするように
してください。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　srcmotid
　　コピー元のモーションを識別するＩＤ
　　E3DAddMotionで取得したmkを指定してください。

3. [IN] 数値または、変数　：　srcframeno
　　コピー元のフレーム番号

4. [IN] 数値または、変数　：　dstmotid
　　コピー先のモーションを識別するＩＤ
　　E3DAddMotionで取得したmkを指定してください。

5. [IN] 数値または、変数　：　dstframeno
　　コピー先のフレーム番号




バージョン : ver1.0.0.1

%index
E3DGetDirQ2
E3DGetDirQをqidで操作できるようにしたものです。
%group
Easy3D For HSP3 : モデル向き

%prm
p1,p2
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN, (OUT)] 数値または、変数　：　qid

%inst
E3DGetDirQをqidで操作できるようにしたものです。

qidで指定したクォータニオンに、
モデルデータの姿勢情報が、
格納されます。



→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN, (OUT)] 数値または、変数　：　qid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。



バージョン : ver1.0.0.1

%index
E3DSetDirQ2
E3DSetDirQをqidで操作できるようにしたものです。
%group
Easy3D For HSP3 : モデル向き

%prm
p1,p2
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　qid

%inst
E3DSetDirQをqidで操作できるようにしたものです。

qidで識別されるクォータニオンの
姿勢情報を、
モデルデータにセットします。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　qid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。



バージョン : ver1.0.0.1

%index
E3DLookAtQ
指定した向きを、徐々に向くための姿勢情報を、クォータニオンにセットします。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9
p1 : [IN] 数値または、変数　：　qid
p2 : [IN] 数値または、変数　：　vecx
p3 : [IN] 数値または、変数　：　vecy
p4 : [IN] 数値または、変数　：　vecz
p5 : [IN] 数値または、変数　：　basevecx
p6 : [IN] 数値または、変数　：　basevecy
p7 : [IN] 数値または、変数　：　basevecz
p8 : [IN] 数値または、変数　：　upflag
p9 : [IN] 数値または、変数　：　divnum

%inst
指定した向きを、徐々に向くための姿勢情報を、クォータニオンにセットします。

この関数は、この関数の呼び出し前の
クォータニオンの姿勢情報も、計算に使用します。
ですので、
qidには、一回前にこの関数を呼び出したときと、同じqidが渡されるものと仮定しています。

qidを他のボーンの姿勢情報などの計算の際に、使い回ししている場合は、
計算したいボーンの姿勢情報を、
呼び出し前に、
E3DCopyQなどで、コピーしておいてください。


（basevecx, basevecy, basevecz）のベクトルを
(vecx, vecy, vecz)の方向に向ける計算をします。

キャラクター全体の姿勢の制御をする場合は、
basevecには、初期状態の向き、
つまり、(0, 0, -1)を与えれば、よいことになります。

ボーンの姿勢を制御する場合には、
初期状態のボーンの向き
つまり、ボーンの座標から、親ボーンの座標を
引いたものを、basevecに与えれば、
よいことになります。


(vecx, vecy, vecz)には、
向きたい位置座標から、
自分の位置座標を引いたものを、
与えてください。


upflagの値によって、４つのモードがあります。

upflag == 0 のときは、
上向き方向が、常にＹ軸上方を向くように
制御されます。

upflag == 1 のときは、
上向き方向が、常にＹ軸下方を向くように
制御されます。

upflag == 2 のときは、
上向き方向が、連続した向きをとるように、
制御されます。
その結果、宙返りがかのうとなります。

upflag == 3 のときは、
上向き方向を、特に制御しません。
上向き方向は、連続した向きをとりますが、
その方向は、拘束されません。

飛行機の制御などに、upflag 2を使用し、
人型キャラなどの制御に、upflag 0 を使用する
ことを、おすすめします。

html{
<strong>upflag == 0とupflag== 1のときには、
真上と真下を向かないようにしてください。
</strong>
}html
upflag == 2とupflag==3のときは、
真上と真下を向いても、大丈夫です。


divnum引数に、分割数を指定します。
現在の位置と、目標地点との間の間隔を
1 / divnum ずつ、内分して、近づきます。


具体的な使用例は、
html{
<strong>e3dhsp3_lookatq.hsp</strong>
}html
に書きましたので、ご覧ください。




→引数
1. [IN] 数値または、変数　：　qid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。
　　このidで識別されるクォータニオンに、
　　指定した方向を向くための情報が、
　　格納されます。

2. [IN] 数値または、変数　：　vecx
3. [IN] 数値または、変数　：　vecy
4. [IN] 数値または、変数　：　vecz
　　(vecx, vecy, vecz)に、
　　向きたい向きのベクトルを指定してください。
　　位置ではなくて、向きを指定してください。
　　実数。

5. [IN] 数値または、変数　：　basevecx
6. [IN] 数値または、変数　：　basevecy
7. [IN] 数値または、変数　：　basevecz
　　(basevecx, basevecy, basevecz)に、
　　初期状態の向きを指定してください。
　　実数。

8. [IN] 数値または、変数　：　upflag
　　上方向の制御モードを指定してください。
　　

9. [IN] 数値または、変数　：　divnum
　　内分する割合を指定してください。
　　大きな値をいれるほど、
　　細かく動きます。




バージョン : ver1.0.0.1

%index
E3DMultQVec
(befvecx, befvecy, befvecz)というベクトルに対して、qidで識別されるクォータニオンによる回転をした後のベクトルを、(aftvecx,
aftvecy, aftvecz)に代入します。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 数値または、変数　：　qid
p2 : [IN] 数値または、変数　：　befvecx
p3 : [IN] 数値または、変数　：　befvecy
p4 : [IN] 数値または、変数　：　befvecz
p5 : [OUT] 変数　：　aftvecx
p6 : [OUT] 変数　：　aftvecy
p7 : [OUT] 変数　：　aftvecz

%inst
(befvecx, befvecy, befvecz)というベクトルに対して、qidで識別されるクォータニオンによる回転をした後のベクトルを、(aftvecx,
aftvecy, aftvecz)に代入します。


例えば、初期状態で、-Z方向を向いている
モデルの場合、

qidに、E3DGetDirQ2呼び出しに使用した
qidを渡し、
basevecに、（0, 0, -1）を渡せば、
aftvecに、現在、キャラクターが向いている向きが代入されます。



→引数
1. [IN] 数値または、変数　：　qid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。
　　このidで識別されるクォータニオンの
　　回転変換をします。
　　
2. [IN] 数値または、変数　：　befvecx
3. [IN] 数値または、変数　：　befvecy
4. [IN] 数値または、変数　：　befvecz
　　(befvecx, befvecy, befvecz)に、
　　回転前のベクトルを指定してください。
　　実数。

5. [OUT] 変数　：　aftvecx
6. [OUT] 変数　：　aftvecy
7. [OUT] 変数　：　aftvecz
　　(aftvecx, aftvecy, aftvecz)に、
　　クォータニオンでの回転後のベクトルが
　　代入されます。
　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DTwistQ
クォータニオンに、ねじりを加えます。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　qid
p2 : [IN] 数値または、変数　：　twistdeg
p3 : [IN] 数値または、変数　：　basevecx
p4 : [IN] 数値または、変数　：　basevecy
p5 : [IN] 数値または、変数　：　basevecz

%inst
クォータニオンに、ねじりを加えます。

basevecには、E3DLookAtQで説明したのと
同じ、初期状態の向きを指定してください。


ねじりの角度は、初期状態からの角度ではなく、現在の姿勢に、追加したい分だけの、
ねじりの角度を、指定してください。



→引数
1. [IN] 数値または、変数　：　qid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。
　　このidで識別されるクォータニオンに、
　　指定した方向を向くための情報が、
　　格納されます。

2. [IN] 数値または、変数　：　twistdeg
　　twistdeg  度だけ、ねじりを加えます。
　　実数。

3. [IN] 数値または、変数　：　basevecx
4. [IN] 数値または、変数　：　basevecy
5. [IN] 数値または、変数　：　basevecz
　　(basevecx, basevecy, basevecz)に、
　　初期状態の向きを指定してください。
　　E3DLookAtQで指定したのと同じbasevecを指定してください。
　　実数。



バージョン : ver1.0.0.1

%index
E3DInitTwistQ
E3DTwistQで与えた、ねじれを、初期化します。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　qid
p2 : [IN] 数値または、変数　：　basevecx
p3 : [IN] 数値または、変数　：　basevecy
p4 : [IN] 数値または、変数　：　basevecz

%inst
E3DTwistQで与えた、ねじれを、初期化します。

basevecには、E3DLookAtQで説明したのと
同じ、初期状態の向きを指定してください。




→引数
1. [IN] 数値または、変数　：　qid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。
　　このidで識別されるクォータニオンの
　　ねじれを初期化します。
　　
2. [IN] 数値または、変数　：　basevecx
3. [IN] 数値または、変数　：　basevecy
4. [IN] 数値または、変数　：　basevecz
　　(basevecx, basevecy, basevecz)に、
　　初期状態の向きを指定してください。
　　E3DLookAtQで指定したのと同じbasevecを指定してください。
　　実数。



バージョン : ver1.0.0.1

%index
E3DGetTwistQ
E3DTwistQで与えた、ねじれの角度の合計を取得します。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2
p1 : [IN] 数値または、変数　：　qid
p2 : [OUT] 変数　：　twist

%inst
E3DTwistQで与えた、ねじれの角度の合計を取得します。




→引数
1. [IN] 数値または、変数　：　qid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。
　　このidで識別されるクォータニオンの
　　ねじれを取得します。

2. [OUT] 変数　：　twist
　　ねじれ角度の合計の値を、
　　代入します。
　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DRotateQLocalX
クォータニオンを、ローカルなＸ軸に関して、回転します。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2
p1 : [IN] 数値または、変数　：　qid
p2 : [IN] 数値または、変数　：　deg

%inst
クォータニオンを、ローカルなＸ軸に関して、回転します。

現在の姿勢に対して、更に、回転します。

E3DRotateQXと違うのは、
姿勢変換を行う前のＸ軸に関して、
回転できる点です。

使用例は、html{
<strong>e3dhsp3_motionpoint.hsp</strong>
}htmlに書きましたので、ご覧ください。




→引数
1. [IN] 数値または、変数　：　qid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。
　　このidで識別されるクォータニオンに、
　　回転を加えます。

2. [IN] 数値または、変数　：　deg
　　deg 度だけ、回転を加えます。
　　実数。


バージョン : ver1.0.0.1

%index
E3DRotateQLocalY
クォータニオンを、ローカルなＹ軸に関して、回転します。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2
p1 : [IN] 数値または、変数　：　qid
p2 : [IN] 数値または、変数　：　deg

%inst
クォータニオンを、ローカルなＹ軸に関して、回転します。

現在の姿勢に対して、更に、回転します。

E3DRotateQYと違うのは、
姿勢変換を行う前のＹ軸に関して、
回転できる点です。

使用例は、html{
<strong>e3dhsp3_motionpoint.hsp</strong>
}htmlに書きましたので、ご覧ください。




→引数
1. [IN] 数値または、変数　：　qid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。
　　このidで識別されるクォータニオンに、
　　回転を加えます。

2. [IN] 数値または、変数　：　deg
　　deg 度だけ、回転を加えます。



バージョン : ver1.0.0.1

%index
E3DRotateQLocalZ
クォータニオンを、ローカルなＺ軸に関して、回転します。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2
p1 : [IN] 数値または、変数　：　qid
p2 : [IN] 数値または、変数　：　deg

%inst
クォータニオンを、ローカルなＺ軸に関して、回転します。

現在の姿勢に対して、更に、回転します。

E3DRotateQZと違うのは、
姿勢変換を行う前のＺ軸に関して、
回転できる点です。

使用例は、html{
<strong>e3dhsp3_motionpoint.hsp</strong>
}htmlに書きましたので、ご覧ください。




→引数
1. [IN] 数値または、変数　：　qid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。
　　このidで識別されるクォータニオンに、
　　回転を加えます。

2. [IN] 数値または、変数　：　deg
　　deg 度だけ、回転を加えます。



バージョン : ver1.0.0.1

%index
E3DGetBonePos
ボーンの位置情報を取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　boneno
p3 : [IN] 数値または、変数　：　poskind
p4 : [IN] 数値または、変数　：　motid
p5 : [IN] 数値または、変数　：　frameno
p6 : [OUT] 変数　：　posx
p7 : [OUT] 変数　：　posy
p8 : [OUT] 変数　：　posz
p9 : [IN] 数値または、変数　：　scaleflag

%inst
ボーンの位置情報を取得します。

poskind == 0のときは、ローカル座標(ボーン変形なし)
poskind == 1のときは、グローバル座標
poskind == 2のときは、ローカル座標（ボーン変形あり）
が取得できます。

bonenoには、E3DGetBoneNoByName
で取得した番号を指定してください。


マルチレイヤーモーションを使用する場合は、
この命令は使えません。
E3DGetCurrentBonePosをお使いください。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　boneno
　　ボーンを識別するＩＤ
　　E3DGetBoneNoByNameで取得した
　　ボーンの番号を渡してください。
　　
3. [IN] 数値または、変数　：　poskind
　　ローカル座標と、グローバル座標の
　　どちらを取得するかを指定します。

4. [IN] 数値または、変数　：　motid
　　モーションを識別するＩＤ
　　E3DAddMotionで取得したmkを指定してください。

5. [IN] 数値または、変数　：　frameno
　　モーションのフレーム番号を指定してください。
　　E3DSetNewPose呼び出し時に、現在のフレーム番号が取得できるので、
　　参考にしてください。


6. [OUT] 変数　：　posx
7. [OUT] 変数　：　posy
8. [OUT] 変数　：　posz
　　(posx, posy, posz)に、
　　ボーンの座標が代入されます。
　　実数型の変数。


9. [IN] 数値または、変数　：　scaleflag
　　scaleflagに１をセットすると、
　　E3DSetScaleの結果を反映したposを計算します。
　　０がセットされた場合には、
　　E3DSetScaleの結果が反映されません。



バージョン : ver3.0.3.4で拡張

%index
E3DCreateLine
線を作成して、lineidを取得します。
%group
Easy3D For HSP3 : ライン

%prm
p1,p2,p3,p4,p5
p1 : [IN] 変数　：　pointpos
p2 : [IN] 数値または、変数　：　pointnum
p3 : [IN] 数値または、変数　：　maxpointnum
p4 : [IN] 数値または、変数　：　linekind
p5 : [OUT] 変数　：　lineid

%inst
線を作成して、lineidを取得します。
lineidは、線オブジェクトを一意に識別するための番号です。

E3DCreateLine、E3DDestroyLine
E3DSetLineColor、E3DAddPoint2Line
E3DDeletePointOfLine、E3DSetPointPosOfLine
E3DGetPointPosOfLine
E3DGetNextPointOfLine
E3DGetPrevPointOfLine
に渡すlineidは、この関数で取得したlineidを
使用してください。

pointposには、
html{
<strong>ddim pointpos, pointnum, 3</strong>
}html
で確保したデータを渡してください。

dimではなくて、ddimで確保してください。

pointnumには、点の数を入れてください。
html{
<strong>点の数の最大値は６５５３５です。</strong>
}html
html{
<strong>pointnumが２より小さい場合は、エラーになります。</strong>
}html
pointpos(点の番号,0) にＸ座標、
pointpos(点の番号,１) にＹ座標、 
pointpos(点の番号,２) にＺ座標
を入れて、初期化しておいてください。


作成した線は、
E3DRenderで、描画できます。
hsidの代わりに、lineidを指定してください。


LINE関係の関数の使用例は、
html{
<strong>e3dhsp3_autorun.hsp</strong>
}html
に書きましたので、ご覧ください。




→引数
1. [IN] 変数　：　pointpos
　　線を構成する点の座標を指定してください。
　　メモリの確保の仕方、値のセットの仕方は、
　　左の記述をご覧ください。
　　必ず、ddimでメモリを作成してください。
　　実数型の変数。


2. [IN] 数値または、変数　：　pointnum
　　初期化する点の数を指定してください。
　　pointposのデータを確保する際に使った
　　点の数を渡してください。

3. [IN] 数値または、変数　：　maxpointnum
　　Lineは、E3DAddPoint2Line命令で、
　　点の数を増やすことが可能です。
　　最大何個まで、点の数を増やせるかを
　　指定してください。
　　（点の数の合計です。）
　　
　　ビデオメモリは、pointnumではなくて、
　　maxpointnumでアロケートされます。

4. [IN] 数値または、変数　：　linekind
　　線の種類を指定します。
　　LINELISTの場合は２を、
　　LINESTRIPの場合は３を指定してください。
　　LINELIST, LISTSTRIPについての説明は、
　　<A href="linekind.htm">線の種類の説明</A>をご覧ください。

5. [OUT] 変数　：　lineid
　　作成した線を識別する番号が、代入されます。




バージョン : ver1.0.0.1

%index
E3DDestroyLine
E3DCreateLine で作成した線を削除します。
%group
Easy3D For HSP3 : ライン

%prm
p1
p1 : [IN] 数値または、変数　：　lineid

%inst
E3DCreateLine で作成した線を削除します。
削除したlineidは、
以降、どの命令にも使わないでください。



→引数
1. [IN] 数値または、変数　：　lineid
　　削除する線を識別する番号を渡します。
　　E3DCreateLineで取得した番号を使ってください。


バージョン : ver1.0.0.1

%index
E3DSetLineColor
線の色を設定します。
%group
Easy3D For HSP3 : ライン

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　lineid
p2 : [IN] 数値または、変数　：　A
p3 : [IN] 数値または、変数　：　R　　
p4 : [IN] 数値または、変数　：　G
p5 : [IN] 数値または、変数　：　B

%inst
線の色を設定します。


→引数
1. [IN] 数値または、変数　：　lineid
　　線を識別する番号を渡します。
　　E3DCreateLineで取得した番号を使ってください。

2. [IN] 数値または、変数　：　A
　　透明度を指定します。
　　０から２５５の値を渡してください。

3. [IN] 数値または、変数　：　R　　
4. [IN] 数値または、変数　：　G
5. [IN] 数値または、変数　：　B
　　色の成分(Ｒ，Ｇ，Ｂ)を指定してください。
　　それぞれ、０から２５５の値を渡してください。



バージョン : ver1.0.0.1

%index
E3DAddPoint2Line
線に点を追加し、追加した点を識別するpidを取得します。
%group
Easy3D For HSP3 : ライン

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　lineid
p2 : [IN] 数値または、変数　：　prevpid
p3 : [OUT] 変数　：　pid

%inst
線に点を追加し、追加した点を識別するpidを取得します。

点の数の合計が、
E3DCreateLineに渡したmaxpointnum
より大きくなると、エラーになります。

取得したpidをE3DSetPointPosOfLine関数に
渡して、
付け足した点の座標をセットしてください。





→引数
1. [IN] 数値または、変数　：　lineid
　　線を識別する番号を渡します。
　　E3DCreateLineで取得した番号を使ってください。

2. [IN] 数値または、変数　：　prevpid
　　線の中のどこに、新しい点を追加するかを指定します。
　　prevpidで指定した点の次の点として、
　　新しい点を追加します。
　　prevpidに-2を指定した場合には、線の先頭に、
　　prevpidに-1を指定した場合には、線の最後に
　　新しい点を追加します。

3. [OUT] 変数　：　pid
　　新しく追加した点を識別する番号が、代入されます。
　　pidは、線ごとに固有な値です。



バージョン : ver1.0.0.1

%index
E3DDeletePointOfLine
線の中の点を削除します。
%group
Easy3D For HSP3 : ライン

%prm
p1,p2
p1 : [IN] 数値または、変数　：　lineid
p2 : [IN] 数値または、変数　：　pid

%inst
線の中の点を削除します。


→引数
1. [IN] 数値または、変数　：　lineid
　　線を識別する番号を渡します。
　　E3DCreateLineで取得した番号を使ってください。

2. [IN] 数値または、変数　：　pid
　　削除する点を識別する番号を指定してください。



バージョン : ver1.0.0.1

%index
E3DSetPointPosOfLine
線の中の点の座標をセットします。
%group
Easy3D For HSP3 : ライン

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　lineid
p2 : [IN] 数値または、変数　：　pid
p3 : [IN] 変数　：　pos

%inst
線の中の点の座標をセットします。

座標posは、
html{
<strong>ddim pos, 3</strong>
}html
で確保したメモリを渡してください。

必ず、dimではなくて、ddimでメモリを作成してください。


pos(0)には、Ｘ座標を、
pos(1)には、Ｙ座標を、 
pos(2)には、Ｚ座標を指定してください。




→引数
1. [IN] 数値または、変数　：　lineid
　　線を識別する番号を渡します。
　　E3DCreateLineで取得した番号を使ってください。

2. [IN] 数値または、変数　：　pid
　　点を識別する番号を渡します。

3. [IN] 変数　：　pos
　　点の座標を渡してください。
　　posの確保の仕方、値のセットの仕方は、
　　左の記述をご覧ください。
　　ddimで作成した実数型配列。



バージョン : ver1.0.0.1

%index
E3DGetPointPosOfLine
線の中の点の座標を取得します。
%group
Easy3D For HSP3 : ライン

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　lineid
p2 : [IN] 数値または、変数　：　pid
p3 : [OUT] 変数　：　pos

%inst
線の中の点の座標を取得します。

座標が代入されるposは、
html{
<strong>ddim pos, 3</strong>
}html
で確保したメモリを渡してください。

必ず、dimではなくて、ddimでメモリを作成してください。


pos(0)には、Ｘ座標が、
pos(1)には、Ｙ座標が、 
pos(2)には、Ｚ座標が代入されます。




→引数
1. [IN] 数値または、変数　：　lineid
　　線を識別する番号を渡します。
　　E3DCreateLineで取得した番号を使ってください。

2. [IN] 数値または、変数　：　pid
　　点を識別する番号を渡します。

3. [OUT] 変数　：　pos
　　点の座標が代入される配列を渡してください。
　　posの確保の仕方、値のセットのされ方は、
　　左の記述をご覧ください。
　　ddimで作成した実数型配列。



バージョン : ver1.0.0.1

%index
E3DGetNextPointOfLine
previdで指定した点の、一つ後の点のＩＤを取得します。
%group
Easy3D For HSP3 : ライン

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　lineid
p2 : [IN] 数値または、変数　：　previd
p3 : [OUT] 変数　：　nextid

%inst
previdで指定した点の、一つ後の点のＩＤを取得します。
線は、点を、双方向リストで、格納しています。


一つ後の点が存在しない場合は、
nextid には、負の値が代入されます。




→引数
1. [IN] 数値または、変数　：　lineid
　　線を識別する番号を渡します。
　　E3DCreateLineで取得した番号を使ってください。

2. [IN] 数値または、変数　：　previd
　　点を識別する番号

3. [OUT] 変数　：　nextid
　　previdの点の、一つ後の点のＩＤが代入されます。

　　previd に-1が指定されている場合は、
　　nextidには、先頭の点のIDが代入されます



バージョン : ver1.0.0.1

%index
E3DGetPrevPointOfLine
pidで指定した点の、一つ前の点のＩＤを取得します。
%group
Easy3D For HSP3 : ライン

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　lineid
p2 : [IN] 数値または、変数　：　pid
p3 : [OUT] 変数　：　previd

%inst
pidで指定した点の、一つ前の点のＩＤを取得します。


線は、点を、双方向リストで、格納しています。

一つ前の点が存在しない場合は、
previd には、負の値が代入されます。



→引数
1. [IN] 数値または、変数　：　lineid
　　線を識別する番号を渡します。
　　E3DCreateLineで取得した番号を使ってください。

2. [IN] 数値または、変数　：　pid
　　点を識別するID

3. [OUT] 変数　：　previd
　　pidの点の、一つ後の点のＩＤが代入されます。



バージョン : ver1.0.0.1

%index
E3DWriteDisplay2BMP
バックバッファの内容を、ＢＭＰファイルに保存します。
%group
Easy3D For HSP3 : 出力

%prm
p1,p2
p1 : [IN] 文字列または、文字列の変数　：　filename
p2 : [IN] 変数または、数値　：　scid

%inst
バックバッファの内容を、ＢＭＰファイルに保存します。

filenameには、拡張子を除いた名前を
指定してください。


html{
<strong>E3DInitのmultisamplenumに０以外を指定した場合は、この命令は使えません。
（エラーになります。）
</strong>
}html



→引数
1. [IN] 文字列または、文字列の変数　：　filename
　　出力するＢＭＰ のパス文字列。

　　拡張子を除いたパスを指定してください。
　　この関数で、自動的に、”.bmp”が付加されます。

　　既に同じファイル名が存在している場合は、
　　そのファイルは、上書きされるので注意してください。

2. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。




バージョン : ver1.0.0.1<BR>
      ver3.0.2.4で引数追加

%index
E3DCreateAVIFile
ＡＶＩファイルを初期化して、aviidを取得します。
%group
Easy3D For HSP3 : 出力

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 文字列または、文字列の変数　：　filename
p2 : [IN] 数値または、変数　：　datatype
p3 : [IN] 数値または、変数　：　compkind
p4 : [IN] 数値または、変数　：　framerate
p5 : [IN] 数値または、変数　：　frameleng
p6 : [OUT] 変数　：　aviid
p7 : [IN] 変数または、数値　：　scid

%inst
ＡＶＩファイルを初期化して、aviidを取得します。

aviidは、ＡＶＩファイルを識別するための番号です。

この命令で作成したＡＶＩファイルに対して、
E3DWriteData2AVIFile命令で、
バックバッファの内容を書き込み、
E3DCompleteAVIFile命令で、
終了処理をします。

E3DWriteData2AVIFile命令、
E3DCompleteAVIFile命令には、
E3DCreateAVIFile命令で取得したaviidを
渡してください。


html{
<strong>E3DInitのmultisamplenumに０以外を指定した場合は、この命令は使えません。
（エラーになります。）
</strong>
}html


ＡＶＩ関係の命令の具体的な使用例は、
html{
<strong>e3dhsp3_savedisplay.hsp</strong>
}html
に書きましたので、ご覧ください。



→引数
1. [IN] 文字列または、文字列の変数　：　filename
　　出力するＢＭＰ のパス文字列。

　　拡張子を除いたパスを指定してください。
　　この関数で、自動的に、”.avi”が付加されます。

　　既に同じファイル名が存在している場合は、
　　そのファイルは、上書きされるので注意してください。

2. [IN] 数値または、変数　：　datatype
　　作成するデータの種類を指定します。
　　現バージョンでは、映像のみしか扱わないため、
　　常に１を指定してください。

3. [IN] 数値または、変数　：　compkind
　　圧縮の種類を指定します。
　　０を指定した場合は、
　　　　圧縮なし
　　１を指定した場合は、
　　　　cinepak Codec by Radiusによる圧縮
　　２を指定した場合には、
　　　　Microsoft Video 1による圧縮
　　をします。

4. [IN] 数値または、変数　：　framerate
　　ＡＶＩファイルのフレームレートを指定してください。
　　通常は、スクリプトプログラムのＦＰＳを指定します。
　　６０ＦＰＳで表示している場合は、６０と指定します。


5. [IN] 数値または、変数　：　frameleng
　　ＡＶＩファイルのフレーム数の合計数。
　　frameleng回だけ、E3DWriteData2AVIFileで、
　　データをファイルに書き込むことが出来ます。

6. [OUT] 変数　：　aviid
　　作成したＡＶＩファイルを識別するための
　　番号が代入されます。

7. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。




バージョン : ver1.0.0.1<BR>
      ver3.0.2.4で引数追加<BR>
      

%index
E3DWriteData2AVIFile
バックバッファの内容を、ＡＶＩファイルに書き込みます。
%group
Easy3D For HSP3 : 出力

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　aviid
p2 : [IN] 数値または、変数　：　datatype
p3 : [IN] 変数または、数値　：　scid

%inst
バックバッファの内容を、ＡＶＩファイルに書き込みます。

E3DCreateAVIFileで指定したframeleng回だけ
この命令を呼ぶことが出来ます。

frameleng回を超えた呼び出しは、
エラーとなり、無視されます。




→引数
1. [IN] 数値または、変数　：　aviid
　　AVIファイルを識別するための番号を指定してください。
　　E3DCreateAVIFileで取得した番号を使用してください。

2. [IN] 数値または、変数　：　datatype
　　作成するデータの種類を指定します。
　　現バージョンでは、映像のみしか扱わないため、
　　常に１を指定してください。

3. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。




バージョン : ver1.0.0.1<BR>
      ver3.0.2.4で引数追加<BR>
      

%index
E3DCompleteAVIFile
ＡＶＩファイルの終了処理をします。
%group
Easy3D For HSP3 : 出力

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　aviid
p2 : [IN] 数値または、変数　：　datatype
p3 : [IN] 変数または、数値　：　scid

%inst
ＡＶＩファイルの終了処理をします。

必要な回数、E3DWriteData2AVIFile命令を
呼び出した後に、この命令を呼び出してください。




→引数
1. [IN] 数値または、変数　：　aviid
　　AVIファイルを識別するための番号を指定してください。
　　E3DCreateAVIFileで取得した番号を使用してください。

2. [IN] 数値または、変数　：　datatype
　　作成するデータの種類を指定します。
　　現バージョンでは、映像のみしか扱わないため、
　　常に１を指定してください。

3. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。




バージョン : ver1.0.0.1<BR>
      ver3.0.2.4で引数追加<BR>
      

%index
E3DCameraLookAt
カメラを向きたい方向に、徐々に向けます。
%group
Easy3D For HSP3 : カメラ

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　vecx
p2 : [IN] 数値または、変数　：　vecy
p3 : [IN] 数値または、変数　：　vecz
p4 : [IN] 数値または、変数　：　upflag
p5 : [IN] 数値または、変数　：　divnum

%inst
カメラを向きたい方向に、徐々に向けます。

（vecx, vecy, vecz）には、注視点ではなくて、
向きたい向きのベクトルを指定してください。

例えば、注視点(tx, ty, tz)を向きたい場合は、
E3DGetCameraPos camx, camy, camz
として、カメラの位置を求め、
引き算するだけでＯＫです。
vecx = tx - camx
vecy = ty - camy
vecz = tz - camz
のようにして、計算し、指定してください。


upflagは、E3DLookAtQでの用法と同じです。
upflag == 0 のときは、
上向き方向が、常にＹ軸上方を向くように
制御されます。

upflag == 1 のときは、
上向き方向が、常にＹ軸下方を向くように
制御されます。

upflag == 2 のときは、
上向き方向が、連続した向きをとるように
制御されます。
その結果、宙返りがかのうとなります。

upflag == 3 のときは、
上向き方向を特に制御しません。
上向き方向は、連続した向きをとりますが、
その方向は拘束されません。


divnum引数に、分割数を指定します。
現在の位置と、目標地点との間の間隔を
1 / divnum ずつ、内分して、近づきます。


具体的な使用例は、
html{
<strong>e3dhsp3_CameraOnNaviline.hsp</strong>
}html
に書きましたので、
ご覧ください。

また、このページの最初に書いてある、
カメラの使い方の所も、お読みください。




→引数
1. [IN] 数値または、変数　：　vecx
2. [IN] 数値または、変数　：　vecy
3. [IN] 数値または、変数　：　vecz
　　向きたいベクトルを、指定してください。
　　ベクトルの計算方法は、左記をご覧ください。
　　実数。

4. [IN] 数値または、変数　：　upflag
　　上向き制御方法のモードを指定してください。
　　詳しくは、左記をご覧ください。

5. [IN] 数値または、変数　：　divnum
　　分割数を指定してください。



バージョン : ver1.0.0.1

%index
E3DCameraOnNaviLine
カメラをナビラインに沿って動かします。
%group
Easy3D For HSP3 : カメラ

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11
p1 : [IN] 数値または、変数　：　nlid
p2 : [IN] 数値または、変数　：　mode
p3 : [IN] 数値または、変数　：　roundflag
p4 : [IN] 数値または、変数　：　reverseflag
p5 : [IN] 数値または、変数　：　offsetx
p6 : [IN] 数値または、変数　：　offsety
p7 : [IN] 数値または、変数　：　offsetz
p8 : [IN] 数値または、変数　：　posstep
p9 : [IN] 数値または、変数　：　dirdivnum
p10 : [IN] 数値または、変数　：　upflag
p11 : [IN] [OUT] 変数　：　targetpointid

%inst
カメラをナビラインに沿って動かします。

mode引数に０を指定すると、
カメラの位置だけを制御します。

mode引数に１を指定すると、
位置に加え、向きも制御します。

ループ移動や、反対方向への移動も
サポートしています。


ナビラインの作成には、
GViewer.exeを使うと便利です。
（おちゃっこＬＡＢでダウンロード可能です。）

ナビラインは、地面の高さに作成することが
普通なので、ナビラインからカメラまでの
オフセット値を指定できるようにしました。

例えば、地面から１０００だけ上方を、
カメラを動かしたいときは、
地面の高さにナビラインを作成し、
この関数のオフセット引数に
offsetx = 0 : offsety = 1000 : offsetz = 0
の値を指定すればＯＫです。



具体的な使用例は、
html{
<strong>e3dhsp3_CameraOnNaviline.hsp</strong>
}html
に書きましたので、
ご覧ください。

また、このページの最初に書いてある、
カメラの使い方の所も、お読みください。




→引数
1. [IN] 数値または、変数　：　nlid
　　ナビラインを識別するＩＤ

2. [IN] 数値または、変数　：　mode
　　位置だけを制御する場合は０を、
　　位置と向きを制御する場合は１を指定してください。

3. [IN] 数値または、変数　：　roundflag
　　ナビラインの最後のナビポイントに移動した後、
　　ナビラインの最初のナビポイントの位置を
　　目指すかどうかを示します。

　　１を指定すると、円形のナビラインの場合は、
　　ずっと、ぐるぐる回ることになります。

4. [IN] 数値または、変数　：　reverseflag
　　１を指定すると、
　　ナビラインのポイントを逆順にたどるようになります。


5. [IN] 数値または、変数　：　offsetx
6. [IN] 数値または、変数　：　offsety
7. [IN] 数値または、変数　：　offsetz
　　ナビラインから、カメラ位置までのオフセット値を
　　指定します。
　　詳しくは、左記をご覧ください。
　　実数。

8. [IN] 数値または、変数　：　posstep
　　カメラを一度にどれくらいの距離を移動させるかを
　　指定します。
　　ただし、ナビポイント付近では、
　　posstepより小さな距離しか移動させないことがあります。
　　実数。

9. [IN] 数値または、変数　：　dirdivnum
　　向きたい向きまで、徐々にカメラを向けるための
　　引数です。
　　目標までの角度を1/dirdivnumずつ内分して、
　　徐々に向きを制御します。

10. [IN] 数値または、変数　：　upflag
　　E3DCameraLookAt関数のupflag引数と同じ意味です。
　　詳しくは、E3DCameraLookAtの説明部分を
　　お読みください。


11. [IN] [OUT] 変数　：　targetpointid
　　現在目指しているナビポイントのＩＤを入れます。
　　移動後は、次に目指すべきナビポイントのＩＤが
　　代入されます。

　　ですので、一番最初の呼び出し時のみ、
　　自分でtargetpoinidを指定すれば、
　　あとは、同じ変数を渡すだけで、
　　自動的に、目指すべきポイントのＩＤが
　　代入されていくことになります。

　　targetpointidに、
　　存在しないナビポイントのＩＤを入れた場合は、
　　（例えば-1など）
　　自動的に、目指すべきナビポイントを決定します。
　　


バージョン : ver1.0.0.1

%index
E3DCameraDirUp
カメラの現在向いている方向を、徐々に上の方向に向けます。
%group
Easy3D For HSP3 : カメラ

%prm
p1,p2
p1 : [IN] 数値または、変数　：　deg
p2 : [IN] 数値または、変数　：　divnum

%inst
カメラの現在向いている方向を、徐々に上の方向に向けます。

現バージョンでは、
宙返りはサポートしていません。


具体的な使用例は、
html{
<strong>e3dhsp3_CameraOnNaviline.hsp</strong>
}html
に書きましたので、
ご覧ください。

また、このページの最初に書いてある、
カメラの使い方の所も、お読みください。




→引数
1. [IN] 数値または、変数　：　deg
　　角度。
　　実数。

2. [IN] 数値または、変数　：　divnum
　　deg度の角度を、1/divnumずつ内分して、
　　カメラを、上方向に向けます。



バージョン : ver1.0.0.1

%index
E3DCameraDirDown
カメラの現在向いている方向を、徐々に下の方向に向けます。
%group
Easy3D For HSP3 : カメラ

%prm
p1,p2
p1 : [IN] 数値または、変数　：　deg
p2 : [IN] 数値または、変数　：　divnum

%inst
カメラの現在向いている方向を、徐々に下の方向に向けます。

現バージョンでは、
宙返りはサポートしていません。


具体的な使用例は、
html{
<strong>e3dhsp3_CameraOnNaviline.hsp</strong>
}html
に書きましたので、
ご覧ください。

また、このページの最初に書いてある、
カメラの使い方の所も、お読みください。




→引数
1. [IN] 数値または、変数　：　deg
　　角度。
　　実数。

2. [IN] 数値または、変数　：　divnum
　　deg度の角度を、1/divnumずつ内分して、
　　カメラを、下方向に向けます。



バージョン : ver1.0.0.1

%index
E3DCameraDirRight
カメラの現在向いている方向を、徐々に右の方向に向けます。
%group
Easy3D For HSP3 : カメラ

%prm
p1,p2
p1 : [IN] 数値または、変数　：　deg
p2 : [IN] 数値または、変数　：　divnum

%inst
カメラの現在向いている方向を、徐々に右の方向に向けます。

具体的な使用例は、
html{
<strong>e3dhsp3_CameraOnNaviline.hsp</strong>
}html
に書きましたので、
ご覧ください。

また、このページの最初に書いてある、
カメラの使い方の所も、お読みください。




→引数
1. [IN] 数値または、変数　：　deg
　　角度。
　　実数。

2. [IN] 数値または、変数　：　divnum
　　deg度の角度を、1/divnumずつ内分して、
　　カメラを、右方向に向けます。



バージョン : ver1.0.0.1

%index
E3DCameraDirLeft
カメラの現在向いている方向を、徐々に左の方向に向けます。
%group
Easy3D For HSP3 : カメラ

%prm
p1,p2
p1 : [IN] 数値または、変数　：　deg
p2 : [IN] 数値または、変数　：　divnum

%inst
カメラの現在向いている方向を、徐々に左の方向に向けます。


具体的な使用例は、
html{
<strong>e3dhsp3_CameraOnNaviline.hsp</strong>
}html
に書きましたので、
ご覧ください。

また、このページの最初に書いてある、
カメラの使い方の所も、お読みください。




→引数
1. [IN] 数値または、変数　：　deg
　　角度。
　　実数。

2. [IN] 数値または、変数　：　divnum
　　deg度の角度を、1/divnumずつ内分して、
　　カメラを、左方向に向けます。



バージョン : ver1.0.0.1

%index
E3DCreateFont
フォントを作成し、フォントを識別するＩＤを取得します。
%group
Easy3D For HSP3 : テキスト

%prm
p1,p2,p3,p4,p5,p6,p7,p8
p1 : [IN] 数値または、変数　：　height
p2 : [IN] 数値または、変数　：　width
p3 : [IN] 数値または、変数　：　weight
p4 : [IN] 数値または、変数　：　bItalic
p5 : [IN] 数値または、変数　：　bUnderline
p6 : [IN] 数値または、変数　：　bStrikeout
p7 : [IN] 文字列または、文字列の変数　：　fontname
p8 : [OUT] 変数　：　fontid

%inst
フォントを作成し、フォントを識別するＩＤを取得します。

具体的な使用例は、
html{
<strong>e3dhsp3_font.hsp</strong>
}html
に書きましたので、ご覧ください。




→引数
1. [IN] 数値または、変数　：　height
　　フォントの文字セルまたは文字の高さを論理単位で指定します。
　　文字の高さとは、
　　文字セルの高さから内部レディング（アクセント記号などのためのスペース）の
　　高さを引いたものです。
　　要求されたサイズを超えない最大のフォントを探して処理されます。

2. [IN] 数値または、変数　：　width
　　フォントの平均文字幅を論理単位で指定します。
　　0 を指定すると、条件に最も近い値が選択されます。
　　条件に最も近い値は、利用可能な各フォントの現在のデバイスでの
　　縦横比とデジタル化された縦横比の差の絶対値を比較することにより
　　決定されます。

3. [IN] 数値または、変数　：　weight
　　フォントの太さを表す 0 から 1000 までの範囲内の値を指定します。
　　たとえば、400 を指定すると標準の太さになり、
　　700 を指定すると太字になります。
　　0 を指定すると、既定の太さが選択されます。

4. [IN] 数値または、変数　：　bItalic
　　斜体にするかどうかを指定します。
　　１ を指定すると、斜体になります。 

5. [IN] 数値または、変数　：　bUnderline
　　下線を付けるかどうかを指定します。
　　１ を指定すると、下線付きになります。

6. [IN] 数値または、変数　：　bStrikeout
　　取り消し線を付けるかどうかを指定します。
　　１ を指定すると、取り消し線が付きます。

7. [IN] 文字列または、文字列の変数　：　fontname
　　フォントの名前が入った 文字列を指定します。
　　文字列の長さは、 31 文字以下にしなければなりません。

8. [OUT] 変数　：　fontid
　　作成したフォントを識別するための
　　番号が代入されます。



バージョン : ver1.0.0.1

%index
E3DDrawTextByFontID
E3DCreateFontで作成したフォントにより、指定した位置、色で、テキストを表示します。
%group
Easy3D For HSP3 : テキスト

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9
p1 : [IN] 変数または、数値　：　scid
p2 : [IN] 数値または、変数　：　fontid
p3 : [IN] 数値または、変数　：　posx
p4 : [IN] 数値または、変数　：　posy
p5 : [IN] 文字列または、文字列の変数　：　textstr
p6 : [IN] 数値または、変数　：　a
p7 : [IN] 数値または、変数　：　r
p8 : [IN] 数値または、変数　：　g
p9 : [IN] 数値または、変数　：　b

%inst
E3DCreateFontで作成したフォントにより、指定した位置、色で、テキストを表示します。




→引数
1. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。

2. [IN] 数値または、変数　：　fontid
　　E3DCreateFontで作成した、フォントの番号を指定します。

3. [IN] 数値または、変数　：　posx
4. [IN] 数値または、変数　：　posy
　　テキストをする位置を　（x, y）＝（posx, posy）で指定します。

5. [IN] 文字列または、文字列の変数　：　textstr
　　表示したい文字列を指定します。

6. [IN] 数値または、変数　：　a
7. [IN] 数値または、変数　：　r
8. [IN] 数値または、変数　：　g
9. [IN] 数値または、変数　：　b
　　文字の透明度と色を（透明度, 赤, 緑, 青）＝（a, r, g, b）で
　　指定します。



バージョン : ver1.0.0.1

%index
E3DDrawTextByFontIDWithCnt
カウンター制御で、一定間隔で、徐々に文字列を表示します。
%group
Easy3D For HSP3 : テキスト

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11
p1 : [IN] 変数または、数値　：　scid
p2 : [IN] 数値または、変数　：　fontid
p3 : [IN] 数値または、変数　：　posx
p4 : [IN] 数値または、変数　：　posy
p5 : [IN] 文字列または、文字列の変数　：　textstr
p6 : [IN] 数値または、変数　：　a
p7 : [IN] 数値または、変数　：　r
p8 : [IN] 数値または、変数　：　g
p9 : [IN] 数値または、変数　：　b
p10 : [IN] 数値または、変数　：　eachcnt
p11 : [IN] 数値または、変数　：　curcnt

%inst
カウンター制御で、一定間隔で、徐々に文字列を表示します。

eachcnt引数に、一文字当たりの待機期間を
指定します。
この値と、curcntに指定したカウンターの値を
比較して、文字を表示します。

curcntには、通常、この命令を呼び出すたびに、
１ずつ増えるカウンターの値を指定します。


例えば、eachcntに１０を指定した場合には、
一文字当たり１０カウントだけ待機するので、
１文字目は、curcntが１０になるまで表示されません。
２文字目は、curcntが２０になるまで表示されません。

と、このように、curcntの値が、増えるに従って、
徐々に、表示文字長が増えていきます。


現バージョンでは、半角カタカナには、
対応していません。


具体的な使用例は、
e3dhsp3_fontWithCnt.hsp
に書きましたので、ご覧ください。




→引数
1. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。

2. [IN] 数値または、変数　：　fontid
　　E3DCreateFontで作成した、フォントの番号を指定します。

3. [IN] 数値または、変数　：　posx
4. [IN] 数値または、変数　：　posy
　　テキストをする位置を　（x, y）＝（posx, posy）で指定します。

5. [IN] 文字列または、文字列の変数　：　textstr
　　表示したい文字列を指定します。

6. [IN] 数値または、変数　：　a
7. [IN] 数値または、変数　：　r
8. [IN] 数値または、変数　：　g
9. [IN] 数値または、変数　：　b
　　文字の透明度と色を（透明度, 赤, 緑, 青）＝（a, r, g, b）で
　　指定します。

10. [IN] 数値または、変数　：　eachcnt
　　一文字当たり、どれくらい待ってから表示するかを指定します。

11. [IN] 数値または、変数　：　curcnt
　　現在のカウンターを指定します。




バージョン : ver1.0.0.1

%index
E3DDrawTextByFontIDWithCnt2
カウンター制御で、文字ごとに表示タイミングを指定して、文字列を表示します。
%group
Easy3D For HSP3 : テキスト

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12
p1 : [IN] 変数または、数値　：　scid
p2 : [IN] 数値または、変数　：　fontid
p3 : [IN] 数値または、変数　：　posx
p4 : [IN] 数値または、変数　：　posy
p5 : [IN] 文字列または、文字列の変数　：　textstr
p6 : [IN] 数値または、変数　：　a
p7 : [IN] 数値または、変数　：　r
p8 : [IN] 数値または、変数　：　g
p9 : [IN] 数値または、変数　：　b
p10 : [IN] 配列の変数　：　cntarray
p11 : [IN] 数値または、変数　：　arrayleng
p12 : [IN] 数値または、変数　：　curcnt

%inst
カウンター制御で、文字ごとに表示タイミングを指定して、文字列を表示します。


cntarray引数に、
文字ごとの表示タイミングを指定した配列を
指定してください。

cntarrayの長さは、
E3DGetCharacterNum関数で、
textstrの文字数を取得して、決定してください。


ＨＳＰでは、文字列中に、'\n'が見つかった場合には、自動的に、&quot;\r\n&quot;に変換されるようです。
つまり、改行マーク１個に付き、１文字増えることになりますので、ご注意ください。


cntarray中の表示タイミングと、
curcntに指定したカウンターの値を比べて、
文字を表示するかどうかを決定します。


cntarray(0)に１０を、
cntarray(1)に２０を指定した場合には、
curcntが１０になったときに１文字目が表示され、
curcntが２０になったときに２文字目が表示されます。

cntarray(1)にcntarray(0)より小さな値を入れることも可能です。
その場合は、２文字目は１文字目よりも後で、
表示されることになります。

\nを文字列中に含む場合は、
自動的に挿入される\rの分の表示タイミングも
指定しないといけませんので、ご注意ください。


現バージョンでは、半角カタカナには、
対応していません。


具体的な使用例は、
e3dhsp3_fontWithCnt.hsp
に書きましたので、ご覧ください。





→引数
1. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。

2. [IN] 数値または、変数　：　fontid
　　E3DCreateFontで作成した、フォントの番号を指定します。

3. [IN] 数値または、変数　：　posx
4. [IN] 数値または、変数　：　posy
　　テキストをする位置を　（x, y）＝（posx, posy）で指定します。

5. [IN] 文字列または、文字列の変数　：　textstr
　　表示したい文字列を指定します。

6. [IN] 数値または、変数　：　a
7. [IN] 数値または、変数　：　r
8. [IN] 数値または、変数　：　g
9. [IN] 数値または、変数　：　b
　　文字の透明度と色を（透明度, 赤, 緑, 青）＝（a, r, g, b）で
　　指定します。

10. [IN] 配列の変数　：　cntarray
　　文字数分の要素数を持つ配列変数を指定します。
　　それぞれの要素には、文字の表示タイミングを指定します。

11. [IN] 数値または、変数　：　arrayleng
　　cntarray中の要素数を指定します。

12. [IN] 数値または、変数　：　curcnt
　　現在のカウンターを指定します。




バージョン : ver1.0.0.1

%index
E3DGetCharacterNum
 １バイト文字、２バイト文字を判別して、textstr中の文字数を取得します。
%group
Easy3D For HSP3 : テキスト

%prm
p1,p2
p1 : [IN] 文字列または、文字列の変数　：　textstr
p2 : [OUT] 変数　：　charanum

%inst
 １バイト文字、２バイト文字を判別して、textstr中の文字数を取得します。


ＨＳＰでは、文字列中に、'\n'が見つかった場合には、自動的に、&quot;\r\n&quot;に変換されるようです。
つまり、改行マーク１個に付き、１文字増えることになりますので、ご注意ください。


現バージョンでは、半角カタカナには、
対応していません。



→引数
1. [IN] 文字列または、文字列の変数　：　textstr
　　調べたい文字列を指定します。

2. [OUT] 変数　：　charanum
　　文字の数が代入されます。



バージョン : ver1.0.0.1

%index
E3DDestroyFont
E3DCreateFontで作成したフォントを、
削除します。
%group
Easy3D For HSP3 : テキスト

%prm
p1
p1 : [IN] 数値または、変数　：　fontid

%inst
E3DCreateFontで作成したフォントを、
削除します。




→引数
1. [IN] 数値または、変数　：　fontid
　　E3DCreateFontで作成した、フォントの番号を指定します。



バージョン : ver1.0.0.1

%index
E3DSlerpQ
クォータニオンを、球面線形補間します。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　startqid
p2 : [IN] 数値または、変数　：　endqid
p3 : [IN] 数値または、変数　：　t
p4 : [IN] 数値または、変数　：　resqid

%inst
クォータニオンを、球面線形補間します。

startqid, endqid, resqid には、
E3DCreateQ で取得した、ＩＤを渡してください。

resqidで識別されるクォータニオンに、
startqid, endqidの間の姿勢を、
t の比率に基づいて補間計算し、
セットします。

t の値が、0.0 から1.0の間になるように、指定してください。

t が0.0のときは、
startqidと同じ姿勢がセットされます。

t が1.0のときは、
endqidと同じ姿勢がセットされます。

具体的な使い方は、
html{
<strong>e3dhsp3_Spline.hsp</strong>
}html
をご覧ください。




→引数
1. [IN] 数値または、変数　：　startqid
2. [IN] 数値または、変数　：　endqid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。
　　startqidとendqidのクォータニオンの間の姿勢を、
　　補間計算して、resqidのクォータニオンにセットします。


3. [IN] 数値または、変数　：　t
　　補間計算するクォータニオンのstartqidからの比率を指定してください。
　　t の値は、0.0から1.0の間の値を指定してください。
　　実数。

4. [IN] 数値または、変数　：　resqid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。
　　計算結果が、resqidのクォータニオンに代入されます。



バージョン : ver1.0.0.1

%index
E3DSquadQ
クォータニオンを、スプライン補間します。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 数値または、変数　：　befqid
p2 : [IN] 数値または、変数　：　startqid
p3 : [IN] 数値または、変数　：　endqid
p4 : [IN] 数値または、変数　：　aftqid
p5 : [IN] 数値または、変数　：　t
p6 : [IN] 数値または、変数　：　resqid

%inst
クォータニオンを、スプライン補間します。

befqid, startqid, endqid, aftqid, resqidには、
E3DCreateQ で取得した、ＩＤを渡してください。

resqidで識別されるクォータニオンに、
startqid, endqidの間の姿勢を、
t の比率に基づいて補間計算し、
セットします。

befqidには、startqidの一つ前の姿勢を、
aftqidには、endqidの一つ後の姿勢を、
セットしておいてください。

この関数は、大きく姿勢が変化する場合には、
向いていません。
大きく変化する姿勢を補完する場合には、
E3DSlerpQを使用してください。
または、２つを組み合わせて、使用してください。


t の値が、0.0 から1.0の間になるように、指定してください。

t が0.0のときは、
startqidと同じ姿勢がセットされます。

t が1.0のときは、
endqidと同じ姿勢がセットされます。


具体的な使い方は、
html{
<strong>e3dhsp3_Spline.hsp</strong>
}html
をご覧ください。




→引数
1. [IN] 数値または、変数　：　befqid
2. [IN] 数値または、変数　：　startqid
3. [IN] 数値または、変数　：　endqid
4. [IN] 数値または、変数　：　aftqid

　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。
　　startqidとendqidのクォータニオンの間の姿勢を、
　　補間計算して、resqidのクォータニオンにセットします。

　　befqidには、startqidの一つ前の姿勢を、
　　aftqidには、endqidの一つ後の姿勢を、
　　セットしておいてください。

5. [IN] 数値または、変数　：　t
　　補間計算するクォータニオンのstartqidからの比率を指定してください。
　　t の値は、0.0から1.0の間の値を指定してください。


6. [IN] 数値または、変数　：　resqid
　　クォータニオンを識別するＩＤ
　　E3DCreateQで取得したidを渡してください。
　　計算結果が、resqidのクォータニオンに代入されます。





バージョン : ver1.0.0.1

%index
E3DSplineVec

位置座標を、スプライン補間計算します。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 変数　：　befpos
p2 : [IN] 変数　：　startpos
p3 : [IN] 変数　：　endpos
p4 : [IN] 変数　：　aftpos
p5 : [IN] 数値または、変数　：　t
p6 : [OUT] 変数　：　respos

%inst

位置座標を、スプライン補間計算します。

befpos, startpos, endpos, aftpos, resposには、
それぞれ、
ddim befpos, 3
ddim startpos, 3
ddim endpos, 3
ddim aftpos, 3
ddim respos, 3
で、確保した配列を渡してください。

必ず、dimではなくて、ddimでメモリを確保してください。


配列の第１要素（例えばbefpos(0)）には、
Ｘ座標、
配列の第２要素（例えばbefpos(1)）には、
Ｙ座標、
配列の第３要素（例えばbefpos(2)）には、
Ｚ座標、
をセットしておいてください。


startposとendposの間の座標を、
tvの比率に基づいて、
スプライン補間計算して、
resposに代入します。

befposには、startposの一つ前の座標を、
aftposには、endposの一つ後の座標を
セットしておいてください。


t の値が、0.0 から1.0の間になるように、指定してください。

t が0.0のときは、
startposと同じ位置がセットされます。

t が1.0のときは、
endposと同じ位置がセットされます。


具体的な使い方は、
html{
<strong>e3dhsp3_Spline.hsp</strong>
}html
をご覧ください。




→引数
1. [IN] 変数　：　befpos
2. [IN] 変数　：　startpos
3. [IN] 変数　：　endpos
4. [IN] 変数　：　aftpos
　　計算の元となる、位置座標の配列を指定してください。
　　詳しくは、左記をご覧ください。
　　ddimで作成した実数型配列。

5. [IN] 数値または、変数　：　t
　　補間計算する位置座標のstartposからの比率を指定してください。
　　t の値は、0.0から1.0の間の値を指定してください。

6. [OUT] 変数　：　respos
　　計算結果が、代入される配列を指定してください。
　　ddimで作成した実数型配列。


バージョン : ver1.0.0.1

%index
E3DDbgOut
dbg.txtに、指定した文字列を出力します。
%group
Easy3D For HSP3 : デバッグ

%prm
p1
p1 : [IN] 文字列または、文字列変数　：　dbgstr

%inst
dbg.txtに、指定した文字列を出力します。

この命令を呼ぶ前に、
一回だけE3DEnableDbgFileを
呼ぶ必要があります。




→引数
1. [IN] 文字列または、文字列変数　：　dbgstr
　　出力文字列を指定してください。



バージョン : ver1.0.0.1

%index
E3DGetDiffuse
任意のパーツの任意の頂点の、diffuse色を取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　vertno
p4 : [OUT] 変数　：　r
p5 : [OUT] 変数　：　g
p6 : [OUT] 変数　：　b

%inst
任意のパーツの任意の頂点の、diffuse色を取得します。






→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ
　　-1を指定すると、ビルボードの色を取得できます。

2. [IN] 数値または、変数　：　partno
　　取得したいパーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。

　　hsidに-1を指定した場合は、
　　E3DCreateBillboardで取得した、
　　ビルボードidを渡してください。

3. [IN] 数値または、変数　：　vertno
　　色を取得したい頂点の番号を指定します。

4. [OUT] 変数　：　r
5. [OUT] 変数　：　g
6. [OUT] 変数　：　b
　　　指定した頂点のdiffuse色が、
　　　RGB = ( r, g, b )に代入されます。
　　　r, g, bそれぞれ、０から２５５の値が代入されます。



バージョン : ver1.0.0.1

%index
E3DGetAmbient
任意のパーツの任意の頂点の、ambient色を取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　vertno
p4 : [OUT] 変数　：　r
p5 : [OUT] 変数　：　g
p6 : [OUT] 変数　：　b

%inst
任意のパーツの任意の頂点の、ambient色を取得します。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ
　　-1を指定すると、ビルボードの色を取得できます。

2. [IN] 数値または、変数　：　partno
　　取得したいパーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。

　　hsidに-1を指定した場合は、
　　E3DCreateBillboardで取得した、
　　ビルボードidを渡してください。

3. [IN] 数値または、変数　：　vertno
　　色を取得したい頂点の番号を指定します。

4. [OUT] 変数　：　r
5. [OUT] 変数　：　g
6. [OUT] 変数　：　b
　　　指定した頂点のambient色が、
　　　RGB = ( r, g, b )に代入されます。
　　　r, g, bそれぞれ、０から２５５の値が代入されます。



バージョン : ver1.0.0.1

%index
E3DGetSpecular
任意のパーツの任意の頂点の、specular色を取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　vertno
p4 : [OUT] 変数　：　r
p5 : [OUT] 変数　：　g
p6 : [OUT] 変数　：　b

%inst
任意のパーツの任意の頂点の、specular色を取得します。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ
　　-1を指定すると、ビルボードの色を取得できます。

2. [IN] 数値または、変数　：　partno
　　取得したいパーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。

　　hsidに-1を指定した場合は、
　　E3DCreateBillboardで取得した、
　　ビルボードidを渡してください。

3. [IN] 数値または、変数　：　vertno
　　色を取得したい頂点の番号を指定します。

4. [OUT] 変数　：　r
5. [OUT] 変数　：　g
6. [OUT] 変数　：　b
　　　指定した頂点のspecular色が、
　　　RGB = ( r, g, b )に代入されます。
　　　r, g, bそれぞれ、０から２５５の値が代入されます。



バージョン : ver1.0.0.1

%index
E3DGetAlpha
任意のパーツの透明度を取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　vertno
p4 : [OUT] 変数　：　alpha

%inst
任意のパーツの透明度を取得します。


→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ
　　-1を指定すると、ビルボードの色を取得できます。

2. [IN] 数値または、変数　：　partno
　　取得したいパーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。

　　hsidに-1を指定した場合は、
　　E3DCreateBillboardで取得した、
　　ビルボードidを渡してください。

3. [IN] 数値または、変数　：　vertno
　　この引数は、現在使用されていません。
　　適当な数字を入れてください。

4. [OUT] 変数　：　alpha
　　指定したパーツの透明度が、０～２５５の値で代入されます。


バージョン : ver1.0.0.1

%index
E3DSaveQuaFile
読み込み済みのモーションを、ファイルに保存します。
%group
Easy3D For HSP3 : 出力

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　mkid
p3 : [IN] 文字列または、文字列変数　：　filename
p4 : [IN] 数値または、変数　：　quatype

%inst
読み込み済みのモーションを、ファイルに保存します。

quatype引数でファイルのタイプを指定します。
e3dhsp3.asで定義されているQUATYPE_ で始まる定数を使います。
QUATYPE_NUMはボーンの階層構造から計算した番号を基準にファイルを作ります。
QUATYPE_NAMEはボーンの名前を基準にファイルを作ります。

ver5.0.3.8より前のバージョンのquaファイルはQUATYPE_NUMです。




→引数
1. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。

2. [IN] 数値または、変数　：　mkid
　　モーションを識別する番号を指定してください。

3. [IN] 文字列または、文字列変数　：　filename
　　保存ファイル名（パス）を指定してください。

4. [IN] 数値または、変数　：　quatype
　　QUATYPE_ で始まる定数を指定。
　　デフォルト値はQUATYPE_NAME。




バージョン : ver1.0.0.1<BR>
      ver5.0.3.8で引数追加<BR>
      

%index
E3DSaveSigFile
形状データをsigファイルに保存します。
%group
Easy3D For HSP3 : 出力

%prm
p1,p2
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 文字列または、文字列変数　：　filename

%inst
形状データをsigファイルに保存します。
html{
<strong></strong>
}html



→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 文字列または、文字列変数　：　filename
　　保存ファイル名（パス）を指定してください。




バージョン : ver1.0.0.1

%index
E3DSetMipMapParams
ミップマップのパラメータを設定します。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1,p2
p1 : [IN] 数値または、変数　：　miplevels
p2 : [IN] 数値または、変数　：　mipfilter

%inst
ミップマップのパラメータを設定します。

この関数を呼んだ後に実行される
全てのE3DSigLoadに影響します。


この命令を一度も呼ばなかった場合は、
miplevelに０、
mipfilterに
D3DX_FILTER_TRIANGL|D3DX_FILTER_MIRROR
を指定したのと同じになります。





→引数

1. [IN] 数値または、変数　：　miplevels
　　要求されるミップ レベルの数。
　　この値が 0 または D3DX_DEFAULT の場合は、
　　完全なミップマップ チェーンが作成されます。 

2. [IN] 数値または、変数　：　mipfilter
　　イメージをフィルタリングする方法を制御する 1 つ以上のフラグの組み合わせ。
　　このパラメータに D3DX_DEFAULT を指定することは、
　　D3DX_FILTER_BOX を指定することと等しい。 
　　有効なそれぞれのフィルタに、次のフラグの 1 つが含まれていなければならない。

　　D3DX_FILTER_BOX 
　　各ピクセルは、ソース イメージ内の 2 × 2 (× 2) のサイズのボックスに含まれ
　　ピクセルの平均を算出することにより計算される。
　　このフィルタは、ミップマップを使用する場合のように、
　　転送先のディメンジョンがソースの半分の場合のみ機能する。 

　　D3DX_FILTER_LINEAR 
　　各転送先ピクセルは、最も近い 4 つのピクセルをソース イメージからサンプリング
　　することにより計算される。
　　このフィルタは、両軸のスケールが 2 未満の場合に最も効率よく機能する。


　　D3DX_FILTER_NONE 
　　スケーリングまたはフィルタリングを行わない。
　　ソース イメージの境界の外側にあるピクセルは透明な黒であると見なされる。


　　D3DX_FILTER_POINT 
　　各転送先ピクセルは、最も近いピクセルをソース イメージからサンプリング
　　することにより計算される。 

　　D3DX_FILTER_TRIANGLE 
　　ソース イメージ内の各ピクセルが、転送先イメージに等しく反映される。
　　これは、最も処理に時間のかかるフィルタである。 
　　さらに、OR 演算子を使用して、有効なフィルタと共に次に示すオプションの
　　フラグを 0 個以上指定できる。 

　　D3DX_FILTER_MIRROR 
　　このフラグを指定すると、D3DX_FILTER_MIRROR_U、D3DX_FILTER_MIRROR_V、
　　および D3DX_FILTER_MIRROR_W フラグを指定したことになる。 

　　D3DX_FILTER_MIRROR_U 
　　u 軸のテクスチャのエッジから離れたピクセルを、ラッピングせずにミラーリング
　　するよう指定する。 

　　D3DX_FILTER_MIRROR_V 
　　v 軸のテクスチャのエッジから離れたピクセルを、
　　ラッピングせずにミラーリングするよう指定する。 

　　D3DX_FILTER_MIRROR_W 
　　w 軸のテクスチャのエッジから離れているピクセルを、
　　ラッピングせずにミラーリングするよう指定する。 

　　D3DX_FILTER_DITHER 
　　結果として作成されたイメージを、4x4 の順序付きディザ アルゴリズム
　　を使ってディザリングする必要がある。 


バージョン : ver1.0.0.1

%index
E3DPickVert
画面上の２Ｄ座標を指定して、その座標に、一番近い頂点を検出する関数です。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9,p10
p1 : [IN] 変数または、数値　：　scid
p2 : [IN] 数値または、変数　：　hsid
p3 : [IN] 数値または、変数　：　posx
p4 : [IN] 数値または、変数　：　posy
p5 : [IN] 数値または、変数　：　rangex
p6 : [IN] 数値または、変数　：　rangey
p7 : [OUT] 変数　：　pickpartarray
p8 : [OUT] 変数　：　pickvertarray
p9 : [IN] 数値または、変数　：　pickarrayleng
p10 : [OUT] 変数　：　getnum

%inst
画面上の２Ｄ座標を指定して、その座標に、一番近い頂点を検出する関数です。

全く同じ座標の頂点が見つかった場合には、
複数のパーツ、複数の頂点の番号を
取得するするようになっています。
同じ座標でも、ＵＶだけが違う頂点などが
存在するので、複数取得できるようになっています。

取得した情報の数が、getnumに代入されます。
該当するデータが無い場合は、getnumに０が
代入されます。

getnumが０出ない場合には、
maxindex = getnum - 1とすると
pickpartarray(0) から、pickpartarray(maxindex)
までに、パーツの番号が代入されます。
pickvertarray(0)から、pickvertarray(maxindex)
までに、頂点の番号が代入されます。


pickarrayleng変数に、
一度に取得できる情報の数をセットした後、
html{
<strong>dim pickpartarray, pickarrayleng</strong>
}html
html{
<strong>dim pickvertarray, pickarrayleng</strong>
}html
で、メモリを確保してください。

rangex, rangey引数を調整することで、
検出の感度を調整できます。



この関数の使用例は、
html{
<strong>e3dhsp3_pickvert.hsp</strong>
}html
に書きましたので、ご覧ください。




→引数
1. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。

2. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

3. [IN] 数値または、変数　：　posx
4. [IN] 数値または、変数　：　posy
　　画面上の２Ｄ座標を（posx, posy）で指定します。

5. [IN] 数値または、変数　：　rangex
6. [IN] 数値または、変数　：　rangey
　　検出距離を指定します。
　　rangexには、Ｘ座標がどれだけ離れた点まで検索するかを指定します。
　　rangeyには、Ｙ座標がどれだけ離れた点まで検索するかを指定します。
　　大きい値を指定すると、
　　指定した座標より遠い頂点まで検索します。

　　感度の調整に使用してください。

7. [OUT] 変数　：　pickpartarray
8. [OUT] 変数　：　pickvertarray
　　指定した座標に一番近いパーツ番号と、
　　頂点の番号がgetnum個だけ、代入されます。

9. [IN] 数値または、変数　：　pickarrayleng
　　pickpartarray, pickvertarrayの配列の大きさを指定してください。
　　dim 命令で使用した値を渡してください。
　　詳しくは、左記をご覧ください。

10. [OUT] 変数　：　getnum
　　pickpartarray, pickvertarrayに、何個の値を代入したかを
　　取得できます。

　　例えば、getnum が３だった場合には、
　　pickpartarray(0), pickpartarray(1), pickpartarray(2)に値が代入されています。
　　


バージョン : ver1.0.0.1

%index
E3DGetCullingFlag
この関数は、現在、機能していません。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　vertno
p4 : [OUT] 変数　：　viewcullflag
p5 : [OUT] 変数　：　revcullflag

%inst
この関数は、現在、機能していません。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　partno
　　取得したいパーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。


3. [IN] 数値または、変数　：　vertno
　　調べたい頂点の番号を指定してください。

4. [OUT] 変数　：　viewcullflag
　　視野外カリングされているとき１が、
　　されていないとき０が代入されます。

5. [OUT] 変数　：　revcullflag
　　背面カリングされているとき１が、
　　されていないとき０が代入されます。



バージョン : ver1.0.0.1

%index
E3DGetOrgVertNo
mqoファイル内での頂点番号を取得する。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　vertno
p4 : [OUT] 変数　：　orgnoarray
p5 : [IN] 数値または、変数　：　arrayleng
p6 : [OUT] 変数　：　getnum

%inst
mqoファイル内での頂点番号を取得する。

パーツ内の頂点の数は、E3DGetVertNumOfPartのvertnumで取得されます。

E3Dのプログラムでは、頂点の番号に、０から(vertnum - 1)の頂点の番号を使用できます。

この頂点の番号は、表示用の最適化をした後の、頂点の番号で、
rok, mqoファイル内での頂点の番号と異なる場合があります。

この関数は、最適化後の頂点番号に対応する、rok,mqoファイル内での頂点の番号を取得します。

mqoの場合は、
mqoファイル中の、パーツごとの頂点の出現順番を返します。（０から始まる数字）

rokの場合は、
rokファイル中の、１から始まる頂点のインデックスを返します。
rokの場合は、パーツごとの番号ではなくて、
頂点全体を通しての番号ですので
注意してください。


指定した頂点と同じ座標を持つ頂点の番号が代入されるので、場合によっては、複数取得されます。

この関数は、E3Dのプログラムから、im2ファイルを作る際などに使用することを想定して、作りました。

地面データには使わないでください。


この関数を使う前に、
html{
<strong>E3DChkIM2Status関数で、引数に
１が返されることを確認してください。</strong>
}html
０が返された場合は、sigファイルを新しい形式にコンバートする必要があります。
コンバーターについては、
(Link http://www5d.biglobe.ne.jp/~ochikko/rdb2_im2file.htm )SigConvForIM2のページをご覧ください。


orgarraylengに、取得できる情報の数をセットして、
html{
<strong>dim orgnoarray, orgarrayleng</strong>
}html
で、メモリを確保してください。





→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　partno
　　取得したいパーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。


3. [IN] 数値または、変数　：　vertno
　　調べたい頂点の番号を指定してください。


4. [OUT] 変数　：　orgnoarray
　　この配列に、元データの頂点の番号が代入されます。
　　maxindex = getnum - 1とすると
　　orgnoarray(0) から、orgnoarray(maxindex)までに
　　頂点の番号が代入されます。

5. [IN] 数値または、変数　：　arrayleng
　　orgnoarrayをdimしたときの、配列の大きさを指定してください。


6. [OUT] 変数　：　getnum
　　orgnoarrayに代入した情報の数を取得できます。



バージョン : ver1.0.0.1

%index
E3DChkIM2Status
影響マップ情報（im2）が、利用可能かどうかを調べます。
%group
Easy3D For HSP3 : ボーン影響

%prm
p1,p2
p1 : [IN] 数値または、変数　：　hsid
p2 : [OUT] 変数　：　status

%inst
影響マップ情報（im2）が、利用可能かどうかを調べます。

status引数に１が返された場合は、
利用可能。
０が返された場合は、
利用不可能です。

０が返された場合は、sigファイルを新しい形式にコンバートする必要があります。
コンバーターについては、
(Link http://www5d.biglobe.ne.jp/~ochikko/rdb2_im2file.htm )SigConvForIM2のページをご覧ください。


E3DGetOrgVertNo, E3DLoadIM2File,
E3DSaveIM2File関数などを使用する前に、
このE3DChkIM2Status関数で、
影響マップファイルの機能が使えるかどうかを
調べてください。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ


2. [OUT] 変数　：　status
　　影響マップ情報が、利用可能かどうかが代入されます。


バージョン : ver1.0.0.1

%index
E3DLoadIM2File
hsidで識別されるモデルデータに、im2ファイルのボーン影響情報をセットします。
%group
Easy3D For HSP3 : ボーン影響

%prm
p1,p2
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 文字列または、文字列の変数　：　fname

%inst
hsidで識別されるモデルデータに、im2ファイルのボーン影響情報をセットします。

この関数を使う前に、
html{
<strong>E3DChkIM2Status関数で、引数に
１が返されることを確認してください。</strong>
}html
０が返された場合は、sigファイルを新しい形式にコンバートする必要があります。
コンバーターについては、
(Link http://www5d.biglobe.ne.jp/~ochikko/rdb2_im2file.htm )SigConvForIM2のページをご覧ください。






→引数
1. [IN] 数値または、変数　：　hsid
　　hsidで識別されるモデルデータに、
　　im2ファイルのボーン影響情報をセットします。

2. [IN] 文字列または、文字列の変数　：　fname
　　*.im2 のパス文字列。



バージョン : ver1.0.0.1

%index
E3DSaveIM2File
hsidで識別されるモデルデータの影響マップ情報を、im2ファイルに書き出します。
%group
Easy3D For HSP3 : ボーン影響出力

%prm
p1,p2
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 文字列または、文字列の変数　：　fname

%inst
hsidで識別されるモデルデータの影響マップ情報を、im2ファイルに書き出します。


この関数を使う前に、
html{
<strong>E3DChkIM2Status関数で、引数に
１が返されることを確認してください。</strong>
}html
０が返された場合は、sigファイルを新しい形式にコンバートする必要があります。
コンバーターについては、
(Link http://www5d.biglobe.ne.jp/~ochikko/rdb2_im2file.htm )SigConvForIM2のページをご覧ください。





→引数
1. [IN] 数値または、変数　：　hsid
　　hsidで識別されるモデルデータの影響マップ情報を、
　　im2ファイルに書き出します。

2. [IN] 文字列または、文字列の変数　：　fname
　　*.im2 のパス文字列。



バージョン : ver1.0.0.1

%index
E3DGetJointNum
ジョイントの総数を取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2
p1 : [IN] 数値または、変数　：　hsid
p2 : [OUT] 変数　：　jointnum

%inst
ジョイントの総数を取得します。

E3DGetJointInfoで詳細情報を取得する際の、
配列データの大きさの決定などに、
使用してください。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [OUT] 変数　：　jointnum
　　ジョイントの総数が、代入されます。



バージョン : ver1.0.0.1

%index
E3DGetJointInfo
ジョイントの詳細情報を、一括取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　jointmaxnum
p3 : [OUT] 文字列の配列変数　：　jointname
p4 : [OUT] 配列変数　：　jointinfo
p5 : [OUT] 変数　：　jointgetnum

%inst
ジョイントの詳細情報を、一括取得します。

この関数を使用するには、
データ取得用の配列を、sdim, dim命令を使って、
作成する必要があります。
（データによって、ジョイントの総数が変化するので、ユーザーさん側で、データ長を調整する必要があります。）


まず、jointmaxnum変数に、
E3DGetJointNum関数で、
ジョイントの総数を取得してください。

jointname引数は、
html{
<strong>sdim jointname, 256, jointmaxnum</strong>
}html
で作成してください。

maxnameno = jointmaxnum - 1
とすると、
jointname(0) から、jointname(maxnameno)
で、jointmaxnum個の名前にアクセスできます。


jointinfo引数は、
html{
<strong>dim jointinfo, JI_MAX, jointmaxnum</strong>
}html
で作成してください。

html{
<strong>JI_* は</strong>
}html、e3dhsp3.asの
最初の方で定義されている定数です。
#define global JI_SERIAL 	0 
define global JI_NOTUSE	1
define global JI_PARENT	2
define global JI_CHILD		3
define global JI_BROTHER	4
define global JI_SISTER	5
define global JI_MAX		6

のように、定義されています。
html{
<strong>配列のインデックスとして、使用してください。</strong>
}html

html{
<strong>JI_SERIAL</strong>
}htmlインデックスは、
ジョイントのシリアル番号にアクセスするときに、
使用します。
ジョイントのシリアル番号とは、
E3DGetPartNoByName あるいは、
E3DGetBoneNoByName　
で取得できる番号と同じものです。

html{
<strong>JI_NOTUSE</strong>
}htmlインデックスは、
ジョイントが無効になっているかどうかの
フラグにアクセスするときに、使用します。
無効なときに１が、有効なときに０が代入されています。

html{
<strong>JI_PARENT, JI_CHILD,
JI_BROTHER, JI_SISTER</strong>
}htmlインデックスは、
ジョイントの階層構造にアクセスするときに
使用します。
詳しくは、
(Link http://www5d.biglobe.ne.jp/~ochikko/e3dhsp_jointtree.htm )ジョイントの階層構造のページ
をご覧ください。

html{
<strong>JI_MAX</strong>
}htmlは、
JI_　で始まる定数の個数を定義しています。
jointinfoをdimするときに使用します。



jointinfoの内容を参照する場合には、
１つ目のインデックスに、
JI_で始まる定数を指定し、
2つ目のインデックスに、
何番目のジョイントかを表す番号
（シリアル番号ではありません）
を指定します。
例えば、3番目のジョイントのシリアル番号に
アクセスしたいときには、
jointinfo(JI_SERIAL,2)
と書きます。

同様に、１番目のジョイントの親の番号に
アクセスしたい場合には、
jointinfo(JI_PARENT,0)
と書きます。


具体的な使用例は、サンプルの
html{
<strong>e3dhsp3_getjointinfo.hsp</strong>
}htmlをご覧ください。





→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　jointmaxnum
　　データ取得用配列の大きさ（ジョイントの数）を指定します。

3. [OUT] 文字列の配列変数　：　jointname
　　名前情報を取得するための配列を渡してください。
　　右に書いた方法で、sdimした配列を渡してください。

4. [OUT] 配列変数　：　jointinfo
　　シリアル番号や、階層構造などを取得するための配列変数を渡してください。
　　右に書いた方法で、dimした配列を渡してください。

5. [OUT] 変数　：　jointgetnum
　　何個のジョイントの情報を出力したかが、代入されます。
　　通常は、jointmaxnumと同じ値が取得されます。




バージョン : ver1.0.0.1

%index
E3DGetFirstJointNo
相対値０のジョイントの、シリアル番号を取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2
p1 : [IN] 数値または、変数　：　hsid
p2 : [OUT] 変数　：　firstno

%inst
相対値０のジョイントの、シリアル番号を取得します。

ジョイント番号の相対値とは、
ボーンファイルや、im2ファイルなどで、
使用します。
各ファイルの説明をご覧ください。
(Link http://www5d.biglobe.ne.jp/~ochikko/rdb2_bonefile.htm )ボーンファイルのページ
(Link http://www5d.biglobe.ne.jp/~ochikko/rdb2_im2file.htm )im2ファイルのページ





→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [OUT] 変数　：　firstno
　　相対値０のシリアル番号が、代入されます。
　　


バージョン : ver1.0.0.1

%index
E3DGetDispObjNum
表示用オブジェクトの総数を取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2
p1 : [IN] 数値または、変数　：　hsid
p2 : [OUT] 変数　：　dispobjnum

%inst
表示用オブジェクトの総数を取得します。
E3DGetDispObjInfoで詳細情報を取得する際の、
配列データの大きさの決定などに、
使用してください。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [OUT] 変数　：　dispobjnum
　　表示オブジェクトの総数が、代入されます。



バージョン : ver1.0.0.1

%index
E3DGetDispObjInfo

表示オブジェクトの詳細情報を、一括取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　dispobjmaxnum
p3 : [OUT] 文字列の配列変数　：　dispobjname
p4 : [OUT] 配列変数　：　dispobjinfo
p5 : [OUT] 変数　：　dispobjgetnum

%inst

表示オブジェクトの詳細情報を、一括取得します。

この関数を使用するには、
データ取得用の配列を、sdim, dim命令を使って、
作成する必要があります。
（データによって、表示オブジェクトの総数が変化するので、ユーザーさん側で、データ長を調整する必要があります。）


まず、dispobjmaxnum変数に、
E3DGetDispObjInfo関数で、
表示オブジェクトの総数を取得してください。


dispobjname引数は、
html{
<strong>sdim dispobjname, 256, dispobjmaxnum</strong>
}html
で作成してください。

maxnameno = dispobjmaxnum - 1
とすると、
dispobjname(0) から、dispobjname(maxnameno)
で、dispobjmaxnum個の名前にアクセスできます。


dispobjinfo引数は、
html{
<strong>dim dispobjinfo, DOI_MAX, dispobjmaxnum</strong>
}html
で作成してください。

html{
<strong>DOI_* は</strong>
}html、e3dhsp3.asで定義されている定数です。
#define global DOI_SERIAL	0
define global DOI_NOTUSE	1
define global DOI_DISPSWITCH	2
#define global DOI_INVISIBLE 3
define global DOI_MAX		4

のように、定義されています。
html{
<strong>配列のインデックスとして、使用してください。</strong>
}html

html{
<strong>DOI_SERIAL</strong>
}htmlインデックスは、
表示オブジェクトのシリアル番号にアクセスするときに、
使用します。
表示オブジェクトのシリアル番号とは、
E3DGetPartNoByName　
で取得できる番号と同じものです。

html{
<strong>DOI_NOTUSE</strong>
}htmlインデックスは、
表示オブジェクトが無効になっているかどうかの
フラグにアクセスするときに、使用します。
無効なときに１が、有効なときに０が代入されています。

html{
<strong>DOI_DISPSWITCH</strong>
}htmlインデックスは、
表示オブジェクトのディスプレイスイッチの番号
にアクセスするときに使用します。
ディスプレイスイッチは、
RokDeBone2で、パーツごとに設定可能です。
(Link http://www5d.biglobe.ne.jp/~ochikko/rdb2_dispswitch.htm )ディスプレイスイッチのページ


html{
<strong>DOI_INVISIBLE</strong>
}htmlインデックスは、
表示オブジェクトが表示されているかどうかのフラグにアクセスするときに使用します。
詳しくは、
E3DSetInvisibleFlag
の説明をお読みください。


html{
<strong>DOI_MAX</strong>
}htmlは、
DOI_　で始まる定数の個数を定義しています。
dispobjinfoをdimするときに使用します。


dispobjinfoの内容を参照する場合には、
１つ目のインデックスに、
DOI_で始まる定数を指定し、
2つ目のインデックスに、
何番目の表示オブジェクトかを表す番号
（シリアル番号ではありません）
を指定します。

例えば、3番目の表示オブジェクトのシリアル番号に
アクセスしたいときには、
dispobjinfo(DOI_SERIAL, 2)
と書きます。

同様に、１番目の表示オブジェクトの
ディスプレイスイッチ番号に、
アクセスしたい場合には、
jointinfo(DOI_DISPSWITCH, 0)
と書きます。



具体的な使用例は、サンプルの
html{
<strong>e3dhsp3_getjointinfo.hsp</strong>
}htmlをご覧ください。






→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　dispobjmaxnum
　　データ取得用配列の大きさ（表示オブジェクトの数）を指定します。

3. [OUT] 文字列の配列変数　：　dispobjname
　　名前情報を取得するための配列を渡してください。
　　右に書いた方法で、sdimした配列を渡してください。

4. [OUT] 配列変数　：　dispobjinfo
　　シリアル番号などを取得するための配列変数を渡してください。
　　右に書いた方法で、dimした配列を渡してください。

5. [OUT] 変数　：　dispobjgetnum
　　何個の表示オブジェクトの情報を出力したかが、代入されます。
　　通常は、dispobjmaxnumと同じ値が取得されます。




バージョン : ver1.0.0.1

%index
E3DEnableTexture
一時的に、テクスチャー表示をオンオフする関数です。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　partno
p3 : [IN] 変数または、数値　：　enableflag

%inst
一時的に、テクスチャー表示をオンオフする関数です。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　partno
　　パーツを識別する番号（シリアル番号）

3. [IN] 変数または、数値　：　enableflag
　　テクスチャーをオフにするときには０を、
　　オンにするときには１を指定してください。



バージョン : ver1.0.0.1

%index
E3DJointAddToTree
パーツに親子関係を設定します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　parentjoint
p3 : [IN] 変数または、数値　：　childjoint
p4 : [IN] 変数または、数値　：　lastflag

%inst
パーツに親子関係を設定します。
childjointをparentjointの子供として、
設定します。

lastflagが０のときは、長男として追加され、
１のときは、末っ子として追加されます。

ジョイント以外に、親子関係を設定しても、
現バージョンでは、意味がありません。

childjoint, parentjointは、
E3DGetPratNoByNameまたは、
E3DGetJointInfoで取得した番号を
使用してください。

E3DJointRemake命令もお読みください。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別する番号

2. [IN] 変数または、数値　：　parentjoint
3. [IN] 変数または、数値　：　childjoint
　　parentjointの子供として、childjointを設定します。

4. [IN] 変数または、数値　：　lastflag
　　０を指定するとparentjointの長男として、
　　１を指定するとparentjointの末っ子として設定されます。



バージョン : ver1.0.0.1

%index
E3DJointRemoveFromParent
パーツの親子関係を取り除きます。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　rmjoint

%inst
パーツの親子関係を取り除きます。

rmjointで指定したパーツと、
その親のパーツとの関係を切り離します。

rmjointの子供の情報は、そのまま残ります。

ジョイント以外に、親子関係を設定しても、
現バージョンでは、意味がありません。


この命令で、親が存在しないまま、
E3DSaveSigFileでファイルに保存すると、
そのファイルは、読み込みできなくなります。

最終的には、E3DJointAddToTreeで、
必ず、親を設定するようにしてください。

一番親のジョイントにしたい場合には、
ジョイントではないフォルダ的な役割をしているパーツの番号を取得して、
それを親に設定してください。


rmjointは、
E3DGetPratNoByNameまたは、
E3DGetJointInfoで取得した番号を
使用してください。

E3DJointRemake命令もお読みください。





→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別する番号

2. [IN] 変数または、数値　：　rmjoint
　　rmjointと、その親の関係を切り離します。


バージョン : ver1.0.0.1

%index
E3DJointRemake
親子関係や、有効無効の変更を、Easy3D内部の関連データに反映させます。
%group
Easy3D For HSP3 : モデル情報

%prm
p1
p1 : [IN] 変数または、数値　：　hsid

%inst
親子関係や、有効無効の変更を、Easy3D内部の関連データに反映させます。

一連の、E3DJointAddToTreeや
E3DJointRemoveFromParent命令や
E3DSetValidFlagを
呼び出した後に、一回、呼び出してください。






→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別する番号



バージョン : ver1.0.0.1

%index
E3DSigImport
hsidに読み込み済の形状データに、
filenameで指定した形状データを
インポートします。
%group
Easy3D For HSP3 : 形状データ

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9,p10
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 文字列または、文字列の変数　：　filename
p3 : [IN] 変数または、数値　：　adjustuvflag
p4 : [IN] 変数または、数値　：　mult
p5 : [IN] 変数または、数値　：　offsetx
p6 : [IN] 変数または、数値　：　offsety
p7 : [IN] 変数または、数値　：　offsetz
p8 : [IN] 変数または、数値　：　rotx
p9 : [IN] 変数または、数値　：　roty
p10 : [IN] 変数または、数値　：　rotz

%inst
hsidに読み込み済の形状データに、
filenameで指定した形状データを
インポートします。

html{
<strong>この命令を呼ぶと、
読み込み済のモーションデータが破棄されます。

</strong>
}html



→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別する番号

2. [IN] 文字列または、文字列の変数　：　filename
　　インポートする*.sig のパス文字列。

3. [IN] 変数または、数値　：　adjustuvflag
　　ＵＶ値を正規化するかどうかのフラグ
　　正規化する場合は１を指定
　　しない場合は０を指定

4. [IN] 変数または、数値　：　mult
　　倍率の値を指定してください。
　　デフォルトは1.0です。
　　等倍は、１．０。
　　実数。

5. [IN] 変数または、数値　：　offsetx
6. [IN] 変数または、数値　：　offsety
7. [IN] 変数または、数値　：　offsetz
　　読み込み位置のオフセット座標を、
　　（offsetx, offsety, offsetz）で指定します。
　　ローカル座標で指定します。
　　実数。

8. [IN] 変数または、数値　：　rotx
9. [IN] 変数または、数値　：　roty
10. [IN] 変数または、数値　：　rotz
　　追加形状を、Ｘ，Ｙ，Ｚそれぞれの軸に対して、
　　rotx, roty, rotz度だけ、回転してから、
　　インポートを行います。
　　回転順序は、Ｚ，Ｙ，Ｘの順番です。
　　実数。

パラメータの適用順序は、
まず、倍率を掛けて、
次に、回転をして、
最後に、移動します。




バージョン : ver1.0.0.1

%index
E3DSigLoadFromBuf
メモリから形状データのロードを行います。
%group
Easy3D For HSP3 : 形状データ

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 文字列または、文字列の変数　：　resdir
p2 : [IN] 変数　：　buf
p3 : [IN] 変数または、数値　：　bufleng
p4 : [OUT] 変数　：　hsid
p5 : [IN] 変数または、数値　：　adjustuvflag
p6 : [IN] 変数または、数値　：　mult

%inst
メモリから形状データのロードを行います。
メモリ内には、sigファイルと同じフォーマットが
入っているとみなして、処理します。

テクスチャファイルは、通常読込と同様に、
ファイルから行います。

resdirには、テクスチャの存在するフォルダのパスを指定してください。
html{
<strong>最後に、&quot;\\&quot;を付けるのを忘れないでください。</strong>
}html

例えば、
resdir = &quot;C:\\hsp\\Meida\\&quot;
や
resdir = dir_cur + &quot;\\&quot;
などのように指定してください。




→引数
1. [IN] 文字列または、文字列の変数　：　resdir
　　テクスチャーのあるフォルダ のパス文字列。
　　最後に、&quot;\\&quot;が必要。

2. [IN] 変数　：　buf
　　バッファの変数

3. [IN] 変数または、数値　：　bufleng
　　バッファの中のデータの長さ

4. [OUT] 変数　：　hsid
　　読み込んだ形状データを識別するhsid

5. [IN] 変数または、数値　：　adjustuvflag
　　ＵＶ値を正規化するかどうかのフラグ
　　正規化する場合は１を指定
　　しない場合は０を指定

6. [IN] 変数または、数値　：　mult
　　倍率の値を指定してください。
　　デフォルトは1.0です。
　　等倍は１．０。
　　実数。



バージョン : ver1.0.0.1

%index
E3DSigImportFromBuf
メモリから、形状データのインポートを行います。
%group
Easy3D For HSP3 : 形状データ

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 文字列または、文字列の変数　：　resdir
p3 : [IN] 変数　：　buf
p4 : [IN] 変数または、数値　：　bufleng
p5 : [IN] 変数または、数値　：　adjustuvflag
p6 : [IN] 変数または、数値　：　mult
p7 : [IN] 変数または、数値　：　offsetx
p8 : [IN] 変数または、数値　：　offsety
p9 : [IN] 変数または、数値　：　offsetz
p10 : [IN] 変数または、数値　：　rotx
p11 : [IN] 変数または、数値　：　roty
p12 : [IN] 変数または、数値　：　rotz

%inst
メモリから、形状データのインポートを行います。
メモリ内には、sigファイルと同じフォーマットが
入っているとみなして、処理します。

テクスチャファイルは、通常読込と同様に、
ファイルから行います。

resdirには、テクスチャの存在するフォルダのパスを指定してください。
html{
<strong>最後に、&quot;\\&quot;を付けるのを忘れないでください。</strong>
}html





→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するhsid

2. [IN] 文字列または、文字列の変数　：　resdir
　　テクスチャーのあるフォルダ のパス文字列。
　　最後に、&quot;\\&quot;が必要。

3. [IN] 変数　：　buf
　　バッファの変数

4. [IN] 変数または、数値　：　bufleng
　　バッファの中のデータの長さ


5. [IN] 変数または、数値　：　adjustuvflag
　　ＵＶ値を正規化するかどうかのフラグ
　　正規化する場合は１を指定
　　しない場合は０を指定

6. [IN] 変数または、数値　：　mult
　　倍率の値を指定してください。
　　デフォルトは１．０です。
　　等倍は１．０。
　　実数。

7. [IN] 変数または、数値　：　offsetx
8. [IN] 変数または、数値　：　offsety
9. [IN] 変数または、数値　：　offsetz
　　読み込み位置のオフセット座標を、
　　（offsetx, offsety, offsetz）で指定します。
　　ローカル座標で指定します。
　　実数。

10. [IN] 変数または、数値　：　rotx
11. [IN] 変数または、数値　：　roty
12. [IN] 変数または、数値　：　rotz
　　追加形状を、Ｘ，Ｙ，Ｚそれぞれの軸に対して、
　　rotx, roty, rotz度だけ、回転してから、
　　インポートを行います。
　　回転順序は、Ｚ，Ｙ，Ｘの順番です。
　　実数。

パラメータの適用順序は、
まず、倍率を掛けて、
次に、回転をして、
最後に、移動します。




バージョン : ver1.0.0.1

%index
E3DAddMotionFromBuf
メモリからモーションデータのロードを行います。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　datakind
p3 : [IN] 変数　：　buf
p4 : [IN] 変数または、数値　：　bufleng
p5 : [OUT] 変数　：　mk
p6 : [OUT] 変数　：　maxframe
p7 : [IN] 変数または、数値　：　mvmult

%inst
メモリからモーションデータのロードを行います。
メモリ内には、quaまたはmotファイルと
同じフォーマットが入っているとみなして、
処理します。

quaデータの読み込み時は、
datakindに０を指定し、
motデータの読み込み時には、
datakindに１を指定してください。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するhsid

2. [IN] 変数または、数値　：　datakind
　　quaデータの時は０を、
　　motデータの時は１を指定してください。

3. [IN] 変数　：　buf
　　バッファの変数

4. [IN] 変数または、数値　：　bufleng
　　バッファの中のデータの長さ

5. [OUT] 変数　：　mk
　　読み込んだモーションを識別する番号

6. [OUT] 変数　：　maxframe
　　読み込んだモーションの最大フレーム番号
　　（総フレーム数 - 1 と同じ）

7. [IN] 変数または、数値　：　mvmult
　　モーションの移動成分に掛ける倍率
　　省略すると１．０
　　実数




バージョン : ver1.0.0.1<BR>
      ver4.0.1.6で引数追加<BR>
      

%index
E3DCheckFullScreenParams
フルスクリーンのパラメータをチェックし、与えた条件に近いパラメータを取得します。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 数値または、変数　：　screenw
p2 : [IN] 数値または、変数　：　screenh
p3 : [IN] 数値または、変数　：　bits
p4 : [OUT] 変数　：　validflag
p5 : [OUT] 変数　：　validw
p6 : [OUT] 変数　：　validh
p7 : [OUT] 変数　：　validbits

%inst
フルスクリーンのパラメータをチェックし、与えた条件に近いパラメータを取得します。

validflagに１が返された場合のみ、
validw, validh, validbitsの値は有効です。

validflagに０が返された場合には、
ウインドウの大きさなどの条件を変えて、
有効なパラメータが取得できるまで、
繰り返し、この命令を呼び出してください。


この命令は、E3DInitよりも前に呼ぶことを前提にしています。

この命令で、取得したvalidwとvalidhでウインドウを作成した後（screen命令やbgscr命令などで）、
E3DInitのbits引数にvalidbitsを指定して、フルスクリーン初期化してください。


具体的な使用例は、
e3dhsp3_fullscreen.hsp
に書きましたので、ご覧ください。






→引数
1. [IN] 数値または、変数　：　screenw
2. [IN] 数値または、変数　：　screenh
3. [IN] 数値または、変数　：　bits
　　使用したいフルスクリーンのパラメータを指定します。
　　screenwにスクリーンの幅
　　screenhにスクリーンの高さ
　　bitsに色数を示すビット数を指定します。

4. [OUT] 変数　：　validflag
　　screenw, screenh, bitsで指定したパラメータに近い
　　フルスクリーンが作れることが分かった場合に、
　　１がセットされます。

　　与えられたパラメータでは、フルスクリーンが作れないことが
　　分かった場合には、０がセットされます。

5. [OUT] 変数　：　validw
6. [OUT] 変数　：　validh
7. [OUT] 変数　：　validbits
　　フルスクリーンの作成に有効なパラメータが返されます。
　　screenw, screenh, bitsで指定したものとは、
　　多少、異なる場合があります。

　　これらの値は、validflagに１が代入されているときのみ有効です。



バージョン : ver1.0.0.1

%index
E3DGetMaxMultiSampleNum
アンチエイリアスに必要な、マルチサンプルの数の最大値を取得します。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　bits
p2 : [IN] 数値または、変数　：　iswindowmode
p3 : [OUT] 変数　：　maxmultisamplenum

%inst
アンチエイリアスに必要な、マルチサンプルの数の最大値を取得します。

この関数は、E3DInitよりも前に呼び出すことを
想定しています。

E3DInitに渡すmultisamplenumの値の決定に
使用してください。


具体的な使用例は、
e3dhsp3_antialias.hsp
に書きましたので、ご覧ください。




→引数
1. [IN] 数値または、変数　：　bits
　　色数を決めるビット数を指定してください。

2. [IN] 数値または、変数　：　iswindowmode
　　ウインドウモードの時は１を
　　フルスクリーンの時は０を指定してください。

3. [OUT] 変数　：　maxmultisamplenum
　　マルチサンプルの数の指定に有効な、最大の値を代入します。
　　０または、２から１６の値が代入されます。
　　ハードウェアによって、異なる値が代入されます。



バージョン : ver1.0.0.1

%index
E3DChkConfLineAndFace
任意の線分と、sigの面との当たり判定をします。
%group
Easy3D For HSP3 : 当たり判定

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17
p1 : [IN] 数値または、変数　：　posx1
p2 : [IN] 数値または、変数　：　posy1
p3 : [IN] 数値または、変数　：　posz1
p4 : [IN] 数値または、変数　：　posx2
p5 : [IN] 数値または、変数　：　posy2
p6 : [IN] 数値または、変数　：　posz2
p7 : [IN] 数値または、変数　：　hsid
p8 : [IN] 数値または、変数　：　needtrans
p9 : [OUT] 変数　：　partno
p10 : [OUT] 変数　：　faceno
p11 : [OUT] 変数　：　confx
p12 : [OUT] 変数　：　confy
p13 : [OUT] 変数　：　confz
p14 : [OUT] 変数　：　nx
p15 : [OUT] 変数　：　ny
p16 : [OUT] 変数　：　nz
p17 : [OUT] 変数　：　revfaceflag

%inst
任意の線分と、sigの面との当たり判定をします。

この当たり判定は、
hsidで指定したデータのボーン変形が、
必要になります。

ですが、同じポーズで何回も当たり判定を行う場合などには、いちいちボーン変形を計算し直さない方が高速です。
needtransに０を指定すると、
ボーン変形計算を省略することが出来ます。
（ポーズが変わった場合や、
カメラ位置を変えた場合には、
needtransを１にしてください。）


線分と面との当たりE3DChkConfLineAndFaceは、結構、重い処理です。
ですので、出来るだけ、呼び出し回数を
少なくするように心がけてください。
呼び出し回数を少なくするための工夫として、
まず、E3DChkConflictで、
おおざっぱな当たり判定を行い、
E3DChkConflictで、当たっていると判定されたときのみ、
E3DChkConfLineAndFaceを呼び出す、
などの方法が有効です。

E3DChkInViewより後で呼び出してください。

具体的な使用例は、
html{
<strong>e3dhsp3_ConfLineAndFace.hsp</strong>
}html
に書きましたので、ご覧ください。





→引数

1. [IN] 数値または、変数　：　posx1
2. [IN] 数値または、変数　：　posy1
3. [IN] 数値または、変数　：　posz1

4. [IN] 数値または、変数　：　posx2
5. [IN] 数値または、変数　：　posy2
6. [IN] 数値または、変数　：　posz2

線分を、（posx1, posy1, posz1）と、(posx2, posy2, posz2)で
指定してください。
　　実数。

7. [IN] 数値または、変数　：　hsid
　　モデルデータを識別するＩＤ

8. [IN] 数値または、変数　：　needtrans
　　ボーン変形計算をするかどうかのフラグ
　　詳しくは、左記をご覧ください。

9. [OUT] 変数　：　partno
10. [OUT] 変数　：　faceno
　　線分とhsidのモデルが衝突していた場合に、
　　衝突したパーツの番号と、面の番号が代入されます。
　　衝突していなかった場合は、-1が代入されます。

11. [OUT] 変数　：　confx
12. [OUT] 変数　：　confy
13. [OUT] 変数　：　confz
　　衝突していた場合に、衝突した座標が代入されます。
　　実数型の変数。

14. [OUT] 変数　：　nx
15. [OUT] 変数　：　ny
16. [OUT] 変数　：　nz
　　衝突していた場合に、衝突したhsidの面の法線ベクトルが代入されます。
　　実数型の変数。

17. [OUT] 変数　：　revfaceflag
　　衝突していた面が裏面だった場合、１が代入されます。
　　表面だった場合は、０が代入されます。



バージョン : ver1.0.0.1

%index
E3DPickFace
２Ｄの画面の座標に対応する、３Ｄモデルの座標を取得できます。
%group
Easy3D For HSP3 : 当たり判定

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15
p1 : [IN] 変数または、数値　：　scid
p2 : [IN] 数値または、変数　：　hsid
p3 : [IN] 数値または、変数　：　pos2x
p4 : [IN] 数値または、変数　：　pos2y
p5 : [IN] 数値または、変数　：　maxdist
p6 : [OUT] 変数　：　partno
p7 : [OUT] 変数　：　faceno
p8 : [OUT] 変数　：　pos3x
p9 : [OUT] 変数　：　pos3y
p10 : [OUT] 変数　：　pos3z
p11 : [OUT] 変数　：　nx
p12 : [OUT] 変数　：　ny
p13 : [OUT] 変数　：　nz
p14 : [OUT] 変数　：　dist
p15 : [IN] 数値または、変数　：　calcmode

%inst
２Ｄの画面の座標に対応する、３Ｄモデルの座標を取得できます。

マウスでクリックした場所に、
３Ｄオブジェクトを移動させることなどに使用してください。

E3DPickVertが、３Ｄモデルの頂点を抽出するのに対し、
E3DPickFaceは、３Ｄモデルの面を抽出し、
２Ｄ座標に対応する面上の３Ｄ座標を取得します。

maxdist によって、どのくらい遠くまで
検索するかを指定できます。
maxdistの値を小さくするほど、
処理は高速になります。



html{
<strong>計算には、E3DChkInViewの結果を
使用しています。
</strong>
}html

具体的な使用例は、
e3dhsp3_pickface.hsp
に書きましたので、ご覧ください。




→引数
1. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。

2. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。


3. [IN] 数値または、変数　：　pos2x
4. [IN] 数値または、変数　：　pos2y
　　画面上の２Ｄ座標を指定してください。

5. [IN] 数値または、変数　：　maxdist
　　どのくらいの距離まで、３Ｄモデルの検索をするかを指定します。
　　この値を小さくするほど、処理は高速になります。

6. [OUT] 変数　：　partno
7. [OUT] 変数　：　faceno
　　2D座標に対応する３Ｄ座標が見つかった場合に、
　　その３Ｄモデルのパーツの番号と、面の番号が
　　代入されます。

　　見つからなかった場合は、-1が代入されます。

8. [OUT] 変数　：　pos3x
9. [OUT] 変数　：　pos3y
10. [OUT] 変数　：　pos3z
　　２Ｄ座標に対応する３Ｄ座標が代入されます。
　　partnoに-1以外の値が代入されているときのみ、
　　これらの値は意味を持ちます。
　　実数型の変数。

11. [OUT] 変数　：　nx
12. [OUT] 変数　：　ny
13. [OUT] 変数　：　nz
　　2D座標に対応する３Ｄ座標を含む面の法線ベクトルが
　　代入されます。

　　ベクトルの大きさは１のものを代入します。

　　partnoに-1以外の値が代入されているときのみ、
　　これらの値は意味を持ちます。

　　実数型の変数。

14. [OUT] 変数　：　dist
　　視点と（pos3x, pos3y, pos3z）との距離が代入されます。
　　partnoに-1以外の値が代入されているときのみ、
　　この値は意味を持ちます。
　　実数型の変数。

15. [IN] 数値または、変数　：　calcmode
　　１を指定してください。




バージョン : ver1.0.0.1

%index
E3DGetBBox
読み込んだモデルデータのバウンダリーボックスの取得が出来ます。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　mode
p4 : [OUT] 変数　：　minx
p5 : [OUT] 変数　：　maxx
p6 : [OUT] 変数　：　miny
p7 : [OUT] 変数　：　maxy
p8 : [OUT] 変数　：　minz
p9 : [OUT] 変数　：　maxz

%inst
読み込んだモデルデータのバウンダリーボックスの取得が出来ます。

カメラの設定や、プロジェクションの設定を、モデルの大きさに応じて変更する場合などに使ってください。

mode引数で、
ローカル座標か、グローバル座標かを
指定できるようにする予定です。
現在は、グローバル座標しか取得できません。

この命令で使用する情報は、E3DChkInViewで更新されます。




→引数
1. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。
　　ビルボードの情報を得たい場合は-1を指定してください。

2. [IN] 数値または、変数　：　partno
　　パーツを識別する番号を指定してください。
　　-1を指定した場合は、モデル全体のバウンダリーボックスを取得します。

　　hsidに-1を指定した場合は
　　ビルボードのIDを指定してください。


3. [IN] 数値または、変数　：　mode
　　現在はサポートされていません。
　　０を指定してください。

4. [OUT] 変数　：　minx
5. [OUT] 変数　：　maxx
6. [OUT] 変数　：　miny
7. [OUT] 変数　：　maxy
8. [OUT] 変数　：　minz
9. [OUT] 変数　：　maxz
　　Ｘ座標の最小、最大
　　Ｙ座標の最小、最大
　　Ｚ座標の最小、最大
　　がそれぞれ、代入されます。
　　実数型の変数。



バージョン : ver1.0.0.1<BR>
      ver5.0.2.9で拡張

%index
E3DGetVertNoOfFace
 facenoで指定した面に含まれる頂点の番号を３つ取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　faceno
p4 : [OUT] 変数　：　vertno1
p5 : [OUT] 変数　：　vertno2
p6 : [OUT] 変数　：　vertno3

%inst
 facenoで指定した面に含まれる頂点の番号を３つ取得します。（３角形の頂点です）

facenoには、E3DPickFaceなどで取得した
面の番号を指定してください。

E3DGetSamePosVertの説明も
お読みください。




→引数
1. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。

2. [IN] 数値または、変数　：　partno
　　パーツを識別する番号を指定してください。

3. [IN] 数値または、変数　：　faceno
　　面を識別する番号を指定してください。

4. [OUT] 変数　：　vertno1
5. [OUT] 変数　：　vertno2
6. [OUT] 変数　：　vertno3
　　３角形の面を構成する３つの頂点の番号が
　　代入されます。



バージョン : ver1.0.0.1

%index
E3DGetSamePosVert
同じ位置の頂点番号を取得する。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　vertno
p4 : [OUT] 変数　：　samevertno
p5 : [IN] 数値または、変数　：　arrayleng
p6 : [OUT] 変数　：　samenum

%inst
同じ位置の頂点番号を取得する。

モデルデータ中には、同じ頂点座標で、
ＵＶ座標だけ違う頂点が存在します。

同じ位置の頂点の番号を取得する関数です。
E3DGetVertNoOfFaceと組み合わせて
使うことを想定しています。

samevertno には、見つかった頂点数分の
頂点番号が代入されます。

arraylengに５くらいの値を入れて、
dim samevertno, arrayleng
で、配列を作成してください。






→引数
1. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。

2. [IN] 数値または、変数　：　partno
　　パーツを識別する番号を指定してください。

3. [IN] 数値または、変数　：　vertno
　　頂点を識別する番号を指定してください。

4. [OUT] 変数　：　samevertno
　　dim samevertno, arraylengで作成した配列を指定してください。
　　見つかった頂点の番号が代入されます。

5. [IN] 数値または、変数　：　arrayleng
　　samevertno配列を作成したときの大きさを指定してください。

6. [OUT] 変数　：　samenum
　　見つかった頂点の数が代入されます。
　　つまり、maxindex = samenum - 1とすると
　　samevertno(0) から　samevertno(maxindex)
　　まで、見つかった頂点の番号が、代入されていることになります。




バージョン : ver1.0.0.1

%index
E3DRdtscStart
時間の計測。
%group
Easy3D For HSP3 : 同期

%prm
なし

%inst
時間の計測。

E3DRdtscStartとE3DRdtscStopは、セットで使用します。

E3DRdtscStartを呼び出してから、
E3DRdtscStopを呼び出すまでに、
プロセッサのタイムスタンプカウンタが
どれくらい増えたかを取得できます。




→引数
なし

バージョン : ver1.0.0.1

%index
E3DRdtscStop
時間の計測。
%group
Easy3D For HSP3 : 同期

%prm
p1
p1 : [OUT] 変数　：　time

%inst
時間の計測。

E3DRdtscStartとE3DRdtscStopは、セットで使用します。

E3DRdtscStartを呼び出してから、
E3DRdtscStopを呼び出すまでに、
プロセッサのタイムスタンプカウンタが
どれくらい増えたかを取得できます。

実数型の値が取得されます。





→引数
1. [OUT] 変数　：　time
　　E3DRdtscStartを呼んでからの、
　　タイムスタンプカウンタの増分が代入されます。
　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DSaveSig2Buf
読み込み済の形状データを、メモリ上に保存します。
%group
Easy3D For HSP3 : モデル出力

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 変数　：　buf
p3 : [IN] 数値または、変数　：　bufsize
p4 : [OUT] 変数　：　writesize

%inst
読み込み済の形状データを、メモリ上に保存します。

保存するためのバッファは、
ユーザーさん側が用意します。

バッファの長さが分からないと、
保存操作が行えないため、
html{
<strong>バッファ長の取得と、実際の保存とで、
合計２回、この関数を呼び出してください。</strong>
}html

bufsize引数に０を指定すると、
保存を行わずに、
保存に必要なバッファの長さを取得します。

バッファの長さを取得した後に、
その長さをbufsize引数に指定して、
実際の保存を行ってください。


実際のコードは、以下のようになります。

E3DSaveSig2Buf hsid, sigbuf, 0, sigwritesize

sdim sigbuf, sigwritesize

E3DSaveSig2Buf hsid2, sigbuf, sigwritesize, writesize1





→引数
1. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。

2. [IN] 変数　：　buf
　　バッファの変数を指定してください。

3. [IN] 数値または、変数　：　bufsize
　　０を指定すると、
　　保存に必要なバッファの長さが、writesizeに代入されます。
　　０以外を指定すると、
　　バッファbufに、形状データを保存します。

4. [OUT] 変数　：　writesize
　　bufsizeに０が指定されている場合には、
　　必要なバッファのサイズが代入されます。

　　bufsizeに０以外が指定されている場合には、
　　実際に保存したデータのバイト数を代入します。



バージョン : ver1.0.0.1

%index
E3DSaveQua2Buf
読み込み済のモーションデータを、メモリ上に保存します。
%group
Easy3D For HSP3 : モーション出力

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　mkid
p3 : [IN] 変数　：　buf
p4 : [IN] 数値または、変数　：　bufsize
p5 : [OUT] 変数　：　writesize
p6 : [IN] 数値または、変数　：　quatype

%inst
読み込み済のモーションデータを、メモリ上に保存します。

保存するためのバッファは、
ユーザーさん側が用意します。

バッファの長さが分からないと、
保存操作が行えないため、
html{
<strong>バッファ長の取得と、実際の保存とで、
合計２回、この関数を呼び出してください。</strong>
}html

bufsize引数に０を指定すると、
保存を行わずに、
保存に必要なバッファの長さを取得します。

バッファの長さを取得した後に、
その長さをbufsize引数に指定して、
実際の保存を行ってください。


実際のコードは、以下のようになります。


E3DSaveQua2Buf hsid, mkid, quabuf, 0, quawritesize, quatype

sdim quabuf, quawritesize

E3DSaveQua2Buf hsid, mkid, quabuf, quawritesize, writesize2, quatype

      quatype引数でファイルのタイプを指定します。
e3dhsp3.asで定義されているQUATYPE_ で始まる定数を使います。
QUATYPE_NUMはボーンの階層構造から計算した番号を基準にファイルを作ります。
QUATYPE_NAMEはボーンの名前を基準にファイルを作ります。

ver5.0.3.8より前のバージョンのquaファイルはQUATYPE_NUMです。




→引数
1. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。

2. [IN] 数値または、変数　：　mkid
　　モーションを識別する番号を指定してください。

3. [IN] 変数　：　buf
　　バッファの変数を指定してください。

4. [IN] 数値または、変数　：　bufsize
　　０を指定すると、
　　保存に必要なバッファの長さが、writesizeに代入されます。
　　０以外を指定すると、
　　バッファbufに、モーションデータを保存します。

5. [OUT] 変数　：　writesize
　　bufsizeに０が指定されている場合には、
　　必要なバッファのサイズが代入されます。

　　bufsizeに０以外が指定されている場合には、
　　実際に保存したデータのバイト数を代入します。

6. [IN] 数値または、変数　：　quatype
　　QUATYPE_ で始まる定数を指定。
　　デフォルト値はQUATYPE_NAME。



バージョン : ver1.0.0.1<BR>
      ver5.0.3.8で引数追加<BR>
      

%index
E3DCameraShiftLeft
カメラを左に平行移動します。
%group
Easy3D For HSP3 : カメラ

%prm
p1
p1 : [IN] 数値または、変数　：　shift

%inst
カメラを左に平行移動します。


→引数
1. [IN] 数値または、変数　：　shift
　　移動量。
　　実数。



バージョン : ver1.0.0.1

%index
E3DCameraShiftRight
カメラを右に平行移動します。
%group
Easy3D For HSP3 : カメラ

%prm
p1
p1 : [IN] 数値または、変数　：　shift

%inst
カメラを右に平行移動します。


→引数
1. [IN] 数値または、変数　：　shift
　　移動量。
　　実数。



バージョン : ver1.0.0.1

%index
E3DCameraShiftUp
カメラを上に平行移動します。
%group
Easy3D For HSP3 : カメラ

%prm
p1
p1 : [IN] 数値または、変数　：　shift

%inst
カメラを上に平行移動します。


→引数
1. [IN] 数値または、変数　：　shift
　　移動量。
　　実数。



バージョン : ver1.0.0.1

%index
E3DCameraShiftDown
カメラを下に平行移動します。
%group
Easy3D For HSP3 : カメラ

%prm
p1
p1 : [IN] 数値または、変数　：　shift

%inst
カメラを下に平行移動します。


→引数
1. [IN] 数値または、変数　：　shift
　　移動量。
　　実数。



バージョン : ver1.0.0.1

%index
E3DGetCameraQ
カメラの回転変換を表すクォータニオンを
取得します。
%group
Easy3D For HSP3 : カメラ

%prm
p1
p1 : [IN] 数値または、変数　：　qid

%inst
カメラの回転変換を表すクォータニオンを
取得します。

使い方の例は、
html{
<strong>e3dhsp3_toolscamera.hsp</strong>
}html
にあります。




→引数
1. [IN] 数値または、変数　：　qid
　　クォータニオンのＩＤを渡してください。
　　qidで識別されるクォータニオンに、
　　カメラの回転情報を代入します。

　　qidには、E3DCreateQで取得したＩＤを使用してください。



バージョン : ver1.0.0.1

%index
E3DInvQ
逆クォータニオンを取得します。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2
p1 : [IN] 数値または、変数　：　srcqid
p2 : [IN] 数値または、変数　：　dstqid

%inst
逆クォータニオンを取得します。

使い方の例は、
html{
<strong>e3dhsp3_toolscamera.hsp</strong>
}html
にあります。




→引数
1. [IN] 数値または、変数　：　srcqid
2. [IN] 数値または、変数　：　dstqid
　　クォータニオンのＩＤを渡してください。
　　dstqidで識別されるクォータニオンに、
　　srcqidで識別されるクォータニオンの逆クォータニオンを代入します。

　　srcqid, dstqidには、
　　E3DCreateQで取得したＩＤを使用してください。



バージョン : ver1.0.0.1

%index
E3DSetCameraTwist
カメラをツイスト（ロール）させます。
%group
Easy3D For HSP3 : カメラ

%prm
p1
p1 : [IN] 数値または、変数　：　twistdeg

%inst
カメラをツイスト（ロール）させます。

カメラの使い方は、この表の前に書いてある部分をお読みください。

E3DSetCameraTwistは、どのタイプのカメラ関数を使用している場合でも、有効です。

E3DSetCameraTargetを使用している場合には、
E3DSetCameraTargetで指定した上方向のベクトルを、さらにtwistdeg分ねじります。





→引数
1. [IN] 数値または、変数　：　twistdeg
　　カメラをtwistdeg度だけ、ツイストします。
　　実数。


バージョン : ver1.0.0.1

%index
E3DIKRotateBeta
ＩＫによるジョイントの回転を行います。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18
p1 : [IN] 変数または、数値　：　scid
p2 : [IN] 数値または、変数　：　hsid
p3 : [IN] 数値または、変数　：　jointno
p4 : [IN] 数値または、変数　：　motionid
p5 : [IN] 数値または、変数　：　frameno
p6 : [IN] 数値または、変数　：　iklevel
p7 : [IN] 数値または、変数　：　axiskind
p8 : [IN] 数値または、変数　：　axisx
p9 : [IN] 数値または、変数　：　axisy
p10 : [IN] 数値または、変数　：　axisz
p11 : [IN] 数値または、変数　：　calclevel
p12 : [IN] 数値または、変数　：　targetx
p13 : [IN] 数値または、変数　：　targety
p14 : [IN] 数値または、変数　：　targetz
p15 : [OUT] 変数　：　resx
p16 : [OUT] 変数　：　resy
p17 : [OUT] 変数　：　resz
p18 : [OUT] 変数　：　lastparent

%inst
ＩＫによるジョイントの回転を行います。
目標の座標などを指定すると、
そこに近づくように、回転します。

html{
<strong>この関数は、ベータ版です。
今後のバージョンアップで、
互換性のとれない変更をする場合がありますので、ご注意ください。</strong>
}html

この関数では、指定したモーションの1フレーム分の姿勢情報しか変更しません。
モーション全体に、ＩＫ結果を反映させたい場合は、
ＩＫ計算した前後のキーフレーム間で、
E3DFillUpMotionを呼び出す必要があります。


使い方の例は、
e3dhsp3_ikrotatebeta.hsp
にあります。





→引数
1. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。

2. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。

3. [IN] 数値または、変数　：　jointno
　　ジョイントパーツを識別する番号を指定してください。
　　E3DGetPartNoByNameなどで取得した値や、
　　E3DGetJointInfoで取得したシリアル番号を指定してください。
　　ジョイント以外のパーツの番号を指定するとエラーになります。
　　
4. [IN] 数値または、変数　：　motionid
　　モーションを識別する番号を指定してください。

5. [IN] 数値または、変数　：　frameno
　　モーションのフレーム番号を指定してください。

6. [IN] 数値または、変数　：　iklevel
　　ＩＫ計算時の階層数を指定します。
　　何階層、親をさかのぼって、ＩＫ計算するかを指定します。

7. [IN] 数値または、変数　：　axiskind
　　IKの回転の際の軸をどのように決定するかを指定します。
　　０の時は、視線に平行なベクトルを使います。
　　１の時は、axisx, axisy, axiszに指定した軸を使います。
　　2の時は、自動的に軸を設定します。
　　
8. [IN] 数値または、変数　：　axisx
9. [IN] 数値または、変数　：　axisy
10. [IN] 数値または、変数　：　axisz
　　IKの回転軸を指定します。
　　axiskindに、１を指定したときのみ、有効です。
　　実数。

11. [IN] 数値または、変数　：　calclevel
　　計算の細かさを指定します。
　　正の整数を指定してください。
　　値が大きいほど細かく動きますが、
　　現バージョンでは、大きすぎても、うまくいきません。

12. [IN] 数値または、変数　：　targetx
13. [IN] 数値または、変数　：　targety
14. [IN] 数値または、変数　：　targetz
　　jointnoで指定したジョイントが、
　　座標（targetx, targety, targetz）に近づくように、回転します。　
　　実数。

15. [OUT] 変数　：　resx
16. [OUT] 変数　：　resy
17. [OUT] 変数　：　resz
　　jointnoで指定したジョイントの、計算後の座標が代入されます。
　　実数型の変数。

18. [OUT] 変数　：　lastparent
　　姿勢の変更のあったボーンのうち、
　　一番親の番号が代入されます。
　　この値を、E3DRenderに渡すと、処理の高速化が出来ます。
　　詳しくは、E3DRednerのところの注意事項をお読みください。




バージョン : ver1.0.0.1

%index
E3DIKRotateBeta2D
E3DIKRotateBetaの２Ｄ座標指定バージョンです。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17
p1 : [IN] 変数または、数値　：　scid
p2 : [IN] 数値または、変数　：　hsid
p3 : [IN] 数値または、変数　：　jointno
p4 : [IN] 数値または、変数　：　motionid
p5 : [IN] 数値または、変数　：　frameno
p6 : [IN] 数値または、変数　：　iklevel
p7 : [IN] 数値または、変数　：　axiskind
p8 : [IN] 数値または、変数　：　axisx
p9 : [IN] 数値または、変数　：　axisy
p10 : [IN] 数値または、変数　：　axisz
p11 : [IN] 数値または、変数　：　calclevel
p12 : [IN] 数値または、変数　：　target2dx
p13 : [IN] 数値または、変数　：　target2dy
p14 : [OUT] 変数　：　resx
p15 : [OUT] 変数　：　resy
p16 : [OUT] 変数　：　resz
p17 : [OUT] 変数　：　lastparent

%inst
E3DIKRotateBetaの２Ｄ座標指定バージョンです。

目標座標が、２Ｄになった以外は、
E3DIKRotateBetaと同じです。
詳しくは、E3DIKRotateBetaの説明を
お読みください。

具体的な使用例は、
html{
<strong>e3dhsp3_MouseDePose.hsp</strong>
}html
に書きましたので、ご覧ください。




→引数
1. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。

2. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。

3. [IN] 数値または、変数　：　jointno
　　ジョイントパーツを識別する番号を指定してください。
　　E3DGetPartNoByNameなどで取得した値や、
　　E3DGetJointInfoで取得したシリアル番号を指定してください。
　　ジョイント以外のパーツの番号を指定するとエラーになります。
　　
4. [IN] 数値または、変数　：　motionid
　　モーションを識別する番号を指定してください。

5. [IN] 数値または、変数　：　frameno
　　モーションのフレーム番号を指定してください。

6. [IN] 数値または、変数　：　iklevel
　　ＩＫ計算時の階層数を指定します。
　　何階層、親をさかのぼって、ＩＫ計算するかを指定します。

7. [IN] 数値または、変数　：　axiskind
　　IKの回転の際の軸をどのように決定するかを指定します。
　　０の時は、視線に平行なベクトルを使います。
　　１の時は、axisx, axisy, axiszに指定した軸を使います。
　　2の時は、自動的に軸を設定します。
　　
8. [IN] 数値または、変数　：　axisx
9. [IN] 数値または、変数　：　axisy
10. [IN] 数値または、変数　：　axisz
　　IKの回転軸を指定します。
　　axiskindに、１を指定したときのみ、有効です。
　　実数。

11. [IN] 数値または、変数　：　calclevel
　　計算の細かさを指定します。
　　正の整数を指定してください。
　　値が大きいほど細かく動きますが、
　　現バージョンでは、大きすぎても、うまくいきません。

12. [IN] 数値または、変数　：　target2dx
13. [IN] 数値または、変数　：　target2dy
　　jointnoで指定したジョイントが、
　　指定した２Ｄ座標に近づくように、回転します。


14. [OUT] 変数　：　resx
15. [OUT] 変数　：　resy
16. [OUT] 変数　：　resz
　　jointnoで指定したジョイントの、計算後の座標が代入されます。
　　実数型の変数。

17. [OUT] 変数　：　lastparent
　　姿勢の変更のあったボーンのうち、
　　一番親の番号が代入されます。
　　この値を、E3DRenderに渡すと、処理の高速化が出来ます。
　　詳しくは、E3DRednerのところの注意事項をお読みください。


バージョン : ver1.0.0.1

%index
E3DGetMotionType
モーションのタイプを取得します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　motid
p3 : [OUT] 変数　：　typeptr

%inst
モーションのタイプを取得します。

得られるタイプの意味は、以下のようになります。
１がフレーム番号固定(Stop)
２が最終フレーム番号まで進んだら固定(Clamp)
３が最終フレーム番号まで進んだら、先頭フレームに戻る(Round)
４が最終フレーム番号まで進んだら、先頭フレームの方向に逆進する（PingPong）
５が最終フレームまで進んだら、指定フレームにジャンプする（Jump）




→引数
1. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。

2. [IN] 数値または、変数　：　motid
　　モーションを識別する番号を指定してください。

3. [OUT] 変数　：　typeptr
　　左で説明したモーションの種類が代入されます。



バージョン : ver1.0.0.1

%index
E3DSetMotionType
モーションのタイプをセットします。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　motid
p3 : [IN] 数値または、変数　：　type

%inst
モーションのタイプをセットします。

typeに指定する値の意味は、以下のようになります。１がフレーム番号固定(Stop)
２が最終フレーム番号まで進んだら固定(Clamp)
３が最終フレーム番号まで進んだら、先頭フレームに戻る(Round)
４が最終フレーム番号まで進んだら、先頭フレームの方向に逆進する（PingPong）




→引数
1. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。

2. [IN] 数値または、変数　：　motid
　　モーションを識別する番号を指定してください。

3. [IN] 数値または、変数　：　type
　　左で説明したモーションの種類を指定してください。



バージョン : ver1.0.0.1

%index
E3DGetIKTransFlag
ＩＫ伝達禁止情報を、ジョイントから取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　jointid
p3 : [OUT] 変数　：　flagptr

%inst
ＩＫ伝達禁止情報を、ジョイントから取得します。




→引数
1. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。

2. [IN] 数値または、変数　：　jointid
　　ジョイントを識別する番号を指定してください。

3. [OUT] 変数　：　flagptr
　　通常の場合は０が、
　　ＩＫ伝達禁止の時は１が代入されます。



バージョン : ver1.0.0.1

%index
E3DSetIKTransFlag
ＩＫ伝達禁止情報を、ジョイントにセットします。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　jointid
p3 : [IN] 数値または、変数　：　flag

%inst
ＩＫ伝達禁止情報を、ジョイントにセットします。




→引数
1. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。

2. [IN] 数値または、変数　：　jointid
　　ジョイントを識別する番号を指定してください。

3. [IN] 数値または、変数　：　flag
　　通常の場合は０を、
　　ＩＫ伝達禁止の時は１を指定してください。



バージョン : ver1.0.0.1

%index
E3DDestroyAllMotion
E3DAddMotionで読み込んだ、モーションデータを、全て、破棄します。
%group
Easy3D For HSP3 : モーション

%prm
p1
p1 : [IN] 数値または、変数　：　hsid

%inst
E3DAddMotionで読み込んだ、モーションデータを、全て、破棄します。


→引数
1. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。



バージョン : ver1.0.0.1

%index
E3DGetUserInt1OfPart
パーツに設定されている、ユーザーデータを、取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [OUT] 変数　：　dataptr

%inst
パーツに設定されている、ユーザーデータを、取得します。




→引数
 1. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。

2. [IN] 数値または、変数　：　partno
　　パーツを識別する番号を指定してください。

3. [OUT] 変数　：　dataptr
　　ユーザーデータが代入されます。



バージョン : ver1.0.0.1

%index
E3DSetUserInt1OfPart
パーツに、ユーザーデータをセットします。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　data

%inst
パーツに、ユーザーデータをセットします。


→引数
1. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。

2. [IN] 数値または、変数　：　partno
　　パーツを識別する番号を指定してください。

3. [IN] 数値または、変数　：　data
　　ユーザーデータを指定してください。



バージョン : ver1.0.0.1

%index
E3DGetBSphere

パーツ毎の、境界球情報を取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [OUT] 変数　：　centerx
p4 : [OUT] 変数　：　centery
p5 : [OUT] 変数　：　centerz
p6 : [OUT] 変数　：　r

%inst

パーツ毎の、境界球情報を取得します。
ボーン変形を考慮した、グローバル座標系の
値が取得できます。

html{
<strong>E3DChkInViewの計算結果を、もとにしています。</strong>
}html

表示用オブジェクトのみに対して有効です。
（ボーンに対して呼んでも、無意味です。）




→引数
1. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。

2. [IN] 数値または、変数　：　partno
　　パーツを識別する番号を指定してください。

3. [OUT] 変数　：　centerx
4. [OUT] 変数　：　centery
5. [OUT] 変数　：　centerz
　　境界球の中心座標が代入されます。
　　実数型の変数。

6. [OUT] 変数　：　r
　　境界球の半径が代入されます。
　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DGetChildJoint
指定したジョイントの、子供ジョイントの数と、子供のシリアル番号を取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　parentno
p3 : [IN] 数値または、変数　：　arrayleng
p4 : [OUT] 変数　：　childarray
p5 : [OUT] 変数　：　childnum

%inst
指定したジョイントの、子供ジョイントの数と、子供のシリアル番号を取得します。


childarray配列に、
子供の数分の、シリアル番号が
代入されます。

子供の数より、配列の長さが、大きいように
してください。




→引数
1. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。

2. [IN] 数値または、変数　：　parentno
　　親のジョイントの番号を指定してください。

3. [IN] 数値または、変数　：　arrayleng
　　childarray引数に格納できる要素数を指定してください。
　　dim childarray, 100とした場合は、
　　１００を指定してください。

　　childnum引数に代入される数が、arraylengより大きい場合は、
　　配列の長さが足りないことになります。


4. [OUT] 変数　：　childarray
　　子供ジョイントの、シリアル番号が、代入されます。
　　arraylengがchildnumより、小さい場合は、
　　arrayleng個の、シリアル番号しか、代入されません。

5. [OUT] 変数　：　childnum
　　子供ジョイントの数が、代入されます。



バージョン : ver1.0.0.1

%index
E3DDestroyMotionFrame
指定したキーフレームを削除します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　motid
p3 : [IN] 数値または、変数　：　frameno

%inst
指定したキーフレームを削除します。

html{
<strong>モーションの変更を反映させるには、
E3DFillUpMotionを呼ぶ必要があります。
</strong>
}html




→引数
1. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。

2. [IN] 数値または、変数　：　motid
　　モーションを識別する番号を指定してください。

3. [IN] 数値または、変数　：　frameno
　　削除するフレームの番号を指定してください。
　　-1を指定すると、全てのキーフレームを削除します。



バージョン : ver1.0.0.1

%index
E3DGetKeyFrameNo
指定したボーンの、キーフレームのフレーム番号を全て取得します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　motid
p3 : [IN] 数値または、変数　：　boneno
p4 : [OUT] 変数　：　framearray
p5 : [IN] 数値または、変数　：　arrayleng
p6 : [OUT] 変数　：　framenum

%inst
指定したボーンの、キーフレームのフレーム番号を全て取得します。


framearrayには、
dim framearray, 50
などで作成した、大きめの配列を使用してください。

配列の長さより、framenumが、大きい場合には、エラーになりますので、
注意してください。




→引数
1. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。

2. [IN] 数値または、変数　：　motid
　　モーションを識別する番号を指定してください。

3. [IN] 数値または、変数　：　boneno
　　ボーンパーツを識別する番号を指定してください。


4. [OUT] 変数　：　framearray
　　この配列に、フレーム番号が、代入されます。

5. [IN] 数値または、変数　：　arrayleng
　　framearrayをアロケート（dim）したときの要素数を指定してください。

6. [OUT] 変数　：　framenum
　　framearrayに格納した要素の数が代入されます。
　　キーフレームの数です。



バージョン : ver1.0.0.1

%index
E3DConvScreenTo3D
任意の２Ｄ座標を３Ｄ座標に変換します。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 変数または、数値　：　scid
p2 : [IN] 数値または、変数　：　x2d
p3 : [IN] 数値または、変数　：　y2d
p4 : [IN] 数値または、変数　：　z
p5 : [OUT] 変数　：　x3d
p6 : [OUT] 変数　：　y3d
p7 : [OUT] 変数　：　z3d

%inst
任意の２Ｄ座標を３Ｄ座標に変換します。

マウスの位置に対応する、３Ｄ座標を
求める場合などに、便利です。


この関数を使用して、
マウスクリックで、
３Ｄラインを描画するサンプルを
html{
<strong>e3dhsp3_DrawLine.hsp</strong>
}html
に書きましたので、ご覧ください。





→引数
1. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。

2. [IN] 数値または、変数　：　x2d
3. [IN] 数値または、変数　：　y2d
　　変換したい、マウスの位置などを、
　　(x2d, y2d)で指定します。

4. [IN] 数値または、変数　：　z
　　カメラからどのくらいの距離の平面上の点を取得するかを
　　指定します。

　　３Ｄ座標のＺの値ではありません。
　　カメラからの距離を制御出来るものと考えてください。
　　（距離の値とは違います。）

　　0.0のとき、カメラに一番近い座標がえられます。
　　1.0のとき、カメラから、一番遠い（見える範囲での）
　　座標がえられます。
　　見える範囲とは、
　　E3DSetProjectionで指定した範囲のことです。

　　実際のカメラの距離と、このzの値は、
　　比例関係にありません。

　　zの値をちょっと大きくしただけで、
　　カメラからの距離が大きく変わったり、
　　反対に、zを大きく変えても、
　　カメラからの距離が少ししか変わらない領域もあります。

　　０に近すぎる値では、
　　見えないことがあるので注意してください。

　　実数。

5. [OUT] 変数　：　x3d
6. [OUT] 変数　：　y3d
7. [OUT] 変数　：　z3d
　　上で指定した２Ｄ座標に対応する３Ｄ座標が、
　　（x3d, y3d, z3d）に代入されます。
　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DVec3Length
指定したベクトルの長さを取得します。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　vecx
p2 : [IN] 数値または、変数　：　vecy
p3 : [IN] 数値または、変数　：　vecz
p4 : [OUT] 変数　：　length

%inst
指定したベクトルの長さを取得します。

2点の距離の計算などに使ってください。
例えば、
(posx1, posy1, posz1)と(posx2, posy2, posz2)
の距離を計算したいときには、

vecx = posx1 - posx2
vecy = posy1 - posy2
vecz = posz1 - posz2
として、この関数に渡してください。




→引数
1. [IN] 数値または、変数　：　vecx
2. [IN] 数値または、変数　：　vecy
3. [IN] 数値または、変数　：　vecz
　　ベクトルを指定します。
　　実数。

4. [OUT] 変数　：　length
　　ベクトルの長さが代入されます。
　　実数型の変数。


バージョン : ver1.0.0.1

%index
E3DSetUV
テクスチャーのＵＶ座標をセットします。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　partno
p3 : [IN] 変数または、数値　：　vertno
p4 : [IN] 変数または、数値　：　u
p5 : [IN] 変数または、数値　：　v
p6 : [IN] 変数または、数値　：　setflag

%inst
テクスチャーのＵＶ座標をセットします。

partnoには、
E3DGetPartNoByNameで取得した番号を、
vertnoには、
E3DGetVertNumOfPartで取得した頂点数を
vertnumとしたとき、
0から(vertnum - 1)までの値を渡してください。

html{
<strong>
vertnoに-1を指定すると、
指定パーツの全ての頂点に対して、
処理を行うようにしました。
</strong>
}html




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　partno
　　パーツを識別する番号

3. [IN] 変数または、数値　：　vertno
　　頂点の番号

　　-1を指定すると、全ての頂点に対して処理します。


4. [IN] 変数または、数値　：　u
5. [IN] 変数または、数値　：　v
　　設定したいＵＶ値の値を指定してください。
　　通常は0.0から1.0の値。
　　実数。

6. [IN] 変数または、数値　：　setflag
　　setflag に０を指定すると、
　　指定ＵＶ値を、そのままセットします。

　　setflagに１を指定すると、
　　指定ＵＶ値を、既存のＵＶ値に、足し算します。



バージョン : ver1.0.0.1

%index
E3DGetUV
テクスチャーのＵＶ座標を取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　partno
p3 : [IN] 変数または、数値　：　vertno
p4 : [OUT] 変数　：　u
p5 : [OUT] 変数　：　v

%inst
テクスチャーのＵＶ座標を取得します。

partnoには、
E3DGetPartNoByNameで取得した番号を、
vertnoには、
E3DGetVertNumOfPartで取得した頂点数を
vertnumとしたとき、
0から(vertnum - 1)までの値を渡してください。





→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　partno
　　パーツを識別する番号

3. [IN] 変数または、数値　：　vertno
　　頂点の番号

4. [OUT] 変数　：　u
5. [OUT] 変数　：　v
　　ＵＶ座標の値が、代入されます。
　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DPickBone
指定した２Ｄ座標に近いジョイントの番号を取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　posx
p3 : [IN] 変数または、数値　：　posy
p4 : [OUT] 変数　：　jointno

%inst
指定した２Ｄ座標に近いジョイントの番号を取得します。

２Ｄ座標には、マウスの座標などを指定してください。


具体的な使用例は、
html{
<strong>e3dhsp3_MouseDePose.hsp</strong>
}html
に書きましたので、ご覧ください。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　posx
3. [IN] 変数または、数値　：　posy
　　２Ｄ座標を、（posx, posy）で指定します。

4. [OUT] 変数　：　jointno
　　指定した２Ｄ座標に近いジョイントがある場合には、
　　そのジョイントのＩＤが代入されます。
　　
　　近くにジョイントがない場合には、０以下が代入されます。



バージョン : ver1.0.0.1

%index
E3DShiftBoneTree2D
指定した２Ｄ座標に近づくように、ボーンツリー全体を、移動します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 変数または、数値　：　scid
p2 : [IN] 数値または、変数　：　hsid
p3 : [IN] 数値または、変数　：　jointno
p4 : [IN] 数値または、変数　：　motid
p5 : [IN] 数値または、変数　：　frameno
p6 : [IN] 数値または、変数　：　target2dx
p7 : [IN] 数値または、変数　：　target2dy

%inst
指定した２Ｄ座標に近づくように、ボーンツリー全体を、移動します。


具体的な使用例は、
html{
<strong>e3dhsp3_MouseDePose.hsp</strong>
}html
に書きましたので、ご覧ください。




→引数
1. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。

2. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

3. [IN] 数値または、変数　：　jointno
　　ジョイントを識別するＩＤ
　　E3DPickBoneなどで取得した、
　　ジョイントの番号を渡してください。

4. [IN] 数値または、変数　：　motid
　　モーションを識別するＩＤ
　　E3DAddMotionで取得したmotidを指定してください。

5. [IN] 数値または、変数　：　frameno
　　ポーズを設定したいフレーム番号を指定してください。

6. [IN] 数値または、変数　：　target2dx
7. [IN] 数値または、変数　：　target2dy
　　jointnoで指定したジョイントが、
　　指定した２Ｄ座標に近づくように、
　　ボーンツリー全体が移動します。



バージョン : ver1.0.0.1

%index
E3DGetDispSwitch
ディスプレイスイッチの状態を取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　motid
p3 : [IN] 数値または、変数　：　frameno
p4 : [OUT] 変数　：　dispswitch

%inst
ディスプレイスイッチの状態を取得します。

ディスプレイスイッチ情報は、ビットごとの和になっています。
ディスプレイスイッチ番号ds がオンの場合は、
２のds乗の値が足されていることになります。
例えば、ディスプレイスイッチ３だけがオンの場合は、２の3乗の８という値が代入されています。


ディスプレイスイッチがオンになっているかを調べて処理するには、
＆演算子と、２のスイッチ番号乗の値を使います。

例えば、スイッチ3がオンかどうかを調べるには、

if( (dispswitch &amp; 8) != 0 ) {
　　//オンの時の処理
} else {
　　//オフの時の処理
}

のようにします。

html{
<strong>この命令はver5.0.0.1以降は機能しません。
新しいE3DGetDispSwitch2をご利用ください。
</strong>
}html



→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　motid
　　モーションを識別するＩＤ

　　motidに-1を指定すると、
　　E3DSetDispSwitchで、motidに-1を指定して設定した値が
　　dispswitch引数に代入されます。

　　motidに-2を指定すると、
　　現在設定されている、モーションのスイッチ状態が、
　　dispswitch引数に代入されます。

3. [IN] 数値または、変数　：　frameno
　　フレーム番号を指定してください。

　　framenoに-1を指定すると、
　　現在のフレーム番号の、スイッチ状態が、
　　dispswitch引数に代入されます。

4. [OUT] 変数　：　dispswitch
　　スイッチの状態が代入されます。
　　詳しくは、左記をご覧ください。



バージョン : ver1.0.0.1

%index
E3DRotateBillboard
ビルボードを、カメラの方向を向けたまま、回転します。
%group
Easy3D For HSP3 : ビルボード

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　billboardid
p2 : [IN] 変数または、数値　：　rotdeg
p3 : [IN] 変数または、数値　：　rotkind

%inst
ビルボードを、カメラの方向を向けたまま、回転します。




→引数
1. [IN] 変数または、数値　：　billboardid
　　ビルボードを識別する番号

2. [IN] 変数または、数値　：　rotdeg
　　ビルボードを、rotdeg度だけ、
　　回転します。
　　実数。

3. [IN] 変数または、数値　：　rotkind

　　rotkindに０を指定すると、相対値モードになります
　　現在のビルボードの向きに、
　　更に、指定角度だけ、回転を加えます。

　　rotkindに１を指定すると、絶対値モードになります。
　　初期状態に対して、指定角度だけ、回転を加えます。



バージョン : ver1.0.0.1

%index
E3DSetBillboardUV
ビルボードのＵＶを設定します。
%group
Easy3D For HSP3 : ビルボード

%prm
p1,p2,p3,p4
p1 : [IN] 変数または、数値　：　bbid
p2 : [IN] 変数または、数値　：　unum
p3 : [IN] 変数または、数値　：　vnum
p4 : [IN] 変数または、数値　：　tileno

%inst
ビルボードのＵＶを設定します。

横方向にunum個、縦方向にvnum個の、タイル状に作ったテクスチャーの、タイルの番号を指定することで、指定した画像のＵＶを設定します。

タイル状のテクスチャ画像とタイル番号の対応は、(Link http://www5d.biglobe.ne.jp/~ochikko/e3dhsp_texturetile.htm )タイル番号の説明をご覧ください。


タイルの数が12個の場合は、
タイルの番号は、０から１１になりますが、
それより大きな値や小さな値を指定することも可能です。

例えば、タイルの数が12個の場合、
１２を指定すると、
タイル番号０が表示され、
13を指定すると、
タイル番号１が表示され、
-1を指定すると、
タイル番号１１が表示されるという具合に
機能します。





→引数
1. [IN] 変数または、数値　：　bbid
　　ビルボードを識別するid

2. [IN] 変数または、数値　：　unum
3. [IN] 変数または、数値　：　vnum
　　タイルの横と縦の個数

4. [IN] 変数または、数値　：　tileno
　　設定したいテクスチャのタイルの番号



バージョン : ver1.0.0.1

%index
E3DCreateTexture
指定したファイルからテクスチャを作ります。
%group
Easy3D For HSP3 : テクスチャ

%prm
p1,p2,p3,p4
p1 : [IN] 文字列または、文字列の変数　：　filename
p2 : [IN] 変数または、数値　：　pool
p3 : [IN] 変数または、数値　：　transparent
p4 : [OUT] 変数　：　texid

%inst
指定したファイルからテクスチャを作ります。画面と同じテクスチャを作ることも可能です。

テクスチャの操作には、この関数で取得した
テクスチャのＩＤ、texidを使用してください。


transparentに１（黒透過）を指定した場合には、
黒透過処理が行われます。
D3DPOOL_DEFAULTで、
テクスチャを作成する場合には、transparentに１を指定すると失敗することがあります。


filenameに、&quot;MainWindow&quot;を指定すると、
バックバッファと同じ内容で、
同じ大きさのサーフェスを作成します。
この際、poolに何を指定しても、
強制的に、システムメモリに作成します。
また、このとき、transparentに１を指定できません。

&quot;MainWindow&quot;を指定した場合は、
E3DSetTextureToDispObjは、使えません。
E3DCopyTextureToBackBufferを使ってください。


&quot;MainWindow&quot;を指定したときは、バックバッファと同じフォーマットで、それ以外は、D3DFMT_A8R8G8B8で作成します。
DX8からDX9への移行時の変更の関係で、
ver3.0.3.4現在、&quot;MainWindow&quot;指定は使用できない状態です。


具体的な使用例は、
html{
<strong>e3dhsp3_TextureChange.hsp</strong>
}html
に書きましたので、ご覧ください。




→引数
1. [IN] 文字列または、文字列の変数　：　filename
　　テクスチャファイル のパス文字列。
　　&quot;MainWindow&quot;を指定すると、
　　画面と同じ内容で、同じ大きさのテクスチャが作成されます。
　　ただし、このとき、注意する点がいつくかあるので、
　　左記をご覧ください。


2. [IN] 変数または、数値　：　pool
　　どのメモリ位置にテクスチャを作成するかを指定します。

　　e3dhsp3.asで定義してある
　　D3DPOOL_DEFAULT　（普通はビデオメモリに作られます）
　　D3DPOOL_MANAGED　（DirectXの管理（バックアップ有り））
　　D3DPOOL_SYSTEMMEM　（システムメモリに作られます）
　　の中から選びます。


3. [IN] 変数または、数値　：　transparent
　　透過情報を指定します。

　　０を指定すると、不透明のテクスチャ。
　　１を指定すると、黒色を透過するテクスチャ。
　　２を指定すると、テクスチャファイルのアルファに従って
　　透過するテクスチャになります。


4. [OUT] 変数　：　texid
　　作成したテクスチャを識別するＩＤ
　　テクスチャ操作の際には、このＩＤを使用してください。




バージョン : ver1.0.0.1

%index
E3DGetTextureInfo
作成したテクスチャの情報を取得します。
%group
Easy3D For HSP3 : テクスチャ

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 変数または、数値　：　texid
p2 : [OUT] 変数　：　width
p3 : [OUT] 変数　：　height
p4 : [OUT] 変数　：　pool
p5 : [OUT] 変数　：　transparent
p6 : [OUT] 変数　：　format

%inst
作成したテクスチャの情報を取得します。

テクスチャのサイズは、
ビデオカードによっては、２の乗数のサイズしか
確保できないので、
ファイルのサイズと異なる場合があります。





→引数
1. [IN] 変数または、数値　：　texid
　　テクスチャを識別するＩＤ

2. [OUT] 変数　：　width
3. [OUT] 変数　：　height
　　テクスチャの幅と高さ

4. [OUT] 変数　：　pool
　　作成メモリ位置

5. [OUT] 変数　：　transparent
　　透過モード

6. [OUT] 変数　：　format
　　フォーマット



バージョン : ver1.0.0.1

%index
E3DCopyTextureToTexture
テクスチャからテクスチャへ、内容をコピーします。
%group
Easy3D For HSP3 : テクスチャ

%prm
p1,p2
p1 : [IN] 変数または、数値　：　srctexid
p2 : [IN] 変数または、数値　：　dsttexid

%inst
テクスチャからテクスチャへ、内容をコピーします。

srcとdstで大きさや、フォーマットが違う場合は、
エラーになります。




→引数
1. [IN] 変数または、数値　：　srctexid
　　コピー元のテクスチャを識別するＩＤ

2. [IN] 変数または、数値　：　dsttexid
　　コピーされるテクスチャを識別するＩＤ



バージョン : ver1.0.0.1

%index
E3DGetTextureFromDispObj
読み込み済の３Ｄオブジェクトに設定されているテクスチャを取得します。
%group
Easy3D For HSP3 : テクスチャ

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　partno
p3 : [OUT] 変数　：　texid

%inst
読み込み済の３Ｄオブジェクトに設定されているテクスチャを取得します。

sigモデルデータに対する操作には
E3DGetTextureFromMaterialをお使いください。





→引数
1. [IN] 変数または、数値　：　hsid
　　モデルデータを識別するＩＤ

　　-1を指定すると、ビルボードの処理を行います。

2. [IN] 変数または、数値　：　partno
　　パーツの番号。
　　E3DGetPartNoByNameで取得した番号を指定してください。

　　hsidに-1を指定した場合には、
　　ビルボードのＩＤを指定してください。

3. [OUT] 変数　：　texid
　　テクスチャを識別するID
　　指定したパーツにテクスチャが貼られていない場合には、
　　texidには、-1が代入されます。




バージョン : ver1.0.0.1

%index
E3DSetTextureToDispObj
読み込み済の３Ｄオブジェクトに、テクスチャを設定します。
%group
Easy3D For HSP3 : テクスチャ

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　partno
p3 : [IN] 変数または、数値　：　texid

%inst
読み込み済の３Ｄオブジェクトに、テクスチャを設定します。

sigモデルデータに対する操作には
E3DSetTextureToMaterialをお使いください。


テクスチャをセットしても、
ＵＶ座標は自動的に生成されません。
動的にテクスチャを設定する場合は、
ＵＶ座標も、E3DSetUVで、設定するか、
もしくは、
あらかじめ、モデルに仮のテクスチャを貼っておいて、ＵＶ設定しておく必要があります。


具体的な使用例は、
html{
<strong>e3dhsp3_TextureChange.hsp</strong>
}html
に書きましたので、ご覧ください。




→引数
1. [IN] 変数または、数値　：　hsid
　　モデルデータを識別するＩＤ

　　-1を指定すると、ビルボードの処理を行います。
　　-2を指定するとスプライトの処理を行います。

2. [IN] 変数または、数値　：　partno
　　パーツの番号。
　　E3DGetPartNoByNameで取得した番号を指定してください。

　　hsidに-1を指定した場合には、
　　ビルボードのＩＤを指定してください。

　　hsidに-2を指定した場合には
　　スプライトのIDを指定してください。

3. [IN] 変数または、数値　：　texid
　　貼り付けたいテクスチャのＩＤを指定します。



バージョン : ver1.0.0.1

%index
E3DRasterScrollTexture
テクスチャに、ラスタースクロール処理を加えます。
%group
Easy3D For HSP3 : テクスチャ

%prm
p1,p2,p3,p4,p5
p1 : [IN] 変数または、数値　：　srctexid
p2 : [IN] 変数または、数値　：　desttexid
p3 : [IN] 変数または、数値　：　t
p4 : [IN] 変数または、数値　：　param1
p5 : [IN] 変数または、数値　：　param2

%inst
テクスチャに、ラスタースクロール処理を加えます。

ゆらゆらと揺れる効果が得られます。

srctexidとdesttexidは、同じ時は、エラーになります。
srcとdestで、大きさ、フォーマットが違うときも、エラーになります。
texidには、両方とも、D3DPOOL_SYSTEMMEMで作成したテクスチャーを指定してください。
それ以外も可能ですが、極端に処理速度が落ちます。
ビデオメモリにラスター処理をしたい場合は、
システムメモリのテクスチャー同士で、ラスター処理をしたあと、
ビデオメモリのテクスチャーに、E3DCopyTextureToTextureで転送してください。
DX8からDX9への移行時の変更の関係で、
ver3.0.3.4現在この命令は使用できない状態です。



→引数
1. [IN] 変数または、数値　：　srctexid
　　処理する前のテクスチャを識別するＩＤ

2. [IN] 変数または、数値　：　desttexid
　　処理した結果を格納するテクスチャを識別するＩＤ

3. [IN] 変数または、数値　：　t
　　時間経過を指定します。

4. [IN] 変数または、数値　：　param1
　　揺れの縦方向の具合を指定します。
　　param1の値が大きいほど、
　　変化が激しくなります。
　　実数。

5. [IN] 変数または、数値　：　param2
　　揺れの横方向の具合を指定します。
　　param2の値が大きいほど、
　　変化が激しくなります。
　　実数。



バージョン : ver1.0.0.1

%index
E3DCopyTextureToBackBuffer
テクスチャをバックバッファにコピーします。
%group
Easy3D For HSP3 : テクスチャ

%prm
p1
p1 : [IN] 変数または、数値　：　texid

%inst
テクスチャをバックバッファにコピーします。

E3DCreateTextureで、
filenameに&quot;MainWindow&quot;を指定して作成した
テクスチャーを、バックバッファにコピーします。

フォーマットが異なる場合は、失敗します。




→引数
1. [IN] 変数または、数値　：　texid
　　コピー元のテクスチャを識別するＩＤ



バージョン : ver1.0.0.1

%index
E3DDestroyTexture
テクスチャを破棄します。
%group
Easy3D For HSP3 : テクスチャ

%prm
p1
p1 : [IN] 変数または、数値　：　texid

%inst
テクスチャを破棄します。




→引数
1. [IN] 変数または、数値　：　texid
　　テクスチャを識別するＩＤ



バージョン : ver1.0.0.1

%index
E3DSetLightAmbient
ライトのアンビエント色を指定します。
%group
Easy3D For HSP3 : ライト

%prm
p1,p2,p3,p4
p1 : [IN] 変数または、数値　：　lightid
p2 : [IN] 変数または、数値　：　R
p3 : [IN] 変数または、数値　：　G
p4 : [IN] 変数または、数値　：　B

%inst
ライトのアンビエント色を指定します。
地面データにのみ、影響します。

この命令は、現在サポートされていません。



→引数
1. [IN] 変数または、数値　：　lightid
　　ライトを識別するＩＤ

2. [IN] 変数または、数値　：　R
3. [IN] 変数または、数値　：　G
4. [IN] 変数または、数値　：　B
　　色のＲＧＢを０から２５５までの値で、指定します。



バージョン : ver1.0.0.1

%index
E3DSetLightSpecular
ライトのスペキュラー色を指定します。
%group
Easy3D For HSP3 : ライト

%prm
p1,p2,p3,p4
p1 : [IN] 変数または、数値　：　lightid
p2 : [IN] 変数または、数値　：　R
p3 : [IN] 変数または、数値　：　G
p4 : [IN] 変数または、数値　：　B

%inst
ライトのスペキュラー色を指定します。




→引数
1. [IN] 変数または、数値　：　lightid
　　ライトを識別するＩＤ

2. [IN] 変数または、数値　：　R
3. [IN] 変数または、数値　：　G
4. [IN] 変数または、数値　：　B
　　色のＲＧＢを０から２５５までの値で、指定します。



バージョン : ver1.0.0.1

%index
E3DInvColTexture
テクスチャの色を反転します。
%group
Easy3D For HSP3 : テクスチャ

%prm
p1
p1 : [IN] 変数または、数値　：　texid

%inst
テクスチャの色を反転します。

具体的な使用例は、
html{
<strong>e3dhsp_TextureRasteras</strong>
}html
に書きましたので、ご覧ください。



→引数
1. [IN] 変数または、数値　：　texid
　　テクスチャを識別するＩＤ



バージョン : ver1.0.0.1

%index
E3DSaveGndFile
地面データをgndファイルに保存します。
%group
Easy3D For HSP3 : 地面出力

%prm
p1,p2
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 文字列または、文字列変数　：　filename

%inst
地面データをgndファイルに保存します。

この関数はサポートが中止されました。
地面を高速に読み込みたい場合はsigを使ってください。




→引数
1. [IN] 数値または、変数　：　hsid
　　地面データを識別するＩＤ

2. [IN] 文字列または、文字列変数　：　filename
　　保存ファイル名（パス）を指定してください。



バージョン : ver1.0.0.1

%index
E3DLoadGndFile
地面データ（*.gnd）を読み込んで、hsidを得る。
%group
Easy3D For HSP3 : 地面

%prm
p1,p2,p3,p4
p1 : [IN] 文字列または、文字列の変数　：　fname
p2 : [OUT] 変数　：　hsid
p3 : [IN] 変数または、数値　：　adjustuvflag
p4 : [IN] 変数または、数値　：　mult

%inst
地面データ（*.gnd）を読み込んで、hsidを得る。

gndファイルの読み込み速度は、mqoファイルの読み込みよりも、
だいぶ速くなります。




→引数
1. [IN] 文字列または、文字列の変数　：　fname
　　*.gnd のパス文字列。

2. [OUT] 変数　：　hsid
　　読み込んだ形状データを識別するhsid

3. [IN] 変数または、数値　：　adjustuvflag
　　ＵＶ値を正規化するかどうかのフラグ
　　正規化する場合は１を指定
　　しない場合は０を指定

4. [IN] 変数または、数値　：　mult
　　読み込み倍率を指定してください。
　　等倍は１．０。
　　実数。




バージョン : ver1.0.0.1

%index
E3DLoadGndFileFromBuf
メモリから地面データのロードを行います。
%group
Easy3D For HSP3 : 地面

%prm
p1,p2,p3,p4,p5
p1 : [IN] 文字列または、文字列の変数　：　resdir
p2 : [IN] 変数　：　buf
p3 : [IN] 変数または、数値　：　bufleng
p4 : [OUT] 変数　：　hsid
p5 : [IN] 変数または、数値　：　adjustuvflag

%inst
メモリから地面データのロードを行います。
メモリ内には、gndファイルと同じフォーマットが
入っているとみなして、処理します。

テクスチャファイルは、通常読込と同様に、
ファイルから行います。

resdirには、テクスチャの存在するフォルダのパスを指定してください。
html{
<strong>最後に、&quot;\\&quot;を付けるのを忘れないでください。</strong>
}html

例えば、
resdir = &quot;C:\\hsp\\Meida\\&quot;
や
resdir = dir_cur+ &quot;\\&quot;
などのように指定してください。





→引数
1. [IN] 文字列または、文字列の変数　：　resdir
　　テクスチャーのあるフォルダ のパス文字列。
　　最後に、&quot;\\&quot;が必要。

2. [IN] 変数　：　buf
　　バッファの変数

3. [IN] 変数または、数値　：　bufleng
　　バッファの中のデータの長さ

4. [OUT] 変数　：　hsid
　　読み込んだ形状データを識別するhsid

5. [IN] 変数または、数値　：　adjustuvflag
　　ＵＶ値を正規化するかどうかのフラグ
　　正規化する場合は１を指定
　　しない場合は０を指定




バージョン : ver1.0.0.1

%index
E3DCreateTextureFromBuf
メモリに読み込んだ絵のデータから、テクスチャを作成します。
%group
Easy3D For HSP3 : テクスチャ

%prm
p1,p2,p3,p4,p5
p1 : [IN] 変数　：　buf
p2 : [IN] 変数または、数値　：　bufleng
p3 : [IN] 変数または、数値　：　pool
p4 : [IN] 変数または、数値　：　transparent
p5 : [OUT] 変数　：　texid

%inst
メモリに読み込んだ絵のデータから、テクスチャを作成します。

filenameの代わりに、バッファを指定し、
&quot;MainWindow&quot;が扱えないこと以外は、
E3DCreateTextureと同じです。

E3DCreateTextureの説明を、
お読みください。


例えば、以下のような使い方になります。

sdim buf0, 800000 ;ファイルサイズより大きめ
bload &quot;pict.bmp&quot;, buf0
bufsize0 = strsize
E3DCreateTextureFromBuf buf0, bufsize0, D3DPOOL_MANAGED, 1, texid0





→引数
1. [IN] 変数　：　buf
　　バッファの変数

2. [IN] 変数または、数値　：　bufleng
　　バッファの中のデータの長さ(バイト)

3. [IN] 変数または、数値　：　pool
　　どのメモリ位置にテクスチャを作成するかを指定します。

　　e3dhsp3.asで定義してある
　　D3DPOOL_DEFAULT　（普通はビデオメモリに作られます）
　　D3DPOOL_MANAGED　（DirectXの管理（バックアップ有り））
　　D3DPOOL_SYSTEMMEM　（システムメモリに作られます）
　　の中から選びます。


4. [IN] 変数または、数値　：　transparent
　　透過情報を指定します。

　　０を指定すると、不透明のテクスチャ。
　　１を指定すると、黒色を透過するテクスチャ。
　　２を指定すると、テクスチャファイルのアルファに従って
　　透過するテクスチャになります。


5. [OUT] 変数　：　texid
　　作成したテクスチャを識別するＩＤ
　　テクスチャ操作の際には、このＩＤを使用してください。



バージョン : ver1.0.0.1

%index
E3DLoadSoundFromBuf
メモリから音データを読み込み、ＩＤを取得します。
%group
Easy3D For HSP3 : サウンド

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 変数　：　buf
p2 : [IN] 変数または、数値　：　bufleng
p3 : [IN] 変数または、数値　：　type
p4 : [IN] 変数または、数値　：　use3dflag
p5 : [IN] 変数または、数値　：　bufnum
p6 : [OUT] 変数　：　soundid

%inst
メモリから音データを読み込み、ＩＤを取得します。

メモリから読み込むこと以外は、
E3DLoadSoundと同じです。

E3DLoadSoundの説明をお読みください。




→引数
1. [IN] 変数　：　buf
　　バッファの変数

2. [IN] 変数または、数値　：　bufleng
　　バッファの中のデータの長さ(バイト)

3. [IN] 変数または、数値　：　type
　　midiのときは１、それ以外は０を指定してください。

4. [IN] 変数または、数値　：　use3dflag
　　ファイルをステレオサウンドとして読み込む場合は０を、
　　３Ｄサウンドとして読み込む場合は１を指定してください。
　　指定しなかった場合は、ステレオサウンドと見なされます。

5. [IN] 変数または、数値　：　bufnum
　　同じＩＤの、３Ｄサウンドを、同時にいくつ重ねて再生できるかを
　　指定します。

　　３Ｄサウンドではない場合は、
　　今まで通り、DirectMusicが、自動的に、
　　重ねて再生してくれます。

6. [OUT] 変数　：　soundid
　　作成した音データを識別する番号が代入されます。



バージョン : ver1.0.0.1

%index
E3DTwistBone
ボーンをツイストします。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4,p5
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　motid
p3 : [IN] 変数または、数値　：　frameno
p4 : [IN] 変数または、数値　：　jointno
p5 : [IN] 変数または、数値　：　twistdeg

%inst
ボーンをツイストします。

指定したジョイントと、その親のジョイントのベクトルを軸として、回転します。

boneno引数に指定したジョイントに
親のジョイントがない場合は、
この関数を呼んでも、
何も効果はありません。





→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　motid
　　モーションを識別する番号

3. [IN] 変数または、数値　：　frameno
　　操作するモーションのフレーム番号

4. [IN] 変数または、数値　：　jointno
　　ジョイントを識別する番号
　　E3DGetPartNoByNameなどで取得した値や、
　　E3DGetJointInfoで取得したシリアル番号を指定してください。
　　ジョイント以外のパーツの番号を指定すると
　　エラーになります。


5. [IN] 変数または、数値　：　twistdeg
　　twistdeg 度だけ、ツイストします。
　　実数。



バージョン : ver1.0.0.1

%index
E3DSetStartPointOfSound
音の再生開始位置を指定します。
%group
Easy3D For HSP3 : サウンド

%prm
p1,p2
p1 : [IN] 変数または、数値　：　soundid
p2 : [IN] 変数または、数値　：　time

%inst
音の再生開始位置を指定します。

E3DPlaySoundの直前に呼んでください。

E3DLoadSoundのbufnum引数に１を指定していて、3Ｄサウンドの場合は、
再生中の音にも影響します。

time引数は、
midiの場合と、３Ｄサウンド(wav)の場合で
意味が異なりますので、注意してください。

midiと、3Dサウンドのための関数です。
html{
<strong>３Ｄサウンド以外のwavには、
効果がありません。</strong>
}html




→引数
1. [IN] 変数または、数値　：　soundid
　　音を識別する番号を、指定します。

2. [IN] 変数または、数値　：　time
　　３Ｄサウンドの場合は、
　　ミリ秒（1秒が１０００）を指定してください。

　　midiの場合は、4分音符の数による数値を指定してください。
　　4分音符あたり768の数値を指定してください。




バージョン : ver1.0.0.1

%index
E3DGetBoneQ
ボーンのクォータニオンを取得します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　boneno
p3 : [IN] 数値または、変数　：　motid
p4 : [IN] 数値または、変数　：　frameno
p5 : [IN] 数値または、変数　：　kind
p6 : [IN, OUT] 数値または、変数　：　qid

%inst
ボーンのクォータニオンを取得します。

kind引数の値により、
親のクォータニオンの影響を受けたものと、
受けていないものを取得できます。

モーションを読み込んでいないときは、
エラーになります。

指定したframenoに、キーフレームがない場合は、
補間計算した結果を取得します。

エンドジョイント（子供を持たないジョイント）
に対しても、呼ぶことが出来ます。

ボーン以外の番号をbonenoに入れると
エラーになります。

マルチレイヤーモーションを使用する場合は
この命令は使えません。
E3DGetCurrentBoneQをお使いください。




→引数
1. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。

2. [IN] 数値または、変数　：　boneno
　　ボーンを識別する番号を指定してください。
　　E3DGetBoneNoByNameまたは、
　　E3DGetPartNoByNameで取得した番号を指定してください。

3. [IN] 数値または、変数　：　motid
　　モーションを識別する番号を指定してください。

4. [IN] 数値または、変数　：　frameno
　　フレームの番号を指定してください。

5. [IN] 数値または、変数　：　kind
　　親の影響を受けたクォータニオンを
　　取得する場合は、１を指定してください。

　　親の影響を受けていないクォータニオンを
　　取得する場合は、０を指定してください。

　　親の影響を受け、
　　更に、モデル全体の向きの影響を受けたクォータニオンを取得
　　するには、２を指定してください。


6. [IN, OUT] 数値または、変数　：　qid
　　クォータニオンを識別する番号。
　　E3DCreateQで取得した番号を指定してください。

　　qidで識別されるクォータニオンの内容に、
　　指定したボーンのクォータニオンの内容を、
　　代入します。



バージョン : ver1.0.0.1

%index
E3DSetBoneQ
ボーンのクォータニオンをセットします。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　boneno
p3 : [IN] 数値または、変数　：　motid
p4 : [IN] 数値または、変数　：　frameno
p5 : [IN] 数値または、変数　：　qid

%inst
ボーンのクォータニオンをセットします。

指定したフレームに、モーションポイントが存在しない場合は、
自動的に、モーションポイントを作成した後、
クォータニオンをセットします。

E3DFillUpMotionを呼び出さないと、
他のフレームには、反映されません。






→引数
1. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。

2. [IN] 数値または、変数　：　boneno
　　ボーンを識別する番号を指定してください。
　　E3DGetBoneNoByNameまたは、
　　E3DGetPartNoByNameで取得した番号を指定してください。

3. [IN] 数値または、変数　：　motid
　　モーションを識別する番号を指定してください。

4. [IN] 数値または、変数　：　frameno
　　フレームの番号を指定してください。

5. [IN] 数値または、変数　：　qid
　　クォータニオンを識別する番号。
　　E3DCreateQで取得した番号を指定してください。

　　qidで識別されるクォータニオンの内容を、
　　ボーンの姿勢にセットします。



バージョン : ver1.0.0.1

%index
E3DIsSoundPlaying
音が再生中かどうかを調べます。
%group
Easy3D For HSP3 : サウンド

%prm
p1,p2
p1 : [IN] 変数または、数値　：　soundid
p2 : [OUT] 変数　：　playing

%inst
音が再生中かどうかを調べます。




→引数
1. [IN] 変数または、数値　：　soundid
　　音を識別する番号を、指定します。

2. [OUT] 変数　：　playing
　　再生中の場合は１が、
　　そうでない場合は０が、代入されます。




バージョン : ver1.0.0.1

%index
E3DIKTranslate
ＩＫで、ボーンの位置を移動します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　boneno
p3 : [IN] 数値または、変数　：　motid
p4 : [IN] 数値または、変数　：　frameno
p5 : [IN] 数値または、変数　：　posx
p6 : [IN] 数値または、変数　：　posy
p7 : [IN] 数値または、変数　：　posz

%inst
ＩＫで、ボーンの位置を移動します。
RokDeBone2のＴボタンと同様に、
一番親のボーン以外で、この関数を呼ぶと、
モデルの形状が、崩れます。
形状を保ちたい場合は、E3DIKRotateBetaを使用してください。

位置には、グローバル座標を指定してください。

モーションを読み込んでいないと、エラーになります。

framenoに、モーションポイントがない場合は、
自動的に作成した後に、移動をセットします。

ジョイント以外に対して呼ぶとエラーになります。

他のフレームにも、結果を反映させたい場合は、
E3DFillUpMotionを呼んでください。





→引数
1. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。

2. [IN] 数値または、変数　：　boneno
　　ボーンを識別する番号を指定してください。
　　E3DGetBoneNoByNameまたは、
　　E3DGetPartNoByNameで取得した番号を指定してください。

3. [IN] 数値または、変数　：　motid
　　モーションを識別する番号を指定してください。

4. [IN] 数値または、変数　：　frameno
　　フレームの番号を指定してください。

5. [IN] 数値または、変数　：　posx
6. [IN] 数値または、変数　：　posy
7. [IN] 数値または、変数　：　posz
　　ボーンを移動させたいグローバル座標を、
　　（posx, posy, posz）で指定します。
　　実数。




バージョン : ver1.0.0.1

%index
E3DSetUVTile
ひとつの画像に、タイル画像を敷き詰めたテクスチャの、ＵＶ座標を、タイル番号で、セットできます。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　texrule
p4 : [IN] 数値または、変数　：　unum
p5 : [IN] 数値または、変数　：　vnum
p6 : [IN] 数値または、変数　：　tileno

%inst
ひとつの画像に、タイル画像を敷き詰めたテクスチャの、ＵＶ座標を、タイル番号で、セットできます。

タイル状のテクスチャ画像とタイル番号の対応は、(Link http://www5d.biglobe.ne.jp/~ochikko/e3dhsp_texturetile.htm )タイル番号の説明をご覧ください。


タイルの数が12個の場合は、
タイルの番号は、０から１１になりますが、
それより大きな値や小さな値を指定することも可能です。

例えば、タイルの数が12個の場合、
１２を指定すると、
タイル番号０が表示され、
13を指定すると、
タイル番号１が表示され、
-1を指定すると、
タイル番号１１が表示されるという具合に
機能します。



5種類の投影、貼り付けをサポートします。





→引数
1. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。

2. [IN] 数値または、変数　：　partno
　　表示パーツを識別する番号を指定してください。
　　E3DGetPartNoByNameで取得した番号を指定してください。

3. [IN] 数値または、変数　：　texrule
　　投影、貼り付けのモードを指定します。

　　０を指定すると、Ｘ軸投影
　　１を指定すると、Ｙ軸投影
　　２を指定すると、Ｚ軸投影
　　３を指定すると、円筒貼り付け
　　４を指定すると、球貼り付け
　　です。


4. [IN] 数値または、変数　：　unum
　　テクスチャのタイル画像の
　　横方向の個数を指定してください。

5. [IN] 数値または、変数　：　vnum
　　テクスチャのタイル画像の
　　縦方向の個数を指定してください。

6. [IN] 数値または、変数　：　tileno
　　表示したいタイルの番号を指定してください。
　　タイル番号については、左記をお読みください。



バージョン : ver1.0.0.1

%index
E3DImportMQOFileAsGround
hsidに読み込み済の地面データに、
filenameで指定した地面データを
インポート（追加読み込み）します。
%group
Easy3D For HSP3 : 地面

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9,p10
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 文字列または、文字列変数　：　filename
p3 : [IN] 変数または、数値　：　adjustuvflag
p4 : [IN] 変数または、数値　：　mult
p5 : [IN] 変数または、数値　：　offsetx
p6 : [IN] 変数または、数値　：　offsety
p7 : [IN] 変数または、数値　：　offsetz
p8 : [IN] 変数または、数値　：　rotx
p9 : [IN] 変数または、数値　：　roty
p10 : [IN] 変数または、数値　：　rotz

%inst
hsidに読み込み済の地面データに、
filenameで指定した地面データを
インポート（追加読み込み）します。







→引数
1. [IN] 数値または、変数　：　hsid
　　読み込み済の地面モデルを識別する番号を
　　指定してください。

2. [IN] 文字列または、文字列変数　：　filename
　　読み込む、mqo ファイル名。

3. [IN] 変数または、数値　：　adjustuvflag
　　UV座標を正規化したいときは１を、
　　そうでないときは、０を指定してください。

4. [IN] 変数または、数値　：　mult
　　形状データの座標に掛ける数値。
　　座標値　＊　multで計算されます。
　　等倍は１．０。
　　実数。

5. [IN] 変数または、数値　：　offsetx
6. [IN] 変数または、数値　：　offsety
7. [IN] 変数または、数値　：　offsetz
　　読み込み位置のオフセット座標を、
　　（offsetx, offsety, offsetz）で指定します。
　　ローカル座標で指定します。
　　実数。

8. [IN] 変数または、数値　：　rotx
9. [IN] 変数または、数値　：　roty
10. [IN] 変数または、数値　：　rotz
　　追加形状を、Ｘ，Ｙ，Ｚそれぞれの軸に対して、
　　rotx, roty, rotz度だけ、回転してから、
　　インポートを行います。
　　回転順序は、Ｚ，Ｙ，Ｘの順番です。
　　実数。

パラメータの適用順序は、
まず、倍率を掛けて、
次に、回転をして、
最後に、移動します。


バージョン : ver1.0.0.1

%index
E3DLoadMQOFileAsMovableAreaFromBuf
移動可能領域を定義するデータを、メモリから読み込みます。
%group
Easy3D For HSP3 : 壁

%prm
p1,p2,p3,p4
p1 : [IN] 変数　：　buf
p2 : [IN] 変数または、数値　：　bufleng
p3 : [IN] 変数または、数値　：　mult
p4 : [OUT] 変数　：　hsid

%inst
移動可能領域を定義するデータを、メモリから読み込みます。

メモリから読み込むこと以外は、
E3DLoadMQOFileAsMovableArea
と同じです。
E3DLoadMQOFileAsMovableArea
の説明をお読みください。

メモリから読み込む手順は、
sdim buf0, 500000 ;ファイルサイズより大きく
bload ファイル名, buf0
bufsize = strsize

E3DLoadMQOFileAsMovableAreaFromBuf
buf0, bufsize, mult100, hsid

という流れになります。






→引数
1. [IN] 変数　：　buf
　　バッファの変数

2. [IN] 変数または、数値　：　bufleng
　　バッファの中のデータの長さ

3. [IN] 変数または、数値　：　mult
　　形状データの座標に掛ける数値。
　　座標値　＊　mult で計算されます。
　　等倍は１．０。
　　実数。

4. [OUT] 変数　：　hsid
　　作成した壁データを識別するhsidが代入されます。



バージョン : ver1.0.0.1

%index
E3DChkThreadWorking
関数の最後に、Threadが付いている関数は、新たにスレッドを作成します。
%group
Easy3D For HSP3 : スレッド管理

%prm
p1,p2,p3,p4
p1 : [IN] 変数または、数値　：　threadid
p2 : [OUT] 変数　：　working
p3 : [OUT] 変数　：　returnval1
p4 : [OUT] 変数　：　returnval2

%inst
関数の最後に、Threadが付いている関数は、新たにスレッドを作成します。

この作成したスレッドが、
現在、動作中であるかどうかをチェックするための関数です。

スレッドが終了している場合には、
スレッドの動作結果が、
returnval1, reteurnval2変数で取得できます。
この変数は、hsidや、モーションＩＤを取得するために、使用します。

スレッド読み込み関数に、存在しないファイル名などを指定した場合などは、エラーにならずに、
hsidが代入される引数に-1が代入されるので注意してください。


具体的な使用例は、
e3dhsp3_LoadByNewThread.hsp
をご覧ください。





→引数
1. [IN] 変数または、数値　：　threadid
　　スレッドを識別するＩＤ
　　名前の最後にThreadが付いている関数で、
　　取得したＩＤを指定してください。

2. [OUT] 変数　：　working
　　スレッドが、動作中かどうかが代入されます。
　　動作中の場合は１が、
　　動作が終了している場合には０が、代入されます。

　　workingが０の場合は、
　　returnval1, returnval2に代入される値が、
　　意味を持ちます。

3. [OUT] 変数　：　returnval1
4. [OUT] 変数　：　returnval2
　　スレッドの実行結果が、代入されます。
　　returnval1, returnval2に代入される値の
　　意味については、
　　各Thread作成関数の説明をお読みください。




バージョン : ver1.0.0.1

%index
E3DLoadMQOFileAsGroundThread
スレッドを作成して、E3DLoadMQOFileAsGroundを実行します。
%group
Easy3D For HSP3 : 地面

%prm
p1,p2,p3,p4
p1 : [IN] 文字列または、文字列変数　：　filename
p2 : [IN] 変数または、数値　：　mult
p3 : [IN] 変数または、数値　：　adjustuvflag
p4 : [OUT] 変数　：　threadid

%inst
スレッドを作成して、E3DLoadMQOFileAsGroundを実行します。

作成したスレッドを識別するためのＩＤが
threadidに代入されます。

スレッドの作成に失敗した場合には、
threadidにマイナスの値が、代入されます。

threadidは、
E3DChkThreadWorkingに使用することが
出来ます。

スレッド作成関数は、全部で、4098回まで、
呼ぶことが出来ます。
（E3DChkThreadWorkingを除く）
E3DFreeThreadの説明もご覧ください。

スレッドが終了すると、
E3DChkThreadWorkingで取得される
returnval1に、
モデルデータを識別するhsidが代入されます。

html{
<strong>
</strong>
}htmlver5.0.0.7からは命令ごとに異なるディレクトリにテクスチャがあっても読み込めるようになりました。

E3DLoadMQOFileAsGroundの説明もお読みください。




→引数
1. [IN] 文字列または、文字列変数　：　filename
　　読み込む、mqo ファイル名。

2. [IN] 変数または、数値　：　mult
　　形状データの座標に掛ける数値。
　　座標値　＊　mult で計算されます。
　　等倍は１．０。
　　実数。

3. [IN] 変数または、数値　：　adjustuvflag
　　UV座標を正規化したいときは１を、
　　そうでないときは、０を指定してください。
　　何も指定しないときは、０として扱われます。

4. [OUT] 変数　：　threadid
　　作成したスレッドを識別するＩＤが、代入されます。



バージョン : ver1.0.0.1

%index
E3DSigLoadThread
スレッドを作成して、E3DSigLoadを実行します。
%group
Easy3D For HSP3 : 形状データ

%prm
p1,p2,p3,p4
p1 : [IN] 文字列または、文字列の変数　：　fname
p2 : [IN] 変数または、数値　：　adjustuvflag
p3 : [IN] 変数または、数値　：　mult
p4 : [OUT] 変数　：　threadid

%inst
スレッドを作成して、E3DSigLoadを実行します。

作成したスレッドを識別するためのＩＤが
threadidに代入されます。

スレッドの作成に失敗した場合には、
threadidにマイナスの値が、代入されます。

threadidは、
E3DChkThreadWorkingに使用することが
出来ます。

スレッド作成関数は、全部で、4098回まで、
呼ぶことが出来ます。
（E3DChkThreadWorkingを除く）
E3DFreeThreadの説明もご覧ください。


スレッドが終了すると、
E3DChkThreadWorkingで取得される
returnval1に、
モデルデータを識別するhsidが代入されます。

html{
<strong>
</strong>
}htmlver5.0.0.7からは命令ごとに異なるディレクトリにテクスチャがあっても読み込めるようになりました。


E3DSigLoadの説明も、お読みください。




→引数
1. [IN] 文字列または、文字列の変数　：　fname
　　*.sig のパス文字列。

2. [IN] 変数または、数値　：　adjustuvflag
　　ＵＶ値を正規化するかどうかのフラグ
　　正規化する場合は１を指定
　　しない場合は０を指定

3. [IN] 変数または、数値　：　mult
　　読み込み倍率を指定してください。
　　等倍は１．０。
　　実数。

4. [OUT] 変数　：　threadid
　　作成したスレッドを識別するＩＤが、代入されます。




バージョン : ver1.0.0.1

%index
E3DSigLoadFromBufThread
スレッドを作成して、E3DSigLoadFromBufを実行します。
%group
Easy3D For HSP3 : 形状データ

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 文字列または、文字列の変数　：　resdir
p2 : [IN] 変数　：　buf
p3 : [IN] 変数または、数値　：　bufleng
p4 : [IN] 変数または、数値　：　adjustuvflag
p5 : [IN] 変数または、数値　：　mult
p6 : [OUT] 変数　：　threadid

%inst
スレッドを作成して、E3DSigLoadFromBufを実行します。

作成したスレッドを識別するためのＩＤが
threadidに代入されます。

スレッドの作成に失敗した場合には、
threadidにマイナスの値が、代入されます。

threadidは、
E3DChkThreadWorkingに使用することが
出来ます。

スレッド作成関数は、全部で、4098回まで、
呼ぶことが出来ます。
（E3DChkThreadWorkingを除く）      E3DFreeThreadの説明もご覧ください。

スレッドが終了すると、
E3DChkThreadWorkingで取得される
returnval1に、
モデルデータを識別するhsidが代入されます。

html{
<strong>
</strong>
}htmlver5.0.0.7からは命令ごとに異なるディレクトリにテクスチャがあっても読み込めるようになりました。


E3DSigLoadFromBufの説明もお読みください。




→引数
1. [IN] 文字列または、文字列の変数　：　resdir
　　テクスチャーのあるフォルダ のパス文字列。
　　最後に、&quot;\\&quot;が必要。

2. [IN] 変数　：　buf
　　バッファの変数

3. [IN] 変数または、数値　：　bufleng
　　バッファの中のデータの長さ

4. [IN] 変数または、数値　：　adjustuvflag
　　ＵＶ値を正規化するかどうかのフラグ
　　正規化する場合は１を指定
　　しない場合は０を指定

5. [IN] 変数または、数値　：　mult
　　倍率を指定してください。
　　デフォルトは1.0です。
　　等倍は、１．０。
　　実数。

6. [OUT] 変数　：　threadid
　　作成したスレッドを識別するＩＤが、代入されます。



バージョン : ver1.0.0.1

%index
E3DLoadMQOFileAsMovableAreaThread
スレッドを作成して、E3DLoadMQOFileAsMovableAreaを実行します。
%group
Easy3D For HSP3 : 壁

%prm
p1,p2,p3
p1 : [IN] 文字列または、文字列変数　：　filename
p2 : [IN] 変数または、数値　：　mult
p3 : [OUT] 変数　：　threadid

%inst
スレッドを作成して、E3DLoadMQOFileAsMovableAreaを実行します。

作成したスレッドを識別するためのＩＤが
threadidに代入されます。

スレッドの作成に失敗した場合には、
threadidにマイナスの値が、代入されます。

threadidは、
E3DChkThreadWorkingに使用することが
出来ます。

スレッド作成関数は、全部で、4098回まで、
呼ぶことが出来ます。
（E3DChkThreadWorkingを除く）      E3DFreeThreadの説明もご覧ください。

スレッドが終了すると、
E3DChkThreadWorkingで取得される
returnval1に、
モデルデータを識別するhsidが代入されます。

E3DLoadMQOFileAsMovableAreaの説明もお読みください。




→引数
1. [IN] 文字列または、文字列変数　：　filename
　　読み込む、mqo ファイル名。

2. [IN] 変数または、数値　：　mult
　　形状データの座標に掛ける数値。
　　座標値　＊　mult で計算されます。
　　等倍は１．０。
　　実数。

3. [OUT] 変数　：　threadid
　　作成したスレッドを識別するＩＤが、代入されます。



バージョン : ver1.0.0.1

%index
E3DLoadMQOFileAsMovableAreaFromBufThread
スレッドを作成して、E3DLoadMQOFileAsMovableAreaFromBufを実行します。
%group
Easy3D For HSP3 : 壁

%prm
p1,p2,p3,p4
p1 : [IN] 変数　：　buf
p2 : [IN] 変数または、数値　：　bufleng
p3 : [IN] 変数または、数値　：　mult
p4 : [OUT] 変数　：　threadid

%inst
スレッドを作成して、E3DLoadMQOFileAsMovableAreaFromBufを実行します。

作成したスレッドを識別するためのＩＤが
threadidに代入されます。

スレッドの作成に失敗した場合には、
threadidにマイナスの値が、代入されます。

threadidは、
E3DChkThreadWorkingに使用することが
出来ます。

スレッド作成関数は、全部で、4098回まで、
呼ぶことが出来ます。
（E3DChkThreadWorkingを除く）      E3DFreeThreadの説明もご覧ください。


スレッドが終了すると、
E3DChkThreadWorkingで取得される
returnval1に、
モデルデータを識別するhsidが代入されます。

E3DLoadMQOFileAsMovableAreaFromBufの説明もお読みください。



→引数
1. [IN] 変数　：　buf
　　バッファの変数

2. [IN] 変数または、数値　：　bufleng
　　バッファの中のデータの長さ

3. [IN] 変数または、数値　：　mult
　　形状データの座標に掛ける数値。
　　座標値　＊　mult で計算されます。
　　等倍は１．０。
　　実数。

4. [OUT] 変数　：　threadid
　　作成したスレッドを識別するＩＤが、代入されます。





バージョン : ver1.0.0.1

%index
E3DLoadGroundBMPThread
スレッドを作成して、E3DLoadGroundBMPを実行します。
%group
Easy3D For HSP3 : 地面

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9,p10
p1 : [IN] 文字列または、文字列変数　：　filename1
p2 : [IN] 文字列または、文字列変数　：　filename2
p3 : [IN] 文字列または、文字列変数　：　filename3
p4 : [IN] 文字列または、文字列変数　：　filename4
p5 : [IN] 変数または、数値　：　maxx
p6 : [IN] 変数または、数値　：　maxz
p7 : [IN] 変数または、数値　：　divx
p8 : [IN] 変数または、数値　：　divz
p9 : [IN] 変数または、数値　：　maxheight
p10 : [OUT] 変数　：　threadid

%inst
スレッドを作成して、E3DLoadGroundBMPを実行します。

作成したスレッドを識別するためのＩＤが
threadidに代入されます。

スレッドの作成に失敗した場合には、
threadidにマイナスの値が、代入されます。

threadidは、
E3DChkThreadWorkingに使用することが
出来ます。

スレッド作成関数は、全部で、4098回まで、
呼ぶことが出来ます。
（E3DChkThreadWorkingを除く）
E3DFreeThreadの説明もご覧ください。


スレッドが終了すると、
E3DChkThreadWorkingで取得される
returnval1に、
モデルデータを識別するhsidが代入されます。

E3DLoadGroundBMPの説明もお読みください。




→引数
1. [IN] 文字列または、文字列変数　：　filename1
　　地面の座標情報の元となる、ＢＭＰファイル名

2. [IN] 文字列または、文字列変数　：　filename2
　　地面の道の情報の元となる、ＢＭＰファイル名

3. [IN] 文字列または、文字列変数　：　filename3
　　地面の川の情報の元となる、ＢＭＰファイル名

4. [IN] 文字列または、文字列変数　：　filename4
　　地面、道、川の模様を決める、ＢＭＰファイル名

5. [IN] 変数または、数値　：　maxx
　　地面のＸ座標の最大値
　　実数。

6. [IN] 変数または、数値　：　maxz
　　地面のＺ座標の最大値
　　実数。

7. [IN] 変数または、数値　：　divx
　　X方向の分割数

8. [IN] 変数または、数値　：　divz
　　Z方向の分割数

9. [IN] 変数または、数値　：　maxheight
　　地面の高さの最大値
　　実数。

10. [OUT] 変数　：　threadid
　　作成したスレッドを識別するＩＤが、代入されます。



バージョン : ver1.0.0.1

%index
E3DLoadGndFileThread
スレッドを作成して、E3DLoadGNDFileを実行します。
%group
Easy3D For HSP3 : 地面

%prm
p1,p2,p3,p4
p1 : [IN] 文字列または、文字列の変数　：　fname
p2 : [IN] 変数または、数値　：　adjustuvflag
p3 : [IN] 変数または、数値　：　mult
p4 : [OUT] 変数　：　threadid

%inst
スレッドを作成して、E3DLoadGNDFileを実行します。

作成したスレッドを識別するためのＩＤが
threadidに代入されます。

スレッドの作成に失敗した場合には、
threadidにマイナスの値が、代入されます。

threadidは、
E3DChkThreadWorkingに使用することが
出来ます。

スレッド作成関数は、全部で、4098回まで、
呼ぶことが出来ます。
（E3DChkThreadWorkingを除く）      E3DFreeThreadの説明もご覧ください。

スレッドが終了すると、
E3DChkThreadWorkingで取得される
returnval1に、
モデルデータを識別するhsidが代入されます。

html{
<strong>
</strong>
}htmlver5.0.0.7からは命令ごとに異なるディレクトリにテクスチャがあっても読み込めるようになりました。


E3DLoadGNDFileの説明もお読みください。



→引数
1. [IN] 文字列または、文字列の変数　：　fname
　　*.gnd のパス文字列。

2. [IN] 変数または、数値　：　adjustuvflag
　　ＵＶ値を正規化するかどうかのフラグ
　　正規化する場合は１を指定
　　しない場合は０を指定

3. [IN] 変数または、数値　：　mult
　　読み込み倍率を指定してください。
　　等倍は１．０。
　　実数。

4. [OUT] 変数　：　threadid
　　作成したスレッドを識別するＩＤが、代入されます。



バージョン : ver1.0.0.1

%index
E3DLoadGndFileFromBufThread
スレッドを作成して、E3DLoadGNDFileFromBufを実行します。
%group
Easy3D For HSP3 : 地面

%prm
p1,p2,p3,p4,p5
p1 : [IN] 文字列または、文字列の変数　：　resdir
p2 : [IN] 変数　：　buf
p3 : [IN] 変数または、数値　：　bufleng
p4 : [IN] 変数または、数値　：　adjustuvflag
p5 : [OUT] 変数　：　threadid

%inst
スレッドを作成して、E3DLoadGNDFileFromBufを実行します。

作成したスレッドを識別するためのＩＤが
threadidに代入されます。

スレッドの作成に失敗した場合には、
threadidにマイナスの値が、代入されます。

threadidは、
E3DChkThreadWorkingに使用することが
出来ます。

スレッド作成関数は、全部で、4098回まで、
呼ぶことが出来ます。
（E3DChkThreadWorkingを除く）
E3DFreeThreadの説明もご覧ください。


スレッドが終了すると、
E3DChkThreadWorkingで取得される
returnval1に、
モデルデータを識別するhsidが代入されます。


html{
<strong>
</strong>
}htmlver5.0.0.7からは命令ごとに異なるディレクトリにテクスチャがあっても読み込めるようになりました。


E3DLoadGNDFileFromBufの説明もお読みください。



→引数
1. [IN] 文字列または、文字列の変数　：　resdir
　　テクスチャーのあるフォルダ のパス文字列。
　　最後に、&quot;\\&quot;が必要。

2. [IN] 変数　：　buf
　　バッファの変数

3. [IN] 変数または、数値　：　bufleng
　　バッファの中のデータの長さ

4. [IN] 変数または、数値　：　adjustuvflag
　　ＵＶ値を正規化するかどうかのフラグ
　　正規化する場合は１を指定
　　しない場合は０を指定

5. [OUT] 変数　：　threadid
　　作成したスレッドを識別するＩＤが、代入されます。



バージョン : ver1.0.0.1

%index
E3DAddMotionThread
スレッドを作成して、E3DAddMotionを実行します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 文字列または、文字列の変数　：　fname
p3 : [OUT] 変数　：　threadid

%inst
スレッドを作成して、E3DAddMotionを実行します。

作成したスレッドを識別するためのＩＤが
threadidに代入されます。

スレッドの作成に失敗した場合には、
threadidにマイナスの値が、代入されます。

threadidは、
E3DChkThreadWorkingに使用することが
出来ます。

スレッド作成関数は、全部で4098回まで、
呼ぶことが出来ます。
（E3DChkThreadWorkingを除く）
E3DFreeThreadの説明もご覧ください。


スレッドが終了すると、
E3DChkThreadWorkingで取得される
returnval1に、
モーションをを識別するIDが代入されます。
returnval2に、
最大フレーム番号が代入されます。

この関数が終了するまで、
この関数に渡したhsidに対して、
モーションの再生命令などは、使わないようにしてください。


E3DAddMotionの説明もお読みください。





→引数
1. [IN] 変数または、数値　：　hsid
　　どのモデルデータに対するモーションかを指定する。

2. [IN] 文字列または、文字列の変数　：　fname
　　*.quaのパス文字列。

3. [OUT] 変数　：　threadid
　　作成したスレッドを識別するＩＤが、代入されます。



バージョン : ver1.0.0.1

%index
E3DAddMotionFromBufThread
スレッドを作成して、E3DAddMotionFromBufを実行します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4,p5
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　datakind
p3 : [IN] 変数　：　buf
p4 : [IN] 変数または、数値　：　bufleng
p5 : [OUT] 変数　：　threadid

%inst
スレッドを作成して、E3DAddMotionFromBufを実行します。

作成したスレッドを識別するためのＩＤが
threadidに代入されます。

スレッドの作成に失敗した場合には、
threadidにマイナスの値が代入されます。

threadidは、
E3DChkThreadWorkingに使用することが
出来ます。

スレッド作成関数は、全部で4098回まで、
呼ぶことが出来ます。
（E3DChkThreadWorkingを除く）
E3DFreeThreadの説明もご覧ください。


スレッドが終了すると、
E3DChkThreadWorkingで取得される
returnval1に、
モーションをを識別するIDが代入されます。
returnval2に、
最大フレーム番号が代入されます。

この関数が終了するまで、
この関数に渡したhsidに対して、
モーションの再生命令などは、使わないようにしてください。


E3DAddMotionFromBufの説明もお読みください。



→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するhsid

2. [IN] 変数または、数値　：　datakind
　　quaデータの時は０を、
　　motデータの時は１を指定してください。

3. [IN] 変数　：　buf
　　バッファの変数

4. [IN] 変数または、数値　：　bufleng
　　バッファの中のデータの長さ

5. [OUT] 変数　：　threadid
　　作成したスレッドを識別するＩＤが、代入されます。




バージョン : ver1.0.0.1

%index
E3DGetShaderType
シェーダーの種類と、オーバーフロー処理を取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [OUT] 変数　：　shader
p3 : [OUT] 変数　：　overflow

%inst
シェーダーの種類と、オーバーフロー処理を取得します。

それぞれの値の意味は、
E3DSetShaderTypeの説明をお読みください。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するhsid

2. [OUT] 変数　：　shader
3. [OUT] 変数　：　overflow
　　シェーダーの種類と、
　　オーバーフロー処理が、代入されます。



バージョン : ver1.0.0.1

%index
E3DSetShaderType
シェーダーの種類と、
色のオーバーフロー処理を設定します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　shader
p3 : [IN] 変数または、数値　：　overflow

%inst
シェーダーの種類と、
色のオーバーフロー処理を設定します。

シェーダーの種類は、
e3dhsp3.asのCOL_ で始まる定数で、定義されています。

COL_OLD
　　従来のRokDeBone2の計算法
　　emissiveは、無効。
　　スペキュラーは、形だけの実装。
　　一番高速。
COL_PHONG
　　Lambertのディフーズ
　　Phongのスペキュラー
　　emissive有り
COL_BLINN
　　Lambertのディフーズ
　　Blinnのスペキュラー
　　emissive有り
COL_SCHLICK
　　Lambertのディフーズ
　　Schlickのスペキュラー
　　emissive有り
COL_MQCLASSIC
　　メタセコイアのマテリアルで
　　Classicを指定したときのモード
　　emissive有り

COL_TOON1
　　テクスチャを使用したトゥーン表示
　　頂点色は設定しないことを推奨。
COL_TOON0
　　ピクセルシェーダーを使用したトゥーン表示。

色のオーバーフロー処理は、
e3dhsp3.asのOVERFLOW_ で始まる定数で、
定義されています。

OVERFLOW_CLAMP
　　クランプ。
　　自己照明がきついと、色が破綻する。
　　一番高速。
OVERFLOW_SCALE
　　スケール。色は破綻しないが、暗くなる。
OVERFLOW_ORG
　　オリジナル。明るさを保つ。


ver3.0.0.1での仕様変更により、現在は、COL_PHONGとCOL_TOON1とCOL_TOON0のみのサポートとなります（ver3.0.3.4現在）






→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するhsid

2. [IN] 変数または、数値　：　shader
3. [IN] 変数または、数値　：　overflow
　　シェーダーの種類と、
　　オーバーフロー処理の指定をします。
　　値の意味は、左記をご覧ください。



バージョン : ver1.0.0.1

%index
E3DSetLightBlendMode
頂点のdiffuse色と、ライト色をブレンディングする際の、方法を設定します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2
p1 : [IN] 変数または、数値　：　lid
p2 : [IN] 変数または、数値　：　mode

%inst
頂点のdiffuse色と、ライト色をブレンディングする際の、方法を設定します。
ブレンド方式には、PhotoShopのブレンドモードを使います。


mode引数には、LBLEND_で始まる定数を使用します。
これらの定数は、e3dhsp3.asで定義されています。

LBLEND_MULT
　　乗算
LBLEND_SCREEN
　　スクリーン
LBLEND_OVERLAY
　　オーバーレイ
LBLEND_HARDLIGHT
　　ハードライト
LBLEND_DODGE
　　覆い焼き





→引数
1. [IN] 変数または、数値　：　lid
　　ライトを識別するＩＤ

2. [IN] 変数または、数値　：　mode
　　ブレンドモードを指定します。
　　LBLEND_ で始まる定数を使用します。




バージョン : ver1.0.0.1

%index
E3DGetLightBlendMode
頂点のdiffuse色と、ライト色とのブレンドモードを取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2
p1 : [IN] 変数または、数値　：　lid
p2 : [OUT] 変数　：　mode

%inst
頂点のdiffuse色と、ライト色とのブレンドモードを取得します。

取得されるモードの数値は、
e3dhsp3.asで定義されている
LBLEND_で始まる定数です。

詳しくは、E3DSetLightBlendModeをお読みください。




→引数
1. [IN] 変数または、数値　：　lid
　　ライトを識別するＩＤ

2. [OUT] 変数　：　mode
　　ブレンドモードが代入されます。



バージョン : ver1.0.0.1

%index
E3DSetEmissive
パーツのemissive色をセットする関数です。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　R
p4 : [IN] 数値または、変数　：　G
p5 : [IN] 数値または、変数　：　B
p6 : [IN] 数値または、変数　：　setflag
p7 : [IN] 数値または、変数　：　vertno

%inst
パーツのemissive色をセットする関数です。

指定した色を、
そのまま設定、乗算して設定、加算して設定、
減算して設定の、4種類出来ます。

その時点で、表示されている色に対して、
乗算、加算、減算します。





→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ
　　-1を指定すると、ビルボードの色を設定できます。

2. [IN] 数値または、変数　：　partno
　　設定したいパーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。

　　hsidに-1を指定した場合は、
　　E3DCreateBillboardで取得した、
　　ビルボードidを渡してください。

　　partnoに-1を渡すと、
　　全てのパーツに色をセットできます。

3. [IN] 数値または、変数　：　R
4. [IN] 数値または、変数　：　G
5. [IN] 数値または、変数　：　B
　　指定したい色を（Ｒ，Ｇ，Ｂ）で指定します。
　　０から２５５までの値を指定してください。

　　setflagに乗算を指定した場合は、
　　各成分に、R/255, G/255, B/255を乗算します。

6. [IN] 数値または、変数　：　setflag
　　setflagが０のときは、
　　パーツの色を（Ｒ，Ｇ，Ｂ）にセットします。

　　setflagが１のときは、
　　パーツの色に（R/255, G/255, B/255）を乗算します。

　　setflagが２のときは、
　　パーツの色に（Ｒ，Ｇ，Ｂ）を足し算します。

　　setflagが３のときは、
　　パーツの色から（Ｒ，Ｇ，Ｂ）を減算します。

7. [IN] 数値または、変数　：　vertno
　　指定した頂点番号の色をセットします。
　　この引数を省略、または、-1をセットした場合には、
　　partnoで指定したパーツ全体の色の設定をします。



バージョン : ver1.0.0.1

%index
E3DSetSpecularPower
パーツのspecular powerをセットする関数です。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　pow
p4 : [IN] 数値または、変数　：　setflag
p5 : [IN] 数値または、変数　：　vertno

%inst
パーツのspecular powerをセットする関数です。

指定した色を、
そのまま設定、乗算して設定、加算して設定、
減算して設定の、4種類出来ます。

その時点で、表示されている色に対して、
乗算、加算、減算します。





→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ
　　-1を指定すると、ビルボードの色を設定できます。

2. [IN] 数値または、変数　：　partno
　　設定したいパーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。

　　hsidに-1を指定した場合は、
　　E3DCreateBillboardで取得した、
　　ビルボードidを渡してください。

　　partnoに-1を渡すと、
　　全てのパーツに色をセットできます。

3. [IN] 数値または、変数　：　pow
　　実数。
　　pow の値を、setflagに基づいて、
　　現在の色に対して処理を行います。

4. [IN] 数値または、変数　：　setflag
　　setflagが０のときは、
　　指定した値をセットします。

　　setflagが１のときは、
　　現在の値に、指定した値を乗算します。

　　setflagが２のときは、
　　現在の値に、指定した値を足し算します。

　　setflagが３のときは、
　　現在の値に、指定した値を減算します。

5. [IN] 数値または、変数　：　vertno
　　指定した頂点番号の色をセットします。
　　この引数を省略、または、-1をセットした場合には、
　　partnoで指定したパーツ全体の色の設定をします。




バージョン : ver1.0.0.1

%index
E3DGetEmissive
任意のパーツの任意の頂点の、emissive色を取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　vertno
p4 : [OUT] 変数　：　r
p5 : [OUT] 変数　：　g
p6 : [OUT] 変数　：　b

%inst
任意のパーツの任意の頂点の、emissive色を取得します。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ
　　-1を指定すると、ビルボードの色を取得できます。

2. [IN] 数値または、変数　：　partno
　　取得したいパーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。

　　hsidに-1を指定した場合は、
　　E3DCreateBillboardで取得した、
　　ビルボードidを渡してください。

3. [IN] 数値または、変数　：　vertno
　　色を取得したい頂点の番号を指定します。

4. [OUT] 変数　：　r
5. [OUT] 変数　：　g
6. [OUT] 変数　：　b
　　　指定した頂点のemissive色が、
　　　RGB = ( r, g, b )に代入されます。
　　　r, g, bそれぞれ、０から２５５の値が代入されます。



バージョン : ver1.0.0.1

%index
E3DGetSpecularPower
任意のパーツの任意の頂点の、specular powerを取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　vertno
p4 : [OUT] 変数　：　pow

%inst
任意のパーツの任意の頂点の、specular powerを取得します。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ
　　-1を指定すると、ビルボードの色を取得できます。

2. [IN] 数値または、変数　：　partno
　　取得したいパーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。

　　hsidに-1を指定した場合は、
　　E3DCreateBillboardで取得した、
　　ビルボードidを渡してください。

3. [IN] 数値または、変数　：　vertno
　　色を取得したい頂点の番号を指定します。

4. [OUT] 変数　：　pow
　　　指定した頂点のspecular powerが、
　　　代入されます。
　　実数1型の変数。



バージョン : ver1.0.0.1

%index
E3DGetInfElemNum
指定した頂点が、何個のボーンの影響を受けているかを取得します。
%group
Easy3D For HSP3 : ボーン影響

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　vertno
p4 : [OUT] 変数　：　num

%inst
指定した頂点が、何個のボーンの影響を受けているかを取得します。

影響度情報は、影響を受けるボーンごとに存在します。
（影響を受けるボーンの数だけ存在します）

この影響度情報のことを、
Easy3Dでは、InfElemと呼びます。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　partno
　　取得したいパーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。

3. [IN] 数値または、変数　：　vertno
　　頂点の番号

4. [OUT] 変数　：　num
　　影響度情報の個数が代入されます。



バージョン : ver1.0.0.1

%index
E3DGetInfElem
指定した頂点の、ボーン影響度情報を取得します。
%group
Easy3D For HSP3 : ボーン影響

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　vertno
p4 : [IN] 数値または、変数　：　infno
p5 : [OUT] 変数　：　childjointno
p6 : [OUT] 変数　：　calcmode
p7 : [OUT] 変数　：　userrate
p8 : [OUT] 変数　：　orginf
p9 : [OUT] 変数　：　dispinf

%inst
指定した頂点の、ボーン影響度情報を取得します。

infnoには、
E3DGetInfElemNumで取得した数値をinfnumとすると、
0から(infnum - 1)の値を渡してください。


childjointnoに0以下（０を含む）の数値が取得された場合には、そのデータはダミーデータですので、無視するようにしてください。



calcmodeの意味
calcmodeは、影響度の計算方法を表します。
e3dhsp3.as中で定義されているCALCMODE_で始まる定数を使用します。
以下のように定義されています。
#define CALCMODE_NOSKIN0 0
define CALCMODE_ONESKIN0	1
define CALCMODE_ONESKIN1	2
define CALCMODE_DIRECT0	3
#define CALCMODE_SYM 4
NOSKIN0は、スキニング無し。
ONESKIN0は、距離と角度によりスキニング。
ONESKIN1は、距離のみによりスキニング。
DIRECT0は、直接数値指定。
SYMは、対称コピーによる指定。
を表します。



Easy3D内部での影響度の計算方法
影響度を算出する際には、
orginf, dispinf, userrate, normalizeflagを使います。
orginfは、calcmodeで指定した方法で、算出した影響度。
userrateは、比重。
normalizeflagは、正規化（一つの頂点の影響度の合計が１になるようにする）をするかどうかのフラグ。
html{
<strong>dispinfが、最終的な、影響度。</strong>
}html
まず、InfElemごとに、以下の計算をします。
orginf * userrate / 100
normalizeflagが０のときは、この値がそのまま、dispinfになります。
normalizeflagが１のときは、
全部のInfElemの影響度（dispinf）の合計が１になるように、正規化します。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　partno
　　取得したいパーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。

3. [IN] 数値または、変数　：　vertno
　　頂点の番号

4. [IN] 数値または、変数　：　infno
　　影響度情報の番号
　　０から（影響度の個数-1）までの数

5. [OUT] 変数　：　childjointno
　　どのボーンの影響を受けるかが代入されます。
　　この値が、0以下の値の時は、ダミーデータです。
　　ボーンの線分の内、子供の方のジョイントの番号が
　　代入されます。

6. [OUT] 変数　：　calcmode
　　影響度の計算方法が代入されます。

7. [OUT] 変数　：　userrate
　　比重が代入されます。
　　％値が代入されます。
　　例えば、１００％の場合は、100.0が代入されます。
　　実数。

8. [OUT] 変数　：　orginf
9. [OUT] 変数　：　dispinf
　　orginf, dispinfの値が代入されます。
　　それぞれの意味は、左記をご覧ください。
　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DSetInfElem
頂点にボーン影響度を設定します。
%group
Easy3D For HSP3 : ボーン影響

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　vertno
p4 : [IN] 数値または、変数　：　childjointno
p5 : [IN] 数値または、変数　：　calcmode
p6 : [IN] 数値または、変数　：　paintmode
p7 : [IN] 数値または、変数　：　normalizeflag
p8 : [IN] 数値または、変数　：　userrate
p9 : [IN] 数値または、変数　：　directval

%inst
頂点にボーン影響度を設定します。


paintmodeの意味
paintmodeは、影響度の設定方法を表します。
e3dhsp3.as内で、PAINT_で始まる定数で、
定義されています。
#define PAINT_NOR 0
#define PAINT_EXC 1
#define PAINT_ADD 2
#define PAINT_SUB 3
#define PAINT_ERA 4
NORは、
すでに設定してある影響度情報に、影響度データを追加します。
同じボーンの情報が既にある場合は、上書きします。
EXCは、すでに設定してある影響度情報を、破棄してから、影響度データを設定します。
ADDは、すでに設定してある影響度の比重に、指定した比重を足し算します。
SUBは、すでに設定してある影響度の比重から、指定した比重を引き算します。
ERAは、指定したボーンの影響度データを削除します。

calcmodeについては、
E3DGetInfElemの説明をご覧ください。


calcmodeとpaintmodeの依存関係
CALCMODE_NOSKIN0のときは、PAINT_EXCを設定してください。
CALCMODE_DIRECT0のときは、PAINT_NORまたは、PAINT_EXCを設定してください。


影響度の計算方法については、
E3DGetInfElemの説明をご覧ください。


directvalは、CALCMODE_DIRECT0のときのみ意味を持ちます。この値をorginfとして設定します。
正の小数を指定してください。


スムージング角度の関係などで、同じ位置に複数の頂点が存在する場合があります。
これらの頂点を同時に同じように設定しないと、ボーン変形が、乱れることがあるので、注意してください。


childjointnoは、ボーンの線分の内の子供のジョイントの番号です。
childjointnoには、必ず親が存在するジョイントの番号を指定してください。
一番親のジョイントは、childjointには、指定できません。


CALCMODE_SYMの影響度設定はこの命令ではできません。
html{
<strong>E3DSetSymInfElem</strong>
}htmlをお使いください。

この命令を呼んだだけでは表示には反映されません。
html{
<strong>影響度の編集がすべて終わったら、E3DCreateSkinMatを呼んで</strong>
}html表示に反映させてください。





→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　partno
　　パーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。

3. [IN] 数値または、変数　：　vertno
　　頂点の番号

4. [IN] 数値または、変数　：　childjointno
　　影響を受けるボーンの指定。
　　ボーンの線分の内、子供の方のジョイントの番号を
　　指定します。

5. [IN] 数値または、変数　：　calcmode
　　影響度の計算方法を指定します。

6. [IN] 数値または、変数　：　paintmode
　　影響度の設定方法を指定します。

7. [IN] 数値または、変数　：　normalizeflag
　　正規化をするときは１、
　　しないときは０を指定します。
　　詳しくは、E3DGetInfElemの説明をお読みください。

8. [IN] 数値または、変数　：　userrate
　　比重％の値を指定します。
　　１００％の時は、100.0を指定します。
　　詳しくは、E3DGetInfElemの説明をお読みください。
　　実数。

9. [IN] 数値または、変数　：　directval
　　直接数値指定の数値を指定します。
　　詳しくは、左記をご覧ください。
　　実数。



バージョン : ver1.0.0.1

%index
E3DDeleteInfElem
ボーン影響度情報を削除します。
%group
Easy3D For HSP3 : ボーン影響

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　vertno
p4 : [IN] 数値または、変数　：　childjointno
p5 : [IN] 数値または、変数　：　normalizeflag

%inst
ボーン影響度情報を削除します。

normalizeflagに１を指定すると、
削除した後に、
指定頂点の残りの影響度情報を、
正規化します。

この命令を呼んだだけでは表示には反映されません。
html{
<strong>影響度の編集がすべて終わったら、E3DCreateSkinMatを呼んで</strong>
}html表示に反映させてください。





→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　partno
　　パーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。

3. [IN] 数値または、変数　：　vertno
　　頂点の番号

4. [IN] 数値または、変数　：　childjointno
　　影響を受けるボーンの指定。
　　ボーンの線分の内、子供の方のジョイントの番号を
　　指定します。

5. [IN] 数値または、変数　：　normalizeflag
　　正規化をするときは１、
　　しないときは０を指定します。
　　詳しくは、E3DGetInfElemの説明をお読みください。



バージョン : ver1.0.0.1

%index
E3DSetInfElemDefault
ボーン影響度情報を、デフォルト状態に戻します。
%group
Easy3D For HSP3 : ボーン影響

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　vertno

%inst
ボーン影響度情報を、デフォルト状態に戻します。

html{
<strong>partno</strong>
}htmlに、-1を指定すると、
全パーツの全頂点の影響度を
デフォルト状態に戻します。





→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　partno
　　パーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。

3. [IN] 数値または、変数　：　vertno
　　頂点の番号



バージョン : ver1.0.0.1

%index
E3DNormalizeInfElem
ボーン影響度情報を、正規化します。
%group
Easy3D For HSP3 : ボーン影響

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　vertno

%inst
ボーン影響度情報を、正規化します。

指定した頂点の影響度の合計が１になるように、各影響度を合計値で割り算します。

html{
<strong>vertno</strong>
}htmlに、-1を指定すると、
指定パーツの、全頂点に対して、
正規化を行います。


この命令を呼んだだけでは表示には反映されません。
html{
<strong>影響度の編集がすべて終わったら、E3DCreateSkinMatを呼んで</strong>
}html表示に反映させてください。





→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　partno
　　パーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。

3. [IN] 数値または、変数　：　vertno
　　頂点の番号



バージョン : ver1.0.0.1

%index
E3DGetVisiblePolygonNum
視野内のポリゴン数を取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　hsid
p2 : [OUT] 変数　：　num1
p3 : [OUT] 変数　：　num2

%inst
視野内のポリゴン数を取得します。

html{
<strong>E3DRenderの後で呼び出してください。</strong>
}html

地面データに対して呼び出した場合は、
num2には、num1と同じ数値が代入されます。


ver3.0.0.1での変更で、この関数は意味を持たなくなりました。



→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [OUT] 変数　：　num1
　　パーツ単位で計算した視野内ポリゴン数が
　　代入されます。

3. [OUT] 変数　：　num2
　　クリッピング、背面カリングを考慮した
　　面単位で計算したポリゴン数が代入されます。
　　地面データの場合は、num1と同じ値が代入されます。





バージョン : ver1.0.0.1

%index
E3DChkConfGroundPart
地面の指定パーツと、キャラクターとの当たり判定を行います。
%group
Easy3D For HSP3 : 当たり判定

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13
p1 : [IN] 変数または、数値　：　charahsid
p2 : [IN] 変数または、数値　：　groundhsid
p3 : [IN] 変数または、数値　：　groundpart
p4 : [IN] 変数または、数値　：　mode
p5 : [IN] 変数または、数値　：　diffmaxy
p6 : [IN] 変数または、数値　：　mapminy
p7 : [OUT] 変数　：　result
p8 : [OUT] 変数　：　adjustx
p9 : [OUT] 変数　：　adjusty
p10 : [OUT] 変数　：　adjustz
p11 : [OUT] 変数　：　nx
p12 : [OUT] 変数　：　ny
p13 : [OUT] 変数　：　nz

%inst
地面の指定パーツと、キャラクターとの当たり判定を行います。

地面のパーツ番号を指定する他は、
E3DChkConfGroundと同じです。
E3DChkConfGroundの説明をお読みください。



→引数
1. [IN] 変数または、数値　：　charahsid
　　移動する形状データを識別するid

2. [IN] 変数または、数値　：　groundhsid
　　E3DLoadGroundBMP、
　　または、E3DLoadMQOFileAsGroundで
　　作成した形状データを
　　識別するid

3. [IN] 変数または、数値　：　groundpart
　　当たり判定をしたい地面のパーツの番号を指定します。
　　E3DGetPartNoByNameで取得した番号を
　　指定してください。

4. [IN] 変数または、数値　：　mode
　　０を指定すると、飛ぶモード
　　１を指定すると、地面を這うモード

5. [IN] 変数または、数値　：　diffmaxy
　　一度の移動で登ることが出来る高さの最大値を
　　指定してください。
　　実数。

6. [IN] 変数または、数値　：　mapminy
　　groundhsidで識別されるデータの一番低いＹ座標の値
　　通常は、0.0です。
　　実数。

7. [OUT] 変数　：　result
　　あたり判定の結果が代入されます。
　　
　　mode == 0 のとき
　　　　ぶつからなかった場合は、resutl = 0
　　　　ぶつかった場合は、result = 1
　　mode == 1のとき
　　　　キャラクターの下に地面が無かった場合、
　　　　または、全く移動しなかった場合、
　　　　result = 0

　　　　diffmaxyより高い高さを登ろうとしたとき、
　　　　result = 1

　　　　地面を下に降りたとき、
　　　　または、diffmaxyより低い高さを登ったとき、
　　　　result = 2

　　となります。

8. [OUT] 変数　：　adjustx
9. [OUT] 変数　：　adjusty
10. [OUT] 変数　：　adjustz
　　result != 0 のときに、
　　　　mode == 0のときは、ぶつかった座標
　　　　mode == 1のときは、地面の座標が
　　　　(adjustx, adjusty, adjustz)に代入されます。
　　実数型の変数。

11. [OUT] 変数　：　nx
12. [OUT] 変数　：　ny
13. [OUT] 変数　：　nz
　　result != 0 のときに、
　　　　mode == 0のときは、ぶつかったポリゴン
　　　　mode == 1のときは、地面のポリゴンの
　　　　法線ベクトルが、
　　　　(nx, ny, nz)に代入されます。
　　　　
　　　　跳ね返る方向を決めるときなどに、
　　　　使用できるのではないかと思い、
　　　　加えてみました。
　　　　実数型の変数。



バージョン : ver1.0.0.1

%index
E3DChkConfGroundPart2
地面パーツを指定して、線分と地面の当たり判定を行います。
%group
Easy3D For HSP3 : 当たり判定

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18
p1 : [IN] 変数または、数値　：　befposx
p2 : [IN] 変数または、数値　：　befposy
p3 : [IN] 変数または、数値　：　befposz
p4 : [IN] 変数または、数値　：　newposx
p5 : [IN] 変数または、数値　：　newposy
p6 : [IN] 変数または、数値　：　newposz
p7 : [IN] 変数または、数値　：　groundhsid
p8 : [IN] 変数または、数値　：　groundpart
p9 : [IN] 変数または、数値　：　mode
p10 : [IN] 変数または、数値　：　diffmaxy
p11 : [IN] 変数または、数値　：　mapminy
p12 : [OUT] 変数　：　result
p13 : [OUT] 変数　：　adjustx
p14 : [OUT] 変数　：　adjusty
p15 : [OUT] 変数　：　adjustz
p16 : [OUT] 変数　：　nx
p17 : [OUT] 変数　：　ny
p18 : [OUT] 変数　：　nz

%inst
地面パーツを指定して、線分と地面の当たり判定を行います。

パーツを指定すること以外は、
E3DChkConfGround2と同じです。

詳しくは、E3DChkConfGround2の説明をお読みください。




→引数
1. [IN] 変数または、数値　：　befposx
2. [IN] 変数または、数値　：　befposy
3. [IN] 変数または、数値　：　befposz
　　線分の始点を（befposx, befposy, befposz）で
　　指定します。
　　実数。

4. [IN] 変数または、数値　：　newposx
5. [IN] 変数または、数値　：　newposy
6. [IN] 変数または、数値　：　newposz
　　線分の終点を（newposx, newposy, newposz）で
　　指定します。
　　実数。

7. [IN] 変数または、数値　：　groundhsid
　　E3DLoadGroundBMP、
　　または、E3DLoadMQOFileAsGroundで
　　作成した形状データを
　　識別するid

8. [IN] 変数または、数値　：　groundpart
　　地面のパーツ番号を指定します。
　　E3DGetPartNoByNameで取得した番号を
　　指定してください。

9. [IN] 変数または、数値　：　mode
　　０を指定すると、飛ぶモード
　　１を指定すると、地面を這うモード

10. [IN] 変数または、数値　：　diffmaxy
　　一度の移動で登ることが出来る高さの最大値を
　　指定してください。
　　実数。

11. [IN] 変数または、数値　：　mapminy
　　groundhsidで識別されるデータの一番低いＹ座標の値
　　通常は、０です。
　　実数。

12. [OUT] 変数　：　result
　　あたり判定の結果が代入されます。
　　
　　mode == 0 のとき
　　　　ぶつからなかった場合は、resutl = 0
　　　　ぶつかった場合は、result = 1
　　mode == 1のとき
　　　　キャラクターの下に地面が無かった場合、
　　　　または、全く移動しなかった場合、
　　　　result = 0

　　　　diffmaxyより高い高さを登ろうとしたとき、
　　　　result = 1

　　　　地面を下に降りたとき、
　　　　または、diffmaxyより低い高さを登ったとき、
　　　　result = 2

13. [OUT] 変数　：　adjustx
14. [OUT] 変数　：　adjusty
15. [OUT] 変数　：　adjustz
　　result != 0 のときに、
　　　　mode == 0のときは、ぶつかった座標
　　　　mode == 1のときは、地面の座標が
　　　　(adjustx, adjusty, adjustz)に代入されます。
　　実数型の変数。

16. [OUT] 変数　：　nx
17. [OUT] 変数　：　ny
18. [OUT] 変数　：　nz
　　result != 0 のときに、
　　　　mode == 0のときは、ぶつかったポリゴン
　　　　mode == 1のときは、地面のポリゴンの
　　　　法線ベクトルが、
　　　　(nx, ny, nz)に代入されます。
　　　　
　　　　跳ね返る方向を決めるときなどに
　　　　使用できるのではないかと思い、
　　　　加えてみました。
　　実数型の変数。




バージョン : ver1.0.0.1

%index
E3DGetMidiMusicTime
Midiのミュージックタイムを取得します。
%group
Easy3D For HSP3 : サウンド

%prm
p1,p2
p1 : [IN] 変数または、数値　：　soundid
p2 : [OUT] 変数　：　musictime

%inst
Midiのミュージックタイムを取得します。

4分音符当たり、768の値が取得されます。

E3DLoadSoundでMidiを読み込んでいるときのみ、機能します。

実際に使用する際には、
E3DPlaySoundの直前に取得したmusictimeを
プレイ中に取得したmusictimeから引いた値で
現在位置を確認します。





→引数
1. [IN] 変数または、数値　：　soundid
　　サウンドを識別するＩＤ
　　E3DLoadSoundで取得した値を指定してください。

2. [OUT] 変数　：　musictime
　　現在のミュージックタイムが代入されます。



バージョン : ver1.0.0.1

%index
E3DSetNextMotionFrameNo
モーションの最後のフレーム番号に到達した後、どのモーションの、どのフレーム番号に、ジャンプするかを指定できます。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　srcmotid
p3 : [IN] 数値または、変数　：　nextmotid
p4 : [IN] 数値または、変数　：　nextframeno

%inst
モーションの最後のフレーム番号に到達した後、どのモーションの、どのフレーム番号に、ジャンプするかを指定できます。

この関数で、次のモーションの指定を行っておけば、E3DSetNewPoseで、自動的にモーションが切り替わります。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　srcmotid
3. [IN] 数値または、変数　：　nextmotid
4. [IN] 数値または、変数　：　nextframeno
　　srcmotidのモーションが、最後のフレーム番号に達した後、nextmotidのモーションの、nextframenoのフレーム番号に、ジャンプするように設定されます。



バージョン : ver1.0.0.1

%index
E3DSetLinearFogParams
頂点フォグ（線形）を設定します。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　enable
p2 : [IN] 数値または、変数　：　r
p3 : [IN] 数値または、変数　：　g
p4 : [IN] 数値または、変数　：　b
p5 : [IN] 数値または、変数　：　start
p6 : [IN] 数値または、変数　：　end
p7 : [IN] 数値または、変数　：　hsid

%inst
頂点フォグ（線形）を設定します。
頂点フォグなので、ポリゴンのない部分には、フォグはかかりません。
画面全体にフォグをかけたい場合は、
E3DCreateBGで、背景を作成してください。（背景はポリゴンです。）

具体的な使用例は、
e3dhsp3_wall.hsp
に書きましたので、ご覧ください。





→引数
1. [IN] 数値または、変数　：　enable
　　１を指定すると、フォグが有効に、
　　０を指定すると、フォグが無効になります。

2. [IN] 数値または、変数　：　r
3. [IN] 数値または、変数　：　g
4. [IN] 数値または、変数　：　b
　　フォグの色を、（r, g, b）で指定します。

5 [IN] 数値または、変数　：　start
6. [IN] 数値または、変数　：　end
　　フォグが開始される距離をstartに、
　　フォグが終了する（一番濃くなる）距離をendに
　　指定します。
　　距離は、カメラからの距離です。

7. [IN] 数値または、変数　：　hsid
　　この引数に、モデルデータのhsidを
　　指定することにより、
　　モデル単位でのフォグの指定が可能になります。
　　特殊効果などで、フォグをかけたくない場合などの
　　表示にお使いください。
　　この引数を、省略した場合は、
　　すべてのモデルデータに対して、設定します。




バージョン : ver1.0.0.2で追加<BR>
      

%index
E3DChkConflict3
２つの形状データの指定したパーツ同士が、衝突しているかどうを判定します。
%group
Easy3D For HSP3 : 当たり判定

%prm
p1,p2,p3,p4,p5,p6,p7,p8
p1 : [IN] 変数または、数値　：　hsid1
p2 : [IN] 変数　：　partno1
p3 : [IN] 変数または、数値　：　partnum1
p4 : [IN] 変数または、数値　：　hsid2
p5 : [IN] 変数　：　partno2
p6 : [IN] 変数または、数値　：　partnum2
p7 : [OUT] 変数　：　confflag
p8 : [OUT] 変数　：　inviewflag

%inst
２つの形状データの指定したパーツ同士が、衝突しているかどうを判定します。

パーツの番号に、配列を指定できること以外は、
ほとんど、E3DChkConflict2と同じです。
（inviewflagが微妙に違います）


パーツ番号には、
E3DGetPartNoByNameで取得した、
パーツの番号を渡してください。

partnoに-1を指定すると、
モデル全体とあたり判定をします。


（判定の元になるデータは、
E3DChkInView命令によって、更新されます。）


すべてのパーツが視野外だった場合は、
inviewflagに３が、
ひとつでも視野内のパーツがあった場合は、
inviewflagに０が代入されます。





→引数
1. [IN] 変数または、数値　：　hsid1
　　形状データを識別するid
2. [IN] 変数　：　partno1
　　hsid1のモデル中のパーツの番号の配列
　　dim partno1, partnum1
　　などで配列を作成し、それぞれの配列要素に、
　　判定をしたいパーツの番号を入れてください。
3. [IN] 変数または、数値　：　partnum1
　　partno1に値をセットした要素数を指定してください。


4. [IN] 変数または、数値　：　hsid2
　　形状データを識別するid
5. [IN] 変数　：　partno2
　　hsid2のモデル中のパーツの番号の配列
　　dim partno2, partnum2
　　などで配列を作成し、それぞれの配列要素に、
　　判定をしたいパーツの番号を入れてください。
6. [IN] 変数または、数値　：　partnum2
　　partno2に値をセットした要素数を指定してください。


7. [OUT] 変数　：　confflag
　　hsid1, hsid2で識別される形状同士が、
　　衝突している場合は、１が、
　　衝突していない場合は０がセットされる。

8. [OUT] 変数　：　inviewflag
　　すべてのパーツが視野外だった場合は、
　　inviewflagに３が、
　　１つでも、視野内のパーツがあった場合は、
　　inviewflagに０が代入されます。




バージョン : ver1.0.0.7で追加

%index
E3DChkConfBySphere3
境界球によるあたり判定を、任意のパーツごとに行います。
%group
Easy3D For HSP3 : 当たり判定

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 変数または、数値　：　hsid1
p2 : [IN] 変数　：　partno1
p3 : [IN] 変数または、数値　：　partnum1
p4 : [IN] 変数または、数値　：　hsid2
p5 : [IN] 変数　：　partno2
p6 : [IN] 変数または、数値　：　partnum2
p7 : [OUT] 変数　：　confflag

%inst
境界球によるあたり判定を、任意のパーツごとに行います。

パーツの番号に配列を指定できること以外は、
E3DChkConfBySphere2と同じです。


判定の際に、E3DChkInViewでセットした
データを使用します。


パーツ番号には、
E3DGetPartNoByNameで取得した
パーツの番号を渡してください。

パーツ番号に-1を指定すると、
モデル全体とあたり判定をします。





→引数
1. [IN] 変数または、数値　：　hsid1
　　形状データを識別するid
2. [IN] 変数　：　partno1
　　hsid1のモデル中のパーツの番号の配列
　　dim partno1, partnum1
　　などで配列を作成し、それぞれの配列要素に、
　　判定をしたいパーツの番号を入れてください。
3. [IN] 変数または、数値　：　partnum1
　　partno1に値をセットした要素数を指定してください。


4. [IN] 変数または、数値　：　hsid2
　　形状データを識別するid
5. [IN] 変数　：　partno2
　　hsid2のモデル中のパーツの番号の配列
　　dim partno2, partnum2
　　などで配列を作成し、それぞれの配列要素に、
　　判定をしたいパーツの番号を入れてください。
6. [IN] 変数または、数値　：　partnum2
　　partno2に値をセットした要素数を指定してください。


7. [OUT] 変数　：　confflag
　　hsid1, hsid2で識別される形状同士が、
　　衝突している場合は、１が、
　　衝突していない場合は０がセットされる。



バージョン : ver1.0.0.7で追加

%index
E3DSetMovableAreaThread
スレッドを作成して、E3DSetMovableAreaを実行します。
%group
Easy3D For HSP3 : 壁

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 文字列または、文字列変数　：　filename1
p2 : [IN] 変数または、数値　：　maxx
p3 : [IN] 変数または、数値　：　maxz
p4 : [IN] 変数または、数値　：　divx
p5 : [IN] 変数または、数値　：　divz
p6 : [IN] 変数または、数値　：　wallheight
p7 : [OUT] 変数　：　threadid

%inst
スレッドを作成して、E3DSetMovableAreaを実行します。

作成したスレッドを識別するためのＩＤが
threadidに代入されます。

スレッドの作成に失敗した場合には、
threadidにマイナスの値が、代入されます。

threadidは、
E3DChkThreadWorkingに使用することが
出来ます。

スレッド作成関数は、全部で、4098回まで、
呼ぶことが出来ます。
（E3DChkThreadWorkingを除く）
E3DFreeThreadの説明もご覧ください。


スレッドが終了すると、
E3DChkThreadWorkingで取得される
returnval1に、
モデルデータを識別するhsidが代入されます。

html{
<strong>
</strong>
}htmlver5.0.0.7からは命令ごとに異なるディレクトリにテクスチャがあっても読み込めるようになりました。


E3DSetMovableAreaの説明も、お読みください。




→引数
1. [IN] 文字列または、文字列変数　：　filename1
　　壁の座標情報の元となる、ＢＭＰファイル名

2. [IN] 変数または、数値　：　maxx
　　壁のＸ座標の最大値
　　実数。

3. [IN] 変数または、数値　：　maxz
　　壁のＺ座標の最大値
　　実数。

4. [IN] 変数または、数値　：　divx
　　X方向の分割数

5. [IN] 変数または、数値　：　divz
　　Z方向の分割数

6. [IN] 変数または、数値　：　wallheight
　　作成する壁の高さ
　　実数。

7. [OUT] 変数　：　threadid
　　作成したスレッドを識別する、ＩＤ



バージョン : ver2.0.0.2で追加

%index
E3DCreateSpriteFromBMSCR
HSPの描画画面（E3Dでの描画を除く）と同じ内容のスプライトを作成します。
%group
Easy3D For HSP3 : スプライト

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 変数または、数値　：　wid
p2 : [IN] 変数または、数値　：　transparentflag
p3 : [OUT] 変数　：　spriteID
p4 : [IN] 変数または、数値　：　tpR
p5 : [IN] 変数または、数値　：　tpG
p6 : [IN] 変数または、数値　：　tpB

%inst
HSPの描画画面（E3Dでの描画を除く）と同じ内容のスプライトを作成します。

内部でテクスチャーを使用するため、
画面の大きさが、２の乗数で無い場合は、
スプライトの大きさと画面の大きさが、異なる場合があります。

スプライトの大きさは、
E3DGetSpriteSizeで確認してください。

使い方としては、
非表示のウインドウを作成しておき、
そこに、mes命令などで、描画を行い、
そのウインドウに対して、この関数を呼び、
出来たスプライトを、メインのウインドウに描画する、
などが、考えられます。

html{
<strong>screen命令の４番目の引数で、
パレットモードを指定した場合は、
この関数は、使用できません。</strong>
}html






→引数
1. [IN] 変数または、数値　：　wid
　　ウインドウID

2. [IN] 変数または、数値　：　transparentflag
　　透過フラグ。

　　透過をしない場合は、０を指定してください。

　　１をセットすると、黒色を透過色として色抜きします。

　　２をセットすると、（tpR, tpG, tpB）で指定した色を
　　透過色とします

　　この関数のtransparetflagの意味は、
　　他の関数のtransparentとは、違うので、
　　気を付けてください。


3. [OUT] 変数　：　spriteID
　　作成したスプライトを識別するＩＤ。

4. [IN] 変数または、数値　：　tpR
5. [IN] 変数または、数値　：　tpG
6. [IN] 変数または、数値　：　tpB
　　transparentflag = 2 のとき、
　　透過色を、(tpR, tpG, tpB)で指定します。



バージョン : ver2.0.0.5で追加

%index
E3DLoadMOAFile
モーションアクセラレータファイル（*.moa）を読み込みます。
%group
Easy3D For HSP3 : モーションアクセラレータ

%prm
p1,p2,p3,p4
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 文字列または、文字列の変数　：　fname
p3 : [IN] 数値または変数　：　FillUpFrameLength
p4 : [IN] 変数または、数値　：　mvmult

%inst
モーションアクセラレータファイル（*.moa）を読み込みます。

moaと同じフォルダに、
moaに記述されている全てのquaファイルが、存在しないと
エラーになります。

詳しくは、マニュアルの、rdb2_ma.htmと
e3dhsp3_MotionAccelerator.hsp
をご覧ください。




→引数
1. [IN] 変数または、数値　：　hsid
　　どのモデルデータに対するmoaかを指定する。

2. [IN] 文字列または、文字列の変数　：　fname
　　*.moaのパス文字列。

3. [IN] 数値または変数　：　FillUpFrameLength
　　補間モーションのフレーム長

4. [IN] 変数または、数値　：　mvmult
　　モーションの移動成分に掛ける倍率
　　省略すると１．０
　　実数



バージョン : ver2.0.1.2で追加<BR>
      ver4.0.1.6で引数追加<BR>
      

%index
E3DSetNewPoseByMOA
モーションアクセラレータに基づいて、モーションの更新をします。
%group
Easy3D For HSP3 : モーションアクセラレータ

%prm
p1,p2
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　eventno

%inst
モーションアクセラレータに基づいて、モーションの更新をします。E3DSetNewPoseの代わりに呼んでください。

eventno引数には、通常、２の乗数の値を使用します。
値が大きくなると記述が大変なので、
２の乗数は、e3dhsp3.asで定義しているPOW2X配列を
使用してください。
例えば、２の１５乗の値は、POW2X( 15 ) でアクセス可能です。


詳しくは、マニュアルの、rdb2_ma.htmと
e3dhsp3_MotionAccelerator.hsp
をご覧ください。




→引数
1. [IN] 変数または、数値　：　hsid
　　モデルデータを識別するID

2. [IN] 変数または、数値　：　eventno
　　イベント番号
　　詳しくは、マニュアルの、rdb2_ma.htmをご覧ください。





バージョン : ver2.0.1.2で追加

%index
E3DGetMotionFrameNo
カレント（現在の）のモーション番号と、フレーム番号を取得します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [OUT] 変数　：　mk
p3 : [OUT] 変数　：　frame

%inst
カレント（現在の）のモーション番号と、フレーム番号を取得します。


→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [OUT] 変数　：　mk
　　モーションを識別する番号

3. [OUT] 変数　：　frame
　　フレーム番号



バージョン : ver2.0.1.2で追加

%index
E3DGetKeyboardCnt
256 個の仮想キーの状態(カウンター)を、指定されたバッファkeybufへコピーします。
%group
Easy3D For HSP3 : キーボード

%prm
p1
p1 : [OUT] 変数　：　keybuf

%inst
256 個の仮想キーの状態(カウンター)を、指定されたバッファkeybufへコピーします。


E3DGetKeyboardState関数は、呼び出し時に、キーが押されているかどうかしか、取得できませんが、
E3DGetKeyboardCnt関数は、どのくらいの時間、押し続けているかを表すカウンターを取得できます。

Easy3D内部で、
前回のきーの情報を保存しておき、
呼び出し時に、キーが押されていれば、
カウンターを１増やします。
押されていなければ、カウンターを０にします。


keybuf は、この関数を使用する前に、
dim keybuf, 256
で、確保してください。

複数のキーの状態を、一度の呼び出しで、
取得できます。

例えば、Ａキーのカウンタを調べる場合は、
E3DGetKeyboardCnt
呼び出し後に、
keybuf('A') の値を調べます。
（　’　を忘れずに。　）


具体的な使用例は、zip中の、
e3dhsp3_MotionAccelerator.hspをご覧ください。

バーチャルキー情報は、zip中の、
e3dhsp3.as で、
VK_ で始まる定数として、宣言しています。
html{
<table border="1">
	<tr><th>定数</th>	<th>キー操作</th>	<th>キー操作</th></tr>
	<tr><td>VK_LBUTTON</td>	<td>マウス　左クリック</td>	<td></td></tr>
	<tr><td>VK_RBUTTON</td>	<td>マウス　右クリック</td>	<td></td></tr>
	<tr><td>VK_CANCEL </td>	<td>Ctrl + Break</td>	<td></td></tr>

	<tr><td>VK_MBUTTON</td>	<td>ホイールクリック</td>	<td></td></tr>
	<tr><td>VK_BACK   </td>	<td>Back Space</td>	<td></td></tr>
	<tr><td>VK_TAB    </td>	<td>Tabキー</td>	<td></td></tr>

	<tr><td>VK_CLEAR  </td>	<td>NumLock を外した状態のテンキー5</td>	<td></td></tr>
	<tr><td>VK_RETURN </td>	<td>Enter</td>	<td></td></tr>
	<tr><td>VK_SHIFT  </td>	<td>Shift</td>	<td></td></tr>

	<tr><td>VK_CONTROL</td>	<td>Ctrl</td>	<td></td></tr>
	<tr><td>VK_MENU   </td>	<td>Alt</td>	<td></td></tr>
	<tr><td>VK_PAUSE  </td>	<td>Pause</td>	<td>Ctrl + NumLock</td></tr>

	<tr><td>VK_CAPITAL</td>	<td>Shift + CapsLock</td>	<td></td></tr>
	<tr><td>VK_HANJA  </td>	<td>Alt + 半角／全角（漢字）</td>	<td></td></tr>
	<tr><td>VK_KANJI  </td>	<td>Alt + 半角／全角（漢字）</td>	<td></td></tr>
	<tr><td>VK_ESCAPE </td>	<td>Esc</td>	<td></td></tr>
	<tr><td>VK_SPACE   </td>	<td>スペースキー</td>	<td></td></tr>

	<tr><td>VK_PRIOR   </td>	<td>PageUp</td>	<td></td></tr>
	<tr><td>VK_NEXT    </td>	<td>PageDown</td>	<td></td></tr>
	<tr><td>VK_END     </td>	<td>End</td>	<td>Shift + テンキー1</td></tr>

	<tr><td>VK_HOME    </td>	<td>Home</td>	<td>Shift + テンキー7</td></tr>
	<tr><td>VK_LEFT    </td>	<td>左矢印キー</td>	<td>Shift + テンキー4</td></tr>
	<tr><td>VK_UP      </td>	<td>上矢印キー</td>	<td>Shift + テンキー8</td></tr>
	<tr><td>VK_RIGHT   </td>	<td>右矢印キー</td>	<td>Shift + テンキー6</td></tr>
	<tr><td>VK_DOWN    </td>	<td>下矢印キー</td>	<td>Shift + テンキー2</td></tr>
	<tr><td>VK_SNAPSHOT</td>	<td>PrintScreen</td>	<td></td></tr>
	<tr><td>VK_INSERT  </td>	<td>Insert</td>	<td>Shift + テンキー0</td></tr>

	<tr><td>VK_DELETE  </td>	<td>Delete</td>	<td>Shift + テンキー.</td></tr>
	<tr><td>'0'</td>	<td>0</td>	<td></td></tr>
	<tr><td>...</td>	<td>...</td>	<td></td></tr>
	<tr><td>'9'</td>	<td>9</td>	<td></td></tr>
	<tr><td>'A'</td>	<td>A</td>	<td></td></tr>
	<tr><td>...</td>	<td>...</td>	<td></td></tr>
	<tr><td>'Z'</td>	<td>Z</td>	<td></td></tr>
	<tr><td>VK_LWIN </td>	<td>ウィンドウズキー（左）</td>	<td></td></tr>
	<tr><td>VK_RWIN </td>	<td>ウィンドウズキー（右）</td>	<td></td></tr>
	<tr><td>VK_APPS </td>	<td>Applicationキー	（右クリックと同等機能のキーのことです。）</td>	<td></td></tr>

	<tr><td>VK_NUMPAD0  </td>	<td>テンキーの０</td>	<td></td></tr>
	<tr><td>...</td>	<td>...</td>	<td></td></tr>
	<tr><td>VK_NUMPAD9  </td>	<td>テンキーの９</td>	<td></td></tr>

	<tr><td>VK_MULTIPLY </td>	<td>テンキーの *</td>	<td></td></tr>
	<tr><td>VK_ADD      </td>	<td>テンキーの +</td>	<td></td></tr>
	<tr><td>VK_SUBTRACT </td>	<td>テンキーの -</td>	<td></td></tr>
	<tr><td>VK_DECIMAL  </td>	<td>テンキーの .</td>	<td></td></tr>
	<tr><td>VK_DIVIDE   </td>	<td>テンキーの /</td>	<td></td></tr>

	<tr><td>VK_F1 </td>	<td>F1</td>	<td></td></tr>
	<tr><td>...</td>	<td>...</td>	<td></td></tr>
	<tr><td>VK_F12</td>	<td>F12</td>	<td></td></tr>
	<tr><td>VK_NUMLOCK</td>	<td>NumLock</td>	<td></td></tr>
	<tr><td>VK_SCROLL </td>	<td>ScrollLock</td>	<td></td></tr>
</table>

<table border="1">
	<tr><th>定数</th>	<th>キー操作</th>	<th>キー操作</th></tr>

	<tr><td>VK_LSHIFT  </td>	<td>Shift（左）</td>	<td></td></tr>
	<tr><td>VK_RSHIFT  </td>	<td>Shift（右）</td>	<td></td></tr>
	<tr><td>VK_LCONTROL</td>	<td>Ctrl（左）</td>	<td></td></tr>

	<tr><td>VK_RCONTROL</td>	<td>Ctrl（右）</td>	<td></td></tr>
	<tr><td>VK_LMENU   </td>	<td>Alt（左）</td>	<td></td></tr>
	<tr><td>VK_RMENU   </td>	<td>Alt（右）</td>	<td></td></tr>

	<tr><td>VK_OEM_1     </td>	<td>';:' for US</td>	<td>:*</td></tr>
	<tr><td>VK_OEM_PLUS  </td>	<td>'+' any country</td>	<td>;+</td></tr>
	<tr><td>VK_OEM_COMMA </td>	<td>',' any country</td>	<td>,&lt;</td></tr>

	<tr><td>VK_OEM_MINUS </td>	<td>'-' any country</td>	<td>-=</td></tr>
	<tr><td>VK_OEM_PERIOD</td>	<td>'.' any country</td>	<td>.&gt;</td></tr>
	<tr><td>VK_OEM_2     </td>	<td>'/?' for US</td>	<td>/?</td></tr>

	<tr><td>VK_OEM_3     </td>	<td>'`~' for US</td>	<td>@`</td></tr>
	<tr><td>VK_OEM_4</td>	<td>'[{' for US</td>	<td>[{</td></tr>
	<tr><td>VK_OEM_5</td>	<td>'\|' for US</td>	<td>\ |</td></tr>

	<tr><td>VK_OEM_6</td>	<td>']}' for US</td>	<td>]}</td></tr>
	<tr><td>VK_OEM_7</td>	<td>''"' for US</td>	<td>^~</td></tr>
</table>

<table border="1">
	<tr><th>定数</th>	<th>キー操作</th>	<th>キー操作</th></tr>
	<tr><td>VK_OEM_102  </td>	<td>"<>" or "\|" on RT 102-key kbd.</td>	<td>_ろ</td></tr>
</table>
}html


→引数
 1. [OUT] 変数　：　keybuf
　　keybufに、キーの状態(カウンタ)が、代入されます。
　　keybufは、dim keybuf, 256 で、
　　作成されている必要があります。



バージョン : ver2.0.1.2で追加

%index
E3DResetKeyboardCnt
E3DGetKeyboardCntが、内部で使用する、前回のキーの情報をリセットします。
%group
Easy3D For HSP3 : キーボード

%prm
なし

%inst
E3DGetKeyboardCntが、内部で使用する、前回のキーの情報をリセットします。




→引数
なし

バージョン : ver2.0.1.2で追加

%index
E3DEncodeBeta
ファイルの内容を、暗号化します。
%group
Easy3D For HSP3 : 簡易暗号化

%prm
p1,p2
p1 : [IN] 文字列または、文字列変数　：　filename
p2 : [IN] 配列変数　：　rnd10

%inst
ファイルの内容を、暗号化します。

暗号化といっても、超簡易な方法ですので、
プログラムに詳しい人なら、復号できてしまう程度のものです。

ファイルを、暗号化して、内容を上書きします。
暗号化したファイルに対して
、この関数を呼べば、暗号化前のファイルに戻ります。





→引数
1. [IN] 文字列または、文字列変数　：　filename
　　簡易暗号化するファイル名

2. [IN] 配列変数　：　rnd10
　　簡易暗号化する際に使用する、
　　ランダムなキー配列を指定します。
　　キーは、１０個指定します。
　　キーの値は、０から２５５の値を使用してください。
　　dim rnd10, 10
　　で、配列を作成してから、値をセットしてください。





バージョン : ver2.0.1.3で追加

%index
E3DDecodeBeta
E3DEncodeBetaで暗号化したファイルを、バッファ上で復号します。
%group
Easy3D For HSP3 : 簡易暗号化

%prm
p1,p2,p3
p1 : [IN] 文字列または、文字列変数　：　filename
p2 : [IN] 配列変数　：　rnd10
p3 : [OUT] 配列変数　：　dstbuffer

%inst
E3DEncodeBetaで暗号化したファイルを、バッファ上で復号します。

バッファは、sdimで確保してください。





→引数
1. [IN] 文字列または、文字列変数　：　filename
　　復号するファイル名

2. [IN] 配列変数　：　rnd10
　　E3DEncodeBetaで使用したのと同じ内容の
　　キー配列。

3. [OUT] 配列変数　：　dstbuffer
　　復号した内容が、セットされます。
　　ファイルの長さをflengthとした場合、
　　sdim dstbuffer, flength
　　で作成したバッファーを指定してください。




バージョン : ver2.0.1.3で追加

%index
E3DGetMoaInfo
Moaファイルを読み込んだ場合のモーションの名前とIDを取得します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　motmaxnum
p3 : [OUT] 文字列の配列変数　：　motionname
p4 : [OUT] 配列変数　：　motionid
p5 : [OUT] 変数　：　motgetnum

%inst
Moaファイルを読み込んだ場合のモーションの名前とIDを取得します。

motmaxnumは、大き目の値を設定してください。
この値が実際のモーションの数よりも小さいとエラーになります。

motionname引数は、
sdim motionname, 256, motmaxnum
で作成した配列を指定してください。

motionid引数は、
dim motionid, motmaxnum
で作成した配列を指定してください。


詳しい使い方は、
e3dhsp3_MotionAccelerator.hspをご覧ください。



→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　motmaxnum
　　データ取得用配列の大きさ（モーションの数）を指定します。

3. [OUT] 文字列の配列変数　：　motionname
　　名前情報を取得するための配列を渡してください。
　　左に書いた方法で、sdimした配列を渡してください。

4. [OUT] 配列変数　：　motionid
　　モーションIDを取得するための配列変数を渡してください。
　　右に書いた方法で、dimした配列を渡してください。

5. [OUT] 変数　：　motgetnum
　　何個のモーションの情報を出力したかが、代入されます。



バージョン : ver3.0.0.1で追加

%index
E3DGetNextMotionFrameNo
E3DSetNextMotionFrameNoで設定した情報を取得します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　motid
p3 : [OUT] 変数　：　nextmotionid
p4 : [OUT] 変数　：　nextframe

%inst
E3DSetNextMotionFrameNoで設定した情報を取得します。

Moaファイルを読み込んで、
E3DSetNewPoseByMOAを使用する場合、
モーションとモーションの間に補間モーションが入ります。
この補間モーションのモーションIDはver3001では常に０です。

この補間モーションには、E3Dが内部で、
次のモーションをE3DSetNextMotionFrameNoでセットしています。

つまり、この補間モーションに対して、
E3DGetNextMotionFrameNoを呼び出せば、
次に再生するモーションの情報が取得できるというわけです。





→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　motid
　　現在のモーションのID


3. [OUT] 変数　：　nextmotionid
　　次に再生されるモーションのID

4. [OUT] 変数　：　nextframe
　　フレーム番号


バージョン : ver3.0.0.1で追加

%index
E3DGetScreenPos3
形状データの画面上での2Dの座標を取得する関数です。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6,p7,p8
p1 : [IN] 変数または、数値　：　scid
p2 : [IN] 数値または、変数　：　hsid
p3 : [IN] 数値または、変数　：　partno
p4 : [OUT] 変数　：　scx
p5 : [OUT] 変数　：　scy
p6 : [OUT] 変数　：　scz
p7 : [IN] 数値または、変数　：　vertno
p8 : [IN] 数値または、変数　：　calcmode

%inst
形状データの画面上での2Dの座標を取得する関数です。
奥行き情報Zも取得できます。

パーツ単位、モデル単位、ビルボード単位で
使用できます。

頂点単位での２Ｄ座標も取得できます。

３Ｄキャラクターの位置に、2Dのスプライトを表示する、などの用途に使えます。

Z情報は、スプライト描画時のZ指定の値に使用できます。


html{
<strong>E3DChkInViewより後で、呼び出してください。</strong>
}html


具体的な使用例は、zip中の、
html{
<strong>e3dhsp3_pickvert.hsp</strong>
}html
に書きましたので、ご覧ください。






→引数
1. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。

2. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ
　　-1を指定すると、ビルボードの２Ｄ位置を取得できます。

3. [IN] 数値または、変数　：　partno
　　設定したいパーツの番号を指定します。

　　E3DGetPartNoByNameで取得した番号を渡してください。

　　hsidに-1を指定した場合は、
　　E3DCreateBillboardで取得した、
　　ビルボードidを渡してください。

　　partnoに-1を渡すと、
　　モデル全体の中心座標の２Ｄ座標を
　　取得できます。

4. [OUT] 変数　：　scx
5. [OUT] 変数　：　scy
　　指定したパーツの2Dスクリーン座標が代入されます。
　　整数。　

　　ただし、以下の場合には、
　　scx = -1, scy = -1が代入されます。
　　
　　１，パーツが表示用オブジェクトではない場合
　　２，パーツ全体が画面外にある場合
　　３，パーツのディスプレイスイッチがオフの場合
　　４，パーツが無効になっていた場合
　　　　（E3DSetValidFlagで０を指定した場合）

6. [OUT] 変数　：　scz
　　奥行き情報Z
　　実数の変数。
　　この値に０から１の範囲外の値が得られた場合は、
　　画面に描画されない頂点です。


7. [IN] 数値または、変数　：　vertno
　　取得したい頂点の番号を指定します。
　　この引数を省略した場合や、-1を指定した場合は、
　　パーツの中心の２Ｄ座標を取得します。

8. [IN] 数値または、変数　：　calcmode
　　1を指定してください。


バージョン : ver3.0.0.1で追加

%index
E3DEnableToonEdge
輪郭線のオンオフをします。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　type
p4 : [IN] 数値または、変数　：　flag

%inst
輪郭線のオンオフをします。

トゥーン設定されたsigを読み込んでいる状態か、
もしくは、E3DSetShaderTypeでCOL_TOON1を設定している状態か
でしか機能しません。






→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　partno
　　設定したいパーツの番号を指定します。
　　E3DGetPartNoByNameで取得した番号を
　　渡してください。

　　partnoに-1を渡すと、
　　モデル全体の輪郭線のオンオフをします。

3. [IN] 数値または、変数　：　type
　　輪郭線のタイプを指定します。
　　０を指定してください。

4. [IN] 数値または、変数　：　flag
　　輪郭をオンにしたい場合は１を、
　　オフにしたい場合は０を指定してください。



バージョン : ver3.0.1.1で追加

%index
E3DSetToonEdge0Color
輪郭線の色をセットします。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 文字列または、文字列の変数　：　materialname
p4 : [IN] 数値または、変数　：　r
p5 : [IN] 数値または、変数　：　g
p6 : [IN] 数値または、変数　：　b

%inst
輪郭線の色をセットします。

トゥーン設定されたsigを読み込んでいる状態か、
もしくは、E3DSetShaderTypeでCOL_TOON1を設定している状態か
でしか機能しません。





→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　partno
　　設定したいパーツの番号を指定します。
　　E3DGetPartNoByNameで取得した番号を
　　渡してください。

　　partnoに-1を渡すと、
　　モデル全体の輪郭線の色を設定します。

3. [IN] 文字列または、文字列の変数　：　materialname
　　マテリアルの名前を指定します。
　　RokDeBone2の「トゥ」ボタンを押したときに
　　リストボックスに表示されるマテリアル名を
　　指定してください。

　　partnoに-1を指定している場合は、
　　&quot;dummy&quot;と指定してください。

4. [IN] 数値または、変数　：　r
5. [IN] 数値または、変数　：　g
6. [IN] 数値または、変数　：　b
　　色のRGBを指定します。
　　それぞれ、０から２５５の整数を指定してください。





バージョン : ver3.0.1.1で追加

%index
E3DSetToonEdge0Width
輪郭線の幅をセットします。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 文字列または、文字列の変数　：　materialname
p4 : [IN] 数値または、変数　：　width

%inst
輪郭線の幅をセットします。

トゥーン設定されたsigを読み込んでいる状態か、
もしくは、E3DSetShaderTypeでCOL_TOON1を設定している状態か
でしか機能しません。





→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　partno
　　設定したいパーツの番号を指定します。
　　E3DGetPartNoByNameで取得した番号を
　　渡してください。

　　partnoに-1を渡すと、
　　モデル全体の輪郭線の色を設定します。

3. [IN] 文字列または、文字列の変数　：　materialname
　　マテリアルの名前を指定します。
　　RokDeBone2の「トゥ」ボタンを押したときに
　　リストボックスに表示されるマテリアル名を
　　指定してください。

　　partnoに-1を指定している場合は、
　　&quot;dummy&quot;と指定してください。

4. [IN] 数値または、変数　：　width
　　輪郭の幅を実数で指定してください。




バージョン : ver3.0.1.1で追加

%index
E3DGetToonEdge0Color
輪郭線の色を取得します。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 文字列または、文字列の変数　：　materialname
p4 : [OUT] 変数　：　r
p5 : [OUT] 変数　：　g
p6 : [OUT] 変数　：　b

%inst
輪郭線の色を取得します。

トゥーン設定されたsigを読み込んでいる状態か、
もしくは、E3DSetShaderTypeでCOL_TOON1を設定している状態か
でしか機能しません。





→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　partno
　　設定したいパーツの番号を指定します。
　　E3DGetPartNoByNameで取得した番号を
　　渡してください。

3. [IN] 文字列または、文字列の変数　：　materialname
　　マテリアルの名前を指定します。
　　RokDeBone2の「トゥ」ボタンを押したときに
　　リストボックスに表示されるマテリアル名を
　　指定してください。

4. [OUT] 変数　：　r
5. [OUT] 変数　：　g
6. [OUT] 変数　：　b
　　輪郭の色のRGBが代入されます。
　　それぞれ、０から２５５の整数が取得されます。

　　指定したマテリアルが見つからなかった場合は
　　(0, 0, 0)が代入されます。



バージョン : ver3.0.1.1で追加

%index
E3DGetToonEdge0Width
輪郭線の幅を取得します。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 文字列または、文字列の変数　：　materialname
p4 : [OUT] 変数　：　width

%inst
輪郭線の幅を取得します。

トゥーン設定されたsigを読み込んでいる状態か、
もしくは、E3DSetShaderTypeでCOL_TOON1を設定している状態か
でしか機能しません。





→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　partno
　　設定したいパーツの番号を指定します。
　　E3DGetPartNoByNameで取得した番号を
　　渡してください。

3. [IN] 文字列または、文字列の変数　：　materialname
　　マテリアルの名前を指定します。
　　RokDeBone2の「トゥ」ボタンを押したときに
　　リストボックスに表示されるマテリアル名を
　　指定してください。

4. [OUT] 変数　：　width
　　輪郭の幅が代入されます。
　　実数型の変数。

　　指定したマテリアルが見つからなかった場合は、
　　0.0が代入されます。



バージョン : ver3.0.1.1で追加

%index
E3DCreateParticle
パーティクルを作成します。
%group
Easy3D For HSP3 : パーティクル

%prm
p1,p2,p3,p4,p5,p6,p7,p8
p1 : [IN] 数値または、変数　：　maxnum
p2 : [IN] 文字列または、文字列の変数　：　texname
p3 : [IN] 数値または、変数　：　width
p4 : [IN] 数値または、変数　：　height
p5 : [IN] 数値または、変数　：　blendmode
p6 : [OUT] 変数　：　particleid
p7 : [IN] 数値または、変数　：　transparentflag
p8 : [IN] 数値または、変数　：　cmpalways

%inst
パーティクルを作成します。

具体的な使用例は、
e3dhsp3_particle.hsp
をご覧ください。



→引数
1. [IN] 数値または、変数　：　maxnum
　　表示できるパーティクルの最大数を指定します。
　　２０００以下の数字を指定してください。

2. [IN] 文字列または、文字列の変数　：　texname
　　テクスチャー名をフルパスで指定します。

3. [IN] 数値または、変数　：　width
　　パーティクルの幅を指定します。
　　実数。

4. [IN] 数値または、変数　：　height
　　パーティクルの高さを指定します。
　　実数。

5. [IN] 数値または、変数　：　blendmode
　　半透明のブレンドモードを指定します。
　　０を指定すると、
　　テクスチャのアルファによるブレンドをします。
　　１を指定すると、
　　アッドモードでのブレンドをします。
　　２を指定すると、
　　頂点のアルファを考慮した
　　アッドモードブレンドをします。

6. [OUT] 変数　：　particleid
　　パーティクルを識別するIDが代入されます。

7. [IN] 数値または、変数　：　transparentflag
　　１を指定すると黒色を透過します（BMP用）。
　　０を指定すると、画像ファイルのアルファを
　　そのまま使います。

　　引数を省略すると１が適用されます。

8. [IN] 数値または、変数　：　cmpalways
　　１を指定するとZバッファの比較を行わずに
　　常に描画するようになります。
　　デフォルトは０。





バージョン : ver3.0.1.5で追加<BR>
      ver3.0.3.1で引数追加<BR>
      ver4.0.0.1で引数追加<BR>
      

%index
E3DDestroyParticle
パーティクルを破棄します。
%group
Easy3D For HSP3 : パーティクル

%prm
p1
p1 : [IN] 数値または、変数　：　particleid

%inst
パーティクルを破棄します。




→引数
1. [IN] 数値または、変数　：　particleid
　　削除したいパーティクルを識別するIDを指定します。



バージョン : ver3.0.1.5で追加

%index
E3DSetParticlePos
パーティクルの場所を設定します。
%group
Easy3D For HSP3 : パーティクル

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　particleid
p2 : [IN] 数値または、変数　：　posx
p3 : [IN] 数値または、変数　：　posy
p4 : [IN] 数値または、変数　：　posz

%inst
パーティクルの場所を設定します。
設定した場所からパーティクルが噴き出します。

具体的な使用例は、
e3dhsp3_particle.hsp
をご覧ください。



→引数
1. [IN] 数値または、変数　：　particleid
　　パーティクルを識別するIDを指定します。

2. [IN] 数値または、変数　：　posx
3. [IN] 数値または、変数　：　posy
4. [IN] 数値または、変数　：　posz
　　パーティクルの位置を（posx, posy, posz）に
　　指定します。
　　実数。




バージョン : ver3.0.1.5で追加

%index
E3DSetParticleGravity
パーティクルの重力を設定します。
%group
Easy3D For HSP3 : パーティクル

%prm
p1,p2
p1 : [IN] 数値または、変数　：　particleid
p2 : [IN] 数値または、変数　：　gravity

%inst
パーティクルの重力を設定します。
設定した値は、Y方向の負の加速度として計算に使用されます。

具体的な使用例は、
e3dhsp3_particle.hsp
をご覧ください。



→引数
1. [IN] 数値または、変数　：　particleid
　　パーティクルを識別するIDを指定します。

2. [IN] 数値または、変数　：　gravity
　　重力を指定します。
　　実数。



バージョン : ver3.0.1.5で追加

%index
E3DSetParticleLife
パーティクルの寿命を設定します。
%group
Easy3D For HSP3 : パーティクル

%prm
p1,p2
p1 : [IN] 数値または、変数　：　particleid
p2 : [IN] 数値または、変数　：　life

%inst
パーティクルの寿命を設定します。
パーティクルが噴き出してから消えるまでの時間を
秒で指定します。

具体的な使用例は、
e3dhsp3_particle.hsp
をご覧ください。



→引数
1. [IN] 数値または、変数　：　particleid
　　パーティクルを識別するIDを指定します。

2. [IN] 数値または、変数　：　life
　　パーティクルの寿命を指定します。
　　実数。
　　秒。




バージョン : ver3.0.1.5で追加

%index
E3DSetParticleEmitNum
パーティクルの生成個数をします。
%group
Easy3D For HSP3 : パーティクル

%prm
p1,p2
p1 : [IN] 数値または、変数　：　particleid
p2 : [IN] 数値または、変数　：　emitnum

%inst
パーティクルの生成個数をします。
E3DRenderParticleを呼ぶたびに指定した個数だけ生成されます。
実数での指定が可能です。
例えば０．２と指定した場合は、
５回E3DRenderParticleを呼び出すごとに１個パーティクルが
生成されます。

具体的な使用例は、
e3dhsp3_particle.hsp
をご覧ください。



→引数
1. [IN] 数値または、変数　：　particleid
　　パーティクルを識別するIDを指定します。

2. [IN] 数値または、変数　：　emitnum
　　パーティクルの１回あたりの生成個数を指定します。
　　実数。



バージョン : ver3.0.1.5で追加

%index
E3DSetParticleVel0
パーティクルの速度を指定します。
%group
Easy3D For HSP3 : パーティクル

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 数値または、変数　：　particleid
p2 : [IN] 数値または、変数　：　minvelx
p3 : [IN] 数値または、変数　：　minvely
p4 : [IN] 数値または、変数　：　minvelz
p5 : [IN] 数値または、変数　：　maxvelx
p6 : [IN] 数値または、変数　：　maxvely
p7 : [IN] 数値または、変数　：　maxvelz

%inst
パーティクルの速度を指定します。

速度の最低値をminvelx, minvely, minvelzに指定し、
速度の最大値をmaxvelx, maxvely, maxvelzに指定します。

最低値と最大値の幅が広いほど、
パーティクルは、まばらに放出されます。

具体的な使用例は、
e3dhsp3_particle.hsp
をご覧ください。



→引数
1. [IN] 数値または、変数　：　particleid
　　パーティクルを識別するIDを指定します。

2. [IN] 数値または、変数　：　minvelx
3. [IN] 数値または、変数　：　minvely
4. [IN] 数値または、変数　：　minvelz
　　パーティクルの速度の最小値を指定します。
　　実数。

5. [IN] 数値または、変数　：　maxvelx
6. [IN] 数値または、変数　：　maxvely
7. [IN] 数値または、変数　：　maxvelz
　　パーティクルの速度の最大値を指定します。
　　実数。





バージョン : ver3.0.1.5で追加

%index
E3DSetParticleRotation
パーティクルの回転を指定します。
%group
Easy3D For HSP3 : パーティクル

%prm
p1,p2
p1 : [IN] 数値または、変数　：　particleid
p2 : [IN] 数値または、変数　：　rotation

%inst
パーティクルの回転を指定します。

この関数を呼び出すたびに、
パーティクルが指定角度だけ回転します。

具体的な使用例は、
e3dhsp3_particle.hsp
をご覧ください。



→引数
1. [IN] 数値または、変数　：　particleid
　　パーティクルを識別するIDを指定します。

2. [IN] 数値または、変数　：　rotation
　　パーティクルの回転を角度（度）で指定します。



バージョン : ver3.0.1.5で追加

%index
E3DSetParticleDiffuse
パーティクルの頂点色を指定します。
%group
Easy3D For HSP3 : パーティクル

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　particleid
p2 : [IN] 数値または、変数　：　r
p3 : [IN] 数値または、変数　：　g
p4 : [IN] 数値または、変数　：　b

%inst
パーティクルの頂点色を指定します。

テクスチャ色とモジュレートされて表示されます。

具体的な使用例は、
e3dhsp3_particle.hsp
をご覧ください。



→引数
1. [IN] 数値または、変数　：　particleid
　　パーティクルを識別するIDを指定します。

2. [IN] 数値または、変数　：　r
3. [IN] 数値または、変数　：　g
4. [IN] 数値または、変数　：　b
　　パーティクルの頂点色を指定します。
　　それぞれ、０から２５５の間の値を指定します。






バージョン : ver3.0.1.5で追加

%index
E3DRenderParticle
パーティクルを描画します。
%group
Easy3D For HSP3 : パーティクル

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　particleid
p2 : [IN] 数値または、変数　：　fps
p3 : [IN] 変数または、数値　：　scid
p4 : [IN] 変数または、数値　：　onlyupdate

%inst
パーティクルを描画します。

呼び出すたびに、パーティクルの消滅、生成、位置移動をして、
描画します。

1.0 / fps 秒だけ時間を進めて描画します。
fpsにマイナスの値を指定した場合は、
パーティクルが静止した状態で描画します。


E3DCreateParticleで指定したmaxnum個より多いパーティクルは
描画できません。
パーティクルの噴出が、途中で途切れる場合は、
maxnumの値を増やすか、または、
E3DSetParticleEmitNumの値を小さくするか、または、
E3DSetParticleLifeに指定するlifeの値を小さくしてください。

具体的な使用例は、
e3dhsp3_particle.hsp
をご覧ください。



→引数
1. [IN] 数値または、変数　：　particleid
　　パーティクルを識別するIDを指定します。

2. [IN] 数値または、変数　：　fps
　　１秒間に何回、この関数を呼ぶかを
　　指定してください。

3. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。

4. [IN] 変数または、数値　：　onlyupdate
　　１を指定した場合は、
　　描画を行わず状態のアップデートのみ行います。
　　０を指定した場合や省略した場合は
　　通常通りアップデートと描画を行います。



バージョン : ver3.0.1.5で追加<BR>
      ver4.0.0.8で引数追加

%index
E3DSetParticleAlpha
パーティクルの透明度を設定します。
%group
Easy3D For HSP3 : パーティクル

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　particleid
p2 : [IN] 数値または、変数　：　mintime
p3 : [IN] 数値または、変数　：　maxtime
p4 : [IN] 数値または、変数　：　alpha

%inst
パーティクルの透明度を設定します。

パーティクルが放出されてからの時間帯ごとに、
設定可能です。

生成されてからの時間が、mintimeからmaxtimeの間にある
パーティクルに対して、処理を行います。

ver3.0.1.7で負荷は気にしなくていい程度になりました。

呼び出すたびに設定されます。
ループ中で使用します。
（一回だけ呼び出しても意味がありません）


具体的な使用例は、
e3dhsp3_particle2.hsp
をご覧ください。





→引数
1. [IN] 数値または、変数　：　particleid
　　パーティクルを識別するIDを指定します。

2. [IN] 数値または、変数　：　mintime
3. [IN] 数値または、変数　：　maxtime
　　処理したいパーティクルの時間帯を
　　秒で指定します。

4. [IN] 数値または、変数　：　alpha
　　透明度を０から１の間の実数で指定します。




バージョン : ver3.0.1.6で追加

%index
E3DSetParticleUVTile
パーティクルのUVを設定します。
%group
Easy3D For HSP3 : パーティクル

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 数値または、変数　：　particleid
p2 : [IN] 数値または、変数　：　mintime
p3 : [IN] 数値または、変数　：　maxtime
p4 : [IN] 数値または、変数　：　unum
p5 : [IN] 数値または、変数　：　vnum
p6 : [IN] 数値または、変数　：　tileno

%inst
パーティクルのUVを設定します。

パーティクルが放出されてからの時間帯ごとに、
設定可能です。

生成されてからの時間が、mintimeからmaxtimeの間にある
パーティクルに対して、処理を行います。

この処理は、ビデオメモリにアクセスする必要があるので、
ちょっと重い処理です。
ひとつの画像に、タイル画像を敷き詰めたテクスチャの、ＵＶ座標を、タイル番号で、セットできます。

タイル状のテクスチャ画像とタイル番号の対応は、(Link http://www5d.biglobe.ne.jp/~ochikko/e3dhsp_texturetile.htm )タイル番号の説明をご覧ください。


呼び出すたびに設定されます。
ループ中で使用します。
（一回だけ呼び出しても意味がありません）


具体的な使用例は、
e3dhsp3_particle2.hsp
をご覧ください。





→引数
1. [IN] 数値または、変数　：　particleid
　　パーティクルを識別するIDを指定します。

2. [IN] 数値または、変数　：　mintime
3. [IN] 数値または、変数　：　maxtime
　　処理したいパーティクルの時間帯を
　　秒で指定します。

4. [IN] 数値または、変数　：　unum
　　テクスチャの横方向の分割数を指定します。

5. [IN] 数値または、変数　：　vnum
　　テクスチャの縦方向の分割数を指定します。

6. [IN] 数値または、変数　：　tileno
　　設定したいタイル番号を指定します。




バージョン : ver3.0.1.6で追加

%index
E3DInitParticle
パーティクルの発生状態を初期状態に戻します。
%group
Easy3D For HSP3 : パーティクル

%prm
p1
p1 : [IN] 数値または、変数　：　particleid

%inst
パーティクルの発生状態を初期状態に戻します。


→引数
1. [IN] 数値または、変数　：　particleid
　　パーティクルを識別するIDを指定します。



バージョン : ver3.0.1.8で追加

%index
E3DPickFace2
２Ｄの画面の座標に対応する、３Ｄモデルの座標を取得できます。
%group
Easy3D For HSP3 : 当たり判定

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17
p1 : [IN] 変数または、数値　：　scid
p2 : [IN] 数値または、変数　：　hsid
p3 : [IN] 配列変数　：　partarray
p4 : [IN] 数値または、変数　：　partnum
p5 : [IN] 数値または、変数　：　pos2x
p6 : [IN] 数値または、変数　：　pos2y
p7 : [IN] 数値または、変数　：　maxdist
p8 : [OUT] 変数　：　partno
p9 : [OUT] 変数　：　faceno
p10 : [OUT] 変数　：　pos3x
p11 : [OUT] 変数　：　pos3y
p12 : [OUT] 変数　：　pos3z
p13 : [OUT] 変数　：　nx
p14 : [OUT] 変数　：　ny
p15 : [OUT] 変数　：　nz
p16 : [OUT] 変数　：　dist
p17 : [IN] 数値または、変数　：　calcmode

%inst
２Ｄの画面の座標に対応する、３Ｄモデルの座標を取得できます。

判定したいパーツを指定できる点以外は、
E3DPickFaceと同じです。
詳しくはE3DPciFaceの説明をお読みください。

パーツ番号３とパーツ番号４についてのみ、判定を行いたい場合は、
partnum = 2
dim partarray, partnum
partarray( 0 ) = 3
partarray( 1 ) = 4
の様に値をセットして、E3DPickFace2を呼び出してください。




→引数
1. [IN] 変数または、数値　：　scid
　　スワップチェインＩＤ。
　　E3DInitやE3DCreateSwapChainで取得したＩＤを
　　指定してください。

2. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。

3. [IN] 配列変数　：　partarray
　　判定したいパーツ番号を指定します。
　　dim partarray, partnumで作成してください。

4. [IN] 数値または、変数　：　partnum
　　partarray配列の要素数


5. [IN] 数値または、変数　：　pos2x
6. [IN] 数値または、変数　：　pos2y
　　画面上の２Ｄ座標を指定してください。

7. [IN] 数値または、変数　：　maxdist
　　どのくらいの距離まで、３Ｄモデルの検索をするかを指定します。
　　この値を小さくするほど、処理は高速になります。

8. [OUT] 変数　：　partno
9. [OUT] 変数　：　faceno
　　2D座標に対応する３Ｄ座標が見つかった場合に、
　　その３Ｄモデルのパーツの番号と、面の番号が
　　代入されます。

　　見つからなかった場合は、-1が代入されます。

10. [OUT] 変数　：　pos3x
11. [OUT] 変数　：　pos3y
12. [OUT] 変数　：　pos3z
　　２Ｄ座標に対応する３Ｄ座標が代入されます。
　　partnoに-1以外の値が代入されているときのみ、
　　これらの値は意味を持ちます。
　　実数型の変数。

13. [OUT] 変数　：　nx
14. [OUT] 変数　：　ny
15. [OUT] 変数　：　nz
　　2D座標に対応する３Ｄ座標を含む面の法線ベクトルが
　　代入されます。

　　ベクトルの大きさは１のものを代入します。

　　partnoに-1以外の値が代入されているときのみ、
　　これらの値は意味を持ちます。

　　実数型の変数。

16. [OUT] 変数　：　dist
　　視点と（pos3x, pos3y, pos3z）との距離が代入されます。
　　partnoに-1以外の値が代入されているときのみ、
　　この値は意味を持ちます。
　　実数型の変数。

17. [IN] 数値または、変数　：　calcmode
　　１を指定してください。



バージョン : ver3.0.2.0で追加

%index
E3DChkConfWall3
E3DSetMovableArea, または、E3DLoadMQOFileAsMovableAreaで作成した壁データと、キャラクターのあたり判定を行います。
%group
Easy3D For HSP3 : 当たり判定

%prm
p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12
p1 : [IN] 変数または、数値　：　charahsid
p2 : [IN] 変数または、数値　：　groundhsid
p3 : [IN] 配列変数　：　partarray
p4 : [IN] 数値または、変数　：　partnum
p5 : [IN] 変数または、数値　：　dist
p6 : [OUT] 変数　：　result
p7 : [OUT] 変数　：　adjustx
p8 : [OUT] 変数　：　adjusty
p9 : [OUT] 変数　：　adjustz
p10 : [OUT] 変数　：　nx
p11 : [OUT] 変数　：　ny
p12 : [OUT] 変数　：　nz

%inst
E3DSetMovableArea, または、E3DLoadMQOFileAsMovableAreaで作成した壁データと、キャラクターのあたり判定を行います。

判定したい壁データのパーツ番号を指定できる点以外は、
E3DChkConfWallと同じです。
詳しくは、E3DChkConfWallの説明をお読みください。

壁モデルのパーツ番号３とパーツ番号４についてのみ、
判定を行いたい場合は、
partnum = 2
dim partarray, partnum
partarray( 0 ) = 3
partarray( 1 ) = 4
の用に値をセットして、E3DConfWall3を呼び出してください。






→引数
1. [IN] 変数または、数値　：　charahsid
　　移動する形状データを識別するid

2. [IN] 変数または、数値　：　groundhsid
　　E3DSetMovableArea、
　　または、E3DLoadMQOFileAsMovableAreaで
　　作成した形状データを
　　識別するid

3. [IN] 配列変数　：　partarray
　　判定したい壁のパーツ番号を指定します。
　　dim partarray, partnumで作成してください。

4. [IN] 数値または、変数　：　partnum
　　partarray配列の要素数

5. [IN] 変数または、数値　：　dist
　　跳ね返る距離。
　　distに大きな値を入れると、
　　ぶつかった際に大きく跳ね返るようになります。
　　実数。

6. [OUT] 変数　：　result
　　あたり判定の結果が代入されます。
　　壁とぶつかった場合は１が、
　　ぶつからなかった場合は、０が、代入されます。

7. [OUT] 変数　：　adjustx
8. [OUT] 変数　：　adjusty
9. [OUT] 変数　：　adjustz
　　result != 0 のときに、
　　修正後の座標が、
　　(adjustx, adjusty, adjustz)に代入されます。
　　実数型の変数。

10. [OUT] 変数　：　nx
11. [OUT] 変数　：　ny
12. [OUT] 変数　：　nz
　　result != 0 のときに、
　　ぶつかった面の法線ベクトルの値が、
　　代入されます。
　　実数型の変数。



バージョン : ver3.0.2.0で追加

%index
E3DGetMotionIDByName
モーションの名前からモーションのIDを取得します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 文字列または、文字列変数　：　motname
p3 : [OUT] 変数　：　motid

%inst
モーションの名前からモーションのIDを取得します。


→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 文字列または、文字列変数　：　motname
　　RokDeBone2で設定したモーションの名前。

3. [OUT] 変数　：　motid
　　名前がmotnameであるモーションのIDが代入されます。



バージョン : ver3.0.2.0で追加

%index
E3DGetMotionNum
読み込んでいるモーションの総数を取得します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2
p1 : [IN] 変数または、数値　：　hsid
p2 : [OUT] 変数　：　motnum

%inst
読み込んでいるモーションの総数を取得します。


→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [OUT] 変数　：　motnum
　　モーションの総数が代入されます。


バージョン : ver3.0.2.0で追加

%index
E3DDot2
内積を計算します。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 変数または、数値　：　vecx1
p2 : [IN] 変数または、数値　：　vecy1 
p3 : [IN] 変数または、数値　：　vecz1
p4 : [IN] 変数または、数値　：　vecx2
p5 : [IN] 変数または、数値　：　vecy2 
p6 : [IN] 変数または、数値　：　vecz2
p7 : [OUT] 変数　：　ret

%inst
内積を計算します。
E3DDotと違って、E3DDot2は、与えたベクトルを正規化しません。





→引数
1. [IN] 変数または、数値　：　vecx1
2. [IN] 変数または、数値　：　vecy1 
3. [IN] 変数または、数値　：　vecz1
　　実数。

4. [IN] 変数または、数値　：　vecx2
5. [IN] 変数または、数値　：　vecy2 
6. [IN] 変数または、数値　：　vecz2
　　実数。

7. [OUT] 変数　：　ret
　　内積の結果が代入される。
　　実数型の変数。



バージョン : ver3.0.2.0で追加

%index
E3DChkConfParticle
パーティクルとモデルデータのあたり判定をします。
%group
Easy3D For HSP3 : 当たり判定

%prm
p1,p2,p3,p4
p1 : [IN] 変数または、数値　：　ptclid
p2 : [IN] 変数または、数値　：　hsid
p3 : [IN] 変数または、数値　：　rate
p4 : [OUT] 変数　：　confflag

%inst
パーティクルとモデルデータのあたり判定をします。

境界球を使用した判定を行います。

モデルデータ側の境界球の半径が大きすぎるときは、
rate引数に１より小さい値を指定して調整してください。





→引数
1. [IN] 変数または、数値　：　ptclid
　　パーティクルを識別するid

2. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

3. [IN] 変数または、数値　：　rate
　　モデルデータの境界球の半径に掛け算して
　　判定します。
　　１より小さい値を指定すれば、
　　判定の感度が落ちます。
　　実数。

4. [OUT] 変数　：　confflag
　　パーティクルとモデルデータが
　　ぶつかっているときは１が
　　ぶつかっていないときは０が代入されます。





バージョン : ver3.0.2.3で追加

%index
E3DLoadSigFileAsGround
sigファイルを地面として読み込んで、hsidを得る。
%group
Easy3D For HSP3 : 地面

%prm
p1,p2,p3,p4
p1 : [IN] 文字列または、文字列の変数　：　fname
p2 : [OUT] 変数　：　hsid
p3 : [IN] 変数または、数値　：　adjustuvflag
p4 : [IN] 変数または、数値　：　mult

%inst
sigファイルを地面として読み込んで、hsidを得る。

sigファイルの読み込み速度は、mqoファイルの読み込みよりも、
だいぶ速くなります。




→引数
1. [IN] 文字列または、文字列の変数　：　fname
　　*.sig のパス文字列。

2. [OUT] 変数　：　hsid
　　読み込んだ形状データを識別するhsid

3. [IN] 変数または、数値　：　adjustuvflag
　　ＵＶ値を正規化するかどうかのフラグ
　　正規化する場合は１を指定
　　しない場合は０を指定

4. [IN] 変数または、数値　：　mult
　　読み込み倍率を指定してください。
　　等倍は１．０。
　　実数。



バージョン : ver3.0.2.5で追加

%index
E3DLoadSigFileAsGroundFromBuf
メモリから地面データのロードを行います。
%group
Easy3D For HSP3 : 地面

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 文字列または、文字列の変数　：　resdir
p2 : [IN] 変数　：　buf
p3 : [IN] 変数または、数値　：　bufleng
p4 : [OUT] 変数　：　hsid
p5 : [IN] 変数または、数値　：　adjustuvflag
p6 : [IN] 変数または、数値　：　mult

%inst
メモリから地面データのロードを行います。
メモリ内には、sigファイルと同じフォーマットが
入っているとみなして、処理します。

テクスチャファイルは、通常読込と同様に、
ファイルから行います。

resdirには、テクスチャの存在するフォルダのパスを指定してください。
html{
<strong>最後に、&quot;\\&quot;を付けるのを忘れないでください。</strong>
}html

例えば、
resdir = &quot;C:\\hsp\\Meida\\&quot;
や
resdir = dir_cur+ &quot;\\&quot;
などのように指定してください。





→引数
1. [IN] 文字列または、文字列の変数　：　resdir
　　テクスチャーのあるフォルダ のパス文字列。
　　最後に、&quot;\\&quot;が必要。

2. [IN] 変数　：　buf
　　バッファの変数

3. [IN] 変数または、数値　：　bufleng
　　バッファの中のデータの長さ

4. [OUT] 変数　：　hsid
　　読み込んだ形状データを識別するhsid

5. [IN] 変数または、数値　：　adjustuvflag
　　ＵＶ値を正規化するかどうかのフラグ
　　正規化する場合は１を指定
　　しない場合は０を指定

6. [IN] 変数または、数値　：　mult
　　読み込み倍率を指定してください。
　　等倍は１．０。
　　実数。



バージョン : ver3.0.2.5で追加

%index
E3DGetCenterPos
パーツの中心のグローバル座標を取得します。
%group
Easy3D For HSP3 : モデル位置

%prm
p1,p2,p3,p4,p5
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [OUT] 変数　：　posx
p4 : [OUT] 変数　：　posy 
p5 : [OUT] 変数　：　posz

%inst
パーツの中心のグローバル座標を取得します。
パーツの中心の座標は、E3DChkInViewで計算されます。





→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 数値または、変数　：　partno
　　取得したいパーツの番号を指定します。
　　E3DGetPartNoByNameで取得した番号を
　　渡してください。

　　-1を指定すると、モデル全体の中心座標が
　　取得できます。

3. [OUT] 変数　：　posx
4. [OUT] 変数　：　posy 
5. [OUT] 変数　：　posz
　　実数型の変数。
　　中心の座標が代入されます。



バージョン : ver3.0.2.7で追加

%index
E3DGetFaceNum
指定した表示オブジェクトの面の総数を取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [OUT] 変数　：　facenum

%inst
指定した表示オブジェクトの面の総数を取得します。






→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 数値または、変数　：　partno
　　取得したいパーツの番号を指定します。
　　E3DGetPartNoByNameで取得した番号を
　　渡してください。

3. [OUT] 変数　：　facenum
　　面の総数が代入されます。



バージョン : ver3.0.3.0で追加

%index
E3DGetFaceNormal
指定した表示オブジェクトの面の法線を取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　faceno
p4 : [OUT] 変数　：　nx
p5 : [OUT] 変数　：　ny 
p6 : [OUT] 変数　：　nz

%inst
指定した表示オブジェクトの面の法線を取得します。

E3DGetFaceNumで取得した面の総数をfacenumとしたとき、
faceno引数には、０からfacenum - 1までの値を
指定してください。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 数値または、変数　：　partno
　　取得したいパーツの番号を指定します。
　　E3DGetPartNoByNameで取得した番号を
　　渡してください。

3. [IN] 数値または、変数　：　faceno
　　面の番号を指定します。

4. [OUT] 変数　：　nx
5. [OUT] 変数　：　ny 
6. [OUT] 変数　：　nz
　　実数型の変数。
　　法線のベクトルが代入されます。



バージョン : ver3.0.3.0で追加

%index
E3DGetReferenceTime
ステレオサウンドのリファレンスタイムを取得します。
%group
Easy3D For HSP3 : サウンド

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　soundid
p2 : [OUT] 変数　：　mtime
p3 : [OUT] 変数　：　reftime

%inst
ステレオサウンドのリファレンスタイムを取得します。

この命令は、３Dサウンドには使えません。
ステレオサウンドのwavに使用できます。

リファレンスタイムは、１秒あたり約10,000,000の値です。

この時間は音データを読み込んだ直後から増加していきます。
ですので、再生してからの時間を測りたいときは、
再生直後のリファレンスタイムを取得しておいて、
現在のリファレンスタイムから引き算して計算してください。





→引数
1. [IN] 変数または、数値　：　soundid
　　音データを識別するIDを指定してください。

2. [OUT] 変数　：　mtime
　　整数型の変数
　　ミュージックタイムが代入されます。
　　４分音符あたり768の値です。
　　MIDI用の時間です。

3. [OUT] 変数　：　reftime
　　実数型の変数
　　リファレンスタイムが代入されます。
　　１秒あたり約10,000,000の値です。
　　wav用の時間です。




バージョン : ver3.0.3.0で追加

%index
E3DCreateEmptyMotion
姿勢情報の入っていない空のモーションを作成します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 文字列または、文字列の変数　：　motname
p3 : [IN] 変数または、数値　：　frameleng
p4 : [OUT] 変数　：　mk

%inst
姿勢情報の入っていない空のモーションを作成します。


→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 文字列または、文字列の変数　：　motname
　　モーションの名前の文字列。

3. [IN] 変数または、数値　：　frameleng
　　作成するモーションの長さ。フレーム長。

4. [OUT] 変数　：　mk
　　作成したモーションを識別する番号




バージョン : ver3.0.3.5で追加

%index
E3DSetTextureMinMagFilter
テクスチャーを拡大縮小表示する際のフィルターを指定します。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1,p2,p3,p4,p5
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　partno
p3 : [IN] 変数または、数値　：　minfilter
p4 : [IN] 変数または、数値　：　magfilter
p5 : [IN] 変数または、数値　：　scid

%inst
テクスチャーを拡大縮小表示する際のフィルターを指定します。

３Dモデル、背景、スプライト、ビルボードに指定できます。

minfilter引数には縮小する際のフィルターを指定し、
magfilter引数には拡大する際のフィルターを指定します。

フィルターの指定にはe3dhsp3.asで定義されている以下の２つの定数を使います。

D3DTEXF_POINT
最近点フィルタ。
目的のピクセル値に最も近い座標のテクセルを使います。
テクスチャがぼやけるのが嫌な場合などに使います。

D3DTEXF_LINEAR
双線形補間フィルタ。
目的のピクセルを取り囲む 2 x 2 領域のテクセルの重み付けした平均を使います。
なめらかな表示をしたいときに使います。





→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

　　E3DCreateBGで作成した背景に対して処理を行いたい場合は０を指定します。

　　ビルボードに対して処理を行いたい場合は-1を指定します。

　　スプライトに対して処理を行いたい場合は-2を指定します。

2. [IN] 変数または、数値　：　partno
　　形状データを識別するidを指定します。

　　背景の場合は０を指定します。

　　ビルボードの場合はビルボードIDを指定します。

　　スプライトの場合はスプライトIDを指定します。


3. [IN] 変数または、数値　：　minfilter
　　縮小フィルター

4. [IN] 変数または、数値　：　magfilter
　　拡大フィルター

5. [IN] 変数または、数値　：　scid
　　スワップチェインID。
　　この引数は、背景の指定の場合のみ意味を持ちます。




バージョン : ver3.0.3.7で追加

%index
E3DGetMotionName
読み込み済みのモーションの名前を取得します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　motid
p3 : [OUT] 文字列型の変数　：　motname

%inst
読み込み済みのモーションの名前を取得します。

motname引数には
sdim motname, 256
で確保したメモリを指定してください。





→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　motid
　　モーションを識別するid

3. [OUT] 文字列型の変数　：　motname
　　モーションの名前が代入されます。
　　sdim motname, 256
　　で確保したメモリを指定してください。




バージョン : ver3.0.3.8で追加

%index
E3DSetMotionName
モーションに名前を設定します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　motid
p3 : [IN] 文字列または、文字列変数　：　motname

%inst
モーションに名前を設定します。

２５５文字以下（２５５バイト以下）の名前を設定してください。



→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　motid
　　モーションを識別するid

3. [IN] 文字列または、文字列変数　：　motname
　　モーションの名前を指定します。
　　名前の長さは２５５文字（２５５バイト）までです。



バージョン : ver3.0.3.8で追加

%index
 E3DGetMaterialNoByName
マテリアル名からマテリアル番号を取得します。
%group
Easy3D For HSP3 : マテリアル

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 文字列または、文字列変数　：　motname
p3 : [OUT] 変数　：　matno

%inst
マテリアル名からマテリアル番号を取得します。

マテリアル名はRokDeBone2のメインメニューの
「面マテリアル」メニューを押したときに現れるダイアログで
確認できます。

ver4.0.0.1以降のRokDeBone2でmqoからデータを読み込んでいる場合には、マテリアル名はメタセコイアの材質名と同じです。

存在しないマテリアル名を渡した場合は、
マテリアル番号には-3が返されます。





→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 文字列または、文字列変数　：　motname
　　マテリアルの名前を指定します。
　　名前の長さは２５５文字（２５５バイト）までです。

3. [OUT] 変数　：　matno
　　マテリアルの番号が代入されます。
　　存在しない名前を渡した場合は-3が代入されます。




バージョン : ver4.0.0.1で追加

%index
E3DGetMaterialAlpha
マテリアルの透明度を取得します。
%group
Easy3D For HSP3 : マテリアル

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　matno
p3 : [OUT] 変数　：　alpha

%inst
マテリアルの透明度を取得します。

透明度は0.0から1.0までの実数です。





→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　matno
　　マテリアル番号。
　　E3DGetMaterialNoByNameで取得した番号、
　　もしくは
　　RokDeBone2の「面マテリアル」メニューで
　　表示されている「マテリアル番号」

3. [OUT] 変数　：　alpha
　　透明度が代入されます。
　　実数型の変数。



バージョン : ver4.0.0.1で追加

%index
E3DGetMaterialDiffuse
マテリアルの拡散光（diffuse）を取得します。
%group
Easy3D For HSP3 : マテリアル

%prm
p1,p2,p3,p4,p5
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　matno
p3 : [OUT] 変数　：　R
p4 : [OUT] 変数　：　G
p5 : [OUT] 変数　：　B

%inst
マテリアルの拡散光（diffuse）を取得します。

R, G, Bはそれぞれ赤、緑、青の強さを０から２５５で表したものです。






→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　matno
　　マテリアル番号。
　　E3DGetMaterialNoByNameで取得した番号、
　　もしくは
　　RokDeBone2の「面マテリアル」メニューで
　　表示されている「マテリアル番号」

3. [OUT] 変数　：　R
4. [OUT] 変数　：　G
5. [OUT] 変数　：　B
　　diffuseのRGBが代入されます。



バージョン : ver4.0.0.1で追加

%index
E3DGetMaterialSpecular
マテリアルの反射光（specular）を取得します。
%group
Easy3D For HSP3 : マテリアル

%prm
p1,p2,p3,p4,p5
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　matno
p3 : [OUT] 変数　：　R
p4 : [OUT] 変数　：　G
p5 : [OUT] 変数　：　B

%inst
マテリアルの反射光（specular）を取得します。
R, G, Bはそれぞれ赤、緑、青の強さを０から２５５で表したものです



→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　matno
　　マテリアル番号。
　　E3DGetMaterialNoByNameで取得した番号、
　　もしくは
　　RokDeBone2の「面マテリアル」メニューで
　　表示されている「マテリアル番号」

3. [OUT] 変数　：　R
4. [OUT] 変数　：　G
5. [OUT] 変数　：　B
　　specularのRGBが代入されます。



バージョン : ver4.0.0.1で追加

%index
E3DGetMaterialAmbient
マテリアルの周囲光（ambient）を取得します。
%group
Easy3D For HSP3 : マテリアル

%prm
p1,p2,p3,p4,p5
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　matno
p3 : [OUT] 変数　：　R
p4 : [OUT] 変数　：　G
p5 : [OUT] 変数　：　B

%inst
マテリアルの周囲光（ambient）を取得します。
R, G, Bはそれぞれ赤、緑、青の強さを０から２５５で表したものです



→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　matno
　　マテリアル番号。
　　E3DGetMaterialNoByNameで取得した番号、
　　もしくは
　　RokDeBone2の「面マテリアル」メニューで
　　表示されている「マテリアル番号」

3. [OUT] 変数　：　R
4. [OUT] 変数　：　G
5. [OUT] 変数　：　B
　　ambientのRGBが代入されます。



バージョン : ver4.0.0.1で追加

%index
E3DGetMaterialEmissive
マテリアルの自己照明（emissiver）を取得します。
%group
Easy3D For HSP3 : マテリアル

%prm
p1,p2,p3,p4,p5
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　matno
p3 : [OUT] 変数　：　R
p4 : [OUT] 変数　：　G
p5 : [OUT] 変数　：　B

%inst
マテリアルの自己照明（emissiver）を取得します。

R, G, Bはそれぞれ赤、緑、青の強さを０から２５５で表したものです



→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　matno
　　マテリアル番号。
　　E3DGetMaterialNoByNameで取得した番号、
　　もしくは
　　RokDeBone2の「面マテリアル」メニューで
　　表示されている「マテリアル番号」

3. [OUT] 変数　：　R
4. [OUT] 変数　：　G
5. [OUT] 変数　：　B
　　emissiveのRGBが代入されます。



バージョン : ver4.0.0.1で追加

%index
E3DGetMaterialPower
マテリアルの反射の強さ(power)を取得します。
%group
Easy3D For HSP3 : マテリアル

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　matno
p3 : [OUT] 変数　：　power

%inst
マテリアルの反射の強さ(power)を取得します。

powerは実数です。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　matno
　　マテリアル番号。
　　E3DGetMaterialNoByNameで取得した番号、
　　もしくは
　　RokDeBone2の「面マテリアル」メニューで
　　表示されている「マテリアル番号」

3. [OUT] 変数　：　power
　　powerが代入されます。
　　実数型の変数。



バージョン : ver4.0.0.1で追加

%index
E3DGetMaterialBlendingMode
マテリアルの半透明モードを取得します。
%group
Easy3D For HSP3 : マテリアル

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　matno
p3 : [OUT] 変数　：　mode

%inst
マテリアルの半透明モードを取得します。

modeの値の意味は
０のとき
頂点アルファ値による半透明モードです。

１のとき　
アッドモードです。

２のとき
頂点アルファを考慮したアッドモードです。





→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　matno
　　マテリアル番号。
　　E3DGetMaterialNoByNameで取得した番号、
　　もしくは
　　RokDeBone2の「面マテリアル」メニューで
　　表示されている「マテリアル番号」

3. [OUT] 変数　：　mode
　　半透明モードが代入されます。



バージョン : ver4.0.0.1で追加

%index
E3DSetMaterialAlpha
マテリアルの透明度を設定します。
%group
Easy3D For HSP3 : マテリアル

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　matno
p3 : [IN] 変数または、数値　：　alpha

%inst
マテリアルの透明度を設定します。

透明度は0.0から1.0の実数で指定します。

マテリアルの変更により
表示オブジェクトの対応する部分の表示が面単位で変化します。






→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　matno
　　マテリアル番号。
　　E3DGetMaterialNoByNameで取得した番号、
　　もしくは
　　RokDeBone2の「面マテリアル」メニューで
　　表示されている「マテリアル番号」

3. [IN] 変数または、数値　：　alpha
　　透明度。
　　実数。



バージョン : ver4.0.0.1で追加

%index
E3DSetMaterialDiffuse
マテリアルの拡散光(diffuse)を設定します。
%group
Easy3D For HSP3 : マテリアル

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　matno
p3 : [IN] 数値または、変数　：　setflag
p4 : [IN] 数値または、変数　：　R
p5 : [IN] 数値または、変数　：　G
p6 : [IN] 数値または、変数　：　B

%inst
マテリアルの拡散光(diffuse)を設定します。

RGBは０から２５５の値で指定します。

マテリアルの変更により
表示オブジェクトの対応する部分の表示が面単位で変化します。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　matno
　　マテリアル番号。
　　E3DGetMaterialNoByNameで取得した番号、
　　もしくは
　　RokDeBone2の「面マテリアル」メニューで
　　表示されている「マテリアル番号」

3. [IN] 数値または、変数　：　setflag
　　setflagが０のときは、
　　パーツの色を（Ｒ，Ｇ，Ｂ）にセットします。

　　setflagが１のときは、
　　パーツの色に（R/255, G/255, B/255）を乗算します。

　　setflagが２のときは、
　　パーツの色に（Ｒ，Ｇ，Ｂ）を足し算します。

　　setflagが３のときは、
　　パーツの色から（Ｒ，Ｇ，Ｂ）を減算します。


4. [IN] 数値または、変数　：　R
5. [IN] 数値または、変数　：　G
6. [IN] 数値または、変数　：　B
　　指定したい色を（Ｒ，Ｇ，Ｂ）で指定します。
　　０から２５５までの値を指定してください。

　　setflagに乗算を指定した場合は、
　　各成分に、R/255, G/255, B/255を乗算します。




バージョン : ver4.0.0.1で追加

%index
E3DSetMaterialSpecular
マテリアルの反射光(specular)を設定します。
%group
Easy3D For HSP3 : マテリアル

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　matno
p3 : [IN] 数値または、変数　：　setflag
p4 : [IN] 数値または、変数　：　R
p5 : [IN] 数値または、変数　：　G
p6 : [IN] 数値または、変数　：　B

%inst
マテリアルの反射光(specular)を設定します。

RGBは０から２５５の値で指定します。

マテリアルの変更により
表示オブジェクトの対応する部分の表示が面単位で変化します。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　matno
　　マテリアル番号。
　　E3DGetMaterialNoByNameで取得した番号、
　　もしくは
　　RokDeBone2の「面マテリアル」メニューで
　　表示されている「マテリアル番号」

3. [IN] 数値または、変数　：　setflag
　　setflagが０のときは、
　　パーツの色を（Ｒ，Ｇ，Ｂ）にセットします。

　　setflagが１のときは、
　　パーツの色に（R/255, G/255, B/255）を乗算します。

　　setflagが２のときは、
　　パーツの色に（Ｒ，Ｇ，Ｂ）を足し算します。

　　setflagが３のときは、
　　パーツの色から（Ｒ，Ｇ，Ｂ）を減算します。


4. [IN] 数値または、変数　：　R
5. [IN] 数値または、変数　：　G
6. [IN] 数値または、変数　：　B
　　指定したい色を（Ｒ，Ｇ，Ｂ）で指定します。
　　０から２５５までの値を指定してください。

　　setflagに乗算を指定した場合は、
　　各成分に、R/255, G/255, B/255を乗算します。



バージョン : ver4.0.0.1で追加

%index
E3DSetMaterialAmbient
マテリアルの周囲光(ambient)を設定します。
%group
Easy3D For HSP3 : マテリアル

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　matno
p3 : [IN] 数値または、変数　：　setflag
p4 : [IN] 数値または、変数　：　R
p5 : [IN] 数値または、変数　：　G
p6 : [IN] 数値または、変数　：　B

%inst
マテリアルの周囲光(ambient)を設定します。

RGBは０から２５５の値で指定します。

マテリアルの変更により
表示オブジェクトの対応する部分の表示が面単位で変化します。



→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　matno
　　マテリアル番号。
　　E3DGetMaterialNoByNameで取得した番号、
　　もしくは
　　RokDeBone2の「面マテリアル」メニューで
　　表示されている「マテリアル番号」

3. [IN] 数値または、変数　：　setflag
　　setflagが０のときは、
　　パーツの色を（Ｒ，Ｇ，Ｂ）にセットします。

　　setflagが１のときは、
　　パーツの色に（R/255, G/255, B/255）を乗算します。

　　setflagが２のときは、
　　パーツの色に（Ｒ，Ｇ，Ｂ）を足し算します。

　　setflagが３のときは、
　　パーツの色から（Ｒ，Ｇ，Ｂ）を減算します。


4. [IN] 数値または、変数　：　R
5. [IN] 数値または、変数　：　G
6. [IN] 数値または、変数　：　B
　　指定したい色を（Ｒ，Ｇ，Ｂ）で指定します。
　　０から２５５までの値を指定してください。

　　setflagに乗算を指定した場合は、
　　各成分に、R/255, G/255, B/255を乗算します。



バージョン : ver4.0.0.1で追加

%index
E3DSetMaterialEmissive
マテリアルの自己照明(emissive)を設定します。
%group
Easy3D For HSP3 : マテリアル

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　matno
p3 : [IN] 数値または、変数　：　setflag
p4 : [IN] 数値または、変数　：　R
p5 : [IN] 数値または、変数　：　G
p6 : [IN] 数値または、変数　：　B

%inst
マテリアルの自己照明(emissive)を設定します。

RGBは０から２５５の値で指定します。

マテリアルの変更により
表示オブジェクトの対応する部分の表示が面単位で変化します。



→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　matno
　　マテリアル番号。
　　E3DGetMaterialNoByNameで取得した番号、
　　もしくは
　　RokDeBone2の「面マテリアル」メニューで
　　表示されている「マテリアル番号」

3. [IN] 数値または、変数　：　setflag
　　setflagが０のときは、
　　パーツの色を（Ｒ，Ｇ，Ｂ）にセットします。

　　setflagが１のときは、
　　パーツの色に（R/255, G/255, B/255）を乗算します。

　　setflagが２のときは、
　　パーツの色に（Ｒ，Ｇ，Ｂ）を足し算します。

　　setflagが３のときは、
　　パーツの色から（Ｒ，Ｇ，Ｂ）を減算します。


4. [IN] 数値または、変数　：　R
5. [IN] 数値または、変数　：　G
6. [IN] 数値または、変数　：　B
　　指定したい色を（Ｒ，Ｇ，Ｂ）で指定します。
　　０から２５５までの値を指定してください。

　　setflagに乗算を指定した場合は、
　　各成分に、R/255, G/255, B/255を乗算します。



バージョン : ver4.0.0.1で追加

%index
E3DSetMaterialPower
マテリアルの反射の強さ(power)を設定します。
%group
Easy3D For HSP3 : マテリアル

%prm
p1,p2,p3,p4
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　matno
p3 : [IN] 数値または、変数　：　setflag
p4 : [IN] 数値または、変数　：　power

%inst
マテリアルの反射の強さ(power)を設定します。

実数で指定します。

マテリアルの変更により
表示オブジェクトの対応する部分の表示が面単位で変化します。



→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　matno
　　マテリアル番号。
　　E3DGetMaterialNoByNameで取得した番号、
　　もしくは
　　RokDeBone2の「面マテリアル」メニューで
　　表示されている「マテリアル番号」

3. [IN] 数値または、変数　：　setflag
　　setflagが０のときは、
　　powerをそのままセットします。

　　setflagが１のときは、
　　現在のマテリアルにpowerを乗算します。

　　setflagが２のときは、
　　現在のマテリアルにpowerを足し算します。

　　setflagが３のときは、
　　現在のマテリアルからpowerを減算します。


4. [IN] 数値または、変数　：　power
　　反射の強さを指定します。
　　実数。



バージョン : ver4.0.0.1で追加

%index
E3DSetMaterialBlendingMode
マテリアルの半透明モードを設定します。
%group
Easy3D For HSP3 : マテリアル

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　matno
p3 : [IN] 数値または、変数　：　blendmode

%inst
マテリアルの半透明モードを設定します。

マテリアルの変更により
表示オブジェクトの対応する部分の表示が面単位で変化します。

blendmode 0, 1, 2はアルファテストの設定も変更します。
アルファテストの設定を変更したくない場合は
blendmode 100, 101, 102をお使いください。

アルファテストを設定したい場合は
E3DSetMaterialAlphaTestをご使用ください。



→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　matno
　　マテリアル番号。
　　E3DGetMaterialNoByNameで取得した番号、
　　もしくは
　　RokDeBone2の「面マテリアル」メニューで
　　表示されている「マテリアル番号」

3. [IN] 数値または、変数　：　blendmode
　　０を指定すると
　　頂点アルファ値による半透明モードになります。
　　アルファテストはオフになります。

　　１を指定すると　
　　アッドモードになります。
　　アルファテストはオンになり８より小さいアルファのときに描画されなくなります（Zバッファにも）。

　　２を指定すると、
　　頂点アルファを考慮したアッドモードになります。
　　アルファテストはオフになります。


　　１００を指定すると
　　頂点アルファ値による半透明モードになります。
　　アルファテストは変更しません。

　　１０１を指定すると　
　　アッドモードになります。
　　アルファテストは変更しません。

　　１０２を指定すると、
　　頂点アルファを考慮したアッドモードになります。
　　アルファテストは変更しません。





バージョン : ver4.0.0.1で追加<BR>
      ver5.0.2.9で拡張

%index
E3DGetTextureFromMaterial
マテリアルに設定されているテクスチャを取得します。
%group
Easy3D For HSP3 : マテリアル

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　matno
p3 : [OUT] 数値　：　texid

%inst
マテリアルに設定されているテクスチャを取得します。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　matno
　　マテリアル番号。
　　E3DGetMaterialNoByNameで取得した番号、
　　もしくは
　　RokDeBone2の「面マテリアル」メニューで
　　表示されている「マテリアル番号」

3. [OUT] 数値　：　texid
　　テクスチャのIDが代入されます。
　　エラーのときは-1が代入されます。




バージョン : ver4.0.0.1で追加

%index
E3DSetTextureToMaterial
マテリアルにテクスチャを設定します。
%group
Easy3D For HSP3 : マテリアル

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　matno
p3 : [IN] 数値または、変数　：　texid

%inst
マテリアルにテクスチャを設定します。

マテリアルの変更により
表示オブジェクトの対応する部分の表示が面単位で変化します。


テクスチャをセットしても、
ＵＶ座標は自動的に生成されません。
動的にテクスチャを設定する場合は、
ＵＶ座標もE3DSetUVで設定するか、
もしくは、
あらかじめ、モデルに仮のテクスチャを貼っておいてＵＶ設定しておく必要があります。


具体的な使用例は、
html{
<strong>e3dhsp3_TextureChange.hsp</strong>
}html
に書きましたので、ご覧ください。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　matno
　　マテリアル番号。
　　E3DGetMaterialNoByNameで取得した番号、
　　もしくは
　　RokDeBone2の「面マテリアル」メニューで
　　表示されている「マテリアル番号」

3. [IN] 数値または、変数　：　texid
　　テクスチャのIDを指定してください。



バージョン : ver4.0.0.1で追加

%index
E3DGetMaterialNo
面のマテリアル番号を取得します。
%group
Easy3D For HSP3 : マテリアル

%prm
p1,p2,p3,p4
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　faceno
p4 : [OUT] 変数　：　matno

%inst
面のマテリアル番号を取得します。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 数値または、変数　：　partno
　　パーツを識別する番号を指定してください。

3. [IN] 数値または、変数　：　faceno
　　面を識別する番号を指定してください。

4. [OUT] 変数　：　matno
　　マテリアルの番号が代入されます。



バージョン : ver4.0.0.6で追加

%index
E3DSetMotionKindML
ボーンごとに再生するモーションの番号を設定します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　motid
p3 : [IN] 配列変数　：　list
p4 : [IN] 配列変数　：　notlist

%inst
ボーンごとに再生するモーションの番号を設定します。

list, notlistはボーンの番号をセットした配列
listに指定した番号とその子供全部に対して再帰的に処理を行う。
notlistには除外したいボーンの内、一番親の番号を記述する。
notlistに記述した番号は、listに記述した番号よりも優先される。
list, notlistには複数の番号を指定できるが、一番最後の要素には０をセットしなければならない。
listの先頭要素に限り-1を指定できる。
-1指定はすべてのボーンに対する処理を表す。

左肩のボーン番号を２、左ひじの番号を３、左手の番号を４、
右肩のボーン番号を１２、右ひじの番号を１３、右手の番号を１４、
手に持っている武器のボーン番号を２２として
武器を除く手の部分にモーションを設定したい場合は、

list(0) = 2
list(1) = 12
list(2) = 0

notlist(0) = 22
notlist(1) = 0

のようにlist, notlistの配列に値をセットして命令を呼び出す。
２を指定すれば２の子供全部に処理が行われるので３，４を指定する必要はない。
同様に１２を指定すれば１２の子供全部に処理が行われるので１３，１４を指定する必要はない。
リストの最後には必ず0を指定する。

具体的な使用例は
html{
<strong>e3dhsp3_MultiLayerMotion.hspに書きましたのでご覧ください。</strong>
}html




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　motid
　　モーションを識別するid

3. [IN] 配列変数　：　list
4. [IN] 配列変数　：　notlist
　　設定したいボーン番号と
　　設定したくないボーン番号をセットした配列。
　　詳しくは前記をご覧ください。


バージョン : ver4.0.0.6で追加

%index
E3DSetMotionFrameNoML
ボーンごとに再生するモーションの番号とフレーム番号を設定します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4,p5
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　motid
p3 : [IN] 変数または、数値　：　frameno
p4 : [IN] 配列変数　：　list
p5 : [IN] 配列変数　：　notlist

%inst
ボーンごとに再生するモーションの番号とフレーム番号を設定します。


list, notlistはボーンの番号をセットした配列
listに指定した番号とその子供全部に対して再帰的に処理を行う。
notlistには除外したいボーンの内、一番親の番号を記述する。
notlistに記述した番号は、listに記述した番号よりも優先される。
list, notlistには複数の番号を指定できるが、一番最後の要素には０をセットしなければならない。
listの先頭要素に限り-1を指定できる。
-1指定はすべてのボーンに対する処理を表す。

左肩のボーン番号を２、左ひじの番号を３、左手の番号を４、
右肩のボーン番号を１２、右ひじの番号を１３、右手の番号を１４、
手に持っている武器のボーン番号を２２として
武器を除く手の部分にモーションを設定したい場合は、

list(0) = 2
list(1) = 12
list(2) = 0

notlist(0) = 22
notlist(1) = 0

のようにlist, notlistの配列に値をセットして命令を呼び出す。
２を指定すれば２の子供全部に処理が行われるので３，４を指定する必要はない。
同様に１２を指定すれば１２の子供全部に処理が行われるので１３，１４を指定する必要はない。
リストの最後には必ず0を指定する。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　motid
　　モーションを識別するid

3. [IN] 変数または、数値　：　frameno
　　フレーム番号。


4. [IN] 配列変数　：　list
5. [IN] 配列変数　：　notlist
　　設定したいボーン番号と
　　設定したくないボーン番号をセットした配列。
　　詳しくは前記をご覧ください。


バージョン : ver4.0.0.6で追加

%index
E3DSetNextMotionFrameNoML
現在再生しているモーションの後につづけて再生するモーションをボーンごとに設定します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　srcmotid
p3 : [IN] 数値または、変数　：　nextmotid
p4 : [IN] 数値または、変数　：　nextframeno
p5 : [IN] 数値または、変数　：　befframeno
p6 : [IN] 配列変数　：　list
p7 : [IN] 配列変数　：　notlist

%inst
現在再生しているモーションの後につづけて再生するモーションをボーンごとに設定します。


list, notlistはボーンの番号をセットした配列
listに指定した番号とその子供全部に対して再帰的に処理を行う。
notlistには除外したいボーンの内、一番親の番号を記述する。
notlistに記述した番号は、listに記述した番号よりも優先される。
list, notlistには複数の番号を指定できるが、一番最後の要素には０をセットしなければならない。
listの先頭要素に限り-1を指定できる。
-1指定はすべてのボーンに対する処理を表す。

左肩のボーン番号を２、左ひじの番号を３、左手の番号を４、
右肩のボーン番号を１２、右ひじの番号を１３、右手の番号を１４、
手に持っている武器のボーン番号を２２として
武器を除く手の部分にモーションを設定したい場合は、

list(0) = 2
list(1) = 12
list(2) = 0

notlist(0) = 22
notlist(1) = 0

のようにlist, notlistの配列に値をセットして命令を呼び出す。
２を指定すれば２の子供全部に処理が行われるので３，４を指定する必要はない。
同様に１２を指定すれば１２の子供全部に処理が行われるので１３，１４を指定する必要はない。
リストの最後には必ず0を指定する。





→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　srcmotid
3. [IN] 数値または、変数　：　nextmotid
4. [IN] 数値または、変数　：　nextframeno
5. [IN] 数値または、変数　：　befframeno
　　srcmotidのモーションが、befframeフレーム番号に達した後、nextmotidのモーションの、nextframenoのフレーム番号に、ジャンプするように設定されます。
befframeに-1をセットした場合は、srcmotidが最終フレームに達した後にジャンプします。


6. [IN] 配列変数　：　list
7. [IN] 配列変数　：　notlist
　　設定したいボーン番号と
　　設定したくないボーン番号をセットした配列。
　　詳しくは前記をご覧ください。




バージョン : ver4.0.0.6で追加

%index
E3DSetMOAEventNoML
モーションアクセラレータのイベント番号をボーンごとに設定します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　eventno
p3 : [IN] 配列変数　：　list
p4 : [IN] 配列変数　：　notlist

%inst
モーションアクセラレータのイベント番号をボーンごとに設定します。

この命令を必要な分だけ呼んだ後に１回E3DSetNewPoseMLを呼ぶ必要があります。
list, notlistはボーンの番号をセットした配列
listに指定した番号とその子供全部に対して再帰的に処理を行う。
notlistには除外したいボーンの内、一番親の番号を記述する。
notlistに記述した番号は、listに記述した番号よりも優先される。
list, notlistには複数の番号を指定できるが、一番最後の要素には０をセットしなければならない。
listの先頭要素に限り-1を指定できる。
-1指定はすべてのボーンに対する処理を表す。

左肩のボーン番号を２、左ひじの番号を３、左手の番号を４、
右肩のボーン番号を１２、右ひじの番号を１３、右手の番号を１４、
手に持っている武器のボーン番号を２２として
武器を除く手の部分にモーションを設定したい場合は、

list(0) = 2
list(1) = 12
list(2) = 0

notlist(0) = 22
notlist(1) = 0

のようにlist, notlistの配列に値をセットして命令を呼び出す。
２を指定すれば２の子供全部に処理が行われるので３，４を指定する必要はない。
同様に１２を指定すれば１２の子供全部に処理が行われるので１３，１４を指定する必要はない。
リストの最後には必ず0を指定する。


具体的な使用例は
html{
<strong>e3dhsp3_MultiLayerMotion_MOA.hsp</strong>
}html
に書きましたのでご覧ください。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　eventno
　　モーションの変化のトリガーとなるイベント番号。

3. [IN] 配列変数　：　list
4. [IN] 配列変数　：　notlist
　　設定したいボーン番号と
　　設定したくないボーン番号をセットした配列。
　　詳しくは前記をご覧ください。



バージョン : ver4.0.0.6で追加

%index
E3DGetMotionFrameNoML
指定したボーンのモーション番号とフレーム番号を取得します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　boneno
p3 : [OUT] 変数　：　motid
p4 : [OUT] 変数　：　frameno

%inst
指定したボーンのモーション番号とフレーム番号を取得します。


→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　boneno
　　ボーンを識別するＩＤ

3. [OUT] 変数　：　motid
　　モーション番号が代入されます。

4. [OUT] 変数　：　frameno
　　フレーム番号が代入されます。




バージョン : ver4.0.0.6で追加

%index
E3DGetNextMotionFrameNoML
E3DSetNextMotionFrameNoMLで設定した情報をボーンごとに取得します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　boneno
p3 : [IN] 数値または、変数　：　motid
p4 : [OUT] 変数　：　nextmotid
p5 : [OUT] 変数　：　nextframeno

%inst
E3DSetNextMotionFrameNoMLで設定した情報をボーンごとに取得します。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　boneno
　　ボーンを識別するＩＤ

3. [IN] 数値または、変数　：　motid
　　モーションを識別するＩＤ

4. [OUT] 変数　：　nextmotid
　　ジャンプ先のモーション番号が代入されます。

5. [OUT] 変数　：　nextframeno
　　ジャンプ先のフレーム番号が代入されます。



バージョン : ver4.0.0.6で追加

%index
E3DSetNewPoseML
マルチレイヤーモーションの仕様に従って、新しい姿勢情報をそれぞれのボーンにセットします。
%group
Easy3D For HSP3 : モーション

%prm
p1
p1 : [IN] 数値または、変数　：　hsid

%inst
マルチレイヤーモーションの仕様に従って、新しい姿勢情報をそれぞれのボーンにセットします。

具体的な使用例は
html{
<strong>e3dhsp3_MultiLayerMotion.hsp</strong>
}htmlと
html{
<strong>e3dhsp3_MultiLayerMotion_MOA.hsp</strong>
}html
に書きましたのでご覧ください。



→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ



バージョン : ver4.0.0.6で追加

%index
E3DGetCurrentBonePos
現在のボーンの位置を取得します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　boneno
p3 : [IN] 数値または、変数　：　poskind
p4 : [OUT] 変数　：　posx
p5 : [OUT] 変数　：　posy
p6 : [OUT] 変数　：　posz

%inst
現在のボーンの位置を取得します。
E3DSetNewPose, E3DSetNewPoseMLの結果を使用します。



→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　boneno
　　ボーンを識別するＩＤ

3. [IN] 数値または、変数　：　poskind
　　poskind = 0 ---&gt; ローカル座標（ボーン変形なし）
　　poskind = 1 ---&gt; グローバル座標（ボーン変形あり）
　　poskind = 2 ---&gt; ローカル座標（ボーン変形あり）

4. [OUT] 変数　：　posx
5. [OUT] 変数　：　posy
6. [OUT] 変数　：　posz
　　ボーンの位置が代入されます。
　　実数型の変数。




バージョン : ver4.0.0.8で追加

%index
E3DGetCurrentBoneQ
現在のボーンの姿勢情報を取得します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　boneno
p3 : [IN] 数値または、変数　：　kind
p4 : [IN, OUT] 数値または、変数　：　qid

%inst
現在のボーンの姿勢情報を取得します。
E3DSetNewPose, E3DSetNewPoseMLの結果を使用します。



→引数
1. [IN] 数値または、変数　：　hsid
　　モデルを識別する番号を指定してください。

2. [IN] 数値または、変数　：　boneno
　　ボーンを識別する番号を指定してください。
　　E3DGetBoneNoByNameまたは、
　　E3DGetPartNoByNameで取得した番号を指定してください。

3. [IN] 数値または、変数　：　kind
　　親の影響を受けたクォータニオンを
　　取得する場合は、１を指定してください。

　　親の影響を受けていないクォータニオンを
　　取得する場合は、０を指定してください。

　　親の影響を受け、
　　更に、モデル全体の向きの影響を受けたクォータニオンを取得
　　するには、２を指定してください。


4. [IN, OUT] 数値または、変数　：　qid
　　クォータニオンを識別する番号。
　　E3DCreateQで取得した番号を指定してください。

　　qidで識別されるクォータニオンの内容に、
　　指定したボーンのクォータニオンの内容を、
　　代入します。



バージョン : ver4.0.0.8で追加

%index
E3DChkBumpMapEnable
ハードウェアがバンプマップを表示可能かどうかを調べます。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1
p1 : [OUT]変数　：　flag

%inst
ハードウェアがバンプマップを表示可能かどうかを調べます。


→引数
1. [OUT]変数　：　flag
　　バンプマップ表示可能の場合は０以外が、
　　表示不可能のときは０が代入されます。



バージョン : ver4.0.1.4で追加

%index
E3DEnableBumpMap
バンプマップ表示を使用するかどうかを設定します。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1
p1 : [IN] 数値または、変数　：　flag

%inst
バンプマップ表示を使用するかどうかを設定します。


→引数
1. [IN] 数値または、変数　：　flag
　　０を指定するとバンプマップを表示しません。
　　１を指定するとハードウェアに能力がある場合に限り、バンプマップを表示可能にします。



バージョン : ver4.0.1.4で追加

%index
E3DConvHeight2NormalMap
白黒の高さマップの画像データを、E3Dで使用可能な法線マップに変換します。
%group
Easy3D For HSP3 : テクスチャ

%prm
p1,p2,p3
p1 : [IN] 文字列または、文字列変数　：　hmapname
p2 : [IN] 文字列または、文字列変数　：　nmapname
p3 : [IN] 数値または、変数　：　hparam

%inst
白黒の高さマップの画像データを、E3Dで使用可能な法線マップに変換します。


→引数
1. [IN] 文字列または、文字列変数　：　hmapname
　　白黒画像のファイルのパス。

2. [IN] 文字列または、文字列変数　：　nmapname
　　法線マップのファイルのパス。
　　出力ファイル名。BMPのみ有効。

3. [IN] 数値または、変数　：　hparam
　　バンプマップの高さのパラメータ。
　　値が大きいほど段差がきつくなります。
　　実数。



バージョン : ver4.0.1.4で追加

%index
E3DSetBumpMapToMaterial
E3DCreateTextureで作成したテクスチャをバンプマップに設定します。
%group
Easy3D For HSP3 : マテリアル

%prm
p1,p2,p3
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　matno
p3 : [IN] 数値または、変数　：　texid

%inst
E3DCreateTextureで作成したテクスチャをバンプマップに設定します。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　matno
　　マテリアル番号。
　　E3DGetMaterialNoByNameで取得した番号、
　　もしくは
　　RokDeBone2の「面マテリアル」メニューで
　　表示されている「マテリアル番号」

3. [IN] 数値または、変数　：　texid
　　テクスチャのIDを指定してください。

　　-1を指定するとバンプマップが無効になります。




バージョン : ver4.0.1.4で追加

%index
E3DGetMOATrunkInfo
MOAの分岐元モーションの情報を取得します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　motid
p3 : [OUT] 配列変数　：　trunkinfo

%inst
MOAの分岐元モーションの情報を取得します。

trunkinfo引数には
dim trunkinfo, MOAT_MAX
で作成した配列を指定してください。

取得したtrunkinfo情報にはe3dhsp3.asで定義している
MOAT_で始まる定数でアクセスします。

それぞれの定数の役割は以下のとおりです。
MOAT_IDLING　アイドリングモーションかどうかのデータ
MOAT_EV0IDLE　イベント番号０でアイドリングに戻すかどうかのデータ
MOAT_COMID　共通分岐イベント番号
MOAT_NOTCOMID　共通分岐禁止イベント番号
MOAT_BRANCHNUM　分岐先モーションがいくつあるか

例えば共通分岐番号の情報にアクセスする場合は
trunkinfo( MOAT_COMID ) のように記述します。

この命令に渡すmotidはE3DGetMOAInfoで取得したIDを使用してください。

motid 0 (補間モーション)を指定すると
trunkinfoにはすべて０が代入されます。





→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　motid
　　モーションを識別するＩＤ

3. [OUT] 配列変数　：　trunkinfo
　　分岐元モーションの情報が代入されます。
　　前述の方法でdimした配列を指定してください。



バージョン : 

%index
E3DGetMOABranchInfo
MOAの分岐先モーションの情報を取得します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　motid
p3 : [OUT] 配列変数　：　branchinfo
p4 : [IN] 数値または、変数　：　branchnum
p5 : [OUT] 変数　：　getnum

%inst
MOAの分岐先モーションの情報を取得します。

branchinfo引数には
dim branchinfo, MOAB_MAX, branchnum
で作成した配列を指定してください。
branchnumにはE3DGetMOATrunkInfoで取得した
trunkinfo( MOAT_BRANCHNUM ) を指定してください。

取得したbranchinfo情報にはe3dhsp3.asで定義している
MOAB_で始まる定数でアクセスします。

それぞれの定数の役割は以下のとおりです。
MOAB_MOTID　分岐先モーションのモーションID
MOAB_EVENTID　イベント番号
MOAB_FRAME1　分岐元フレーム番号
MOAB_FRAME2　分岐先フレーム番号
MOAB_NOTFU　補間なしで変化させるかどうか

branchinfoの１番目のインデックスにはMOAB_で始まる定数を指定し、２番目のインデックスには０から(getnum - 1) の値（分岐先の番号）を指定します。

例えば、最初の分岐のイベント番号にアクセスする場合は
branchinfo( MOAB_EVENTID, 0 ) のように記述します。

この命令に渡すmotidはE3DGetMOAInfoで取得したIDを使用してください。





→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　motid
　　モーションを識別するＩＤ

3. [OUT] 配列変数　：　branchinfo
　　分岐先モーションの情報が代入されます。
　　前述の方法でdimした配列を指定してください。

4. [IN] 数値または、変数　：　branchnum
　　branchinfoをdimしたときのbranchnumを指定してください。

5. [OUT] 変数　：　getnum
　　分岐先モーション情報をいくつ取得したかが代入されます。




バージョン : 

%index
E3DSetMOABranchFrame1
MOAの分岐の分岐元フレーム番号情報を設定します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　tmotid
p3 : [IN] 数値または、変数　：　bmotid
p4 : [IN] 数値または、変数　：　frame1

%inst
MOAの分岐の分岐元フレーム番号情報を設定します。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　tmotid
　　分岐元モーションを識別するＩＤ

3. [IN] 数値または、変数　：　bmotid
　　分岐先モーションを識別するＩＤ

4. [IN] 数値または、変数　：　frame1
　　分岐の分岐元フレーム番号
　　-1指定は、いつでも分岐することを表します。





バージョン : 

%index
E3DSetMOABranchFrame2
MOAの分岐の分岐先フレーム番号情報を設定します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　tmotid
p3 : [IN] 数値または、変数　：　bmotid
p4 : [IN] 数値または、変数　：　frame2

%inst
MOAの分岐の分岐先フレーム番号情報を設定します。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　tmotid
　　分岐元モーションを識別するＩＤ

3. [IN] 数値または、変数　：　bmotid
　　分岐先モーションを識別するＩＤ

4. [IN] 数値または、変数　：　frame2
　　分岐の分岐先フレーム番号



バージョン : 

%index
E3DSetDispSwitch2
ディスプレイスイッチのアニメーションの設定をします。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　boneno
p3 : [IN] 数値または、変数　：　motid
p4 : [IN] 数値または、変数　：　switchid
p5 : [IN] 数値または、変数　：　frameno
p6 : [IN] 数値または、変数　：　switchflag

%inst
ディスプレイスイッチのアニメーションの設定をします。


→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　boneno
　　ボーンを識別するパーツの番号

3. [IN] 数値または、変数　：　motid
　　モーションを識別するＩＤ

4. [IN] 数値または、変数　：　switchid
　　スイッチの番号。０から９９

5. [IN] 数値または、変数　：　frameno
　　モーションのフレーム番号

6. [IN] 数値または、変数　：　switchflag
　　スイッチの状態。
　　０がオフ。１がオン。




バージョン : ver5.0.0.1で追加

%index
E3DQtoEuler
クォータニオンの姿勢をオイラー角に変換します。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 数値または、変数　：　qid
p2 : [OUT] 数値または、変数　：　newx
p3 : [OUT] 数値または、変数　：　newy
p4 : [OUT] 数値または、変数　：　newz
p5 : [IN] 数値または、変数　：　oldx
p6 : [IN] 数値または、変数　：　oldy
p7 : [IN] 数値または、変数　：　oldz

%inst
クォータニオンの姿勢をオイラー角に変換します。
回転の順番はZ軸、X軸、Y軸です。



→引数
1. [IN] 数値または、変数　：　qid
　　クォータニオンを識別するＩＤ

2. [OUT] 数値または、変数　：　newx
3. [OUT] 数値または、変数　：　newy
4. [OUT] 数値または、変数　：　newz
　　オイラー角が代入されます。
　　実数型の変数。

5. [IN] 数値または、変数　：　oldx
6. [IN] 数値または、変数　：　oldy
7. [IN] 数値または、変数　：　oldz
　　前回E3DQtoEulerした結果を指定します。
　　計算時にoldに一番近い角度をnewに代入します。
　　初回時には０を指定してください。




バージョン : ver5.0.0.1で追加

%index
E3DEnablePhongEdge
色P時に輪郭線を表示するかを指定します。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1,p2
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　flag

%inst
色P時に輪郭線を表示するかを指定します。


→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　flag
　　輪郭線を表示するとき１、しないとき０




バージョン : ver5.0.0.1で追加

%index
E3DSetPhongEdge0Params
色P時の輪郭線の色と幅と半透明モードを設定します。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　r
p3 : [IN] 数値または、変数　：　g
p4 : [IN] 数値または、変数　：　b
p5 : [IN] 数値または、変数　：　width
p6 : [IN] 数値または、変数　：　blendmode
p7 : [IN] 数値または、変数　：　alpha

%inst
色P時の輪郭線の色と幅と半透明モードを設定します。

半透明の輪郭線はE3DRenderのwithalpha引数に１を指定したときに表示されます。



→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　r
3. [IN] 数値または、変数　：　g
4. [IN] 数値または、変数　：　b
　　輪郭線の色をRGBで指定します。
　　それぞれ０から２５５までの値。

5. [IN] 数値または、変数　：　width
　　輪郭線の幅を実数で指定します。

6. [IN] 数値または、変数　：　blendmode
　　輪郭線の半透明モードを指定します。
　　０を指定すると頂点アルファによる半透明
　　１を指定するとアッドモード
　　２を指定すると頂点アルファを考慮したアッドモード
　　３を指定すると不透明
　　になります。
　　デフォルト値は３です。

7. [IN] 数値または、変数　：　alpha
　　輪郭線の頂点アルファを指定します。
　　blendmodeで０または２を指定したときに
　　意味を持ちます。
　　0.0から1.0の間の実数を指定してください。




バージョン : ver5.0.0.1で追加<BR>
      ver5.0.0.3で拡張

%index
E3DGetDispSwitch2
ディスプレイスイッチを取得します。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　hsid
p2 : [OUT] 配列変数　：　dispswitch
p3 : [IN] 数値または、変数　：　leng

%inst
ディスプレイスイッチを取得します。
E3DSetNewPose, E3DSetNewPoseMLの結果を利用します。

dispswitch変数は
dim dispswitch, DISPSWITCHNUM
で確保してからこの命令に渡してください。

DISPSWITCHNUMはe3dhsp3.asで定義されています。
（スイッチの総数です）

スイッチがオフのとき０がオンのときは０以外が代入されます。

例えばスイッチ３がオンのときは
dispswitch( 3 ) に０以外が代入されます。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [OUT] 配列変数　：　dispswitch
　　スイッチの状態が代入されます。
　　詳しくは前記をご覧ください。

3. [IN] 数値または、変数　：　leng
　　dispswitch配列を作成したときの
　　要素数を指定します。




バージョン : ver5.0.0.6で追加

%index
E3DFreeThread
スレッドのリソースを解放します。
%group
Easy3D For HSP3 : スレッド管理

%prm
p1
p1 : [IN] 数値または、変数　：　threadid

%inst
スレッドのリソースを解放します。
この命令を実行が終わったスレッドに対して呼ぶことで
4098回の呼び出し回数制限を緩和することが出来ます。
ただしこの命令を使用しても一度にアクティブにできる
スレッド命令は4098個のままです。




→引数
1. [IN] 数値または、変数　：　threadid
　　スレッドを識別するＩＤ



バージョン : ver5.0.0.7で追加

%index
E3DLoadSigFileAsGroundThread
スレッドを作成して、E3DLoadSigFileAsGroundを実行します。
%group
Easy3D For HSP3 : 地面

%prm
p1,p2,p3,p4
p1 : [IN] 文字列または、文字列の変数　：　fname
p2 : [IN] 変数または、数値　：　adjustuvflag
p3 : [IN] 変数または、数値　：　mult
p4 : [OUT] 変数　：　threadid

%inst
スレッドを作成して、E3DLoadSigFileAsGroundを実行します。

作成したスレッドを識別するためのＩＤが
threadidに代入されます。

スレッドの作成に失敗した場合には、
threadidにマイナスの値が、代入されます。

threadidは、
E3DChkThreadWorkingに使用することが
出来ます。

スレッド作成関数は、全部で、4098回まで、
呼ぶことが出来ます。
（E3DChkThreadWorkingを除く）
E3DFreeThreadの説明もご覧ください。


スレッドが終了すると、
E3DChkThreadWorkingで取得される
returnval1に、
モデルデータを識別するhsidが代入されます。


E3DLoadSigFileAsGroundの説明も、お読みください。



→引数
1. [IN] 文字列または、文字列の変数　：　fname
　　*.sig のパス文字列。

2. [IN] 変数または、数値　：　adjustuvflag
　　ＵＶ値を正規化するかどうかのフラグ
　　正規化する場合は１を指定
　　しない場合は０を指定

3. [IN] 変数または、数値　：　mult
　　読み込み倍率を指定してください。
　　等倍は１．０。
　　実数。

4. [OUT] 変数　：　threadid
　　作成したスレッドを識別するID。



バージョン : ver5.0.0.7で追加

%index
E3DLoadSigFileAsGroundFromBufThread
スレッドを作成して、E3DLoadSigFileAsGroundFromBufを実行します。
%group
Easy3D For HSP3 : 地面

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 文字列または、文字列の変数　：　resdir
p2 : [IN] 変数　：　buf
p3 : [IN] 変数または、数値　：　bufleng
p4 : [IN] 変数または、数値　：　adjustuvflag
p5 : [IN] 変数または、数値　：　mult
p6 : [OUT] 変数　：　threadid

%inst
スレッドを作成して、E3DLoadSigFileAsGroundFromBufを実行します。

作成したスレッドを識別するためのＩＤが
threadidに代入されます。

スレッドの作成に失敗した場合には、
threadidにマイナスの値が、代入されます。

threadidは、
E3DChkThreadWorkingに使用することが
出来ます。

スレッド作成関数は、全部で、4098回まで、
呼ぶことが出来ます。
（E3DChkThreadWorkingを除く）
E3DFreeThreadの説明もご覧ください。


スレッドが終了すると、
E3DChkThreadWorkingで取得される
returnval1に、
モデルデータを識別するhsidが代入されます。


E3DLoadSigFileAsGroundFromBufの説明も、お読みください。



→引数
1. [IN] 文字列または、文字列の変数　：　resdir
　　テクスチャーのあるフォルダ のパス文字列。
　　最後に、&quot;\\&quot;が必要。

2. [IN] 変数　：　buf
　　バッファの変数

3. [IN] 変数または、数値　：　bufleng
　　バッファの中のデータの長さ

4. [IN] 変数または、数値　：　adjustuvflag
　　ＵＶ値を正規化するかどうかのフラグ
　　正規化する場合は１を指定
　　しない場合は０を指定

5. [IN] 変数または、数値　：　mult
　　読み込み倍率を指定してください。
　　等倍は１．０。
　　実数。

6. [OUT] 変数　：　threadid
　　作成したスレッドを識別するID。



バージョン : ver5.0.0.7で追加

%index
E3DSetLightIdOfBumpMap
バンプマップを照らす光源を１つだけ選択します。
%group
Easy3D For HSP3 : ライト

%prm
p1
p1 : [IN] 数値または、変数　：　lid

%inst
バンプマップを照らす光源を１つだけ選択します。

平行光源でも点光源でもOKです。



→引数
1. [IN] 数値または、変数　：　lid
　　ライトを識別するＩＤ



バージョン : ver5.0.0.8で追加

%index
E3DSetSpriteUV
スプライトのUVを設定します。
%group
Easy3D For HSP3 : スプライト

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　spid
p2 : [IN] 数値または、変数　：　startu
p3 : [IN] 数値または、変数　：　endu
p4 : [IN] 数値または、変数　：　startv
p5 : [IN] 数値または、変数　：　endv

%inst
スプライトのUVを設定します。

具体的な使用例は
e3dhsp3_SpriteUV.hspをご覧ください。



→引数
1. [IN] 数値または、変数　：　spid
　　スプライトを識別するＩＤ

2. [IN] 数値または、変数　：　startu
　　U方向の表示開始点を０から１で指定します。
　　実数。

3. [IN] 数値または、変数　：　endu
　　U方向の表示終了点を０から１で指定します。
　　実数。

4. [IN] 数値または、変数　：　startv
　　V方向の表示開始点を０から１で指定します。
　　実数。

5. [IN] 数値または、変数　：　endv
　　V方向の表示終了点を０から１で指定します。
　　実数。




バージョン : ver5.0.0.8で追加

%index
E3DCreateRenderTargetTexture
レンダリング可能なテクスチャを作成します。
%group
Easy3D For HSP3 : テクスチャ

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 数値または、変数　：　sizex
p2 : [IN] 数値または、変数　：　sizey
p3 : [OUT] 変数　：　scid
p4 : [OUT] 変数　：　texid
p5 : [OUT] 変数　：　okflag
p6 : [IN] 数値または、変数　：　fmt

%inst
レンダリング可能なテクスチャを作成します。

この命令が成功するとスワップチェインIDとテクスチャIDが取得できます。

テクスチャのサイズは２の乗数にしてください。

消費するビデオメモリ量は
sizex * sizey * ( 4 + 2 ) バイトです。


メモリ不足などでこの命令が失敗した場合には
エラーにならずにokflagに０が代入されます。
失敗した場合はテクスチャサイズを小さくするなどして
再試行してみてください。

具体的な使用例は
e3dhsp3_RenderTargetTexture.hspをご覧ください。





→引数
1. [IN] 数値または、変数　：　sizex
2. [IN] 数値または、変数　：　sizey
　　作成するテクスチャのサイズ
　　２の乗数を推奨。

3. [OUT] 変数　：　scid
　　スワップチェインIDが代入されます。

4. [OUT] 変数　：　texid
　　テクスチャIDが代入されます。

5. [OUT] 変数　：　okflag
　　成功した場合は１が
　　失敗した場合は０が代入されます。

6. [IN] 数値または、変数　：　fmt
　　作成したいテクスチャのフォーマットを指定します。
　　e3dhsp3.asで定義されているD3DFMT_で始まる
　　定数を使用してください。
　　この引数を省略した場合は
　　D3DFMT_A8R8G8B8で作成されます。




バージョン : ver5.0.0.9で追加<BR>
      ver5.0.1.6で引数追加<BR>
      

%index
E3DDestroyRenderTargetTexture
レンダーターゲットテクスチャを破棄します。
%group
Easy3D For HSP3 : テクスチャ

%prm
p1,p2
p1 : [IN] 数値または、変数　：　scid
p2 : [IN] 数値または、変数　：　texid      　　E3DCreateRednerTargetTextureで

%inst
レンダーターゲットテクスチャを破棄します。




→引数
1. [IN] 数値または、変数　：　scid
　　E3DCreateRednerTargetTextureで
　　取得したスワップチェインIDを指定します。

2. [IN] 数値または、変数　：　texid      　　E3DCreateRednerTargetTextureで
　　取得したテクスチャIDを指定します。



バージョン : ver5.0.0.9で追加

%index
E3DSetDSFillUpMode
補間時に補間前のモーションのスイッチ状態を表示するか、もしくは補間後のモーションのスイッチ状態を表示するかを選びます。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　mode

%inst
補間時に補間前のモーションのスイッチ状態を表示するか、もしくは補間後のモーションのスイッチ状態を表示するかを選びます。






→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　mode
　　０を指定すると補間前のモーションの
　　スイッチ状態を表示します。
　　１を指定すると補間後のモーションの
　　スイッチ状態を表示します。





バージョン : ver5.0.1.2で追加

%index
E3DSetTexFillUpMode
補間時に補間前のモーションのテクスチャアニメの状態を表示するか、もしくは補間後のモーションのテクスチャアニメの状態を表示するかを選びます。
%group
Easy3D For HSP3 : モーション

%prm
p1,p2
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　mode

%inst
補間時に補間前のモーションのテクスチャアニメの状態を表示するか、もしくは補間後のモーションのテクスチャアニメの状態を表示するかを選びます。


→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　mode
　　０を指定すると補間前のモーションの
　　テクスチャを表示します。
　　１を指定すると補間後のモーションの
　　テクスチャを表示します。



バージョン : 

%index
E3DSetShadowBias
影をレンダリングする際のZバッファのバイアスを設定します。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1
p1 : [IN] 数値または、変数　：　bias

%inst
影をレンダリングする際のZバッファのバイアスを設定します。
一般に大きい値を設定すればマッハバンド（縞模様）が消えます。

具体的な使用例はe3dhsp3_shadow2.hspをご覧ください。



→引数
1. [IN] 数値または、変数　：　bias
　　Zバッファの誤差を緩和するためのバイアスを指定します。
　　デフォルト値は0.005です。


バージョン : ver5.0.1.6で追加

%index
E3DRenderWithShadow
影付きのシーンを一括レンダリングします。
%group
Easy3D For HSP3 : 描画

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 数値または、変数　：　scid
p2 : [IN] 数値または、変数　：　rtscid
p3 : [IN] 数値または、変数　：　rttexid
p4 : [IN] 配列変数　：　hsidarray
p5 : [IN] 数値または、変数　：　num
p6 : [IN] 数値または、変数　：　skipflag

%inst
影付きのシーンを一括レンダリングします。
内部でE3DChkInView、E3DBeginScene、E3DEndSceneも
呼ばれます。
全ての不透明を描画後、半透明が描画されます。

hsidarray（配列）にレンダリングしたいhsidを格納してから呼び出します。

具体的な使用例はe3dhsp3_shadow2.hspをご覧ください。



→引数
1. [IN] 数値または、変数　：　scid
　　影付きのシーンをレンダリングするための
　　スワップチェインIDを指定してください。

2. [IN] 数値または、変数　：　rtscid
3. [IN] 数値または、変数　：　rttexid
　　シャドウマップ用のE3DCreateRenderTargetTexture
　　で取得したscidとtexidを指定してください。

4. [IN] 配列変数　：　hsidarray
　　描画したいhsidを配列に格納してください。
　　ビルボードを描画したいときはhsidに-1を
　　格納してください。


5. [IN] 数値または、変数　：　num
　　hsidarrayに何個のhsidを格納したかを指定してください。

6. [IN] 数値または、変数　：　skipflag
　　skipflagに１を指定すると
　　画面のバッファのクリアと背景の描画を
　　スキップします。

　　デフォルト値は０．
　　BeginSceneとEndSceneはスキップしません。

　　E3DBeginScene scid1
　　　　前に描画したいものをレンダー
　　E3DEndScene
　　E3DRenderWithShadow (skipflag = 1)
　　E3DBeginScene scid1, 1
　　　　後に描画したいものをレンダー
　　E3DEndScene
　　のように描画してください。





バージョン : ver5.0.1.6で追加<BR>
      ver5.0.1.7で引数追加<BR>
      

%index
E3DChkShadowEnable
ハードウェアで影の描画が出来るかどうかを調べます。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1
p1 : [OUT] 変数　：　flag

%inst
ハードウェアで影の描画が出来るかどうかを調べます。


→引数
1. [OUT] 変数　：　flag
　　影の描画が出来る時は０以外が
　　出来ないときは０が代入されます。


バージョン : ver5.0.1.6で追加

%index
E3DEnableShadow
影の描画をオンまたはオフにします。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1
p1 : [IN] 数値または、変数　：　flag

%inst
影の描画をオンまたはオフにします。


→引数
1. [IN] 数値または、変数　：　flag
　　１をセットすると影の描画が可能な時は描画するようにします。
　　０をセットすると影の描画は行わないようにします。



バージョン : ver5.0.1.6で追加

%index
E3DCheckRTFormat
E3DCreateRenderTargetTextureで作成できるフォーマットを調べます。
%group
Easy3D For HSP3 : テクスチャ

%prm
p1,p2
p1 : [IN] 数値または、変数　：　fmt
p2 : [OUT] 変数　：　okflag

%inst
E3DCreateRenderTargetTextureで作成できるフォーマットを調べます。
具体的な使用例はe3dhsp3_shadow.hspをご覧ください。



→引数
1. [IN] 数値または、変数　：　fmt
　　調べたいフォーマットを指定します。
　　e3dhsp3.asで定義されているD3DFMT_で始まる
　　定数を使用してください。

2. [OUT] 変数　：　okflag
　　指定したフォーマットが使用可能な時は０以外が
　　使用不可な時は０が代入されます。




バージョン : ver5.0.1.6で追加

%index
E3DSetShadowDarkness
影の暗さを設定します。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1
p1 : [IN] 数値または、変数　：　darkness

%inst
影の暗さを設定します。

darknessに指定した係数にAmbientを掛けたものが
影の色となります。

デフォルト値は１．０です。
０に近づくほど暗くなります。





→引数
1. [IN] 数値または、変数　：　darkness
　　０以上の実数。
　　アンビエントに掛け算して影の色とする。



バージョン : ver5.0.1.7で追加

%index
E3DRenderBatch
E3DRenderのバッチ版。
%group
Easy3D For HSP3 : 描画

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　scid
p2 : [IN] 配列変数　：　hsidarray
p3 : [IN] 数値または、変数　：　num
p4 : [IN] 数値または、変数　：　needchkinview
p5 : [IN] 数値または、変数　：　skipflag

%inst
E3DRenderのバッチ版。hsidをまとめて描画することにより高速化。

内部でE3DChkInView、E3DBeginScene、E3DEndSceneも
呼ばれます。

全ての不透明を描画後、半透明が描画されます。



→引数
1. [IN] 数値または、変数　：　scid
　　スワップチェインIDを指定してください。

2. [IN] 配列変数　：　hsidarray
　　描画したいhsidを格納した配列。

3. [IN] 数値または、変数　：　num
　　hsidarrayに何個のhsidをセットしたか。

4. [IN] 数値または、変数　：　needchkinview
　　内部でChkInViewを呼ぶかどうかのフラグ。

5. [IN] 数値または、変数　：　skipflag
　　０以外をセットすると
　　画面バッファのクリアと背景の描画をスキップします。
　　
　　BeginSceneとEndSceneはスキップしません。
　　デフォルト値は０。



バージョン : ver5.0.1.7で追加

%index
E3DSetVertPosBatch
E3DSetVertPosのバッチ版。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 配列変数　：　vertnoarray
p4 : [IN] 数値または、変数　：　vnum
p5 : [IN] 配列変数　：　vertarray

%inst
E3DSetVertPosのバッチ版。まとめて高速化。

あたり判定データの更新はされません。


vertarrayには、
html{
<strong>ddim vertarray, vnum, 3</strong>
}html
で確保したデータを渡してください。

dimではなくて、ddimで確保してください。

vnumには、点の数を入れてください。

vertarray(点の番号,0) にＸ座標、
vertarray(点の番号,１) にＹ座標、 
vertarray(点の番号,２) にＺ座標
を入れて、初期化しておいてください。





→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するID。

2. [IN] 数値または、変数　：　partno
　　パーツを識別するID。

3. [IN] 配列変数　：　vertnoarray
　　位置を設定したい頂点の番号を配列にセットしてください。

4. [IN] 数値または、変数　：　vnum
　　何個の頂点の位置を設定するかをセットしてください。

5. [IN] 配列変数　：　vertarray
　　頂点の座標を実数型の配列にセットしてください。
　　詳しくは前記をご覧ください。







バージョン : ver5.0.1.7で追加

%index
E3DSetShadowMapLightDir
影用の平行光源の向きを設定します。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　dirx
p2 : [IN] 数値または、変数　：　diry
p3 : [IN] 数値または、変数　：　dirz

%inst
影用の平行光源の向きを設定します。


→引数
1. [IN] 数値または、変数　：　dirx
2. [IN] 数値または、変数　：　diry
3. [IN] 数値または、変数　：　dirz
　　平行光源の向きをベクトル（dirx, diry, dirz）で
　　指定します。
　　実数です。




バージョン : ver5.0.2.0で追加

%index
E3DRenderBatchMode
E3DRenderBatchの拡張版。
%group
Easy3D For HSP3 : 描画

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 数値または、変数　：　scid
p2 : [IN] 配列変数　：　hsidarray
p3 : [IN] 数値または、変数　：　num
p4 : [IN] 数値または、変数　：　needchkinview
p5 : [IN] 数値または、変数　：　skipflag
p6 : [IN] 配列変数　：　modearray

%inst
E3DRenderBatchの拡張版。
hsidごとに不透明のみを描画するか
半透明のみを描画するか
不透明と半透明の両方を描画するかを指定できます。

適切に設定することで描画速度が速くなります。


hsidarrayにはパーティクルのIDを指定することもできます。
パーティクルはmode 2のみ有効です。
パーティクルをhsidarrayに含める場合はこの命令を呼ぶ前に
onlyupdate引数を１にしてE3DRenderParticleを呼んでおく必要があります。






→引数
1. [IN] 数値または、変数　：　scid
　　スワップチェインIDを指定してください。

2. [IN] 配列変数　：　hsidarray
　　描画したいhsidを格納した配列。

3. [IN] 数値または、変数　：　num
　　hsidarrayに何個のhsidをセットしたか。

4. [IN] 数値または、変数　：　needchkinview
　　内部でChkInViewを呼ぶかどうかのフラグ。

5. [IN] 数値または、変数　：　skipflag
　　０以外をセットすると
　　画面バッファのクリアと背景の描画をスキップします。
　　
　　BeginSceneとEndSceneはスキップしません。
　　デフォルト値は０。

6. [IN] 配列変数　：　modearray
　　描画モードを格納した配列。
　　hsidarrayと同じ長さの配列。
　　配列の要素に１を指定すると不透明のみ
　　２を指定すると半透明のみ
　　３を指定すると両方を描画します。




バージョン : ver5.0.2.1で追加

%index
E3DGlobalToLocal
グローバル座標系からキャラクターのローカル座標系への変換。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　srcx
p3 : [IN] 数値または、変数　：　srcy
p4 : [IN] 数値または、変数　：　srcz
p5 : [OUT] 変数　：　dstx
p6 : [OUT] 変数　：　dsty
p7 : [OUT] 変数　：　dstz

%inst
グローバル座標系からキャラクターのローカル座標系への変換。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　srcx
3. [IN] 数値または、変数　：　srcy
4. [IN] 数値または、変数　：　srcz
　　変換前の座標を指定します。
　　実数。

5. [OUT] 変数　：　dstx
6. [OUT] 変数　：　dsty
7. [OUT] 変数　：　dstz
　　変換後の座標が代入されます。
　　実数型の変数。




バージョン : ver5.0.2.1で追加

%index
E3DLocalToGlobal
キャラクターのローカル座標系からグローバル座標系への変換。
%group
Easy3D For HSP3 : 算術

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　srcx
p3 : [IN] 数値または、変数　：　srcy
p4 : [IN] 数値または、変数　：　srcz
p5 : [OUT] 変数　：　dstx
p6 : [OUT] 変数　：　dsty
p7 : [OUT] 変数　：　dstz

%inst
キャラクターのローカル座標系からグローバル座標系への変換。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するＩＤ

2. [IN] 数値または、変数　：　srcx
3. [IN] 数値または、変数　：　srcy
4. [IN] 数値または、変数　：　srcz
　　変換前の座標を指定します。
　　実数。

5. [OUT] 変数　：　dstx
6. [OUT] 変数　：　dsty
7. [OUT] 変数　：　dstz
　　変換後の座標が代入されます。
　　実数型の変数。



バージョン : ver5.0.2.1で追加

%index
E3DSetShadowMapMode
シャドウマップのモードを設定します。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1
p1 : [IN] 数値または、変数　：　mode

%inst
シャドウマップのモードを設定します。

モード０を指定するとLiSPSMの方法で
E3DSetShadowMapLightDirを呼び出すだけで自動的に
適切なシャドウマップを作成します。

モード１を指定するとE3DSetShadowMapCameraと
E3DSetShadowMapProjOrthoを使用する
マニュアル設定のモードになります。

この命令を呼び出さなかった場合は
モード０が適用されます。




→引数
1. [IN] 数値または、変数　：　mode
　　モード（０または１）を指定します。
　　詳しくは前記をご覧ください。



バージョン : ver5.0.2.2で追加

%index
E3DSetShadowMapCamera
シャドウマップを作成する際のカメラの位置を設定します。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1,p2,p3
p1 : [IN] 実数型配列変数 pos
p2 : [IN] 実数型配列変数 target
p3 : [IN] 実数型配列変数 upvec

%inst
シャドウマップを作成する際のカメラの位置を設定します。
影を落とす際のライトの位置と同じ意味です。



→引数
1. [IN] 実数型配列変数 pos
　　カメラの位置を実数型の配列で指定します。
　　ddim pos, 3で作成し
　　pos(0)にX座標、pos(1)にY座標、pos(2)にZ座標を
　　指定します。

2. [IN] 実数型配列変数 target
　　カメラの注視点を実数型の配列で指定します。
　　ddim target, 3で作成し
　　pos(0)にX座標、pos(1)にY座標、pos(2)にZ座標を
　　指定します。

3. [IN] 実数型配列変数 upvec
　　カメラの上方向ベクトルを
　　実数型の配列で指定します。
　　ddim upvec, 3で作成し
　　pos(0)にX座標、pos(1)にY座標、pos(2)にZ座標を
　　指定します。
　　通常は( 0.0, 1.0, 0.0 )を指定します。


バージョン : ver5.0.2.2で追加

%index
E3DSetShadowMapProjOrtho
シャドウマップを作成する際のプロジェクションを設定します。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1,p2,p3,p4
p1 : [IN] 数値または、変数　：　rttexid
p2 : [IN] 数値または、変数　：　near
p3 : [IN] 数値または、変数　：　far
p4 : [IN] 数値または、変数　：　viewsize

%inst
シャドウマップを作成する際のプロジェクションを設定します。
どのくらいの範囲のシーンをシャドウマップにするかが決定されます。




→引数
1. [IN] 数値または、変数　：　rttexid
　　E3DCreateRenderTargetTextureで作成したシャドウマップ用のテクスチャIDを渡します。

2. [IN] 数値または、変数　：　near
　　視野内のカメラから一番近い距離を指定します。
　　あまり小さいとZバッファの精度が悪くなります。
　　実数。

3. [IN] 数値または、変数　：　far
　　視野内のカメラから一番遠い距離を指定します。
　　あまり大きいとZバッファの精度が悪くなります。
　　実数。

4. [IN] 数値または、変数　：　viewsize
　　正射影のビューのボリュームサイズを指定します。
　　実数。


バージョン : ver5.0.2.2で追加

%index
E3DSetVertPosBatchAOrder
E3DSetVertPosのバッチ版。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 配列変数　：　vertnoarray
p4 : [IN] 数値または、変数　：　vnum
p5 : [IN] 配列変数　：　vertarray

%inst
E3DSetVertPosのバッチ版。まとめて高速化。

あたり判定データの更新はされません。

E3DSetVertPosBatchとはvertarrayの２次元配列の順番が
異なります。

vertarrayには、
html{
<strong>ddim vertarray, 3, vnum</strong>
}html
で確保したデータを渡してください。

dimではなくて、ddimで確保してください。

vnumには、点の数を入れてください。

vertarray(0, 点の番号) にＸ座標、
vertarray(1, 点の番号) にＹ座標、 
vertarray(2, 点の番号) にＺ座標
を入れて、初期化しておいてください。





→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するID。

2. [IN] 数値または、変数　：　partno
　　パーツを識別するID。

3. [IN] 配列変数　：　vertnoarray
　　位置を設定したい頂点の番号を配列にセットしてください。

4. [IN] 数値または、変数　：　vnum
　　何個の頂点の位置を設定するかをセットしてください。

5. [IN] 配列変数　：　vertarray
　　頂点の座標を実数型の配列にセットしてください。
　　詳しくは前記をご覧ください。



バージョン : ver5.0.2.2で追加

%index
E3DLoadTextureFromBuf
作成済みのテクスチャにバッファから画像ファイルを読み込みます。
%group
Easy3D For HSP3 : テクスチャ

%prm
p1,p2,p3,p4
p1 : [IN] 変数または、数値　：　texid
p2 : [IN] 変数　：　buf
p3 : [IN] 変数または、数値　：　bufleng
p4 : [IN] 変数または、数値　：　transparent

%inst
作成済みのテクスチャにバッファから画像ファイルを読み込みます。

テクスチャの内容を頻繁に更新したいときに
この命令を使えばテクスチャの作成と破棄を繰り返さなくても
すみます。

ループの外で１回E3DCreateTextureなどでテクスチャを作っておき
ループ中でこのE3DLoadTextureFromBufを呼び出すことを想定しています。





→引数
1. [IN] 変数または、数値　：　texid
　　作成済みのテクスチャを識別するID

2. [IN] 変数　：　buf
　　バッファの変数
　　ファイルのイメージがバッファに入っていると
　　想定します。

3. [IN] 変数または、数値　：　bufleng
　　バッファの中のデータの長さ(バイト)

4. [IN] 変数または、数値　：　transparent
　　透過情報を指定します。

　　texidを取得するときのテクスチャ作成命令に
　　指定したのと同じtransparentを指定してください。




バージョン : ver5.0.2.5で追加

%index
E3DLoadSpriteFromBMSCR
作成済みのスプライトにHSPの画像バッファから画像を読み込みます。
%group
Easy3D For HSP3 : スプライト

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 変数または、数値　：　spriteid
p2 : [IN] 変数または、数値　：　wid
p3 : [IN] 変数または、数値　：　transparentflag
p4 : [IN] 変数または、数値　：　tpR
p5 : [IN] 変数または、数値　：　tpG
p6 : [IN] 変数または、数値　：　tpB

%inst
作成済みのスプライトにHSPの画像バッファから画像を読み込みます。

スプライトの内容を頻繁に更新したいときに
この命令を使えばスプライトの作成と破棄を繰り返さなくても
すみます。

この命令に渡すspriteidは
E3DCreateSpriteFromBMSCRで作成したスプライトでなければなりません。
他の命令で作成したスプライトIDを渡すとエラーになります。

ループの外で１回E3DCreateSpriteFromBMSCRでスプライトを作っておき
ループ中でこのE3DLoadSpriteFromBMSCRを呼び出すことを想定しています。






→引数
1. [IN] 変数または、数値　：　spriteid
　　E3DCreateSpriteFromBMSCRで作成した
　　スプライトID。

2. [IN] 変数または、数値　：　wid
　　ウインドウID

3. [IN] 変数または、数値　：　transparentflag
　　透過フラグ。

　　E3DCreateSpriteFromBMSCR
　　に指定したのと同じ値を指定してください。
　　（異なるものを渡すとエラーになります。）

4. [IN] 変数または、数値　：　tpR
5. [IN] 変数または、数値　：　tpG
6. [IN] 変数または、数値　：　tpB
　　透過色。





バージョン : ver5.0.2.5で追加

%index
E3DSetShadowMapInterFlag
シャドウマップにパーツを含めるかどうかのフラグを設定します。
%group
Easy3D For HSP3 : 描画パラメータ

%prm
p1,p2,p3
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　flag

%inst
シャドウマップにパーツを含めるかどうかのフラグを設定します。

シャドウマップモード０用です。

フラグには
e3dhsp3.asで定義されているSHADOWIN_*を指定します。

SHADOWIN_PROJのときは
パーツの一部分でも視野内に入っている場合には
パーツ全体がシャドウマップに含まれるようにします。
キャラクターデータのデフォルト値です。

SHADOWIN_ALWAYSのときは
視野内に入っているかどうかにかかわらず
必ずシャドウマップにパーツ全体が含まれるようにします。
シャドウマップに入るパーツが広い範囲に散らばれば散らばるほど
影の品質は悪くなります。
ですのでシャドウマップに入れるかどうかを動的に判定し、
必要がなくなったら
SHADOWIN_PROJやSHADOWIN_NOTに戻すことを推奨します。

SHADOWIN_NOTのときは
シャドウマップに入れるかどうかをE3D側で制御しません。
地面などの大きいオブジェクト用のモードです。
地面データのデフォルト値です。






→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するID。

2. [IN] 数値または、変数　：　partno
　　パーツを識別するID。

3. [IN] 数値または、変数　：　flag
　　SHADOWIN_ではじまる定数を指定します。
　　詳しくは前記をご覧ください。




バージョン : ver5.0.2.7で追加

%index
E3DSetMaterialAlphaTest
マテリアルごとにアルファテストのオンオフを設定できます。
%group
Easy3D For HSP3 : マテリアル

%prm
p1,p2,p3,p4,p5,p6
p1 : [IN] 変数または、数値　：　hsid
p2 : [IN] 変数または、数値　：　matno
p3 : [IN] 変数または、数値　：　alphatest0
p4 : [IN] 変数または、数値　：　alphaval0
p5 : [IN] 変数または、数値　：　alphatest1
p6 : [IN] 変数または、数値　：　alphaval1

%inst
マテリアルごとにアルファテストのオンオフを設定できます。

E3DSetMaterialBlendingModeで０、１、２の値をセットしている場合はアルファテストも自動的に設定されるようになっています。
自動設定させたくない場合はblendmode １００、１０１、１０２を使用するか、もしくはE3DSetMaterialBlendingModeの後で
E3DSetMaterialAlphaTestを呼び出してください。

アルファテストをオンにした場合は
アルファの値が閾値よりも小さい場合に描画されなくなります。
（Zバッファにも描画されなくなります。）





→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid

2. [IN] 変数または、数値　：　matno
　　マテリアル番号。
　　E3DGetMaterialNoByNameで取得した番号、
　　もしくは
　　RokDeBone2の「面マテリアル」メニューで
　　表示されている「マテリアル番号」

3. [IN] 変数または、数値　：　alphatest0
　　不透明を描画時にアルファテストする場合は１を
　　しない場合は０を指定します。

4. [IN] 変数または、数値　：　alphaval0
　　不透明時のアルファテストのアルファの閾値。
　　（０から２５５）

5. [IN] 変数または、数値　：　alphatest1
　　半透明を描画時にアルファテストする場合は１を
　　しない場合は０を指定します。

6. [IN] 変数または、数値　：　alphaval1
　　半透明時のアルファテストのアルファの閾値。
　　（０から２５５）




バージョン : ver5.0.2.9で追加

%index
E3DTransformBillboard
ビルボードの視野内判定と位置計算とソートを行います。
%group
Easy3D For HSP3 : 描画準備

%prm
なし

%inst
ビルボードの視野内判定と位置計算とソートを行います。

デフォルト状態のE3DRenderBillboardでは
これらの描画準備の計算と描画の処理がいっぺんに行われていました。
そのためあたり判定は描画の後にしなくてはならず、
実際の描画と判定が１フレームずれるという問題がありました。

この問題を解決するためにこの命令を追加しました。
この命令を呼び出したあとビルボードの位置などに変更がない場合は、E3DRenderBillboardのtransskip引数に１を設定します。
そうすることで２度同じ描画準備の計算を行うことを防ぎます。


E3DTransformBillboard
あたり判定
E3DRenderBillboard (transskip = 1)

のように使ってください。





→引数
引数なし

バージョン : ver5.0.2.9で追加

%index
E3DCalcMLMotion
マルチレイヤーモーションの姿勢情報を計算します。
%group
Easy3D For HSP3 : モーション

%prm
p1
p1 : [IN] 変数または、数値　：　hsid

%inst
マルチレイヤーモーションの姿勢情報を計算します。ローカルの姿勢から親子関係を反映した姿勢を計算します。

E3DSetNewPoseMLより後でE3DSetBoneQした場合などに
呼んでください。

（E3DSetNewPoseML内部からも呼ばれています）

使用例としてはE3DSetMotionKindML
E3DSetNewPoseML
E3DGetMotionFrameNo
E3DSetBoneQ
E3DCalcMLMotion
のような順序で呼び出します。




→引数
1. [IN] 変数または、数値　：　hsid
　　形状データを識別するid



バージョン : ver5.0.3.4で追加

%index
E3DCreateSkinMat
影響度の編集結果を表示用データに反映させます。
%group
Easy3D For HSP3 : ボーン影響

%prm
p1,p2
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno

%inst
影響度の編集結果を表示用データに反映させます。

E3DSetInfElem, E3DDeleteInfElem, E3DNormalizeInfElem, E3DSetSymInfElemなどで影響度を全て編集し終わったら
この命令を呼んでください。





→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するID。

2. [IN] 数値または、変数　：　partno
　　パーツを識別するID。
　　-1を指定すると全てのパーツに対して処理を行います。



バージョン : ver5.0.3.7で追加

%index
E3DSetSymInfElem
CALCMODE_SYM（対称セット）で頂点のボーン影響度を設定します。
%group
Easy3D For HSP3 : ボーン影響

%prm
p1,p2,p3,p4,p5
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　partno
p3 : [IN] 数値または、変数　：　vertno
p4 : [IN] 数値または、変数　：　symaxis
p5 : [IN] 数値または、変数　：　symdist

%inst
CALCMODE_SYM（対称セット）で頂点のボーン影響度を設定します。

対称軸symaxis引数にはe3dhsp3.asで定義されているSYMAXIS_で始まる定数を使用してください。
SYMAXIS_XはX軸対称
SYMAXIS_YはY軸対称
SYMAXIS_ZはZ軸対称

この命令を呼んだだけでは表示には反映されません。
html{
<strong>影響度の編集がすべて終わったら、E3DCreateSkinMatを呼んで</strong>
}html表示に反映させてください。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するID。

2. [IN] 数値または、変数　：　partno
　　パーツを識別するID。
　　-1を指定すると全てのパーツに対して処理を行います。

3. [IN] 数値または、変数　：　vertno
　　頂点の番号。
　　-1を指定するとパーツ中のすべての頂点に対して処理を行います。

4. [IN] 数値または、変数　：　symaxis
　　対称軸をSYMAXIS_で始まる定数で指定します。

5. [IN] 数値または、変数　：　symdist
　　対称距離。
　　ぴったり対称な位置からどれくらい離れていても対称とみなすかを指定します。
　　実数。





バージョン : ver5.0.3.7で追加

%index
E3DUpdateSymInfElem
CALCMODE_SYM（対称設定）の設定してある頂点の影響度を最新の状態に更新します。
%group
Easy3D For HSP3 : ボーン影響

%prm
p1,p2
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　excludeflag

%inst
CALCMODE_SYM（対称設定）の設定してある頂点の影響度を最新の状態に更新します。

内部でCreateSkinMatも呼ばれます。



→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するID。

2. [IN] 数値または、変数　：　excludeflag
　　0を指定すると全てのパーツに対して処理を行います。１を指定するとE3DSetValidFlagで無効にしているパーツは除外して処理を行います。



バージョン : ver5.0.3.7で追加

%index
E3DSetJointInitialPos
ジョイント（ボーン）の初期位置をローカル座標系で設定します。
%group
Easy3D For HSP3 : モデル情報

%prm
p1,p2,p3,p4,p5,p6,p7
p1 : [IN] 数値または、変数　：　hsid
p2 : [IN] 数値または、変数　：　jointno
p3 : [IN] 数値または、変数　：　posx
p4 : [IN] 数値または、変数　：　posy
p5 : [IN] 数値または、変数　：　posz
p6 : [IN] 数値または、変数　：　calcflag
p7 : [IN] 数値または、変数　：　excludeflag

%inst
ジョイント（ボーン）の初期位置をローカル座標系で設定します。




→引数
1. [IN] 数値または、変数　：　hsid
　　形状データを識別するid

2. [IN] 数値または、変数　：　jointno
　　ジョイントを識別するパーツのid

3. [IN] 数値または、変数　：　posx
4. [IN] 数値または、変数　：　posy
5. [IN] 数値または、変数　：　posz
　　ジョイントの位置をローカル座標系で指定します。
　　実数。

6. [IN] 数値または、変数　：　calcflag
　　頂点の影響度の再計算をするときは１を、しないときは０を指定します。

7. [IN] 数値または、変数　：　excludeflag
　　calcflagに１を指定したときのみ意味を持ちます。
　　１を指定するとE3DSetValidFlagで無効にしているパーツの影響度は再計算しません。
　　０を指定すると無効にしているパーツも全て再計算の対象になります。



バージョン : 

