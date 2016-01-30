
	;	module for AHT
	;
#include "mod_fontdlg.as"

#module ahtmod
#define APPNAME "Peas ver1.1"
#include "hspcmp.as"

#enum AHTTYPE_EDIT_INT = 0	// 入力枠(結果=int,sub=最小,sub2=最大)
#enum AHTTYPE_EDIT_DOUBLE	// 入力枠(結果=double,sub=最小,sub2=最大)
#enum AHTTYPE_EDIT_STRING	// 入力枠(結果=str,sub=文字数,sub2=option)
#enum AHTTYPE_CBOX_STRING	// コンボボックス(結果=str,sub=選択肢,sub2=選択肢テキスト)
#enum AHTTYPE_CHKB_INT		// チェックボックス(0or1、sub=テキスト)
#enum AHTTYPE_COLS_INT		// 色選択(結果=int)
#enum AHTTYPE_FONT_STRING	// フォント選択(結果=str)
#enum AHTTYPE_FILE_STRING	// ファイル選択(sub=拡張子,sub2=選択名)
#enum AHTTYPE_EXTF_STRING	// 外部ツール起動(sub=拡張子,sub2=ツール名)
#enum AHTTYPE_PARTS_INT,	// パーツID(sub=クラス名,sub2=参照名)
#enum AHTTYPE_PARTS_PROP_STRING,// パーツIDのプロパティ(sub=プロパティ名)
#enum AHTTYPE_PARTS_OPT_STRING,	// パーツIDのオプション(sub=オプション名)
#enum AHTTYPE_MAX

#uselib "user32.dll"
#func EnableWindow "EnableWindow" int,int

;-------------------------------------------------------------------------

#deffunc tminit
	;	AHTシステム初期化
	;
	sdim class, 128
	sdim author, 64
	sdim ver, 64
	sdim fname, 260
	sdim icon, 64
	sdim mflag, 64
	sdim glid, 64
	sdim exp, 1024
	sdim helpkw, 256

	dim maxis, 8
	dim maxis2, 8

	aht_ini "test"

	return


#deffunc tmload var _p1, str _p2, str _p3, int _p4

	;	モデル読み込み
	;	tmload 変数, "ファイル名","パス名",モデルID
	;	(モデルIDがマイナスの場合は自動的にID割り当て)
	;	(変数に割り当てられたIDが代入される)
	;
	_p1 = -1
	aht_source m, _p2,_p3,_p4
	tmload_res=stat

	;mes "ModelID="+m

	aht_stdsize size
	sdim stdbuf, size
	aht_stdbuf stdbuf

	if tmload_res != 0 : return

	;mesbox stdbuf,640,200,0
	;aht_getopt class,"class",m,128
	;aht_getopt author,"author",m,64
	;aht_getopt ver,"ver",m,64
	;aht_getopt icon,"icon",m,64
	;aht_getopt fname,"source",m,260
	;aht_getopt exp,"exp",m,1024
	;mes "Class["+class+"] Author["+author+"] Ver["+ver+"] File["+fname+"] Icon["+icon+"]"
	;mes "Exp="+exp

	x=128:y=128
	if clsel>=0 {
		aht_getmodaxis maxis, clsel
		x=maxis(0)+80
		y=maxis(1)
	}
	aht_setmodaxis m, x, y, clpage

	_p1 = m
	clsel = m

	return


#deffunc tmdelete int _p1

	;	モデル削除
	;
	clsel = -1
	aht_delmod _p1
	return


#deffunc tmlink int _p1, int _p2

	;	モデル接続
	;
	aht_linkmod _p1, _p2
	return


#deffunc tmunlink int _p1

	;	モデル切断
	;
	aht_unlinkmod _p1
	return


