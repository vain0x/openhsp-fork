
;	hgimg.dll header
;	(for HSP3.0 or later)
;

#uselib "hgimg.dll"
#func _hgini hgini 2
#func hgsrc hgsrc 2
#func hgdst hgdst 2
#func hgdraw hgdraw 0
#func hgsync hgsync 2
#func hgbye hgbye $100
#func getsync getsync 1
#func sync sync 0
#func getdebug getdebug 1
#func hgsetreq hgsetreq 0
#func hggetreq hggetreq 1

#func setborder setborder 0
#func clscolor clscolor 0
#func clstex clstex 0
#func setfont setfont 0
#func fprt fprt 6

#func objset1 objset1 0
#func objadd1 objadd1 0
#func objmov1 objmov1 0
#func objsetf1 objsetf1 int,float,int,int
#func objaddf1 objaddf1 int,float,int,int
#func objmovf1 objmovf1 int,int,float,int
#func objcheck objcheck 1
#func objmovmode objmovmode 0
#func objmovopt objmovopt 0

#func objset2 objset2 0
#func objadd2 objadd2 0
#func objmov2 objmov2 0
#func objsetf2 objsetf2 int,float,float,int
#func objaddf2 objaddf2 int,float,float,int
#func objmovf2 objmovf2 int,int,float,float

#func objset3 objset3 0
#func objadd3 objadd3 0
#func objmov3 objmov3 0
#func objsetf3 objsetf3 float,float,float,int
#func objaddf3 objaddf3 float,float,float,int
#func objmovf3 objmovf3 int,float,float,float

#func selmoc selmoc 0
#func selpos selpos 0
#func selang selang 0
#func selscale selscale 0
#func seldir seldir 0

#func objgetfv objgetfv 1
#func objgetv objgetv 1
#func objsetfv objsetfv 1
#func objsetv objsetv 1
#func objaddfv objaddfv 1
#func objmovfv objmovfv 1
#func objgetstr objgetstr 1
#func objact objact 0

#func fvset fvset var,float,float,float
#func fvseti fvseti 1
#func fvadd fvadd var,float,float,float
#func fvsub fvsub var,float,float,float
#func fvmul fvmul var,float,float,float
#func fvdiv fvdiv var,float,float,float
#func fvdir fvdir var,float,float,float
#func fvget fvget var,float,float,float
#func fvmin fvmin var,float,float,float
#func fvmax fvmax var,float,float,float
#func fvouter fvouter var,float,float,float
#func fvinner fvinner var,float,float,float
#func fvunit fvunit var,float,float,float
#func fvface fvface var,float,float,float
#func fv2str fv2str $11
#func f2str f2str $11
#func str2f str2f 5
#func str2fv str2fv 5
#func f2i f2i 1
#func fsin fsin var,float,int,int
#func fcos fcos var,float,int,int
#func fsqr fsqr var,float,int,int
#func fadd fadd var,float,int,int
#func fsub fsub var,float,int,int
#func fmul fmul var,float,int,int
#func fdiv fdiv var,float,int,int
#func fcmp fcmp var,float,float,int
#func froti froti 1

#func setuv setuv 0
#func setsizef setsizef float,float,int,int
#func setbg setbg 0
#func getbg getbg $83
#func setmap setmap 0
#func addbox addbox 1
#func addplate addplate 1
#func addspr addspr 1
#func addbg addbg 1
#func regobj regobj 1
#func delobj delobj 0
#func setobjm setobjm 0
#func uvanim uvanim 0
#func setmode setmode 0
#func settimer settimer 0
#func setobjmode setobjmode 0
#func setcoli setcoli 0
#func getcoli getcoli var,int,float,int
#func findobj findobj 0
#func nextobj nextobj 1

#func evmodel evmodel 0
#func setmtex setmtex 0
#func getmtex getmtex 1

#func cammode cammode 0
#func selcam selcam 0
#func selcpos selcpos 0
#func selcang selcang 0
#func selcint selcint 0

#func copybuf copybuf 2

#func mxsend mxsend 1
#func mxconv mxconv 1
#func mxaconv mxaconv 1
#func mxgetpoly mxgetpoly 1
#func mxgetname mxgetname 1
#func settex settex 2
#func gettex gettex 1

#func addmesh addmesh 1

;
;	new function on 2.6
;
#func modelmovef modelmovef int,float,float,float
#func modelshade modelshade 0
#func dxfconv dxfconv 1
#func dxfgetpoly dxfgetpoly 1
#func objscanf2 objscanf2 var,float,float,int
#func objscan2 objscan2 1
#func mxsave mxsave 6
#func setmchild setmchild 0
#func setmsibling setmsibling 0
#func getmchild getmchild 1
#func getmsibling getmsibling 1
#func setmfv setmfv 1
#func getmfv getmfv 1
#func getmodel getmodel 1
#func putmodel putmodel 1
#func dupnode dupnode $83
#func gettree gettree 1
#func hgreset hgreset 2
#func mxtex mxtex 1
#func setmuv setmuv 1
#func getmuv getmuv 1
#func nodemax nodemax 1
#func getmpoly getmpoly 1
#func setmpoly setmpoly 1

