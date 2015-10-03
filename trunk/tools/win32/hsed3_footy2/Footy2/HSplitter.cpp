/*===================================================================
CHSplitter
水平スクロールバーの管理クラスです。
===================================================================*/

#include "HSplitter.h"
#include "Cursor.h"

/*-------------------------------------------------------------------
CHSplitter::CHSplitter
コンストラクタ
-------------------------------------------------------------------*/
CHSplitter::CHSplitter(){
}


/*-------------------------------------------------------------------
CHSplitter::MoveWin
スプリッターを移動させる
-------------------------------------------------------------------*/
bool CHSplitter::MoveWin(int x,int y,int nWidth,int nHeight){
	/*エラーチェック*/
	if (y <= 0 || m_nBaseHeight < y)return false;
	/*アタッチされたウィンドウを移動させる*/
	if (m_pViews){
		if (m_nMode == SPLIT_DUAL){
			m_pViews[0].MoveWin(x,m_nBaseY,nWidth,y-m_nBaseY);
			m_pViews[1].MoveWin(x,y+SPLIT_SIZE,nWidth,nHeight-(y-m_nBaseY)-SPLIT_SIZE);
		}
		else if (m_pOtherSplit){
			m_pViews[0].MoveWin(x,m_nBaseY,m_pOtherSplit->GetX(),y-m_nBaseY);
			m_pViews[1].MoveWin(m_pOtherSplit->GetX()+SPLIT_SIZE,m_nBaseY,
				nWidth-m_pOtherSplit->GetX()-SPLIT_SIZE,y-m_nBaseY);
			m_pViews[2].MoveWin(x,y+SPLIT_SIZE,m_pOtherSplit->GetX(),m_nBaseHeight-(y-m_nBaseY)-SPLIT_SIZE);
			m_pViews[3].MoveWin(m_pOtherSplit->GetX()+SPLIT_SIZE,y+SPLIT_SIZE,
				nWidth-m_pOtherSplit->GetX()-SPLIT_SIZE,m_nBaseHeight-(y-m_nBaseY)-SPLIT_SIZE);
		}
	}
	/*スプリットバーを移動させる*/
	MoveWindow(GetWnd(),x,y,nWidth,SPLIT_SIZE,true);
	/*メンバ変数を代入*/
	m_x = x;
	m_y = y;
	return true;
}


/*-------------------------------------------------------------------
CHSplitter::OnMouseMove
マウスが動かされたときの処理
-------------------------------------------------------------------*/
void CHSplitter::OnMouseMove(int x,int y){
	if (m_bDrag)
		MoveWin(m_x,m_y+y,m_nBaseWidth,m_nBaseHeight);
	CCursor::UseUpDown();
}