#deffunc tmprops int _p1

	;
	;	プロパティ編集オブジェクト作成
	;
	aht_getpropcnt pmax, _p1
	aht_getpropcnt plmax, _p1,1
	;
	sdim p_name, 512
	sdim p_help, 512
	sdim p_def2, 4096
	sdim p_def3, 4096
	sdim p_def, 1024, pmax
	dim p_defi, pmax
	ddim p_defd, pmax
	dim p_xx, pmax
	dim p_yy, pmax
	dim p_obj, pmax
	;
	sdim deftmp, 1024
	;
	pscr=1
	mymodel = _p1
	ox=160:oy=22:py=oy+4
	sx=320:sy=plmax*py+48+24
	screen pscr,sx,sy,8,ginfo_wx2,ginfo_wy1
	aht_getopt fname,"name",_p1,256
	title "プロパティ - "+getpath(fname,9)
	syscolor 15:boxf
	sysfont 17:color 0,0,0
	x=4:y=4

	aht_propupdate mymodel	; 動的プロパティの更新
	repeat pmax
		curprop=cnt
		aht_getproptype p_type, cnt, _p1
		aht_getpropmode p_mode, cnt, _p1
		aht_getprop p_name, 0, cnt, _p1
		aht_getprop p_help, 1, cnt, _p1
		aht_getprop p_def2, 3, cnt, _p1
		aht_getprop p_def3, 4, cnt, _p1
		aht_getprop p_def(cnt), 2, cnt, _p1
		pos x,y+2:mes p_name
		p_xx(cnt) = x+ginfo_mesx+8
		p_yy(cnt) = y
		p_obj(cnt) = -1
		pos p_xx(cnt),p_yy(cnt)
		on p_type gosub *ptype_0,*ptype_1,*ptype_2,*ptype_3,*ptype_4,*ptype_5,*ptype_6,*ptype_7,*ptype_8,*ptype_9,*ptype_10,*ptype_11
		if p_mode&AHTMODE_READ_ONLY : EnableWindow objinfo_hwnd(p_obj(cnt)),0
		y+=py
	loop
	;
	if pmax>0 : objsel 0
	;
	aht_getopt class,"class",_p1,128
	aht_getopt author,"author",_p1,64
	aht_getopt ver,"ver",_p1,64
	aht_getopt icon,"icon",_p1,64
	aht_getopt mflag,"flag",_p1,64
	aht_getopt glid,"glid",_p1,64
	aht_getopt fname,"source",_p1,260
	aht_getopt exp,"exp",_p1,1024
	aht_getopt helpkw,"helpkw",_p1,256
	;
	y+=24
	pos x,y
	mes "Class:"+class
	mes "Author:"+author+" Ver:"+ver
	mes "Flag:"+mflag+" PartsID:"+_p1+"/"+glid
	pos sx-128,y+14:objsize 120,24
	return

*ptype_0
	;	AHTTYPE_EDIT_INT
	objsize 64,oy
	i=ginfo_cx+72
	p_defi(cnt)=0+p_def(cnt)
	input p_defi(cnt)
	p_obj(cnt) = stat
	goto *afthelp
*ptype_1
	;	AHTTYPE_EDIT_DOUBLE
	objsize 64,oy
	i=ginfo_cx+72
	p_defd(cnt)=0.0+p_def(cnt)
	input p_defd(cnt)
	p_obj(cnt) = stat
	goto *afthelp
*ptype_2
	;	AHTTYPE_EDIT_STRING
	if peek(p_def3,0)='m' {
		mesbox p_def(cnt),310-ginfo_cx,py*4,1
		p_obj(cnt) = stat
		y+=py*3
		goto *afthelp2
	}
	if peek(p_def3,0)='w' {
		objsize 310-ginfo_cx,oy
		input p_def(cnt)
		p_obj(cnt) = stat
		goto *afthelp2
	}
*ptype_2x
	objsize ox,oy
	i=ginfo_cx+ox+8
	input p_def(cnt)
	p_obj(cnt) = stat
	goto *afthelp

