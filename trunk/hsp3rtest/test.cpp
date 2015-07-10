//
//	hsp3cnv generated source
//	[test.ax]
//
#include "hsp3r.h"

#define _HSP3CNV_DATE "2011/03/04"
#define _HSP3CNV_TIME "19:32:56"
#define _HSP3CNV_MAXVAR 84
#define _HSP3CNV_MAXHPI 0
#define _HSP3CNV_VERSION 0x301
#define _HSP3CNV_BOOTOPT 4096

/*-----------------------------------------------------------*/

static PVal *Var_gr;
static PVal *Var_gy;
static PVal *Var_gd;
static PVal *Var_ctx;
static PVal *Var_ctz;
static PVal *Var_sunx;
static PVal *Var_suny;
static PVal *Var_sunz;
static PVal *Var_nobstacles;
static PVal *Var_r;
static PVal *Var_ox;
static PVal *Var_oy;
static PVal *Var_oz;
static PVal *Var_os;
static PVal *Var_ocr;
static PVal *Var_ocg;
static PVal *Var_ocb;
static PVal *Var_cx;
static PVal *Var_cy;
static PVal *Var_cz;
static PVal *Var_omx;
static PVal *Var_mx;
static PVal *Var_omy;
static PVal *Var_my;
static PVal *Var_mw;
static PVal *Var_obt;
static PVal *Var_bt;
static PVal *Var_step;
static PVal *Var_w;
static PVal *Var_h;
static PVal *Var_zoom;
static PVal *Var_ru;
static PVal *Var_rd;
static PVal *Var_vox;
static PVal *Var_voz;
static PVal *Var_gx;
static PVal *Var_gz;
static PVal *Var_sel;
static PVal *Var_dx;
static PVal *Var_v;
static PVal *Var_orgxv;
static PVal *Var_orgyv;
static PVal *Var_mode;
static PVal *Var_hit;
static PVal *Var_starttime;
static PVal *Var_py;
static PVal *Var_px;
static PVal *Var_lr;
static PVal *Var_lg;
static PVal *Var_lb;
static PVal *Var_sr;
static PVal *Var_sg;
static PVal *Var_sb;
static PVal *Var_yv;
static PVal *Var_l;
static PVal *Var_xv;
static PVal *Var_zv;
static PVal *Var_col;
static PVal *Var_fg;
static PVal *Var_t;
static PVal *Var_y;
static PVal *Var_x;
static PVal *Var_z;
static PVal *Var_nhit;
static PVal *Var_n0d;
static PVal *Var_n0c;
static PVal *Var_endtime;
static PVal *Var_minv;
static PVal *Var_dy;
static PVal *Var_dz;
static PVal *Var_b;
static PVal *Var_d;
static PVal *Var_c;
static PVal *Var_f;
static PVal *Var_nx;
static PVal *Var_ny;
static PVal *Var_nz;
static PVal *Var_e;
static PVal *Var_nc;
static PVal *Var_nd;
static PVal *Var_oxv;
static PVal *Var_oyv;
static PVal *Var_ozv;
static PVal *Var_a;

/*-----------------------------------------------------------*/

void __HspEntry( void ) {
	// Var initalize
	Var_gr = &mem_var[0];
	Var_gy = &mem_var[1];
	Var_gd = &mem_var[2];
	Var_ctx = &mem_var[3];
	Var_ctz = &mem_var[4];
	Var_sunx = &mem_var[5];
	Var_suny = &mem_var[6];
	Var_sunz = &mem_var[7];
	Var_nobstacles = &mem_var[8];
	Var_r = &mem_var[9];
	Var_ox = &mem_var[10];
	Var_oy = &mem_var[11];
	Var_oz = &mem_var[12];
	Var_os = &mem_var[13];
	Var_ocr = &mem_var[14];
	Var_ocg = &mem_var[15];
	Var_ocb = &mem_var[16];
	Var_cx = &mem_var[17];
	Var_cy = &mem_var[18];
	Var_cz = &mem_var[19];
	Var_omx = &mem_var[20];
	Var_mx = &mem_var[21];
	Var_omy = &mem_var[22];
	Var_my = &mem_var[23];
	Var_mw = &mem_var[24];
	Var_obt = &mem_var[25];
	Var_bt = &mem_var[26];
	Var_step = &mem_var[27];
	Var_w = &mem_var[28];
	Var_h = &mem_var[29];
	Var_zoom = &mem_var[30];
	Var_ru = &mem_var[31];
	Var_rd = &mem_var[32];
	Var_vox = &mem_var[33];
	Var_voz = &mem_var[34];
	Var_gx = &mem_var[35];
	Var_gz = &mem_var[36];
	Var_sel = &mem_var[37];
	Var_dx = &mem_var[38];
	Var_v = &mem_var[39];
	Var_orgxv = &mem_var[40];
	Var_orgyv = &mem_var[41];
	Var_mode = &mem_var[42];
	Var_hit = &mem_var[43];
	Var_starttime = &mem_var[44];
	Var_py = &mem_var[45];
	Var_px = &mem_var[46];
	Var_lr = &mem_var[47];
	Var_lg = &mem_var[48];
	Var_lb = &mem_var[49];
	Var_sr = &mem_var[50];
	Var_sg = &mem_var[51];
	Var_sb = &mem_var[52];
	Var_yv = &mem_var[53];
	Var_l = &mem_var[54];
	Var_xv = &mem_var[55];
	Var_zv = &mem_var[56];
	Var_col = &mem_var[57];
	Var_fg = &mem_var[58];
	Var_t = &mem_var[59];
	Var_y = &mem_var[60];
	Var_x = &mem_var[61];
	Var_z = &mem_var[62];
	Var_nhit = &mem_var[63];
	Var_n0d = &mem_var[64];
	Var_n0c = &mem_var[65];
	Var_endtime = &mem_var[66];
	Var_minv = &mem_var[67];
	Var_dy = &mem_var[68];
	Var_dz = &mem_var[69];
	Var_b = &mem_var[70];
	Var_d = &mem_var[71];
	Var_c = &mem_var[72];
	Var_f = &mem_var[73];
	Var_nx = &mem_var[74];
	Var_ny = &mem_var[75];
	Var_nz = &mem_var[76];
	Var_e = &mem_var[77];
	Var_nc = &mem_var[78];
	Var_nd = &mem_var[79];
	Var_oxv = &mem_var[80];
	Var_oyv = &mem_var[81];
	Var_ozv = &mem_var[82];
	Var_a = &mem_var[83];

	// randomize 
	Intcmd(39,0);
	// gr =0.000000
	PushDouble(0.000000); 
	VarSet(Var_gr,0);
	// gy =28.000000
	PushDouble(28.000000); 
	VarSet(Var_gy,0);
	// gd =80.000000
	PushDouble(80.000000); 
	VarSet(Var_gd,0);
	// ctx =0.000000
	PushDouble(0.000000); 
	VarSet(Var_ctx,0);
	// ctz =0.000000
	PushDouble(0.000000); 
	VarSet(Var_ctz,0);
	// sunx =0.500000
	PushDouble(0.500000); 
	VarSet(Var_sunx,0);
	// suny =0.707100
	PushDouble(0.707100); 
	VarSet(Var_suny,0);
	// sunz =-0.500000
	PushDouble(-0.500000); 
	VarSet(Var_sunz,0);
	// font "ÇlÇr ÉSÉVÉbÉN", 12
	PushInt(12); 
	PushStr("ÇlÇr ÉSÉVÉbÉN"); 
	Extcmd(20,2);
	TaskSwitch(0);
}

