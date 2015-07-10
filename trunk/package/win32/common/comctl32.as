;(comctl32.as)
#ifdef __hsp30__
#ifndef __COMCTL32__
#define global __COMCTL32__
#uselib "COMCTL32.DLL"
	#func global CreateMappedBitmap "CreateMappedBitmap" sptr,sptr,sptr,sptr,sptr
	#func global CreatePropertySheetPage "CreatePropertySheetPage" sptr
	#func global CreatePropertySheetPageA "CreatePropertySheetPageA" sptr
	#func global CreatePropertySheetPageW "CreatePropertySheetPageW" wptr
	#func global CreateStatusWindow "CreateStatusWindow" sptr,sptr,sptr,sptr
	#func global CreateStatusWindowA "CreateStatusWindowA" sptr,sptr,sptr,sptr
	#func global CreateStatusWindowW "CreateStatusWindowW" wptr,wptr,wptr,wptr
	#func global CreateToolbar "CreateToolbar" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global CreateToolbarEx "CreateToolbarEx" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global CreateUpDownControl "CreateUpDownControl" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global DestroyPropertySheetPage "DestroyPropertySheetPage" sptr
	#func global DrawInsert "DrawInsert" sptr,sptr,sptr
	#func global DrawStatusText "DrawStatusText" sptr,sptr,sptr,sptr
	#func global DrawStatusTextA "DrawStatusTextA" sptr,sptr,sptr,sptr
	#func global DrawStatusTextW "DrawStatusTextW" wptr,wptr,wptr,wptr
	#func global FlatSB_EnableScrollBar "FlatSB_EnableScrollBar" sptr,sptr,sptr
	#func global FlatSB_GetScrollInfo "FlatSB_GetScrollInfo" sptr,sptr,sptr
	#func global FlatSB_GetScrollPos "FlatSB_GetScrollPos" sptr,sptr
	#func global FlatSB_GetScrollProp "FlatSB_GetScrollProp" sptr,sptr,sptr
	#func global FlatSB_GetScrollRange "FlatSB_GetScrollRange" sptr,sptr,sptr,sptr
	#func global FlatSB_SetScrollInfo "FlatSB_SetScrollInfo" sptr,sptr,sptr,sptr
	#func global FlatSB_SetScrollPos "FlatSB_SetScrollPos" sptr,sptr,sptr,sptr
	#func global FlatSB_SetScrollProp "FlatSB_SetScrollProp" sptr,sptr,sptr,sptr
	#func global FlatSB_SetScrollRange "FlatSB_SetScrollRange" sptr,sptr,sptr,sptr,sptr
	#func global FlatSB_ShowScrollBar "FlatSB_ShowScrollBar" sptr,sptr,sptr
	#func global GetEffectiveClientRect "GetEffectiveClientRect" sptr,sptr,sptr
	#func global ImageList_Add "ImageList_Add" sptr,sptr,sptr
	#func global ImageList_AddIcon "ImageList_AddIcon" sptr,sptr
	#func global ImageList_AddMasked "ImageList_AddMasked" sptr,sptr,sptr
	#func global ImageList_BeginDrag "ImageList_BeginDrag" sptr,sptr,sptr,sptr
	#func global ImageList_Copy "ImageList_Copy" sptr,sptr,sptr,sptr,sptr
	#func global ImageList_Create "ImageList_Create" sptr,sptr,sptr,sptr,sptr
	#func global ImageList_Destroy "ImageList_Destroy" sptr
	#func global ImageList_DragEnter "ImageList_DragEnter" sptr,sptr,sptr
	#func global ImageList_DragLeave "ImageList_DragLeave" sptr
	#func global ImageList_DragMove "ImageList_DragMove" sptr,sptr
	#func global ImageList_DragShowNolock "ImageList_DragShowNolock" sptr
	#func global ImageList_Draw "ImageList_Draw" sptr,sptr,sptr,sptr,sptr,sptr
	#func global ImageList_DrawEx "ImageList_DrawEx" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global ImageList_DrawIndirect "ImageList_DrawIndirect" sptr
	#func global ImageList_Duplicate "ImageList_Duplicate" sptr
	#func global ImageList_EndDrag "ImageList_EndDrag"
	#func global ImageList_GetBkColor "ImageList_GetBkColor" sptr
	#func global ImageList_GetDragImage "ImageList_GetDragImage" sptr,sptr
	#func global ImageList_GetIcon "ImageList_GetIcon" sptr,sptr,sptr
	#func global ImageList_GetIconSize "ImageList_GetIconSize" sptr,sptr,sptr
	#func global ImageList_GetImageCount "ImageList_GetImageCount" sptr
	#func global ImageList_GetImageInfo "ImageList_GetImageInfo" sptr,sptr,sptr
	#func global ImageList_GetImageRect "ImageList_GetImageRect" sptr,sptr,sptr
	#func global ImageList_LoadImage "ImageList_LoadImage" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global ImageList_LoadImageA "ImageList_LoadImageA" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global ImageList_LoadImageW "ImageList_LoadImageW" wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global ImageList_Merge "ImageList_Merge" sptr,sptr,sptr,sptr,sptr,sptr
	#func global ImageList_Read "ImageList_Read" sptr
	#func global ImageList_Remove "ImageList_Remove" sptr,sptr
	#func global ImageList_Replace "ImageList_Replace" sptr,sptr,sptr,sptr
	#func global ImageList_ReplaceIcon "ImageList_ReplaceIcon" sptr,sptr,sptr
	#func global ImageList_SetBkColor "ImageList_SetBkColor" sptr,sptr
	#func global ImageList_SetDragCursorImage "ImageList_SetDragCursorImage" sptr,sptr,sptr,sptr
	#func global ImageList_SetFilter "ImageList_SetFilter" sptr,sptr,sptr
	#func global ImageList_SetIconSize "ImageList_SetIconSize" sptr,sptr,sptr
	#func global ImageList_SetImageCount "ImageList_SetImageCount" sptr,sptr
	#func global ImageList_SetOverlayImage "ImageList_SetOverlayImage" sptr,sptr,sptr
	#func global ImageList_Write "ImageList_Write" sptr,sptr
	#func global InitCommonControls "InitCommonControls"
	#func global InitCommonControlsEx "InitCommonControlsEx" sptr
	#func global InitializeFlatSB "InitializeFlatSB" sptr
	#func global LBItemFromPt "LBItemFromPt" sptr,sptr,sptr,sptr
	#func global MakeDragList "MakeDragList" sptr
	#func global MenuHelp "MenuHelp" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global PropertySheet "PropertySheet" sptr
	#func global PropertySheetA "PropertySheetA" sptr
	#func global PropertySheetW "PropertySheetW" wptr
	#func global ShowHideMenuCtl "ShowHideMenuCtl" sptr,sptr,sptr
	#func global _TrackMouseEvent "TrackMouseEvent" sptr
	#func global UninitializeFlatSB "UninitializeFlatSB" sptr
#endif
#endif
