/**
 * @file SplitBase.h
 * @brief スプリットバーの基底クラスです。
 * @author Shinji Watanabe
 * @date Dec. 28, 2008
 */

#pragma once

#include "FootyView.h"

#define SPLIT_WNDCLASSNAME	L"Splitter"
#define SPLIT_PROPNAME		L"SplitterClass"

class CSplitBase
{
public:
	CSplitBase();
	virtual ~CSplitBase();

	bool Create( HWND hWndParent, HINSTANCE hInstance );
	void DestroySplitBar();
	void OnBaseWindowMove(int x,int y,int nWidth,int nHeight);
	inline HWND GetWnd(){return m_hWnd;}
	inline int GetX() const { return m_x; }
	inline int GetY() const { return m_y; }
	void SetViews(CFootyView *pTopView)
	{
		m_pViews = pTopView;
		m_nMode = SPLIT_DUAL;
	}
	void SetViews(CFootyView *pTopView,CSplitBase *pSplit)
	{
		m_pViews = pTopView;
		m_pOtherSplit = pSplit;
		m_nMode = SPLIT_QUAD;
	}

	void SetVisible(bool bVisible);

	enum fixed_num
	{
		SPLIT_SIZE = 4,
	};

protected:

private:
	static LRESULT CALLBACK SplitWinProc(HWND hWnd,UINT msg,WPARAM wParam,LPARAM lParam);
	LRESULT MainProc(UINT msg,WPARAM wParam,LPARAM lParam);
	virtual void OnMouseDown(int x,int y);
	virtual void OnMouseMove(int x,int y){}
	virtual void OnMouseUp(int x,int y);

public:
protected:
	enum SplitMode
	{
		SPLIT_DUAL,						//!< デュアルビュー
		SPLIT_QUAD,						//!< クアッドビュー
	};

	bool m_bDrag;						//!< 現在ドラッグ中？
	int m_x,m_y;						//!< 現在の位置
	int m_nBaseX,m_nBaseY;				//!< ベースウィンドウの位置
	int m_nBaseWidth,m_nBaseHeight;		//!< ベースウィンドウの大きさ
	
	CFootyView *m_pViews;				//!< Footyのビュー
	CSplitBase *m_pOtherSplit;			//!< 他のスプリットバー
	SplitMode m_nMode;					//!< 現在のビューモード

private:
	HWND m_hWnd;						//!< ウィンドウハンドル
	bool m_bVisible;					//!< 表示状態か？
};

/*[EOF]*/
