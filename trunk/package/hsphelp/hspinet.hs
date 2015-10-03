;
;	HSP help manager用 HELPソースファイル
;	(先頭が「;」の行はコメントとして処理されます)
;

%type
拡張命令
%ver
3.1
%note
hspinet.asをインクルードすること。

%date
2005/06/28
%author
onitama
%dll
hspinet
%url
http://www.onionsoft.net/hsp/
%port
Win


%index
netinit
ネット接続の初期化
%group
拡張入出力制御命令
%inst
Wininet.dllの初期化を行ないます。
net～で始まる命令を使用する際には、最初に１回だけ必ず実行する必要があります。
実行後に結果がシステム変数statに格納されます。
0ならば正常終了、それ以外はエラーが発生したことを示しています。
%href
netterm



%index
netterm
ネット接続の終了
%group
拡張入出力制御命令
%inst
Wininet.dllの終了処理を行ないます。
通常、この命令はプログラム終了時に自動的に呼び出されるため、特にスクリプトに記述する必要はありません。
%href
netinit



%index
netexec
最小単位の処理を実行
%group
拡張入出力制御命令
%prm
p1
p1 : 処理の結果が代入される変数

%inst
最小単位の処理を実行します。
サーバーからの応答待ちや、ダウンロード中など時間のかかる処理を細かい単位で実行します。
メインプログラムでは、await命令などで細かく待ち時間(ウェイト)を取りながらnetexec命令を呼び出す必要があります。
^p
例:
	;	結果待ちのためのループ
	repeat
	netexec res
	if res : break
	await 50
	loop
^p
実行後、結果がp1で指定された変数に代入されます。
内容が0の場合は、処理が継続中であることを意味します。
内容が1の場合は、処理が正常に終了していることを意味します。
内容がマイナス値の場合は、何らかのエラーが発生したことを示しています。
statが0以外の値になった場合は、それに応じた処理を適宜スクリプト側で処理するようにしてください。

%href
netmode
netsize



%index
netmode
モードの取得
%group
拡張入出力制御命令
%prm
p1
p1 : モード値が代入される変数

%inst
現在の処理モードを取得します。
p1で指定された変数にモード値が代入されます。
モード値の内容は以下の通りです。
httpリクエストは、INET_MODE_READYの状態で発行するようにしてください。
ftpリクエストは、INET_MODE_FTPREADYの状態で発行するようにしてください。
^p
ラベル             | 値    状態
------------------------------------------------------
INET_MODE_NONE     |  0    未初期化の状態
INET_MODE_READY    |  1    待機状態
INET_MODE_REQUEST  |  2    httpリクエスト受付
INET_MODE_REQSEND  |  3    httpリクエスト送信中
INET_MODE_DATAWAIT |  4    httpデータ受信中
INET_MODE_DATAEND  |  5    httpデータ受信終了処理中
INET_MODE_INFOREQ  |  6    http情報リクエスト送信中
INET_MODE_INFORECV |  7    http情報データ受信中
INET_MODE_FTPREADY |  8    ftp待機状態
INET_MODE_FTPDIR   |  9    ftpディレクトリ情報取得中
INET_MODE_FTPREAD  |  10   ftpファイル受信中
INET_MODE_FTPWRITE |  11   ftpファイル送信中
INET_MODE_FTPCMD   |  12   ftpコマンド送信終了処理中
INET_MODE_FTPRESULT|  13   ftpサーバー返信データ受信中
INET_MODE_ERROR    |  14   エラー状態
^p

%href
netexec



%index
neterror
ネットエラー文字列の取得
%group
拡張入出力制御命令
%prm
p1
p1 : エラー文字列が代入される変数

%inst
エラー発生時の詳細を示す文字列を取得します。
p1で指定した変数に、文字列として代入されます。



%index
neturl
URLの設定
%group
拡張入出力制御命令
%prm
"URL"
"URL" : URLを示す文字列

%inst
httpリクエストを行なうURLを設定します。
URLは、ファイル名を除いた形でスキーム名を含めて設定する必要があります。
「http://www.onionsoft.net/hsp/index.html」の場合は、「http://www.onionsoft.net/hsp/」までを設定してください。
httpリクエストは必ず、neturl命令によるURL設定を先に行なっておいてください。neturl命令実行の時点では、まだhttpリクエストは発行されません。
httpリクエストの発行は、netrequest命令またはnetload命令によって行なわれます。
%href
netrequest
netload
netfileinfo



%index
netrequest
httpリクエスト発行
%group
拡張入出力制御命令
%prm
"FileName"
"FileName" : リクエストを行なうファイル名

