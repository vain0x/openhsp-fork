//
//			HSP3 OP
//			onion software/onitama 2008/5
//
#ifndef __hsp3op_h
#define __hsp3op_h

#include <stdio.h>
#include <string>
#include <map>
#include <set>
#include <vector>
#include <stack>
#include <iostream>
#include <boost/tuple/tuple.hpp>
#include <boost/tuple/tuple_comparison.hpp>

#include "supio.h"
#include "chsp3.h"

class VarId : public boost::tuple<int, int, int> {
public:
	VarId(int type, int varid, int prmid) : boost::tuple<int, int, int>( type, varid, prmid ) {
	}

	int type() const {
		return get<0>();
	}

	int val() const {
		return get<1>();
	}

	int prm() const {
		return get<2>();
	}
};


enum OPCODE {
	NOP, TASK_SWITCH_OP, CALC_OP, PUSH_VAR_OP, PUSH_VAR_PTR_OP, PUSH_DNUM_OP, PUSH_INUM_OP,
	PUSH_LABEL_OP, PUSH_STR_OP, PUSH_CMD_OP, PUSH_FUNC_END_OP, VAR_SET_OP,
	VAR_INC_OP, VAR_DEC_OP, VAR_CALC_OP, COMPARE_OP, CMD_OP, MODCMD_OP, PUSH_DEFAULT_OP,
	PUSH_FUNC_PARAM_OP, PUSH_FUNC_PARAM_PTR_OP,
};

enum COMPILE_TYPE {
	DEFAULT, OPT_STACK, DEFAULT_VALUE, OPT_VALUE
};

class Op;
typedef std::vector<Op*> op_list;

class Op {
public:
	COMPILE_TYPE compile;
	int compileSubType;
	int flag;
	void *llValue;
	int id;
	Op* refer;

	op_list operands;

	Op() : flag(-1), llValue(NULL), refer(NULL), compileSubType(0)
	{
	}
	virtual ~Op() {}
	virtual std::string GetName() const
	{
		return "Op";
	}
	virtual std::string GetParam() const
	{
		return "()";
	}
	virtual OPCODE GetOpCode() const = 0;
};

class TaskSwitchOp : public Op {
	int taskId;
public:
	explicit TaskSwitchOp( int task ) : taskId( task )
	{
	}
	virtual std::string GetName() const
	{
		return "TaskSwitchOp";
	}
	virtual std::string GetParam() const
	{
		char buf[256];
		sprintf( buf, "(%d)", taskId );
		return buf;
	}
	virtual OPCODE GetOpCode() const
	{
		return TASK_SWITCH_OP;
	}
	int GetNextTask() const
	{
		return taskId;
	}
};

class CalcOp : public Op {
	int op;
public:
	explicit CalcOp( int op ) : op( op )
	{
	}
	int GetCalcOp() const
	{
		return op;
	}
	virtual std::string GetName() const
	{
		return "CalcOp";
	}
	virtual OPCODE GetOpCode() const
	{
		return CALC_OP;
	}
};

class VarRefOp : public Op {
protected:
	int type;
	int val;
	int prm;

	int va;
public:
	bool useRegister;

	VarRefOp( int type, int val, int prm, int va ) : type( type ), val( val ), prm( prm ), va( va )
	{
	}
	VarId GetVarId() const
	{
		return VarId(type, val, prm);
	}
	int GetVarType() const
	{
		return type;
	}
	int GetVarNo() const
	{
		return val;
	}
	int GetPrmNo() const
	{
		return prm;
	}
	int GetArrayDim() const
	{
		return va;
	}
	virtual std::string GetParam() const
	{
		char buf[256];
		sprintf( buf, "(%d, %d, %d, %d)", type, val, prm, va );
		return buf;
	}
	virtual bool IsParam() const
	{
		return false;
	}
};

class PushVarOp : public VarRefOp {
public:
	PushVarOp( int val, int va ) : VarRefOp( TYPE_VAR, val, val, va )
	{
	}
	virtual std::string GetName() const
	{
		return "PushVarOp";
	}
	virtual OPCODE GetOpCode() const
	{
		return PUSH_VAR_OP;
	}
};