static void L0000( void ) {
	// nobstacles =8
	PushInt(8); 
	VarSet(Var_nobstacles,0);
	// repeat
	PushVAP(Var_nobstacles,0); 
	PushLabel(1); 
	PushLabel(14); Prgcmd(4,3); return;
	TaskSwitch(14);
}

static void L0014( void ) {
	// r =(3.141590/4)*cnt
	PushDouble(3.141590); PushInt(4); CalcDivI(); PushSysvar(4,0); CalcMulI(); 
	VarSet(Var_r,0);
	// ox (cnt)=sin(r)*20
	PushFuncEnd(); 	PushVAP(Var_r,0); 
	PushIntfunc(384,1); PushInt(20); CalcMulI(); 
	PushSysvar(4,0); 
	VarSet(Var_ox,1);
	// oy (cnt)=(cos(r)*20)+28
	PushFuncEnd(); 	PushVAP(Var_r,0); 
	PushIntfunc(385,1); PushInt(20); CalcMulI(); PushInt(28); CalcAddI(); 
	PushSysvar(4,0); 
	VarSet(Var_oy,1);
	// oz (cnt)=0.000000
	PushDouble(0.000000); 
	PushSysvar(4,0); 
	VarSet(Var_oz,1);
	// os (cnt)=10.000000
	PushDouble(10.000000); 
	PushSysvar(4,0); 
	VarSet(Var_os,1);
	// ocr (cnt)=0.300000
	PushDouble(0.300000); 
	PushSysvar(4,0); 
	VarSet(Var_ocr,1);
	// ocg (cnt)=0.300000
	PushDouble(0.300000); 
	PushSysvar(4,0); 
	VarSet(Var_ocg,1);
	// ocb (cnt)=0.300000
	PushDouble(0.300000); 
	PushSysvar(4,0); 
	VarSet(Var_ocb,1);
	// loop 
	Prgcmd(5,0);
	return;
	TaskSwitch(1);
}

static void L0001( void ) {
	// goto *L0002
	TaskSwitch(2);
	return;
	TaskSwitch(3);
}

static void L0003( void ) {
	// nobstacles =rnd(12)+1
	PushFuncEnd(); 	PushInt(12); 
	PushIntfunc(1,1); PushInt(1); CalcAddI(); 
	VarSet(Var_nobstacles,0);
	// cx =0.000000
	PushDouble(0.000000); 
	VarSet(Var_cx,0);
	// cy =0.000000
	PushDouble(0.000000); 
	VarSet(Var_cy,0);
	// cz =0.000000
	PushDouble(0.000000); 
	VarSet(Var_cz,0);
	// repeat
	PushVAP(Var_nobstacles,0); 
	PushLabel(4); 
	PushLabel(15); Prgcmd(4,3); return;
	TaskSwitch(15);
}

static void L0015( void ) {
	// ox (cnt)=(0.000000+rnd(60))-30
	PushDouble(0.000000); PushFuncEnd(); 	PushInt(60); 
	PushIntfunc(1,1); CalcAddI(); PushInt(30); CalcSubI(); 
	PushSysvar(4,0); 
	VarSet(Var_ox,1);
	// oy (cnt)=0.000000+rnd(40)
	PushDouble(0.000000); PushFuncEnd(); 	PushInt(40); 
	PushIntfunc(1,1); CalcAddI(); 
	PushSysvar(4,0); 
	VarSet(Var_oy,1);
	// oz (cnt)=(0.000000+rnd(60))-30
	PushDouble(0.000000); PushFuncEnd(); 	PushInt(60); 
	PushIntfunc(1,1); CalcAddI(); PushInt(30); CalcSubI(); 
	PushSysvar(4,0); 
	VarSet(Var_oz,1);
	// os (cnt)=0.010000*rnd(900)+4.000000
	PushDouble(4.000000); PushDouble(0.010000); PushFuncEnd(); 	PushInt(900); 
	PushIntfunc(1,1); CalcMulI(); CalcAddI(); 
	PushSysvar(4,0); 
	VarSet(Var_os,1);
	// ocr (cnt)=0.001000*rnd(1000)
	PushDouble(0.001000); PushFuncEnd(); 	PushInt(1000); 
	PushIntfunc(1,1); CalcMulI(); 
	PushSysvar(4,0); 
	VarSet(Var_ocr,1);
	// ocg (cnt)=0.001000*rnd(1000)
	PushDouble(0.001000); PushFuncEnd(); 	PushInt(1000); 
	PushIntfunc(1,1); CalcMulI(); 
	PushSysvar(4,0); 
	VarSet(Var_ocg,1);
	// ocb (cnt)=0.001000*rnd(1000)
	PushDouble(0.001000); PushFuncEnd(); 	PushInt(1000); 
	PushIntfunc(1,1); CalcMulI(); 
	PushSysvar(4,0); 
	VarSet(Var_ocb,1);
	// cx +=ox(cnt)/nobstacles
		PushSysvar(4,0); 
	PushVar(Var_ox,1); PushVar(Var_nobstacles,0); CalcDivI(); 
	VarCalc(Var_cx,0,0);
	// cy +=oy(cnt)/nobstacles
		PushSysvar(4,0); 
	PushVar(Var_oy,1); PushVar(Var_nobstacles,0); CalcDivI(); 
	VarCalc(Var_cy,0,0);
	// cz +=oz(cnt)/nobstacles
		PushSysvar(4,0); 
	PushVar(Var_oz,1); PushVar(Var_nobstacles,0); CalcDivI(); 
	VarCalc(Var_cz,0,0);
	// loop 
	Prgcmd(5,0);
	return;
	TaskSwitch(2);
}

static void L0002( void ) {
	TaskSwitch(4);
}

static void L0004( void ) {
	// repeat
	PushLabel(5); 
	PushLabel(16); Prgcmd(4,2); return;
	TaskSwitch(16);
}

