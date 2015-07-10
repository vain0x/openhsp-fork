
;	hspda.dll header
;
#cmpopt varname 1

#uselib "hspda.dll"

#func csvstr csvstr $202
#func csvnote csvnote $87

#func xnotesel xnotesel $202
#func xnoteadd xnoteadd $202

#func rndf_ini rndf_ini $202
#func rndf_get rndf_get $202
#func rndf_geti rndf_geti $202

#func csvsel csvsel 1
#func csvres csvres $83
#func csvflag csvflag 0
#func csvopt csvopt 0
#func csvfind csvfind 6

#define CCSV_OPT_NOCASE 1
#define CCSV_OPT_ANDMATCH 2
#define CCSV_OPT_ZENKAKU 4
#define CCSV_OPT_ADDLINE 8
#define CCSV_OPT_EXPRESSION 128

#func getvarid getvarid $202
#func getvarname getvarname $202
#func getmaxvar getmaxvar $202
#func vsave vsave $202
#func vload vload $202
#func vsave_start vsave_start $202
#func vsave_put vsave_put $202
#func vsave_end vsave_end $202
#func vload_start vload_start $202
#func vload_get vload_get $202
#func vload_end vload_end $202

