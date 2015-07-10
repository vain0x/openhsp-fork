;
; HGIMG4 Default define and macros
;
#ifndef __hgimg4__
#define __hgimg4__
#define __hsp3dish__
#define global _HSP3DISH
#define global _HGIMG4

#runtime "hsp3gp"

#const global FILTER_NONE 0
#const global FILTER_LINEAR 1
#const global FILTER_LINEAR2 2

#const global CLSMODE_NONE 0
#const global CLSMODE_SOLID 1
#const global CLSMODE_TEXTURE 2
#const global CLSMODE_BLUR 3

#const global OBJ_HIDE 1
#const global OBJ_CLIP 2
#const global OBJ_XFRONT 4
#const global OBJ_WIRE 8
#const global OBJ_MOVE 32
#const global OBJ_FLIP 64
#const global OBJ_BORDER 0x80
#const global OBJ_2D 0x100
#const global OBJ_TIMER 0x200
#const global OBJ_SORT 0x400
#const global OBJ_LATE 0x4000

#const global GPOBJ_SCENE  0x100001
#const global GPOBJ_CAMERA 0x100002
#const global GPOBJ_LIGHT  0x100003

#const global GPOBJ_MATOPT_NOLIGHT (1)
#const global GPOBJ_MATOPT_NOMIPMAP (2)
#const global GPOBJ_MATOPT_NOCULL (4)
#const global GPOBJ_MATOPT_NOZTEST (8)
#const global GPOBJ_MATOPT_NOZWRITE (16)
#const global GPOBJ_MATOPT_BLENDADD (32)

#enum global PRMSET_FLAG = 0
#enum global PRMSET_MODE
#enum global PRMSET_ID
#enum global PRMSET_TIMER
#enum global PRMSET_ALPHA
#enum global PRMSET_MYGROUP
#enum global PRMSET_COLGROUP
#enum global PRMSET_SHAPE
#enum global PRMSET_USEGPMAT
#enum global PRMSET_USEGPPHY
#enum global PRMSET_COLILOG
#enum global PRMSET_SPRID = 0x100
#enum global PRMSET_SPRCELID
#enum global PRMSET_SPRGMODE

#define GPOBJ_LGTOPT_NORMAL (0)
#define GPOBJ_LGTOPT_POINT (1)
#define GPOBJ_LGTOPT_SPOT (2)

#enum global GPPSET_ENABLE = 0
#enum global GPPSET_FRICTION
#enum global GPPSET_DAMPING
#enum global GPPSET_KINEMATIC
#enum global GPPSET_ANISOTROPIC_FRICTION
#enum global GPPSET_GRAVITY
#enum global GPPSET_LINEAR_FACTOR
#enum global GPPSET_ANGULAR_FACTOR
#enum global GPPSET_ANGULAR_VELOCITY
#enum global GPPSET_LINEAR_VELOCITY

#const global GPPAPPLY_FORCE (0)
#const global GPPAPPLY_IMPULSE (1)
#const global GPPAPPLY_TORQUE (2)
#const global GPPAPPLY_TORQUE_IMPULSE (3)

#const global GPDRAW_OPT_OBJUPDATE (1)
#const global GPDRAW_OPT_DRAWSCENE (2)
#const global GPDRAW_OPT_DRAW2D (4)
#const global GPDRAW_OPT_DRAWSCENE_LATE (8)
#const global GPDRAW_OPT_DRAW2D_LATE (16)


;
;	system request
;
#enum global SYSREQ_MAXMODEL=1
#enum global SYSREQ_MAXOBJ
#enum global SYSREQ_MAXTEX
#enum global SYSREQ_MAXMOC
#enum global SYSREQ_DXMODE
#enum global SYSREQ_DXHWND
#enum global SYSREQ_DXWIDTH
#enum global SYSREQ_DXHEIGHT
#enum global SYSREQ_COLORKEY
#enum global SYSREQ_RESULT
#enum global SYSREQ_RESVMODE
#enum global SYSREQ_PKTSIZE
#enum global SYSREQ_MAXEVENT
#enum global SYSREQ_PTRD3D
#enum global SYSREQ_PTRD3DDEV
#enum global SYSREQ_MDLANIM
#enum global SYSREQ_CALCNORMAL
#enum global SYSREQ_2DFILTER
#enum global SYSREQ_3DFILTER
#enum global SYSREQ_OLDCAM
#enum global SYSREQ_QUATALG
#enum global SYSREQ_DXVSYNC
#enum global SYSREQ_DEFTIMER
#enum global SYSREQ_NOMIPMAP
#enum global SYSREQ_DEVLOST
#enum global SYSREQ_MAXEMITTER
#enum global SYSREQ_THROUGHFLAG
#enum global SYSREQ_OBAQMATBUF
#enum global SYSREQ_2DFILTER2
#enum global SYSREQ_FPUPRESERVE
#enum global SYSREQ_CLSMODE
#enum global SYSREQ_CLSCOLOR
#enum global SYSREQ_CLSTEX
#enum global SYSREQ_TIMER
#enum global SYSREQ_PLATFORM
#enum global SYSREQ_FPS
#enum global SYSREQ_VSYNC
#enum global SYSREQ_MAXMATERIAL

