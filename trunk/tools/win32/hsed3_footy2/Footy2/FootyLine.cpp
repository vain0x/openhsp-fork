/**
 * @file FootyLine.cpp
 * @brief CFootyLineの実装を行います。
 * @author Shinji Watanabe
 * @date Oct.30.2008
 */

#include "FootyLine.h"

//-----------------------------------------------------------------------------
/**
 * @brief コンストラクタです。最初の行を構築します。
 */
CFootyLine::CFootyLine()
{
	m_nEthicLine = 1;
	m_nLineOffset = 0;
	m_nRealLineNum = 0;
	m_bEmphasisChached = false;
	m_nLineIcons = 0;
}

//-----------------------------------------------------------------------------
/**
 * @brief 前の行のオフセット値と倫理行数を元にこのオフセット値を設定します。
 * @param pPrevLine 前の行へのイテレータ
 * @return もしも前回と変わっていればtrueが返る
 */
bool CFootyLine::SetPrevLineInfo(LinePt pPrevLine)
{
	// バックアップ
	size_t nOffsetBefore = m_nLineOffset;
	size_t nRealBefore = m_nRealLineNum;

	// 行番号データを計算
	m_nLineOffset = pPrevLine->m_nLineOffset + pPrevLine->m_nEthicLine;
	m_nRealLineNum = pPrevLine->m_nRealLineNum + 1;

	// 前のと一緒かどうかチェックする
	return  m_nLineOffset != nOffsetBefore || m_nRealLineNum != nRealBefore;
}

//-----------------------------------------------------------------------------
/**
 * @brief 行のデータをフラッシュして各種計算を行います。
 * @param nTabLen タブ幅
 * @param nColumn 折り返し桁
 * @param nMode 折り返しモード
 * @return 論理行数が変更された場合trueが返る
 * @note データを変更したら最後にこの処理を呼び出す必要があります。
 */
bool CFootyLine::FlushString(size_t nTabLen,size_t nColumn,int nMode)
{
	// 宣言
	CUrlInfo stInsert;

	// 論理行数の情報を更新する
	size_t nBeforeEthicLine = m_nEthicLine;
	m_nEthicLine = CalcEthicLine(GetLineLength(),nColumn,nTabLen,nMode).m_nEthicLine + 1;

	// クリッカブルURLの検索
	stInsert.m_nEndPos = -1;
	m_vecUrlInfo.clear();
	forever{
		if (!FindURL(stInsert.m_nEndPos + 1,
			&stInsert.m_nStartPos,&stInsert.m_nEndPos))break;
		m_vecUrlInfo.push_back(stInsert);
	}

	// クリッカブルメールアドレスの検索
	stInsert.m_nEndPos = -1;
	m_vecMailInfo.clear();
	forever{
		if (!FindMail(stInsert.m_nEndPos + 1,
			&stInsert.m_nStartPos,&stInsert.m_nEndPos))break;
		m_vecMailInfo.push_back(stInsert);
	}
	return m_nEthicLine != nBeforeEthicLine;
}


//-----------------------------------------------------------------------------
/**
 * @brief nPosの位置がどこら辺にくるか計算するルーチンです。
 */
CFootyLine::EthicInfo CFootyLine::CalcEthicLine(size_t nPos,size_t nColumn,size_t nTab,int nMode) const
{
	// 宣言
	const wchar_t *pWork = GetLineData();
	EthicInfo stRet;
	// 初期化
	stRet.m_nEthicLine = 0;
	stRet.m_nEthicColumn = 0;
	// 文字列走査
	for (size_t i=0;i<nPos;i++,pWork++)
	{
		// タブ
		if (*pWork == L'\t')
		{
			for (stRet.m_nEthicColumn++;;stRet.m_nEthicColumn++)
			{
				if (stRet.m_nEthicColumn % nTab == 0)break;
			}
		}
		else
		{
			// 横二倍かどうか判定する
			bool bIsDualWidth = false;
			if (IsSurrogateLead(*pWork))	// サロゲートペアの１バイト目
			{
				bIsDualWidth = IsDualChar(*pWork,*(pWork+1));
				pWork++;i++;
			}
			else							// サロゲートペアではないとき
			{
				bIsDualWidth = IsDualChar(*pWork);
			}
			// 位置をずらす
			if (bIsDualWidth)stRet.m_nEthicColumn += 2;
			else stRet.m_nEthicColumn ++;
		}
		// 次の文字へ行きます？
		if (IsGoNext(pWork,i,stRet.m_nEthicColumn,nColumn,nMode))
		{
			stRet.m_nEthicColumn = 0;
			stRet.m_nEthicLine ++ ;
		}
	}
	// 値を返す
	return stRet;
}

//-----------------------------------------------------------------------------
/**
 * @brief 倫理行から実際の桁数を計算するルーチンです。
 * @note nEthicLineもnEthicPosも0ベースで渡します。
 */
size_t CFootyLine::CalcRealPosition(size_t nEthicLine,size_t nEthicPos, size_t nColumn,size_t nTab,int nMode) const
{
	// 宣言
	const wchar_t *pWork = GetLineData();
	size_t nLineLength = GetLineLength();
	size_t nVisPosition = 0;
	size_t nNowEthic = 0;
	size_t i;
	// 文字列走査
	for (i=0;i<nLineLength;i++,pWork++)
	{
		// 適合するか(終了？)
		if (nNowEthic == nEthicLine)
		{
			if (nVisPosition >= nEthicPos)break;
		}
		// タブ
		if (*pWork == L'\t')
		{
			for (nVisPosition++;;nVisPosition++)
			{
				if (nVisPosition % nTab == 0)break;
			}
		}
		else
		{
			// 横二倍かどうか判定する
			bool bIsDualWidth = false;
			if (IsSurrogateLead(*pWork))	// サロゲートペアの１バイト目
			{
				bIsDualWidth = IsDualChar(*pWork,*(pWork+1));
				pWork++;i++;
			}
			else							// サロゲートペアではないとき
			{
				bIsDualWidth = IsDualChar(*pWork);
			}
			// 位置をずらす
			if (bIsDualWidth)nVisPosition += 2;
			else nVisPosition ++;
		}
		// 次の行へ行きます？
		if (IsGoNext(pWork,i,nVisPosition,nColumn,nMode))
		{
			nVisPosition = 0;
			nNowEthic ++ ;
		}
	}
	// 値を返す
	return i;
}

//-----------------------------------------------------------------------------
/**
 * @brief 行の最初から指定された位置までの空白数を計算する
 * @param	nPos	[in] 計算位置
 * @return 文字数
 */
size_t CFootyLine::CalcAutoIndentPos( size_t nPos ) const
{
	size_t i = 0;
	for ( i = 0; i < nPos; i++ )
	{
		wchar_t c = m_strLineData[ i ];
		if ( c != '\t' && c != ' ' )
		{
			break;
		}
	}
	return i;
}

/*[EOF]*/
