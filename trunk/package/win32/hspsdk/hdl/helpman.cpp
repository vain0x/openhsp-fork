// helpman.exe
// for old-help call

#include <windows.h>

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, PSTR lpCmdLine, int nCmdShow)
{
	char cmd[1024] = "\"", msg[1024] = "HDL exec error\n\n";

	GetModuleFileName(NULL, cmd + 1, sizeof(cmd) - 1);
	strcat_s(cmd, sizeof(cmd), "\\..\\..\\hdl.exe\" ");
	strcat_s(cmd, sizeof(cmd), lpCmdLine);

	if(WinExec(cmd, 0) <= 31){
		strcat_s(msg, sizeof(msg), cmd);
		MessageBox(NULL, msg, "helpman.exe", MB_ICONERROR);
	}

	return 0;
}
