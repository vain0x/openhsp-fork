;
; Character Codepage Encode module

#ifndef __ENCODE_AS__
#define global __ENCODE_AS__

#module "mod_encode"

#const global CODEPAGE_S_JIS            932 ; Shift-JIS
#const global CODEPAGE_EUC_JP         51932 ; EUC-JP
#const global CODEPAGE_JIS            50220 ; iso-2022-jp(JIS)
#const global CODEPAGE_UTF_7          65000 ; utf-7
#const global CODEPAGE_UTF_8          65001 ; utf-8
#const global CODEPAGE_UNICODE         1200 ; Unicode
#const global CODEPAGE_UNICODE_BE      1201 ; Unicode(Big-Endian)
#const global CODEPAGE_AUTODET_ALL    50001 ; auto detect all
#const global CODEPAGE_AUTODET        50932 ; auto detect

#usecom IMultiLanguage@mod_encode	"{275c23e1-3747-11d0-9fea-00aa003f8646}" \
									"{275c23e2-3747-11d0-9fea-00aa003f8646}"
#comfunc MuLang_ConvertString 9 var, int, int, var, var, var, var

#deffunc _encode_init
	newcom ml, IMultiLanguage
	return

#deffunc _encode_term onexit
	delcom ml
	return

#deffunc __FromSJIS@mod_encode str _src, int srcCodepage, var dest, int destCodepage, local src, local srcSize, local destSize, local pdwMode
	pdwMode = 0
	srcSize = -1
	destSize= 0
	src		= _src
	sdim dest
	MuLang_ConvertString ml, pdwMode, srcCodepage, destCodepage, src, srcSize, dest, destSize
	sdim dest, destSize + 1
	MuLang_ConvertString ml, pdwMode, srcCodepage, destCodepage, src, srcSize, dest, destSize
	return destSize

#defcfunc _ToSJIS@mod_encode var src, int srcCodepage, int destCodepage, local dest
	__FromSJIS src, srcCodepage, dest, destCodepage
	return dest

#define _FromSJIS __FromSJIS@mod_encode

#global

_encode_init

; SJIS -> other char code 
#define			sjis2eucjp(%1, %2)	_FromSJIS@mod_encode %2, CODEPAGE_S_JIS, %1, CODEPAGE_EUC_JP
#define			sjis2jis(%1, %2)	_FromSJIS@mod_encode %2, CODEPAGE_S_JIS, %1, CODEPAGE_JIS
#define			sjis2utf7n(%1, %2)	_FromSJIS@mod_encode %2, CODEPAGE_S_JIS, %1, CODEPAGE_UTF_7
#define			sjis2utf8n(%1, %2)	_FromSJIS@mod_encode %2, CODEPAGE_S_JIS, %1, CODEPAGE_UTF_8

; other char code -> SJIS
#define ctype	eucjp2sjis(%1)		_ToSJIS@mod_encode(%1, CODEPAGE_EUC_JP, CODEPAGE_S_JIS)
#define ctype	jis2sjis(%1)		_ToSJIS@mod_encode(%1, CODEPAGE_JIS,    CODEPAGE_S_JIS)
#define ctype	utf7n2sjis(%1)		_ToSJIS@mod_encode(%1, CODEPAGE_UTF_7,  CODEPAGE_S_JIS)
#define ctype	utf8n2sjis(%1)		_ToSJIS@mod_encode(%1, CODEPAGE_UTF_8,  CODEPAGE_S_JIS)

#endif