class PushVarPtrOp : public VarRefOp {
public:
	PushVarPtrOp( int val, int va ) : VarRefOp( TYPE_VAR, val, val, va )
	{
	}
	virtual std::string GetName() const
	{
		return "PushVarPtrOp";
	}
	virtual OPCODE GetOpCode() const
	{
		return PUSH_VAR_PTR_OP;
	}
};

class PushDnumOp : public Op {
	double val;
public:
	explicit PushDnumOp( double val ) : val ( val )
	{
	}
	double GetValue() const
	{
		return val;
	}
	virtual std::string GetName() const
	{
		return "PushDnumOp";
	}
	virtual OPCODE GetOpCode() const
	{
		return PUSH_DNUM_OP;
	}
};

class PushInumOp : public Op {
	int val;
public:
	explicit PushInumOp( int val ) : val ( val )
	{
	}
	int GetValue() const
	{
		return val;
	}
	virtual std::string GetName() const
	{
		return "PushInumOp";
	}
	virtual OPCODE GetOpCode() const
	{
		return PUSH_INUM_OP;
	}
};

class PushLabelOp : public Op {
	int val;
public:
	explicit PushLabelOp( int val ) : val ( val )
	{
	}
	int GetValue() const
	{
		return val;
	}
	virtual std::string GetName() const
	{
		return "PushLabelOp";
	}
	virtual std::string GetParam() const
	{
		char buf[256];
		sprintf( buf, "(%d)", val );
		return buf;
	}
	virtual OPCODE GetOpCode() const
	{
		return PUSH_LABEL_OP;
	}
};

class PushStrOp : public Op {
	int val;
public:
	explicit PushStrOp( int val ) : val ( val )
	{
	}
	int GetValue() const
	{
		return val;
	}
	virtual std::string GetName() const
	{
		return "PushStrOp";
	}
	virtual OPCODE GetOpCode() const
	{
		return PUSH_STR_OP;
	}
};

class PushDefaultOp : public Op {
	double val;
public:
	explicit PushDefaultOp()
	{
	}
	virtual std::string GetName() const
	{
		return "PushDefaultOp";
	}
	virtual OPCODE GetOpCode() const
	{
		return PUSH_DEFAULT_OP;
	}
};

class PushFuncPrmOp : public VarRefOp {
public:
	explicit PushFuncPrmOp( int val, int prm, int va ) : VarRefOp ( TYPE_STRUCT, val, prm, va )
	{
	}
	virtual std::string GetName() const
	{
		return "PushFuncPrmOp";
	}
	virtual OPCODE GetOpCode() const
	{
		return PUSH_FUNC_PARAM_OP;
	}
	virtual bool IsParam() const
	{
		return true;
	}
};

class PushFuncPrmPtrOp : public VarRefOp {
public:
	explicit PushFuncPrmPtrOp( int val, int prm, int va ) : VarRefOp ( TYPE_STRUCT, val, prm, va )
	{
	}
	virtual std::string GetName() const
	{
		return "PushFuncPrmPtrOp";
	}
	virtual OPCODE GetOpCode() const
	{
		return PUSH_FUNC_PARAM_PTR_OP;
	}
	virtual bool IsParam() const
	{
		return true;
	}
};

class CallOp : public Op {
protected:
	int type;
	int val;

	int pnum;
public:
	CallOp( int type, int val, int pnum ) : type( type ), val( val ), pnum ( pnum )
	{
	}
	int GetCmdType() const
	{
		return type;
	}
	int GetCmdVal() const
	{
		return val;
	}
	int GetCmdPNum() const
	{
		return pnum;
	}
};

class PushCmdOp : public CallOp {
public:
	PushCmdOp( int type, int val, int pnum ) : CallOp( type, val, pnum )
	{
	}
	virtual std::string GetName() const
	{
		return "PushCmdOp";
	}
	virtual OPCODE GetOpCode() const
	{
		return PUSH_CMD_OP;
	}
};

