;--------------------------------------------------
; SQLele help
;--------------------------------------------------

%dll
SQLele

%ver
1.15

%date
2010/02/22

%author
S.Programs

%url
http://sprocket.babyblue.jp/

%note
sqlele.hsp をインクルードして使用します。実行には sqlite3.dll が必要です。

%type
ユーザー拡張命令

%index
prm_blob
変数を BLOB 型データの SQL パラメータとして指定

%prm
(v1, p1)
v1 : BLOB 型パラメータとして与える変数
p1 : 変数のデータサイズ (バイト数)

%inst
この関数は、変数バッファを BLOB 型データとして SQL 文のパラメータにするために使用します。sql_q 命令の引数文字列専用です。

この関数で設定したパラメータは、sql_q 命令の実行時にバインド変数として扱われます。

%href
sql_q

%sample
	...

	sql_q "INSERT INTO Tbl (v1, v2, v3) VALUES ("+prm_blob(v1, n1)+","+prm_blob(v2, n2)+","+prm_blob(v3, n3)+")"

%group
パラメータ用関数

%index
sql_q
SQL ステートメントを実行

%prm
"p1", v1
"p1"	: 実行する SQL 文
v1	: 対象レコードセット変数 (省略値 tmparr)

%inst
SQL 文を実行します。

p1 で、実行する SQL 文を指定します。

v1 で、結果データを受け取るレコードセット変数を指定します。

SELECT 文などで結果となるレコードセットがある場合、レコードセット変数にレコードデータが取得されます。システム変数 stat には、レコードの行数が返ります。stat が 0 の場合は、レコードがなかったことを表します。

「レコードセット変数」は、2 次元の文字列バッファの配列として初期化されます。この配列変数には、出力データや型情報、カラム名などが格納されています。レコードセット変数は文字列配列として直接参照できるほか、sql_v() を使用すればカラム名を使ったデータ参照ができ、sql_type() を使用すれば元のデータ型を取得することができます。

v1 を省略した場合は、マクロにより変数名 tmparr が設定されます。SQLele のすべての命令・関数では、レコードセット変数の指定を省略した場合、tmparr という変数名が与えられます。そのため、多くの場合レコードセット変数の指定を省略することができます。

p1 で与えるパラメータにバインドを使用する場合は、prm_i(), prm_f(), prm_text(), prm_blob() 関数を使用します。これにより、処理の効率化を図ることができます。

sql_q 命令を実行するためには、sql_open 命令でデータベースが開かれている必要があります。

他のプロセスのトランザクションによってロックされたデータベースに書き込もうとした場合は、ロックが解除されるまで待ってから書き込みが実行されます。

(資料) レコードセット変数のフォーマット
データ文字列     = v1(column [0～], record [0～stat-1])
カラム名         = v1(column [0～], stat)
型               = lpeek(v1(column, record), strlen(v1(column, record)) + 4)
レコードカウンタ = lpeek(v1(0, 0), strlen(v1(0, 0)) + 8)
BLOB サイズ      = lpeek(v1(column, record), strlen(v1(column, record)) + 12)
BLOB データ      = v1(column, record) 16 バイト目以降
レコード数       = length2(v1) - 1
カラム数         = length(v1)

%href
sql_v
sql_i
sql_f
sql_type
prm_i
prm_f
prm_text
prm_blob

%sample
	...

	sql_q "SELECT ID, Val FROM [テーブル]"
	count = stat

	mes "件数 = " + count
	repeat count
		mes "ID = " + sql_v("ID") + " / Val = " + sql_v("Val")
		sql_next
	loop

%group
データベース操作

%index
prm_f
浮動小数点数を SQL パラメータとして指定

%prm
(p1)
p1 : パラメータとして与える浮動小数点数

%inst
この関数は、浮動小数点数を SQL 文のパラメータにするために使用します。sql_q 命令の引数文字列専用です。

この関数で設定したパラメータは、sql_q 命令の実行時にバインド変数として扱われます。

