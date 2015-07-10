;(winmm.as)
#ifdef __hsp30__
#ifndef __WINMM__
#define global __WINMM__
#uselib "WINMM.DLL"
	#func global CloseDriver "CloseDriver" sptr,sptr,sptr
	#func global DefDriverProc "DefDriverProc" sptr,sptr,sptr,sptr,sptr
	#func global DriverCallback "DriverCallback" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global DrvGetModuleHandle "DrvGetModuleHandle" sptr
	#func global GetDriverModuleHandle "GetDriverModuleHandle" sptr
	#func global MigrateAllDrivers "MigrateAllDrivers"
	#func global MigrateMidiUser "MigrateMidiUser"
	#func global MigrateSoundEvents "MigrateSoundEvents"
	#func global NotifyCallbackData "NotifyCallbackData" sptr,sptr,sptr,sptr,sptr
	#func global OpenDriver "OpenDriver" sptr,sptr,sptr
	#func global PlaySound "PlaySound" sptr,sptr,sptr
	#func global PlaySoundA "PlaySoundA" sptr,sptr,sptr
	#func global PlaySoundW "PlaySoundW" wptr,wptr,wptr
	#func global SendDriverMessage "SendDriverMessage" sptr,sptr,sptr,sptr
	#func global WOW32DriverCallback "WOW32DriverCallback" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global WOW32ResolveMultiMediaHandle "WOW32ResolveMultiMediaHandle" sptr,sptr,sptr,sptr,sptr,sptr
	#func global WOWAppExit "WOWAppExit" sptr
	#func global aux32Message "aux32Message" sptr,sptr,sptr,sptr,sptr
	#define global auxGetDevCaps auxGetDevCapsA
	#func global auxGetDevCapsA "auxGetDevCapsA" sptr,sptr,sptr
	#func global auxGetDevCapsW "auxGetDevCapsW" wptr,wptr,wptr
	#func global auxGetNumDevs "auxGetNumDevs"
	#func global auxGetVolume "auxGetVolume" sptr,sptr
	#func global auxOutMessage "auxOutMessage" sptr,sptr,sptr,sptr
	#func global auxSetVolume "auxSetVolume" sptr,sptr
	#func global joy32Message "joy32Message" sptr,sptr,sptr,sptr,sptr
	#func global joyConfigChanged "joyConfigChanged" sptr
	#define global joyGetDevCaps joyGetDevCapsA
	#func global joyGetDevCapsA "joyGetDevCapsA" sptr,sptr,sptr
	#func global joyGetDevCapsW "joyGetDevCapsW" wptr,wptr,wptr
	#func global joyGetNumDevs "joyGetNumDevs"
	#func global joyGetPos "joyGetPos" sptr,sptr
	#func global joyGetPosEx "joyGetPosEx" sptr,sptr
	#func global joyGetThreshold "joyGetThreshold" sptr,sptr
	#func global joyReleaseCapture "joyReleaseCapture" sptr
	#func global joySetCapture "joySetCapture" sptr,sptr,sptr,sptr
	#func global joySetThreshold "joySetThreshold" sptr,sptr
	#func global mci32Message "mci32Message" sptr,sptr,sptr,sptr,sptr
	#func global mciDriverNotify "mciDriverNotify" sptr,sptr,sptr
	#func global mciDriverYield "mciDriverYield" sptr
	#func global mciExecute "mciExecute" sptr
	#func global mciFreeCommandResource "mciFreeCommandResource" sptr
	#func global mciGetCreatorTask "mciGetCreatorTask" sptr
	#define global mciGetDeviceID mciGetDeviceIDA
	#func global mciGetDeviceIDA "mciGetDeviceIDA" sptr
	#define global mciGetDeviceIDFromElementID mciGetDeviceIDFromElementIDA
	#func global mciGetDeviceIDFromElementIDA "mciGetDeviceIDFromElementIDA" sptr,sptr
	#func global mciGetDeviceIDFromElementIDW "mciGetDeviceIDFromElementIDW" wptr,wptr
	#func global mciGetDeviceIDW "mciGetDeviceIDW" wptr
	#func global mciGetDriverData "mciGetDriverData" sptr
	#define global mciGetErrorString mciGetErrorStringA
	#func global mciGetErrorStringA "mciGetErrorStringA" sptr,sptr,sptr
	#func global mciGetErrorStringW "mciGetErrorStringW" wptr,wptr,wptr
	#func global mciGetYieldProc "mciGetYieldProc" sptr,sptr
	#func global mciLoadCommandResource "mciLoadCommandResource" sptr,sptr,sptr
	#define global mciSendCommand mciSendCommandA
	#func global mciSendCommandA "mciSendCommandA" sptr,sptr,sptr,sptr
	#func global mciSendCommandW "mciSendCommandW" wptr,wptr,wptr,wptr
	#define global mciSendString mciSendStringA
	#func global mciSendStringA "mciSendStringA" sptr,sptr,sptr,sptr
	#func global mciSendStringW "mciSendStringW" wptr,wptr,wptr,wptr
	#func global mciSetDriverData "mciSetDriverData" sptr,sptr
	#func global mciSetYieldProc "mciSetYieldProc" sptr,sptr,sptr
	#func global mid32Message "mid32Message" sptr,sptr,sptr,sptr,sptr
	#func global midiConnect "midiConnect" sptr,sptr,sptr
	#func global midiDisconnect "midiDisconnect" sptr,sptr,sptr
	#func global midiInAddBuffer "midiInAddBuffer" sptr,sptr,sptr
	#func global midiInClose "midiInClose" sptr
	#define global midiInGetDevCaps midiInGetDevCapsA
	#func global midiInGetDevCapsA "midiInGetDevCapsA" sptr,sptr,sptr
	#func global midiInGetDevCapsW "midiInGetDevCapsW" wptr,wptr,wptr
	#define global midiInGetErrorText midiInGetErrorTextA
	#func global midiInGetErrorTextA "midiInGetErrorTextA" sptr,sptr,sptr
	#func global midiInGetErrorTextW "midiInGetErrorTextW" wptr,wptr,wptr
	#func global midiInGetID "midiInGetID" sptr,sptr
	#func global midiInGetNumDevs "midiInGetNumDevs"
	#func global midiInMessage "midiInMessage" sptr,sptr,sptr,sptr
	#func global midiInOpen "midiInOpen" sptr,sptr,sptr,sptr,sptr
	#func global midiInPrepareHeader "midiInPrepareHeader" sptr,sptr,sptr
	#func global midiInReset "midiInReset" sptr
	#func global midiInStart "midiInStart" sptr
	#func global midiInStop "midiInStop" sptr
	#func global midiInUnprepareHeader "midiInUnprepareHeader" sptr,sptr,sptr
	#func global midiOutCacheDrumPatches "midiOutCacheDrumPatches" sptr,sptr,sptr,sptr
	#func global midiOutCachePatches "midiOutCachePatches" sptr,sptr,sptr,sptr
	#func global midiOutClose "midiOutClose" sptr
	#define global midiOutGetDevCaps midiOutGetDevCapsA
	#func global midiOutGetDevCapsA "midiOutGetDevCapsA" sptr,sptr,sptr
	#func global midiOutGetDevCapsW "midiOutGetDevCapsW" wptr,wptr,wptr
	#define global midiOutGetErrorText midiOutGetErrorTextA
	#func global midiOutGetErrorTextA "midiOutGetErrorTextA" sptr,sptr,sptr
	#func global midiOutGetErrorTextW "midiOutGetErrorTextW" wptr,wptr,wptr
	#func global midiOutGetID "midiOutGetID" sptr,sptr
	#func global midiOutGetNumDevs "midiOutGetNumDevs"
	#func global midiOutGetVolume "midiOutGetVolume" sptr,sptr
	#func global midiOutLongMsg "midiOutLongMsg" sptr,sptr,sptr
	#func global midiOutMessage "midiOutMessage" sptr,sptr,sptr,sptr
	#func global midiOutOpen "midiOutOpen" sptr,sptr,sptr,sptr,sptr
	#func global midiOutPrepareHeader "midiOutPrepareHeader" sptr,sptr,sptr
	#func global midiOutReset "midiOutReset" sptr
	#func global midiOutSetVolume "midiOutSetVolume" sptr,sptr
	#func global midiOutShortMsg "midiOutShortMsg" sptr,sptr
	#func global midiOutUnprepareHeader "midiOutUnprepareHeader" sptr,sptr,sptr
	#func global midiStreamClose "midiStreamClose" sptr
	#func global midiStreamOpen "midiStreamOpen" sptr,sptr,sptr,sptr,sptr,sptr
	#func global midiStreamOut "midiStreamOut" sptr,sptr,sptr
	#func global midiStreamPause "midiStreamPause" sptr
	#func global midiStreamPosition "midiStreamPosition" sptr,sptr,sptr
	#func global midiStreamProperty "midiStreamProperty" sptr,sptr,sptr
	#func global midiStreamRestart "midiStreamRestart" sptr
	#func global midiStreamStop "midiStreamStop" sptr
	#func global mixerClose "mixerClose" sptr
	#define global mixerGetControlDetails mixerGetControlDetailsA
	#func global mixerGetControlDetailsA "mixerGetControlDetailsA" sptr,sptr,sptr
	#func global mixerGetControlDetailsW "mixerGetControlDetailsW" wptr,wptr,wptr
	#define global mixerGetDevCaps mixerGetDevCapsA
	#func global mixerGetDevCapsA "mixerGetDevCapsA" sptr,sptr,sptr
	#func global mixerGetDevCapsW "mixerGetDevCapsW" wptr,wptr,wptr
	#func global mixerGetID "mixerGetID" sptr,sptr,sptr
	#define global mixerGetLineControls mixerGetLineControlsA
	#func global mixerGetLineControlsA "mixerGetLineControlsA" sptr,sptr,sptr
	#func global mixerGetLineControlsW "mixerGetLineControlsW" wptr,wptr,wptr
	#define global mixerGetLineInfo mixerGetLineInfoA
	#func global mixerGetLineInfoA "mixerGetLineInfoA" sptr,sptr,sptr
	#func global mixerGetLineInfoW "mixerGetLineInfoW" wptr,wptr,wptr
	#func global mixerGetNumDevs "mixerGetNumDevs"
	#func global mixerMessage "mixerMessage" sptr,sptr,sptr,sptr
	#func global mixerOpen "mixerOpen" sptr,sptr,sptr,sptr,sptr
	#func global mixerSetControlDetails "mixerSetControlDetails" sptr,sptr,sptr
	#func global mmDrvInstall "mmDrvInstall" sptr,sptr,sptr,sptr
	#func global mmGetCurrentTask "mmGetCurrentTask"
	#func global mmTaskBlock "mmTaskBlock" sptr
	#func global mmTaskCreate "mmTaskCreate" sptr,sptr,sptr
	#func global mmTaskSignal "mmTaskSignal" sptr
	#func global mmTaskYield "mmTaskYield"
	#func global mmioAdvance "mmioAdvance" sptr,sptr,sptr
	#func global mmioAscend "mmioAscend" sptr,sptr,sptr
	#func global mmioClose "mmioClose" sptr,sptr
	#func global mmioCreateChunk "mmioCreateChunk" sptr,sptr,sptr
	#func global mmioDescend "mmioDescend" sptr,sptr,sptr,sptr
	#func global mmioFlush "mmioFlush" sptr,sptr
	#func global mmioGetInfo "mmioGetInfo" sptr,sptr,sptr
	#define global mmioInstallIOProc mmioInstallIOProcA
	#func global mmioInstallIOProcA "mmioInstallIOProcA" sptr,sptr,sptr
	#func global mmioInstallIOProcW "mmioInstallIOProcW" wptr,wptr,wptr
	#define global mmioOpen mmioOpenA
	#func global mmioOpenA "mmioOpenA" sptr,sptr,sptr
	#func global mmioOpenW "mmioOpenW" wptr,wptr,wptr
	#func global mmioRead "mmioRead" sptr,sptr,sptr
	#define global mmioRename mmioRenameA
	#func global mmioRenameA "mmioRenameA" sptr,sptr,sptr,sptr
	#func global mmioRenameW "mmioRenameW" wptr,wptr,wptr,wptr
	#func global mmioSeek "mmioSeek" sptr,sptr,sptr
	#func global mmioSendMessage "mmioSendMessage" sptr,sptr,sptr,sptr
	#func global mmioSetBuffer "mmioSetBuffer" sptr,sptr,sptr,sptr
	#func global mmioSetInfo "mmioSetInfo" sptr,sptr,sptr
	#define global mmioStringToFOURCC mmioStringToFOURCCA
	#func global mmioStringToFOURCCA "mmioStringToFOURCCA" sptr,sptr
	#func global mmioStringToFOURCCW "mmioStringToFOURCCW" wptr,wptr
	#func global mmioWrite "mmioWrite" sptr,sptr,sptr
	#func global mmsystemGetVersion "mmsystemGetVersion"
	#func global mod32Message "mod32Message" sptr,sptr,sptr,sptr,sptr
	#func global mxd32Message "mxd32Message" sptr,sptr,sptr,sptr,sptr
	#define global sndPlaySound sndPlaySoundA
	#func global sndPlaySoundA "sndPlaySoundA" sptr,sptr
	#func global sndPlaySoundW "sndPlaySoundW" wptr,wptr
	#func global tid32Message "tid32Message" sptr,sptr,sptr,sptr,sptr
	#func global timeBeginPeriod "timeBeginPeriod" sptr
	#func global timeEndPeriod "timeEndPeriod" sptr
	#func global timeGetDevCaps "timeGetDevCaps" sptr,sptr
	#func global timeGetSystemTime "timeGetSystemTime" sptr,sptr
	#func global timeGetTime "timeGetTime"
	#func global timeKillEvent "timeKillEvent" sptr
	#func global timeSetEvent "timeSetEvent" sptr,sptr,sptr,sptr,sptr
	#func global waveInAddBuffer "waveInAddBuffer" sptr,sptr,sptr
	#func global waveInClose "waveInClose" sptr
	#define global waveInGetDevCaps waveInGetDevCapsA
	#func global waveInGetDevCapsA "waveInGetDevCapsA" sptr,sptr,sptr
	#func global waveInGetDevCapsW "waveInGetDevCapsW" wptr,wptr,wptr
	#define global waveInGetErrorText waveInGetErrorTextA
	#func global waveInGetErrorTextA "waveInGetErrorTextA" sptr,sptr,sptr
	#func global waveInGetErrorTextW "waveInGetErrorTextW" wptr,wptr,wptr
	#func global waveInGetID "waveInGetID" sptr,sptr
	#func global waveInGetNumDevs "waveInGetNumDevs"
	#func global waveInGetPosition "waveInGetPosition" sptr,sptr,sptr
	#func global waveInMessage "waveInMessage" sptr,sptr,sptr,sptr
	#func global waveInOpen "waveInOpen" sptr,sptr,sptr,sptr,sptr,sptr
	#func global waveInPrepareHeader "waveInPrepareHeader" sptr,sptr,sptr
	#func global waveInReset "waveInReset" sptr
	#func global waveInStart "waveInStart" sptr
	#func global waveInStop "waveInStop" sptr
	#func global waveInUnprepareHeader "waveInUnprepareHeader" sptr,sptr,sptr
	#func global waveOutBreakLoop "waveOutBreakLoop" sptr
	#func global waveOutClose "waveOutClose" sptr
	#define global waveOutGetDevCaps waveOutGetDevCapsA
	#func global waveOutGetDevCapsA "waveOutGetDevCapsA" sptr,sptr,sptr
	#func global waveOutGetDevCapsW "waveOutGetDevCapsW" wptr,wptr,wptr
	#define global waveOutGetErrorText waveOutGetErrorTextA
	#func global waveOutGetErrorTextA "waveOutGetErrorTextA" sptr,sptr,sptr
	#func global waveOutGetErrorTextW "waveOutGetErrorTextW" wptr,wptr,wptr
	#func global waveOutGetID "waveOutGetID" sptr,sptr
	#func global waveOutGetNumDevs "waveOutGetNumDevs"
	#func global waveOutGetPitch "waveOutGetPitch" sptr,sptr
	#func global waveOutGetPlaybackRate "waveOutGetPlaybackRate" sptr,sptr
	#func global waveOutGetPosition "waveOutGetPosition" sptr,sptr,sptr
	#func global waveOutGetVolume "waveOutGetVolume" sptr,sptr
	#func global waveOutMessage "waveOutMessage" sptr,sptr,sptr,sptr
	#func global waveOutOpen "waveOutOpen" sptr,sptr,sptr,sptr,sptr,sptr
	#func global waveOutPause "waveOutPause" sptr
	#func global waveOutPrepareHeader "waveOutPrepareHeader" sptr,sptr,sptr
	#func global waveOutReset "waveOutReset" sptr
	#func global waveOutRestart "waveOutRestart" sptr
	#func global waveOutSetPitch "waveOutSetPitch" sptr,sptr
	#func global waveOutSetPlaybackRate "waveOutSetPlaybackRate" sptr,sptr
	#func global waveOutSetVolume "waveOutSetVolume" sptr,sptr
	#func global waveOutUnprepareHeader "waveOutUnprepareHeader" sptr,sptr,sptr
	#func global waveOutWrite "waveOutWrite" sptr,sptr,sptr
	#func global wid32Message "wid32Message" sptr,sptr,sptr,sptr,sptr
	#func global winmmDbgOut "winmmDbgOut" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global winmmSetDebugLevel "winmmSetDebugLevel" sptr
	#func global wod32Message "wod32Message" sptr,sptr,sptr,sptr,sptr
#endif
#endif
