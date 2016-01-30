
■HSPをCGIとして動作させる環境を構築するには

CGIを動作させる実行環境を準備する必要があります。
HSPに限らずCGIを実行するには、Webサーバが必要となります。
ここでは、Windows上でサーバーを起動して実行を行なう方法について説明します。
CGIを実行させる場合は、HSPのソーススクリプト(.hsp)ではなく、
オブジェクトファイル(.ax)を設置する形で行ないます。

・フリーソフト「An HTTP Server」を利用したCGI実行環境

「An HTTP Server」の入手先
http://www.vector.co.jp/soft/win95/net/se044252.html

An HTTP Server のホームフォルダおよびWWWルートは「C:\httpd」とし、
CGIフォルダは「C:\httpd\cgi-bin」とします。

一般設定で、「cgiを実行する」許可を行ない、拡張子の登録を行ないます。
拡張子は、.ax
実行プログラムは、C:\hsp33\hsp3cl.exe
(C:\hsp33にHSP3.3がインストールされている場合)
(一般パスでも実行する、EXE形式の実行にチェックを入れます)

CGIの実行方法
An HTTP Server を稼動した状態でCGIフォルダ「cgi-bin」にオブジェクトファイル(.ax)を置き、
ブラウザを開いてアドレスバーにCGIをリクエストするURLを入力し、[Entet]キーで実行します。

リクエストURLの例：http://localhost/cgi-bin/hello.exe


・「Apache httpd」を利用したCGI実行環境

「Apache httpd」の入手先
http://httpd.apache.org/

設定ファイル httpd.conf に以下を追加

<Directory "C:\www/hspcgi/">
    Options +ExecCGI
    Allow from all
    AddHandler cgi-script .ax
    ScriptInterpreterSource Registry-Strict
</Directory>

「C:\www」をドキュメントルートとして設定されている場合、
「C:\www\hspcgi\」をHSPCGI実行用に設定します。

次に、レジストリエディタで.axの実行先を設定します。

[HKEY_CLASSES_ROOT]
以下に、以下のキーを作成します。

	.ax → shell → ExecCGI → command

commandの規定文字列(REG_SZ)に、以下を設定します。

C:\hsp33\hsp3cl.exe %1
(C:\hsp33にHSP3.3がインストールされている場合)

CGIの実行方法
Apache httpdを稼動した状態でCGIフォルダ「hspcgi」にオブジェクトファイル(.ax)を置き、
ブラウザを開いてアドレスバーにCGIをリクエストするURLを入力し、[Entet]キーで実行します。

リクエストURLの例：http://localhost/hspcgi/hello.ax

