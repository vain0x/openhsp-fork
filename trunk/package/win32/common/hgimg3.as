;
; HGIMG3.21 define and macros
;
#ifndef __hgimg3__
#define __hgimg3__
#runtime "hsp3hg"

#const global FLAG_NONE 0
#const global FLAG_ENTRY 1
#const global FLAG_VISIBLE 2
#const global FLAG_MOVING 4

#const global OBJ_HIDE 1
#const global OBJ_TREE 2
#const global OBJ_XFRONT 4
#const global OBJ_MOVE 32
#const global OBJ_FLIP 64
#const global OBJ_BORDER 0x80
#const global OBJ_2D 0x100
#const global OBJ_SORT 0x400
#const global OBJ_STATIC 0x800
#const global OBJ_GRAVITY 0x1000
#const global OBJ_LATE 0x4000
#const global OBJ_FIRST 0x8000

#const global OBJ_STAND 0x10000
#const global OBJ_GROUND 0x20000
#const global OBJ_LAND 0x40000
#const global OBJ_LOOKAT 0x80000

#const global OBJ_BOUND 0x100000
#const global OBJ_ALIEN 0x200000
#const global OBJ_WALKCLIP 0x400000
#const global OBJ_EMITTER 0x800000

#const global SHADE_LINES	0x80
#const global SHADE_NOLIGHT	0x100
#const global SHADE_TOON	0x200

#enum global PRMSET_MODE = 0
#enum global PRMSET_FLAG
#enum global PRMSET_SHADE
#enum global PRMSET_TIMER
#enum global PRMSET_MYGROUP
#enum global PRMSET_COLGROUP

#const global HGOBJ_CAMERA 0
#const global HGOBJ_LIGHT 1

#const global CAM_MODE_NORMAL 0
#const global CAM_MODE_LOOKAT 1
#const global CAM_MODE_LOOKOBJ 2
#const global CAM_MODE_AUTOMOVE 3

#const global HGMODEL_ROTORDER_ZYX 0
#const global HGMODEL_ROTORDER_XYZ 1
#const global HGMODEL_ROTORDER_YXZ 2

#const global EPRIM_CIRCLE 0
#const global EPRIM_CIRCLE2 1
#const global EPRIM_SQUARE 2
#const global EPRIM_FAN 3
#const global EPRIM_LINE 4

#const global MOVEMODE_LINEAR 0
#const global MOVEMODE_SPLINE 1
#const global MOVEMODE_LINEAR_REL 2
#const global MOVEMODE_SPLINE_REL 3
#const global MOVEMODE_FROMWORK 16

;
;	system request
;
#define global SYSREQ_NONE 0
#define global SYSREQ_MAXMODEL 1
#define global SYSREQ_MAXOBJ 2
#define global SYSREQ_MAXTEX 3
#define global SYSREQ_MAXMOC 4
#define global SYSREQ_DXMODE 5
#define global SYSREQ_DXHWND 6
#define global SYSREQ_DXWIDTH 7
#define global SYSREQ_DXHEIGHT 8
#define global SYSREQ_COLORKEY 9
#define global SYSREQ_RESULT 10
#define global SYSREQ_RESVMODE 11
#define global SYSREQ_PKTSIZE 12
#define global SYSREQ_MAXEVENT 13
#define global SYSREQ_PTRD3D 14
#define global SYSREQ_PTRD3DDEV 15
#define global SYSREQ_MDLANIM 16
#define global SYSREQ_2DFILTER 18
#define global SYSREQ_3DFILTER 19
#define global SYSREQ_OLDCAM 20
#define global SYSREQ_QUATALG 21
#define global SYSREQ_DXVSYNC 22
#define global SYSREQ_DEFTIMER 23
#define global SYSREQ_NOMIPMAP 24
#define global SYSREQ_DEVLOST 25
#define global SYSREQ_MAXEMITTER 26
#define global SYSREQ_THROUGHFLAG 27
#define global SYSREQ_OBAQMATBUF 28
#define global SYSREQ_2DFILTER2 29
#define global SYSREQ_FPUPRESERVE 30
#define global SYSREQ_DSSOFTWARE 31
#define global SYSREQ_DSGLOBAL 32
#define global SYSREQ_DSBUFSEC 33
#define global SYSREQ_DEBUG $10000

