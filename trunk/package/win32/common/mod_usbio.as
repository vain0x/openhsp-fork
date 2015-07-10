////////////////////////////////////////////////////////////////////////////////
//  mod_usbio  USB-IO制御モジュール for HSP ver0.4
//                               Copyright(C) 2007 K.Kawahira
//                               Modified 2010/7 onitama

#module
#define MAX_DEVS 32
#define NULL 0
#uselib "kernel32.dll"
#func CreateFile "CreateFileA" str,int,int,int,int,int,nullptr
#func WriteFile "WriteFile" int,var,int,var,int
#func ReadFile "ReadFile" int,var,int,var,int
#func CloseHandle "CloseHandle" int
#uselib "hid.dll"
#func HidD_GetAttributes "HidD_GetAttributes" int,var
#func HidD_GetHidGuid "HidD_GetHidGuid" var
#func HidD_GetPreparsedData "HidD_GetPreparsedData" int,var
#func HidP_GetCaps "HidP_GetCaps" int,var
#func HidD_FreePreparsedData "HidD_FreePreparsedData" int
#uselib "setupapi.dll"
#func SetupDiGetClassDevs "SetupDiGetClassDevsA" var,int,int,int
#func SetupDiEnumDeviceInterfaces "SetupDiEnumDeviceInterfaces" int,int,var,int,var
#func SetupDiDestroyDeviceInfoList "SetupDiDestroyDeviceInfoList" int
#func SetupDiGetDeviceInterfaceDetail "SetupDiGetDeviceInterfaceDetailA" int,var,int,int,var,int
/*
typedef struct _SP_DEVICE_INTERFACE_DATA {
    DWORD cbSize;
    GUID  InterfaceClassGuid;
    DWORD Flags;
    ULONG_PTR Reserved;
} SP_DEVICE_INTERFACE_DATA, *PSP_DEVICE_INTERFACE_DATA;
*/

// 見つかったディバイスの個数を返す
#deffunc uio_getdevs
	mref _stat,64
	_stat=devs
return

// n番目のディバイス選択
#deffunc uio_seldev int n
	if (n>=devs) :return
	if (hHID) {
		CloseHandle hHID
		hHID=NULL
	}

	CreateFile devpath(dev),0xC0000000,3,NULL,3,0
	if (stat==-1) : return
	hHID=stat

	dim hPreparsedData
	dim Caps,16
	HidD_GetPreparsedData hHID,hPreparsedData
	HidP_GetCaps hPreparsedData,Caps
	HidD_FreePreparsedData hPreparsedData

	InputByte=Caps(1)&0xffff
	OutputByte=Caps(1)>>16&0xffff
return

// ディバイスを検索して一覧作成
#deffunc uio_find
	sdim devpath,256,MAX_DEVS
	sdim path,256,MAX_DEVS
	dev=0
	devs=0

	sdim HidGuid,16
	dim devData,8

	devData(0) = 28 // cbSize

	dim DeviceAttributes,4
	DeviceAttributes(0)=10 // cbSize

	HidD_GetHidGuid HidGuid
	SetupDiGetClassDevs HidGuid,0,0,0x12
	DeviceInfoSet=stat
	dim Needed

	repeat
		SetupDiEnumDeviceInterfaces DeviceInfoSet,0,HidGuid,cnt,devData
		if stat==0 : break
		SetupDiGetDeviceInterfaceDetail DeviceInfoSet,devData,NULL,0,Needed,0
		size = Needed
		sdim DevDetail,Needed+4
		lpoke DevDetail,0,5
		//DevDetail(0)=5 // size
		SetupDiGetDeviceInterfaceDetail DeviceInfoSet,devData,varptr(DevDetail),size,Needed,0
		memcpy path,DevDetail,size,0,4
		;path=strmid(DevDetail,4,size)
		CreateFile path,0xC0000000,3,NULL,3,0
		hHID=stat
		HidD_GetAttributes hHID,DeviceAttributes
		vid=DeviceAttributes(1)&0xffff
		pid=DeviceAttributes(1)>>16&0xffff
		ver=DeviceAttributes(2)&0xffff

		;print path
		;print strlen(path)
		print "path="+DevDetail+"  vid="+vid+"  pid="+pid+" (v:"+ver+")"
		if ((vid==0x0BFE && pid==0x1003) || (vid==0x12ED && pid==0x1003) || (vid==0x1352 && pid==0x100)) {
			devpath(devs)=path
			devs++
			if (devs>=MAX_DEVS) : break
		}

		CloseHandle hHID
	loop
	SetupDiDestroyDeviceInfoList DeviceInfoSet
	hHID = NULL
	if (devs) {
		uio_seldev 0
	}
	mref _stat,64
	_stat=devs==0
return

// ポート出力
#deffunc uio_out int port,int value,int mode
	if (hHID==NULL) : uio_find
	mref _stat,64
	dim sz,1
	sdim dat,10
	poke dat,0,0
	poke dat,1,1+port
	poke dat,2,value
	if (mode) {
		poke dat,1,0x10+port
	}
	WriteFile hHID,dat,OutputByte,sz,NULL
	_stat=sz!=OutputByte
return


// ポートから入力
#deffunc uio_inp var v,int port,int mode
	if (hHID==NULL) : uio_find
	mref _stat,64
	dim sz,1
	cmdid=(cmdid+1)&255
	sdim dat,10
	poke dat,0,0
	poke dat,1,3+port
	poke dat,2,0
	poke dat,7,cmdid
	if (mode) {
		poke dat,1,0x14+port
	}
	WriteFile hHID,dat,OutputByte,sz,NULL
	if (stat==0) :_stat=1: return
	f=1
	repeat 100
		ReadFile hHID,dat,InputByte,sz,NULL
		if (stat==0) :_stat=1:return
		if (peek(dat,7)==cmdid) : v=peek(dat,2):f=0:break
	loop
	_stat=f
return

// 閉じる
#deffunc uio_free onexit
	if (hHID) {
		CloseHandle hHID
		hHID=NULL
	}
	devs=0
return
#global

