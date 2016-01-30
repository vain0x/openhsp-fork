#ifndef __mod_regexp
#define __mod_regexp
/*********************************************************************
%dll
mod_regexp
%group
正規表現検索命令
%note
Internet Explorer 5.5 以上が必要
%********************************************************************/
#module
#deffunc _endregexp onexit
	delcom oReg
	return
#deffunc _startregexp
	newcom oReg,"VBScript.RegExp"
	return
/*********************************************************************
%index
match
正規表現で検索して最初に一致した文字列を返す
%prm
(p1,p2,p3,p4)
p1:検索される文字列
p2:検索する文字列
p3(0):大文字と小文字を区別するなら1
p4(0):全体を一つの行と見なすなら1
%inst
p1の文字列からp2に一致した最初の文字列を返します。
p2には正規表現のパターンを指定します。
p3を1にすると大文字と小文字を区別します。0や省略した場合は区別しません。
p4を1にするとメタ文字 ^ と $ が改行直後・直前に対応しません。0や省略した場合は対応します。

正規表現のパターンには通常の文字の他、以下のメタ文字と呼ばれる特殊文字が使えます。
メタ文字を使う場合、HSPスクリプト上では \ は "\\" と表記する事に注意してください。
たとえば、数字と一致するパターンの表記は "\\d" となり、 \ と一致するパターン表記は "\\\\" となります。
また、HSPでの改行 "\n" は\r\nの２文字であることに注意してください。"\n" と一致するパターン表記は "\n" または "\\r\\n" となります。

html{
<center>メタ文字一覧</center>
<table border="1" style="font-family:MS UI Gothic;line-height:100%;">
<tr valign="top"><th>文字</th><th>説明</th></tr>
<tr valign="top"><td align="center" nowrap>.</td><td> \n 以外の任意の1文字に一致します。\r とは一致する事に注意してください。</td></tr>
<tr valign="top"><td align="center" nowrap>*</td><td>直前のパターンの0回以上の繰り返しに一致します。たとえば、HSP!* は "HSP" と "HSP!" と "HSP!!" いずれにも一致します。</td></tr>
<tr valign="top"><td align="center" nowrap>+</td><td>直前のパターンの1回以上の繰り返しに一致します。たとえば、HSP!+ は "HSP!" と "HSP!!" には一致しますが、"HSP" には一致しません。</td></tr>
<tr valign="top"><td align="center" nowrap>?</td><td>直前のパターンの0回または 1 回の繰り返しに一致します。たとえば、HSP!? は "HSP" と "HSP!" に一致します。</td></tr>
<tr valign="top"><td align="center" nowrap>{<em>n</em>,<em>m</em>}</td><td>直前のパターンの <em>n</em> 回以上 <em>m</em> 回以下の繰り返しに一致します。たとえば、\d{3,4} は 3桁または4桁の数字に一致しますが 2桁の数字には一致せず、5桁の数字には最初の4桁だけが一致します。<em>m</em>を省略すると<em>n</em> 回以上の繰り返しに一致し、カンマと<em>m</em>を省略すると<em>n</em> 回ちょうどの繰り返しに一致します。{0,1} は ? と同じ意味になり、{1,} は + と、{0,} は * と同じ意味になります。{ }の間には余分な空白などを入れてはいけません。</td></tr>
<tr valign="top"><td align="center">*? +? ?? {<em>n</em>,<em>m</em>}?</td><td>* + ? {<em>n</em>,<em>m</em>} のような繰り返し指定のメタ文字は通常、最も長い文字列と一致しますが、これらのメタ文字直後に ? をおくと最も短い文字列と一致します。たとえば、"&lt;abc&gt;&lt;def&gt;" という文字列をパターン &lt;.*&gt; で検索した場合、文字列全体と一致しますが &lt;.*?&gt; と検索した場合は "&lt;abc&gt;" と "&lt;def&gt;" の二つに分けて一致するようになります。</td></tr>
<tr valign="top"><td align="center" nowrap>[<em>string</em>]</td><td><em>string</em> に含まれるいずれかの一文字と一致します。たとえば、HSP[123] は "HSP1" と "HSP2" と"HSP3" に一致しますが "HSP4" には一致しません。また、二つの文字を-でつなげば範囲指定が可能です。例えば [a-z] は任意の英小文字一文字に一致し、[a-zA-Z] は任意の英字一文字に一致します。-自体を検索する場合は [-a-z] のようにします。<em>string</em>には $ などのメタ文字を使用してもメタ文字と解釈されませんが、一部を除く \ で始まるメタ文字は機能します。</td></tr>
<tr valign="top"><td align="center" nowrap>[^<em>string</em>]</td><td>[<em>string</em>] とは逆に <em>string</em> に含まれない任意の一文字と一致します。たとえば、HSP[^1-3] は "HSP4" や "HSP5" に一致しますが "HSP1" と "HSP2" と"HSP3" には一致しません。</td></tr>
<tr valign="top"><td align="center" nowrap>|</td><td>論理和(OR)検索をします。たとえば、abc|def は "abc" と "def" に一致します。| は他の文字より評価の優先順位が低いので ( ) と組み合わせるのが便利です。</td></tr>
<tr valign="top"><td align="center" nowrap>(<em>pattern</em>)</td><td><em>pattern</em> を一つのグループとします。たとえば、20(09|10) は "2009" と "2010" に一致します。また、<em>pattern</em> に一致する文字列をサブマッチとして後方参照することが出来ます(最大99個)。</td></tr>
<tr valign="top"><td align="center" nowrap>(?:<em>pattern</em>)</td><td>サブマッチとして利用できない以外は (<em>pattern</em>) といっしょです。(<em>pattern</em>)を使う場合に比べてメモリの節約になります。</td></tr>
<tr valign="top"><td align="center" nowrap>(?=<em>pattern</em>)</td><td><em>pattern</em> に一致する文字列の直前の位置に一致します。たとえば、HSP(?=2|3) は "HSP2" と "HSP3" の"HSP"に一致しますが "HSP1" の"HSP"には一致しません。また、サブマッチとしての利用は出来ません。</td></tr>
<tr valign="top"><td align="center" nowrap>(?!<em>pattern</em>)</td><td><em>pattern</em> に一致しない文字列の直前の位置に一致します。たとえば、HSP(?!2)\d は "HSP1" や "HSP3" に一致しますが "HSP2" や "HSPa" には一致しません。また、サブマッチとしての利用は出来ません。</td></tr>
<tr valign="top"><td align="center" nowrap>\<em>num</em></td><td>サブマッチと同じ文字列に一致します。一つ目のサブマッチは\1で最大\99まで指定できます。たとえば、(.)(.)\1\2 は "abab" や "0101" のような交互に繰り返す文字列に一致し、&lt;(.*?)&gt;.*&lt;/\1&gt; は "&lt;a&gt;hoge&lt;/a&gt;" や "&lt;b&gt;hoge&lt;/b&gt;" に一致します。対応するサブマッチがない場合は8進文字コードと見なされます。</td></tr>
<tr valign="top"><td align="center" nowrap>^</td><td>行頭に一致します。つまり、文字列の先頭および \n または \r の直後の位置に一致します。</td></tr>
<tr valign="top"><td align="center" nowrap>$</td><td>行末に一致します。つまり、文字列の最後および \n または \r の直前の位置に一致します。</td></tr>
<tr valign="top"><td align="center" nowrap>\</td><td>\の次にメタ文字をおくと、その文字と一致します。たとえば、\( は "(" に一致し \? は "?" に一致します。また、\\ は "\" に一致します。</td></tr>
<tr valign="top"><td align="center" nowrap>\n</td><td>改行(LF)に一致します。\x0a および \cJ と同じです。</td></tr>
<tr valign="top"><td align="center" nowrap>\r</td><td>改行(CR)に一致します。\x0d および \cM と同じです。</td></tr>
<tr valign="top"><td align="center" nowrap>\t</td><td>タブに一致します。\x09 および \cI と同じです。</td></tr>
<tr valign="top"><td align="center" nowrap>\f</td><td>フォームフィードに一致します。\x0c および \cL と同じです。</td></tr>
<tr valign="top"><td align="center" nowrap>\v</td><td>垂直タブに一致します。\x0b および \cK と同じです。</td></tr>
<tr valign="top"><td align="center" nowrap>\c</td><td>Ctrlキーで入力できる制御文字に一致します。\cに続けて英字一文字を指定します。たとえば、\cM は Ctrl + M キー(改行文字)に一致します。</td></tr>
<tr valign="top"><td align="center" nowrap>\b</td><td>単語の境界に一致します。たとえば、run\b は "run" には一致しますが "running" の "run" には一致しません。</td></tr>
<tr valign="top"><td align="center" nowrap>\B</td><td>単語の境界でない位置に一致します。たとえば、run\B は "running" の "run" には一致しますが "run" には一致しません。</td></tr>
<tr valign="top"><td align="center" nowrap>\d</td><td>数字一文字に一致します。[0-9] と同じです。</td></tr>
<tr valign="top"><td align="center" nowrap>\D</td><td>数字以外の一文字に一致します。[^0-9] と同じです。</td></tr>
<tr valign="top"><td align="center" nowrap>\s</td><td>スペースやタブなどの空白文字に一致します。[ \f\n\r\t\v] と同じです。</td></tr>
<tr valign="top"><td align="center" nowrap>\S</td><td>空白文字以外の任意の一文字に一致します。[^ \f\n\r\t\v] と同じです。</td></tr>
<tr valign="top"><td align="center" nowrap>\w</td><td>単語に使用される任意の一文字に一致します。[A-Za-z0-9_] と同じです。</td></tr>
<tr valign="top"><td align="center" nowrap>\W</td><td>単語に使用される文字以外の任意の一文字に一致します。[^A-Za-z0-9_] と同じです。</td></tr>
<tr valign="top"><td align="center" nowrap>\x</td><td>16進文字コードです。\xに続けて2桁の16進数を指定します。たとえば、\x41 は "A" に一致します。</td></tr>
<tr valign="top"><td align="center" nowrap>\</td><td>8進文字コードです。\に続けて3桁の8進数を指定します。たとえば、\101 は "A" に一致します。</td></tr>
<tr valign="top"><td align="center" nowrap>\u</td><td>Unicodeです。\uに続けて4桁の16進数を指定します。たとえば、\u3042 は "あ" に一致します。</td></tr>
</table>
}html
%sample
#include "mod_regexp.as"
a={"
	算数=50
	国語=100
	社会=70
"}
mes match(a,"国語=\\d+")

 ;--------結果-----------
 ;国語=100
%href
submatch
matches
replace
%********************************************************************/
#defcfunc match str target,str Pattern,int IgnoreCase,int Multiline
	oReg("Global") = 0
	oReg("IgnoreCase") = (IgnoreCase==0)
	oReg("Multiline") = (Multiline==0)
	oReg("Pattern") = Pattern
	comres oMatches
	oReg->"Execute" target
	if stat<0:return ""
	if oMatches("count"){
		oMatch=oMatches("item",0)
		retstr=oMatch("value")
		delcom oMatch
	}else{
		retstr=""
	}
	delcom oMatches
	return retstr
