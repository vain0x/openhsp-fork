
;	hspdx.dll header

#define global HSPDXFIX_VERSION 19

#ifdef HSPDXFIX_DEBUG
	;デバッグモード
	#uselib "hspdx.dbg"
	#define global HSPDXFIX_EXEMDOE 0
#else
	;リリースモード
	#uselib "hspdx.dll"
	#define global HSPDXFIX_EXEMDOE 1
#endif

;---

#func global es_ini		es_ini			$202
#func global es_bye		es_bye			$102
#func global es_release	es_release		$202
#func global es_screen		es_screen		$202
#func global es_buffer		es_buffer		$202
#func global es_window		es_window		$202
#func global es_area		es_area			$202
#func global es_sync		es_sync			$202
#func global es_caps		es_caps			$202
#func global es_opt		es_opt			0

#func global es_palfade	es_palfade		$202
#func global es_boxf		es_boxf			$202
#func global es_copy		es_copy			$202
#func global es_zoom		es_zoom			$202
#func global es_fmes		es_fmes			$202
#func global es_mes		es_mes			$202
#func global es_cls		es_cls			$202
#func global es_put		es_put			$202
#func global es_fmesbuf	es_fmesbuf		$202
#func global es_mesbuf		es_mesbuf		$202

#func global es_size		es_size			$202
#func global es_pat		es_pat			$202
#func global es_link		es_link			$202

#func global es_clear		es_clear		$202
#func global es_new		es_new			$202
#func global es_get		es_get			$202
#func global es_setp		es_setp			$202
#func global es_find		es_find			$202
#func global es_check		es_check		$202
#func global es_offset		es_offset		$202
#func global es_set		es_set			$202
#func global es_flag		es_flag			$202
#func global es_chr		es_chr			$202
#func global es_type		es_type			$202
#func global es_kill		es_kill			$202
#func global es_pos		es_pos			$202
#func global es_posd		es_posd			0
#func global es_apos		es_apos			$202
#func global es_aposd		es_aposd		$202
#func global es_adir		es_adir			$202
#func global es_aim		es_aim			$202
#func global es_draw		es_draw			$202

#func global es_getbuf		es_getbuf		$202
#func global es_palset		es_palset		$202
#func global es_xfer		es_xfer			$202
#func global es_fill		es_fill			$202

#func global es_debug		es_debug		$202

#func global es_buffer_np	es_buffer_np	2
#func global es_buffer_pm	es_buffer_pm	2
#func global es_palcopy	es_palcopy		$202
#func global es_gdi		es_gdi			$202

#func global es_timer		es_timer		$202
#func global es_getfps		es_getfps		$202
#func global es_ang		es_ang			$202
#func global es_sin		es_sin			$202
#func global es_cos		es_cos			$202
#func global es_dist		es_dist			$202
#func global es_saver		es_saver		$202
#func global es_exnew		es_exnew		$202
#func global es_showdia	es_showdia		$202
#func global es_cursor		es_cursor		$202
#func global es_await		es_await		$202

#func global es_gravity	es_gravity		$202
#func global es_bound		es_bound		$202
#func global es_blink		es_blink		$202
#func global es_effect		es_effect		$202
#func global es_move		es_move			$202
#func global es_setpri		es_setpri		$202

#func global es_excopy		es_excopy		$202
#func global es_exboxf		es_exboxf		$202
#func global es_exput		es_exput		$202

#func global es_d3dopt		es_d3dopt		$202
#func global es_clip		es_clip			$202
#func global es_gsel		es_gsel			$202

#func global es_d3dcheck	es_d3dcheck		$202

;---

#define global ESB_ZERO 0
#define global ESB_ONE 1
#define global ESB_SRCCOLOR 2
#define global ESB_INVSRCCOLOR 3
#define global ESB_SRCALPHA 4
#define global ESB_INVSRCALPHA 5
#define global ESB_DESTALPHA 6
#define global ESB_INVDESTALPHA 7
#define global ESB_DESTCOLOR 8
#define global ESB_INVDESTCOLOR 9
#define global ESB_SRCALPHASAT 10

#define global ESB_ALPHA 59
#define global ESB_ADD 15
#define global ESB_SHADOW 55
#define global ESB_NEGATIVE 9
#define global ESB_MULTIPLE 8

#define global ESI_FLAG_LOW 0
#define global ESI_FLAG_HIGH 1
#define global ESI_POSX_DEC 2
#define global ESI_POSX_INT 3
#define global ESI_POSY_DEC 4
#define global ESI_POSY_INT 5
#define global ESI_SPDX_DEC 6
#define global ESI_SPDX_INT 7
#define global ESI_SPDY_DEC 8
#define global ESI_SPDY_INT 9
#define global ESI_PRGCOUNT 10
#define global ESI_ANIMECOUNT 11
#define global ESI_CHRNO 12
#define global ESI_TYPE 13
#define global ESI_EXECPTR_LOW 14
#define global ESI_EXECPTR_HIGH 15
#define global ESI_ACCELX 16
#define global ESI_ACCELY 17
#define global ESI_BOUNCEPOW 18
#define global ESI_BOUNCEFLAG 19
#define global ESI_BLINKFLAG 20
#define global ESI_BLINKCOUNT_LOW 22
#define global ESI_BLINKCOUNT_HIGH 23
#define global ESI_D3DFLAG 24
#define global ESI_DISPX 25
#define global ESI_DISPY 26
#define global ESI_ROTX 27
#define global ESI_ROTY 28
#define global ESI_ROTZ 29
#define global ESI_BLENDFACTOR 30
#define global ESI_ALPHA 31
#define global ESI_DISPFLAG 32
#define global ESI_LIGHT_LOW 34
#define global ESI_LIGHT_HIGH 35
#define global ESI_PRIORITY 36

;---

#define global es_excopy2(%1,%2,%3,%4,%5,%6,%7) es_excopy %1,%2.0,%2.1,%3.0,%3.1,%4.0,%4.1,%5.0,%5.1,%5.2,%6.0,%6.1,%7
#define global ctype es_bfcalc(%1,%2) %2*11+%1
#define global ctype es_rgbcalc(%1,%2,%3) (%1<<16)+(%2<<8)+%3
#define global es_effect2(%1,%2,%3,%4,%5) es_effect %1,%2.0,%2.1,%3.0,%3.1,%3.2,%4.0,%4.1,%5
#define global es_expat(%1,%2,%3,%4,%5) es_pat %1,%3,%4,%5,%2
#define global es_dialog(%1,%2,%3) es_cursor 1:es_showdia:dialog %1,%2,%3:esr_stat=stat:es_cursor 0
#define global es_exput2(%1,%2,%3,%4,%5,%6) es_exput %1.0,%1.1,%2,%3.0,%3.1,%4.0,%4.1,%4.2,%5.0,%5.1,%6

;---

	#func global es_islost		es_islost		$202
;#ifndef HSPDXFIX_IN_MODULE
	;モジュールの中でHSPDXFIXを使用するときには宣言しない
	#module "hspdxfix_module"


	#deffunc es_bufcheck
		mref ret,64
		ret=0
		#ifdef __hsp30__
			prmx=ginfo(2)
		#else
			ginfo 1
		#endif
		if prmx=0 : return
		repeat
			#ifdef __hsp30__
				prmx=ginfo(2)
			#else
				ginfo 1
			#endif
			wait 1
			if prmx=0 : break
		loop
		;バッファがロストしてないか調べる
		es_islost
		ret=stat
	return

	#global
;#else
;	#undef HSPDXFIX_IN_MODULE
;#endif