%inst
httpリクエストを行ないます。
先に、neturl命令によりファイル名を除いたURLを指定しておく必要があります。
netrequest命令でhttpリクエストを発行した後は、netexec命令により受信処理をスクリプト側で行なう必要があります。
受信処理を自動で行なうためのnetload命令も別途用意されています。
%href
neturl
netload
netfileinfo



%index
netload
httpファイル取得
%group
拡張入出力制御命令
%prm
"FileName"
"FileName" : リクエストを行なうファイル名

%inst
httpリクエストを行ないます。
先に、neturl命令によりファイル名を除いたURLを指定しておく必要があります。
netload命令は、ファイルの取得が終了するまで、処理を中断します。
手軽にファイルの取得を行なうことが可能ですが、大きなファイルや受信状態の悪い場合などは、そのまま画面が停止したままになる可能性もあるので注意してください。
ファイルの受信中に、並行して別な処理を行ないたい場合には、netrequest命令を使用してhttpリクエストを行なってください。
%href
neturl
netrequest
netfileinfo



%index
netfileinfo
httpファイル情報取得
%group
拡張入出力制御命令
%prm
p1,"FileName"
p1         : ファイル情報が代入される変数名
"FileName" : リクエストを行なうファイル名

%inst
httpサーバー上にあるファイル情報を取得します。
先に、neturl命令によりファイル名を除いたURLを指定しておく必要があります。
取得に成功すると、システム変数statの値が0となり、p1で指定した変数に文字列型でサーバーが返した情報文字列が代入されます。
取得に失敗した場合は、システム変数statに0以外が代入されます。
サーバーが返す情報の種類は、httpサーバーによって異なります。
詳しくは、RFCなどhttpプロトコルの解説を参照してください。
netfileinfo命令は、ファイルの取得が終了するまで、処理を中断します。
%href
neturl
netload



%index
netdlname
ダウンロード名の設定
%group
拡張入出力制御命令
%prm
"FileName"
"FileName" : ダウンロードされた時のファイル名

%inst
ファイルを取得する際のファイル名を設定します。
netdlname命令によってファイル名を設定していない場合は、httpリクエストを行なったファイル名が使用されます。
netdlname命令に、空の文字列("")を指定した場合も、httpリクエストを行なったファイル名が使用されます。
%href
netrequest
netload



%index
netproxy
プロキシの設定
%group
拡張入出力制御命令
%prm
"ServerName",p1,p2
"ServerName" : リクエストを行なうファイル名
p1 (0)       : ポート番号
p2 (0)       : ローカル接続フラグ

%inst
http接続の際に使用されるプロキシ(代理)サーバーを設定します。
"ServerName"で、プロキシサーバー名を設定します。
空の文字列("")を指定した場合には、プロキシは設定されません。
p1でhttpが使用するプロキシサーバーのポート番号を指定します。
p2で、ローカルアドレスをプロキシ経由のアクセスから除外するかどうかを設定します。1の場合は、ローカルアドレスのみプロキシから除外されます。0の場合は、ローカルアドレスも含めてプロキシを使用します。
netproxy命令が実行されると、それまでのセッションが解除され、neturl命令や、netheader命令による設定はリセットされます。
^p
	例:
	netinit
	if stat : dialog "ネット接続できません。" : end
	netproxy "proxy_server",8080,1
	neturl "http://www.onionsoft.net/hsp/"
	netload "index.html"
^p
%href
netagent
netheader



%index
netagent
エージェントの設定
%group
拡張入出力制御命令
%prm
"AgentName"
"AgentName" : 設定するエージェント名

%inst
http接続の際にサーバーに渡されるエージェント情報の文字列を設定します。"AgentName"で指定したエージェント名が設定されます。
空の文字列("")を指定した場合には、デフォルトの設定になります。
netagent命令が実行されると、それまでのセッションが解除され、neturl命令や、netheader命令による設定はリセットされます。
%href
netproxy
netheader



%index
netheader
ヘッダ文字列の設定
%group
拡張入出力制御命令
%prm
"HeaderString"
"HeaderString" : ヘッダに追加される文字列

%inst
http接続の際にサーバーに渡されるヘッダ文字列を設定します。
空の文字列("")を指定した場合には、無設定になります。
ヘッダ文字列は、通常設定する必要ありませんが、何からの付加情報や動作設定を行なう場合に使用することができます。
netheader命令で設定したヘッダ文字列は、それ以降のリクエストすべてに適用されます。
^p
	例:
	; リファラーを追加する
	netheader "Referer:http://www.onionsoft.net/\n\n"
^p
%href
netagent



%index
netsize
ファイル受信サイズの取得
%group
拡張入出力制御命令
%prm
p1
p1 : ファイル受信サイズが代入される変数