/*********************************************************************
%index
submatch
正規表現で検索して最初に一致したサブマッチ文字列を返す
%prm
(p1,p2,p3,p4)
p1:検索される文字列
p2:検索する文字列
p3(0):大文字と小文字を区別するなら1
p4(0):全体を一つの行と見なすなら1
%inst
p1の文字列からp2に一致した最初の結果のサブマッチ文字列を返します。
p2には正規表現のパターンを指定します。
p3を1にすると大文字と小文字を区別します。0や省略した場合は区別しません。
p4を1にするとメタ文字 ^ と $ が改行直後・直前に対応しません。0や省略した場合は対応します。
正規表現のパターンについてはmatchの項目を参照してください。
%sample
#include "mod_regexp.as"
a={"
	算数=50
	国語=100
	社会=70
"}
mes submatch(a,"国語=(\\d+)")

 ;--------結果-----------
 ;100
%href
match
matches
replace
%********************************************************************/
#defcfunc submatch str target,str Pattern,int IgnoreCase,int Multiline
	oReg("Global") = 0
	oReg("IgnoreCase") = (IgnoreCase==0)
	oReg("Multiline") = (Multiline==0)
	oReg("Pattern") = Pattern
	comres oMatches
	oReg->"Execute" target
	if stat<0 : return ""
	retstr=""
	if oMatches("count"){
		oMatch=oMatches("item",0)
		oSubmatches=oMatch("submatches")
		if oSubmatches("count"){
			variant=oSubmatches(".Item",0)
			variant("vartype")=8/*VT_BSTR*/
			retstr=variant("value")
			variant=0
		}
		delcom oSubmatches
		delcom oMatch
	}
	delcom oMatches
	return retstr