static void L0016( void ) {
	// omx =mx
	PushVar(Var_mx,0); 
	VarSet(Var_omx,0);
	// omy =my
	PushVar(Var_my,0); 
	VarSet(Var_omy,0);
	// mx =mousex
	PushFuncEnd(); PushExtvar(0,0); 
	VarSet(Var_mx,0);
	// my =mousey
	PushFuncEnd(); PushExtvar(1,0); 
	VarSet(Var_my,0);
	// mw =mousew
	PushFuncEnd(); PushExtvar(2,0); 
	VarSet(Var_mw,0);
	// obt =bt
	PushVar(Var_bt,0); 
	VarSet(Var_obt,0);
	// stick bt, 15+256
	PushInt(271);/*OPT*/ 
	PushVAP(Var_bt,0); 
	Extcmd(52,2);
	// if bt&16
	PushVar(Var_bt,0); PushInt(16); CalcAndI(); 
	if (HspIf()) { TaskSwitch(17); return; }
	// break *L0005
	PushLabel(5); 
	Prgcmd(3,1);
	return;
	TaskSwitch(17);
}

static void L0017( void ) {
	// if bt&32
	PushVar(Var_bt,0); PushInt(32); CalcAndI(); 
	if (HspIf()) { TaskSwitch(18); return; }
	// step =1
	PushInt(1); 
	VarSet(Var_step,0);
	// color , 255
	PushInt(255); 
	PushDefault();
	Extcmd(24,2);
	// boxf 633
	PushInt(633); 
	Extcmd(49,1);
	// pos 540, 460
	PushInt(460); 
	PushInt(540); 
	Extcmd(17,2);
	// mes "íÜíf : ESC"
	PushStr("íÜíf : ESC"); 
	Extcmd(15,1);
	TaskSwitch(19);
}

static void L0018( void ) {
	// else
	// step =16
	PushInt(16); 
	VarSet(Var_step,0);
	// redraw 0
	PushInt(0); 
	Extcmd(27,1);
	TaskSwitch(19);
}

static void L0019( void ) {
	// w =ginfo(12)/step
	PushFuncEnd(); 	PushInt(12); 
	PushExtvar(256,1); PushVar(Var_step,0); CalcDivI(); 
	VarSet(Var_w,0);
	// h =ginfo(13)/step
	PushFuncEnd(); 	PushInt(13); 
	PushExtvar(256,1); PushVar(Var_step,0); CalcDivI(); 
	VarSet(Var_h,0);
	// zoom =1.000000/h
	PushDouble(1.000000); PushVar(Var_h,0); CalcDivI(); 
	VarSet(Var_zoom,0);
	// getkey ru, 33
	PushInt(33); 
	PushVAP(Var_ru,0); 
	Extcmd(35,2);
	// getkey rd, 34
	PushInt(34); 
	PushVAP(Var_rd,0); 
	Extcmd(35,2);
	// gd -=ru-rd*0.500000
	PushDouble(0.500000); PushVar(Var_ru,0); PushVar(Var_rd,0); CalcSubI(); CalcMulI(); 
	VarCalc(Var_gd,0,1);
	// gr +=((bt>>2)&1bt&1)-*0.030000
	PushDouble(0.030000); PushVar(Var_bt,0); PushInt(2); CalcRrI(); PushInt(1); CalcAndI(); PushVar(Var_bt,0); PushInt(1); CalcAndI(); CalcSubI(); CalcMulI(); 
	VarCalc(Var_gr,0,0);
	// gy +=(((bt>>1)&1bt>>3)&1)-
	PushVar(Var_bt,0); PushInt(1); CalcRrI(); PushInt(1); CalcAndI(); PushVar(Var_bt,0); PushInt(3); CalcRrI(); PushInt(1); CalcAndI(); CalcSubI(); 
	VarCalc(Var_gy,0,0);
	// if gy<1.000000
	PushVar(Var_gy,0); PushDouble(1.000000); CalcLtI(); 
	if (HspIf()) { TaskSwitch(20); return; }
	// gy =1.000000
	PushDouble(1.000000); 
	VarSet(Var_gy,0);
	TaskSwitch(20);
}

static void L0020( void ) {
	// ctx +=(cx-ctx)*0.100000
	PushVar(Var_cx,0); PushVar(Var_ctx,0); CalcSubI(); PushDouble(0.100000); CalcMulI(); 
	VarCalc(Var_ctx,0,0);
	// ctz +=(cz-ctz)*0.100000
	PushVar(Var_cz,0); PushVar(Var_ctz,0); CalcSubI(); PushDouble(0.100000); CalcMulI(); 
	VarCalc(Var_ctz,0,0);
	// vox =sin(gr)
	PushFuncEnd(); 	PushVAP(Var_gr,0); 
	PushIntfunc(384,1); 
	VarSet(Var_vox,0);
	// voz =cos(gr)*-1
	PushFuncEnd(); 	PushVAP(Var_gr,0); 
	PushIntfunc(385,1); PushInt(-1); CalcMulI(); 
	VarSet(Var_voz,0);
	// gx =(vox*gd)+ctx
	PushVar(Var_vox,0); PushVar(Var_gd,0); CalcMulI(); PushVar(Var_ctx,0); CalcAddI(); 
	VarSet(Var_gx,0);
	// gz =(voz*gd)+ctz
	PushVar(Var_voz,0); PushVar(Var_gd,0); CalcMulI(); PushVar(Var_ctz,0); CalcAddI(); 
	VarSet(Var_gz,0);
	// if bt&256
	PushVar(Var_bt,0); PushInt(256); CalcAndI(); 
	if (HspIf()) { TaskSwitch(21); return; }
	// if sel>=0
	PushVar(Var_sel,0); PushInt(0); CalcGtEqI(); 
	if (HspIf()) { TaskSwitch(22); return; }
	// dx =mx-omx
	PushVar(Var_mx,0); PushVar(Var_omx,0); CalcSubI(); 
	VarSet(Var_dx,0);
	// v =0.160000
	PushDouble(0.160000); 
	VarSet(Var_v,0);
	// oy (sel)+=omy-my*v
	PushVar(Var_v,0); PushVar(Var_omy,0); PushVar(Var_my,0); CalcSubI(); CalcMulI(); 
	PushVAP(Var_sel,0); 
	VarCalc(Var_oy,1,0);
	// ox (sel)-=(v*voz)*dx
	PushVar(Var_v,0); PushVar(Var_voz,0); CalcMulI(); PushVar(Var_dx,0); CalcMulI(); 
	PushVAP(Var_sel,0); 
	VarCalc(Var_ox,1,1);
	// oz (sel)+=(v*vox)*dx
	PushVar(Var_v,0); PushVar(Var_vox,0); CalcMulI(); PushVar(Var_dx,0); CalcMulI(); 
	PushVAP(Var_sel,0); 
	VarCalc(Var_oz,1,0);
	// if mw>0
	PushVar(Var_mw,0); PushInt(0); CalcGtI(); 
	if (HspIf()) { TaskSwitch(23); return; }
	// os (sel)+=0.400000
	PushDouble(0.400000); 
	PushVAP(Var_sel,0); 
	VarCalc(Var_os,1,0);
	TaskSwitch(23);
}

