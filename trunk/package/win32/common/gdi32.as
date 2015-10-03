;(gdi32.as)
#ifdef __hsp30__
#ifndef __GDI32__
#define global __GDI32__
#uselib "GDI32.DLL"
	#func global AbortDoc "AbortDoc" sptr
	#func global AbortPath "AbortPath" sptr
	#func global AddFontMemResourceEx "AddFontMemResourceEx" sptr,sptr,sptr,sptr
	#define global AddFontResource AddFontResourceA
	#func global AddFontResourceA "AddFontResourceA" sptr
	#define global AddFontResourceEx AddFontResourceExA
	#func global AddFontResourceExA "AddFontResourceExA" sptr,sptr,sptr
	#func global AddFontResourceExW "AddFontResourceExW" wptr,wptr,wptr
	#func global AddFontResourceW "AddFontResourceW" wptr
	#func global AngleArc "AngleArc" sptr,sptr,sptr,sptr,float,float

	#func global AnimatePalette "AnimatePalette" sptr,sptr,sptr,sptr
	#func global Arc "Arc" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global ArcTo "ArcTo" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global BeginPath "BeginPath" sptr
	#func global BitBlt "BitBlt" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global CancelDC "CancelDC" sptr
	#func global CheckColorsInGamut "CheckColorsInGamut" sptr,sptr,sptr,sptr
	#func global ChoosePixelFormat "ChoosePixelFormat" sptr,sptr
	#func global Chord "Chord" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global CloseEnhMetaFile "CloseEnhMetaFile" sptr
	#func global CloseFigure "CloseFigure" sptr
	#func global CloseMetaFile "CloseMetaFile" sptr
	#func global ColorCorrectPalette "ColorCorrectPalette" sptr,sptr,sptr,sptr
	#func global ColorMatchToTarget "ColorMatchToTarget" sptr,sptr,sptr
	#func global CombineRgn "CombineRgn" sptr,sptr,sptr,sptr
	#func global CombineTransform "CombineTransform" sptr,sptr,sptr
	#define global CopyEnhMetaFile CopyEnhMetaFileA
	#func global CopyEnhMetaFileA "CopyEnhMetaFileA" sptr,sptr
	#func global CopyEnhMetaFileW "CopyEnhMetaFileW" wptr,wptr
	#define global CopyMetaFile CopyMetaFileA
	#func global CopyMetaFileA "CopyMetaFileA" sptr,sptr
	#func global CopyMetaFileW "CopyMetaFileW" wptr,wptr
	#func global CreateBitmap "CreateBitmap" sptr,sptr,sptr,sptr,sptr
	#func global CreateBitmapIndirect "CreateBitmapIndirect" sptr
	#func global CreateBrushIndirect "CreateBrushIndirect" sptr
	#define global CreateColorSpace CreateColorSpaceA
	#func global CreateColorSpaceA "CreateColorSpaceA" sptr
	#func global CreateColorSpaceW "CreateColorSpaceW" wptr
	#func global CreateCompatibleBitmap "CreateCompatibleBitmap" sptr,sptr,sptr
	#func global CreateCompatibleDC "CreateCompatibleDC" sptr
	#define global CreateDC CreateDCA
	#func global CreateDCA "CreateDCA" sptr,sptr,sptr,sptr
	#func global CreateDCW "CreateDCW" wptr,wptr,wptr,wptr
	#func global CreateDIBPatternBrush "CreateDIBPatternBrush" sptr,sptr
	#func global CreateDIBPatternBrushPt "CreateDIBPatternBrushPt" sptr,sptr
	#func global CreateDIBSection "CreateDIBSection" sptr,sptr,sptr,sptr,sptr,sptr
	#func global CreateDIBitmap "CreateDIBitmap" sptr,sptr,sptr,sptr,sptr,sptr
	#func global CreateDiscardableBitmap "CreateDiscardableBitmap" sptr,sptr,sptr
	#func global CreateEllipticRgn "CreateEllipticRgn" sptr,sptr,sptr,sptr
	#func global CreateEllipticRgnIndirect "CreateEllipticRgnIndirect" sptr
	#define global CreateEnhMetaFile CreateEnhMetaFileA
	#func global CreateEnhMetaFileA "CreateEnhMetaFileA" sptr,sptr,sptr,sptr
	#func global CreateEnhMetaFileW "CreateEnhMetaFileW" wptr,wptr,wptr,wptr
	#define global CreateFont CreateFontA
	#func global CreateFontA "CreateFontA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#define global CreateFontIndirect CreateFontIndirectA
	#func global CreateFontIndirectA "CreateFontIndirectA" sptr
	#define global CreateFontIndirectEx CreateFontIndirectExA
	#func global CreateFontIndirectExA "CreateFontIndirectExA" sptr
	#func global CreateFontIndirectExW "CreateFontIndirectExW" wptr
	#func global CreateFontIndirectW "CreateFontIndirectW" wptr
	#func global CreateFontW "CreateFontW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global CreateHalftonePalette "CreateHalftonePalette" sptr
	#func global CreateHatchBrush "CreateHatchBrush" sptr,sptr
	#define global CreateIC CreateICA
	#func global CreateICA "CreateICA" sptr,sptr,sptr,sptr
	#func global CreateICW "CreateICW" wptr,wptr,wptr,wptr
	#define global CreateMetaFile CreateMetaFileA
	#func global CreateMetaFileA "CreateMetaFileA" sptr
	#func global CreateMetaFileW "CreateMetaFileW" wptr
	#func global CreatePalette "CreatePalette" sptr
	#func global CreatePatternBrush "CreatePatternBrush" sptr
	#func global CreatePen "CreatePen" sptr,sptr,sptr
	#func global CreatePenIndirect "CreatePenIndirect" sptr
	#func global CreatePolyPolygonRgn "CreatePolyPolygonRgn" sptr,sptr,sptr,sptr
	#func global CreatePolygonRgn "CreatePolygonRgn" sptr,sptr,sptr
	#func global CreateRectRgn "CreateRectRgn" sptr,sptr,sptr,sptr
	#func global CreateRectRgnIndirect "CreateRectRgnIndirect" sptr
	#func global CreateRoundRectRgn "CreateRoundRectRgn" sptr,sptr,sptr,sptr,sptr,sptr
	#define global CreateScalableFontResource CreateScalableFontResourceA
	#func global CreateScalableFontResourceA "CreateScalableFontResourceA" sptr,sptr,sptr,sptr
	#func global CreateScalableFontResourceW "CreateScalableFontResourceW" wptr,wptr,wptr,wptr
	#func global CreateSolidBrush "CreateSolidBrush" sptr
	#func global DPtoLP "DPtoLP" sptr,sptr,sptr
	#func global DeleteColorSpace "DeleteColorSpace" sptr
	#func global DeleteDC "DeleteDC" sptr
	#func global DeleteEnhMetaFile "DeleteEnhMetaFile" sptr
	#func global DeleteMetaFile "DeleteMetaFile" sptr
	#func global DeleteObject "DeleteObject" sptr
	#func global DescribePixelFormat "DescribePixelFormat" sptr,sptr,sptr,sptr
	#define global DeviceCapabilitiesEx DeviceCapabilitiesExA
	#func global DeviceCapabilitiesExA "DeviceCapabilitiesExA" sptr,sptr,sptr,sptr,sptr,sptr
	#func global DeviceCapabilitiesExW "DeviceCapabilitiesExW" wptr,wptr,wptr,wptr,wptr,wptr
	#func global DrawEscape "DrawEscape" sptr,sptr,sptr,sptr
	#func global Ellipse "Ellipse" sptr,sptr,sptr,sptr,sptr
	#func global EnableEUDC "EnableEUDC" sptr
	#func global EndDoc "EndDoc" sptr
	#func global EndFormPage "EndFormPage" sptr
	#func global EndPage "EndPage" sptr
	#func global EndPath "EndPath" sptr
	#func global EnumEnhMetaFile "EnumEnhMetaFile" sptr,sptr,sptr,sptr,sptr
	#define global EnumFontFamilies EnumFontFamiliesA
	#func global EnumFontFamiliesA "EnumFontFamiliesA" sptr,sptr,sptr,sptr
	#define global EnumFontFamiliesEx EnumFontFamiliesExA
	#func global EnumFontFamiliesExA "EnumFontFamiliesExA" sptr,sptr,sptr,sptr,sptr
	#func global EnumFontFamiliesExW "EnumFontFamiliesExW" wptr,wptr,wptr,wptr,wptr
	#func global EnumFontFamiliesW "EnumFontFamiliesW" wptr,wptr,wptr,wptr
	#define global EnumFonts EnumFontsA
	#func global EnumFontsA "EnumFontsA" sptr,sptr,sptr,sptr
	#func global EnumFontsW "EnumFontsW" wptr,wptr,wptr,wptr
	#define global EnumICMProfiles EnumICMProfilesA
	#func global EnumICMProfilesA "EnumICMProfilesA" sptr,sptr,sptr
	#func global EnumICMProfilesW "EnumICMProfilesW" wptr,wptr,wptr
	#func global EnumMetaFile "EnumMetaFile" sptr,sptr,sptr,sptr
	#func global EnumObjects "EnumObjects" sptr,sptr,sptr,sptr
	#func global EqualRgn "EqualRgn" sptr,sptr
	#func global Escape "Escape" sptr,sptr,sptr,sptr,sptr
	#func global EudcLoadLinkW "EudcLoadLinkW" wptr,wptr,wptr,wptr
	#func global EudcUnloadLinkW "EudcUnloadLinkW" wptr,wptr
	#func global ExcludeClipRect "ExcludeClipRect" sptr,sptr,sptr,sptr,sptr
	#func global ExtCreatePen "ExtCreatePen" sptr,sptr,sptr,sptr,sptr
	#func global ExtCreateRegion "ExtCreateRegion" sptr,sptr,sptr
	#func global ExtEscape "ExtEscape" sptr,sptr,sptr,sptr,sptr,sptr
	#func global ExtFloodFill "ExtFloodFill" sptr,sptr,sptr,sptr,sptr
	#func global ExtSelectClipRgn "ExtSelectClipRgn" sptr,sptr,sptr
	#define global ExtTextOut ExtTextOutA
	#func global ExtTextOutA "ExtTextOutA" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global ExtTextOutW "ExtTextOutW" wptr,wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global FillPath "FillPath" sptr
	#func global FillRgn "FillRgn" sptr,sptr,sptr
	#func global FixBrushOrgEx "FixBrushOrgEx" sptr,sptr,sptr,sptr
	#func global FlattenPath "FlattenPath" sptr
	#func global FloodFill "FloodFill" sptr,sptr,sptr,sptr
	#func global FrameRgn "FrameRgn" sptr,sptr,sptr,sptr,sptr
	#func global GdiArtificialDecrementDriver "GdiArtificialDecrementDriver" sptr,sptr
	#func global GdiComment "GdiComment" sptr,sptr,sptr
	#func global GdiDeleteSpoolFileHandle "GdiDeleteSpoolFileHandle" sptr
	#func global GdiEndDocEMF "GdiEndDocEMF" sptr
	#func global GdiEndPageEMF "GdiEndPageEMF" sptr,sptr
	#func global GdiFlush "GdiFlush"
	#func global GdiGetBatchLimit "GdiGetBatchLimit"
	#func global GdiGetDC "GdiGetDC" sptr
	#func global GdiGetDevmodeForPage "GdiGetDevmodeForPage" sptr,sptr,sptr,sptr
	#func global GdiGetPageCount "GdiGetPageCount" sptr
	#func global GdiGetPageHandle "GdiGetPageHandle" sptr,sptr,sptr
	#func global GdiGetSpoolFileHandle "GdiGetSpoolFileHandle" sptr,sptr,sptr
	#func global GdiPlayDCScript "GdiPlayDCScript" sptr,sptr,sptr,sptr,sptr,sptr
	#func global GdiPlayEMF "GdiPlayEMF" sptr,sptr,sptr,sptr,sptr
	#func global GdiPlayJournal "GdiPlayJournal" sptr,sptr,sptr,sptr,sptr
	#func global GdiPlayPageEMF "GdiPlayPageEMF" sptr,sptr,sptr,sptr,sptr
	#func global GdiPlayPrivatePageEMF "GdiPlayPrivatePageEMF" sptr,sptr,sptr
	#func global GdiPlayScript "GdiPlayScript" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global GdiResetDCEMF "GdiResetDCEMF" sptr,sptr
	#func global GdiSetBatchLimit "GdiSetBatchLimit" sptr
	#func global GdiStartDocEMF "GdiStartDocEMF" sptr,sptr
	#func global GdiStartPageEMF "GdiStartPageEMF" sptr
	#func global GetArcDirection "GetArcDirection" sptr
	#func global GetAspectRatioFilterEx "GetAspectRatioFilterEx" sptr,sptr
	#func global GetBitmapBits "GetBitmapBits" sptr,sptr,sptr
	#func global GetBitmapDimensionEx "GetBitmapDimensionEx" sptr,sptr
	#func global GetBkColor "GetBkColor" sptr
	#func global GetBkMode "GetBkMode" sptr
	#func global GetBoundsRect "GetBoundsRect" sptr,sptr,sptr
	#func global GetBrushOrgEx "GetBrushOrgEx" sptr,sptr
	#define global GetCharABCWidths GetCharABCWidthsA
	#func global GetCharABCWidthsA "GetCharABCWidthsA" sptr,sptr,sptr,sptr
	#define global GetCharABCWidthsFloat GetCharABCWidthsFloatA
	#func global GetCharABCWidthsFloatA "GetCharABCWidthsFloatA" sptr,sptr,sptr,sptr
	#func global GetCharABCWidthsFloatW "GetCharABCWidthsFloatW" wptr,wptr,wptr,wptr
	#func global GetCharABCWidthsI "GetCharABCWidthsI" sptr,sptr,sptr,sptr,sptr
	#func global GetCharABCWidthsW "GetCharABCWidthsW" wptr,wptr,wptr,wptr
	#define global GetCharWidth32 GetCharWidth32A
	#func global GetCharWidth32A "GetCharWidth32A" sptr,sptr,sptr,sptr
	#func global GetCharWidth32W "GetCharWidth32W" wptr,wptr,wptr,wptr
	#define global GetCharWidth GetCharWidthA
	#func global GetCharWidthA "GetCharWidthA" sptr,sptr,sptr,sptr
	#define global GetCharWidthFloat GetCharWidthFloatA
	#func global GetCharWidthFloatA "GetCharWidthFloatA" sptr,sptr,sptr,sptr
	#func global GetCharWidthFloatW "GetCharWidthFloatW" wptr,wptr,wptr,wptr
	#func global GetCharWidthI "GetCharWidthI" sptr,sptr,sptr,sptr,sptr
	#func global GetCharWidthW "GetCharWidthW" wptr,wptr,wptr,wptr
	#define global GetCharacterPlacement GetCharacterPlacementA
	#func global GetCharacterPlacementA "GetCharacterPlacementA" sptr,sptr,sptr,sptr,sptr,sptr
	#func global GetCharacterPlacementW "GetCharacterPlacementW" wptr,wptr,wptr,wptr,wptr,wptr
	#func global GetClipBox "GetClipBox" sptr,sptr
	#func global GetClipRgn "GetClipRgn" sptr,sptr
	#func global GetColorAdjustment "GetColorAdjustment" sptr,sptr
	#func global GetColorSpace "GetColorSpace" sptr
	#func global GetCurrentObject "GetCurrentObject" sptr,sptr
	#func global GetCurrentPositionEx "GetCurrentPositionEx" sptr,sptr
	#func global GetDCBrushColor "GetDCBrushColor" sptr
	#func global GetDCOrgEx "GetDCOrgEx" sptr,sptr
	#func global GetDCPenColor "GetDCPenColor" sptr
	#func global GetDIBColorTable "GetDIBColorTable" sptr,sptr,sptr,sptr
	#func global GetDIBits "GetDIBits" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global GetDeviceCaps "GetDeviceCaps" sptr,sptr
	#func global GetDeviceGammaRamp "GetDeviceGammaRamp" sptr,sptr
	#define global GetEnhMetaFile GetEnhMetaFileA
	#func global GetEnhMetaFileA "GetEnhMetaFileA" sptr
	#func global GetEnhMetaFileBits "GetEnhMetaFileBits" sptr,sptr,sptr
	#define global GetEnhMetaFileDescription GetEnhMetaFileDescriptionA
	#func global GetEnhMetaFileDescriptionA "GetEnhMetaFileDescriptionA" sptr,sptr,sptr
	#func global GetEnhMetaFileDescriptionW "GetEnhMetaFileDescriptionW" wptr,wptr,wptr
	#func global GetEnhMetaFileHeader "GetEnhMetaFileHeader" sptr,sptr,sptr
	#func global GetEnhMetaFilePaletteEntries "GetEnhMetaFilePaletteEntries" sptr,sptr,sptr
	#func global GetEnhMetaFilePixelFormat "GetEnhMetaFilePixelFormat" sptr,sptr,sptr
	#func global GetEnhMetaFileW "GetEnhMetaFileW" wptr
	#func global GetFontAssocStatus "GetFontAssocStatus" sptr
	#func global GetFontData "GetFontData" sptr,sptr,sptr,sptr,sptr
	#func global GetFontLanguageInfo "GetFontLanguageInfo" sptr
	#func global GetFontResourceInfoW "GetFontResourceInfoW" wptr,wptr,wptr,wptr
	#func global GetFontUnicodeRanges "GetFontUnicodeRanges" sptr,sptr
	#define global GetGlyphIndices GetGlyphIndicesA
	#func global GetGlyphIndicesA "GetGlyphIndicesA" sptr,sptr,sptr,sptr,sptr
	#func global GetGlyphIndicesW "GetGlyphIndicesW" wptr,wptr,wptr,wptr,wptr
	#func global GetGlyphOutline "GetGlyphOutline" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global GetGlyphOutlineA "GetGlyphOutlineA" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global GetGlyphOutlineW "GetGlyphOutlineW" wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#func global GetGraphicsMode "GetGraphicsMode" sptr
	#define global GetICMProfile GetICMProfileA
	#func global GetICMProfileA "GetICMProfileA" sptr,sptr,sptr
	#func global GetICMProfileW "GetICMProfileW" wptr,wptr,wptr
	#func global GetKerningPairs "GetKerningPairs" sptr,sptr,sptr
	#func global GetKerningPairsA "GetKerningPairsA" sptr,sptr,sptr
	#func global GetKerningPairsW "GetKerningPairsW" wptr,wptr,wptr
	#func global GetLayout "GetLayout" sptr
	#define global GetLogColorSpace GetLogColorSpaceA
	#func global GetLogColorSpaceA "GetLogColorSpaceA" sptr,sptr,sptr
	#func global GetLogColorSpaceW "GetLogColorSpaceW" wptr,wptr,wptr
	#func global GetMapMode "GetMapMode" sptr
	#define global GetMetaFile GetMetaFileA
	#func global GetMetaFileA "GetMetaFileA" sptr
	#func global GetMetaFileBitsEx "GetMetaFileBitsEx" sptr,sptr,sptr
	#func global GetMetaFileW "GetMetaFileW" wptr
	#func global GetMetaRgn "GetMetaRgn" sptr,sptr
	#func global GetMiterLimit "GetMiterLimit" sptr,sptr
	#func global GetNearestColor "GetNearestColor" sptr,sptr
	#func global GetNearestPaletteIndex "GetNearestPaletteIndex" sptr,sptr
	#define global GetObject GetObjectA
	#func global GetObjectA "GetObjectA" sptr,sptr,sptr
	#func global GetObjectType "GetObjectType" sptr
	#func global GetObjectW "GetObjectW" wptr,wptr,wptr
	#define global GetOutlineTextMetrics GetOutlineTextMetricsA
	#func global GetOutlineTextMetricsA "GetOutlineTextMetricsA" sptr,sptr,sptr
	#func global GetOutlineTextMetricsW "GetOutlineTextMetricsW" wptr,wptr,wptr
	#func global GetPaletteEntries "GetPaletteEntries" sptr,sptr,sptr,sptr
	#func global _GetPath "GetPath" sptr,sptr,sptr,sptr
	#func global GetPixel "GetPixel" sptr,sptr,sptr
	#func global GetPixelFormat "GetPixelFormat" sptr
	#func global GetPolyFillMode "GetPolyFillMode" sptr
	#func global GetROP2 "GetROP2" sptr
	#func global GetRandomRgn "GetRandomRgn" sptr,sptr,sptr
	#func global GetRasterizerCaps "GetRasterizerCaps" sptr,sptr
	#func global GetRegionData "GetRegionData" sptr,sptr,sptr
	#func global GetRelAbs "GetRelAbs" sptr,sptr
	#func global GetRgnBox "GetRgnBox" sptr,sptr
	#func global GetStockObject "GetStockObject" sptr
	#func global GetStretchBltMode "GetStretchBltMode" sptr
	#func global GetSystemPaletteEntries "GetSystemPaletteEntries" sptr,sptr,sptr,sptr
	#func global GetSystemPaletteUse "GetSystemPaletteUse" sptr
	#func global GetTextAlign "GetTextAlign" sptr
	#func global GetTextCharacterExtra "GetTextCharacterExtra" sptr
	#func global GetTextCharset "GetTextCharset" sptr
	#func global GetTextCharsetInfo "GetTextCharsetInfo" sptr,sptr,sptr
	#func global GetTextColor "GetTextColor" sptr
	#define global GetTextExtentExPoint GetTextExtentExPointA
	#func global GetTextExtentExPointA "GetTextExtentExPointA" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global GetTextExtentExPointI "GetTextExtentExPointI" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global GetTextExtentExPointW "GetTextExtentExPointW" wptr,wptr,wptr,wptr,wptr,wptr,wptr
	#define global GetTextExtentPoint32 GetTextExtentPoint32A
	#func global GetTextExtentPoint32A "GetTextExtentPoint32A" sptr,sptr,sptr,sptr
	#func global GetTextExtentPoint32W "GetTextExtentPoint32W" wptr,wptr,wptr,wptr
	#define global GetTextExtentPoint GetTextExtentPointA
	#func global GetTextExtentPointA "GetTextExtentPointA" sptr,sptr,sptr,sptr
	#func global GetTextExtentPointI "GetTextExtentPointI" sptr,sptr,sptr,sptr
	#func global GetTextExtentPointW "GetTextExtentPointW" wptr,wptr,wptr,wptr
	#define global GetTextFace GetTextFaceA
	#func global GetTextFaceA "GetTextFaceA" sptr,sptr,sptr
	#func global GetTextFaceW "GetTextFaceW" wptr,wptr,wptr
	#define global GetTextMetrics GetTextMetricsA
	#func global GetTextMetricsA "GetTextMetricsA" sptr,sptr
	#func global GetTextMetricsW "GetTextMetricsW" wptr,wptr
	#func global GetViewportExtEx "GetViewportExtEx" sptr,sptr
	#func global GetViewportOrgEx "GetViewportOrgEx" sptr,sptr
	#func global GetWinMetaFileBits "GetWinMetaFileBits" sptr,sptr,sptr,sptr,sptr
	#func global GetWindowExtEx "GetWindowExtEx" sptr,sptr
	#func global GetWindowOrgEx "GetWindowOrgEx" sptr,sptr
	#func global GetWorldTransform "GetWorldTransform" sptr,sptr
	#func global IntersectClipRect "IntersectClipRect" sptr,sptr,sptr,sptr,sptr
	#func global InvertRgn "InvertRgn" sptr,sptr
	#func global LPtoDP "LPtoDP" sptr,sptr,sptr
	#define global LineDD LineDDA
	#func global LineDDA "LineDDA" sptr,sptr,sptr,sptr,sptr,sptr
	#func global LineTo "LineTo" sptr,sptr,sptr
	#func global MaskBlt "MaskBlt" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global ModifyWorldTransform "ModifyWorldTransform" sptr,sptr,sptr
	#func global MoveToEx "MoveToEx" sptr,sptr,sptr,sptr
	#func global OffsetClipRgn "OffsetClipRgn" sptr,sptr,sptr
	#func global OffsetRgn "OffsetRgn" sptr,sptr,sptr
	#func global OffsetViewportOrgEx "OffsetViewportOrgEx" sptr,sptr,sptr,sptr
	#func global OffsetWindowOrgEx "OffsetWindowOrgEx" sptr,sptr,sptr,sptr
	#func global PaintRgn "PaintRgn" sptr,sptr
	#func global PatBlt "PatBlt" sptr,sptr,sptr,sptr,sptr,sptr
	#func global PathToRegion "PathToRegion" sptr
	#func global Pie "Pie" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global PlayEnhMetaFile "PlayEnhMetaFile" sptr,sptr,sptr
	#func global PlayEnhMetaFileRecord "PlayEnhMetaFileRecord" sptr,sptr,sptr,sptr
	#func global PlayMetaFile "PlayMetaFile" sptr,sptr
	#func global PlayMetaFileRecord "PlayMetaFileRecord" sptr,sptr,sptr,sptr
	#func global PlgBlt "PlgBlt" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global PolyBezier "PolyBezier" sptr,sptr,sptr
	#func global PolyBezierTo "PolyBezierTo" sptr,sptr,sptr
	#func global PolyDraw "PolyDraw" sptr,sptr,sptr,sptr
	#func global PolyPolygon "PolyPolygon" sptr,sptr,sptr,sptr
	#func global PolyPolyline "PolyPolyline" sptr,sptr,sptr,sptr
	#define global PolyTextOut PolyTextOutA
	#func global PolyTextOutA "PolyTextOutA" sptr,sptr,sptr
	#func global PolyTextOutW "PolyTextOutW" wptr,wptr,wptr
	#func global Polygon "Polygon" sptr,sptr,sptr
	#func global Polyline "Polyline" sptr,sptr,sptr
	#func global PolylineTo "PolylineTo" sptr,sptr,sptr
	#func global PtInRegion "PtInRegion" sptr,sptr,sptr
	#func global PtVisible "PtVisible" sptr,sptr,sptr
	#func global RealizePalette "RealizePalette" sptr
	#func global RectInRegion "RectInRegion" sptr,sptr
	#func global RectVisible "RectVisible" sptr,sptr
	#func global Rectangle "Rectangle" sptr,sptr,sptr,sptr,sptr
	#func global RemoveFontMemResourceEx "RemoveFontMemResourceEx" sptr
	#define global RemoveFontResource RemoveFontResourceA
	#func global RemoveFontResourceA "RemoveFontResourceA" sptr
	#define global RemoveFontResourceEx RemoveFontResourceExA
	#func global RemoveFontResourceExA "RemoveFontResourceExA" sptr,sptr,sptr
	#func global RemoveFontResourceExW "RemoveFontResourceExW" wptr,wptr,wptr
	#func global RemoveFontResourceW "RemoveFontResourceW" wptr
	#define global ResetDC ResetDCA
	#func global ResetDCA "ResetDCA" sptr,sptr
	#func global ResetDCW "ResetDCW" wptr,wptr
	#func global ResizePalette "ResizePalette" sptr,sptr
	#func global RestoreDC "RestoreDC" sptr,sptr
	#func global RoundRect "RoundRect" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global SaveDC "SaveDC" sptr
	#func global ScaleViewportExtEx "ScaleViewportExtEx" sptr,sptr,sptr,sptr,sptr,sptr
	#func global ScaleWindowExtEx "ScaleWindowExtEx" sptr,sptr,sptr,sptr,sptr,sptr
	#func global SelectBrushLocal "SelectBrushLocal" sptr,sptr
	#func global SelectClipPath "SelectClipPath" sptr,sptr
	#func global SelectClipRgn "SelectClipRgn" sptr,sptr
	#func global SelectFontLocal "SelectFontLocal" sptr,sptr
	#func global SelectObject "SelectObject" sptr,sptr
	#func global SelectPalette "SelectPalette" sptr,sptr,sptr
	#func global SetAbortProc "SetAbortProc" sptr,sptr
	#func global SetArcDirection "SetArcDirection" sptr,sptr
	#func global SetBitmapBits "SetBitmapBits" sptr,sptr,sptr
	#func global SetBitmapDimensionEx "SetBitmapDimensionEx" sptr,sptr,sptr,sptr
	#func global SetBkColor "SetBkColor" sptr,sptr
	#func global SetBkMode "SetBkMode" sptr,sptr
	#func global SetBoundsRect "SetBoundsRect" sptr,sptr,sptr
	#func global SetBrushOrgEx "SetBrushOrgEx" sptr,sptr,sptr,sptr
	#func global SetColorAdjustment "SetColorAdjustment" sptr,sptr
	#func global SetColorSpace "SetColorSpace" sptr,sptr
	#func global SetDCBrushColor "SetDCBrushColor" sptr,sptr
	#func global SetDCPenColor "SetDCPenColor" sptr,sptr
	#func global SetDIBColorTable "SetDIBColorTable" sptr,sptr,sptr,sptr
	#func global SetDIBits "SetDIBits" sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global SetDIBitsToDevice "SetDIBitsToDevice" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global SetDeviceGammaRamp "SetDeviceGammaRamp" sptr,sptr
	#func global SetEnhMetaFileBits "SetEnhMetaFileBits" sptr,sptr
	#func global SetFontEnumeration "SetFontEnumeration" sptr
	#func global SetGraphicsMode "SetGraphicsMode" sptr,sptr
	#func global SetICMMode "SetICMMode" sptr,sptr
	#define global SetICMProfile SetICMProfileA
	#func global SetICMProfileA "SetICMProfileA" sptr,sptr
	#func global SetICMProfileW "SetICMProfileW" wptr,wptr
	#func global SetLayout "SetLayout" sptr,sptr
	#func global SetMagicColors "SetMagicColors" sptr,sptr,sptr
	#func global SetMapMode "SetMapMode" sptr,sptr
	#func global SetMapperFlags "SetMapperFlags" sptr,sptr
	#func global SetMetaFileBitsEx "SetMetaFileBitsEx" sptr,sptr
	#func global SetMetaRgn "SetMetaRgn" sptr
	#func global SetMiterLimit "SetMiterLimit" sptr,sptr,sptr
	#func global SetPaletteEntries "SetPaletteEntries" sptr,sptr,sptr,sptr
	#func global SetPixel "SetPixel" sptr,sptr,sptr,sptr
	#func global SetPixelFormat "SetPixelFormat" sptr,sptr,sptr
	#func global SetPixelV "SetPixelV" sptr,sptr,sptr,sptr
	#func global SetPolyFillMode "SetPolyFillMode" sptr,sptr
	#func global SetROP2 "SetROP2" sptr,sptr
	#func global SetRectRgn "SetRectRgn" sptr,sptr,sptr,sptr,sptr
	#func global SetRelAbs "SetRelAbs" sptr,sptr
	#func global SetStretchBltMode "SetStretchBltMode" sptr,sptr
	#func global SetSystemPaletteUse "SetSystemPaletteUse" sptr,sptr
	#func global SetTextAlign "SetTextAlign" sptr,sptr
	#func global SetTextCharacterExtra "SetTextCharacterExtra" sptr,sptr
	#func global SetTextColor "SetTextColor" sptr,sptr
	#func global SetTextJustification "SetTextJustification" sptr,sptr,sptr
	#func global SetViewportExtEx "SetViewportExtEx" sptr,sptr,sptr,sptr
	#func global SetViewportOrgEx "SetViewportOrgEx" sptr,sptr,sptr,sptr
	#func global SetWinMetaFileBits "SetWinMetaFileBits" sptr,sptr,sptr,sptr
	#func global SetWindowExtEx "SetWindowExtEx" sptr,sptr,sptr,sptr
	#func global SetWindowOrgEx "SetWindowOrgEx" sptr,sptr,sptr,sptr
	#func global SetWorldTransform "SetWorldTransform" sptr,sptr
	#define global StartDoc StartDocA
	#func global StartDocA "StartDocA" sptr,sptr
	#func global StartDocW "StartDocW" wptr,wptr
	#func global StartFormPage "StartFormPage" sptr
	#func global StartPage "StartPage" sptr
	#func global StretchBlt "StretchBlt" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global StretchDIBits "StretchDIBits" sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr,sptr
	#func global StrokeAndFillPath "StrokeAndFillPath" sptr
	#func global StrokePath "StrokePath" sptr
	#func global SwapBuffers "SwapBuffers" sptr
	#define global TextOut TextOutA
	#func global TextOutA "TextOutA" sptr,sptr,sptr,sptr,sptr
	#func global TextOutW "TextOutW" wptr,wptr,wptr,wptr,wptr
	#func global TranslateCharsetInfo "TranslateCharsetInfo" sptr,sptr,sptr
	#func global UnrealizeObject "UnrealizeObject" sptr
	#func global UpdateColors "UpdateColors" sptr
	#define global UpdateICMRegKey UpdateICMRegKeyA
	#func global UpdateICMRegKeyA "UpdateICMRegKeyA" sptr,sptr,sptr,sptr
	#func global UpdateICMRegKeyW "UpdateICMRegKeyW" wptr,wptr,wptr,wptr
	#func global WidenPath "WidenPath" sptr
	#func global gdiPlaySpoolStream "gdiPlaySpoolStream" sptr,sptr,sptr,sptr,sptr,sptr
#endif
#endif