/*********************************************************************
%index
matches
正規表現で検索した複数の結果を取得する
%prm
p1,p2,p3,p4,p5,p6
p1:結果を受け取る変数
p2:検索される文字列
p3:検索する文字列
p4(0):大文字と小文字を区別するなら1
p5(0):最初の結果だけを取得するなら1
p6(0):全体を一つの行と見なすなら1
%inst
p2の文字列からp3に一致した複数の結果をサブマッチを含めて一度に取得します。
p3には正規表現のパターンを指定します。
p4を1にすると大文字と小文字を区別します。0や省略した場合は区別しません。
p5を1にすると最初に一致した結果だけを取得します。0や省略した場合は全ての結果を取得します。
p6を1にするとメタ文字 ^ と $ が改行直後・直前に対応しません。0や省略した場合は対応します。

p1の変数は初期化され、結果はp1の配列にセットされます。
一番目に一致した文字列はp1(0)に、二番目に一致した文字列はp1(1)に格納されます。
さらに、一番目に一致した文字列のなかの一番目のサブマッチはp1(0,1)に、二番目のサブマッチはp1(0,2)に格納されます。
statに一致した文字列の数がセットされ、0なら一つも一致していないことになります。
サブマッチの数はlength2を使って調べられます。

正規表現のパターンについてはmatchの項目を参照してください。
%sample
#include "mod_regexp.as"
a={"
	太郎：算数=50,国語=100,社会=70
	一郎：算数=30,国語=50,社会=60
	花子：算数=60,国語=40,社会=50
"}
matches b,a,"(.*)：算数=(\\d+),国語=(\\d+),社会=(\\d+)"
repeat stat
	mes b(cnt)
	mes "\t"+b(cnt,1)+"の総得点="+(0+b(cnt,2)+b(cnt,3)+b(cnt,4))
loop

 ;-------------結果------------
 ;太郎：算数=50,国語=100,社会=70
 ;	太郎の総得点=220
 ;一郎：算数=30,国語=50,社会=60
 ;	一郎の総得点=140
 ;花子：算数=60,国語=40,社会=50
 ;	花子の総得点=150
%href
match
submatch
replace
%********************************************************************/
#deffunc matches array retvar,str target,str Pattern,int IgnoreCase,int Global,int Multiline
	oReg("IgnoreCase") = (IgnoreCase==0)
	oReg("Global") = (Global==0)
	oReg("Multiline") = (Multiline==0)
	oReg("Pattern") = Pattern
	comres oMatches
	oReg->"Execute" target
	if stat<0:sdim retvar,1,1:return 0
	num1=oMatches("count")
	if num1==0:sdim retvar,1,1:	delcom oMatches:return 0
	oMatch=oMatches("item",0)
	oSubmatches=oMatch("submatches")
	num2=oSubmatches("Count")
	sdim retvar,64,num1,num2+1
	for i,0,num1,1
		oMatch=oMatches("item",i)
		retvar.i=oMatch("value")
		oSubmatches=oMatch("submatches")
		repeat num2
			variant=oSubmatches(".Item",cnt)
			variant("vartype")=8/*VT_BSTR*/
			retvar(i,cnt+1)=variant("value")
		loop
	next
	variant=0
	delcom oSubmatches
	delcom oMatch
	delcom oMatches
	return num1