static void L0023( void ) {
	// if mw<0
	PushVar(Var_mw,0); PushInt(0); CalcLtI(); 
	if (HspIf()) { TaskSwitch(24); return; }
	// os (sel)-=0.400000
	PushDouble(0.400000); 
	PushVAP(Var_sel,0); 
	VarCalc(Var_os,1,1);
	TaskSwitch(24);
}

static void L0024( void ) {
	TaskSwitch(22);
}

static void L0022( void ) {
	TaskSwitch(25);
}

static void L0021( void ) {
	// else
	// sel =-1
	PushInt(-1); 
	VarSet(Var_sel,0);
	TaskSwitch(25);
}

static void L0025( void ) {
	// if ((obt^bt)&bt)&256
	PushVar(Var_obt,0); PushVar(Var_bt,0); CalcXorI(); PushVar(Var_bt,0); CalcAndI(); PushInt(256); CalcAndI(); 
	if (HspIf()) { TaskSwitch(26); return; }
	// orgxv =(omx/step+0.5000000.500000*w)-*zoom
	PushVar(Var_zoom,0); PushDouble(0.500000); PushVar(Var_omx,0); PushVar(Var_step,0); CalcDivI(); CalcAddI(); PushDouble(0.500000); PushVar(Var_w,0); CalcMulI(); CalcSubI(); CalcMulI(); 
	VarSet(Var_orgxv,0);
	// orgyv =(omy/step+0.5000000.500000*h)-*zoom
	PushVar(Var_zoom,0); PushDouble(0.500000); PushVar(Var_omy,0); PushVar(Var_step,0); CalcDivI(); CalcAddI(); PushDouble(0.500000); PushVar(Var_h,0); CalcMulI(); CalcSubI(); CalcMulI(); 
	VarSet(Var_orgyv,0);
	// gosub
	PushLabel(6); 
	PushLabel(27); Prgcmd(1,2); return;
}

static void L0027( void ) {
	// mode =2
	PushInt(2); 
	VarSet(Var_mode,0);
	// gosub
	PushLabel(7); 
	PushLabel(28); Prgcmd(1,2); return;
}

static void L0028( void ) {
	// sel =hit
	PushVar(Var_hit,0); 
	VarSet(Var_sel,0);
	TaskSwitch(26);
}

static void L0026( void ) {
	// starttime =(((gettime(5)*60)+gettime(6))*1000)+gettime(7)
	PushFuncEnd(); 	PushInt(5); 
	PushIntfunc(8,1); PushInt(60); CalcMulI(); PushFuncEnd(); 	PushInt(6); 
	PushIntfunc(8,1); CalcAddI(); PushInt(1000); CalcMulI(); PushFuncEnd(); 	PushInt(7); 
	PushIntfunc(8,1); CalcAddI(); 
	VarSet(Var_starttime,0);
	// repeat
	PushVAP(Var_h,0); 
	PushLabel(8); 
	PushLabel(29); Prgcmd(4,3); return;
	TaskSwitch(29);
}

static void L0029( void ) {
	// py =cnt*step
	PushSysvar(4,0); PushVar(Var_step,0); CalcMulI(); 
	VarSet(Var_py,0);
	// orgyv =(0.500000+cnt0.500000*h)-*zoom
	PushVar(Var_zoom,0); PushDouble(0.500000); PushSysvar(4,0); CalcAddI(); PushDouble(0.500000); PushVar(Var_h,0); CalcMulI(); CalcSubI(); CalcMulI(); 
	VarSet(Var_orgyv,0);
	// repeat
	PushVAP(Var_w,0); 
	PushLabel(9); 
	PushLabel(30); Prgcmd(4,3); return;
	TaskSwitch(30);
}

static void L0030( void ) {
	// px =cnt*step
	PushSysvar(4,0); PushVar(Var_step,0); CalcMulI(); 
	VarSet(Var_px,0);
	// orgxv =(0.500000+cnt0.500000*w)-*zoom
	PushVar(Var_zoom,0); PushDouble(0.500000); PushSysvar(4,0); CalcAddI(); PushDouble(0.500000); PushVar(Var_w,0); CalcMulI(); CalcSubI(); CalcMulI(); 
	VarSet(Var_orgxv,0);
	// gosub
	PushLabel(6); 
	PushLabel(31); Prgcmd(1,2); return;
}

static void L0031( void ) {
	// lr =1.000000
	PushDouble(1.000000); 
	VarSet(Var_lr,0);
	// lg =1.000000
	PushDouble(1.000000); 
	VarSet(Var_lg,0);
	// lb =1.000000
	PushDouble(1.000000); 
	VarSet(Var_lb,0);
	// sr =0.000000
	PushDouble(0.000000); 
	VarSet(Var_sr,0);
	// sg =0.000000
	PushDouble(0.000000); 
	VarSet(Var_sg,0);
	// sb =0.000000
	PushDouble(0.000000); 
	VarSet(Var_sb,0);
	// gosub
	PushLabel(7); 
	PushLabel(32); Prgcmd(1,2); return;
}

static void L0032( void ) {
	// if yv>=0.000000
	PushVar(Var_yv,0); PushDouble(0.000000); CalcGtEqI(); 
	if (HspIf()) { TaskSwitch(33); return; }
	// l =limitf(((xv*sunxyv*suny)+zv*sunz)+, 0, 1)
	PushFuncEnd(); 	PushInt(1); 
		PushInt(0); 
		PushVar(Var_xv,0); PushVar(Var_sunx,0); CalcMulI(); PushVar(Var_yv,0); PushVar(Var_suny,0); CalcMulI(); CalcAddI(); PushVar(Var_zv,0); PushVar(Var_sunz,0); CalcMulI(); CalcAddI(); 
	PushIntfunc(393,3); 
	VarSet(Var_l,0);
	// repeat
	PushInt(8); 
	PushLabel(10); 
	PushLabel(34); Prgcmd(4,3); return;
	TaskSwitch(34);
}

static void L0034( void ) {
	// l =l*l
	PushVar(Var_l,0); PushVar(Var_l,0); CalcMulI(); 
	VarSet(Var_l,0);
	// loop 
	Prgcmd(5,0);
	return;
	TaskSwitch(10);
}

static void L0010( void ) {
	// col =l*100
	PushVar(Var_l,0); PushInt(100); CalcMulI(); 
	VarSet(Var_col,0);
	TaskSwitch(35);
}

