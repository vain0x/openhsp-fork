//
//			HSP3
//			zakki 2011/05
//
#include "compilecontext.h"

#include <stdio.h>
#include <string>
#include <map>
#include <set>
#include <vector>
#include <stack>
#include <fstream>
#include <boost/ptr_container/ptr_vector.hpp>
#include <boost/format.hpp>


#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/PassManager.h"
#include "llvm/IR/TypeBuilder.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Analysis/Passes.h"
#include "llvm/AsmParser/Parser.h"
#include "llvm/Bitcode/ReaderWriter.h"
#include "llvm/ExecutionEngine/JIT.h"
#include "llvm/ExecutionEngine/Interpreter.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/Transforms/Scalar.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/ManagedStatic.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/FileSystem.h"

#include "llvm/Analysis/Passes.h"
#include "llvm/Transforms/IPO.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/Transforms/Utils/Cloning.h"

#include "supio.h"
#include "chsp3op.h"
#include "chsp3llvm.h"
#include "hsp3r.h"
#include "hsp3op.h"

#ifdef HSPWIN
#include <windows.h>
#endif

#define HSP_PROFILE 0

using namespace llvm;
using std::string;
using boost::format;

extern void HspVarCoreArray2(PVal *pval, int offset);
void* HspLazyFunctionCreator(const string &name);

static std::unique_ptr<Module> rtModule;

bool DumpModule(const char *name, const Module &M)
{
	string errorInfo;
	raw_fd_ostream out(name, errorInfo, sys::fs::F_None);
	if (!errorInfo.empty()) {
		errs() << errorInfo << '\n';
		return false;
	}

	out << M;
	return true;
}

void LoadLLRuntime()
{
#ifdef HSPWIN
	HRSRC hrc;
	HGLOBAL hgb;
	LPVOID p;
	LLVMContext& context = getGlobalContext();

	hrc = FindResource(NULL, MAKEINTRESOURCEA(256), "TEXT");
	hgb = LoadResource(NULL, hrc);
	p = LockResource(hgb);

	SMDiagnostic err;
	rtModule.reset(ParseAssemblyString((char*)p, nullptr, err, context));
	FreeResource(hrc);
	if (!rtModule)
		Alert(err.getMessage().data());
#else
#error
#endif
}


CompileContext::CompileContext(CHsp3Op* hsp)
	: hsp(hsp), context(getGlobalContext()), builder(context), module(nullptr)
{
	if (!rtModule)
		LoadLLRuntime();
}

CompileContext::~CompileContext()
{
}

void CompileContext::ResetModule(HSPCTX **hspctx, PVal **hspVars, void *dsBasePtr)
{
	EE.reset();
	module = CloneModule(rtModule.get());

	Type *pvalType = GetPValType();
	int maxvar = hsp->GetHSPHed()->max_val;

	// ïœêîÇÃèÄîı
	variables = new GlobalVariable*[maxvar];
	for (int i = 0; i < maxvar; i++) {
		variables[i] = (GlobalVariable*)module->getOrInsertGlobal(CPPHED_HSPVAR + hsp->GetHSPVarName(i), pvalType);
	}

	dsBase = (GlobalVariable*)module->getOrInsertGlobal("ds_base", Type::getInt32Ty(context));

	CreateEE();

	for (int i = 0; i < maxvar; i++) {
		EE->updateGlobalMapping(variables[i], hspVars[i]);
	}
	EE->updateGlobalMapping(dsBase, dsBasePtr);

	stmCur = (GlobalVariable*)module->getGlobalVariable("stm_cur");
	EE->updateGlobalMapping(stmCur, (void*)&stm_cur);

	GlobalVariable *ctx = (GlobalVariable*)module->getGlobalVariable("hspctx");
	EE->updateGlobalMapping(ctx, (void*)hspctx);
}

Value* CompileContext::GetValue(BasicBlock* bb, const VarId& id, char *opt)
{
	return GetValue(bb, id.type(), id.val(), id.prm(), opt);
}

