//
//			HSP3 OP
//			onion software/onitama 2008/5
//
#include <stdio.h>
#include <string>
#include <map>
#include <set>
#include <vector>
#include <stack>
#include <algorithm>
#include <cassert>

#include "hsp3op.h"
#include "supio.h"
#include "hsp3r.h"

void UpdateOperands( Block *task )
{
	std::stack<Op*> stack;

	for ( auto op : task->operations ) {
		op->operands.clear();
		switch ( op->GetOpCode() ) {
		case PUSH_VAR_OP:
			{
				PushVarOp *pv = (PushVarOp*)op;
				for ( int i = 0; i <  pv->GetArrayDim(); i++ ) {
					op->operands.push_back( stack.top() );
					stack.pop();
				}
				stack.push( op );
			}
			break;
		case PUSH_VAR_PTR_OP:
			{
				PushVarPtrOp *pv = (PushVarPtrOp*)op;
				for ( int i = 0; i <  pv->GetArrayDim(); i++ ) {
					op->operands.push_back( stack.top() );
					stack.pop();
				}
				stack.push( op );
			}
			break;
		case PUSH_FUNC_PARAM_OP:
		case PUSH_FUNC_PARAM_PTR_OP:
			{
				VarRefOp *pv = (VarRefOp*)op;
				for ( int i = 0; i <  pv->GetArrayDim(); i++ ) {
					op->operands.push_back( stack.top() );
					stack.pop();
				}
				stack.push( op );
			}
			break;

		case PUSH_DNUM_OP:
		case PUSH_INUM_OP:
		case PUSH_LABEL_OP:
		case PUSH_STR_OP:
		case PUSH_FUNC_END_OP:
		case PUSH_DEFAULT_OP:
			stack.push( op );
			break;

		case PUSH_CMD_OP:
		{
			PushCmdOp *pcop = (PushCmdOp*)op;
			if (pcop->GetCmdType() == TYPE_SYSVAR) {
				assert(pcop->GetCmdPNum() == 0);
			} else {
				while (stack.top()->GetOpCode() != PUSH_FUNC_END_OP) {
					op->operands.push_back(stack.top());
					stack.pop();
				}
				op->operands.push_back(stack.top());
				stack.pop();
			}
			stack.push(op);
			break;
		}

		case CALC_OP:
			op->operands.push_back( stack.top() );
			stack.pop();
			op->operands.push_back( stack.top() );
			stack.pop();
			stack.push( op );
			break;

		case VAR_INC_OP:
		case VAR_DEC_OP:

		case VAR_CALC_OP:
		case VAR_SET_OP:
			while ( !stack.empty() ) {
				op->operands.push_back( stack.top() );
				stack.pop();
			}
			break;
		case COMPARE_OP:
			op->operands.push_back( stack.top() );
			stack.pop();
			break;
		case CMD_OP:
			{
				CmdOp *pv = (CmdOp*)op;
				for ( int i = 0; i <  pv->GetCmdPNum(); i++ ) {
					op->operands.push_back( stack.top() );
					stack.pop();
				}
			}
			break;
		case MODCMD_OP:
			{
				ModCmdOp *pv = (ModCmdOp*)op;
				op->operands.push_back( stack.top() );
				stack.pop();
				for ( int i = 0; i <  pv->GetCmdPNum(); i++ ) {
					op->operands.push_back( stack.top() );
					stack.pop();
				}
			}
			break;
		case TASK_SWITCH_OP:
			break;
		default:
			break;
		}
	}

	std::set<VarId> usedVariables;
	// アクセスしている変数をリストアップ
	for ( auto op : task->operations ) {
		switch ( op->GetOpCode() ) {
		case PUSH_VAR_OP:
		case PUSH_VAR_PTR_OP:
		case PUSH_FUNC_PARAM_OP:
		case PUSH_FUNC_PARAM_PTR_OP:
		case VAR_SET_OP:
		case VAR_INC_OP:
		case VAR_DEC_OP:
		case VAR_CALC_OP:
			{
				VarRefOp *vr = (VarRefOp*)op;
				usedVariables.insert( vr->GetVarId() );
			}
			break;
		default:
			break;
		}
	}

	for (auto& var : usedVariables) {
		task->usedVariables.push_back(var);
	}

	for ( auto op : task->operations ) {
		for( auto o : op->operands) {
			o->refer = op;
		}
	}
}