static void L0033( void ) {
	// else
	// fg =(yv*-1)*5.000000
	PushVar(Var_yv,0); PushInt(-1); CalcMulI(); PushDouble(5.000000); CalcMulI(); 
	VarSet(Var_fg,0);
	// t =(y*-1)/yv
	PushVar(Var_y,0); PushInt(-1); CalcMulI(); PushVar(Var_yv,0); CalcDivI(); 
	VarSet(Var_t,0);
	// x =t*xv+x
	PushVar(Var_x,0); PushVar(Var_t,0); PushVar(Var_xv,0); CalcMulI(); CalcAddI(); 
	VarSet(Var_x,0);
	// y =0.000000
	PushDouble(0.000000); 
	VarSet(Var_y,0);
	// z =t*zv+z
	PushVar(Var_z,0); PushVar(Var_t,0); PushVar(Var_zv,0); CalcMulI(); CalcAddI(); 
	VarSet(Var_z,0);
	// col =limitf((((int(x+80000)/8int(z+80000)/8)+(z+80000))&1)!=0*0.700000, 0.300000, fg)
	PushFuncEnd(); 	PushVAP(Var_fg,0); 
		PushDouble(0.300000); 
		PushDouble(0.700000); PushFuncEnd(); 	PushVar(Var_x,0); PushInt(80000); CalcAddI(); 
	PushIntfunc(0,1); PushInt(8); CalcDivI(); PushFuncEnd(); 	PushVar(Var_z,0); PushInt(80000); CalcAddI(); 
	PushIntfunc(0,1); PushInt(8); CalcDivI(); CalcAddI(); PushInt(1); CalcAndI(); PushInt(0); CalcNeI(); CalcMulI(); 
	PushIntfunc(393,3); 
	VarSet(Var_col,0);
	// xv =sunx
	PushVar(Var_sunx,0); 
	VarSet(Var_xv,0);
	// yv =suny
	PushVar(Var_suny,0); 
	VarSet(Var_yv,0);
	// zv =sunz
	PushVar(Var_sunz,0); 
	VarSet(Var_zv,0);
	// mode =1
	PushInt(1); 
	VarSet(Var_mode,0);
	// gosub
	PushLabel(7); 
	PushLabel(36); Prgcmd(1,2); return;
}

static void L0036( void ) {
	// if hit>0
	PushVar(Var_hit,0); PushInt(0); CalcGtI(); 
	if (HspIf()) { TaskSwitch(37); return; }
	// col *=0.200000
	PushDouble(0.200000); 
	VarCalc(Var_col,0,2);
	TaskSwitch(37);
}

static void L0037( void ) {
	TaskSwitch(35);
}

static void L0035( void ) {
	// if nhit
	PushVAP(Var_nhit,0); 
	if (HspIf()) { TaskSwitch(38); return; }
	// sr +=n0d*ocr(n0c)
	PushVar(Var_n0d,0); 	PushVAP(Var_n0c,0); 
	PushVar(Var_ocr,1); CalcMulI(); 
	VarCalc(Var_sr,0,0);
	// sg +=n0d*ocg(n0c)
	PushVar(Var_n0d,0); 	PushVAP(Var_n0c,0); 
	PushVar(Var_ocg,1); CalcMulI(); 
	VarCalc(Var_sg,0,0);
	// sb +=n0d*ocb(n0c)
	PushVar(Var_n0d,0); 	PushVAP(Var_n0c,0); 
	PushVar(Var_ocb,1); CalcMulI(); 
	VarCalc(Var_sb,0,0);
	TaskSwitch(38);
}

static void L0038( void ) {
	// color limitf((col*lr)+sr, 0, 1)*255, limitf((col*lg)+sg, 0, 1)*255, limitf((col*lb)+sb, 0, 1)*255
	PushFuncEnd(); 	PushInt(1); 
		PushInt(0); 
		PushVar(Var_col,0); PushVar(Var_lb,0); CalcMulI(); PushVar(Var_sb,0); CalcAddI(); 
	PushIntfunc(393,3); PushInt(255); CalcMulI(); 
	PushFuncEnd(); 	PushInt(1); 
		PushInt(0); 
		PushVar(Var_col,0); PushVar(Var_lg,0); CalcMulI(); PushVar(Var_sg,0); CalcAddI(); 
	PushIntfunc(393,3); PushInt(255); CalcMulI(); 
	PushFuncEnd(); 	PushInt(1); 
		PushInt(0); 
		PushVar(Var_col,0); PushVar(Var_lr,0); CalcMulI(); PushVar(Var_sr,0); CalcAddI(); 
	PushIntfunc(393,3); PushInt(255); CalcMulI(); 
	Extcmd(24,3);
	// boxf px, py, (px+step)-1, (py+step)-1
	PushVar(Var_py,0); PushVar(Var_step,0); CalcAddI(); PushInt(1); CalcSubI(); 
	PushVar(Var_px,0); PushVar(Var_step,0); CalcAddI(); PushInt(1); CalcSubI(); 
	PushVAP(Var_py,0); 
	PushVAP(Var_px,0); 
	Extcmd(49,4);
	// loop 
	Prgcmd(5,0);
	return;
	TaskSwitch(9);
}

static void L0009( void ) {
	// await 0
	PushInt(0); 
	Prgcmd(8,1);
	TaskSwitch(39);
}

static void L0039( void ) {
	// if step=1
	PushVar(Var_step,0); PushInt(1); CalcEqI(); 
	if (HspIf()) { TaskSwitch(40); return; }
	// stick bt
	PushVAP(Var_bt,0); 
	Extcmd(52,1);
	// if bt&128
	PushVar(Var_bt,0); PushInt(128); CalcAndI(); 
	if (HspIf()) { TaskSwitch(41); return; }
	// step =16
	PushInt(16); 
	VarSet(Var_step,0);
	// break *L0008
	PushLabel(8); 
	Prgcmd(3,1);
	return;
	TaskSwitch(41);
}

static void L0041( void ) {
	TaskSwitch(40);
}

static void L0040( void ) {
	// loop 
	Prgcmd(5,0);
	return;
	TaskSwitch(8);
}

static void L0008( void ) {
	// endtime =(((gettime(5)*60)+gettime(6))*1000)+gettime(7)
	PushFuncEnd(); 	PushInt(5); 
	PushIntfunc(8,1); PushInt(60); CalcMulI(); PushFuncEnd(); 	PushInt(6); 
	PushIntfunc(8,1); CalcAddI(); PushInt(1000); CalcMulI(); PushFuncEnd(); 	PushInt(7); 
	PushIntfunc(8,1); CalcAddI(); 
	VarSet(Var_endtime,0);
	// color 255, 255, 255
	PushInt(255); 
	PushInt(255); 
	PushInt(255); 
	Extcmd(24,3);
	// pos 0, 20
	PushInt(20); 
	PushInt(0); 
	Extcmd(17,2);
	// mes (double(endtime-starttime)/1000+"->")+"sec"
	PushStr("->"); PushFuncEnd(); 	PushVar(Var_endtime,0); PushVar(Var_starttime,0); CalcSubI(); 
	PushIntfunc(389,1); PushInt(1000); CalcDivI(); CalcAddI(); PushStr("sec"); CalcAddI(); 
	Extcmd(15,1);
	// if step=1
	PushVar(Var_step,0); PushInt(1); CalcEqI(); 
	if (HspIf()) { TaskSwitch(42); return; }
	// dialog "ÉZÅ[ÉuÇµÇ‹Ç∑Ç©ÅH", 2
	PushInt(2); 
	PushStr("ÉZÅ[ÉuÇµÇ‹Ç∑Ç©ÅH"); 
	Extcmd(3,2);
	// if stat=6
	PushSysvar(3,0); PushInt(6); CalcEqI(); 
	if (HspIf()) { TaskSwitch(43); return; }
	// dialog "bmp", 17
	PushInt(17); 
	PushStr("bmp"); 
	Extcmd(3,2);
	// if stat
	PushSysvar(3,0); 
	if (HspIf()) { TaskSwitch(44); return; }
	// bmpsave refstr
	PushSysvar(12,0); 
	Extcmd(33,1);
	TaskSwitch(44);
}