*ptype_3
	;	AHTTYPE_CBOX_STRING
	;
	if p_def3="" : p_def3 = p_def2
	i=ginfo_cx+ox+8
	objsize 310-ginfo_cx,oy
	cbindex=0
	notesel p_def2
	repeat notemax
	noteget deftmp,cnt
	if p_def(curprop)=deftmp : cbindex=cnt
	loop
	;
	p_defi(cnt)=cbindex
	combox p_defi(cnt),100,p_def3
	p_obj(cnt) = stat
	goto *afthelp2

*ptype_4
	;	AHTTYPE_CHKB_INT	// チェックボックス(0or1、sub=テキスト)
	;
	i=ginfo_cx+ox+8
	objsize ox,oy
	p_defi(cnt)=0+p_def(cnt)
	chkbox p_def2,p_defi(cnt)
	p_obj(cnt) = stat
	goto *afthelp

*ptype_5
	;	AHTTYPE_COLS_INT	// 色選択(結果=int)
	;
	objsize 64,oy
	i=ginfo_cx+68
	input p_def(cnt)
	p_obj(cnt) = stat
	pos i,y:objsize 36,oy
	button gosub "選択",*btn_colset
	i+=44
	goto *afthelp

*ptype_6
	;	AHTTYPE_FONT_STRING	// フォント選択(結果=str)
	;
	objsize 270-ginfo_cx,oy
	i=280
	input p_def(cnt)
	p_obj(cnt) = stat
	pos i,y:objsize 36,oy
	button gosub "選択",*btn_fontset
	goto *afthelp2

*ptype_7
	;	AHTTYPE_FILE_STRING	// ファイル選択(sub=拡張子,sub2=選択名)
	;
	objsize 270-ginfo_cx,oy
	i=280
	input p_def(cnt)
	p_obj(cnt) = stat
	pos i,y:objsize 36,oy
	button gosub "選択",*btn_fileset
	goto *afthelp2

*ptype_8
	;	AHTTYPE_EXTF_STRING	// 外部ツール起動(sub=拡張子,sub2=ツール名)
	;
	objsize 310-ginfo_cx,oy
	input p_def(cnt)
	p_obj(cnt) = stat
	goto *afthelp2

*ptype_9
	;	AHTTYPE_PARTS_INT		// パーツID(sub=クラス名)
	aht_listparts p_def3, p_def2
	;
	objsize 310-ginfo_cx,oy
	cbindex=0
	i_defid = 0 + p_def(curprop)
	notesel p_def3
	repeat notemax
	noteget deftmp,cnt
	if i_defid = (0+deftmp) : cbindex=cnt
	loop
	;
	p_defi(cnt)=cbindex
	combox p_defi(cnt),100,p_def3
	p_obj(cnt) = stat
	goto *afthelp2

*ptype_10
	;	AHTTYPE_PARTS_PROP_STRING	// パーツIDのプロパティ(sub=プロパティ名)
	goto *ptype_2x

*ptype_11
	;	AHTTYPE_PARTS_OPT_STRING	// パーツIDのオプション(sub=オプション名)
	goto *ptype_2x


*afthelp
	;	パーツの右側にヘルプを表示
	pos i,y+2:mes p_help
	return
*afthelp2
	;	パーツの下にヘルプを表示
	if p_help="" : return
	y+=py
	pos x+48,y+4:mes p_help
	return

*btn_colset
	;	カラー選択
	objid = stat-1
	gosub *obj_getid
	if myid<0 : return
	;
	gsel pscr,1
	dialog "",33
	if stat {
		objprm p_obj(myid),"$"+strf("%02x",ginfo_r)+strf("%02x",ginfo_g)+strf("%02x",ginfo_b)
		aht_getprop p_def3, 4, myid, mymodel
		if p_def3="rgb" {
			objprm p_obj(myid+1),ginfo_r
			objprm p_obj(myid+2),ginfo_g
			objprm p_obj(myid+3),ginfo_b
		}
	}
	return

*btn_fontset
	;	フォント選択
	objid = stat-1
	gosub *obj_getid
	if myid<0 : return
	;
	gsel pscr,1
	dim n,8
	fontdlg n,$100
	if stat {
		gsel 1
		objprm p_obj(myid),refstr
		objprm p_obj(myid+1),n(2)
		objprm p_obj(myid+2),n(1)
	}
	return