%href
sql_q

%sample
	...

	sql_q "INSERT INTO Tbl (f1, f2, f3) VALUES ("+prm_f(0.0)+","+prm_f(1.0)+","+prm_f(2.0)+")"

%group
パラメータ用関数

%index
prm_i
整数を SQL パラメータとして指定

%prm
(p1)
p1 : パラメータとして与える整数

%inst
この関数は、整数を SQL 文のパラメータにするために使用します。sql_q 命令の引数文字列専用です。

この関数で設定したパラメータは、sql_q 命令の実行時にバインド変数として扱われます。

%href
sql_q

%sample
	...

	sql_q "INSERT INTO Tbl (i1, i2, i3) VALUES ("+prm_i(0)+","+prm_i(1)+","+prm_i(2)+")"

%group
パラメータ用関数

%index
prm_text
文字列変数をテキスト型の SQL パラメータとして指定

%prm
(v1)
v1 : テキスト型パラメータにする変数

%inst
この関数は、文字列型の変数をテキストデータとして SQL 文のパラメータにするために使用します。sql_q 命令の引数文字列専用です。

この関数で設定したパラメータは、sql_q 命令の実行時にバインド変数として扱われます。SQL 文に直接文字列を入れるより高速に処理されます。シングルクォーテーションで囲まずに使用してください。

%href
sql_q
sqesc

%sample
	...

	sql_q "INSERT INTO Tbl (s1, s2, s3) VALUES ("+prm_text(s1)+","+prm_text(s2)+","+prm_text(s3)+")"

%group
パラメータ用関数

%index
sql_f
レコードセット変数から double としてデータ取得

%prm
("p1", v1)
"p1"	: カラム名
v1	: 対象レコードセット変数 (省略値 tmparr)

%inst
レコードセット変数から、カラム名を指定して (元のデータの型に関係なく) 浮動小数点数としてデータを参照します。

参照するレコードを次へ進めるときは、sql_next 命令を使用します。


%href
sql_q
sql_next
sql_v
sql_i
sql_type

%group
レコードセット操作

%index
sql_i
レコードセット変数から int としてデータ取得

%prm
("p1", v1)
"p1"	: カラム名
v1	: 対象レコードセット変数 (省略値 tmparr)

%inst
レコードセット変数から、カラム名を指定して (元のデータの型に関係なく) 整数値としてデータを参照します。

参照するレコードを次へ進めるときは、sql_next 命令を使用します。


%href
sql_q
sql_next
sql_v
sql_f
sql_type

%sample
	...

	sql_q "SELECT ID, ...", tmparr

	id = sql_i("ID")

%group
レコードセット操作

%index
sql_type
レコードセット変数からデータの型を取得

%prm
("p1", v1)
"p1"	: カラム名
v1	: 対象レコードセット変数 (省略値 tmparr)

%inst
レコードセット変数から、カラム名を指定してデータの型を取得します。

sql_q 命令で取得されるレコードセット変数は文字列型の配列になるため、元の型を知りたい場合はこの関数で調べます。値の意味は、下記のようになります。

type = sql_type("Col name", arr)

type == SQLITE_INTEGER	-> INTEGER 型
type == SQLITE_FLOAT	-> FLOAT 型
type == SQLITE_TEXT	-> TEXT 型
type == SQLITE_BLOB	-> BLOB 型
type == SQLITE_NULL	-> NULL

SQLite では、同じカラムのデータでもレコードによって異なる型を持つことができます。

参照するレコードを次へ進めるときは、sql_next 命令を使用します。

%href
sql_q
sql_next
sql_v
sql_i
sql_f

%group
レコードセット操作

%index
sql_v
レコードセット変数のデータを参照

%prm
("p1", v1)
"p1"	: カラム名
v1	: 対象レコードセット変数 (省略値 tmparr)

%inst
レコードセット変数から、カラム名を指定してデータを参照します。この関数型マクロは、変数として参照可能な形で展開されます。