#func objset1r objset1r 0
#func objmov1r objmov1r 0
#func objset2r objset2r 0
#func objmov2r objmov2r 0
#func objset3r objset3r 0
#func objmov3r objmov3r 0

#func sellight sellight 0
#func sellpos sellpos 0
#func sellang sellang 0
#func sellcolor sellcolor 0
#func selefx selefx 0
#func falpha falpha 0
#func setcolor setcolor 0
#func clsblur clsblur 0

;
;	new function on 2.61
;
#func modelscalef modelscalef int,float,float,float

;
;	camera mode
;
#define CAM_MODE_NORMAL 0
#define CAM_MODE_LOOKAT 1

;
;	object mode
;
#define OBJ_HIDE 1
#define OBJ_TREE 2
#define OBJ_XFRONT 4
#define OBJ_UVANIM 8
#define OBJ_UVANIM_1SHOT 16
#define OBJ_MOVE 32
#define OBJ_FLIP 64
#define OBJ_BORDER 0x80
#define OBJ_2D 0x100
#define OBJ_TIMER 0x200
#define OBJ_WIPEBOM 0x400
#define OBJ_NOSORT 0x800
#define OBJ_GRAVITY 0x1000
#define OBJ_SKY 0x2000
#define OBJ_GROUND 0x4000

#define OBJMOV_STATIC 1
#define OBJMOV_LINEAR 2
#define OBJMOV_SPLINE 16

#define OBJMOV_OPT_AUTOKEY 0x400
#define OBJMOV_OPT_PARENT 0x2000
#define OBJMOV_OPT_REVERSE 0x4000
#define OBJMOV_OPT_ETERNAL 0x8000

;
;	model create mode
;
#define MODEL_TEXRGB0 1
#define MODEL_SHADE 2

;
;	model shade mode
;
#define SHADE_NONE 0
#define SHADE_FLAT 1
#define SHADE_GOURAUD 2

;
;	node mode
;
#define NODE_ATTR_COLKEY 0x8000

;
;	system request
;
#define SYSREQ_NONE 0
#define SYSREQ_MAXMODEL 1
#define SYSREQ_MAXOBJ 2
#define SYSREQ_MAXTEX 3
#define SYSREQ_MAXMOC 4
#define SYSREQ_DXMODE 5
#define SYSREQ_DXHWND 6
#define SYSREQ_DXWIDTH 7
#define SYSREQ_DXHEIGHT 8
#define SYSREQ_COLORKEY 9
#define SYSREQ_PKTSIZE 12


#module "HGIMG"

#deffunc hgini int,int

	;	initalize
	;
	mref p1,0
	mref p2,1
	mref bm,67
	hgmode = bm.3
	_hgini@ hgmode,p1,p2
	return


#deffunc texload str fn

	;	texture reg
	;
	buffer 3,100,100,hgmode
	picload fn
	settex@ ginfo(12),ginfo(13)
	if stat : dialog "Texture Error("+stat+")" : return
	return


#deffunc texloadbg str fn

	;	texture reg
	;
	buffer 3,100,100,hgmode
	picload fn
	clstex@
	settex@ ginfo(12),ginfo(13),1
	if stat : dialog "Texture Error("+stat+")" : return
	return


#deffunc mxload str fn,int

	;	model load
	;
	mref p2,1
	mref _mdid,64
	fname = fn+".mx"
	exist fname
	if strsize<0 : dialog "file error ["+fname+"]" : end
	sdim buf,strsize
	s1=""
	bload fname,buf
	mxsend@ buf,p2
	buffer 3,100,100,hgmode
	repeat
		mxgetname@ s1,cnt : if s1="" : break
		exist s1+".bmp"
		if strsize<0 : dialog "No file ["+s1+"]" : end
		texload s1+".bmp"
	loop
	mxconv@ mdid@		; コンバート開始
	mxgetpoly@ polys@	; ポリゴン数を得る
	sdim buf,64
	_mdid = mdid@
	return


#deffunc maload str fn
	;	model animation load
	;
	fname = fn+".ma"
	exist fname
	if strsize<0 : dialog "file error ["+fname+"]" : end
	sdim buf,strsize
	bload fname,buf
	mxaconv@ buf
	sdim buf,64
	return


#deffunc dxfload str fn

	;	DXF model load
	;
	mref _mdid,64
	fname = fn+".dxf"
	exist fname
	if strsize<0 : dialog "file error ["+fname+"]" : end
	sdim buf,strsize
	s1=""
	bload fname,buf
	dxfconv@ buf
	mdid@ = stat
	dxfgetpoly@ polys@	; ポリゴン数を得る
	_mdid = mdid@
	return



#global

