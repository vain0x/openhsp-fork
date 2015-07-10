;
;	hspprint.dll header
;
#ifndef __hspprint__
#define __hspprint__

#uselib "hspprint.dll"

#const PRINTER_ENUM_LOCAL 2
#const PRINTER_ENUM_CONNECTIONS 4
#const PRINTER_ENUM_SHARED 32

#func prnflags prnflags $202
#func enumprn enumprn $202
#func propprn propprn $202
#func execprn execprn $202
#func getdefprn getdefprn $202
#func prndialog prndialog $202

#endif