static void L0044( void ) {
	TaskSwitch(43);
}

static void L0043( void ) {
	// stick bt
	PushVAP(Var_bt,0); 
	Extcmd(52,1);
	TaskSwitch(45);
}

static void L0042( void ) {
	// else
	// color 255, 255, 255
	PushInt(255); 
	PushInt(255); 
	PushInt(255); 
	Extcmd(24,3);
	// pos 0, 0
	PushInt(0); 
	PushInt(0); 
	Extcmd(17,2);
	// mes "ëÄçÏ:Å™Å´Å©Å® Rup Rdn Enter Space Drag+Wheel"
	PushStr("ëÄçÏ:Å™Å´Å©Å® Rup Rdn Enter Space Drag+Wheel"); 
	Extcmd(15,1);
	TaskSwitch(45);
}

static void L0045( void ) {
	// redraw 1
	PushInt(1); 
	Extcmd(27,1);
	// loop 
	Prgcmd(5,0);
	return;
	TaskSwitch(5);
}

static void L0005( void ) {
	// goto *L0003
	TaskSwitch(3);
	return;
	TaskSwitch(7);
}

static void L0007( void ) {
	// if mode=0
	PushVar(Var_mode,0); PushInt(0); CalcEqI(); 
	if (HspIf()) { TaskSwitch(46); return; }
	// nhit =0
	PushInt(0); 
	VarSet(Var_nhit,0);
	TaskSwitch(46);
}

static void L0046( void ) {
	// repeat
	PushInt(10); 
	PushLabel(11); 
	PushLabel(47); Prgcmd(4,3); return;
	TaskSwitch(47);
}

static void L0047( void ) {
	// hit =-1
	PushInt(-1); 
	VarSet(Var_hit,0);
	// minv =10000.000000
	PushDouble(10000.000000); 
	VarSet(Var_minv,0);
	// repeat
	PushVAP(Var_nobstacles,0); 
	PushLabel(12); 
	PushLabel(48); Prgcmd(4,3); return;
	TaskSwitch(48);
}

static void L0048( void ) {
	// r =os(cnt)
		PushSysvar(4,0); 
	PushVar(Var_os,1); 
	VarSet(Var_r,0);
	// dx =ox(cnt)-x
		PushSysvar(4,0); 
	PushVar(Var_ox,1); PushVar(Var_x,0); CalcSubI(); 
	VarSet(Var_dx,0);
	// dy =oy(cnt)-y
		PushSysvar(4,0); 
	PushVar(Var_oy,1); PushVar(Var_y,0); CalcSubI(); 
	VarSet(Var_dy,0);
	// dz =oz(cnt)-z
		PushSysvar(4,0); 
	PushVar(Var_oz,1); PushVar(Var_z,0); CalcSubI(); 
	VarSet(Var_dz,0);
	// b =((dx*xvdy*yv)+dz*zv)+
	PushVar(Var_dx,0); PushVar(Var_xv,0); CalcMulI(); PushVar(Var_dy,0); PushVar(Var_yv,0); CalcMulI(); CalcAddI(); PushVar(Var_dz,0); PushVar(Var_zv,0); CalcMulI(); CalcAddI(); 
	VarSet(Var_b,0);
	// d =((dx*dxdy*dy)+dz*dz)+
	PushVar(Var_dx,0); PushVar(Var_dx,0); CalcMulI(); PushVar(Var_dy,0); PushVar(Var_dy,0); CalcMulI(); CalcAddI(); PushVar(Var_dz,0); PushVar(Var_dz,0); CalcMulI(); CalcAddI(); 
	VarSet(Var_d,0);
	// c =r*r-d
	PushVar(Var_d,0); PushVar(Var_r,0); PushVar(Var_r,0); CalcMulI(); CalcSubI(); 
	VarSet(Var_c,0);
	// f =(b*b)-c
	PushVar(Var_b,0); PushVar(Var_b,0); CalcMulI(); PushVar(Var_c,0); CalcSubI(); 
	VarSet(Var_f,0);
	// if f<0.000000
	PushVar(Var_f,0); PushDouble(0.000000); CalcLtI(); 
	if (HspIf()) { TaskSwitch(49); return; }
	// continue *L000c
	PushLabel(12); 
	Prgcmd(6,1);
	return;
	TaskSwitch(49);
}

static void L0049( void ) {
	// v =b-sqrt(f)
	PushVar(Var_b,0); PushFuncEnd(); 	PushVAP(Var_f,0); 
	PushIntfunc(388,1); CalcSubI(); 
	VarSet(Var_v,0);
	// if v<0.000000
	PushVar(Var_v,0); PushDouble(0.000000); CalcLtI(); 
	if (HspIf()) { TaskSwitch(50); return; }
	// continue *L000c
	PushLabel(12); 
	Prgcmd(6,1);
	return;
	TaskSwitch(50);
}

static void L0050( void ) {
	// if mode=1
	PushVar(Var_mode,0); PushInt(1); CalcEqI(); 
	if (HspIf()) { TaskSwitch(51); return; }
	// hit =1
	PushInt(1); 
	VarSet(Var_hit,0);
	// break *L000c
	PushLabel(12); 
	Prgcmd(3,1);
	return;
	TaskSwitch(51);
}

static void L0051( void ) {
	// if v<minv
	PushVar(Var_v,0); PushVar(Var_minv,0); CalcLtI(); 
	if (HspIf()) { TaskSwitch(52); return; }
	// if (yv*v+y)>0.000000
	PushVar(Var_y,0); PushVar(Var_yv,0); PushVar(Var_v,0); CalcMulI(); CalcAddI(); PushDouble(0.000000); CalcGtI(); 
	if (HspIf()) { TaskSwitch(53); return; }
	// minv =v
	PushVar(Var_v,0); 
	VarSet(Var_minv,0);
	// hit =cnt
	PushSysvar(4,0); 
	VarSet(Var_hit,0);
	TaskSwitch(53);
}

