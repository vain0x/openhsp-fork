/*===================================================================
FootyStatusクラス
CFootyViewクラスの見え方を管理するクラスです。
===================================================================*/

#pragma once

class CFootyStatus{
public:
	CFootyStatus();

	void SetDefaultColor();
private:
public:
	/*色情報*/
	COLORREF m_clDefaultLetter;					/*通常の文字色*/
	COLORREF m_clBackGround;					/*通常の背景色*/
	COLORREF m_clCrlf;							/*改行マークの色*/
	COLORREF m_clHalfSpace;						/*半角スペースの色*/
	COLORREF m_clNormalSpace;					/*全角スペースの色*/
	COLORREF m_clTab;							/*タブマークの色*/
	COLORREF m_clEOF;							/*[EOF]マークの色*/
	COLORREF m_clUnderLine;						/*カーソル下のアンダーライン色*/
	COLORREF m_clLineNumLine;					/*行番号の境界線の色*/
	COLORREF m_clLineNum;						/*行番号の文字の色*/
	COLORREF m_clCaretLine;						/*キャレットがある行の行番号の背景色*/
	COLORREF m_clRulerBk;						/*ルーラーの色*/
	COLORREF m_clRulerText;						/*ルーラーのテキストの色*/
	COLORREF m_clRulerLine;						/*ルーラーの線の色*/
	COLORREF m_clCaretPos;						/*カーソルのある位置のルーラー背景*/
	COLORREF m_clUrl;							/*URLの色*/
	COLORREF m_clUrlUnder;						/*URLの色*/
	COLORREF m_clMail;							/*メールアドレスの色*/
	COLORREF m_clMailUnder;						/*メールアドレスの色*/
	COLORREF m_clHighlightText;					/*強調テキスト*/
	COLORREF m_clHighlightBk;					/*強調背景*/

private:
};

/*[EOF]*/