データの型は、元のデータ型に関係なく文字列型となります。元の型を知りたい場合は、sql_type() を使用します。

このマクロは変数として展開されるため、下記のように引数に文字列型変数を要求する標準関数でそのまま使用できます。

i = instr(sql_v("hoge"), 0, "srch")
s = strmid(sql_v("hoge"), 0, 99)

参照するレコードを次へ進めるときは、sql_next 命令を使用します。


(資料) マクロの仕様
展開前 : sql_v("Col", arr)
展開後 : arr(sql_colid("Col", arr), [レコードカウンタ])

%href
sql_q
sql_next
sql_i
sql_f
sql_type

%sample
	; フル引数
	sql_q "SELECT * FROM ...", tmparr
	repeat stat
		mes sql_v("col1", tmparr) + "/" +  sql_v("col2", tmparr)
		sql_next tmparr
	loop

	↓

	; 引数省略
	sql_q "SELECT * FROM ..."
	repeat stat
		mes sql_v("col1") + "/" +  sql_v("col2")
		sql_next
	loop

%group
レコードセット操作

%index
sqesc
シングルクォーテーション エスケープ

%prm
("p1")
"p1" : 変換する文字列

%inst
この関数は、文字列中のシングルクォーテーションをすべて 2 連続にした値を返します。

例 : "let's go" → "let''s go"

SQL 文で使用するシングルクォーテーション括りの文字列リテラルでは、文字列の中身にシングルクォーテーションが含まれる場合、それを 2 連続とすることによってエスケープする必要があります。

SQL 文に単純に文字列変数を挿入する場合は、より高速な prm_text() を使用することができます。

%href
prm_text

%sample
	...

	sql_q "SELECT ... WHERE [備考] like '%"+sqesc(srch)+"%')"

%group
パラメータ用関数
%index
sql_next
次のレコードへ移動

%prm
v1
v1 : 対象レコードセット変数 (省略値 tmparr)

%inst
レコードセット変数 v1 のレコードカウンタを 1 つ進めます。

レコードカウンタとはレコードセット変数に記録されているカウンタで、sql_v(), sql_i() などのデータ取得関数で取り出されるレコードの位置を示すものです。

実際のレコード数以上にカウンタを進めた場合、エラーとなります。

%href
sql_move
sql_v
sql_i
sql_f
sql_type
sql_blobsize
sql_blobcopy

%sample
	...

	sql_q "SELECT * FROM ..."
	repeat stat
		mes sql_v("Column")
		sql_next
	loop

%group
レコードセット操作

%index
sql_blobcopy
BLOB データを変数にコピー

%prm
v1, "p1", v2
v1	: 値を受け取る変数
"p1"	: カラム名
v2	: 対象レコードセット変数 (省略値 tmparr)

%inst
レコードセット変数から、カラム名を指定して BLOB データを別の変数にコピーします。

値を受け取る変数は、dim や sdim, memexpand であらかじめ sql_blobsize() で取得される BLOB サイズ以上の大きさが確保されている必要があります。

当該のデータが BLOB 型かどうかは、sql_type() で判別できます。

参照するレコードを次へ進めるときは、sql_next 命令を使用します。

%href
sql_blobsize
sql_next

%sample
	...

	sql_q "SELECT blob1 FROM ..."

	; カラム blob1 の BLOB データを変数 v にコピー
	size = sql_blobsize("blob1")
	sdim v, size
	sql_blobcopy v, "blob1"

%group
レコードセット操作

%index
sql_blobsize
BLOB データのサイズを取得

%prm
("p1", v1)
"p1"	: カラム名
v1	: 対象レコードセット変数 (省略値 tmparr)

%inst
レコードセット変数から、カラム名を指定して BLOB データ (データベースに格納されたバイナリデータ) のサイズを取得します。

当該のデータが BLOB 型かどうかは、sql_type() で判別できます。BLOB データ本体は、sql_v() で参照できる変数の 16 バイト目以降に格納されており、sql_blobcopy 命令で別の変数にコピーできます。