/*********************************************************************
%index
replace
正規表現で文字列の置換を行う
%prm
(p1,p2,p3,p4,p5,p6)
p1:検索される文字列
p2:検索する文字列
p3:置き換える文字列
p4(0):大文字と小文字を区別するなら1
p5(0):最初に一致した部分だけを置換するなら1
p6(0):全体を一つの行と見なすなら1
%inst
p1の文字列のなかでp2に一致した部分をp3で置き換えた文字列を返します。
p2には正規表現のパターンを指定します。
p4を1にすると大文字と小文字を区別します。0や省略した場合は区別しません。
p5を1にすると最初に一致した部分だけを置換します。0や省略した場合は全ての一致した部分を置換します。
p6を1にするとメタ文字 ^ と $ が改行直後・直前に対応しません。0や省略した場合は対応します。
正規表現のパターンについてはmatchの項目を参照してください。

p3には以下の特殊文字が使用できます。
html{
<table border="1" style="font-family:MS UI Gothic;line-height:100%;">
<tr><th>文字</th><th>説明</th></tr>
<tr><td align="center" nowrap>$<em>num</em></td><td><em>num</em>番目のサブマッチ文字列に置換されます。一つ目のサブマッチは$1で最大$99まで指定できます。</td></tr>
<tr><td align="center" nowrap>$&amp;</td><td>p2に一致した文字列に置換されます。</td></tr>
<tr><td align="center" nowrap>$`</td><td>p1の中で、p2に一致した文字列よりも前方の部分に置換されます。</td></tr>
<tr><td align="center" nowrap>$'</td><td>p1の中で、p2に一致した文字列よりも後方の部分に置換されます。</td></tr>
<tr><td align="center" nowrap>$$</td><td>$に置換されます。</td></tr>
</table>
}html
%sample
#include "mod_regexp.as"
a={"
	太郎：50,100,70
	一郎：30,50,60
	花子：60,40,50
"}
mes replace(a,"：","の成績：")

 ;---------------結果--------------
 ;太郎の成績：50,100,70
 ;一郎の成績：30,50,60
 ;花子の成績：60,40,50

mes replace(a,"(.*)：(\\d+),(\\d+),(\\d+)","$1の成績：算数=$2,国語=$3,社会=$4")

 ;---------------結果--------------
 ;太郎の成績：算数=50,国語=100,社会=70
 ;一郎の成績：算数=30,国語=50,社会=60
 ;花子の成績：算数=60,国語=40,社会=50
%href
match
submatch
matches
%********************************************************************/
#defcfunc replace str target,str Pattern,str repstr,int IgnoreCase,int Global,int Multiline
	oReg("IgnoreCase") = (IgnoreCase==0)
	oReg("Global") = (Global==0)
	oReg("Multiline") = (Multiline==0)
	oReg("Pattern") = Pattern
	comres retstr
	oReg->"Replace" target,repstr
	if stat<0:return target
	return retstr
#global
_startregexp
#endif
