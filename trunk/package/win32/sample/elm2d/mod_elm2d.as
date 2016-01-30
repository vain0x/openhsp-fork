
;
;	.elm2d support module
;
#define global PI_FIX 0.00628318530717958
#define global PTUSE_POS 1
#define global PTUSE_ANG 2
#define global PTUSE_SCALE 4
#define global PTUSE_EFX 8
#define global PTUSE_ANM 16
#module

#deffunc elm2d_init str fname

	elm2d_name = getpath( fname, 1 )+".elm2d"
	sdim sbuf,$1000
	sdim s1,$100
	sdim s2,$100
	sbuf=";elm2d v0.1\n"
	cur=0
	return

#deffunc elm2d_seti str varname, int val

	sbuf+=";%"+varname+"="+val+"\n"
	return

#deffunc elm2d_setd str varname, double val

	sbuf+=";%"+varname+"="+val+"\n"
	return

#deffunc elm2d_sets str varname, str val

	sbuf+=";%"+varname+"="+val+"\n"
	return

#deffunc elm2d_data str vdata

	sbuf+=vdata+"\n"
	return

#deffunc elm2d_save

	notesel sbuf
	notesave elm2d_name
	return

#defcfunc elm2d_getvar str varname

	res=""
	notesel sbuf
	repeat notemax
	noteget s1,cnt
	if wpeek(s1,0)=$253b {
		getstr s2,s1,2,'='
		if s2=varname {
			getstr res,s1,2+strsize
			break
		}
	}
	loop
	return res

#deffunc elm2d_load

	notesel sbuf
	noteload elm2d_name
	cur=0
	repeat notemax
	noteget s1,cnt
	if peek(s1,0)!=';' : cur=cnt : break
	loop
	return

#deffunc elm2d_getdata var p1

	notesel sbuf
	noteget p1,cur
	cur++
	return


#global

