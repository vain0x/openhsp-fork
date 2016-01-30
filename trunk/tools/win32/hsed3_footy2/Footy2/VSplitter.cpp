/*===================================================================
CVSplitter
垂直スクロールバーの管理クラスです。
===================================================================*/

#include "VSplitter.h"
#include "Cursor.h"

/*-------------------------------------------------------------------
CVSplitter::CVSplitter
コンストラクタ
-------------------------------------------------------------------*/
CVSplitter::CVSplitter(){
}

/*-------------------------------------------------------------------
CVSplitter::MoveWin
スプリッターを移動させる
-------------------------------------------------------------------*/
bool CVSplitter::MoveWin(int x,int y,int nWidth,int nHeight){
	/*エラーチェック*/
	if (x <= 0 || m_nBaseWidth < x)return false;
	if (nHeight < y)return false;
	/*アタッチされたビューを移動させる*/
	if (m_pViews){
		if (m_nMode == SPLIT_DUAL){
			m_pViews[0].MoveWin(m_nBaseX,m_nBaseY,x-m_nBaseX,nHeight);
			m_pViews[1].MoveWin(x+SPLIT_SIZE,m_nBaseY,nWidth-(x-m_nBaseX)-SPLIT_SIZE,nHeight);
		}
		else if (m_pOtherSplit){
			m_pViews[0].MoveWin(m_nBaseX,y,x-m_nBaseX,m_pOtherSplit->GetY()-y);
			m_pViews[1].MoveWin(x+SPLIT_SIZE,y,nWidth-x-SPLIT_SIZE,m_pOtherSplit->GetY()-y);
			m_pViews[2].MoveWin(m_nBaseX,m_pOtherSplit->GetY()+SPLIT_SIZE,
				x-m_nBaseX,nHeight-(m_pOtherSplit->GetY()-y)-SPLIT_SIZE);
			m_pViews[3].MoveWin(x+SPLIT_SIZE,m_pOtherSplit->GetY()+SPLIT_SIZE,
				nWidth-x-SPLIT_SIZE,nHeight-(m_pOtherSplit->GetY()-y)-SPLIT_SIZE);
		}
	}
	/*スプリットバーを移動させる*/
	MoveWindow(GetWnd(),x,y,SPLIT_SIZE,nHeight,true);
	/*メンバ変数を代入*/
	m_x = x;
	m_y = y;
	return true;
}


/*-------------------------------------------------------------------
CVSplitter::OnMouseMove
マウスが動かされたときの処理
-------------------------------------------------------------------*/
void CVSplitter::OnMouseMove(int x,int y){
	if (m_bDrag)
		MoveWin(m_x+x,m_y,m_nBaseWidth,m_nBaseHeight);
	CCursor::UseRightLeft();
}

/*[EOF]*/
