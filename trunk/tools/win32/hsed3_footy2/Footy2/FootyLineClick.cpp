/**
 * @file FootyLineClick.cpp
 * @brief クリッカブル系の処理を行います。
 * @author Shinji Watanabe
 * @version 1.0
 * @date Jan.08.2008
 */

#include "FootyLine.h"

/**
 * CFootyLine::FindURL
 * @brief URL文字列を検索します。
 * @param start [in] 開始位置
 * @param pBegin [out] 見つかった開始位置
 * @param pEnd [out] 見つかった終了位置
 */
bool CFootyLine::FindURL(size_t start,size_t *pBegin,size_t *pEnd)
{
	// 宣言
	const wchar_t *pLineData = GetLineData() + start;
	size_t nTextLen = GetLineLength();
	size_t len = -1;
	// 検索開始
	for (size_t i=start;i<nTextLen;i++,pLineData++)
	{
		// 比較
		if (5 <= nTextLen-i && IsMatched(pLineData,L"http:",5))len=5;
		if (6 <= nTextLen-i && IsMatched(pLineData,L"https:",6))len=6;
		if (4 <= nTextLen-i && IsMatched(pLineData,L"ftp:",4))len=4;
		
		// 一致したとき
		if (len!=-1)
		{
			*pBegin = i;
			for (pLineData+=len,i+=len;i<nTextLen;i++,pLineData++)
			{
				if (!IsURLChar(*pLineData))	// URLの文字の適合性をチェック
				{
					*pEnd = i;
					return true;
				}
			}
			*pEnd = nTextLen;
			return true;
		}
	}
	*pBegin = *pEnd = -1;
	return false;
}

/**
 * CFootyLine::FindMail
 * @brief メールアドレス文字列を検索します。
 * @param start [in] 開始位置
 * @param pBegin [out] 見つかった開始位置
 * @param pEnd [out] 見つかった終了位置
 */
bool CFootyLine::FindMail(size_t start,size_t *pBegin,size_t *pEnd)
{
	// 宣言
	int work=-1;										//!< 検出用
	bool bDotFound;										//!< ドットが見つかったか
	size_t i,j;
	const wchar_t *pLineData = GetLineData() + start;	//!< 高速化用
	const wchar_t *pWork;
	size_t nTextLen = GetLineLength();

	// 検索
	for (i = start;i<nTextLen;i++,pLineData++)			// 最後から一つ前まで
	{
		bDotFound = false;
		if (*pLineData == L'@')							// ＠マーク発見時
		{
			if (i == 0)continue;						// それ以前が無い場合は次へ
			for (j=i-1,pWork=pLineData-1;;pWork--,j--)	// それ以前を検索していく
			{
				if (j == -1)
				{
					*pBegin=0;
					break;
				}
				if (!IsMailChar(*pWork))				// メール文字列として不適切な場合
				{
					if (j == i - 1)goto NextI;			// ＠マーク以前になかったら次へ
					*pBegin = j + 1;
					break;
				}
			}
			for (j=i+1,pWork=pLineData+1;;pWork++,j++)	// ＠マーク以降を検索
			{
				if (j == nTextLen)
				{
					*pEnd = nTextLen;
					if (bDotFound)
						return true;
					goto NextI;
				}
				if (!IsMailChar(*pWork))
				{
					if (i == j+1)goto NextI;			// それ以降の文字列が見つからない
					*pEnd = j;
					if (bDotFound)
						return true;
					goto NextI;
				}
				if (*pWork == L'.')						// @以降に.が見つかった
					bDotFound = true;
			}
		}
NextI:;
	}
	*pBegin = *pEnd = -1;
	return false;
}

/**
 * CFootyLine::IsMailChar
 * @brief メールアドレスの文字として適正か判定
 * @param c 調べる文字
 * @return 適切な場合trueを返します。
 */
bool CFootyLine::IsMailChar(wchar_t c)
{
	if (c==L'~'  || (97 <=c && c <= 122) || // a～z
		c==L'_'  || (65 <=c && c <= 90)  || // ?,A～Z
		c==L'\\' || (45 <=c && c <= 58)  || // 数字、ピリオド、ハイフン、スラッシュ、コロン
		c==L'='  || (36 <=c && c <= 38)  ||
		c==L'&'  || c==L'%' || c==L'#' || c==L'+')
		return true;
	else
		return false;
}

/**
 * CFootyLine::IsURLChar
 * @brief URLの文字として適正のあるものか調べます。
 * @param c 調べる文字
 * @return 適切な場合trueを返します。
 */
bool CFootyLine::IsURLChar(wchar_t c)
{
	if (c==L'~'  || (97 <=c && c <= 122) ||
		c==L'_'  || (65 <=c && c <= 90)  ||
		c==L'!'  || (44 <=c && c <= 59)  ||
		c==L'='  || (36 <=c && c <= 38)  ||
		c==L'*'  || c==L'?' || c==L'#')
		return true;
	else
		return false;
}

/*[EOF]*/