%inst
netrequest命令で発行されたhttpリクエストに対するファイルがどれだけのサイズを受信したかを取得します。
p1で指定された変数にファイル受信サイズが代入されます。
ファイル受信サイズは、netexec命令で受信が行なわれた内容を調べるためのものです。あらかじめ、ファイル情報取得でファイルサイズを調べておけば、進行の割合を計ることが可能です。
%href
netexec



%index
filecrc
ファイルのCRC32を取得
%group
拡張入出力制御命令
%prm
p1,"FileName"
p1         : CRC値が代入される変数名
"FileName" : CRCチェックを行なうファイル名

%inst
指定されたファイルのCRC32を求めてp1の変数に代入します。
CRC32は、ファイルの内容をもとに算出された32bitの数値です。
ファイル内容のチェックなどに使用することができます。
%href
filemd5



%index
filemd5
ファイルのMD5を取得
%group
拡張入出力制御命令
%prm
p1,"FileName"
p1         : MD5値が代入される変数名
"FileName" : MD5チェックを行なうファイル名

%inst
指定されたファイルのMD5を求めてp1の変数に代入します。
MD5値は、文字列型で「f96b697d7cb7938d525a2f31aaf161d0」のような32文字の16進数として表現されます。
MD5値は、ファイルの内容を一意に表わすハッシュ値として使用することができます。詳しくは、MD5についての資料などを参照してください。
ファイル内容のチェックなどに使用することができます。
%href
filecrc



%index
ftpopen
FTPセッションの開始
%group
拡張入出力制御命令
%prm
p1,p2,p3,p4
p1 : ftpサーバーアドレス(文字列)
p2 : ftpログインユーザー名(文字列)
p3 : ftpログインユーザーパスワード(文字列)
p4 : ポート番号(省略可能)

%inst
ftpサーバーに接続してセッションを開始します。
p1にサーバーのアドレス、p2にユーザー名、p3にパスワードを指定してftpに接続します。
p4パラメーターでポート番号を指定することができます。
p4の指定を省略した場合は、標準のポート番号が使用されます。
実行に成功した場合は、システム変数statに0が代入され、失敗した場合はそれ以外の値が代入されます。
あらかじめ、netinit命令によって初期化を行なう必要があります。
ftpセッションを開始した後は、ftp関連命令のみ使用することができます。httpなど他のネット操作を行なう場合には、必ずftpclose命令によりftpセッションを終了させるようにしてください。

%href
ftpclose


%index
ftpclose
FTPセッションの終了
%group
拡張入出力制御命令

%inst
ftpopen命令で開始されたセッションを終了させます。

%href
ftpopen


%index
ftpresult
FTP処理結果文字列の取得
%group
拡張入出力制御命令
%prm
p1
p1 : FTP処理結果文字列が代入される変数

%inst
ftp関連命令による処理に対するサーバーの返信メッセージを
取得して、p1に指定された変数に代入します。
p1の変数には、文字列データとして代入されます。
この命令は、必ずftpopen命令によりftpセッションを開始してから使用してください。

%href
ftpopen


%index
ftpdir
FTPディレクトリ移動
%group
拡張入出力制御命令
%prm
p1,p2
p1 : 現在のディレクトリ位置が代入される変数
p2 : 移動先のディレクトリ名(文字列)

%inst
p1で指定した変数に、ftpサーバー上のカレントディレクトリ名を文字列データとして代入します。
p2にディレクトリ名を指定した場合には、その場所へ移動を行ないます。
p2の指定を省略した場合には、ディレクトリ移動は行なわれません。
実行に成功した場合は、システム変数statに0が代入され、失敗した場合はそれ以外の値が代入されます。
この命令は、必ずftpopen命令によりftpセッションを開始してから使用してください。

%href
ftpopen


%index
ftpdirlist
FTPディレクトリリスト取得1
%group
拡張入出力制御命令

%inst
ftpサーバー上のカレントディレクトリにあるファイルリストを取得するためのリクエストを行ないます。
実際のファイルリストは、ftpdirlist2命令で行ないます。
実行に成功した場合は、システム変数statに0が代入され、失敗した場合はそれ以外の値が代入されます。
この命令は、必ずftpopen命令によりftpセッションを開始してから使用してください。

%href
ftpopen
ftpdirlist2


%index
ftpdirlist2
FTPディレクトリリスト取得2
%group
拡張入出力制御命令
%prm
p1
p1 : ファイルリストが代入される変数

%inst
この命令は、必ずftpopen命令によりftpセッションを開始し、ftpdirlist命令によりファイルリスト取得が終了した後で使用してください。
以下は、ファイルリスト取得するまでの例です。
^p
例:
	;	結果待ちのためのループ
	ftpdirlist
	repeat
	netexec mode
	if res : break
	await 50
	loop
	ftpdirlist2 res
