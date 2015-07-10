;
; 【HSP64bit用関数呼び出しアセンブリ】
;  by inovia (http://hsp.moe)
;
; fast-call 呼び出し規約
; x64になって使用できるレジスタが増えた為、存分に使用しています。
; もう少し綺麗に書きたい気持ちがぐぬぬっ。
;  
; [参考]
; 64 ビット Windows システムのプログラミングを開始するときに必要な知識
; https://msdn.microsoft.com/ja-jp/magazine/ee230241.aspx
; x64 ソフトウェア規約
; https://msdn.microsoft.com/ja-jp/library/7kcdt6fy.aspx
;

.code
align 16
PUBLIC call_extfunc64
call_extfunc64 PROC	
	
	; 【call_extfunc64自身の引数と戻り値】
	; rcx = 第1引数(実行する関数のポインタ)
	; rdx = 第2引数(実行する関数の引数が入ったINT64の配列)
	; r8  = 第3引数(実行する関数の引数の型情報(int32(int64)=0,　double(float)=1)が入ったINT64の配列)
	;       (小数点系のパラメタはXMMレジスタを使用する為、その判断に使用します)
	; r9  = 第4引数(実行する関数の引数の数)
	; rax = 整数型戻り値 or xmm0 = 浮動小数点戻り値
	
	; 
	; R12～R15レジスタは不揮発性な為、スタックに退避します
	; 
		push r12
		push r13
		push r14
		push r15

	; R10～R11はテンポラリ用
	; R12 は関数のアドレス保持に使用中の為
	; R13 はサイズ保持用レジスタ
	; R14 はrdx退避使用

	; 第2引数情報を R14 に代入します
		mov r14, rdx

	; 引数の数に差があっても、
	; スタックのサイズは最低40byte必要な為、 R13に保持します。
		mov r13, 40

	; R9
	; 引数の数が0～4の場合は、ARG0TO4 に飛びます。
	; それ以外の場合はスタックサイズ調整を行います。
	; if R9 <= 4
		cmp r9, 4
		jbe ARG0TO4

	; 引数が5以上の処理
	; (R13 += 8 * ( R9 - 4 ))
	
		; 第4引数(引数の数) R9 から R10 に代入します。
		; R10 はスタックで渡す必要のある引数の数を表します。
			mov r10, r9
	
		; 引数の数が4まではレジスタで渡すため、
		; 4を引いてスタックで渡す必要のある引数の数を求めます。
			sub r10, 4

		; R10を8倍します。左への論理シフトを行います。
		; 8(=2の3乗）なので、パラメタは3を指定します。
			shl r10, 3
			add r13, r10

	; 引数の数が0～4の時はスタックサイズ 40byte
	; 5以降は 16byteずつ増えます(アライメント)

	; 【例】        必要バイト数 実バイト数
	;------------------------------------
	; 引数の数 0-4  40byte       40byte(引数1～4と戻りアドレス用で40byte消費)
	;------------------------------------
	; 引数の数   5  48byte       56byte
	; 引数の数   6  56byte       56byte
	; 引数の数   7  64byte       72byte
	; 引数の数   8  72byte       72byte
	; 引数の数   9  80byte       88byte
	; 引数の数  10  88byte       88byte

	; 現時点のスタックのサイズ(R13)が16で割り切れる場合は、8byte 足します。
	; if r13\16 == 0 : r13 += 8

		; R13 から RAX に代入します。
			mov rax, r13

			cdq
			and	rdx, 15
			add	rax, rdx
			and	rax, 15
			sub	rax, rdx

		; RAXが0で割り切れないときは、ARG0TO4に飛びます。
		; スタックサイズの調整を終了します。
			cmp rax, 0
			jne ARG0TO4

		; 割り切れるため、スタックのサイズ(R13)に 8byte 加算します
		; スタックサイズの調整を終了します。
			add r13, 8

; レジスタ渡しする引数の設定を行います。 
ARG0TO4:

	; R14からRDXに代入します
	; スタックのサイズR13からR11に代入します
		mov rdx, r14
		mov r11, r13

	; スタックのサイズ(R11)分
	; スタックポインタをずらして、スタックを確保します
		sub rsp, r11

	; 関数呼び出しの為、RCX, RDX, R8, R9 を R12, R13, R14, R15 レジスタに代入します。
	; r12  = 第1引数(実行する関数のポインタ)
	; r13  = 第2引数(実行する関数の引数が入ったINT64の配列)
	; r14  = 第3引数(実行する関数の引数の型情報(int32(int64)=0,　double(float)=1)が入ったINT64の配列)
	;       (小数点系のパラメタはXMMレジスタを使用する為、その判断に使用します)
	; r15  = 第4引数(実行する関数の引数の数)

		mov r12, rcx
		mov r13, rdx
		mov r14, r8
		mov r15, r9

	;  
	; 引数1～4の時はレジスタに格納、5以降はスタックに格納する処理です。
	;

	; ------------------------------------------------------------------
	; 実行する関数の第1引数
	; ------------------------------------------------------------------
	; if 引数の数 > 0
		cmp r15, 0
		jg FLAG1
		jmp FLAG1END
FLAG1:
	; R14 のポインタから R10レジスタ にコピーします。
	; R10 は 整数か浮動小数点かどうかの情報が入っています。
		mov r10, qword ptr [r14 + 0]
	; 整数か浮動小数点かどうかを判断します。
		cmp r10, 0
		je FLAG1INT
	; 浮動小数点なのでXMM0レジスタへ代入します
		movq xmm0, qword ptr [r13 + 0]
		jmp FLAG1END
FLAG1INT:
	; 整数なのでRCXレジスタへ代入します
		mov rcx, qword ptr [r13 + 0]
FLAG1END:

	; ------------------------------------------------------------------
	; 実行する関数の第2引数
	; ------------------------------------------------------------------
	; if 引数の数 > 1
		cmp r15, 1
		jg FLAG2
		jmp FLAG2END
FLAG2:
	; R14 のポインタから R10レジスタ にコピーします。
		mov r10, qword ptr [r14 + 8]
	; 整数か浮動小数点かどうかを判断します。
		cmp r10, 0
		je FLAG2INT
	; 浮動小数点なのでXMM1レジスタへ代入します
		movq xmm1, qword ptr [r13 + 8]
		jmp FLAG2END
FLAG2INT:
	; 整数なのでRDXレジスタへ代入します
		mov rdx, qword ptr [r13 + 8]
FLAG2END:

	; ------------------------------------------------------------------
	; 実行する関数の第3引数
	; ------------------------------------------------------------------
	; if 引数の数 > 2
		cmp r15, 2
		jg FLAG3
		jmp FLAG3END
FLAG3:
	; R14 のポインタから R10レジスタ にコピーします。
		mov r10, qword ptr [r14 + 16]
	; 整数か浮動小数点かどうかを判断します。
		cmp r10, 0
		je FLAG3INT
		; 浮動小数点なのでXMM2レジスタへ代入します
		movq xmm2, qword ptr [r13 + 16]
		jmp FLAG3END
FLAG3INT:
	; 整数なのでR8レジスタへ代入します
		mov r8, qword ptr [r13 + 16]
FLAG3END:

	; ------------------------------------------------------------------
	; 実行する関数の第4引数
	; ------------------------------------------------------------------
	; if 引数の数 > 3
		cmp r15, 3
		jg FLAG4
		jmp FLAG4END
FLAG4:
	; R14 のポインタから R10レジスタ にコピーします。
		mov r10, qword ptr [r14 + 24]
	; 整数か浮動小数点かどうかを判断します。
		cmp r10, 0
		je FLAG4INT
	; 浮動小数点なのでXMM3レジスタへ代入します
		movq xmm3, qword ptr [r13 + 24]
		jmp FLAG4END
FLAG4INT:
	; 整数なのでR9レジスタへ代入します
		mov r9, qword ptr [r13 + 24]
FLAG4END:

	; ------------------------------------------------------------------
	; 実行する関数の第5引数 以降～
	; ------------------------------------------------------------------
	; if 引数の数 < 5 : 引数の数が0～4の場合は CALLFUNC に飛びます。
		cmp r15, 5
		jl CALLFUNC
	; 引数の数が5以上はスタックに積む(引数の一番最後から積む)
	; 引数の数(R15)→(R10)に代入します。
		mov r10, r15
		jmp PUSHCHECK

	; 引数の情報をスタックに積みます。
PUSHSTACK:
		mov	rax, qword ptr [r13 + r10 * 8]
		mov	qword ptr [rsp + r10 * 8], rax
PUSHCHECK:
	; 引数の数を1ずつ減らします。
		dec	r10
	; 引数の数が0～3になった時は追加をやめます。
		cmp r10, 3
		jg PUSHSTACK

CALLFUNC:

	; 関数を呼び出します
		mov r13, r11
		call r12
		mov r11, r13

	; スタックポインタを元に戻します。
		add	rsp, r11
	
	; 退避したR12～R15レジスタをスタックから戻します
		pop r15
		pop r14
		pop r13
		pop r12
	
	; 終了
		ret

call_extfunc64 ENDP

; 戻り値がdouble型用
PUBLIC call_extfunc64d
call_extfunc64d PROC	
	jmp call_extfunc64
call_extfunc64d ENDP

; 戻り値がfloat型用
PUBLIC call_extfunc64f
call_extfunc64f PROC	
	jmp call_extfunc64
call_extfunc64f ENDP

;
End