Value* CompileContext::GetValue(BasicBlock* bb, int type, int val, int prm, char *opt)
{
	//		íºíl(int,double,str)Çí«â¡
	//		(í«â¡Ç≈Ç´Ç»Ç¢å^ÇÃèÍçáÇÕ-1Çï‘Ç∑)
	//
	char mes[4096];
	int i;
	i = hsp->MakeImmidiateName(mes, type, val);
	if (i == 0) return NULL;
	switch (type) {
	case TYPE_VAR:
		sprintf(mes, "%s%s", CPPHED_HSPVAR, hsp->GetHSPVarName(val).c_str());
		if (opt != NULL) strcat(mes, opt);
		break;
	case TYPE_STRUCT:
	{
		const STRUCTPRM *st = hsp->GetMInfo(val);
		switch (st->mptype) {
		case MPTYPE_LOCALVAR:
			return CreateCallImm(bb, "LocalPrm", prm);
			break;
		default:
			return CreateCallImm(bb, "FuncPrm", prm);
			break;
		}
		break;
	}
	case TYPE_LABEL:
		sprintf(mes, "*L%04x", val);
		break;
	default:
		strcpy(mes, hsp->GetHSPName(type, val).c_str());
		if (opt != NULL) strcat(mes, opt);
		if (*mes == 0) return NULL;
		break;
	}
	return module->getNamedValue(mes);
}



// LLVM utilities
//

StructType* CompileContext::GetPValType()
{
	return (StructType*)module->getTypeByName("struct.PVal");
}

Value* CompileContext::CreateCallImm(BasicBlock *bblock, const string& name, const llvm::Twine &vname)
{
	Function *f = module->getFunction(name);
	if (!f)
		Alert((char*)(name + " not found!").c_str());

	std::vector<Value*> args;

	builder.SetInsertPoint(bblock);
	return builder.CreateCall(f, makeArrayRef(args), vname);
}

Value* CompileContext::CreateCallImm(BasicBlock *bblock, const string& name, int a, const llvm::Twine &vname)
{
	Function *f = module->getFunction(name);
	if (!f)
		Alert((char*)(name + " not found!").c_str());

	std::vector<Value*> args;

	args.push_back(ConstantInt::get(Type::getInt32Ty(context), a));

	builder.SetInsertPoint(bblock);
	return builder.CreateCall(f, makeArrayRef(args), vname);
}

Value* CompileContext::CreateCallImm(BasicBlock *bblock, const string& name, int a, int b, const llvm::Twine &vname)
{
	Function *f = module->getFunction(name);
	if (!f)
		Alert((char*)(name + " not found!").c_str());

	std::vector<Value*> args;

	args.push_back(ConstantInt::get(Type::getInt32Ty(context), a));
	args.push_back(ConstantInt::get(Type::getInt32Ty(context), b));

	builder.SetInsertPoint(bblock);
	return builder.CreateCall(f, makeArrayRef(args), vname);
}

Value* CompileContext::CreateCalcI(int code, Value *a, Value *b, const llvm::Twine &name)
{
	switch (code) {
	case CALCCODE_ADD:
		return builder.CreateAdd(a, b, name);
	case CALCCODE_SUB:
		return builder.CreateSub(a, b, name);
	case CALCCODE_MUL:
		return builder.CreateMul(a, b, name);
	case CALCCODE_DIV:
		return builder.CreateSDiv(a, b, name);
	case CALCCODE_MOD:
		return builder.CreateSRem(a, b, name);
	case CALCCODE_AND:
		return builder.CreateAnd(a, b, name);
	case CALCCODE_OR:
		return builder.CreateOr(a, b, name);
	case CALCCODE_XOR:
		return builder.CreateXor(a, b, name);
	case CALCCODE_EQ:
	{
		Value *cond = builder.CreateICmpEQ(a, b, name);
		return builder.CreateZExt(cond, Type::getInt32Ty(context), name);
	}
	case CALCCODE_NE:
	{
		Value *cond = builder.CreateICmpNE(a, b, name);
		return builder.CreateZExt(cond, Type::getInt32Ty(context), name);
	}
	case CALCCODE_GT:
	{
		Value *cond = builder.CreateICmpSGT(a, b, name);
		return builder.CreateZExt(cond, Type::getInt32Ty(context), name);
	}
	case CALCCODE_LT:
	{
		Value *cond = builder.CreateICmpSLT(a, b, name);
		return builder.CreateZExt(cond, Type::getInt32Ty(context), name);
	}
	case CALCCODE_GTEQ:
	{
		Value *cond = builder.CreateICmpSGE(a, b, name);
		return builder.CreateZExt(cond, Type::getInt32Ty(context), name);
	}
	case CALCCODE_LTEQ:
	{
		Value *cond = builder.CreateICmpSLE(a, b, name);
		return builder.CreateZExt(cond, Type::getInt32Ty(context), name);
	}
	case CALCCODE_RR:
		return builder.CreateAShr(a, b, name);
	case CALCCODE_LR:
		return builder.CreateShl(a, b, name);

	default:
		return NULL;
	}
}