#define global ginfo_accx ginfo(0x100)
#define global ginfo_accy ginfo(0x101)
#define global ginfo_accz ginfo(0x102)

#define global SYSREQ_DEBUG $10000

#regcmd 9

#cmd gpreset $60
#cmd gpdraw $61
#cmd gpusescene $62
#cmd gpsetprm $63
#cmd gpgetprm $64
#cmd gppostefx $65
#cmd gpuselight $66
#cmd gpusecamera $67
#cmd gpmatprm $68
#cmd gpmatstate $69
#cmd gpviewport $6a
#cmd setobjname $6b
#cmd getobjname $6c
#cmd setborder $6d
#cmd findobj $6e
#cmd nextobj $6f

#cmd delobj $70
#cmd gpcolormat $71
#cmd gptexmat $72
#cmd gpusermat $73
#cmd gpclone $74
#cmd gpload $75
#cmd gpplate $76
#cmd gpfloor $77
#cmd gpbox $78
#cmd gpspr $79
#cmd gplight $7a
#cmd setobjmode $7b
#cmd gplookat $7c
#cmd gppbind $7d
#cmd gpcamera $7e
#cmd gpnull $7f

#cmd getpos $80
#cmd getquat $81
#cmd getscale $82
#cmd getdir $83
#cmd getefx $84
#cmd getcolor $85
#cmd getwork $86
#cmd getwork2 $87

#cmd getposi $90
#cmd getquati $91
#cmd getscalei $92
#cmd getdiri $93
#cmd getefxi $94
#cmd getcolori $95
#cmd getworki $96
#cmd getwork2i $97

#cmd selpos $a0
#cmd selquat $a1
#cmd selscale $a2
#cmd seldir $a3
#cmd selefx $a4
#cmd selcolor $a5
#cmd selwork $a6
#cmd selwork2 $a7

#cmd setpos $b0
#cmd setquat $b1
#cmd setscale $b2
#cmd setdir $b3
#cmd setefx $b4
#cmd setcolor $b5
#cmd setwork $b6
#cmd setwork2 $b7
#cmd setaxang $b8
#cmd setang $b9
#cmd setangy $ba
#cmd setangz $bb

#cmd addpos $c0
#cmd addquat $c1
#cmd addscale $c2
#cmd adddir $c3
#cmd addefx $c4
#cmd addcolor $c5
#cmd addwork $c6
#cmd addwork2 $c7
#cmd addaxang $c8
#cmd addang $c9
#cmd addangy $ca
#cmd addangz $cc

#cmd objsetf3 $d0
#cmd objaddf3 $d1
#cmd objsetfv $d2
#cmd objaddfv $d3
#cmd objgetfv $d4
#cmd setangr $d5
#cmd addangr $d6
#cmd selmoc $d7
#cmd gpcnvaxis $d8
#cmd getcoli $d9
#cmd setcoli $da
#cmd getobjcoli $db
#cmd objexist $dc

#cmd fvset $e0
#cmd fvadd $e1
#cmd fvsub $e2
#cmd fvmul $e3
#cmd fvdiv $e4
#cmd fvdir $e5
#cmd fvmin $e6
#cmd fvmax $e7
#cmd fvunit $e8
#cmd fvouter $e9
#cmd fvinner $ea
#cmd fvface $eb
#cmd fv2str $ec
#cmd f2str $ed
#cmd str2fv $ee
#cmd str2f $ef

#cmd gppset $f0
#cmd gpobjpool $f1
#cmd gppapply $f2
#cmd setalpha $f3
#cmd gpmatprm1 $f4
#cmd gpmatprm4 $f5

#define fsin(%1,%2) %1=sin(%2)
#define fcos(%1,%2) %1=cos(%2)
#define fsqr(%1,%2) %1=sqrt(%2)
#define froti(%1,%2) %1=%2/6433.98175455188992



#endif

