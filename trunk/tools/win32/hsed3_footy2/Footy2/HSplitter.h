/*===================================================================
CHSplitter
水平スクロールバーの管理クラスです。
===================================================================*/

#pragma once

#include "SplitBase.h"

class CHSplitter : public CSplitBase{
public:
	CHSplitter();

	bool MoveWin(int x,int y,int nWidth,int nHeight);
	bool SetAttachedView(CFootyView *pTop,CFootyView *pBottom);

private:
	void OnMouseMove(int x,int y);

public:
private:
};

/*[EOF]*/
