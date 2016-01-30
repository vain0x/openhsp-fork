
#regcmd 9
#cmd hyoji $0f		; mesと同じコードを展開

#regcmd "_hsp3cmdinit@4","hpi3sample.dll"
#cmd newcmd $000
#cmd newcmd2 $001
#cmd newcmd3 $002
#cmd newcmd4 $003

hyoji "mes命令の代わりにhyojiを使っています。"

a=0

newcmd 1000		; 省略時は123となります
mes "システム変数statの値は、"+stat+"です。"

a=12
mes "関数newcmd("+a+")の値="+newcmd(a)+"です。"

repeat 12
newcmd2 a,10		; 0～9までの乱数を変数aに代入
mes "乱数="+a
loop

newcmd3 "test.txt",10.0
mes "test.txtを作成しました。"

newcmd4 300,50,500,250,0	; 線を描画
newcmd4 300,50,100,250,0	; 線を描画
newcmd4 100,250,500,250,0	; 線を描画

stop

