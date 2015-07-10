%dll
hspusbio

%ver
0.30

%date
2007/05/14

%author
K-K

%url
http://www.binzume.net/

%note
hspusbio.asまたはmod_usbio.asをインクルードして使用します。

%type
ユーザー拡張命令

%index
uio_find
USB-IOを検索・初期化
%group
USBデバイス制御命令
%inst
ディバイスの中からUSB-IOを検索・初期化します．
失敗するとシステム変数statにエラーコードが帰ります．
^p
  stat : エラー内容
 ----------------------------------------------------
   0   : 正常
   1   : 必要なドライバが無い(まだUSB-IOを繋いだことが無い場合など)
   2   : USB-IOが繋がってない
^p

%href
uio_free


%index
uio_free
USB-IOを解放
%group
USBデバイス制御命令
%inst
USB-IOを解放します．
HSPの終了時に自動的に呼び出されますが，手動で呼び出しても害はありません．

%href
uio_find


%index
uio_getdevs
USB-IOの接続数を取得
%group
USBデバイス制御命令
%inst
繋がれているUSB-IOの数をシステム変数statに返します．

%href
uio_seldev


%index
uio_seldev
複数のUSB-IOから選択
%group
USBデバイス制御命令
%prm
p1
p1(0) : 番号(0～uio_getdevsで得た値)
%inst
複数のUSB-IOが繋がれている場合に何番目を使うかを指定します．

%href
uio_getdevs


%index
uio_out
USB-IOデータ出力
%group
USBデバイス制御命令
%prm
p1,p2,p3
p1(0) : 出力するI/Oポートアドレス(0～1)
p2(0) : 出力する内容(8ビット)
p3(0) : モード
%inst
USB-IOに任意のデータを出力します．
失敗するとシステム変数statに1が返ります．
p3に1を指定すると，ポート1のp1にパルスを送りポート0を書き換えます．

%href
uio_inp


%index
uio_inp
USB-IOデータ読み込み
%group
USBデバイス制御命令
%prm
p1,p2,p3
p1    : データを読み込む変数
p2(0) : I/Oポートアドレス(0～1)
p3(0) : モード
%inst
USB-IOからデータを入力します．
失敗するとシステム変数statに0以外の値が返ります．
p3に1を指定すると，ポート1のp1にパルスを送りポート0から読み込みます．

%href
uio_out


