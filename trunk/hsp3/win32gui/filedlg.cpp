/*------------------------------------------
	File Load/Save common dialog routines
  ------------------------------------------*/

#include <windows.h>
#include <commdlg.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "../hsp3debug.h"

static HWND hwbak;
static OPENFILENAME ofn ;
static char szFileName[_MAX_PATH + 1] ;
static char szTitleName[_MAX_PATH + 1] ;
//static char szFilter[128];


void PopFileInitialize (HWND hwnd)
     {
     ofn.lStructSize       = sizeof (OPENFILENAME) ;
     ofn.hwndOwner         = hwnd ;
     ofn.hInstance         = NULL ;
//   ofn.lpstrFilter       = szFilter ;
     ofn.lpstrCustomFilter = NULL ;
     ofn.nMaxCustFilter    = 0 ;
     ofn.nFilterIndex      = 1 ;
     ofn.nMaxFile          = _MAX_PATH ;
     ofn.lpstrFile         = szFileName ;
     ofn.nMaxFileTitle     = _MAX_PATH ;
     ofn.lpstrFileTitle    = szTitleName ;
     ofn.lpstrInitialDir   = NULL ;
     ofn.lpstrTitle        = NULL ;
     ofn.Flags             = 0 ;             // Set in Open and Close functions
     ofn.nFileOffset       = 0 ;
     ofn.nFileExtension    = 0 ;
     ofn.lpstrDefExt       = NULL ;
     ofn.lCustData         = 0L ;
     ofn.lpfnHook          = NULL ;
     ofn.lpTemplateName    = NULL ;
     }

// SJIS��1�o�C�g�ڂ����ׂ�
#define is_sjis1(c)	 ( ( (unsigned char)(c) >= 0x81 && (unsigned char)(c) <= 0x9F ) || ( (unsigned char)(c) >= 0xE0 && (unsigned char)(c) <= 0xFC ) )