*btn_fileset
	;	ファイル選択
	objid = stat-1
	gosub *obj_getid
	if myid<0 : return
	;
	aht_getprop p_def2, 3, myid, mymodel
	aht_getprop p_def3, 4, myid, mymodel
	curbak = getpath(dir_cur,16)+"\\"

	gsel pscr,1
	dialog p_def2,16,p_def3
	if stat {
		gsel 1
		fname=getpath(refstr,32+16)
		objprm p_obj(myid),getpath(refstr,8+16)

		;	カレントからの相対パスになるか?
		if strmid(fname,0,strlen(curbak))=curbak {
			fname=strmid(fname,strlen(curbak),255)
		}
		objprm p_obj(myid+1),fname
	}
	chdir curbak
	return

*obj_getid
	;	objectID(objid)からPropertyIDを得る
	;
	myid = -1
	repeat pmax
		if p_obj(cnt)=objid : myid=cnt
	loop
	return


#deffunc tmsetprop int _p1
	;
	;	編集したプロパティを設定
	;
	repeat pmax
		aht_getproptype p_type, cnt, _p1
		if p_type=AHTTYPE_EDIT_INT : gosub *cnvi2s
		if p_type=AHTTYPE_CHKB_INT : gosub *cnvi2s
		if p_type=AHTTYPE_EDIT_DOUBLE : gosub *cnvd2s
		if p_type=AHTTYPE_CBOX_STRING {
			aht_getprop p_def2, 3, cnt, _p1
			gosub *cnv_cb2s
		}
		if p_type=AHTTYPE_PARTS_INT {
			aht_getprop p_def2, 3, cnt, _p1
			aht_listparts p_def3, p_def2
			gosub *cnv_parts2s
		}
		aht_setprop p_def(cnt), cnt, _p1
	loop
	return

*cnvi2s
	;	パラメーター(int)を文字列に変換
	p_def(cnt)=""+p_defi(cnt)
	return
*cnvd2s
	;	パラメーター(double)を文字列に変換
	p_def(cnt)=""+p_defd(cnt)
	return
*cnv_cb2s
	;	パラメーター(int)を文字列に変換
	if p_def2="" : goto *cnvi2s
	notesel p_def2
	noteget p_def(cnt), p_defi(cnt)
	return
*cnv_parts2s
	;	パラメーター(int)を文字列に変換
	notesel p_def3
	noteget p_def(cnt), p_defi(cnt)
	i_parts = 0+p_def(cnt)
	return


#deffunc tmmake int _p1, int _p2

	;
	;	AHTからソースを出力
	;	tmmake ID, mode
	;	( mode:bit0=normal/bit1=ahtout/bit2=Make buffer out)
	;
	aht_make res, "ahtout", _p1, _p2
	aht_stdsize size
	sdim stdbuf, size
	aht_stdbuf stdbuf
	return res


;-------------------------------------------------------------------------

#deffunc scrinit

	;
	;	画像の初期化
	;
	buffer 5
	picload "ahtman_wnd.bmp"
	pssx=640:pssy=384
	osx=64:osy=64
	;
	buffer 3
	picload "ahticon.bmp"
	;
	buffer 4
	picload "ahtman640.bmp"
	;
	msx=800:msy=600
	clx=22:cly=22:clsx=640:clsy=480
	clex=clsx+clx-osx
	cley=clsy+cly-osy-20
	;
	return


#deffunc scrparts_dir int _p1

	;	パーツフォルダ変更
	;
	sdim ahtlist,256
	pfolder="aht\\"
	if _p1>0 {
		notesel ahtdirs
		noteget fname, _p1
		pfolder+=fname+"\\"
	}
	dirlist ahtlist, dir_exe+"\\"+pfolder+"*.aht"
	parts_max = stat
	aht_parts dir_exe+"\\"+pfolder, ahtlist
	parts_page=0
	return