#define global event_delobj(%1) event_prmset %1,PRMSET_FLAG,0

#regcmd 18
#cmd _hgini $00
#cmd hgreset $01
#cmd hgbye $02
#cmd hgsetreq $03
#cmd hggetreq $04
#cmd hgdraw $05
#cmd hgsync $06
#cmd hgrect $07
#cmd hgrotate $08
#cmd settex $0a
#cmd setfont $0b
#cmd falpha $0c
#cmd fprt $0d
#cmd setsizef $0e
#cmd setbg $0f
#cmd clscolor $10
#cmd clsblur $11
#cmd clstex $12
#cmd texmake $13
#cmd texcls $14
#cmd texmes $15
#cmd texdel $16
#cmd setuv $17
#cmd addspr $18
#cmd regobj $19
#cmd delobj $1a
#cmd addplate $1b
#cmd addsplate $1c
#cmd setcolor $1d
#cmd addbox $1e
#cmd addmesh $1f

#cmd setpos $20
#cmd setang $21
#cmd setscale $22
#cmd setdir $23
#cmd setefx $24
#cmd setwork $25

#cmd addpos $28
#cmd addang $29
#cmd addscale $2a
#cmd adddir $2b
#cmd addefx $2c
#cmd addwork $2d

#cmd getpos $30
#cmd getang $31
#cmd getscale $32
#cmd getdir $33
#cmd getefx $34
#cmd getwork $35

#cmd getposi $38
#cmd getangi $39
#cmd getscalei $3a
#cmd getdiri $3b
#cmd getefxi $3c
#cmd getworki $3d

#cmd selpos $40
#cmd selang $41
#cmd selscale $42
#cmd seldir $43
#cmd selefx $44
#cmd selwork $45

#define global selcpos selpos HGOBJ_CAMERA
#define global selcang selang HGOBJ_CAMERA
#define global selcint seldir HGOBJ_CAMERA

#define global sellpos selpos HGOBJ_LIGHT
#define global sellang selang HGOBJ_LIGHT
#define global sellcolor selscale HGOBJ_LIGHT
#define global sellambient seldir HGOBJ_LIGHT

#cmd objset1 $48
#cmd objsetf1 $48
#cmd objset1r $49
#cmd objset2 $4a
#cmd objsetf2 $4a
#cmd objset2r $4b
#cmd objset3 $4c
#cmd objsetf3 $4c
#cmd objset3r $4d
#cmd objadd1 $4e
#cmd objaddf1 $4e
#cmd objadd1r $4f
#cmd objadd2 $50
#cmd objaddf2 $50
#cmd objadd2r $51
#cmd objadd3 $52
#cmd objaddf3 $52
#cmd objadd3r $53

#cmd adddxf $60
#cmd modelscale $61
#cmd texload2 $62

#cmd event_wait $63
#cmd event_jump $64
#cmd event_prmset $65
#cmd event_prmon $66
#cmd event_prmoff $67
#cmd event_pos $68
#cmd event_ang $69
#cmd event_scale $6a
#cmd event_dir $6b
#cmd event_efx $6c
#cmd event_work $6d
#cmd event_angr $6f
#cmd event_addpos $70
#cmd event_addang $71
#cmd event_addscale $72
#cmd event_adddir $73
#cmd event_addefx $74
#cmd event_addwork $75
#cmd event_addtarget $76
#cmd event_addangr $77
#cmd event_setpos $78
#cmd event_setang $79
#cmd event_setscale $7a
#cmd event_setdir $7b
#cmd event_setefx $7c
#cmd event_setwork $7d
#cmd event_setangr $7f

#cmd setevent $80
#cmd delevent $81
#cmd cammode $82
#cmd addxfile $83
#cmd getmdiffuse $84
#cmd settoon $85
#cmd setmonotoon $86
#cmd settoonedge $87
#cmd event_uv $88
#cmd newevent $89
#cmd setangr $8a
#cmd addangr $8b
#cmd getangr $8c
#cmd setobjmode $8d
#cmd setobjmodel $8e
#cmd setcoli $8f
#cmd enumobj $90
#cmd getenum $91
#cmd bindxfile $92
#cmd addtexanim $93
#cmd settexanimfile $94
#cmd settexanimmode $95
#cmd hgcnvaxis $96