Value* CompileContext::CreateCalcD(int code, Value *a, Value *b, const llvm::Twine &name)
{
	switch (code) {
	case CALCCODE_ADD:
		return builder.CreateFAdd(a, b, name);
	case CALCCODE_SUB:
		return builder.CreateFSub(a, b, name);
	case CALCCODE_MUL:
		return builder.CreateFMul(a, b, name);
	case CALCCODE_DIV:
		return builder.CreateFDiv(a, b, name);
	case CALCCODE_MOD:
		return builder.CreateFRem(a, b, name);
		//	case CALCCODE_AND:
		//	case CALCCODE_OR:
		//	case CALCCODE_XOR:
	case CALCCODE_EQ:
	{
		Value *cond = builder.CreateFCmpUEQ(a, b, name);
		return builder.CreateZExt(cond, Type::getInt32Ty(context), name);
	}
	case CALCCODE_NE:
	{
		Value *cond = builder.CreateFCmpUNE(a, b, name);
		return builder.CreateZExt(cond, Type::getInt32Ty(context), name);
	}
	case CALCCODE_GT:
	{
		Value *cond = builder.CreateFCmpUGT(a, b, name);
		return builder.CreateZExt(cond, Type::getInt32Ty(context), name);
	}
	case CALCCODE_LT:
	{
		Value *cond = builder.CreateFCmpULT(a, b, name);
		return builder.CreateZExt(cond, Type::getInt32Ty(context), name);
	}
	case CALCCODE_GTEQ:
	{
		Value *cond = builder.CreateFCmpUGE(a, b, name);
		return builder.CreateZExt(cond, Type::getInt32Ty(context), name);
	}
	case CALCCODE_LTEQ:
	{
		Value *cond = builder.CreateFCmpULE(a, b, name);
		return builder.CreateZExt(cond, Type::getInt32Ty(context), name);
	}
		//	case CALCCODE_RR:
		//	case CALCCODE_LR:
	default:
		return NULL;
	}
}