void AnalyzeTask( Program* program, Block *block )
{
	UpdateOperands( block );

	// 代入の右辺が変数へのポインタの場合、値に置き換える
	while ( true ) {
		bool changed = false;
		for ( auto op : block->operations ) {
			switch ( op->GetOpCode() ) {
			case VAR_INC_OP:
			case VAR_DEC_OP:
			case VAR_CALC_OP:
			case VAR_SET_OP:
				{
				VarRefOp *vro = (VarRefOp*)op;
				if (vro->operands.size() == 1) {
					Op *rhv = vro->operands[0];
					if ( rhv->GetOpCode() == PUSH_VAR_PTR_OP ) {
						PushVarPtrOp *pv = (PushVarPtrOp*)rhv;
						std::find( block->operations.begin(),
								   block->operations.end(),
								   pv )[0]
							= new PushVarOp( pv->GetVarNo(), pv->GetArrayDim() );
						delete pv;
						UpdateOperands( block );
						changed = true;
					}
				}
				}
				break;
			}
		}
		if ( !changed )
			break;
	}

	//	使っている変数
	for ( auto op : block->operations ) {
		switch ( op->GetOpCode() ) {
		case PUSH_VAR_OP:
		case PUSH_VAR_PTR_OP:

		case PUSH_FUNC_PARAM_OP:
		case PUSH_FUNC_PARAM_PTR_OP:

		case VAR_INC_OP:
		case VAR_DEC_OP:

		case VAR_CALC_OP:
		case VAR_SET_OP:
			program->varTaskMap[((VarRefOp*)op)->GetVarId()].insert( block->name );
			break;

		case PUSH_DNUM_OP:
		case PUSH_INUM_OP:
		case PUSH_LABEL_OP:
		case PUSH_STR_OP:
		case PUSH_FUNC_END_OP:
		case PUSH_CMD_OP:
		case CALC_OP:
		case COMPARE_OP:
		case CMD_OP:
		case MODCMD_OP:
		case TASK_SWITCH_OP:
			break;
		default:
			break;
		}
	}

	// コントロールフロー
	for ( auto op : block->operations ) {
		switch ( op->GetOpCode() ) {
		case PUSH_VAR_OP:
		case PUSH_VAR_PTR_OP:
		case PUSH_FUNC_PARAM_OP:
		case PUSH_FUNC_PARAM_PTR_OP:
		case VAR_INC_OP:
		case VAR_DEC_OP:
		case VAR_CALC_OP:
		case VAR_SET_OP:
		case PUSH_DNUM_OP:
		case PUSH_INUM_OP:
		case PUSH_LABEL_OP:
		case PUSH_STR_OP:
		case PUSH_FUNC_END_OP:
		case PUSH_CMD_OP:
		case PUSH_DEFAULT_OP:
		case CALC_OP:
		case MODCMD_OP:
			break;

		case COMPARE_OP:
		{
			CompareOp *comp = (CompareOp*)op;
			block->nextTasks.push_back( comp->GetNextTask() );
			break;
		}
		case CMD_OP:
		{
			CmdOp *cmd = (CmdOp*)op;
			if ( cmd->GetCmdType() == TYPE_PROGCMD ) {
				switch ( cmd->GetCmdVal() ) {
				case 0x00:								// goto
				case 0x02:								// return
				case 0x03:								// break
				case 0x05:								// loop
				case 0x06:								// continue
				case 0x0b:								// foreach
				case 0x0c:								// (hidden)foreach check
				case 0x10:								// end
				case 0x1b:								// assert
				case 0x11:								// stop
				case 0x19:								// on
					break;
				}
			}
			break;
		}
		case TASK_SWITCH_OP:
		{
			TaskSwitchOp *ts = (TaskSwitchOp*)op;
			block->nextTasks.push_back( ts->GetNextTask() );
			break;
		}
		default:
			Alert( "Unknown op" );
			assert(false);
		}
	}
}

