//
//			HSP3
//			zakki 2011/05
//
#ifndef __compilecontext_h
#define __compilecontext_h

#include <string>
#include <memory>
#include <vector>
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/PassManager.h"

#include "../hsp3/hspvar_core.h"

class CHsp3Op;
class VarId;
struct HSPCTX;

class CompileContext {
public:
	CHsp3Op* hsp;
	llvm::LLVMContext& context;
	llvm::IRBuilder<> builder;
	llvm::Module* module;
	std::unique_ptr<llvm::ExecutionEngine> EE;
	std::unique_ptr<llvm::FunctionPassManager> FPM;
	std::unique_ptr<llvm::PassManager> Passes;
	llvm::GlobalVariable **variables;
	llvm::GlobalVariable *dsBase;
	llvm::GlobalVariable *stmCur;

	explicit CompileContext(CHsp3Op* hsp);
	~CompileContext();

	void ResetModule(HSPCTX **hspctx, PVal **hspVars, void *dsBasePtr);
	void CreateEE();

	llvm::StructType* GetPValType();

	llvm::Value* CreateCalcI(int code, llvm::Value *a, llvm::Value *b, const llvm::Twine &name = "");
	llvm::Value* CreateCalcD(int code, llvm::Value *a, llvm::Value *b, const llvm::Twine &name = "");

	llvm::Value* GetValue(llvm::BasicBlock* bb, int type, int val, int prm, char *opt = NULL);
	llvm::Value* GetValue(llvm::BasicBlock* bb, const VarId& id, char *opt = NULL);

	llvm::Value* CreateCallImm(llvm::BasicBlock *bblock, const std::string& name, const llvm::Twine &vname = "");
	llvm::Value* CreateCallImm(llvm::BasicBlock *bblock, const std::string& name, int a, const llvm::Twine &vname = "");
	llvm::Value* CreateCallImm(llvm::BasicBlock *bblock, const std::string& name, int a, int b, const llvm::Twine &vname = "");
};

bool DumpModule(const char *name, const llvm::Module& M);

#endif