void CompileContext::CreateEE()
{
	string errMsg;
	if (verifyModule(*module, &raw_string_ostream(errMsg))) {
		Alert((char*)errMsg.c_str());
	}

	EE.reset(EngineBuilder(module)
		.setEngineKind(EngineKind::JIT)
		.setUseMCJIT(true)
		.setOptLevel(CodeGenOpt::Aggressive)
		.create());

	EE->InstallLazyFunctionCreator(HspLazyFunctionCreator);

#define REGISTER_RT_(t, name, func) \
	do {\
		Function *KnownFunction = Function::Create(\
		TypeBuilder<t, false>::get(context),\
			GlobalValue::ExternalLinkage, name,\
			module);\
		EE->addGlobalMapping(KnownFunction, (void*)(intptr_t)func);\
	} while (false);

#define REGISTER_RT(t, func) REGISTER_RT_(t, #func, func)

	REGISTER_RT(void(int, int), Prgcmd);
	REGISTER_RT(void(int, int), Modcmd);
	REGISTER_RT(void(void*, int, int), VarSet);
	REGISTER_RT(void(void*, int), VarSetIndex1);
	REGISTER_RT(void(void*, int, int), VarSetIndex2);
	REGISTER_RT(void(void*, int, int), VarSetIndex1i);
	REGISTER_RT(void(void*, int, int, int), VarSetIndex2i);
	REGISTER_RT(void(void*, double, int), VarSetIndex1d);
	REGISTER_RT(void(void*, double, int, int), VarSetIndex2d);

	REGISTER_RT(void(int), StackPushi);
	REGISTER_RT_(void(int), "PushInt", StackPushi);
	REGISTER_RT(void(int), StackPushd);
	REGISTER_RT_(void(double), "PushDouble", StackPushd);
	REGISTER_RT(void(int), StackPushl);
	REGISTER_RT_(void(int), "PushLabel", StackPushl);
	REGISTER_RT(void(char*), PushStr);
	REGISTER_RT(void(void*, int), PushVar);
	REGISTER_RT(void(void*, int), PushVAP);
	REGISTER_RT(void(), PushDefault);

	REGISTER_RT(void(), PushFuncEnd);

	REGISTER_RT(void(int), PushFuncPrm1);
	REGISTER_RT(void(int), PushFuncPrmI);
	REGISTER_RT(void(int), PushFuncPrmD);
	REGISTER_RT(void(int, int), PushFuncPrm);
	REGISTER_RT(void(int, int), PushFuncPAP);
	REGISTER_RT(void*(int), FuncPrm);
	REGISTER_RT(void*(int), LocalPrm);

	REGISTER_RT(int(int), FuncPrmI);
	REGISTER_RT(double(int), FuncPrmD);

	REGISTER_RT(void(), CalcAddI);
	REGISTER_RT(void(), CalcSubI);
	REGISTER_RT(void(), CalcMulI);
	REGISTER_RT(void(), CalcDivI);
	REGISTER_RT(void(), CalcModI);
	REGISTER_RT(void(), CalcAndI);
	REGISTER_RT(void(), CalcOrI);
	REGISTER_RT(void(), CalcXorI);
	REGISTER_RT(void(), CalcEqI);
	REGISTER_RT(void(), CalcNeI);
	REGISTER_RT(void(), CalcGtI);
	REGISTER_RT(void(), CalcLtI);
	REGISTER_RT(void(), CalcGtEqI);
	REGISTER_RT(void(), CalcLtEqI);
	REGISTER_RT(void(), CalcRrI);
	REGISTER_RT(void(), CalcLrI);

	REGISTER_RT(void(int, int), PushIntfunc);
	REGISTER_RT(void(void*, int, int), VarCalc);
	REGISTER_RT(void(void*, int), VarInc);
	REGISTER_RT(void(int), TaskSwitch);
	REGISTER_RT(char(), HspIf);
	REGISTER_RT(void(int, int), PushSysvar);
	REGISTER_RT(void(int, int), PushExtvar);
	REGISTER_RT(void(int, int), PushModcmd);
	REGISTER_RT(void(int, int), Extcmd);
	REGISTER_RT(void(int, int), Intcmd);
	REGISTER_RT(void(int, int), PushDllfunc);
	REGISTER_RT(void(int, int), PushDllctrl);
	REGISTER_RT(int(), GetTaskID);
	//REGISTER_RT(int(Hsp3r*, int, int), Hsp3rReset);
	REGISTER_RT(void(void*, int), HspVarCoreArray2);

	REGISTER_RT(double(int, int), CallDoubleIntfunc);
	REGISTER_RT(int(int, int), CallIntIntfunc);
	REGISTER_RT(double(int, int), CallDoubleSysvar);
	REGISTER_RT(int(int, int), CallIntSysvar);
	REGISTER_RT(int(), PopInt);
	REGISTER_RT(double(), PopDouble);

	//REGISTER_RT(char(), HspIf);
	//REGISTER_RT(void(int, int), PushSysvar);
#undef REGISTER_RT

	Passes.reset(new PassManager());
	FPM.reset(new FunctionPassManager(module));

	Passes->add(new DataLayoutPass(module));
	Passes->add(createVerifierPass());

	PassManagerBuilder Builder;
	Builder.OptLevel = 3;
	Builder.SizeLevel = 0;
	Builder.Inliner = createFunctionInliningPass(Builder.OptLevel, Builder.SizeLevel);

	Builder.populateModulePassManager(*Passes);
	Builder.populateLTOPassManager(*Passes, false, true);
	Builder.populateFunctionPassManager(*FPM);
	Builder.populateModulePassManager(*Passes);

	FPM->doInitialization();

	for (auto& f : *module) {
		// Run the FPM on this function
		FPM->run(f);
	}

	return;
}