void fd_ini( HWND hwnd, char *extname, char *extinfo )
{
	// dialog p1,16,p3/dialog p1,17,p3 �� OpenFileDialog/SaveFileDialog�ɓn���f�[�^��
	// p1(extname)      p3(extinfo)                    �t�B���^�p�f�[�^ 
	// "txt"            "�e�L�X�g�t�@�C��"              "*.txt\0�e�L�X�g�t�@�C��(*.txt)\0\0"
	// "txt;*.text"     "�e�L�X�g�t�@�C��"              "*.txt;*.text\0�e�L�X�g�t�@�C��(*.txt;*.text)\0\0"
	// "txt;*.text|log" "�e�L�X�g�t�@�C��|���O�t�@�C��" "*.txt;*.text\0�e�L�X�g�t�@�C��(*.txt;*.text)\0*.log\0���O�t�@�C��(*.log)\0\0"
	// ";a*.txt"        "�e�L�X�g�t�@�C��"              "a*.txt\0�e�L�X�g�t�@�C��(a*.txt)\0\0"

	// Shark++
	// �� MS���S�p�𐄏����Ă�����(���j���[�����񂾂�������)�������p�̂ĂĂ��������...
	// �@ ���Ă��Ƃ�"̧��" �� "�t�@�C��" �ɂ��܂����B

#define realloc_filter_buffer()                        \
	pszFilterPtr = (char*)realloc(pszFilter, nFilterLen + 1); \
	if( NULL == pszFilterPtr ) goto out_of_memory;     \
	pszFilter = pszFilterPtr

	// ��؂蕶��
	// "|"��؂�
	static const char DELIMITER_PIPE[]  = "|";
	static const int  DELIMITER_PIPE_LEN= 1;
	// "\n"��؂�
	static const char DELIMITER_CR[]    = "\r\n";
	static const int  DELIMITER_CR_LEN  = 2;
	static const char DEFAULT_DESC[]    = "�t�@�C��";
	static const char ALL_FILE_FILTER[] = "���ׂẴt�@�C�� (*.*)";

	char *pszFilter = NULL, *pszFilterPtr;
	int nFilterLen;
	int nFilterSeek;
	char *fext = NULL, *fext_next;
	char *finf = NULL, *finf_next;
	int fext_len;
	int finf_len;
	bool no_aster;
	int nFilterIndex;

	szFileName[0]=0;
	szTitleName[0]=0;

	fext = extname;
	finf = extinfo;

	nFilterLen = 0;
	nFilterSeek = 0;

	for(nFilterIndex = 0;;
		fext = fext_next + (*DELIMITER_CR == *fext_next && DELIMITER_CR[1] == fext_next[1] ? DELIMITER_CR_LEN : DELIMITER_PIPE_LEN),
		finf = finf_next + (*DELIMITER_CR == *finf_next && DELIMITER_CR[1] == finf_next[1] ? DELIMITER_CR_LEN : DELIMITER_PIPE_LEN),
		nFilterIndex++)
	{
		// ��؂蕶���ŕ���
		for(fext_next = fext; *fext_next &&
			*DELIMITER_PIPE != *fext_next && *DELIMITER_CR != *fext_next;
			fext_next++) {
			// SJIS��1�o�C�g�ڃ`�F�b�N��2�����ڂ��΂��Ƃ���'\0'�`�F�b�N
			if( is_sjis1(*fext_next) && fext_next[1] )
				fext_next++;
		}
		for(finf_next = finf; *finf_next &&
			*DELIMITER_PIPE != *finf_next && *DELIMITER_CR != *finf_next;
			finf_next++) {
			// SJIS��1�o�C�g�ڃ`�F�b�N��2�����ڂ��΂��Ƃ���'\0'�`�F�b�N
			if( is_sjis1(*finf_next) && finf_next[1] )
				finf_next++;
		}
		if( fext_next == fext && finf_next == finf ) {
			break;
		}

		fext_len = (int)(fext_next - fext);
		finf_len = (int)(finf_next - finf);

		if( !*fext_next )
			fext_next -= DELIMITER_PIPE_LEN;
		if( !*finf_next )
			finf_next -= DELIMITER_PIPE_LEN;

		// �g���q�̐擪��';'���������ꍇ��"*."��擪�ɂ��Ȃ����[�h�ɂ���
		no_aster = (';' == *fext);
		if( no_aster ) {
			fext++;
			fext_len--;
		}

		if( 0 == fext_len ||
			('*' == *fext && 1 == fext_len) )
		{
			// �g���q�w�肪�󕶎� or "*" �̏ꍇ�̓t�B���^�ɓo�^�����Ȃ�
			continue;
		}

		// �f�t�H���g�t�@�C�����w��
		if( 0 == nFilterIndex ) {
			if( !no_aster )
				strcat(szFileName, "*.");
			strncat(szFileName, fext, min((size_t)fext_len, sizeof(szFileName)/sizeof(szFileName[0]) - 3/* strlen("*.")+sizeof('\0') */));
		}

		// finf + "(" + "*." + fext + ")" + "\0" + "*." + fext + "\0"
		nFilterSeek = nFilterLen;
		nFilterLen += finf_len + 1 + 2 + fext_len + 1 + 1 + 2 + fext_len + 1 + (no_aster ? -4 : 0);
		if( 0 == finf_len ) {
			// �t�@�C���̐������󕶎��̏ꍇ�͊g���q+"�t�@�C��"��
			nFilterLen += fext_len;
			nFilterLen += (int)strlen(DEFAULT_DESC); // ��
		}
		realloc_filter_buffer();

		pszFilterPtr = pszFilter + nFilterSeek;
		*pszFilterPtr = '\0';

		// �t�B���^����
		if( 0 == finf_len ) {
			strncat(pszFilterPtr, fext, (size_t)fext_len);
			strcat(pszFilterPtr, DEFAULT_DESC); // ��
		} else {
			strncat(pszFilterPtr, finf, (size_t)finf_len);
		}

		strcat(pszFilterPtr,  no_aster ? "(" : "(*.");
		strncat(pszFilterPtr, fext, (size_t)fext_len);
		strcat(pszFilterPtr,  ")");
		strcat(pszFilterPtr,  DELIMITER_PIPE);

		// �t�B���^�g���q
		if( !no_aster )
			strcat(pszFilterPtr, "*.");
		strncat(pszFilterPtr, fext, (size_t)fext_len);
		strcat(pszFilterPtr,  DELIMITER_PIPE);
	}

	// "���ׂẴt�@�C�� (*.*)" + "\0" + "*.*" + "\0" + "\0"
	nFilterSeek = nFilterLen;
	nFilterLen += (int)strlen(ALL_FILE_FILTER) + 1 + (int)strlen("*.*") + 1 + 1;
	realloc_filter_buffer();

	pszFilterPtr = pszFilter + nFilterSeek;
	*pszFilterPtr = '\0';

	// �t�B���^����
	strcat(pszFilterPtr, ALL_FILE_FILTER); // ��
	strcat(pszFilterPtr, DELIMITER_PIPE);

	// �t�B���^�g���q
	strcat(pszFilterPtr, "*.*");
	strcat(pszFilterPtr, DELIMITER_PIPE);
	strcat(pszFilterPtr, DELIMITER_PIPE);

//	for(int i = 0; i < nFilterLen-1; i++) if('\0'==pszFilter[i]) pszFilter[i] = '|';
//	MessageBox(NULL,pszFilter,"",0);

	// ��؂蕶����'\0'�ɕϊ�
	pszFilterPtr = pszFilter;
	for(nFilterSeek = 0; nFilterSeek < nFilterLen; pszFilterPtr++, nFilterSeek++) {
		if( is_sjis1(*pszFilterPtr) )
			pszFilterPtr++, nFilterSeek++;
		else if( *DELIMITER_PIPE == *pszFilterPtr )
			*pszFilterPtr = '\0';
	}
	
	PopFileInitialize(hwnd);
	ofn.lpstrFilter = pszFilter;

#undef realloc_filter_buffer

	return;

out_of_memory:
	free(pszFilter);
	throw HSPERR_OUT_OF_MEMORY;
}

