
#ifndef __mod_img__
#define __mod_img__

#module "mod_imgctx"

#define IID_IImgCtx   "{3050f3d7-98b5-11cf-bb82-00aa00bdce0b}"
#define CLSID_IImgCtx "{3050f3d6-98b5-11cf-bb82-00aa00bdce0b}"

#usecom  ImgCtx IID_IImgCtx CLSID_IImgCtx
#comfunc IImgCtx_Load 3 wstr,int
#comfunc IImgCtx_GetStateInfo 8 var,var,int
#comfunc IImgCtx_StretchBlt 12 int,int,int,int,int,int,int,int,int,int

#deffunc imgload str _p1

	;
	;	ImgCtxを利用して画像ファイルを読み込みます
	;	imgload "ファイル名"
	;	(BMP,JPEG,GIF,ICO,PNGフォーマットを読み込み可能)
	;
	fname=_p1
	fpath=getpath( fname,32 )
	if fpath="" : fname = dir_cur + "\\" + fname
	;
	newcom pImage,ImgCtx
	IImgCtx_Load pImage,fname,0

	dim size,4
	repeat
		IImgCtx_GetStateInfo pImage,flg,size,1
		if ( flg & 0x00200000 )==0 : break
		wait 4
	loop

	IImgCtx_GetStateInfo pImage,flg,size,0
	IImgCtx_StretchBlt pImage,hdc,0,0,size(0),size(1),0,0,size(0),size(1),0xCC0020
	redraw 1

	delcom pImage
	return

#global

#endif