#cmd event_wpos $98
#cmd event_wang $99
#cmd event_wscale $9a
#cmd event_wdir $9b
#cmd event_wefx $9c
#cmd event_wwait $9d


#cmd fvset $9e
#cmd fvseti $9e
#cmd fvadd $9f
#cmd fvsub $a0
#cmd fvmul $a1
#cmd fvdiv $a2
#cmd fvdir $a3
#cmd fvmin $a4
#cmd fvmax $a5
#cmd fvunit $a6
#cmd fvouter $a7
#cmd fvinner $a8
#cmd fvface $a9

#define global fsin(%1,%2) %1=sin(%2)
#define global fcos(%1,%2) %1=cos(%2)
#define global fsqr(%1,%2) %1=sqrt(%2)
#define global froti(%1,%2) %1=%2/6433.98175455188992

#cmd fv2str $aa
#cmd f2str $ab
#cmd str2fv $ac
#cmd str2f $ad

#cmd objgetstr $ae
#cmd objgetfv $af
#cmd objgetv $b0
#cmd objsetfv $b1
#cmd objsetv $b2
#cmd objaddfv $b3

#cmd selmoc $b4
#cmd setborder $b5
#cmd findobj $b6
#cmd nextobj $b7
#cmd getcoli $b8
#cmd addxanim $b9
#cmd objact $ba
#cmd objspeed $bb
#cmd getanim $bc
#cmd modelspeed $bd
#cmd hgline $be
#cmd hgcapture $bf
#cmd reglight $c0
#cmd objlight $c1
#cmd getxinfo $c2
#cmd setxinfo $c3
#cmd getobjcoli $c4
#cmd getobjmodel $c5
#cmd setcolvec $c6
#cmd setcolscale $c6
#cmd modelcols $c7
#cmd objexist $c8
#cmd modelshade $c9
#cmd modelorder $ca
#cmd addeprim $cb
#cmd seteprim $cc
#cmd objproj $cd
#cmd event_regobj $ce
#cmd objchild $cf
#cmd event_eprim $d0
#cmd event_aim $d1
#cmd objaim $d2
#cmd hgprm $d3
#cmd event_objact $d4
#cmd texopt $d5
#cmd hgview $d6
#cmd hggettime $d7
#cmd hgsettime $d8
#cmd meshmap $d9
#cmd getvarmap $da
#cmd objwalk $db
#cmd objfloor $dc
#cmd getcolvec $dd
#cmd getnearobj $de
#cmd delmodel $df

#cmd dmmini $e0
#cmd dmmbye $e1
#cmd dmmreset $e2
#cmd dmmdel $e3
#cmd dmmvol $e4
#cmd dmmpan $e5
#cmd dmmloop $e6
#cmd dmmload $e7
#cmd dmmplay $e8
#cmd dmmstop $e9
#cmd dmmstat $ea

#cmd fire_init $100
#cmd fire_exec $101
#cmd fire_set $102
#cmd wave_init $103
#cmd wave_apply $104
#cmd wave_set $105
#cmd mosaic_draw $106
#cmd mosaic_set $107

#cmd hgobaq $108
#cmd hgceldiv $109
#const global mat_wire3 5
#const global mat_spr3 6

#define global EMITMODE_NONE	0
#define global EMITMODE_STATIC	1
#define global EMITMODE_CIRCLE	2
#define global EMITMODE_RANDOM	3
#define global EMITMODE_LOOKAT	16

#cmd newemit $10a
#cmd delemit $10b
#cmd emit_size $10c
#cmd emit_speed $10d
#cmd emit_angmul $10e
#cmd emit_angopt $10f
#cmd emit_model $110
#cmd emit_event $111
#cmd emit_num $112
#cmd emit_group $113
#cmd hgemit $114
#cmd setobjemit $115
#cmd groupmod $116
#cmd addobaq3d $117
#cmd obaqmat $118
#cmd hgqview $119
#cmd hgqcnvaxis $11a
#cmd addline $11b
#cmd hgcnvline $11c

#module "HGIMG"
#define global WORKSCR 3

#deffunc hgini int p1,int p2

	;	initalize
	;
	mref bm,67
	hgmode = bm.3
	_hgini p1,p2
	;
	hgsel=ginfo(3)
	buffer WORKSCR,128,128,hgmode
	gsel hgsel
	return


