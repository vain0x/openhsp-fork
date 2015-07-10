%dll
hsp3imp

%ver
3.3

%date
2009/08/01

%author
onitama

%url
http://hsp.tv/

%note
hsp3imp.asをインクルードすること。

%type
拡張命令

%group
拡張入出力制御命令

%port
Win
%index
hspini 
HSP3IMP.DLLの初期化

%prm
mode,xsize,ysize,handle
mode : 初期化モード($100=子ウィンドウとして初期化)
       bit0 = window非表示(ON/OFF)
       bit1 = カレントディレクトリ変更禁止(ON/OFF)

xsize  : HSPの初期化ウィンドウサイズ(X)
ysize  : HSPの初期化ウィンドウサイズ(Y)
handle : 親のウィンドウハンドル(HWND)

%inst
HSP3IMP.DLLを初期化します。
HSP3の初期化と、オブジェクトファイルの読み込みを行ないます。
hspiniを実行する前に、hspprm命令によって各種設定を行なっておく必要があります。

%index
hspbye
初期化されたHSP3のインスタンスの破棄

%prm

%inst
hspini命令によって初期化されたHSP3のインスタンスを破棄します。
最後に必ず実行して、HSP3の終了処理を行なう必要があります。

%index
hspexec
HSP3のタスクの実行

%prm

%inst
hspini命令によって初期化されたHSP3のタスクを実行します。
hspexec命令は、実行したコードが終了するか、エラーが発生するまで戻ってきません。(その間は、HSP3のタスクが動作します。)
HSP3IMP.DLLは、あくまでもシングルタスクとして動作することを前提としているので注意してください。

%index
hspprm
HSP3IMP.DLLに関する設定と情報の取得

%prm
p1,p2,p3,p4
p1         : 設定または取得のモード
p2, p3, p4 : p1 に応じたパラメーター

%inst
HSP3IMP.DLLに関する設定および、情報の取得を行ないます。
p1の値によって、p2～p4までに指定する内容が変わります。
設定されるパラメーターは、以下を参考にしてください。

p1(mode)
-----------------------------------------------------------
    0        親ウィンドウからの表示オフセット指定
             (p2,p3でX,Yオフセット値を設定します)
    1        起動パラメーター指定(HSPTVでのみ使用します)
0x100        HSPCTX構造体のポインタを取得
             (結果がp4で指定されたアドレスに書き込まれます)
0x101        拡張命令を初期化するための関数指定
             (p4にHSP3TYPEINFOポインタを引数とする関数を登録します)
0x102        HSP3オブジェクトファイル名を指定
             (p4にファイル名が格納されているアドレスを設定)