static void L0053( void ) {
	TaskSwitch(52);
}

static void L0052( void ) {
	// loop 
	Prgcmd(5,0);
	return;
	TaskSwitch(12);
}

static void L0012( void ) {
	// if mode
	PushVAP(Var_mode,0); 
	if (HspIf()) { TaskSwitch(54); return; }
	// mode =0
	PushInt(0); 
	VarSet(Var_mode,0);
	// break *L000b
	PushLabel(11); 
	Prgcmd(3,1);
	return;
	TaskSwitch(54);
}

static void L0054( void ) {
	// if hit<0
	PushVar(Var_hit,0); PushInt(0); CalcLtI(); 
	if (HspIf()) { TaskSwitch(55); return; }
	// break *L000b
	PushLabel(11); 
	Prgcmd(3,1);
	return;
	TaskSwitch(55);
}

static void L0055( void ) {
	// d =1.000000/os(hit)
	PushDouble(1.000000); 	PushVAP(Var_hit,0); 
	PushVar(Var_os,1); CalcDivI(); 
	VarSet(Var_d,0);
	// x +=xv*minv
	PushVar(Var_xv,0); PushVar(Var_minv,0); CalcMulI(); 
	VarCalc(Var_x,0,0);
	// nx =(x-ox(hit))*d
	PushVar(Var_x,0); 	PushVAP(Var_hit,0); 
	PushVar(Var_ox,1); CalcSubI(); PushVar(Var_d,0); CalcMulI(); 
	VarSet(Var_nx,0);
	// y +=yv*minv
	PushVar(Var_yv,0); PushVar(Var_minv,0); CalcMulI(); 
	VarCalc(Var_y,0,0);
	// ny =(y-oy(hit))*d
	PushVar(Var_y,0); 	PushVAP(Var_hit,0); 
	PushVar(Var_oy,1); CalcSubI(); PushVar(Var_d,0); CalcMulI(); 
	VarSet(Var_ny,0);
	// z +=zv*minv
	PushVar(Var_zv,0); PushVar(Var_minv,0); CalcMulI(); 
	VarCalc(Var_z,0,0);
	// nz =(z-oz(hit))*d
	PushVar(Var_z,0); 	PushVAP(Var_hit,0); 
	PushVar(Var_oz,1); CalcSubI(); PushVar(Var_d,0); CalcMulI(); 
	VarSet(Var_nz,0);
	// d =((nx*xvny*yv)+nz*zv)+*2.000000
	PushDouble(2.000000); PushVar(Var_nx,0); PushVar(Var_xv,0); CalcMulI(); PushVar(Var_ny,0); PushVar(Var_yv,0); CalcMulI(); CalcAddI(); PushVar(Var_nz,0); PushVar(Var_zv,0); CalcMulI(); CalcAddI(); CalcMulI(); 
	VarSet(Var_d,0);
	// xv =d*nx-xv
	PushVar(Var_xv,0); PushVar(Var_d,0); PushVar(Var_nx,0); CalcMulI(); CalcSubI(); 
	VarSet(Var_xv,0);
	// yv =d*ny-yv
	PushVar(Var_yv,0); PushVar(Var_d,0); PushVar(Var_ny,0); CalcMulI(); CalcSubI(); 
	VarSet(Var_yv,0);
	// zv =d*nz-zv
	PushVar(Var_zv,0); PushVar(Var_d,0); PushVar(Var_nz,0); CalcMulI(); CalcSubI(); 
	VarSet(Var_zv,0);
	// e =limitf(d*0.500000+1.100000, 0, 1)
	PushFuncEnd(); 	PushInt(1); 
		PushInt(0); 
		PushDouble(1.100000); PushVar(Var_d,0); PushDouble(0.500000); CalcMulI(); CalcAddI(); 
	PushIntfunc(393,3); 
	VarSet(Var_e,0);
	// e =(e*e)*4
	PushVar(Var_e,0); PushVar(Var_e,0); CalcMulI(); PushInt(4); CalcMulI(); 
	VarSet(Var_e,0);
	// nc =hit
	PushVar(Var_hit,0); 
	VarSet(Var_nc,0);
	// nd =limitf(((nx*sunxny*suny)+nz*sunz)+, 0, 1)
	PushFuncEnd(); 	PushInt(1); 
		PushInt(0); 
		PushVar(Var_nx,0); PushVar(Var_sunx,0); CalcMulI(); PushVar(Var_ny,0); PushVar(Var_suny,0); CalcMulI(); CalcAddI(); PushVar(Var_nz,0); PushVar(Var_sunz,0); CalcMulI(); CalcAddI(); 
	PushIntfunc(393,3); 
	VarSet(Var_nd,0);
	// if nd>0.000000
	PushVar(Var_nd,0); PushDouble(0.000000); CalcGtI(); 
	if (HspIf()) { TaskSwitch(56); return; }
	// oxv =xv
	PushVar(Var_xv,0); 
	VarSet(Var_oxv,0);
	// oyv =yv
	PushVar(Var_yv,0); 
	VarSet(Var_oyv,0);
	// ozv =zv
	PushVar(Var_zv,0); 
	VarSet(Var_ozv,0);
	// xv =sunx
	PushVar(Var_sunx,0); 
	VarSet(Var_xv,0);
	// yv =suny
	PushVar(Var_suny,0); 
	VarSet(Var_yv,0);
	// zv =sunz
	PushVar(Var_sunz,0); 
	VarSet(Var_zv,0);
	// mode =1
	PushInt(1); 
	VarSet(Var_mode,0);
	// gosub
	PushLabel(7); 
	PushLabel(57); Prgcmd(1,2); return;
}

static void L0057( void ) {
	// if hit>0
	PushVar(Var_hit,0); PushInt(0); CalcGtI(); 
	if (HspIf()) { TaskSwitch(58); return; }
	// nd *=0.200000
	PushDouble(0.200000); 
	VarCalc(Var_nd,0,2);
	TaskSwitch(58);
}

static void L0058( void ) {
	// xv =oxv
	PushVar(Var_oxv,0); 
	VarSet(Var_xv,0);
	// yv =oyv
	PushVar(Var_oyv,0); 
	VarSet(Var_yv,0);
	// zv =ozv
	PushVar(Var_ozv,0); 
	VarSet(Var_zv,0);
	TaskSwitch(56);
}

static void L0056( void ) {
	// lr *=ocr(nc)*e
		PushVAP(Var_nc,0); 
	PushVar(Var_ocr,1); PushVar(Var_e,0); CalcMulI(); 
	VarCalc(Var_lr,0,2);
	// lg *=ocg(nc)*e
		PushVAP(Var_nc,0); 
	PushVar(Var_ocg,1); PushVar(Var_e,0); CalcMulI(); 
	VarCalc(Var_lg,0,2);
	// lb *=ocb(nc)*e
		PushVAP(Var_nc,0); 
	PushVar(Var_ocb,1); PushVar(Var_e,0); CalcMulI(); 
	VarCalc(Var_lb,0,2);
	// if nhit=0
	PushVar(Var_nhit,0); PushInt(0); CalcEqI(); 
	if (HspIf()) { TaskSwitch(59); return; }
	// n0c =nc
	PushVar(Var_nc,0); 
	VarSet(Var_n0c,0);
	// n0d =nd
	PushVar(Var_nd,0); 
	VarSet(Var_n0d,0);
	TaskSwitch(60);
}