void* HspLazyFunctionCreator(const string &name)
{
#define RESOLVE_FUNC(arg) if (#arg == name) return arg
	RESOLVE_FUNC(Prgcmd);
	RESOLVE_FUNC(Modcmd);
	RESOLVE_FUNC(VarSet);
	RESOLVE_FUNC(VarSetIndex1);
	RESOLVE_FUNC(VarSetIndex2);
	RESOLVE_FUNC(VarSetIndex1i);
	RESOLVE_FUNC(VarSetIndex2i);
	RESOLVE_FUNC(VarSetIndex1d);
	RESOLVE_FUNC(VarSetIndex2d);
	RESOLVE_FUNC(StackPushi);
	if ("PushInt" == name) return StackPushi;
	RESOLVE_FUNC(StackPushd);
	if ("PushDouble" == name) return StackPushd;
	RESOLVE_FUNC(PushStr);
	RESOLVE_FUNC(StackPushl);
	if ("PushLabel" == name) return StackPushl;
	RESOLVE_FUNC(PushVar);
	RESOLVE_FUNC(PushVAP);
	RESOLVE_FUNC(PushDefault);
	RESOLVE_FUNC(PushFuncEnd);

	RESOLVE_FUNC(PushFuncPrm1);
	RESOLVE_FUNC(PushFuncPrmI);
	RESOLVE_FUNC(PushFuncPrmD);
	RESOLVE_FUNC(PushFuncPrm);
	RESOLVE_FUNC(PushFuncPAP);
	RESOLVE_FUNC(FuncPrm);
	RESOLVE_FUNC(LocalPrm);
	RESOLVE_FUNC(FuncPrmI);
	RESOLVE_FUNC(FuncPrmD);

	RESOLVE_FUNC(CalcAddI);
	RESOLVE_FUNC(CalcSubI);
	RESOLVE_FUNC(CalcMulI);
	RESOLVE_FUNC(CalcDivI);
	RESOLVE_FUNC(CalcModI);
	RESOLVE_FUNC(CalcAndI);
	RESOLVE_FUNC(CalcOrI);
	RESOLVE_FUNC(CalcXorI);
	RESOLVE_FUNC(CalcEqI);
	RESOLVE_FUNC(CalcNeI);
	RESOLVE_FUNC(CalcGtI);
	RESOLVE_FUNC(CalcLtI);
	RESOLVE_FUNC(CalcGtEqI);
	RESOLVE_FUNC(CalcLtEqI);
	RESOLVE_FUNC(CalcRrI);
	RESOLVE_FUNC(CalcLrI);

	RESOLVE_FUNC(PushIntfunc);
	RESOLVE_FUNC(VarCalc);
	RESOLVE_FUNC(VarInc);
	RESOLVE_FUNC(TaskSwitch);
	RESOLVE_FUNC(HspIf);
	RESOLVE_FUNC(PushSysvar);
	RESOLVE_FUNC(PushExtvar);
	RESOLVE_FUNC(PushModcmd);
	RESOLVE_FUNC(Extcmd);
	RESOLVE_FUNC(Intcmd);
	RESOLVE_FUNC(PushDllfunc);
	RESOLVE_FUNC(PushDllctrl);
	RESOLVE_FUNC(GetTaskID);
	//RESOLVE_FUNC(Hsp3rReset);
	RESOLVE_FUNC(HspVarCoreArray2);
	RESOLVE_FUNC(CallDoubleIntfunc);
	RESOLVE_FUNC(CallIntIntfunc);
	RESOLVE_FUNC(CallDoubleSysvar);
	RESOLVE_FUNC(CallIntSysvar);
	RESOLVE_FUNC(PopInt);
	RESOLVE_FUNC(PopDouble);

	RESOLVE_FUNC(strlen);

	//RESOLVE_FUNC(log);
	//RESOLVE_FUNC(exp);
	//RESOLVE_FUNC(sqrt);
	//RESOLVE_FUNC(cos);
	//RESOLVE_FUNC(sin);
	if ("log" == name) return (double(*)(double))log;
	if ("exp" == name) return (double(*)(double))exp;
	if ("sqrt" == name) return (double(*)(double))sqrt;
	if ("cos" == name) return (double(*)(double))cos;
	if ("sin" == name) return (double(*)(double))sin;
	if ("tan" == name) return (double(*)(double))tan;
#undef LAZY_FUNC

	Alert(const_cast<char*>((name + " not foud").c_str()));
	return NULL;
}
