
;	hspcmp.dll header

#define AHTMODE_QUOTATION	1	// ダブルクォートで囲む
#define AHTMODE_OUTPUT_PURE 2		// 出力時はクォートなし
#define AHTMODE_READ_ONLY 4		// 修正不可
#define AHTMODE_WITH_ID 8		// デフォルトでIDを付加する

#uselib "hspcmp.dll"
#func hsc_ini hsc_ini 6
#func hsc_refname hsc_refname 6
#func hsc_objname hsc_objname 6
#func hsc_compath hsc_compath 6
#func hsc_comp "_hsc_comp@16" int,int,int,int
#func hsc_getmes hsc_getmes 1
#func hsc_clrmes hsc_clrmes 0
#func hsc_ver hsc_ver $10
#func hsc_bye hsc_bye $100

#func hsc3_getsym hsc3_getsym 0
#func hsc3_messize hsc3_messize 1
#func hsc3_make hsc3_make 6
#func hsc3_getruntime hsc3_getruntime 5
#func hsc3_run hsc3_run 1

#func pack_ini pack_ini 6
#func pack_view pack_view 0
#func pack_make pack_make 0
#func pack_exe pack_exe 0
#func pack_opt pack_opt 0
#func pack_rt pack_rt 6
#func pack_get pack_get 6

#func aht_ini aht_ini 6
#func aht_stdbuf aht_stdbuf 1
#func aht_stdsize aht_stdsize 1
#func aht_source aht_source $202
#func aht_makeinit aht_makeinit 0
#func aht_make aht_make 5
#func aht_makeend aht_makeend 6
#func aht_makeput aht_makeput 6

#func aht_getopt aht_getopt 5
#func aht_prjsave aht_prjsave 6
#func aht_prjload aht_prjload 6
#func aht_getprjsrc aht_getprjsrc $202
#func aht_getprjmax aht_getprjmax $202
#func aht_prjload2 aht_prjload2 $202
#func aht_prjloade aht_prjloade $202
#func aht_getpage aht_getpage $202
#func aht_setpage aht_setpage 0
#func aht_parts aht_parts $202
#func aht_getparts aht_getparts $202
#func aht_findstart aht_findstart $202
#func aht_findparts aht_findparts $202
#func aht_findend aht_findend $202
#func aht_listparts aht_listparts $202
#func aht_propupdate aht_propupdate $202
#func aht_getexid aht_getexid $202

#func aht_getpropcnt aht_getpropcnt 1
#func aht_getprop aht_getprop 1
#func aht_getpropid aht_getpropid 5
#func aht_getproptype aht_getproptype 1
#func aht_getpropmode aht_getpropmode 1
#func aht_setprop aht_setprop 6
#func aht_sendstr aht_sendstr 1
#func aht_getmodcnt aht_getmodcnt 1
#func aht_getmodaxis aht_getmodaxis 1
#func aht_setmodaxis aht_setmodaxis 0
#func aht_delmod aht_delmod 0
#func aht_linkmod aht_linkmod 0
#func aht_unlinkmod aht_unlinkmod 0

