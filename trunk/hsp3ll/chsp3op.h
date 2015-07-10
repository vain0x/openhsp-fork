
//
//	CHsp3Op.cpp structures
//
#ifndef __CHsp3Op_h
#define __CHsp3Op_h

#include "chsp3.h"
#include "hsp3op.h"
#include <map>

#define CPPHED_HSPVAR "Var_"

//	HSP3(.ax) -> Intermediate representation conversion class
//
class CHsp3Op : public CHsp3 {
public:

	CHsp3Op();
	int MakeSource( int option, void *ref );
	std::string MakeImmidiateCPPVarName( int type, int val, char *opt=NULL );

	int GetLabMax() const {
		return max_lab;
	}
	const block_map& GetBlocks() const
	{
		return tasks;
	}

	void UpdateOpType(Block *block, const std::map<VarId, int>& varTypes) const;

private:
	//		Settings
	//
	int makeoption;
	int tasknum;
	int curot;						// 追加用のタスク(ラベル)テーブルID
	int curprmindex;				// 現在のパラメーター先頭インデックス
	int curprmlocal;				// 現在のローカル変数スタック数
	int prmcnv_locvar[64];			// パラメーター変換用バッファ(ローカル変数用)
	int max_lab;
	block_map tasks;
	Block *curTask;
	bool reachable;

	//		Internal Function
	//
	int MakeCPPMain( void );
	void MakeCPPSub( int cmdtype, int cmdval );
	void MakeCPPLabel( void );
	void MakeCPPTask( int nexttask );
	void MakeCPPTask2( int nexttask, int newtask );
	void MakeCPPTask( int id, const std::string& name, int nexttask=-1 );
	int MakeCPPParam( bool process, int addprm=0, bool varval=false );
	int GetCPPExpression( int *result, bool process, int flg=0 );
	int GetCPPExpressionSub( bool process, int flg=0 );
	int GetVarExpressionOp( void );
	int MakeCPPVarExpression( bool process, int flg=0, bool varval=false );

	void MakeCPPProgramInfoFuncParam( int structid );
	int GetLocalPrm( int val ) const {
		return prmcnv_locvar[val - curprmindex];
	}
	int GetFuncPrm( int val ) const {
		return val - curprmindex + curprmlocal;
	}
};


#endif
