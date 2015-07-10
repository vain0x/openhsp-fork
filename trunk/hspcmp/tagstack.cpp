
//
//		stack buffer with tag class
//			onion software/onitama 2002/10
//
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tagstack.h"

//-------------------------------------------------------------
//		Routines
//-------------------------------------------------------------

int CTagStack::SearchTagID( char *tag )
{
	//		タグを検索
	//
	int i;
	if ( tagent==0 ) return -1;
	for(i=0;i<tagent;i++) {
		if ( !strcmp(mem_tag[i].name, tag) ) return i;
	}
	return -1;
}


int CTagStack::RegistTagID( char *tag )
{
	//		タグを登録
	//
	if ( tagent>=TAGSTK_TAGMAX ) return -1;
	int const i = tagent; tagent++;
	strncpy_s(mem_tag[i].name, tag, TAGSTK_TAGSIZE - 1); mem_tag[i].name[TAGSTK_TAGSIZE - 1] = '\0';
	return i;
}


void CTagStack::GetTagUniqueName( int tagid, char *outname )
{
	//		タグIDに対応したユニーク名を取得
	//
	TAGINF *t;
	if (( tagid < 0 )||( tagid >= TAGSTK_TAGMAX )) {
		sprintf( outname,"TagErr%04x",gcount++ );
	} else {
		t = &mem_tag[tagid];
		sprintf( outname,"_%s_%04x", t->name, t->uid++ );
	}
}


int CTagStack::GetTagID( char *tag )
{
	//		タグ名->タグID に変換する
	//
	int i;
	i = SearchTagID( tag );
	if ( i<0 ) { i = RegistTagID( tag ); }
	return i;
}


char *CTagStack::GetTagName( int tagid )
{
	//		タグID->タグ名 に変換する
	//
	if (( tagid < 0 )||( tagid >= TAGSTK_TAGMAX )) return tagerr;
	return mem_tag[tagid].name;
}


int CTagStack::StackCheck( char *res )
{
	//		すべてのスタックが解決されているかをチェック
	//			0=OK/1>=NG (resにエラースタックを含むタグ一覧)
	//
	int i,n;
	TAGDATA *t;
	strcpy ( res, "\t" );
	for(i=0;i<TAGSTK_TAGMAX;i++) { mem_tag[i].check = 0; }
	if ( lastidx<1 ) return 0;
	i = lastidx;
	while(1) {
		i--; if ( i<0 ) break;
		t = &mem_buf[i];
		if ( t->tagid >= 0 ) mem_tag[ t->tagid ].check = -1;
	}
	n=0;
	for(i=0;i<TAGSTK_TAGMAX;i++) {
		if ( mem_tag[i].check ) {
			if ( n ) strcat( res, ", " );
			strcat( res, mem_tag[i].name );
			n++;
		}
	}
	return n;
}


int CTagStack::PushTag( int tagid, char *str )
{
	//		タグID,strをスタックに入れる
	//
	int i,len;
	TAGDATA *t;
	if (( tagid < 0 )||( tagid >= TAGSTK_TAGMAX )) return -1;
	if ( lastidx >= TAGSTK_MAX ) return -1;
	i = lastidx; lastidx++;
	t = &mem_buf[i];
	t->tagid = tagid;
	len = strlen( str );if ( len>=TAGSTK_SIZE ) str[TAGSTK_SIZE-1]=0;
	strcpy( t->data, str );
	return i;
}


char *CTagStack::PopTag( int tagid )
{
	//		タグIDに対応したスタックstrを取り出す
	//
	int i;
	TAGDATA *t;
	char *p;
	if (( tagid < 0 )||( tagid >= TAGSTK_TAGMAX )) return NULL;
	if ( lastidx<1 ) return NULL;
	i = lastidx;
	while(1) {							// スタックを辿る
		i--; if ( i<0 ) return NULL;
		t = &mem_buf[i];
		if ( t->tagid == tagid ) break;
	}
	p = t->data;
	t->tagid = -1;
	i = lastidx - 1;
	while(1) {
		if ( i<0 ) break;
		if ( mem_buf[i].tagid != -1 ) break;
		lastidx = i;
		i--;
	}
	return p;
}


char *CTagStack::LookupTag( int tagid, int level )
{
	//		タグIDに対応したスタックstrを取り出す(POPしない)
	//				(level=スタック段数0,1,2…)
	//
	int i,lv;
	TAGDATA *t;
	if (( tagid < 0 )||( tagid >= TAGSTK_TAGMAX )) return NULL;
	if ( lastidx<1 ) return NULL;
	lv = level;
	i = lastidx;
	while(1) {							// スタックを辿る
		i--;if ( i<0 ) return NULL;
		t = &mem_buf[i];
		if ( t->tagid == tagid ) {
			if ( lv==0 ) break;
			lv--;
		}
	}
	return t->data;
}


//-------------------------------------------------------------
//		Interfaces
//-------------------------------------------------------------

CTagStack::CTagStack()
{
	int i;
	for(i=0;i<TAGSTK_TAGMAX;i++) {
		mem_tag[i].name[0] = 0;
		mem_tag[i].uid = 0;
	}
	for(i=0;i<TAGSTK_MAX;i++) {
		mem_buf[i].data[0] = 0;
		mem_buf[i].tagid = -1;
	}
	tagent = 0;
	lastidx = 0;
	gcount = 0;
	strcpy( tagerr, "%err%" );
}