BLOB 型以外のデータに対してこの関数を実行した場合は、0 が返ります。

参照するレコードを次へ進めるときは、sql_next 命令を使用します。

%href
sql_blobcopy
sql_next

%sample
	...

	sql_q "SELECT ID, blob1 FROM ..."
	repeat stat
		mes "ID " + sql_v("ID") + " の blob1 のサイズは " + sql_blobsize("blob1")
		sql_next
	loop

%group
レコードセット操作

%index
sql_move
レコード位置の移動

%prm
p1, v1
p1 : レコード位置指定 [0～] (0)
v1 : 対象レコードセット変数 (省略値 tmparr)

%inst
レコードセット変数 v1 の読み出しレコード位置 (レコードカウンタ) の値を設定します。

レコードカウンタとはレコードセット変数に記録されているカウンタで、sql_v(), sql_i() などのデータ取得関数の対象となるレコードを示すものです。

レコードカウンタには、0 ～ (レコード数 - 1) の値が設定できます。範囲外の値を指定した場合、エラーとなります。

%href
sql_next

%sample
	sql_q "SELECT * FROM ..."
	repeat stat
		mes sql_v("Column")
		sql_next
	loop

 ;	↓同じ働きをする

	sql_q "SELECT * FROM ..."
	repeat stat
		sql_move cnt
		mes sql_v("Column")
	loop

%group
レコードセット操作

%index
sql_close
データベースをクローズ

%prm

%inst
sql_open 命令で開いたデータベースをクローズ (使用終了) します。

アプリケーション終了時など、データベースの使用を終了するときに呼び出してください。

%href
sql_open

%sample
	sql_open "test.db"

	...

	sql_close

%group
データベース操作

%index
sql_open
データベースをオープン

%prm
"p1"
"p1" : オープンするファイル名

%inst
データベース ファイルを開きます。

p1 でファイル名を指定します。指定されたファイルがなければ、新規に作成されます。

p1 に "" を指定すると、ディスク上に一時的なデータベースが作成されます。":memory:" を指定すると、ファイルを作成せずにメモリ上に一時的なデータベースを作成します。

データベースの使用を終了するときは、sql_close でデータベースを閉じてください。

%href
sql_close

%sample
	sql_open "test.db"

	...

	sql_close

%group
データベース操作

%index
sql_colid
カラム名からレコードセット変数の配列インデックスを取得

%prm
("p1", v1)
"p1"	: カラム名
v1	: 対象レコードセット変数 (省略値 tmparr)

%inst
レコードセット変数から、カラム名を指定してその配列インデックスを取得します。

例えば SQL 文 "SELECT ID, hoge, foo FROM ..." を実行した場合、

sql_colid("ID") == 0
sql_colid("hoge") == 1
sql_colid("foo") == 2

となります。

カラム名は、大文字小文字を含め完全一致でなければなりません。

この関数は、sql_v(), sql_i(), sql_f(), sql_type() が使用しています。

%sample
	...

	sql_q "SELECT * FROM ...", arr

	c_id  = sql_colid("ID", arr)
	c_val = sql_colid("Val", arr)

	mes "ID=" + arr(c_id, 0) + " / Val=" + arr(c_val, 0)

%group
レコードセット操作

%index
sql_collist
レコードセット変数のカラム一覧を取得

%prm
("p1", v1)
"p1"	: 区切り文字列
v1	: 対象レコードセット変数 (省略値 tmparr)

%inst
レコードセット変数に含まれるカラム名の一覧を取得します。

p1 で、カラム名を区切る文字列を指定します。この引数を省略すると、"," (コンマ) が使用されます。

v1 で、レコードセット変数名を指定します。レコードセット変数を省略すると、tmparr という変数名が使用されます。

%sample
	...

	sql_q "SELECT * FROM Table1" ; レコードセット取得

	mes sql_collist() ; レコードセット変数に含まれるカラム名一覧を表示

%group
レコードセット操作