#deffunc scrparts

	;
	;	パーツ画面
	;
	screen 6,pssx,pssy
	title "Parts list"
	;
	sdim ahtdirs,256
	dirlist ahtdirs, dir_exe+"\\aht\\*.*",5
	ahtdirs="基本パーツ\n"+ahtdirs
	scrparts_dir 0
	;
	return


#deffunc scrparts_sel int _p1

	;
	;	パーツ決定
	;
	clsel_bak = clsel

	notesel ahtlist
	noteget fname, _p1

	tmload m, fname,pfolder,-1
	if tmload_res != 0 {
		dialog stdbuf
		return
	}
	;
	if clsel_bak>=0 {
		aht_linkmod clsel_bak, m
	}
	;
	return


#deffunc dlg_notice str _p1

	;	汎用ダイアログを出す
	;
	screen 6,320,120,8,ginfo_wx1,ginfo_wy1
	syscolor 15:boxf
	title ""
	sysfont 17:color 0,0,0
	pos 8,12
	mes _p1
	objsize 120,24
	pos 180,60
	return

#deffunc dlg_done

	;	汎用ダイアログを閉じる
	;
	gsel 6,-1
	gsel 0, 1
	return


#deffunc scrmain

	;
	;	メイン画面
	;
	screen 0,msx,msy
	gmode 0,msx,msy
	pos 0,0:gcopy 4,0,0
	mmax = 0
	clbtn = 0
	clsel = -1
	clcmd = 0
	clpage = 0
	clpage_max = 0

	title APPNAME
	sdim stbuf,256
	sdim prjname,256

	pos 18,520
	mesbox stbuf,648,50
	sysfont 17
	objsize 96,22,24
	pos 680,24
	button gosub "読み込み",*nocmd
	button gosub "保存",*nocmd
	button gosub "別名保存",*nocmd
	objsize 96,64
	button gosub "実行",*nocmd

	objsize 96,22,24
	pos 680,216
	button gosub "追加",*nocmd
	objsize 96,64,66
	button gosub "編集",*nocmd
	objsize 96,22,24
	button gosub "接続",*nocmd
	button gosub "切断",*nocmd
	button gosub "削除",*nocmd

	pos 680,400
	input num_page : objid_num_page = stat
	button gosub "ページ",*nocmd
	objsize 48,22,24
	pos 680,448
	button gosub "<-",*nocmd
	pos 680+48,448
	button gosub "->",*nocmd

	pos 680,472
	button gosub "Home",*nocmd
	pos 680+48,472
	button gosub "?",*nocmd

	pselflag = 1

	return

*nocmd
	clcmd = stat
	return


#deffunc objput int _p1, int _p2, int _p3, int _p4

	;
	;	モデルオブジェクトの表示
	;	objput x,y,icon,selflag
	;	(fnameにファイル名を代入しておく)
	;
	pos _p1,_p2:gmode 2,osx,osy
	gcopy 3,_p3*osx,0
	_x=_p1+32-strlen(fname)*3:
	_y=_p2+68
	color 0,0,0
	pos _x+1,_y+1:mes fname
	color 255,255,255
	pos _x,_y:mes fname

	if _p4=0 : return

	;	選択枠
	color 255,0,0
	_x=_p1+64:_y=_p2+64
	line _p1,_p2,_x,_p2
	line _p1,_y,_x,_y
	line _p1,_p2,_p1,_y
	line _x,_p2,_x,_y

	return


#deffunc selinfo int _p1

	;	パーツ選択された時の情報表示
	;
	if _p1<0 : return
	;
	aht_getopt class,"class",_p1,128
	aht_getopt fname,"name",_p1,256
	aht_getopt exp,"exp",_p1,1024
	;
	stbuf="[ "+fname+" ] (ID"+_p1+") ["+class+"]\n"+exp
	;
	gsel 0
	objprm 0,stbuf
	return


#deffunc selflag int _p1

	;	パーツ選択の許可/不許可
	;	(1=OK/0=NG)
	pselflag = _p1
	return

