;
;	HSP help manager用 HELPソースファイル
;	(先頭が「;」の行はコメントとして処理されます)
;

%type
ユーザー拡張命令
%ver
3.3
%note
llmod3.hspをインクルードする

%date
2009/08/01
%author
tom
%dll
llmod3
%url
http://www.s-software.net/


%index
getptr
変数のポインタを取得する
%group
メモリ管理命令
%prm
v1,v2
v1 : ポインタを代入する変数
v2 : ポインタを取得する変数
%inst
変数v2のポインタを取得し、変数v1に代入します。
取得したポインタはdllへ渡すパラメータなどに使用できます。





%index
dllproc
外部dllの関数を呼び出す
%group
拡張入出力制御命令
%prm
"s1",v2,n3,n4
s1 : 関数名
v2 : 関数に渡すパラメータが代入された変数
n3 : 関数に渡すパラメータの数
n4 : dllのインスタンス

%inst
n4に指定したdll内のs1の関数を使用します。
関数の返り値はシステム変数statに代入されます。
llmod3内では主用なdllがロードされていて、そのdllを使用する場合はn4に以下の数値を使用できます。
^p
DLL名          数値(defineされている名前)
kernel32.dll   0 (D_KERNEL)
user32.dll     1 (D_USER)
shell32.dll    2 (D_SHELL)
comctl32.dll   3 (D_COMCTL)
comdlg.dll     4 (D_COMDLG)
gdi32.dll      5 (D_GDI)
^p

%href
ll_libload
ll_libfree
getptr

%sample
	;例1
	ll_libload dll,"user32"		;user32.dllをロード
	s="test"
	getptr p,s
	prm=0, p, p, 0
	dllproc "MessageBoxA", prm, 4, dll
	mes dllret
	ll_libfree dll
	end
^
	;例2
	s="test2"
	getptr p, s
	prm=0, p, p, 0
	dllproc "MessageBoxA", prm, 4, D_USER
	mes dllret



%index
_makewnd
WinAPIのCreateWindowAを呼び出す
%group
OSシステム制御命令
%prm
v1, "s2"
v1 : CreateWindowに渡すパラメータが代入された変数
s2 : ウィンドウのクラス名
%inst
v1に代入されたパラメータを使用してCreateWindowAを呼び出します。
v1にはx座標, y座標, 幅, 高さ, スタイル, 親ウィンドウのハンドル, dwExStyleの順にパラメータを代入します。
s2は作成するウィンドウのクラス名です。
作成したウィンドウのハンドルはv1に代入されます。
親ウィンドウのハンドルを0にすると_makewndが呼ばれたとき操作対象になっているウィンドウのハンドルが使用されます。
%sample
	prm = csrx, csry, 200, 30, $50000000, 0, $200
	_makewnd prm,"msctls_trackbar32"
	handle_of_track=prm
	stop



%index
_objsel
llmod3のモジュールで作成したオブジェクトをアクティブにする
%group
オブジェクト制御命令
%prm
n1
n1 : アクティブにするオブジェクトのID
%inst
n1に指定したオブジェクトをアクティブにします。
n1を-1にすると現在アクティブになっているオブジェクトのIDを
statに代入します。



%index
_clrobj
llmod3のモジュールで作成したオブジェクトを消去する
%group
オブジェクト制御命令
%prm
n1
n1 : 消去するオブジェクトのID

%inst
llmod3のモジュールで作成したlistview,progbox,trackbox,treebox,udbtnなどのオブジェクトを消去します。
^
※llmod3で作成したオブジェクトはHSP標準命令のcls、screenなどで消去されません。
これらの命令を使用したときは_cls、_clrobjを使用してください。
%href
_cls
listview
progbox
trackbox
treebox
udbtn




%index
_cls
llmod3のモジュールで作成したものを含む全てのオブジェクトを消去する
%group
オブジェクト制御命令
%prm
n1
n1 : clsに渡すパラメータ

%inst
llmod3のモジュールで作成したlistview,progbox,trackbox,treebox,udbtnなどのオブジェクトとHSP標準命令で作成したオブジェクトを全て消去します。
n1は_clsの内部で呼び出されているHSP標準命令のclsに渡すパラメータとして使用されます。
^
※llmod3で作成したオブジェクトはHSP標準命令のcls、screenなどで消去されません。
これらの命令を使用したときは_cls、_clrobjを使用してください。
%href
_clrobj
listview
progbox
trackbox
treebox
udbtn




%index
charupper
WinAPIのCharUpperAを使い変数内の英字を大文字に変換する
%group
文字列操作命令
%prm
v1
v1 : CharUpperに渡す文字列変数

%inst
変数内の英字を大文字に変換します。



%index
charlower
WinAPIのCharLowerAを使い変数内の英字を大文字に変換する
%group
文字列操作命令
%prm
v1
v1 : CharLowerに渡す文字列変数

%inst
変数内の英字を小文字に変換します。

