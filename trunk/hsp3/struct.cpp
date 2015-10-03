
//
//	struct.cpp
//

#include "hsp3code.h"
#include "struct.h"
#include "stack.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static STRUCT *freelist = NULL;

#define HEAPS_INCREMENT 10
typedef struct {
	STRUCT *slot;
	int limit;
} heap_slot;

static heap_slot *heaps = NULL;
static int heaps_used = 0;
static int heaps_length = 0;
static int during_gc;

#define HEAP_MIN_SLOTS 10000
static int heap_slots = HEAP_MIN_SLOTS;

#define MARK_STACK_MAX 1024
STRUCT *mark_stack[MARK_STACK_MAX];
STRUCT **mark_stack_ptr;
int mark_stack_overflow;

#define FREE_MIN 4096

static STRUCT_REF ref_first_guard;
static STRUCT_REF ref_last_guard;

static HSPCTX *hspctx;

static void add_heap()
{
	if ( heaps_used == heaps_length ) {
		heaps_length += HEAPS_INCREMENT;
		int length = sizeof(heap_slot) * heaps_length;
		if ( heaps_used > 0 ) {
			heaps = (heap_slot *)realloc( heaps, length );
		} else {
			heaps = (heap_slot *)malloc( length );
		}
	}
	STRUCT *p = (STRUCT *)malloc( sizeof(STRUCT) * heap_slots );
	STRUCT *pend = p + heap_slots;
	heaps[heaps_used].slot = p;
	heaps[heaps_used].limit = heap_slots;
	heaps_used++;
	heap_slots = (int)(heap_slots * 1.8);
	while ( p < pend ) {
		p->free.flags = 0;
		p->free.next = freelist;
		freelist = p;
		p++;
	}
}

static void garbage_collect();

STRUCT *new_struct( STRUCTDAT *module, void *members_buffer )
{
	if ( freelist == NULL ) {
		garbage_collect();
	}
	STRUCT *obj = freelist;
	freelist = freelist->free.next;
	obj->st.flags = STRUCT_FLAG_ALIVE;
	STRUCT_SET_MODULE( obj, module->prmindex );
	obj->st.members_buffer = members_buffer;
	return obj;
}

static void delete_struct( STRUCT *obj )
{
	code_delete_struct_members_buffer( get_struct_dat( obj ), obj->st.members_buffer );
	obj->free.flags = 0;
	obj->free.next = freelist;
	freelist = obj;
}

static void mark_parameters_buffer( STRUCTDAT *dat, char *ptr, int lev );

static void mark_obj_children( STRUCT *obj, int lev )
{
	mark_parameters_buffer( get_struct_dat(obj), (char *)GET_STRUCT_MEMBERS_BUFFER(obj), lev );
}

#define GC_LEVEL_MAX 250

static void mark_obj( STRUCT *obj, int lev )
{
	if ( obj == NULL ) return;
	if ( obj->st.flags & STRUCT_FLAG_MARK ) return;
	obj->st.flags |= STRUCT_FLAG_MARK;
	if ( lev > GC_LEVEL_MAX ) {
		if ( !mark_stack_overflow ) {
			if ( mark_stack_ptr - mark_stack < MARK_STACK_MAX ) {
				*mark_stack_ptr = obj;
				mark_stack_ptr++;
			} else {
				mark_stack_overflow = 1;
			}
		}
		return;
	}
	mark_obj_children( obj, lev + 1 );
}

static void mark_variable( PVal *pval, int lev )
{
	if ( pval->mode != HSPVAR_MODE_MALLOC ) return;
	if ( pval->flag != HSPVAR_FLAG_STRUCT ) return;
	STRUCT **p = (STRUCT **)pval->pt;
	STRUCT **pend = p + pval->size / sizeof(STRUCT *);
	while ( p < pend ) {
		mark_obj(*p, lev);
		p ++;
	}
}

static void mark_static_variables()
{
	PVal *p = hspctx->mem_var;
	PVal *pend = p + hspctx->hsphed->max_val;
	while ( p < pend ) {
		mark_variable(p, 0);
		p ++;
	}
}

static void mark_parameters_buffer( STRUCTDAT *dat, char *ptr, int lev )
{
	STRUCTPRM *p = &hspctx->mem_minfo[dat->prmindex];

	// どこまで引数のセットアップを終えているか（引数のセットアップが全て完了しているときは prmmax と同じ値）
	int argcnt = *(int *)(ptr + dat->size);

	STRUCTPRM *pend = p + argcnt;
	while ( p < pend ) {
		char *out = ptr + p->offset;
		switch ( p->mptype ) {
		case MPTYPE_SINGLEVAR:
		case MPTYPE_ARRAYVAR:
			{
			MPVarData *var = (MPVarData *)out;
			mark_variable(var->pval, lev);
			break;
			}
		case MPTYPE_MODULEVAR:
		case MPTYPE_IMODULEVAR:
		case MPTYPE_TMODULEVAR:
			{
			MPModVarData *var = (MPModVarData *)out;
			mark_obj(var->obj, lev);
			break;
			}
		case MPTYPE_LOCALVAR:
			mark_variable((PVal *)out, lev);
			break;
		case MPTYPE_STRUCT:
			mark_obj(*(STRUCT **)out, lev);
			break;
		}
		p ++;
	}
}

