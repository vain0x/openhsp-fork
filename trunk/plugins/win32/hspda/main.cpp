
//
//		Easy Data Access Plugin for HSP
//				onion software/onitama 1999
//

#include <windows.h>
#include <stdio.h>

int WINAPI hspda_DllMain (HINSTANCE hInstance, DWORD fdwReason, PVOID pvReserved);

int WINAPI DllMain (HINSTANCE hInstance, DWORD fdwReason, PVOID pvReserved)
{
	return hspda_DllMain ( hInstance, fdwReason, pvReserved);
}