char *fd_getfname( void )
{
	return szFileName;
}

BOOL fd_dialog( HWND hwnd, int mode, char *fext, char *finf )
{
	BOOL bResult = FALSE;
	switch(mode) {
	case 0:
		fd_ini( hwnd, fext, finf );
		ofn.Flags = OFN_HIDEREADONLY | OFN_CREATEPROMPT ;
		bResult = GetOpenFileName (&ofn) ;
		free((void*)ofn.lpstrFilter);
		ofn.lpstrFilter = NULL;
		break;
	case 1:
		fd_ini( hwnd, fext, finf );
		ofn.Flags = OFN_OVERWRITEPROMPT | OFN_HIDEREADONLY;
		bResult = GetSaveFileName (&ofn) ;
		free((void*)ofn.lpstrFilter);
		ofn.lpstrFilter = NULL;
		break;
	}
	return bResult;
}


DWORD fd_selcolor( HWND hwnd, int mode )
     {
	 BOOL res;
     static CHOOSECOLOR cc ;
     static COLORREF    crCustColors[16] ;

     cc.lStructSize    = sizeof (CHOOSECOLOR) ;
     cc.hwndOwner      = hwnd ;
     cc.hInstance      = NULL ;
     cc.rgbResult      = RGB (0x80, 0x80, 0x80) ;
     cc.lpCustColors   = crCustColors ;

	 if (mode)
	     cc.Flags          = CC_RGBINIT | CC_FULLOPEN ;
	 else
		 cc.Flags          = CC_RGBINIT;

     cc.lCustData      = 0L ;
     cc.lpfnHook       = NULL ;
     cc.lpTemplateName = NULL ;

     res=ChooseColor(&cc) ;
	 if (res) {
		return (DWORD)cc.rgbResult;
	 }
/*
	rev 43
	mingw : warning : DWORD�^�̖߂�l��-1��Ԃ��Ă���
	�ɑΏ�
*/
	 	return static_cast< DWORD >( -1 );
     }