class PushFuncEndOp : public Op {
public:
	explicit PushFuncEndOp()
	{
	}
	virtual std::string GetName() const
	{
		return "PushFuncEndOp";
	}
	virtual OPCODE GetOpCode() const
	{
		return PUSH_FUNC_END_OP;
	}
};

class VarSetOp : public VarRefOp {
	int pnum;
public:
	VarSetOp( int type, int val, int prm, int va, int pnum ) : VarRefOp( type, val, prm, va ), pnum( pnum )
	{
	}
	int GetCmdPNum()
	{
		return pnum;
	}
	virtual std::string GetName() const
	{
		return "VarSetOp";
	}
	virtual OPCODE GetOpCode() const
	{
		return VAR_SET_OP;
	}
};

class VarIncOp : public VarRefOp {
public:
	VarIncOp( int type, int val, int prm, int va ) : VarRefOp( type, val, prm, va )
	{
	}
	virtual std::string GetName() const
	{
		return "VarIncOp";
	}
	virtual OPCODE GetOpCode() const
	{
		return VAR_INC_OP;
	}
};

class VarDecOp : public VarRefOp {
public:
	VarDecOp( int type, int val, int prm, int va ) : VarRefOp( type, val, prm, va )
	{
	}
	virtual std::string GetName() const
	{
		return "VarDecOp";
	}
	virtual OPCODE GetOpCode() const
	{
		return VAR_DEC_OP;
	}
};

class VarCalcOp : public VarRefOp {
	int op;
public:
	VarCalcOp( int type, int val, int prm, int va, int op ) : VarRefOp( type, val, prm, va ), op( op )
	{
	}
	virtual std::string GetName() const
	{
		return "VarCalcOp";
	}
	virtual OPCODE GetOpCode() const
	{
		return VAR_CALC_OP;
	}
	int GetCalcOp() const {
		return op;
	}
};

class CompareOp : public Op {
	int taskId;
public:
	CompareOp( int task ) : taskId( task )
	{
	}
	virtual std::string GetName() const
	{
		return "CompareOp";
	}
	virtual OPCODE GetOpCode() const
	{
		return COMPARE_OP;
	}
	int GetNextTask() const
	{
		return taskId;
	}
};

class CmdOp : public CallOp {
public:
	CmdOp( int type, int val, int pnum ) : CallOp( type, val, pnum )
	{
	}
	virtual std::string GetName() const
	{
		return "CmdOp";
	}
	virtual std::string GetParam() const
	{
		char buf[256];
		sprintf( buf, "(%d, %d, %d)//%s", type, val, pnum,
				 CHsp3Parser::GetHSPCmdTypeName( type ).c_str() );
		return buf;
	}
	virtual OPCODE GetOpCode() const
	{
		return CMD_OP;
	}
};

class ModCmdOp : public CallOp {
public:
	ModCmdOp( int type, int val, int pnum ) : CallOp( type, val, pnum )
	{
	}
	virtual std::string GetName() const
	{
		return "ModCmdOp";
	}
	virtual std::string GetParam() const
	{
		char buf[256];
		sprintf( buf, "(%d, %d, %d)", type, val, pnum );
		return buf;
	}
	virtual OPCODE GetOpCode() const
	{
		return MODCMD_OP;
	}
};


class VarInfo {
public:
	int tflag;

	bool localVar;

	VarInfo() : tflag(0), localVar(false)
	{
	}
};

class Block {
public:
	int id;
	std::string name;
	std::vector<VarId> usedVariables;
	op_list operations;
	std::vector<int> nextTasks;

	Block()
	{
	}
};

typedef std::map<std::string, Block*> block_map;
typedef std::map<VarId, std::set<std::string> > var_task_map;
typedef std::map<VarId, VarInfo*> var_info_map;

class Program {
public:
	block_map blocks;
	Block *entryPoint;

	var_task_map varTaskMap;
	var_info_map varInfos;
};

void AnalyzeProgram( Program* program );
void PrettyPrint(std::ostream &out, const Block *block, const CHsp3* hsp);

#endif
