/*===================================================================
CVSplitter
垂直スクロールバーの管理クラスです。
===================================================================*/

#pragma once

#include "SplitBase.h"						/*スプリットバーベースクラス*/

class CVSplitter : public CSplitBase{
public:
	CVSplitter();

	bool MoveWin(int x,int y,int nWidth,int nHeight);

private:
	void OnMouseMove(int x,int y);

public:
private:
};

/*[EOF]*/