static void mark_hsp_stack()
{
	STMDATA *p = mem_stm;
	STMDATA *pend = p + stm_cur;
	while ( p < pend ) {
		switch( p->type ) {
		case HSPVAR_FLAG_STRUCT:
			mark_obj(*(STRUCT **)STM_GETPTR(p), 0);
			break;
		case TYPE_EX_CUSTOMFUNC:
			{
			HSPROUTINE *r = (HSPROUTINE *)STM_GETPTR(p);
			mark_parameters_buffer( r->param, (char *)(r+1), 0 );
			break;
			}
		}
		p ++;
	}
}

static void mark_references()
{
	STRUCT_REF *ref = ref_first_guard.next;
	STRUCT_REF *end = &ref_last_guard;
	while ( ref != end ) {
		mark_obj(ref->obj, 0);
		ref = ref->next;
	}
}

static void mark_root_objects()
{
	mark_static_variables();
	mark_hsp_stack();
	mark_references();
}

static void init_mark_stack()
{
	mark_stack_overflow = 0;
	mark_stack_ptr = mark_stack;
}

#define MARK_STACK_EMPTY (mark_stack_ptr == mark_stack)

static void mark_all()
{
    init_mark_stack();
	for ( int i = 0; i < heaps_used; i++ ) {
		STRUCT *p = heaps[i].slot;
		STRUCT *pend = p + heaps[i].limit;
		while ( p < pend ) {
		 	if ( p->st.flags & STRUCT_FLAG_MARK ) {
				mark_obj_children( p, 0 );
			}
			p++;
		}
	}
}

static void mark_rest()
{
	STRUCT *tmp_array[MARK_STACK_MAX];
	STRUCT **p;

	p = tmp_array + (mark_stack_ptr - mark_stack);
	memcpy( tmp_array, mark_stack, sizeof(STRUCT *) * (p - tmp_array) );

	init_mark_stack();
	while ( p != tmp_array ) {
		p--;
		mark_obj_children( *p, 0 );
	}
}

static void mark_not_comleted_objects()
{
	while ( !MARK_STACK_EMPTY ) {
		if ( mark_stack_overflow ) {
			mark_all();
		} else {
			mark_rest();
		}
	}
}

static void sweep()
{
	int freed = 0;
	int alive = 0;
	for ( int i = 0; i < heaps_used; i ++ ) {
		STRUCT *p = heaps[i].slot;
		STRUCT *pend = p + heaps[i].limit;
		for(; p < pend; p ++) {
			if ( !p->st.flags ) continue;
			if ( p->st.flags & STRUCT_FLAG_MARK ) {
				p->st.flags &= ~STRUCT_FLAG_MARK;
				alive ++;
			} else {
				delete_struct( p );
				freed ++;
			}
		}
	}
	//printf("garbage collected. alive=%d, freed=%d\n", alive, freed);
	if ( freed < FREE_MIN ) {
		add_heap();
	}
}

static void garbage_collect()
{
	if ( during_gc ) {
		if ( !freelist ) {
			add_heap();
		}
		return;
	}
	during_gc++;
	init_mark_stack();
	mark_root_objects();
	mark_not_comleted_objects();
	sweep();
	during_gc = 0;
}

STRUCT_REF *add_struct_ref( STRUCT *obj )
{
	STRUCT_REF *ref = (STRUCT_REF *)malloc( sizeof(STRUCT_REF) );
	STRUCT_REF *next = &ref_last_guard;
	STRUCT_REF *prev = ref_last_guard.prev;

	ref->obj = obj;
	ref->next = next;
	ref->prev = prev;

	prev->next = ref;
	next->prev = ref;

	return ref;
}

void remove_struct_ref( STRUCT_REF *ref )
{
	STRUCT_REF *next = ref->next;
	STRUCT_REF *prev = ref->prev;
	prev->next = next;
	next->prev = prev;
	free( ref );
}

STRUCTPRM *get_struct_prm( STRUCT *obj )
{
	return hspctx->mem_minfo + STRUCT_GET_MODULE( obj );
}

STRUCTDAT *get_struct_dat( STRUCT *obj )
{
	return hspctx->mem_finfo + get_struct_prm( obj )->subid;
}

void struct_init( HSPCTX *ctx )
{
	hspctx = ctx;
	ref_first_guard.next = &ref_last_guard;
	ref_last_guard.prev = &ref_first_guard;
}

void struct_bye()
{
	for ( int i = 0; i < heaps_used; i ++ ) {
		STRUCT *p = heaps[i].slot;
		STRUCT *pend = p + heaps[i].limit;
		while ( p < pend ) {
			if ( p->st.flags ) {
				delete_struct( p );
			}
			p ++;
		}
		free( heaps[i].slot );
	}
	free( heaps );

	STRUCT_REF *ref = ref_first_guard.next;
	STRUCT_REF *end = &ref_last_guard;
	while ( ref != end ) {
		STRUCT_REF *next = ref->next;
		free( ref );
		ref = next;
	}
	ref_first_guard.next = &ref_last_guard;
	ref_last_guard.prev = &ref_first_guard;

	heaps_used = heaps_length = 0;
	freelist = NULL;
	heaps = NULL;
}