static void L0059( void ) {
	// else
	// sr +=(nd*ocr(nc))*lr
	PushVar(Var_nd,0); 	PushVAP(Var_nc,0); 
	PushVar(Var_ocr,1); CalcMulI(); PushVar(Var_lr,0); CalcMulI(); 
	VarCalc(Var_sr,0,0);
	// sg +=(nd*ocg(nc))*lg
	PushVar(Var_nd,0); 	PushVAP(Var_nc,0); 
	PushVar(Var_ocg,1); CalcMulI(); PushVar(Var_lg,0); CalcMulI(); 
	VarCalc(Var_sg,0,0);
	// sb +=(nd*ocb(nc))*lb
	PushVar(Var_nd,0); 	PushVAP(Var_nc,0); 
	PushVar(Var_ocb,1); CalcMulI(); PushVar(Var_lb,0); CalcMulI(); 
	VarCalc(Var_sb,0,0);
	TaskSwitch(60);
}

static void L0060( void ) {
	// nhit ++
	VarInc(Var_nhit,0);
	// loop 
	Prgcmd(5,0);
	return;
	TaskSwitch(11);
}

static void L0011( void ) {
	// return 
	Prgcmd(2,0);
	return;
	TaskSwitch(6);
}

static void L0006( void ) {
	// xv =((voz*-1)*orgxv)-vox
	PushVar(Var_voz,0); PushInt(-1); CalcMulI(); PushVar(Var_orgxv,0); CalcMulI(); PushVar(Var_vox,0); CalcSubI(); 
	VarSet(Var_xv,0);
	// yv =orgyv*-1
	PushVar(Var_orgyv,0); PushInt(-1); CalcMulI(); 
	VarSet(Var_yv,0);
	// zv =(vox*orgxv)-voz
	PushVar(Var_vox,0); PushVar(Var_orgxv,0); CalcMulI(); PushVar(Var_voz,0); CalcSubI(); 
	VarSet(Var_zv,0);
	// a =1.000000/sqrt(((xv*xvyv*yv)+zv*zv)+)
	PushDouble(1.000000); PushFuncEnd(); 	PushVar(Var_xv,0); PushVar(Var_xv,0); CalcMulI(); PushVar(Var_yv,0); PushVar(Var_yv,0); CalcMulI(); CalcAddI(); PushVar(Var_zv,0); PushVar(Var_zv,0); CalcMulI(); CalcAddI(); 
	PushIntfunc(388,1); CalcDivI(); 
	VarSet(Var_a,0);
	// xv *=a
	PushVar(Var_a,0); 
	VarCalc(Var_xv,0,2);
	// yv *=a
	PushVar(Var_a,0); 
	VarCalc(Var_yv,0,2);
	// zv *=a
	PushVar(Var_a,0); 
	VarCalc(Var_zv,0,2);
	// x =gx
	PushVar(Var_gx,0); 
	VarSet(Var_x,0);
	// y =gy
	PushVar(Var_gy,0); 
	VarSet(Var_y,0);
	// z =gz
	PushVar(Var_gz,0); 
	VarSet(Var_z,0);
	// return 
	Prgcmd(2,0);
	return;
	TaskSwitch(13);
}

static void L0013( void ) {
	// stop 
	Prgcmd(17,0);
	return;
	// goto 
	Prgcmd(0,0);
	return;
}

//-End of Source-------------------------------------------

CHSP3_TASK __HspTaskFunc[]={
(CHSP3_TASK) L0000,
(CHSP3_TASK) L0001,
(CHSP3_TASK) L0002,
(CHSP3_TASK) L0003,
(CHSP3_TASK) L0004,
(CHSP3_TASK) L0005,
(CHSP3_TASK) L0006,
(CHSP3_TASK) L0007,
(CHSP3_TASK) L0008,
(CHSP3_TASK) L0009,
(CHSP3_TASK) L0010,
(CHSP3_TASK) L0011,
(CHSP3_TASK) L0012,
(CHSP3_TASK) L0013,
(CHSP3_TASK) L0014,
(CHSP3_TASK) L0015,
(CHSP3_TASK) L0016,
(CHSP3_TASK) L0017,
(CHSP3_TASK) L0018,
(CHSP3_TASK) L0019,
(CHSP3_TASK) L0020,
(CHSP3_TASK) L0021,
(CHSP3_TASK) L0022,
(CHSP3_TASK) L0023,
(CHSP3_TASK) L0024,
(CHSP3_TASK) L0025,
(CHSP3_TASK) L0026,
(CHSP3_TASK) L0027,
(CHSP3_TASK) L0028,
(CHSP3_TASK) L0029,
(CHSP3_TASK) L0030,
(CHSP3_TASK) L0031,
(CHSP3_TASK) L0032,
(CHSP3_TASK) L0033,
(CHSP3_TASK) L0034,
(CHSP3_TASK) L0035,
(CHSP3_TASK) L0036,
(CHSP3_TASK) L0037,
(CHSP3_TASK) L0038,
(CHSP3_TASK) L0039,
(CHSP3_TASK) L0040,
(CHSP3_TASK) L0041,
(CHSP3_TASK) L0042,
(CHSP3_TASK) L0043,
(CHSP3_TASK) L0044,
(CHSP3_TASK) L0045,
(CHSP3_TASK) L0046,
(CHSP3_TASK) L0047,
(CHSP3_TASK) L0048,
(CHSP3_TASK) L0049,
(CHSP3_TASK) L0050,
(CHSP3_TASK) L0051,
(CHSP3_TASK) L0052,
(CHSP3_TASK) L0053,
(CHSP3_TASK) L0054,
(CHSP3_TASK) L0055,
(CHSP3_TASK) L0056,
(CHSP3_TASK) L0057,
(CHSP3_TASK) L0058,
(CHSP3_TASK) L0059,
(CHSP3_TASK) L0060,

};

/*-----------------------------------------------------------*/


/*-----------------------------------------------------------*/

void __HspInit( Hsp3r *hsp3 ) {
	hsp3->Reset( _HSP3CNV_MAXVAR, _HSP3CNV_MAXHPI );
	hsp3->SetDataName( 0 );
	hsp3->SetFInfo( 0, 0 );
	hsp3->SetLInfo( 0, 0 );
	hsp3->SetMInfo( 0, 0 );
}

/*-----------------------------------------------------------*/

