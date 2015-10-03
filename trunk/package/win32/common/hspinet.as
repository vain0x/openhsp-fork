;
;	hspinet.dll header
;
#ifndef __hspinet__
#define __hspinet__

#uselib "hspinet.dll"
#func netinit netinit 0
#func netterm netterm $100
#func netexec netexec 1
#func netmode netmode 1
#func netsize netsize 1
#func neterror neterror $202
#func neturl neturl 6
#func netdlname netdlname 6
#func netproxy netproxy 6
#func netagent netagent 6
#func netheader netheader 6
#func netrequest netrequest 6
#func netfileinfo netfileinfo $202

#func filecrc filecrc $202
#func filemd5 filemd5 $202

#func ftpopen ftpopen $202
#func ftpclose ftpclose $202
#func ftpresult ftpresult $202
#func ftpdir ftpdir $202
#func ftpdirlist ftpdirlist $202
#func ftpdirlist2 ftpdirlist2 $202
#func ftpcmd ftpcmd $202
#func ftprmdir ftprmdir $202
#func ftpmkdir ftpmkdir $202
#func ftpget ftpget $202
#func ftpput ftpput $202
#func ftprename ftprename $202
#func ftpdelete ftpdelete $202

#enum INET_MODE_NONE = 0
#enum INET_MODE_READY
#enum INET_MODE_REQUEST
#enum INET_MODE_REQSEND
#enum INET_MODE_DATAWAIT
#enum INET_MODE_DATAEND
#enum INET_MODE_INFOREQ
#enum INET_MODE_INFORECV
#enum INET_MODE_FTPREADY
#enum INET_MODE_FTPDIR
#enum INET_MODE_FTPREAD
#enum INET_MODE_FTPWRITE
#enum INET_MODE_FTPCMD
#enum INET_MODE_FTPRESULT
#enum INET_MODE_ERROR


#module

#deffunc netload str _p1

	netrequest@ _p1

	repeat
	netexec@ res
	if res : break
	await 50
	loop

	if res > 0 : return

	neterror@ estr
	dialog "ƒGƒ‰[:"+estr
	return

#global

#endif