#deffunc scr_update

	;
	;	メイン画面更新
	;
	gsel 0
	redraw 0
	gmode 0,clsx+64,clsy+64
	pos 0,0:gcopy 4

	;	info
	fname="Page "+clpage+"/"+clpage_max
	x=580:y=cly+8
	color 0,0,0
	pos x+1,y+1:mes fname
	color 255,255,255
	pos x,y:mes fname

	;	initalize
	ptx=mousex:pty=mousey
	clcmd = 0
	cldrag=-1

	;	icon put
	aht_getmodcnt mmax
	sysfont 17
	repeat mmax
		; maxisにModel情報が代入されています
		; (0)=X座標,(1)=Y座標,(2)=ICON,(3)=ページ,(4)=NextID,(5)=PrevID
		aht_getmodaxis maxis, cnt
		if stat : continue		; Model未登録の場合はスキップ
		if clpage!=maxis(3) : continue	; ページが異なる場合はスキップ
		aht_getopt fname,"name",cnt,260
		x=maxis
		y=maxis(1)
		if (ptx>=x)&(pty>=y) {
			if (ptx<(x+64))&(pty<(y+64)) {
				cldrag=cnt
			}
		}
		objput x,y,maxis(2),cnt=clsel

		if maxis(4)>=0 {
			aht_getmodaxis maxis2, maxis(4)
			color 255,255,255
			line x+64,y+28,maxis2+4,maxis2(1)+28
		}
	loop

	redraw 1

	stick key,$3ff
	on clbtn gosub *cl_0,*cl_1

	return

*cl_0
	if (key&$100)=0 : return
	if cldrag<0 : return
	if pselflag = 0 : return
	if clsel!=cldrag : selinfo cldrag
	clbtn=1:clsel=cldrag
	aht_getmodaxis maxis, clsel
	clbtnx=ptx-maxis:clbtny=pty-maxis(1)
	return
*cl_1
	if (key&$100)=0 : clbtn=0 : return

	x=limit(ptx-clbtnx,clx,clex)
	y=limit(pty-clbtny,cly,cley)
	aht_setmodaxis clsel,x,y,clpage

	return
*cl_2
	return



#deffunc scrp_update

	;
	;	パーツ画面更新
	;
	gsel 6
	redraw 0
	gmode 0,pssx,pssy
	pos 0,0:gcopy 5,0,0
	sysfont 17
	notesel ahtlist
	ptx=mousex:pty=mousey
	cldrag=-1
	i=parts_page
	repeat 20
		if i>=parts_max : break
		x=(cnt\5)*80+40
		y=(cnt/5)*80+32
		if (ptx>=x)&(pty>=y) {
			if (ptx<(x+64))&(pty<(y+64)) {
				cldrag=i
			}
		}
		aht_getparts i, icon,fname,clsname
		objput x,y,icon,cldrag=i
		i++
	loop

	redraw 1

	return


#deffunc chg_page int _p1

	;	ページ変更
	;	(_p1=ページ相対値/0の場合は入力値)
	;
	if _p1=0 {
		clpage = num_page
		if clpage>clpage_max : clpage_max = clpage
	} else {
		clpage+=_p1
	}
	if clpage<0 : clpage=0
	if clpage>clpage_max : clpage=clpage_max
	aht_setpage clpage, clpage_max
	clsel = -1				; 選択を解除
	objprm objid_num_page, clpage
	return


#deffunc edit_src int _p1

	;
	;	ソース編集
	;
	;
	aht_getopt fname,"source",_p1,260
	exec "hsed3f aht\\"+fname
	return