#deffunc texload str fn

	;	texture reg
	;
	gsel WORKSCR
	picload fn
	winx=ginfo(12):winy=ginfo(13)

	px=1:repeat 12
	if px>=winx : break
	px=px<<1:loop
	py=1:repeat 12
	if py>=winy : break
	py=py<<1:loop
	if ( px!=winx )|( py!=winy ) {	; 2^nƒTƒCƒY‚Å‚È‚¢Žž‚Í•â³
		buffer WORKSCR,px,py,hgmode
		cls 4
		picload fn,1
	}
	settex winx,winy
	if stat<0 : dialog "Texture Error("+stat+")" { gsel hgsel : return }
	i=stat
	await 0
	gsel hgsel
	return i


#deffunc loadtoon int p1,str fn

	;	Apply Toon Texture
	;
	gsel WORKSCR
	if fn!="" : picload fn
	winx=ginfo(12):winy=ginfo(13)
	settex winx,winy
	if stat<0 : dialog "Texture Error("+stat+")" : gsel hgsel : return
	texid=stat

	dim coltable,256
	maxcolor=(winy/8)
	repeat maxcolor
		y=cnt*8:pget 0,y
		coltable.cnt=(ginfo(16)<<16)|(ginfo(17)<<8)|ginfo(18)
		;dialog strf("#%x",coltable.cnt)
	loop
	settoon p1,coltable,maxcolor,texid
	gsel hgsel
	return


#deffunc preloadtoon str fn

	;	Apply Toon Texture
	;
	gsel WORKSCR
	picload fn
	winx=ginfo(12):winy=ginfo(13)
	settex winx,winy
	if stat<0 : dialog "Texture Error("+stat+")" : gsel hgsel : return
	texid=stat
	dim coltable,256
	maxcolor=(winy/8)
	repeat maxcolor
		y=cnt*8:pget 0,y
		coltable.cnt=(ginfo(16)<<16)|(ginfo(17)<<8)|ginfo(18)
		;dialog strf("#%x",coltable.cnt)
	loop
	gsel hgsel
	return


#deffunc presettoon int p1, int p2
	setmonotoon p1, $ffffff, p2, texid
	return


#deffunc maketoon int p1,int p2

	;	Make a Toon Texture
	;
	dim coltable,1024
	getmdiffuse coltable, p1
	maxcolor=stat
	i=maxcolor*8
	py=1:repeat 12
	if py>=i : break
	py=py<<1:loop
	if py<128 : py=128

	buffer WORKSCR,128,py,0
	;screen 2,128,py,0
	cls 1

	i=0:x1=40:x2=128
	repeat maxcolor
		y=i*8:col=coltable.cnt
		repeat cnt
		if col=coltable.cnt : y=-1
		loop
		if y>=0 {
			;cstr=0:cstr=col:str cstr,8+16
			;wbuf+="#"+i+":"+cstr+"\n"
			c1=col&255:c2=(col>>8)&255:c3=(col>>16)&255
			color c3>>1,c2>>1,c1>>1
			boxf 0,y+4,x1,y+8
			color c3,c2,c1
			boxf x1,y+4,x2,y+8
			boxf 0,y,x2,y+3
			i++
		}
	loop
	;bsave "a.txt",wbuf

	if p2&1 {
		settex 128,py
		if stat<0 : dialog "Texture Error("+stat+")" : gsel hgsel : return
		texid=stat
		maxcolor=(py/8)
		repeat maxcolor
			y=cnt*8:pget 0,y
			coltable.cnt=(ginfo(16)<<16)|(ginfo(17)<<8)|ginfo(18)
		loop
		settoon p1,coltable,maxcolor,texid
	}
	if p2&2 {
		bmpsave "toon.bmp"
	}

	gsel hgsel
	return


#deffunc dxfload str fn,int p1

	;	DXF model load
	;
	exist fn
	if strsize<0 : dialog "No file:"+fname : end
	sdim dxfbuf,strsize
	bload fn,dxfbuf
	_dxfcolor = p1
	if _dxfcolor = 0 {
		_dxfcolor = -1
	}
	adddxf _dxfmdl, dxfbuf, _dxfcolor
	sdim dxfbuf,64
	return _dxfmdl


#global


#endif

