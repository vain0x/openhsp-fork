/**
 * @file Footy.h
 * @brief Footyエディタのためのクラス。中に一つのドキュメントと4個のビューを保持します
 * @author Shinji Watanabe
 * @date Nov.08.2008
 */

#pragma once

#include "FootyDoc.h"
#include "VSplitter.h"
#include "HSplitter.h"

class CFooty
{
public:
	CFooty(int nID, HINSTANCE hInstance, int nViewMode );

	// メソッド
	bool Create(HWND hWnd, int x,int y,int nWidth,int nHeight);
	void ChangeView(int nViewMode,bool bRedraw = false);
	bool Move(int x,int y,int nWidth,int nHeight);
	void SetText(const wchar_t *pString);
	bool SetSelText(const wchar_t *pString);
	bool Paste();
	bool Copy();
	bool Cut();
	bool Undo();
	bool Redo();
	
	// フォント設定
	bool SetFontSize(int nPoint,bool bRedraw);
	bool SetFontFace(int nType,const wchar_t *pFaceName,bool bRedraw);
	
	// 折り返し設定
	bool SetLapel(int nColumns,int nMode,bool bRedraw);
	inline void SetCharSet(CharSetMode nCharSet){m_nCharSet = nCharSet;}
	
	// 取得
	inline int GetID() const {return m_nID;}
	inline CharSetMode GetCharSet() const {return m_nCharSet;}
	bool IsFocused();

public:
	// データ
	CFootyDoc m_cDoc;					//!< ドキュメント
	CFootyStatus m_cStatus;				//!< ステータスクラス
	
	// GUI
	CFootyView m_cView[4];				//!< ビュークラス
	CVSplitter m_cVSplitter;			//!< 垂直スプリッター
	CHSplitter m_cHSplitter;			//!< 水平スプリッター
	
private:
	// IDデータ
	int m_nID;							//!< Footy2のID
	CharSetMode m_nCharSet;				//!< 現在設定されているキャラクタセット
	LineMode m_nLineCode;

	// データ
	HWND m_hWndParent;					//!< 親ウィンドウハンドル
	HINSTANCE m_hInstance;				//!< DLLのインスタンス
	int m_x,m_y;						//!< 位置
	int m_nWidth,m_nHeight;				//!< 大きさ
	int m_nViewMode;					//!< ビュー情報
	CFontObjects m_cFonts;				//!< フォントオブジェクト
};

/*[EOF]*/