#deffunc screxec int _p1

	;
	;	AHT実行
	;
	;
	if prjname = "" : dialog "プロジェクトが保存されていません。",1 : return
	;
	ahtbase=getpath(prjname,1)+".hsp"
	;
	aht_makeinit
	;
	aht_findstart
	makeerr=0
	repeat
		aht_findparts findid
		findres = stat
		if findid<0 : break

		aht_getmodaxis maxis, findid
		if stat : continue		; Model未登録の場合はスキップ

		aht_propupdate findid		; 動的プロパティの更新

		aht_getopt fname,"name",findid,255
		aht_makeput ";-------main:"+fname+"(ID"+cnt+")",0
		aht_makeput ";-------init:"+fname+"(ID"+cnt+")",1

		tmmake findid, 4
		if stat : makeerr=findid : break

		if maxis(4)<0 {			; リンクの終端か?
			if findres & 1 {
				aht_makeput "return",0
			} else {
				aht_makeput "stop",0
			}
		}

	loop
	aht_findend i
	if i : return				; エラーが発生した場合
	;
	aht_makeput ";-------entry point",1
	aht_makeput "goto _ahtstart",1
	;
	aht_makeend ahtbase
	;
	gsel 0
	objprm 0,stdbuf
	if makeerr {
		dialog "AHTファイルの変換中にエラーが発生しました。(ID"+makeerr+")"
		return
	}
	;
#ifdef EXEC_DEBUG
	exec "notepad "+ahtbase
	return
#endif
	;
	;	HSP3ソーススクリプトをコンパイルして実行する
	;	(スクリプトエディタのコンパイル+実行と同じ動作を行ないます)
	;
	sdim rtname,256
	objname="obj"			; オブジェクトファイル名
	;
	hsc_ini ahtbase
	hsc_clrmes
	hsc_objname objname
	hsc_comp 0
	res=stat

	hsc3_messize size
	sdim stdbuf, size
	hsc_getmes stdbuf

	if res!=0 {
		dialog "実行時にエラーが発生しました。\n"+stdbuf
		return
	}
	hsc3_getruntime rtname, objname
	if rtname="" : rtname="hsp3.exe"
	debug_mode=0			; デバッグウィンドウ表示フラグ
	;
	cmdexe = dir_exe+"\\"+rtname+" \""+dir_cur+"\\"+objname+"\""
	hsc3_run cmdexe, debug_mode
	;
	return


#deffunc prjload str _fname

	;
	;	プロジェクトをロード
	;	(_fnameが""の時はダイアログを出す)
	;
	sdim mdlname,256
	sdim mdlpath,256

	if _fname="" {
		dialog "peas",16,"PeaSプロジェクトファイル"
		if stat=0 : return 1
		fname = getpath(refstr,32+16)
		prjname = getpath(refstr,8+16)
	} else {
		fname = getpath(_fname,32+16)
		prjname = getpath(_fname,8+16)
	}
	chdir fname
	aht_prjload prjname
	if stat : prjname="" : dialog "プロジェクトロード時にエラーが発生しました。" : return -1
	gsel 0
	title prjname + " - " + APPNAME
	aht_getprjmax res		; パーツ数の取得
	;dialog "PARTS="+res
	repeat res
		aht_getprjsrc mdlname,mdlpath,mdlid,cnt	; パーツ名、パス名、IDの取得
		;dialog "LOAD PARTS="+mdlname+"/"+mdlpath+"/"+mdlid
		tmload i, mdlname,mdlpath,mdlid	; パーツ読み込み
		if i<0 : dialog "読み込み中にエラーが発生しました。["+mdlname+"]" : break
		;dialog "APPLY PARTS="+i
		aht_prjload2 i,cnt	; パラメーターの反映
	loop
	aht_prjloade			; あとしまつ
	aht_getpage clpage, clpage_max	; ページ情報を取得
	return


#deffunc prjsave int _p1

	;
	;	プロジェクトをセーブ
	;	(mode:0=save/1=save as)
	res = _p1
	if prjname = "" : res=1
	if res {
		dialog "peas",17,"PeaSプロジェクトファイル"
		if stat=0 : return 1
		fname = getpath(refstr,32+16)
		prjname = getpath(refstr,8+1+16)+".peas"
		chdir fname
	}
	aht_prjsave prjname
	if stat : prjname="" : return -1
	gsel 0
	title prjname + " - " + APPNAME
	return 0

;-------------------------------------------------------------------------

#global