void AnalyzeProgram( Program* program ) {
	block_map& blocks = program->blocks;
	var_task_map& varTaskMap = program->varTaskMap;
	var_info_map& varInfos = program->varInfos;

	for ( auto& elm : blocks ) {
		Block *block = elm.second;
		AnalyzeTask( program, block );

		for (auto& id : block->usedVariables) {
			if (varInfos.find(id) != varInfos.end())
				continue;
			varInfos[id] = new VarInfo();
		}
	}

	for ( auto t : varTaskMap ) {
		const VarId& id = t.first;
		auto& taskIds = t.second;
		if (taskIds.size() == 0)
			continue;

		bool localVar = true;

		// 書き込んでから読み込むタスクだけかチェック
		for ( auto taskId : taskIds) {
			Block *block = program->blocks[taskId];
			VarInfo *var = varInfos[id];
			VarRefOp* firstAccessOp = NULL;

			for(auto op : block->operations) {
				switch ( op->GetOpCode() ) {
				case PUSH_VAR_PTR_OP:
				case PUSH_VAR_OP:
				case PUSH_FUNC_PARAM_OP:
				case PUSH_FUNC_PARAM_PTR_OP:
				case VAR_SET_OP:
				case VAR_CALC_OP:
				case VAR_INC_OP:
				case VAR_DEC_OP:
				{
					VarRefOp* vrop = (VarRefOp*)op;
					if ( vrop->GetVarId() != id )
						continue;
					if ( op->GetOpCode() == PUSH_VAR_PTR_OP ) {
						localVar = false;
					}
					if ( vrop->GetArrayDim() > 0) {
						localVar = false;
					}
					if ( vrop->IsParam() ) {
						localVar = false;
					}
					if ( !firstAccessOp ) {
						firstAccessOp = vrop;
					}
				}
				break;
				}
			}
			switch (firstAccessOp->GetOpCode()) {
			case VAR_SET_OP:
				break;
			case PUSH_VAR_OP:
			case PUSH_VAR_PTR_OP:
			case PUSH_FUNC_PARAM_OP:
			case PUSH_FUNC_PARAM_PTR_OP:
			case VAR_CALC_OP:
			case VAR_INC_OP:
			case VAR_DEC_OP:
				localVar = false;
				break;
			}
		}

		for ( auto id : t.second ) {
			Block *task = blocks[id];
			VarInfo *var = varInfos[t.first];

			var->localVar = localVar;
		}
	}
}


std::ostream& operator<< (std::ostream &out, const Op &op) {
	out << "(" << op.id << ")"
		<< op.GetName()
		<< op.GetParam();

	switch (op.compile) {
	case DEFAULT:
		out << "[DS]";
		break;
	case OPT_STACK:
		out << "[OS]";
		break;
	case DEFAULT_VALUE:
		out << "[DV]";
		break;
	case OPT_VALUE:
		out << "[OV]";
		break;
	default:
		out << "[?]";
		break;
	}
	switch (op.flag) {
	case HSPVAR_FLAG_NONE:
		out << "[NONE]";
		break;
	case HSPVAR_FLAG_LABEL:
		out << "[LABEL]";
		break;
	case HSPVAR_FLAG_STR:
		out << "[STR]";
		break;
	case HSPVAR_FLAG_DOUBLE:
		out << "[DOUBLE]";
		break;
	case HSPVAR_FLAG_INT:
		out << "[INT]";
		break;
	case HSPVAR_FLAG_STRUCT:
		out << "[STRUCT]";
		break;
	case HSPVAR_FLAG_COMSTRUCT:
		out << "[COMSTRUCT]";
		break;
	case HSPVAR_FLAG_MAX:
		out << "[?]";
		break;
	default:
		out << "[#" << op.flag << "]";
		break;
	}

	return out;
}

static void PrettyPrint(std::ostream &out, const Op *op, const CHsp3* hsp, int depth) {
	for (int i = 0; i < depth; ++i) {
		out << "  ";
	}
	out << *op;
	switch (op->GetOpCode()) {
	case PUSH_CMD_OP:
	case CMD_OP:
	case MODCMD_OP:
	{
		auto call = static_cast<const CallOp*>(op);
		out << "; " << hsp->GetHSPName(call->GetCmdType(), call->GetCmdVal());
		break;
	}
	}
	out << std::endl;
	for (auto o : op->operands) {
		PrettyPrint(out, o, hsp, depth + 1);
	}
}

void PrettyPrint(std::ostream &out, const Block *block, const CHsp3* hsp) {

	out << "block:" << block->name << std::endl;

	out << "out:";
	for (auto id : block->nextTasks) {
		out << id << ", ";
	}
	out << std::endl;;

	int id = 0;
	for (auto it = block->operations.begin();
		it != block->operations.end(); ++it, ++id) {
		(*it)->id = id;
	}

	for (auto op : block->operations) {
		out << *op << std::endl;
	}
	out << std::endl;

	for (auto op : block->operations) {
		if (!op->refer) {
			PrettyPrint(out, op, hsp, 0);
		}
	}
	out << std::endl << std::endl;
}
