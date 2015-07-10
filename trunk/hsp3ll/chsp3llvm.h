
//
//	CHsp3LLVM.cpp structures
//
#ifndef __CHsp3LLVM_h
#define __CHsp3LLVM_h

#include "chsp3op.h"

#define CPPHED_HSPVAR "Var_"

//		CHSP3 Task callback function
//
typedef void (* CHSP3_TASK) (void);

int MakeSource( CHsp3Op *hsp, int option, void *ref );


#endif
