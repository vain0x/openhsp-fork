
//
//	struct.cpp header
//
#ifndef __struct_h
#define __struct_h

#include "hsp3struct.h"

STRUCT *new_struct( STRUCTDAT *module, void *members_buffer );
STRUCTPRM *get_struct_prm( STRUCT *obj );
STRUCTDAT *get_struct_dat( STRUCT *obj );
STRUCT_REF *add_struct_ref( STRUCT *obj );
void remove_struct_ref( STRUCT_REF *ref );
void struct_init( HSPCTX *ctx );
void struct_bye();

#endif
