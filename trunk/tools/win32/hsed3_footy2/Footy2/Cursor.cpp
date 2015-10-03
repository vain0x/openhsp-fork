/*===================================================================
CCursorクラス
カーソル管理を行います。
===================================================================*/

#include "Cursor.h"
#include "resource.h"

HCURSOR CCursor::m_hOnUrlCursor = NULL;
HCURSOR CCursor::m_hLineCountCursor = NULL;
HCURSOR CCursor::m_hIBeam = NULL;
HCURSOR CCursor::m_hArrowCursor = NULL;
HCURSOR CCursor::m_hUpDownCursor = NULL;
HCURSOR CCursor::m_hRightLeftCursor = NULL;

/*-------------------------------------------------------------------
CCursor::LoadCursors
カーソルをロードします。
-------------------------------------------------------------------*/
bool CCursor::LoadCursors(HINSTANCE hInstance){
	if (!hInstance)return false;
	/*カーソルを破棄*/
	DestroyCursors();
	/*カーソルの読み込み*/
	m_hArrowCursor = LoadCursor(NULL,IDC_ARROW);
	m_hIBeam = LoadCursor(NULL,IDC_IBEAM);
	m_hUpDownCursor = LoadCursor(NULL,IDC_SIZENS);
	m_hRightLeftCursor = LoadCursor(NULL,IDC_SIZEWE);
	m_hOnUrlCursor = LoadCursor(hInstance,MAKEINTRESOURCE(IDC_URL));
	if (!m_hOnUrlCursor)return false;
	m_hLineCountCursor = LoadCursor(hInstance,MAKEINTRESOURCE(IDC_LINE));
	if (!m_hLineCountCursor)return false;
	return true;
}

/*-------------------------------------------------------------------
CCursor::DestroyCursors
カーソルを破棄します。
-------------------------------------------------------------------*/
void CCursor::DestroyCursors(){
	/*自分でロードしたのは破壊しちゃうよ*/
	SAFE_DELETEOBJECT(m_hOnUrlCursor);
	SAFE_DELETEOBJECT(m_hLineCountCursor);
	/*共通オブジェクトは破壊しちゃまずいでしょ…*/
	m_hIBeam = NULL;
	m_hArrowCursor = NULL;
	m_hUpDownCursor = NULL;
	m_hRightLeftCursor = NULL;
}

/*-------------------------------------------------------------------
CCursor::Use●●
各カーソルを使用するルーチンです。
-------------------------------------------------------------------*/
void CCursor::UseArrow(){				/*アローカーソルを使用します。*/
	SetCursor(m_hArrowCursor);	
}
void CCursor::UseIBeam(){				/*Iビームカーソルを使用します。*/
	SetCursor(m_hIBeam);
}
void CCursor::UseUrlCursor(){			/*URLに乗ったときのカーソルを使用します。*/
	SetCursor(m_hOnUrlCursor);
}
void CCursor::UseLineCount(){			/*行番号表示領域のカーソルを使用します。*/
	SetCursor(m_hLineCountCursor);
}
void CCursor::UseUpDown(){			/*行番号表示領域のカーソルを使用します。*/
	SetCursor(m_hUpDownCursor);
}
void CCursor::UseRightLeft(){			/*行番号表示領域のカーソルを使用します。*/
	SetCursor(m_hRightLeftCursor);
}

/*[EOF]*/
