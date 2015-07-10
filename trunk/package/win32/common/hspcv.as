;
;	hspcv.dll header
;
#ifndef __hspcv__
#define __hspcv__

#enum global CVOBJ_INFO_SIZEX = 0
#enum global CVOBJ_INFO_SIZEY
#enum global CVOBJ_INFO_CHANNEL
#enum global CVOBJ_INFO_BIT

#define global CV_INTER_NN        0
#define global CV_INTER_LINEAR    1
#define global CV_INTER_CUBIC     2
#define global CV_INTER_AREA      3

#define global CV_WARP_FILL_OUTLIERS 8
#define global CV_WARP_INVERSE_MAP  16

#define global CV_BLUR_NO_SCALE 0
#define global CV_BLUR  1
#define global CV_GAUSSIAN  2
#define global CV_MEDIAN 3
#define global CV_BILATERAL 4

#define global CV_THRESH_BINARY      0
#define global CV_THRESH_BINARY_INV  1
#define global CV_THRESH_TRUNC       2
#define global CV_THRESH_TOZERO      3
#define global CV_THRESH_TOZERO_INV  4
#define global CV_THRESH_MASK        7
#define global CV_THRESH_OTSU        8

#define global CVCOPY_SET 0
#define global CVCOPY_ADD 1
#define global CVCOPY_SUB 2
#define global CVCOPY_MUL 3
#define global CVCOPY_DIF 4
#define global CVCOPY_AND 5

#define global CV_TM_SQDIFF        0
#define global CV_TM_SQDIFF_NORMED 1
#define global CV_TM_CCORR         2
#define global CV_TM_CCORR_NORMED  3
#define global CV_TM_CCOEFF        4
#define global CV_TM_CCOEFF_NORMED 5


#uselib "hspcv.dll"
#func global cvreset cvreset 0
#func global cvsel cvsel 0
#func global cvbuffer cvbuffer 0
#func global cvresize cvresize $202
#func global _cvgetimg cvgetimg $202
#func global cvputimg cvputimg $202
#func global cvload cvload $202
#func global cvsave cvsave $202
#func global cvj2opt cvj2opt $202
#func global cvgetinfo cvgetinfo $202
#func global cvsmooth cvsmooth $202
#func global cvthreshold cvthreshold $202
#func global cvrotate cvrotate $202
#func global cvarea cvarea $202
#func global cvcopy cvcopy $202
#func global cvxors cvxors $202
#func global cvflip cvflip $202
#func global cvloadxml cvloadxml $202
#func global cvfacedetect cvfacedetect $202
#func global cvgetface cvgetface $202
#func global cvmatch cvmatch $202
#func global cvconvert cvconvert $202


; for video
#define global CV_CAP_ANY      0   //‰½‚Å‚à
#define global CV_CAP_MIL      100 //Matrox Imaging Library
#define global CV_CAP_VFW      200 //Video for Windows
#define global CV_CAP_IEEE1394 300 //IEEE1394

#func global cvcapture cvcapture $202
#func global cvgetcapture cvgetcapture $202
#func global cvendcapture cvendcapture $202
#func global cvopenavi cvopenavi $202
#func global cvgetavi cvgetavi $202
#func global cvcloseavi cvcloseavi $202

#func global cvmakeavi cvmakeavi $202
#func global cvputavi cvputavi $202
#func global cvendavi cvendavi $202

#module hspcv

#deffunc cvgetimg int _p1, int _p2

	cvgetinfo sx, _p1, CVOBJ_INFO_SIZEX
	cvgetinfo sy, _p1, CVOBJ_INFO_SIZEY
	if _p2&1 {
		screen ginfo(3),sx,sy
	}
	_cvgetimg _p1
	redraw
	return

#global