^p
ファイルリスト取得は、ftpdirlist命令によるリクエスト、netexec命令による受信待ち、ftpdirlist2命令による結果の取得という３つの手順に分けて行なう必要があります。
p1に代入されるファイルリストは、１行あたり１エントリごとに区切られている複数行文字列データになります。
１行は、「"ファイル名"」、ファイルサイズ、更新日時の順番に「,」で区切られた形になります。

%href
ftpopen
ftpdirlist
netexec


%index
ftpcmd
FTPコマンドの実行
%group
拡張入出力制御命令
%prm
p1
p1 : 実行するFTPコマンド文字列

%inst
p1で指定されたFTPコマンドを実行します。
実行に成功した場合は、システム変数statに0が代入され、失敗した場合はそれ以外の値が代入されます。
この命令は、必ずftpopen命令によりftpセッションを開始してから使用してください。

%href
ftpopen


%index
ftprmdir
FTPディレクトリの削除
%group
拡張入出力制御命令
%prm
p1
p1 : 削除するディレクトリを示す文字列

%inst
p1で指定されたディレクトリを削除します。
実行に成功した場合は、システム変数statに0が代入され、
失敗した場合はそれ以外の値が代入されます。
この命令は、必ずftpopen命令によりftpセッションを開始してから使用してください。

%href
ftpopen
ftpmkdir


%index
ftpmkdir
FTPディレクトリの作成
%group
拡張入出力制御命令
%prm
p1
p1 : 作成するディレクトリを示す文字列

%inst
p1で指定されたディレクトリを作成します。
実行に成功した場合は、システム変数statに0が代入され、失敗した場合はそれ以外の値が代入されます。
この命令は、必ずftpopen命令によりftpセッションを開始してから使用してください。

%href
ftpopen
ftprmdir


%index
ftpget
FTPファイル取得
%group
拡張入出力制御命令
%prm
p1,p2,p3
p1     : サーバー上から取得するファイル名(文字列)
p2("") : ローカルに作成されるファイル名(文字列)
p3(0)  : 転送モード(0=バイナリ/1=アスキー)

%inst
ftpサーバー上のファイルを取得します。
p1でサーバー上のファイル名を指定します。
p2でダウンロードして作成されるファイル名を指定します。
p2の指定を省略または""にした場合は、p1と同じ名前が使用されます。
p3で転送モードを指定します。転送モードを省略または0に指定した場合はバイナリデータとして、1に指定した場合は、アスキーデータとして転送を行ないます。
実行に成功した場合は、システム変数statに0が代入され、失敗した場合はそれ以外の値が代入されます。
この命令は、必ずftpopen命令によりftpセッションを開始してから使用してください。

%href
ftpopen
ftpput


%index
ftpput
FTPファイル送信
%group
拡張入出力制御命令
%prm
p1,p2,p3
p1     : サーバー上に作成するファイル名(文字列)
p2("") : ローカルから送信されるファイル名(文字列)
p3(0)  : 転送モード(0=バイナリ/1=アスキー)

%inst
ftpサーバー上にファイルを送信します。
p1でサーバー上に作成するファイル名を指定します。
p2でローカルから送信されるファイル名を指定します。
p2の指定を省略または""にした場合は、p1と同じ名前が使用されます。
p3で転送モードを指定します。転送モードを省略または0に指定した場合はバイナリデータとして、1に指定した場合は、アスキーデータとして転送を行ないます。
実行に成功した場合は、システム変数statに0が代入され、失敗した場合はそれ以外の値が代入されます。
この命令は、必ずftpopen命令によりftpセッションを開始してから使用してください。

%href
ftpopen
ftpget


%index
ftprename
FTPファイル名前変更
%group
拡張入出力制御命令
%prm
p1,p2
p1 : 変更元のファイル名(文字列)
p2 : 新しいファイル名(文字列)

%inst
ftpサーバー上のファイル名を変更します。
p1で変更元のファイル名を、p2で新しいファイル名を指定します。
実行に成功した場合は、システム変数statに0が代入され、失敗した場合はそれ以外の値が代入されます。
この命令は、必ずftpopen命令によりftpセッションを開始してから使用してください。

%href
ftpopen
ftpdelete


%index
ftpdelete
FTPファイル削除
%group
拡張入出力制御命令
%prm
p1
p1 : 削除するファイル名(文字列)

%inst
ftpサーバー上のファイルを削除します。
実行に成功した場合は、システム変数statに0が代入され、失敗した場合はそれ以外の値が代入されます。
この命令は、必ずftpopen命令によりftpセッションを開始してから使用してください。

%href
ftpopen
ftprename


