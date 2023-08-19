package dwrite_wrapper

import "core:fmt"

import win32 "core:sys/windows"
import "vendor:directx/dxgi"

foreign import dwrite "wrapper.lib"

@(default_calling_convention = "std")
@(link_prefix="dwDWrite")
foreign dwrite {
}

create_factory :: proc(type: FACTORY_TYPE, factory: ^^IFactory) -> win32.HRESULT {
	foreign dwrite {
		dwDWriteCreateFactory :: proc "c" (type: FACTORY_TYPE, factory: ^^IUnknown) -> win32.HRESULT ---
	}
	res := dwDWriteCreateFactory(type, cast(^^IUnknown)factory);
	return res
}

register_font_file_loader :: proc(factory: ^IFactory, font_loader: ^IFontFileLoader) -> win32.HRESULT {
	foreign dwrite {
		dwRegisterFontFileLoader :: proc "c" (factory: ^IUnknown, font_loader: ^IUnknown) -> win32.HRESULT ---
	}
	return dwRegisterFontFileLoader(cast(^IUnknown)factory, cast(^IUnknown)font_loader)
}

POINT_2F :: struct {
	x: f32,
	y: f32,
}

FONTSIGNATURE :: struct {
	fsUsb: [4]win32.UINT,
	fsCsb: [2]win32.UINT,
}
LF_FACESIZE :: 32

LOGFONTA :: struct {
	lfHeight: win32.LONG,
	lfWidth: win32.LONG,
	lfEscapement: win32.LONG,
	lfOrientation: win32.LONG,
	lfWeight: win32.LONG,
	lfItalic: win32.BYTE,
	lfUnderline: win32.BYTE,
	lfStrikeOut: win32.BYTE,
	lfCharSet: win32.BYTE,
	lfOutPrecision: win32.BYTE,
	lfClipPrecision: win32.BYTE,
	lfQuality: win32.BYTE,
	lfPitchAndFamily: win32.BYTE,
	lfFaceName: [LF_FACESIZE]win32.CHAR,
}

LOGFONTW :: struct {
	lfHeight: win32.LONG,
	lfWidth: win32.LONG,
	lfEscapement: win32.LONG,
	lfOrientation: win32.LONG,
	lfWeight: win32.LONG,
	lfItalic: win32.BYTE,
	lfUnderline: win32.BYTE,
	lfStrikeOut: win32.BYTE,
	lfCharSet: win32.BYTE,
	lfOutPrecision: win32.BYTE,
	lfClipPrecision: win32.BYTE,
	lfQuality: win32.BYTE,
	lfPitchAndFamily: win32.BYTE,
	lfFaceName: [LF_FACESIZE]win32.WCHAR,
}

IUnknown :: dxgi.IUnknown
IUnknown_VTable :: dxgi.IUnknown_VTable

HANDLE :: win32.HANDLE
HRESULT :: win32.HRESULT
BOOL :: win32.BOOL
HWND :: win32.HWND
HDC :: win32.HDC
HMONITOR :: win32.HMONITOR
RECT :: win32.RECT
PWSTR :: win32.wstring
POINT :: win32.POINT
FILETIME :: win32.FILETIME
SIZE :: win32.SIZE


FONT_AXIS_TAG :: enum u32 {
	WEIGHT       = 1952999287,
	WIDTH        = 1752458359,
	SLANT        = 1953393779,
	OPTICAL_SIZE = 2054385775,
	ITALIC       = 1818326121,
}

COLOR_F :: struct {
	r: f32,
	g: f32,
	b: f32,
	a: f32,
}

MEASURING_MODE :: enum i32 {
	NATURAL,
	GDI_CLASSIC,
	GDI_NATURAL,
}

GLYPH_IMAGE_FORMATS_Flag :: enum {
	TRUETYPE,
	CFF,
	COLR,
	SVG,
	PNG,
	JPEG,
	TIFF,
	PREMULTIPLIED_B8G8R8A8,
}
GLYPH_IMAGE_FORMATS :: bit_set[GLYPH_IMAGE_FORMATS_Flag;u32]

FONT_FILE_TYPE :: enum i32 {
	UNKNOWN             = 0,
	CFF                 = 1,
	TRUETYPE            = 2,
	OPENTYPE_COLLECTION = 3,
	TYPE1_PFM           = 4,
	TYPE1_PFB           = 5,
	VECTOR              = 6,
	BITMAP              = 7,
	TRUETYPE_COLLECTION = 3,
}

FONT_FACE_TYPE :: enum i32 {
	CFF                 = 0,
	TRUETYPE            = 1,
	OPENTYPE_COLLECTION = 2,
	TYPE1               = 3,
	VECTOR              = 4,
	BITMAP              = 5,
	UNKNOWN             = 6,
	RAW_CFF             = 7,
	TRUETYPE_COLLECTION = 2,
}

FONT_SIMULATIONS_Flag :: enum {
	BOLD    = 1,
	OBLIQUE = 2,
}
FONT_SIMULATIONS :: bit_set[FONT_SIMULATIONS_Flag;u32]

FONT_WEIGHT :: enum i32 {
	THIN        = 100,
	EXTRA_LIGHT = 200,
	ULTRA_LIGHT = 200,
	LIGHT       = 300,
	SEMI_LIGHT  = 350,
	NORMAL      = 400,
	REGULAR     = 400,
	MEDIUM      = 500,
	DEMI_BOLD   = 600,
	SEMI_BOLD   = 600,
	BOLD        = 700,
	EXTRA_BOLD  = 800,
	ULTRA_BOLD  = 800,
	BLACK       = 900,
	HEAVY       = 900,
	EXTRA_BLACK = 950,
	ULTRA_BLACK = 950,
}

FONT_STRETCH :: enum i32 {
	UNDEFINED       = 0,
	ULTRA_CONDENSED = 1,
	EXTRA_CONDENSED = 2,
	CONDENSED       = 3,
	SEMI_CONDENSED  = 4,
	NORMAL          = 5,
	MEDIUM          = 5,
	SEMI_EXPANDED   = 6,
	EXPANDED        = 7,
	EXTRA_EXPANDED  = 8,
	ULTRA_EXPANDED  = 9,
}

FONT_STYLE :: enum i32 {
	NORMAL,
	OBLIQUE,
	ITALIC,
}

INFORMATIONAL_STRING_ID :: enum i32 {
	NONE                             = 0,
	COPYRIGHT_NOTICE                 = 1,
	VERSION_STRINGS                  = 2,
	TRADEMARK                        = 3,
	MANUFACTURER                     = 4,
	DESIGNER                         = 5,
	DESIGNER_URL                     = 6,
	DESCRIPTION                      = 7,
	FONT_VENDOR_URL                  = 8,
	LICENSE_DESCRIPTION              = 9,
	LICENSE_INFO_URL                 = 10,
	WIN32_FAMILY_NAMES               = 11,
	WIN32_SUBFAMILY_NAMES            = 12,
	TYPOGRAPHIC_FAMILY_NAMES         = 13,
	TYPOGRAPHIC_SUBFAMILY_NAMES      = 14,
	SAMPLE_TEXT                      = 15,
	FULL_NAME                        = 16,
	POSTSCRIPT_NAME                  = 17,
	POSTSCRIPT_CID_NAME              = 18,
	WEIGHT_STRETCH_STYLE_FAMILY_NAME = 19,
	DESIGN_SCRIPT_LANGUAGE_TAG       = 20,
	SUPPORTED_SCRIPT_LANGUAGE_TAG    = 21,
	PREFERRED_FAMILY_NAMES           = 13,
	PREFERRED_SUBFAMILY_NAMES        = 14,
	WWS_FAMILY_NAME                  = 19,
}

FONT_METRICS :: struct {
	designUnitsPerEm:       u16,
	ascent:                 u16,
	descent:                u16,
	lineGap:                i16,
	capHeight:              u16,
	xHeight:                u16,
	underlinePosition:      i16,
	underlineThickness:     u16,
	strikethroughPosition:  i16,
	strikethroughThickness: u16,
}

GLYPH_METRICS :: struct {
	leftSideBearing:   i32,
	advanceWidth:      u32,
	rightSideBearing:  i32,
	topSideBearing:    i32,
	advanceHeight:     u32,
	bottomSideBearing: i32,
	verticalOriginY:   i32,
}

GLYPH_OFFSET :: struct {
	advanceOffset:  f32,
	ascenderOffset: f32,
}

FACTORY_TYPE :: enum i32 {
	SHARED,
	ISOLATED,
}

IFontFileLoader_UUID_STRING := "727cad4e-d6af-4c9e-8a08-d695b11caa49"
IFontFileLoader_UUID := win32.IID{0x727cad4e, 0xd6af, 0x4c9e, {0x8a, 0x08, 0xd6, 0x95, 0xb1, 0x1c, 0xaa, 0x49}}
IFontFileLoader :: struct #raw_union {
	#subtype iunknown:            IUnknown,
	using ifontfileloader_vtable: IFontFileLoader_VTable,
}
IFontFileLoader_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	CreateStreamFromKey:   proc "stdcall" (this: ^IFontFileLoader, fontFileReferenceKey: rawptr, fontFileReferenceKeySize: u32, fontFileStream: ^^IFontFileStream) -> HRESULT,
}


ILocalFontFileLoader_UUID_STRING := "b2d9f3ec-c9fe-4a11-a2ec-d86208f7c0a2"
ILocalFontFileLoader_UUID := win32.IID{0xb2d9f3ec, 0xc9fe, 0x4a11, {0xa2, 0xec, 0xd8, 0x62, 0x08, 0xf7, 0xc0, 0xa2}}
ILocalFontFileLoader :: struct #raw_union {
	#subtype ifontfileloader:          IFontFileLoader,
	using ilocalfontfileloader_vtable: ILocalFontFileLoader_VTable,
}
ILocalFontFileLoader_VTable :: struct {
	using ifontfileloader_vtable: IFontFileLoader_VTable,
	GetFilePathLengthFromKey:     proc "stdcall" (this: ^ILocalFontFileLoader, fontFileReferenceKey: rawptr, fontFileReferenceKeySize: u32, filePathLength: ^u32) -> HRESULT,
	GetFilePathFromKey:           proc "stdcall" (
		this: ^ILocalFontFileLoader,
		fontFileReferenceKey: rawptr,
		fontFileReferenceKeySize: u32,
		filePath: [^]u8,
		filePathSize: u32,
	) -> HRESULT,
	GetLastWriteTimeFromKey:      proc "stdcall" (this: ^ILocalFontFileLoader, fontFileReferenceKey: rawptr, fontFileReferenceKeySize: u32, lastWriteTime: ^FILETIME) -> HRESULT,
}


IFontFileStream_UUID_STRING := "6d4865fe-0ab8-4d91-8f62-5dd6be34a3e0"
IFontFileStream_UUID := win32.IID{0x6d4865fe, 0x0ab8, 0x4d91, {0x8f, 0x62, 0x5d, 0xd6, 0xbe, 0x34, 0xa3, 0xe0}}
IFontFileStream :: struct #raw_union {
	#subtype iunknown:            IUnknown,
	using ifontfilestream_vtable: IFontFileStream_VTable,
}
IFontFileStream_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	ReadFileFragment:      proc "stdcall" (this: ^IFontFileStream, fragmentStart: ^rawptr, fileOffset: u64, fragmentSize: u64, fragmentContext: ^rawptr) -> HRESULT,
	ReleaseFileFragment:   proc "stdcall" (this: ^IFontFileStream, fragmentContext: rawptr),
	GetFileSize:           proc "stdcall" (this: ^IFontFileStream, fileSize: ^u64) -> HRESULT,
	GetLastWriteTime:      proc "stdcall" (this: ^IFontFileStream, lastWriteTime: ^u64) -> HRESULT,
}


IFontFile_UUID_STRING := "739d886a-cef5-47dc-8769-1a8b41bebbb0"
IFontFile_UUID := win32.IID{0x739d886a, 0xcef5, 0x47dc, {0x87, 0x69, 0x1a, 0x8b, 0x41, 0xbe, 0xbb, 0xb0}}
IFontFile :: struct #raw_union {
	#subtype iunknown:      IUnknown,
	using ifontfile_vtable: IFontFile_VTable,
}
IFontFile_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	GetReferenceKey:       proc "stdcall" (this: ^IFontFile, fontFileReferenceKey: ^rawptr, fontFileReferenceKeySize: ^u32) -> HRESULT,
	GetLoader:             proc "stdcall" (this: ^IFontFile, fontFileLoader: ^^IFontFileLoader) -> HRESULT,
	Analyze:               proc "stdcall" (
		this: ^IFontFile,
		isSupportedFontType: ^BOOL,
		fontFileType: ^FONT_FILE_TYPE,
		fontFaceType: ^FONT_FACE_TYPE,
		numberOfFaces: ^u32,
	) -> HRESULT,
}


PIXEL_GEOMETRY :: enum i32 {
	FLAT,
	RGB,
	BGR,
}

RENDERING_MODE :: enum i32 {
	DEFAULT                     = 0,
	ALIASED                     = 1,
	GDI_CLASSIC                 = 2,
	GDI_NATURAL                 = 3,
	NATURAL                     = 4,
	NATURAL_SYMMETRIC           = 5,
	OUTLINE                     = 6,
	CLEARTYPE_GDI_CLASSIC       = 2,
	CLEARTYPE_GDI_NATURAL       = 3,
	CLEARTYPE_NATURAL           = 4,
	CLEARTYPE_NATURAL_SYMMETRIC = 5,
}

MATRIX :: struct {
	m11: f32,
	m12: f32,
	m21: f32,
	m22: f32,
	dx:  f32,
	dy:  f32,
}

IRenderingParams_UUID_STRING := "2f0da53a-2add-47cd-82ee-d9ec34688e75"
IRenderingParams_UUID := win32.IID{0x2f0da53a, 0x2add, 0x47cd, {0x82, 0xee, 0xd9, 0xec, 0x34, 0x68, 0x8e, 0x75}}
IRenderingParams :: struct #raw_union {
	#subtype iunknown:             IUnknown,
	using irenderingparams_vtable: IRenderingParams_VTable,
}
IRenderingParams_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	GetGamma:              proc "stdcall" (this: ^IRenderingParams) -> f32,
	GetEnhancedContrast:   proc "stdcall" (this: ^IRenderingParams) -> f32,
	GetClearTypeLevel:     proc "stdcall" (this: ^IRenderingParams) -> f32,
	GetPixelGeometry:      proc "stdcall" (this: ^IRenderingParams) -> PIXEL_GEOMETRY,
	GetRenderingMode:      proc "stdcall" (this: ^IRenderingParams) -> RENDERING_MODE,
}


IFontFace_UUID_STRING := "5f49804d-7024-4d43-bfa9-d25984f53849"
IFontFace_UUID := win32.IID{0x5f49804d, 0x7024, 0x4d43, {0xbf, 0xa9, 0xd2, 0x59, 0x84, 0xf5, 0x38, 0x49}}
IFontFace :: struct #raw_union {
	#subtype iunknown:      IUnknown,
	using ifontface_vtable: IFontFace_VTable,
}
IFontFace_VTable :: struct {
	using iunknown_vtable:        IUnknown_VTable,
	GetType:                      proc "stdcall" (this: ^IFontFace) -> FONT_FACE_TYPE,
	GetFiles:                     proc "stdcall" (this: ^IFontFace, numberOfFiles: ^u32, fontFiles: [^]^IFontFile) -> HRESULT,
	GetIndex:                     proc "stdcall" (this: ^IFontFace) -> u32,
	GetSimulations:               proc "stdcall" (this: ^IFontFace) -> FONT_SIMULATIONS,
	IsSymbolFont:                 proc "stdcall" (this: ^IFontFace) -> BOOL,
	GetMetrics:                   proc "stdcall" (this: ^IFontFace, fontFaceMetrics: ^FONT_METRICS),
	GetGlyphCount:                proc "stdcall" (this: ^IFontFace) -> u16,
	GetDesignGlyphMetrics:        proc "stdcall" (this: ^IFontFace, glyphIndices: [^]u16, glyphCount: u32, glyphMetrics: [^]GLYPH_METRICS, isSideways: BOOL) -> HRESULT,
	GetGlyphIndices:              proc "stdcall" (this: ^IFontFace, codePoints: [^]u32, codePointCount: u32, glyphIndices: [^]u16) -> HRESULT,
	TryGetFontTable:              proc "stdcall" (this: ^IFontFace, openTypeTableTag: u32, tableData: ^rawptr, tableSize: ^u32, tableContext: ^rawptr, exists: ^BOOL) -> HRESULT,
	ReleaseFontTable:             proc "stdcall" (this: ^IFontFace, tableContext: rawptr),
	GetGlyphRunOutline:           proc "stdcall" (
		this: ^IFontFace,
		emSize: f32,
		glyphIndices: [^]u16,
		glyphAdvances: [^]f32,
		glyphOffsets: [^]GLYPH_OFFSET,
		glyphCount: u32,
		isSideways: BOOL,
		isRightToLeft: BOOL,
		// geometrySink: ^d2d_common.ISimplifiedGeometrySink,
	) -> HRESULT,
	GetRecommendedRenderingMode:  proc "stdcall" (
		this: ^IFontFace,
		emSize: f32,
		pixelsPerDip: f32,
		measuringMode: MEASURING_MODE,
		renderingParams: ^IRenderingParams,
		renderingMode: ^RENDERING_MODE,
	) -> HRESULT,
	GetGdiCompatibleMetrics:      proc "stdcall" (this: ^IFontFace, emSize: f32, pixelsPerDip: f32, transform: ^MATRIX, fontFaceMetrics: ^FONT_METRICS) -> HRESULT,
	GetGdiCompatibleGlyphMetrics: proc "stdcall" (
		this: ^IFontFace,
		emSize: f32,
		pixelsPerDip: f32,
		transform: ^MATRIX,
		useGdiNatural: BOOL,
		glyphIndices: [^]u16,
		glyphCount: u32,
		glyphMetrics: [^]GLYPH_METRICS,
		isSideways: BOOL,
	) -> HRESULT,
}


IFontCollectionLoader_UUID_STRING := "cca920e4-52f0-492b-bfa8-29c72ee0a468"
IFontCollectionLoader_UUID := win32.IID{0xcca920e4, 0x52f0, 0x492b, {0xbf, 0xa8, 0x29, 0xc7, 0x2e, 0xe0, 0xa4, 0x68}}
IFontCollectionLoader :: struct #raw_union {
	#subtype iunknown:                  IUnknown,
	using ifontcollectionloader_vtable: IFontCollectionLoader_VTable,
}
IFontCollectionLoader_VTable :: struct {
	using iunknown_vtable:   IUnknown_VTable,
	CreateEnumeratorFromKey: proc "stdcall" (
		this: ^IFontCollectionLoader,
		factory: ^IFactory,
		collectionKey: rawptr,
		collectionKeySize: u32,
		fontFileEnumerator: ^^IFontFileEnumerator,
	) -> HRESULT,
}


IFontFileEnumerator_UUID_STRING := "72755049-5ff7-435d-8348-4be97cfa6c7c"
IFontFileEnumerator_UUID := win32.IID{0x72755049, 0x5ff7, 0x435d, {0x83, 0x48, 0x4b, 0xe9, 0x7c, 0xfa, 0x6c, 0x7c}}
IFontFileEnumerator :: struct #raw_union {
	#subtype iunknown:                IUnknown,
	using ifontfileenumerator_vtable: IFontFileEnumerator_VTable,
}
IFontFileEnumerator_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	MoveNext:              proc "stdcall" (this: ^IFontFileEnumerator, hasCurrentFile: ^BOOL) -> HRESULT,
	GetCurrentFontFile:    proc "stdcall" (this: ^IFontFileEnumerator, fontFile: ^^IFontFile) -> HRESULT,
}


ILocalizedStrings_UUID_STRING := "08256209-099a-4b34-b86d-c22b110e7771"
ILocalizedStrings_UUID := win32.IID{0x08256209, 0x099a, 0x4b34, {0xb8, 0x6d, 0xc2, 0x2b, 0x11, 0x0e, 0x77, 0x71}}
ILocalizedStrings :: struct #raw_union {
	#subtype iunknown:              IUnknown,
	using ilocalizedstrings_vtable: ILocalizedStrings_VTable,
}
ILocalizedStrings_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	GetCount:              proc "stdcall" (this: ^ILocalizedStrings) -> u32,
	FindLocaleName:        proc "stdcall" (this: ^ILocalizedStrings, localeName: PWSTR, index: ^u32, exists: ^BOOL) -> HRESULT,
	GetLocaleNameLength:   proc "stdcall" (this: ^ILocalizedStrings, index: u32, length: ^u32) -> HRESULT,
	GetLocaleName:         proc "stdcall" (this: ^ILocalizedStrings, index: u32, localeName: [^]u8, size: u32) -> HRESULT,
	GetStringLength:       proc "stdcall" (this: ^ILocalizedStrings, index: u32, length: ^u32) -> HRESULT,
	GetString:             proc "stdcall" (this: ^ILocalizedStrings, index: u32, stringBuffer: [^]u8, size: u32) -> HRESULT,
}


IFontCollection_UUID_STRING := "a84cee02-3eea-4eee-a827-87c1a02a0fcc"
IFontCollection_UUID := win32.IID{0xa84cee02, 0x3eea, 0x4eee, {0xa8, 0x27, 0x87, 0xc1, 0xa0, 0x2a, 0x0f, 0xcc}}
IFontCollection :: struct #raw_union {
	#subtype iunknown:            IUnknown,
	using ifontcollection_vtable: IFontCollection_VTable,
}
IFontCollection_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	GetFontFamilyCount:    proc "stdcall" (this: ^IFontCollection) -> u32,
	GetFontFamily:         proc "stdcall" (this: ^IFontCollection, index: u32, fontFamily: ^^IFontFamily) -> HRESULT,
	FindFamilyName:        proc "stdcall" (this: ^IFontCollection, familyName: PWSTR, index: ^u32, exists: ^BOOL) -> HRESULT,
	GetFontFromFontFace:   proc "stdcall" (this: ^IFontCollection, fontFace: ^IFontFace, font: ^^IFont) -> HRESULT,
}


IFontList_UUID_STRING := "1a0d8438-1d97-4ec1-aef9-a2fb86ed6acb"
IFontList_UUID := win32.IID{0x1a0d8438, 0x1d97, 0x4ec1, {0xae, 0xf9, 0xa2, 0xfb, 0x86, 0xed, 0x6a, 0xcb}}
IFontList :: struct #raw_union {
	#subtype iunknown:      IUnknown,
	using ifontlist_vtable: IFontList_VTable,
}
IFontList_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	GetFontCollection:     proc "stdcall" (this: ^IFontList, fontCollection: ^^IFontCollection) -> HRESULT,
	GetFontCount:          proc "stdcall" (this: ^IFontList) -> u32,
	GetFont:               proc "stdcall" (this: ^IFontList, index: u32, font: ^^IFont) -> HRESULT,
}


IFontFamily_UUID_STRING := "da20d8ef-812a-4c43-9802-62ec4abd7add"
IFontFamily_UUID := win32.IID{0xda20d8ef, 0x812a, 0x4c43, {0x98, 0x02, 0x62, 0xec, 0x4a, 0xbd, 0x7a, 0xdd}}
IFontFamily :: struct #raw_union {
	#subtype ifontlist:       IFontList,
	using ifontfamily_vtable: IFontFamily_VTable,
}
IFontFamily_VTable :: struct {
	using ifontlist_vtable: IFontList_VTable,
	GetFamilyNames:         proc "stdcall" (this: ^IFontFamily, names: ^^ILocalizedStrings) -> HRESULT,
	GetFirstMatchingFont:   proc "stdcall" (this: ^IFontFamily, weight: FONT_WEIGHT, stretch: FONT_STRETCH, style: FONT_STYLE, matchingFont: ^^IFont) -> HRESULT,
	GetMatchingFonts:       proc "stdcall" (this: ^IFontFamily, weight: FONT_WEIGHT, stretch: FONT_STRETCH, style: FONT_STYLE, matchingFonts: ^^IFontList) -> HRESULT,
}


IFont_UUID_STRING := "acd16696-8c14-4f5d-877e-fe3fc1d32737"
IFont_UUID := win32.IID{0xacd16696, 0x8c14, 0x4f5d, {0x87, 0x7e, 0xfe, 0x3f, 0xc1, 0xd3, 0x27, 0x37}}
IFont :: struct #raw_union {
	#subtype iunknown:  IUnknown,
	using ifont_vtable: IFont_VTable,
}
IFont_VTable :: struct {
	using iunknown_vtable:   IUnknown_VTable,
	GetFontFamily:           proc "stdcall" (this: ^IFont, fontFamily: ^^IFontFamily) -> HRESULT,
	GetWeight:               proc "stdcall" (this: ^IFont) -> FONT_WEIGHT,
	GetStretch:              proc "stdcall" (this: ^IFont) -> FONT_STRETCH,
	GetStyle:                proc "stdcall" (this: ^IFont) -> FONT_STYLE,
	IsSymbolFont:            proc "stdcall" (this: ^IFont) -> BOOL,
	GetFaceNames:            proc "stdcall" (this: ^IFont, names: ^^ILocalizedStrings) -> HRESULT,
	GetInformationalStrings: proc "stdcall" (this: ^IFont, informationalStringID: INFORMATIONAL_STRING_ID, informationalStrings: ^^ILocalizedStrings, exists: ^BOOL) -> HRESULT,
	GetSimulations:          proc "stdcall" (this: ^IFont) -> FONT_SIMULATIONS,
	GetMetrics:              proc "stdcall" (this: ^IFont, fontMetrics: ^FONT_METRICS),
	HasCharacter:            proc "stdcall" (this: ^IFont, unicodeValue: u32, exists: ^BOOL) -> HRESULT,
	CreateFontFace:          proc "stdcall" (this: ^IFont, fontFace: ^^IFontFace) -> HRESULT,
}


READING_DIRECTION :: enum i32 {
	LEFT_TO_RIGHT,
	RIGHT_TO_LEFT,
	TOP_TO_BOTTOM,
	BOTTOM_TO_TOP,
}

FLOW_DIRECTION :: enum i32 {
	TOP_TO_BOTTOM,
	BOTTOM_TO_TOP,
	LEFT_TO_RIGHT,
	RIGHT_TO_LEFT,
}

TEXT_ALIGNMENT :: enum i32 {
	LEADING,
	TRAILING,
	CENTER,
	JUSTIFIED,
}

PARAGRAPH_ALIGNMENT :: enum i32 {
	NEAR,
	FAR,
	CENTER,
}

WORD_WRAPPING :: enum i32 {
	WRAP,
	NO_WRAP,
	EMERGENCY_BREAK,
	WHOLE_WORD,
	CHARACTER,
}

LINE_SPACING_METHOD :: enum i32 {
	DEFAULT,
	UNIFORM,
	PROPORTIONAL,
}

TRIMMING_GRANULARITY :: enum i32 {
	NONE,
	CHARACTER,
	WORD,
}

FONT_FEATURE_TAG :: enum u32 {
	ALTERNATIVE_FRACTIONS            = 1668441697,
	PETITE_CAPITALS_FROM_CAPITALS    = 1668297315,
	SMALL_CAPITALS_FROM_CAPITALS     = 1668493923,
	CONTEXTUAL_ALTERNATES            = 1953259875,
	CASE_SENSITIVE_FORMS             = 1702060387,
	GLYPH_COMPOSITION_DECOMPOSITION  = 1886217059,
	CONTEXTUAL_LIGATURES             = 1734962275,
	CAPITAL_SPACING                  = 1886613603,
	CONTEXTUAL_SWASH                 = 1752658787,
	CURSIVE_POSITIONING              = 1936880995,
	DEFAULT                          = 1953261156,
	DISCRETIONARY_LIGATURES          = 1734962276,
	EXPERT_FORMS                     = 1953527909,
	FRACTIONS                        = 1667330662,
	FULL_WIDTH                       = 1684633446,
	HALF_FORMS                       = 1718378856,
	HALANT_FORMS                     = 1852596584,
	ALTERNATE_HALF_WIDTH             = 1953259880,
	HISTORICAL_FORMS                 = 1953720680,
	HORIZONTAL_KANA_ALTERNATES       = 1634626408,
	HISTORICAL_LIGATURES             = 1734962280,
	HALF_WIDTH                       = 1684633448,
	HOJO_KANJI_FORMS                 = 1869246312,
	JIS04_FORMS                      = 875589738,
	JIS78_FORMS                      = 943157354,
	JIS83_FORMS                      = 859336810,
	JIS90_FORMS                      = 809070698,
	KERNING                          = 1852990827,
	STANDARD_LIGATURES               = 1634167148,
	LINING_FIGURES                   = 1836412524,
	LOCALIZED_FORMS                  = 1818455916,
	MARK_POSITIONING                 = 1802658157,
	MATHEMATICAL_GREEK               = 1802659693,
	MARK_TO_MARK_POSITIONING         = 1802333037,
	ALTERNATE_ANNOTATION_FORMS       = 1953259886,
	NLC_KANJI_FORMS                  = 1801677934,
	OLD_STYLE_FIGURES                = 1836412527,
	ORDINALS                         = 1852076655,
	PROPORTIONAL_ALTERNATE_WIDTH     = 1953259888,
	PETITE_CAPITALS                  = 1885430640,
	PROPORTIONAL_FIGURES             = 1836412528,
	PROPORTIONAL_WIDTHS              = 1684633456,
	QUARTER_WIDTHS                   = 1684633457,
	REQUIRED_LIGATURES               = 1734962290,
	RUBY_NOTATION_FORMS              = 2036495730,
	STYLISTIC_ALTERNATES             = 1953259891,
	SCIENTIFIC_INFERIORS             = 1718511987,
	SMALL_CAPITALS                   = 1885564275,
	SIMPLIFIED_FORMS                 = 1819307379,
	STYLISTIC_SET_1                  = 825258867,
	STYLISTIC_SET_2                  = 842036083,
	STYLISTIC_SET_3                  = 858813299,
	STYLISTIC_SET_4                  = 875590515,
	STYLISTIC_SET_5                  = 892367731,
	STYLISTIC_SET_6                  = 909144947,
	STYLISTIC_SET_7                  = 925922163,
	STYLISTIC_SET_8                  = 942699379,
	STYLISTIC_SET_9                  = 959476595,
	STYLISTIC_SET_10                 = 808547187,
	STYLISTIC_SET_11                 = 825324403,
	STYLISTIC_SET_12                 = 842101619,
	STYLISTIC_SET_13                 = 858878835,
	STYLISTIC_SET_14                 = 875656051,
	STYLISTIC_SET_15                 = 892433267,
	STYLISTIC_SET_16                 = 909210483,
	STYLISTIC_SET_17                 = 925987699,
	STYLISTIC_SET_18                 = 942764915,
	STYLISTIC_SET_19                 = 959542131,
	STYLISTIC_SET_20                 = 808612723,
	SUBSCRIPT                        = 1935832435,
	SUPERSCRIPT                      = 1936749939,
	SWASH                            = 1752397683,
	TITLING                          = 1819568500,
	TRADITIONAL_NAME_FORMS           = 1835101812,
	TABULAR_FIGURES                  = 1836412532,
	TRADITIONAL_FORMS                = 1684107892,
	THIRD_WIDTHS                     = 1684633460,
	UNICASE                          = 1667853941,
	VERTICAL_WRITING                 = 1953654134,
	VERTICAL_ALTERNATES_AND_ROTATION = 846492278,
	SLASHED_ZERO                     = 1869768058,
}

TEXT_RANGE :: struct {
	startPosition: u32,
	length:        u32,
}

FONT_FEATURE :: struct {
	nameTag:   FONT_FEATURE_TAG,
	parameter: u32,
}

TYPOGRAPHIC_FEATURES :: struct {
	features:     ^FONT_FEATURE,
	featureCount: u32,
}

TRIMMING :: struct {
	granularity:    TRIMMING_GRANULARITY,
	delimiter:      u32,
	delimiterCount: u32,
}

ITextFormat_UUID_STRING := "9c906818-31d7-4fd3-a151-7c5e225db55a"
ITextFormat_UUID := win32.IID{0x9c906818, 0x31d7, 0x4fd3, {0xa1, 0x51, 0x7c, 0x5e, 0x22, 0x5d, 0xb5, 0x5a}}
ITextFormat :: struct #raw_union {
	#subtype iunknown:        IUnknown,
	using itextformat_vtable: ITextFormat_VTable,
}
ITextFormat_VTable :: struct {
	using iunknown_vtable:   IUnknown_VTable,
	SetTextAlignment:        proc "stdcall" (this: ^ITextFormat, textAlignment: TEXT_ALIGNMENT) -> HRESULT,
	SetParagraphAlignment:   proc "stdcall" (this: ^ITextFormat, paragraphAlignment: PARAGRAPH_ALIGNMENT) -> HRESULT,
	SetWordWrapping:         proc "stdcall" (this: ^ITextFormat, wordWrapping: WORD_WRAPPING) -> HRESULT,
	SetReadingDirection:     proc "stdcall" (this: ^ITextFormat, readingDirection: READING_DIRECTION) -> HRESULT,
	SetFlowDirection:        proc "stdcall" (this: ^ITextFormat, flowDirection: FLOW_DIRECTION) -> HRESULT,
	SetIncrementalTabStop:   proc "stdcall" (this: ^ITextFormat, incrementalTabStop: f32) -> HRESULT,
	SetTrimming:             proc "stdcall" (this: ^ITextFormat, #by_ptr trimmingOptions: TRIMMING, trimmingSign: ^IInlineObject) -> HRESULT,
	SetLineSpacing:          proc "stdcall" (this: ^ITextFormat, lineSpacingMethod: LINE_SPACING_METHOD, lineSpacing: f32, baseline: f32) -> HRESULT,
	GetTextAlignment:        proc "stdcall" (this: ^ITextFormat) -> TEXT_ALIGNMENT,
	GetParagraphAlignment:   proc "stdcall" (this: ^ITextFormat) -> PARAGRAPH_ALIGNMENT,
	GetWordWrapping:         proc "stdcall" (this: ^ITextFormat) -> WORD_WRAPPING,
	GetReadingDirection:     proc "stdcall" (this: ^ITextFormat) -> READING_DIRECTION,
	GetFlowDirection:        proc "stdcall" (this: ^ITextFormat) -> FLOW_DIRECTION,
	GetIncrementalTabStop:   proc "stdcall" (this: ^ITextFormat) -> f32,
	GetTrimming:             proc "stdcall" (this: ^ITextFormat, trimmingOptions: ^TRIMMING, trimmingSign: ^^IInlineObject) -> HRESULT,
	GetLineSpacing:          proc "stdcall" (this: ^ITextFormat, lineSpacingMethod: ^LINE_SPACING_METHOD, lineSpacing: ^f32, baseline: ^f32) -> HRESULT,
	GetFontCollection:       proc "stdcall" (this: ^ITextFormat, fontCollection: ^^IFontCollection) -> HRESULT,
	GetFontFamilyNameLength: proc "stdcall" (this: ^ITextFormat) -> u32,
	GetFontFamilyName:       proc "stdcall" (this: ^ITextFormat, fontFamilyName: [^]u8, nameSize: u32) -> HRESULT,
	GetFontWeight:           proc "stdcall" (this: ^ITextFormat) -> FONT_WEIGHT,
	GetFontStyle:            proc "stdcall" (this: ^ITextFormat) -> FONT_STYLE,
	GetFontStretch:          proc "stdcall" (this: ^ITextFormat) -> FONT_STRETCH,
	GetFontSize:             proc "stdcall" (this: ^ITextFormat) -> f32,
	GetLocaleNameLength:     proc "stdcall" (this: ^ITextFormat) -> u32,
	GetLocaleName:           proc "stdcall" (this: ^ITextFormat, localeName: [^]u8, nameSize: u32) -> HRESULT,
}


ITypography_UUID_STRING := "55f1112b-1dc2-4b3c-9541-f46894ed85b6"
ITypography_UUID := win32.IID{0x55f1112b, 0x1dc2, 0x4b3c, {0x95, 0x41, 0xf4, 0x68, 0x94, 0xed, 0x85, 0xb6}}
ITypography :: struct #raw_union {
	#subtype iunknown:        IUnknown,
	using itypography_vtable: ITypography_VTable,
}
ITypography_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	AddFontFeature:        proc "stdcall" (this: ^ITypography, fontFeature: FONT_FEATURE) -> HRESULT,
	GetFontFeatureCount:   proc "stdcall" (this: ^ITypography) -> u32,
	GetFontFeature:        proc "stdcall" (this: ^ITypography, fontFeatureIndex: u32, fontFeature: ^FONT_FEATURE) -> HRESULT,
}


SCRIPT_SHAPES_Flag :: enum {
	DEFAULT   = 0,
	NO_VISUAL = 1,
}
SCRIPT_SHAPES :: bit_set[SCRIPT_SHAPES_Flag;u32]

SCRIPT_ANALYSIS :: struct {
	script: u16,
	shapes: SCRIPT_SHAPES,
}

BREAK_CONDITION :: enum i32 {
	NEUTRAL,
	CAN_BREAK,
	MAY_NOT_BREAK,
	MUST_BREAK,
}

LINE_BREAKPOINT :: struct {
	_bitfield: u8,
}

NUMBER_SUBSTITUTION_METHOD :: enum i32 {
	FROM_CULTURE,
	CONTEXTUAL,
	NONE,
	NATIONAL,
	TRADITIONAL,
}

INumberSubstitution_UUID_STRING := "14885cc9-bab0-4f90-b6ed-5c366a2cd03d"
INumberSubstitution_UUID := win32.IID{0x14885cc9, 0xbab0, 0x4f90, {0xb6, 0xed, 0x5c, 0x36, 0x6a, 0x2c, 0xd0, 0x3d}}
INumberSubstitution :: struct #raw_union {
	#subtype iunknown:                IUnknown,
	using inumbersubstitution_vtable: INumberSubstitution_VTable,
}
INumberSubstitution_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
}


SHAPING_TEXT_PROPERTIES :: struct {
	_bitfield: u16,
}

SHAPING_GLYPH_PROPERTIES :: struct {
	_bitfield: u16,
}

ITextAnalysisSource_UUID_STRING := "688e1a58-5094-47c8-adc8-fbcea60ae92b"
ITextAnalysisSource_UUID := win32.IID{0x688e1a58, 0x5094, 0x47c8, {0xad, 0xc8, 0xfb, 0xce, 0xa6, 0x0a, 0xe9, 0x2b}}
ITextAnalysisSource :: struct #raw_union {
	#subtype iunknown:                IUnknown,
	using itextanalysissource_vtable: ITextAnalysisSource_VTable,
}
ITextAnalysisSource_VTable :: struct {
	using iunknown_vtable:        IUnknown_VTable,
	GetTextAtPosition:            proc "stdcall" (this: ^ITextAnalysisSource, textPosition: u32, textString: ^[^]u16, textLength: ^u32) -> HRESULT,
	GetTextBeforePosition:        proc "stdcall" (this: ^ITextAnalysisSource, textPosition: u32, textString: ^[^]u16, textLength: ^u32) -> HRESULT,
	GetParagraphReadingDirection: proc "stdcall" (this: ^ITextAnalysisSource) -> READING_DIRECTION,
	GetLocaleName:                proc "stdcall" (this: ^ITextAnalysisSource, textPosition: u32, textLength: ^u32, localeName: ^[^]u16) -> HRESULT,
	GetNumberSubstitution:        proc "stdcall" (this: ^ITextAnalysisSource, textPosition: u32, textLength: ^u32, numberSubstitution: ^^INumberSubstitution) -> HRESULT,
}


ITextAnalysisSink_UUID_STRING := "5810cd44-0ca0-4701-b3fa-bec5182ae4f6"
ITextAnalysisSink_UUID := win32.IID{0x5810cd44, 0x0ca0, 0x4701, {0xb3, 0xfa, 0xbe, 0xc5, 0x18, 0x2a, 0xe4, 0xf6}}
ITextAnalysisSink :: struct #raw_union {
	#subtype iunknown:              IUnknown,
	using itextanalysissink_vtable: ITextAnalysisSink_VTable,
}
ITextAnalysisSink_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	SetScriptAnalysis:     proc "stdcall" (this: ^ITextAnalysisSink, textPosition: u32, textLength: u32, #by_ptr scriptAnalysis: SCRIPT_ANALYSIS) -> HRESULT,
	SetLineBreakpoints:    proc "stdcall" (this: ^ITextAnalysisSink, textPosition: u32, textLength: u32, lineBreakpoints: [^]LINE_BREAKPOINT) -> HRESULT,
	SetBidiLevel:          proc "stdcall" (this: ^ITextAnalysisSink, textPosition: u32, textLength: u32, explicitLevel: u8, resolvedLevel: u8) -> HRESULT,
	SetNumberSubstitution: proc "stdcall" (this: ^ITextAnalysisSink, textPosition: u32, textLength: u32, numberSubstitution: ^INumberSubstitution) -> HRESULT,
}


ITextAnalyzer_UUID_STRING := "b7e6163e-7f46-43b4-84b3-e4e6249c365d"
ITextAnalyzer_UUID := win32.IID{0xb7e6163e, 0x7f46, 0x43b4, {0x84, 0xb3, 0xe4, 0xe6, 0x24, 0x9c, 0x36, 0x5d}}
ITextAnalyzer :: struct #raw_union {
	#subtype iunknown:          IUnknown,
	using itextanalyzer_vtable: ITextAnalyzer_VTable,
}
ITextAnalyzer_VTable :: struct {
	using iunknown_vtable:           IUnknown_VTable,
	AnalyzeScript:                   proc "stdcall" (
		this: ^ITextAnalyzer,
		analysisSource: ^ITextAnalysisSource,
		textPosition: u32,
		textLength: u32,
		analysisSink: ^ITextAnalysisSink,
	) -> HRESULT,
	AnalyzeBidi:                     proc "stdcall" (
		this: ^ITextAnalyzer,
		analysisSource: ^ITextAnalysisSource,
		textPosition: u32,
		textLength: u32,
		analysisSink: ^ITextAnalysisSink,
	) -> HRESULT,
	AnalyzeNumberSubstitution:       proc "stdcall" (
		this: ^ITextAnalyzer,
		analysisSource: ^ITextAnalysisSource,
		textPosition: u32,
		textLength: u32,
		analysisSink: ^ITextAnalysisSink,
	) -> HRESULT,
	AnalyzeLineBreakpoints:          proc "stdcall" (
		this: ^ITextAnalyzer,
		analysisSource: ^ITextAnalysisSource,
		textPosition: u32,
		textLength: u32,
		analysisSink: ^ITextAnalysisSink,
	) -> HRESULT,
	GetGlyphs:                       proc "stdcall" (
		this: ^ITextAnalyzer,
		textString: [^]u8,
		textLength: u32,
		fontFace: ^IFontFace,
		isSideways: BOOL,
		isRightToLeft: BOOL,
		#by_ptr scriptAnalysis: SCRIPT_ANALYSIS,
		localeName: PWSTR,
		numberSubstitution: ^INumberSubstitution,
		features: [^]^TYPOGRAPHIC_FEATURES,
		featureRangeLengths: [^]u32,
		featureRanges: u32,
		maxGlyphCount: u32,
		clusterMap: [^]u16,
		textProps: [^]SHAPING_TEXT_PROPERTIES,
		glyphIndices: [^]u16,
		glyphProps: [^]SHAPING_GLYPH_PROPERTIES,
		actualGlyphCount: ^u32,
	) -> HRESULT,
	GetGlyphPlacements:              proc "stdcall" (
		this: ^ITextAnalyzer,
		textString: [^]u8,
		clusterMap: [^]u16,
		textProps: [^]SHAPING_TEXT_PROPERTIES,
		textLength: u32,
		glyphIndices: [^]u16,
		glyphProps: [^]SHAPING_GLYPH_PROPERTIES,
		glyphCount: u32,
		fontFace: ^IFontFace,
		fontEmSize: f32,
		isSideways: BOOL,
		isRightToLeft: BOOL,
		#by_ptr scriptAnalysis: SCRIPT_ANALYSIS,
		localeName: PWSTR,
		features: [^]^TYPOGRAPHIC_FEATURES,
		featureRangeLengths: [^]u32,
		featureRanges: u32,
		glyphAdvances: [^]f32,
		glyphOffsets: [^]GLYPH_OFFSET,
	) -> HRESULT,
	GetGdiCompatibleGlyphPlacements: proc "stdcall" (
		this: ^ITextAnalyzer,
		textString: [^]u8,
		clusterMap: [^]u16,
		textProps: [^]SHAPING_TEXT_PROPERTIES,
		textLength: u32,
		glyphIndices: [^]u16,
		glyphProps: [^]SHAPING_GLYPH_PROPERTIES,
		glyphCount: u32,
		fontFace: ^IFontFace,
		fontEmSize: f32,
		pixelsPerDip: f32,
		transform: ^MATRIX,
		useGdiNatural: BOOL,
		isSideways: BOOL,
		isRightToLeft: BOOL,
		#by_ptr scriptAnalysis: SCRIPT_ANALYSIS,
		localeName: PWSTR,
		features: [^]^TYPOGRAPHIC_FEATURES,
		featureRangeLengths: [^]u32,
		featureRanges: u32,
		glyphAdvances: [^]f32,
		glyphOffsets: [^]GLYPH_OFFSET,
	) -> HRESULT,
}


GLYPH_RUN :: struct {
	fontFace:      ^IFontFace,
	fontEmSize:    f32,
	glyphCount:    u32,
	glyphIndices:  ^u16,
	glyphAdvances: ^f32,
	glyphOffsets:  ^GLYPH_OFFSET,
	isSideways:    BOOL,
	bidiLevel:     u32,
}

GLYPH_RUN_DESCRIPTION :: struct {
	localeName:   PWSTR,
	string:       PWSTR,
	stringLength: u32,
	clusterMap:   ^u16,
	textPosition: u32,
}

UNDERLINE :: struct {
	width:            f32,
	thickness:        f32,
	offset:           f32,
	runHeight:        f32,
	readingDirection: READING_DIRECTION,
	flowDirection:    FLOW_DIRECTION,
	localeName:       PWSTR,
	measuringMode:    MEASURING_MODE,
}

STRIKETHROUGH :: struct {
	width:            f32,
	thickness:        f32,
	offset:           f32,
	readingDirection: READING_DIRECTION,
	flowDirection:    FLOW_DIRECTION,
	localeName:       PWSTR,
	measuringMode:    MEASURING_MODE,
}

LINE_METRICS :: struct {
	length:                   u32,
	trailingWhitespaceLength: u32,
	newlineLength:            u32,
	height:                   f32,
	baseline:                 f32,
	isTrimmed:                BOOL,
}

CLUSTER_METRICS :: struct {
	width:     f32,
	length:    u16,
	_bitfield: u16,
}

TEXT_METRICS :: struct {
	left:                             f32,
	top:                              f32,
	width:                            f32,
	widthIncludingTrailingWhitespace: f32,
	height:                           f32,
	layoutWidth:                      f32,
	layoutHeight:                     f32,
	maxBidiReorderingDepth:           u32,
	lineCount:                        u32,
}

INLINE_OBJECT_METRICS :: struct {
	width:            f32,
	height:           f32,
	baseline:         f32,
	supportsSideways: BOOL,
}

OVERHANG_METRICS :: struct {
	left:   f32,
	top:    f32,
	right:  f32,
	bottom: f32,
}

HIT_TEST_METRICS :: struct {
	textPosition: u32,
	length:       u32,
	left:         f32,
	top:          f32,
	width:        f32,
	height:       f32,
	bidiLevel:    u32,
	isText:       BOOL,
	isTrimmed:    BOOL,
}

IInlineObject_UUID_STRING := "8339fde3-106f-47ab-8373-1c6295eb10b3"
IInlineObject_UUID := win32.IID{0x8339fde3, 0x106f, 0x47ab, {0x83, 0x73, 0x1c, 0x62, 0x95, 0xeb, 0x10, 0xb3}}
IInlineObject :: struct #raw_union {
	#subtype iunknown:          IUnknown,
	using iinlineobject_vtable: IInlineObject_VTable,
}
IInlineObject_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	Draw:                  proc "stdcall" (
		this: ^IInlineObject,
		clientDrawingContext: rawptr,
		renderer: ^ITextRenderer,
		originX: f32,
		originY: f32,
		isSideways: BOOL,
		isRightToLeft: BOOL,
		clientDrawingEffect: ^IUnknown,
	) -> HRESULT,
	GetMetrics:            proc "stdcall" (this: ^IInlineObject, metrics: ^INLINE_OBJECT_METRICS) -> HRESULT,
	GetOverhangMetrics:    proc "stdcall" (this: ^IInlineObject, overhangs: ^OVERHANG_METRICS) -> HRESULT,
	GetBreakConditions:    proc "stdcall" (this: ^IInlineObject, breakConditionBefore: ^BREAK_CONDITION, breakConditionAfter: ^BREAK_CONDITION) -> HRESULT,
}


IPixelSnapping_UUID_STRING := "eaf3a2da-ecf4-4d24-b644-b34f6842024b"
IPixelSnapping_UUID := win32.IID{0xeaf3a2da, 0xecf4, 0x4d24, {0xb6, 0x44, 0xb3, 0x4f, 0x68, 0x42, 0x02, 0x4b}}
IPixelSnapping :: struct #raw_union {
	#subtype iunknown:           IUnknown,
	using ipixelsnapping_vtable: IPixelSnapping_VTable,
}
IPixelSnapping_VTable :: struct {
	using iunknown_vtable:   IUnknown_VTable,
	IsPixelSnappingDisabled: proc "stdcall" (this: ^IPixelSnapping, clientDrawingContext: rawptr, isDisabled: ^BOOL) -> HRESULT,
	GetCurrentTransform:     proc "stdcall" (this: ^IPixelSnapping, clientDrawingContext: rawptr, transform: ^MATRIX) -> HRESULT,
	GetPixelsPerDip:         proc "stdcall" (this: ^IPixelSnapping, clientDrawingContext: rawptr, pixelsPerDip: ^f32) -> HRESULT,
}


ITextRenderer_UUID_STRING := "ef8a8135-5cc6-45fe-8825-c5a0724eb819"
ITextRenderer_UUID := win32.IID{0xef8a8135, 0x5cc6, 0x45fe, {0x88, 0x25, 0xc5, 0xa0, 0x72, 0x4e, 0xb8, 0x19}}
ITextRenderer :: struct #raw_union {
	#subtype ipixelsnapping:    IPixelSnapping,
	using itextrenderer_vtable: ITextRenderer_VTable,
}
ITextRenderer_VTable :: struct {
	using ipixelsnapping_vtable: IPixelSnapping_VTable,
	DrawGlyphRun:                proc "stdcall" (
		this: ^ITextRenderer,
		clientDrawingContext: rawptr,
		baselineOriginX: f32,
		baselineOriginY: f32,
		measuringMode: MEASURING_MODE,
		#by_ptr glyphRun: GLYPH_RUN,
		#by_ptr glyphRunDescription: GLYPH_RUN_DESCRIPTION,
		clientDrawingEffect: ^IUnknown,
	) -> HRESULT,
	DrawUnderline:               proc "stdcall" (
		this: ^ITextRenderer,
		clientDrawingContext: rawptr,
		baselineOriginX: f32,
		baselineOriginY: f32,
		#by_ptr underline: UNDERLINE,
		clientDrawingEffect: ^IUnknown,
	) -> HRESULT,
	DrawStrikethrough:           proc "stdcall" (
		this: ^ITextRenderer,
		clientDrawingContext: rawptr,
		baselineOriginX: f32,
		baselineOriginY: f32,
		#by_ptr strikethrough: STRIKETHROUGH,
		clientDrawingEffect: ^IUnknown,
	) -> HRESULT,
	DrawInlineObject:            proc "stdcall" (
		this: ^ITextRenderer,
		clientDrawingContext: rawptr,
		originX: f32,
		originY: f32,
		inlineObject: ^IInlineObject,
		isSideways: BOOL,
		isRightToLeft: BOOL,
		clientDrawingEffect: ^IUnknown,
	) -> HRESULT,
}


ITextLayout_UUID_STRING := "53737037-6d14-410b-9bfe-0b182bb70961"
ITextLayout_UUID := win32.IID{0x53737037, 0x6d14, 0x410b, {0x9b, 0xfe, 0x0b, 0x18, 0x2b, 0xb7, 0x09, 0x61}}
ITextLayout :: struct #raw_union {
	#subtype itextformat:     ITextFormat,
	using itextlayout_vtable: ITextLayout_VTable,
}
ITextLayout_VTable :: struct {
	using itextformat_vtable:  ITextFormat_VTable,
	SetMaxWidth:               proc "stdcall" (this: ^ITextLayout, maxWidth: f32) -> HRESULT,
	SetMaxHeight:              proc "stdcall" (this: ^ITextLayout, maxHeight: f32) -> HRESULT,
	SetFontCollection:         proc "stdcall" (this: ^ITextLayout, fontCollection: ^IFontCollection, textRange: TEXT_RANGE) -> HRESULT,
	SetFontFamilyName:         proc "stdcall" (this: ^ITextLayout, fontFamilyName: PWSTR, textRange: TEXT_RANGE) -> HRESULT,
	SetFontWeight:             proc "stdcall" (this: ^ITextLayout, fontWeight: FONT_WEIGHT, textRange: TEXT_RANGE) -> HRESULT,
	SetFontStyle:              proc "stdcall" (this: ^ITextLayout, fontStyle: FONT_STYLE, textRange: TEXT_RANGE) -> HRESULT,
	SetFontStretch:            proc "stdcall" (this: ^ITextLayout, fontStretch: FONT_STRETCH, textRange: TEXT_RANGE) -> HRESULT,
	SetFontSize:               proc "stdcall" (this: ^ITextLayout, fontSize: f32, textRange: TEXT_RANGE) -> HRESULT,
	SetUnderline:              proc "stdcall" (this: ^ITextLayout, hasUnderline: BOOL, textRange: TEXT_RANGE) -> HRESULT,
	SetStrikethrough:          proc "stdcall" (this: ^ITextLayout, hasStrikethrough: BOOL, textRange: TEXT_RANGE) -> HRESULT,
	SetDrawingEffect:          proc "stdcall" (this: ^ITextLayout, drawingEffect: ^IUnknown, textRange: TEXT_RANGE) -> HRESULT,
	SetInlineObject:           proc "stdcall" (this: ^ITextLayout, inlineObject: ^IInlineObject, textRange: TEXT_RANGE) -> HRESULT,
	SetTypography:             proc "stdcall" (this: ^ITextLayout, typography: ^ITypography, textRange: TEXT_RANGE) -> HRESULT,
	SetLocaleName:             proc "stdcall" (this: ^ITextLayout, localeName: PWSTR, textRange: TEXT_RANGE) -> HRESULT,
	GetMaxWidth:               proc "stdcall" (this: ^ITextLayout) -> f32,
	GetMaxHeight:              proc "stdcall" (this: ^ITextLayout) -> f32,
	GetFontCollection_1:       proc "stdcall" (this: ^ITextLayout, currentPosition: u32, fontCollection: ^^IFontCollection, textRange: ^TEXT_RANGE) -> HRESULT,
	GetFontFamilyNameLength_1: proc "stdcall" (this: ^ITextLayout, currentPosition: u32, nameLength: ^u32, textRange: ^TEXT_RANGE) -> HRESULT,
	GetFontFamilyName_1:       proc "stdcall" (this: ^ITextLayout, currentPosition: u32, fontFamilyName: [^]u8, nameSize: u32, textRange: ^TEXT_RANGE) -> HRESULT,
	GetFontWeight_1:           proc "stdcall" (this: ^ITextLayout, currentPosition: u32, fontWeight: ^FONT_WEIGHT, textRange: ^TEXT_RANGE) -> HRESULT,
	GetFontStyle_1:            proc "stdcall" (this: ^ITextLayout, currentPosition: u32, fontStyle: ^FONT_STYLE, textRange: ^TEXT_RANGE) -> HRESULT,
	GetFontStretch_1:          proc "stdcall" (this: ^ITextLayout, currentPosition: u32, fontStretch: ^FONT_STRETCH, textRange: ^TEXT_RANGE) -> HRESULT,
	GetFontSize_1:             proc "stdcall" (this: ^ITextLayout, currentPosition: u32, fontSize: ^f32, textRange: ^TEXT_RANGE) -> HRESULT,
	GetUnderline:              proc "stdcall" (this: ^ITextLayout, currentPosition: u32, hasUnderline: ^BOOL, textRange: ^TEXT_RANGE) -> HRESULT,
	GetStrikethrough:          proc "stdcall" (this: ^ITextLayout, currentPosition: u32, hasStrikethrough: ^BOOL, textRange: ^TEXT_RANGE) -> HRESULT,
	GetDrawingEffect:          proc "stdcall" (this: ^ITextLayout, currentPosition: u32, drawingEffect: ^^IUnknown, textRange: ^TEXT_RANGE) -> HRESULT,
	GetInlineObject:           proc "stdcall" (this: ^ITextLayout, currentPosition: u32, inlineObject: ^^IInlineObject, textRange: ^TEXT_RANGE) -> HRESULT,
	GetTypography:             proc "stdcall" (this: ^ITextLayout, currentPosition: u32, typography: ^^ITypography, textRange: ^TEXT_RANGE) -> HRESULT,
	GetLocaleNameLength_1:     proc "stdcall" (this: ^ITextLayout, currentPosition: u32, nameLength: ^u32, textRange: ^TEXT_RANGE) -> HRESULT,
	GetLocaleName_1:           proc "stdcall" (this: ^ITextLayout, currentPosition: u32, localeName: [^]u8, nameSize: u32, textRange: ^TEXT_RANGE) -> HRESULT,
	Draw:                      proc "stdcall" (this: ^ITextLayout, clientDrawingContext: rawptr, renderer: ^ITextRenderer, originX: f32, originY: f32) -> HRESULT,
	GetLineMetrics:            proc "stdcall" (this: ^ITextLayout, lineMetrics: [^]LINE_METRICS, maxLineCount: u32, actualLineCount: ^u32) -> HRESULT,
	GetMetrics:                proc "stdcall" (this: ^ITextLayout, textMetrics: ^TEXT_METRICS) -> HRESULT,
	GetOverhangMetrics:        proc "stdcall" (this: ^ITextLayout, overhangs: ^OVERHANG_METRICS) -> HRESULT,
	GetClusterMetrics:         proc "stdcall" (this: ^ITextLayout, clusterMetrics: [^]CLUSTER_METRICS, maxClusterCount: u32, actualClusterCount: ^u32) -> HRESULT,
	DetermineMinWidth:         proc "stdcall" (this: ^ITextLayout, minWidth: ^f32) -> HRESULT,
	HitTestPoint:              proc "stdcall" (this: ^ITextLayout, pointX: f32, pointY: f32, isTrailingHit: ^BOOL, isInside: ^BOOL, hitTestMetrics: ^HIT_TEST_METRICS) -> HRESULT,
	HitTestTextPosition:       proc "stdcall" (this: ^ITextLayout, textPosition: u32, isTrailingHit: BOOL, pointX: ^f32, pointY: ^f32, hitTestMetrics: ^HIT_TEST_METRICS) -> HRESULT,
	HitTestTextRange:          proc "stdcall" (
		this: ^ITextLayout,
		textPosition: u32,
		textLength: u32,
		originX: f32,
		originY: f32,
		hitTestMetrics: [^]HIT_TEST_METRICS,
		maxHitTestMetricsCount: u32,
		actualHitTestMetricsCount: ^u32,
	) -> HRESULT,
}


IBitmapRenderTarget_UUID_STRING := "5e5a32a3-8dff-4773-9ff6-0696eab77267"
IBitmapRenderTarget_UUID := win32.IID{0x5e5a32a3, 0x8dff, 0x4773, {0x9f, 0xf6, 0x06, 0x96, 0xea, 0xb7, 0x72, 0x67}}
IBitmapRenderTarget :: struct #raw_union {
	#subtype iunknown:                IUnknown,
	using ibitmaprendertarget_vtable: IBitmapRenderTarget_VTable,
}
IBitmapRenderTarget_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	DrawGlyphRun:          proc "stdcall" (
		this: ^IBitmapRenderTarget,
		baselineOriginX: f32,
		baselineOriginY: f32,
		measuringMode: MEASURING_MODE,
		#by_ptr glyphRun: GLYPH_RUN,
		renderingParams: ^IRenderingParams,
		textColor: u32,
		blackBoxRect: ^RECT,
	) -> HRESULT,
	GetMemoryDC:           proc "stdcall" (this: ^IBitmapRenderTarget) -> HDC,
	GetPixelsPerDip:       proc "stdcall" (this: ^IBitmapRenderTarget) -> f32,
	SetPixelsPerDip:       proc "stdcall" (this: ^IBitmapRenderTarget, pixelsPerDip: f32) -> HRESULT,
	GetCurrentTransform:   proc "stdcall" (this: ^IBitmapRenderTarget, transform: ^MATRIX) -> HRESULT,
	SetCurrentTransform:   proc "stdcall" (this: ^IBitmapRenderTarget, transform: ^MATRIX) -> HRESULT,
	GetSize:               proc "stdcall" (this: ^IBitmapRenderTarget, size: ^SIZE) -> HRESULT,
	Resize:                proc "stdcall" (this: ^IBitmapRenderTarget, width: u32, height: u32) -> HRESULT,
}


IGdiInterop_UUID_STRING := "1edd9491-9853-4299-898f-6432983b6f3a"
IGdiInterop_UUID := win32.IID{0x1edd9491, 0x9853, 0x4299, {0x89, 0x8f, 0x64, 0x32, 0x98, 0x3b, 0x6f, 0x3a}}
IGdiInterop :: struct #raw_union {
	#subtype iunknown:        IUnknown,
	using igdiinterop_vtable: IGdiInterop_VTable,
}
IGdiInterop_VTable :: struct {
	using iunknown_vtable:    IUnknown_VTable,
	CreateFontFromLOGFONT:    proc "stdcall" (this: ^IGdiInterop, #by_ptr logFont: LOGFONTW, font: ^^IFont) -> HRESULT,
	ConvertFontToLOGFONT:     proc "stdcall" (this: ^IGdiInterop, font: ^IFont, logFont: ^LOGFONTW, isSystemFont: ^BOOL) -> HRESULT,
	ConvertFontFaceToLOGFONT: proc "stdcall" (this: ^IGdiInterop, font: ^IFontFace, logFont: ^LOGFONTW) -> HRESULT,
	CreateFontFaceFromHdc:    proc "stdcall" (this: ^IGdiInterop, hdc: HDC, fontFace: ^^IFontFace) -> HRESULT,
	CreateBitmapRenderTarget: proc "stdcall" (this: ^IGdiInterop, hdc: HDC, width: u32, height: u32, renderTarget: ^^IBitmapRenderTarget) -> HRESULT,
}


TEXTURE_TYPE :: enum i32 {
	ALIASED_1x1,
	CLEARTYPE_3x1,
}

IGlyphRunAnalysis_UUID_STRING := "7d97dbf7-e085-42d4-81e3-6a883bded118"
IGlyphRunAnalysis_UUID := win32.IID{0x7d97dbf7, 0xe085, 0x42d4, {0x81, 0xe3, 0x6a, 0x88, 0x3b, 0xde, 0xd1, 0x18}}
IGlyphRunAnalysis :: struct #raw_union {
	#subtype iunknown:              IUnknown,
	using iglyphrunanalysis_vtable: IGlyphRunAnalysis_VTable,
}
IGlyphRunAnalysis_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	GetAlphaTextureBounds: proc "stdcall" (this: ^IGlyphRunAnalysis, textureType: TEXTURE_TYPE, textureBounds: ^RECT) -> HRESULT,
	CreateAlphaTexture:    proc "stdcall" (this: ^IGlyphRunAnalysis, textureType: TEXTURE_TYPE, #by_ptr textureBounds: RECT, alphaValues: ^u8, bufferSize: u32) -> HRESULT,
	GetAlphaBlendParams:   proc "stdcall" (
		this: ^IGlyphRunAnalysis,
		renderingParams: ^IRenderingParams,
		blendGamma: ^f32,
		blendEnhancedContrast: ^f32,
		blendClearTypeLevel: ^f32,
	) -> HRESULT,
}


IFactory_UUID_STRING := "b859ee5a-d838-4b5b-a2e8-1adc7d93db48"
IFactory_UUID := win32.IID{0xb859ee5a, 0xd838, 0x4b5b, {0xa2, 0xe8, 0x1a, 0xdc, 0x7d, 0x93, 0xdb, 0x48}}
IFactory :: struct #raw_union {
	#subtype iunknown:     IUnknown,
	using ifactory_vtable: IFactory_VTable,
}
IFactory_VTable :: struct {
	using iunknown_vtable:          IUnknown_VTable,
	GetSystemFontCollection:        proc "stdcall" (this: ^IFactory, fontCollection: ^^IFontCollection, checkForUpdates: BOOL) -> HRESULT,
	CreateCustomFontCollection:     proc "stdcall" (
		this: ^IFactory,
		collectionLoader: ^IFontCollectionLoader,
		collectionKey: rawptr,
		collectionKeySize: u32,
		fontCollection: ^^IFontCollection,
	) -> HRESULT,
	RegisterFontCollectionLoader:   proc "stdcall" (this: ^IFactory, fontCollectionLoader: ^IFontCollectionLoader) -> HRESULT,
	UnregisterFontCollectionLoader: proc "stdcall" (this: ^IFactory, fontCollectionLoader: ^IFontCollectionLoader) -> HRESULT,
	CreateFontFileReference:        proc "stdcall" (this: ^IFactory, filePath: PWSTR, lastWriteTime: ^FILETIME, fontFile: ^^IFontFile) -> HRESULT,
	CreateCustomFontFileReference:  proc "stdcall" (
		this: ^IFactory,
		fontFileReferenceKey: rawptr,
		fontFileReferenceKeySize: u32,
		fontFileLoader: ^IFontFileLoader,
		fontFile: ^^IFontFile,
	) -> HRESULT,
	CreateFontFace:                 proc "stdcall" (
		this: ^IFactory,
		fontFaceType: FONT_FACE_TYPE,
		numberOfFiles: u32,
		fontFiles: [^]^IFontFile,
		faceIndex: u32,
		fontFaceSimulationFlags: FONT_SIMULATIONS,
		fontFace: ^^IFontFace,
	) -> HRESULT,
	CreateRenderingParams:          proc "stdcall" (this: ^IFactory, renderingParams: ^^IRenderingParams) -> HRESULT,
	CreateMonitorRenderingParams:   proc "stdcall" (this: ^IFactory, monitor: HMONITOR, renderingParams: ^^IRenderingParams) -> HRESULT,
	CreateCustomRenderingParams:    proc "stdcall" (
		this: ^IFactory,
		gamma: f32,
		enhancedContrast: f32,
		clearTypeLevel: f32,
		pixelGeometry: PIXEL_GEOMETRY,
		renderingMode: RENDERING_MODE,
		renderingParams: ^^IRenderingParams,
	) -> HRESULT,
	RegisterFontFileLoader:         proc "stdcall" (this: ^IFactory, fontFileLoader: ^IFontFileLoader) -> HRESULT,
	UnregisterFontFileLoader:       proc "stdcall" (this: ^IFactory, fontFileLoader: ^IFontFileLoader) -> HRESULT,
	CreateTextFormat:               proc "stdcall" (
		this: ^IFactory,
		fontFamilyName: PWSTR,
		fontCollection: ^IFontCollection,
		fontWeight: FONT_WEIGHT,
		fontStyle: FONT_STYLE,
		fontStretch: FONT_STRETCH,
		fontSize: f32,
		localeName: PWSTR,
		textFormat: ^^ITextFormat,
	) -> HRESULT,
	CreateTypography:               proc "stdcall" (this: ^IFactory, typography: ^^ITypography) -> HRESULT,
	GetGdiInterop:                  proc "stdcall" (this: ^IFactory, gdiInterop: ^^IGdiInterop) -> HRESULT,
	CreateTextLayout:               proc "stdcall" (
		this: ^IFactory,
		string: [^]win32.WCHAR,
		stringLength: win32.UINT32,
		textFormat: ^ITextFormat,
		maxWidth: f32,
		maxHeight: f32,
		textLayout: ^^ITextLayout,
	) -> HRESULT,
	CreateGdiCompatibleTextLayout:  proc "stdcall" (
		this: ^IFactory,
		string: [^]win32.WCHAR,
		stringLength: u32,
		textFormat: ^ITextFormat,
		layoutWidth: f32,
		layoutHeight: f32,
		pixelsPerDip: f32,
		transform: ^MATRIX,
		useGdiNatural: win32.BOOL,
		textLayout: ^^ITextLayout,
	) -> HRESULT,
	CreateEllipsisTrimmingSign:     proc "stdcall" (this: ^IFactory, textFormat: ^ITextFormat, trimmingSign: ^^IInlineObject) -> HRESULT,
	CreateTextAnalyzer:             proc "stdcall" (this: ^IFactory, textAnalyzer: ^^ITextAnalyzer) -> HRESULT,
	CreateNumberSubstitution:       proc "stdcall" (
		this: ^IFactory,
		substitutionMethod: NUMBER_SUBSTITUTION_METHOD,
		localeName: win32.PCWSTR,
		ignoreUserOverride: BOOL,
		numberSubstitution: ^^INumberSubstitution,
	) -> HRESULT,
	CreateGlyphRunAnalysis:         proc "stdcall" (
		this: ^IFactory,
		#by_ptr glyphRun: GLYPH_RUN,
		pixelsPerDip: f32,
		transform: ^MATRIX,
		renderingMode: RENDERING_MODE,
		measuringMode: MEASURING_MODE,
		baselineOriginX: f32,
		baselineOriginY: f32,
		glyphRunAnalysis: ^^IGlyphRunAnalysis,
	) -> HRESULT,
}


PANOSE_FAMILY :: enum i32 {
	ANY          = 0,
	NO_FIT       = 1,
	TEXT_DISPLAY = 2,
	SCRIPT       = 3,
	DECORATIVE   = 4,
	SYMBOL       = 5,
	PICTORIAL    = 5,
}

PANOSE_SERIF_STYLE :: enum i32 {
	ANY                = 0,
	NO_FIT             = 1,
	COVE               = 2,
	OBTUSE_COVE        = 3,
	SQUARE_COVE        = 4,
	OBTUSE_SQUARE_COVE = 5,
	SQUARE             = 6,
	THIN               = 7,
	OVAL               = 8,
	EXAGGERATED        = 9,
	TRIANGLE           = 10,
	NORMAL_SANS        = 11,
	OBTUSE_SANS        = 12,
	PERPENDICULAR_SANS = 13,
	FLARED             = 14,
	ROUNDED            = 15,
	SCRIPT             = 16,
	PERP_SANS          = 13,
	BONE               = 8,
}

PANOSE_WEIGHT :: enum i32 {
	ANY         = 0,
	NO_FIT      = 1,
	VERY_LIGHT  = 2,
	LIGHT       = 3,
	THIN        = 4,
	BOOK        = 5,
	MEDIUM      = 6,
	DEMI        = 7,
	BOLD        = 8,
	HEAVY       = 9,
	BLACK       = 10,
	EXTRA_BLACK = 11,
	NORD        = 11,
}

PANOSE_PROPORTION :: enum i32 {
	ANY,
	NO_FIT,
	OLD_STYLE,
	MODERN,
	EVEN_WIDTH,
	EXPANDED,
	CONDENSED,
	VERY_EXPANDED,
	VERY_CONDENSED,
	MONOSPACED,
}

PANOSE_CONTRAST :: enum i32 {
	ANY,
	NO_FIT,
	NONE,
	VERY_LOW,
	LOW,
	MEDIUM_LOW,
	MEDIUM,
	MEDIUM_HIGH,
	HIGH,
	VERY_HIGH,
	HORIZONTAL_LOW,
	HORIZONTAL_MEDIUM,
	HORIZONTAL_HIGH,
	BROKEN,
}

PANOSE_STROKE_VARIATION :: enum i32 {
	ANY,
	NO_FIT,
	NO_VARIATION,
	GRADUAL_DIAGONAL,
	GRADUAL_TRANSITIONAL,
	GRADUAL_VERTICAL,
	GRADUAL_HORIZONTAL,
	RAPID_VERTICAL,
	RAPID_HORIZONTAL,
	INSTANT_VERTICAL,
	INSTANT_HORIZONTAL,
}

PANOSE_ARM_STYLE :: enum i32 {
	ANY                           = 0,
	NO_FIT                        = 1,
	STRAIGHT_ARMS_HORIZONTAL      = 2,
	STRAIGHT_ARMS_WEDGE           = 3,
	STRAIGHT_ARMS_VERTICAL        = 4,
	STRAIGHT_ARMS_SINGLE_SERIF    = 5,
	STRAIGHT_ARMS_DOUBLE_SERIF    = 6,
	NONSTRAIGHT_ARMS_HORIZONTAL   = 7,
	NONSTRAIGHT_ARMS_WEDGE        = 8,
	NONSTRAIGHT_ARMS_VERTICAL     = 9,
	NONSTRAIGHT_ARMS_SINGLE_SERIF = 10,
	NONSTRAIGHT_ARMS_DOUBLE_SERIF = 11,
	STRAIGHT_ARMS_HORZ            = 2,
	STRAIGHT_ARMS_VERT            = 4,
	BENT_ARMS_HORZ                = 7,
	BENT_ARMS_WEDGE               = 8,
	BENT_ARMS_VERT                = 9,
	BENT_ARMS_SINGLE_SERIF        = 10,
	BENT_ARMS_DOUBLE_SERIF        = 11,
}

PANOSE_LETTERFORM :: enum i32 {
	ANY,
	NO_FIT,
	NORMAL_CONTACT,
	NORMAL_WEIGHTED,
	NORMAL_BOXED,
	NORMAL_FLATTENED,
	NORMAL_ROUNDED,
	NORMAL_OFF_CENTER,
	NORMAL_SQUARE,
	OBLIQUE_CONTACT,
	OBLIQUE_WEIGHTED,
	OBLIQUE_BOXED,
	OBLIQUE_FLATTENED,
	OBLIQUE_ROUNDED,
	OBLIQUE_OFF_CENTER,
	OBLIQUE_SQUARE,
}

PANOSE_MIDLINE :: enum i32 {
	ANY,
	NO_FIT,
	STANDARD_TRIMMED,
	STANDARD_POINTED,
	STANDARD_SERIFED,
	HIGH_TRIMMED,
	HIGH_POINTED,
	HIGH_SERIFED,
	CONSTANT_TRIMMED,
	CONSTANT_POINTED,
	CONSTANT_SERIFED,
	LOW_TRIMMED,
	LOW_POINTED,
	LOW_SERIFED,
}

PANOSE_XHEIGHT :: enum i32 {
	ANY               = 0,
	NO_FIT            = 1,
	CONSTANT_SMALL    = 2,
	CONSTANT_STANDARD = 3,
	CONSTANT_LARGE    = 4,
	DUCKING_SMALL     = 5,
	DUCKING_STANDARD  = 6,
	DUCKING_LARGE     = 7,
	CONSTANT_STD      = 3,
	DUCKING_STD       = 6,
}

PANOSE_TOOL_KIND :: enum i32 {
	ANY,
	NO_FIT,
	FLAT_NIB,
	PRESSURE_POINT,
	ENGRAVED,
	BALL,
	BRUSH,
	ROUGH,
	FELT_PEN_BRUSH_TIP,
	WILD_BRUSH,
}

PANOSE_SPACING :: enum i32 {
	ANY,
	NO_FIT,
	PROPORTIONAL_SPACED,
	MONOSPACED,
}

PANOSE_ASPECT_RATIO :: enum i32 {
	ANY,
	NO_FIT,
	VERY_CONDENSED,
	CONDENSED,
	NORMAL,
	EXPANDED,
	VERY_EXPANDED,
}

PANOSE_SCRIPT_TOPOLOGY :: enum i32 {
	ANY,
	NO_FIT,
	ROMAN_DISCONNECTED,
	ROMAN_TRAILING,
	ROMAN_CONNECTED,
	CURSIVE_DISCONNECTED,
	CURSIVE_TRAILING,
	CURSIVE_CONNECTED,
	BLACKLETTER_DISCONNECTED,
	BLACKLETTER_TRAILING,
	BLACKLETTER_CONNECTED,
}

PANOSE_SCRIPT_FORM :: enum i32 {
	ANY,
	NO_FIT,
	UPRIGHT_NO_WRAPPING,
	UPRIGHT_SOME_WRAPPING,
	UPRIGHT_MORE_WRAPPING,
	UPRIGHT_EXTREME_WRAPPING,
	OBLIQUE_NO_WRAPPING,
	OBLIQUE_SOME_WRAPPING,
	OBLIQUE_MORE_WRAPPING,
	OBLIQUE_EXTREME_WRAPPING,
	EXAGGERATED_NO_WRAPPING,
	EXAGGERATED_SOME_WRAPPING,
	EXAGGERATED_MORE_WRAPPING,
	EXAGGERATED_EXTREME_WRAPPING,
}

PANOSE_FINIALS :: enum i32 {
	ANY,
	NO_FIT,
	NONE_NO_LOOPS,
	NONE_CLOSED_LOOPS,
	NONE_OPEN_LOOPS,
	SHARP_NO_LOOPS,
	SHARP_CLOSED_LOOPS,
	SHARP_OPEN_LOOPS,
	TAPERED_NO_LOOPS,
	TAPERED_CLOSED_LOOPS,
	TAPERED_OPEN_LOOPS,
	ROUND_NO_LOOPS,
	ROUND_CLOSED_LOOPS,
	ROUND_OPEN_LOOPS,
}

PANOSE_XASCENT :: enum i32 {
	ANY,
	NO_FIT,
	VERY_LOW,
	LOW,
	MEDIUM,
	HIGH,
	VERY_HIGH,
}

PANOSE_DECORATIVE_CLASS :: enum i32 {
	ANY,
	NO_FIT,
	DERIVATIVE,
	NONSTANDARD_TOPOLOGY,
	NONSTANDARD_ELEMENTS,
	NONSTANDARD_ASPECT,
	INITIALS,
	CARTOON,
	PICTURE_STEMS,
	ORNAMENTED,
	TEXT_AND_BACKGROUND,
	COLLAGE,
	MONTAGE,
}

PANOSE_ASPECT :: enum i32 {
	ANY,
	NO_FIT,
	SUPER_CONDENSED,
	VERY_CONDENSED,
	CONDENSED,
	NORMAL,
	EXTENDED,
	VERY_EXTENDED,
	SUPER_EXTENDED,
	MONOSPACED,
}

PANOSE_FILL :: enum i32 {
	ANY,
	NO_FIT,
	STANDARD_SOLID_FILL,
	NO_FILL,
	PATTERNED_FILL,
	COMPLEX_FILL,
	SHAPED_FILL,
	DRAWN_DISTRESSED,
}

PANOSE_LINING :: enum i32 {
	ANY,
	NO_FIT,
	NONE,
	INLINE,
	OUTLINE,
	ENGRAVED,
	SHADOW,
	RELIEF,
	BACKDROP,
}

PANOSE_DECORATIVE_TOPOLOGY :: enum i32 {
	ANY,
	NO_FIT,
	STANDARD,
	SQUARE,
	MULTIPLE_SEGMENT,
	ART_DECO,
	UNEVEN_WEIGHTING,
	DIVERSE_ARMS,
	DIVERSE_FORMS,
	LOMBARDIC_FORMS,
	UPPER_CASE_IN_LOWER_CASE,
	IMPLIED_TOPOLOGY,
	HORSESHOE_E_AND_A,
	CURSIVE,
	BLACKLETTER,
	SWASH_VARIANCE,
}

PANOSE_CHARACTER_RANGES :: enum i32 {
	ANY,
	NO_FIT,
	EXTENDED_COLLECTION,
	LITERALS,
	NO_LOWER_CASE,
	SMALL_CAPS,
}

PANOSE_SYMBOL_KIND :: enum i32 {
	ANY,
	NO_FIT,
	MONTAGES,
	PICTURES,
	SHAPES,
	SCIENTIFIC,
	MUSIC,
	EXPERT,
	PATTERNS,
	BOARDERS,
	ICONS,
	LOGOS,
	INDUSTRY_SPECIFIC,
}

PANOSE_SYMBOL_ASPECT_RATIO :: enum i32 {
	ANY,
	NO_FIT,
	NO_WIDTH,
	EXCEPTIONALLY_WIDE,
	SUPER_WIDE,
	VERY_WIDE,
	WIDE,
	NORMAL,
	NARROW,
	VERY_NARROW,
}

OUTLINE_THRESHOLD :: enum i32 {
	ANTIALIASED,
	ALIASED,
}

BASELINE :: enum i32 {
	DEFAULT,
	ROMAN,
	CENTRAL,
	MATH,
	HANGING,
	IDEOGRAPHIC_BOTTOM,
	IDEOGRAPHIC_TOP,
	MINIMUM,
	MAXIMUM,
}

VERTICAL_GLYPH_ORIENTATION :: enum i32 {
	DEFAULT,
	STACKED,
}

GLYPH_ORIENTATION_ANGLE :: enum i32 {
	_0_DEGREES,
	_90_DEGREES,
	_180_DEGREES,
	_270_DEGREES,
}

FONT_METRICS1 :: struct {
	__AnonymousBase_1_L627_C38: FONT_METRICS,
	glyphBoxLeft:               i16,
	glyphBoxTop:                i16,
	glyphBoxRight:              i16,
	glyphBoxBottom:             i16,
	subscriptPositionX:         i16,
	subscriptPositionY:         i16,
	subscriptSizeX:             i16,
	subscriptSizeY:             i16,
	superscriptPositionX:       i16,
	superscriptPositionY:       i16,
	superscriptSizeX:           i16,
	superscriptSizeY:           i16,
	hasTypographicMetrics:      BOOL,
}

CARET_METRICS :: struct {
	slopeRise: i16,
	slopeRun:  i16,
	offset:    i16,
}

PANOSE :: struct #raw_union {} //TODO

UNICODE_RANGE :: struct {
	first: u32,
	last:  u32,
}

SCRIPT_PROPERTIES :: struct {
	isoScriptCode:          u32,
	isoScriptNumber:        u32,
	clusterLookahead:       u32,
	justificationCharacter: u32,
	_bitfield:              u32,
}

JUSTIFICATION_OPPORTUNITY :: struct {
	expansionMinimum:   f32,
	expansionMaximum:   f32,
	compressionMaximum: f32,
	_bitfield:          u32,
}

IFactory1_UUID_STRING := "30572f99-dac6-41db-a16e-0486307e606a"
IFactory1_UUID := win32.IID{0x30572f99, 0xdac6, 0x41db, {0xa1, 0x6e, 0x04, 0x86, 0x30, 0x7e, 0x60, 0x6a}}
IFactory1 :: struct #raw_union {
	#subtype ifactory:      IFactory,
	using ifactory1_vtable: IFactory1_VTable,
}
IFactory1_VTable :: struct {
	using ifactory_vtable:        IFactory_VTable,
	GetEudcFontCollection:        proc "stdcall" (this: ^IFactory1, fontCollection: ^^IFontCollection, checkForUpdates: BOOL) -> HRESULT,
	CreateCustomRenderingParams1: proc "stdcall" (
		this: ^IFactory1,
		gamma: f32,
		enhancedContrast: f32,
		enhancedContrastGrayscale: f32,
		clearTypeLevel: f32,
		pixelGeometry: PIXEL_GEOMETRY,
		renderingMode: RENDERING_MODE,
		renderingParams: ^^IRenderingParams1,
	) -> HRESULT,
}


IFontFace1_UUID_STRING := "a71efdb4-9fdb-4838-ad90-cfc3be8c3daf"
IFontFace1_UUID := win32.IID{0xa71efdb4, 0x9fdb, 0x4838, {0xad, 0x90, 0xcf, 0xc3, 0xbe, 0x8c, 0x3d, 0xaf}}
IFontFace1 :: struct #raw_union {
	#subtype ifontface:      IFontFace,
	using ifontface1_vtable: IFontFace1_VTable,
}
IFontFace1_VTable :: struct {
	using ifontface_vtable:        IFontFace_VTable,
	GetMetrics1:                   proc "stdcall" (this: ^IFontFace1, fontMetrics: ^FONT_METRICS1),
	GetGdiCompatibleMetrics1:      proc "stdcall" (this: ^IFontFace1, emSize: f32, pixelsPerDip: f32, transform: ^MATRIX, fontMetrics: ^FONT_METRICS1) -> HRESULT,
	GetCaretMetrics:               proc "stdcall" (this: ^IFontFace1, caretMetrics: ^CARET_METRICS),
	GetUnicodeRanges:              proc "stdcall" (this: ^IFontFace1, maxRangeCount: u32, unicodeRanges: [^]UNICODE_RANGE, actualRangeCount: ^u32) -> HRESULT,
	IsMonospacedFont:              proc "stdcall" (this: ^IFontFace1) -> BOOL,
	GetDesignGlyphAdvances:        proc "stdcall" (this: ^IFontFace1, glyphCount: u32, glyphIndices: [^]u16, glyphAdvances: [^]i32, isSideways: BOOL) -> HRESULT,
	GetGdiCompatibleGlyphAdvances: proc "stdcall" (
		this: ^IFontFace1,
		emSize: f32,
		pixelsPerDip: f32,
		transform: ^MATRIX,
		useGdiNatural: BOOL,
		isSideways: BOOL,
		glyphCount: u32,
		glyphIndices: [^]u16,
		glyphAdvances: [^]i32,
	) -> HRESULT,
	GetKerningPairAdjustments:     proc "stdcall" (this: ^IFontFace1, glyphCount: u32, glyphIndices: [^]u16, glyphAdvanceAdjustments: [^]i32) -> HRESULT,
	HasKerningPairs:               proc "stdcall" (this: ^IFontFace1) -> BOOL,
	GetRecommendedRenderingMode1:  proc "stdcall" (
		this: ^IFontFace1,
		fontEmSize: f32,
		dpiX: f32,
		dpiY: f32,
		transform: ^MATRIX,
		isSideways: BOOL,
		outlineThreshold: OUTLINE_THRESHOLD,
		measuringMode: MEASURING_MODE,
		renderingMode: ^RENDERING_MODE,
	) -> HRESULT,
	GetVerticalGlyphVariants:      proc "stdcall" (this: ^IFontFace1, glyphCount: u32, nominalGlyphIndices: [^]u16, verticalGlyphIndices: [^]u16) -> HRESULT,
	HasVerticalGlyphVariants:      proc "stdcall" (this: ^IFontFace1) -> BOOL,
}


IFont1_UUID_STRING := "acd16696-8c14-4f5d-877e-fe3fc1d32738"
IFont1_UUID := win32.IID{0xacd16696, 0x8c14, 0x4f5d, {0x87, 0x7e, 0xfe, 0x3f, 0xc1, 0xd3, 0x27, 0x38}}
IFont1 :: struct #raw_union {
	#subtype ifont:      IFont,
	using ifont1_vtable: IFont1_VTable,
}
IFont1_VTable :: struct {
	using ifont_vtable: IFont_VTable,
	GetMetrics1:        proc "stdcall" (this: ^IFont1, fontMetrics: ^FONT_METRICS1),
	GetPanose:          proc "stdcall" (this: ^IFont1, panose: ^PANOSE),
	GetUnicodeRanges:   proc "stdcall" (this: ^IFont1, maxRangeCount: u32, unicodeRanges: [^]UNICODE_RANGE, actualRangeCount: ^u32) -> HRESULT,
	IsMonospacedFont:   proc "stdcall" (this: ^IFont1) -> BOOL,
}


IRenderingParams1_UUID_STRING := "94413cf4-a6fc-4248-8b50-6674348fcad3"
IRenderingParams1_UUID := win32.IID{0x94413cf4, 0xa6fc, 0x4248, {0x8b, 0x50, 0x66, 0x74, 0x34, 0x8f, 0xca, 0xd3}}
IRenderingParams1 :: struct #raw_union {
	#subtype irenderingparams:      IRenderingParams,
	using irenderingparams1_vtable: IRenderingParams1_VTable,
}
IRenderingParams1_VTable :: struct {
	using irenderingparams_vtable: IRenderingParams_VTable,
	GetGrayscaleEnhancedContrast:  proc "stdcall" (this: ^IRenderingParams1) -> f32,
}


ITextAnalyzer1_UUID_STRING := "80dad800-e21f-4e83-96ce-bfcce500db7c"
ITextAnalyzer1_UUID := win32.IID{0x80dad800, 0xe21f, 0x4e83, {0x96, 0xce, 0xbf, 0xcc, 0xe5, 0x00, 0xdb, 0x7c}}
ITextAnalyzer1 :: struct #raw_union {
	#subtype itextanalyzer:      ITextAnalyzer,
	using itextanalyzer1_vtable: ITextAnalyzer1_VTable,
}
ITextAnalyzer1_VTable :: struct {
	using itextanalyzer_vtable:      ITextAnalyzer_VTable,
	ApplyCharacterSpacing:           proc "stdcall" (
		this: ^ITextAnalyzer1,
		leadingSpacing: f32,
		trailingSpacing: f32,
		minimumAdvanceWidth: f32,
		textLength: u32,
		glyphCount: u32,
		clusterMap: [^]u16,
		glyphAdvances: [^]f32,
		glyphOffsets: [^]GLYPH_OFFSET,
		glyphProperties: [^]SHAPING_GLYPH_PROPERTIES,
		modifiedGlyphAdvances: [^]f32,
		modifiedGlyphOffsets: [^]GLYPH_OFFSET,
	) -> HRESULT,
	GetBaseline:                     proc "stdcall" (
		this: ^ITextAnalyzer1,
		fontFace: ^IFontFace,
		baseline: BASELINE,
		isVertical: BOOL,
		isSimulationAllowed: BOOL,
		scriptAnalysis: SCRIPT_ANALYSIS,
		localeName: PWSTR,
		baselineCoordinate: ^i32,
		exists: ^BOOL,
	) -> HRESULT,
	AnalyzeVerticalGlyphOrientation: proc "stdcall" (
		this: ^ITextAnalyzer1,
		analysisSource: ^ITextAnalysisSource1,
		textPosition: u32,
		textLength: u32,
		analysisSink: ^ITextAnalysisSink1,
	) -> HRESULT,
	GetGlyphOrientationTransform:    proc "stdcall" (this: ^ITextAnalyzer1, glyphOrientationAngle: GLYPH_ORIENTATION_ANGLE, isSideways: BOOL, transform: ^MATRIX) -> HRESULT,
	GetScriptProperties:             proc "stdcall" (this: ^ITextAnalyzer1, scriptAnalysis: SCRIPT_ANALYSIS, scriptProperties: ^SCRIPT_PROPERTIES) -> HRESULT,
	GetTextComplexity:               proc "stdcall" (
		this: ^ITextAnalyzer1,
		textString: [^]u8,
		textLength: u32,
		fontFace: ^IFontFace,
		isTextSimple: ^BOOL,
		textLengthRead: ^u32,
		glyphIndices: [^]u16,
	) -> HRESULT,
	GetJustificationOpportunities:   proc "stdcall" (
		this: ^ITextAnalyzer1,
		fontFace: ^IFontFace,
		fontEmSize: f32,
		scriptAnalysis: SCRIPT_ANALYSIS,
		textLength: u32,
		glyphCount: u32,
		textString: [^]u8,
		clusterMap: [^]u16,
		glyphProperties: [^]SHAPING_GLYPH_PROPERTIES,
		justificationOpportunities: [^]JUSTIFICATION_OPPORTUNITY,
	) -> HRESULT,
	JustifyGlyphAdvances:            proc "stdcall" (
		this: ^ITextAnalyzer1,
		lineWidth: f32,
		glyphCount: u32,
		justificationOpportunities: [^]JUSTIFICATION_OPPORTUNITY,
		glyphAdvances: [^]f32,
		glyphOffsets: [^]GLYPH_OFFSET,
		justifiedGlyphAdvances: [^]f32,
		justifiedGlyphOffsets: [^]GLYPH_OFFSET,
	) -> HRESULT,
	GetJustifiedGlyphs:              proc "stdcall" (
		this: ^ITextAnalyzer1,
		fontFace: ^IFontFace,
		fontEmSize: f32,
		scriptAnalysis: SCRIPT_ANALYSIS,
		textLength: u32,
		glyphCount: u32,
		maxGlyphCount: u32,
		clusterMap: [^]u16,
		glyphIndices: [^]u16,
		glyphAdvances: [^]f32,
		justifiedGlyphAdvances: [^]f32,
		justifiedGlyphOffsets: [^]GLYPH_OFFSET,
		glyphProperties: [^]SHAPING_GLYPH_PROPERTIES,
		actualGlyphCount: ^u32,
		modifiedClusterMap: [^]u16,
		modifiedGlyphIndices: [^]u16,
		modifiedGlyphAdvances: [^]f32,
		modifiedGlyphOffsets: [^]GLYPH_OFFSET,
	) -> HRESULT,
}


ITextAnalysisSource1_UUID_STRING := "639cfad8-0fb4-4b21-a58a-067920120009"
ITextAnalysisSource1_UUID := win32.IID{0x639cfad8, 0x0fb4, 0x4b21, {0xa5, 0x8a, 0x06, 0x79, 0x20, 0x12, 0x00, 0x09}}
ITextAnalysisSource1 :: struct #raw_union {
	#subtype itextanalysissource:      ITextAnalysisSource,
	using itextanalysissource1_vtable: ITextAnalysisSource1_VTable,
}
ITextAnalysisSource1_VTable :: struct {
	using itextanalysissource_vtable: ITextAnalysisSource_VTable,
	GetVerticalGlyphOrientation:      proc "stdcall" (
		this: ^ITextAnalysisSource1,
		textPosition: u32,
		textLength: ^u32,
		glyphOrientation: ^VERTICAL_GLYPH_ORIENTATION,
		bidiLevel: ^u8,
	) -> HRESULT,
}


ITextAnalysisSink1_UUID_STRING := "b0d941a0-85e7-4d8b-9fd3-5ced9934482a"
ITextAnalysisSink1_UUID := win32.IID{0xb0d941a0, 0x85e7, 0x4d8b, {0x9f, 0xd3, 0x5c, 0xed, 0x99, 0x34, 0x48, 0x2a}}
ITextAnalysisSink1 :: struct #raw_union {
	#subtype itextanalysissink:      ITextAnalysisSink,
	using itextanalysissink1_vtable: ITextAnalysisSink1_VTable,
}
ITextAnalysisSink1_VTable :: struct {
	using itextanalysissink_vtable: ITextAnalysisSink_VTable,
	SetGlyphOrientation:            proc "stdcall" (
		this: ^ITextAnalysisSink1,
		textPosition: u32,
		textLength: u32,
		glyphOrientationAngle: GLYPH_ORIENTATION_ANGLE,
		adjustedBidiLevel: u8,
		isSideways: BOOL,
		isRightToLeft: BOOL,
	) -> HRESULT,
}


ITextLayout1_UUID_STRING := "9064d822-80a7-465c-a986-df65f78b8feb"
ITextLayout1_UUID := win32.IID{0x9064d822, 0x80a7, 0x465c, {0xa9, 0x86, 0xdf, 0x65, 0xf7, 0x8b, 0x8f, 0xeb}}
ITextLayout1 :: struct #raw_union {
	#subtype itextlayout:      ITextLayout,
	using itextlayout1_vtable: ITextLayout1_VTable,
}
ITextLayout1_VTable :: struct {
	using itextlayout_vtable: ITextLayout_VTable,
	SetPairKerning:           proc "stdcall" (this: ^ITextLayout1, isPairKerningEnabled: BOOL, textRange: TEXT_RANGE) -> HRESULT,
	GetPairKerning:           proc "stdcall" (this: ^ITextLayout1, currentPosition: u32, isPairKerningEnabled: ^BOOL, textRange: ^TEXT_RANGE) -> HRESULT,
	SetCharacterSpacing:      proc "stdcall" (this: ^ITextLayout1, leadingSpacing: f32, trailingSpacing: f32, minimumAdvanceWidth: f32, textRange: TEXT_RANGE) -> HRESULT,
	GetCharacterSpacing:      proc "stdcall" (
		this: ^ITextLayout1,
		currentPosition: u32,
		leadingSpacing: ^f32,
		trailingSpacing: ^f32,
		minimumAdvanceWidth: ^f32,
		textRange: ^TEXT_RANGE,
	) -> HRESULT,
}


TEXT_ANTIALIAS_MODE :: enum i32 {
	CLEARTYPE,
	GRAYSCALE,
}

IBitmapRenderTarget1_UUID_STRING := "791e8298-3ef3-4230-9880-c9bdecc42064"
IBitmapRenderTarget1_UUID := win32.IID{0x791e8298, 0x3ef3, 0x4230, {0x98, 0x80, 0xc9, 0xbd, 0xec, 0xc4, 0x20, 0x64}}
IBitmapRenderTarget1 :: struct #raw_union {
	#subtype ibitmaprendertarget:      IBitmapRenderTarget,
	using ibitmaprendertarget1_vtable: IBitmapRenderTarget1_VTable,
}
IBitmapRenderTarget1_VTable :: struct {
	using ibitmaprendertarget_vtable: IBitmapRenderTarget_VTable,
	GetTextAntialiasMode:             proc "stdcall" (this: ^IBitmapRenderTarget1) -> TEXT_ANTIALIAS_MODE,
	SetTextAntialiasMode:             proc "stdcall" (this: ^IBitmapRenderTarget1, antialiasMode: TEXT_ANTIALIAS_MODE) -> HRESULT,
}


OPTICAL_ALIGNMENT :: enum i32 {
	NONE,
	NO_SIDE_BEARINGS,
}

GRID_FIT_MODE :: enum i32 {
	DEFAULT,
	DISABLED,
	ENABLED,
}

TEXT_METRICS1 :: struct {
	Base:                              TEXT_METRICS,
	heightIncludingTrailingWhitespace: f32,
}

ITextRenderer1_UUID_STRING := "d3e0e934-22a0-427e-aae4-7d9574b59db1"
ITextRenderer1_UUID := win32.IID{0xd3e0e934, 0x22a0, 0x427e, {0xaa, 0xe4, 0x7d, 0x95, 0x74, 0xb5, 0x9d, 0xb1}}
ITextRenderer1 :: struct #raw_union {
	#subtype itextrenderer:      ITextRenderer,
	using itextrenderer1_vtable: ITextRenderer1_VTable,
}
ITextRenderer1_VTable :: struct {
	using itextrenderer_vtable: ITextRenderer_VTable,
	DrawGlyphRun1:              proc "stdcall" (
		this: ^ITextRenderer1,
		clientDrawingContext: rawptr,
		baselineOriginX: f32,
		baselineOriginY: f32,
		orientationAngle: GLYPH_ORIENTATION_ANGLE,
		measuringMode: MEASURING_MODE,
		#by_ptr glyphRun: GLYPH_RUN,
		#by_ptr glyphRunDescription: GLYPH_RUN_DESCRIPTION,
		clientDrawingEffect: ^IUnknown,
	) -> HRESULT,
	DrawUnderline1:             proc "stdcall" (
		this: ^ITextRenderer1,
		clientDrawingContext: rawptr,
		baselineOriginX: f32,
		baselineOriginY: f32,
		orientationAngle: GLYPH_ORIENTATION_ANGLE,
		#by_ptr underline: UNDERLINE,
		clientDrawingEffect: ^IUnknown,
	) -> HRESULT,
	DrawStrikethrough1:         proc "stdcall" (
		this: ^ITextRenderer1,
		clientDrawingContext: rawptr,
		baselineOriginX: f32,
		baselineOriginY: f32,
		orientationAngle: GLYPH_ORIENTATION_ANGLE,
		#by_ptr strikethrough: STRIKETHROUGH,
		clientDrawingEffect: ^IUnknown,
	) -> HRESULT,
	DrawInlineObject1:          proc "stdcall" (
		this: ^ITextRenderer1,
		clientDrawingContext: rawptr,
		originX: f32,
		originY: f32,
		orientationAngle: GLYPH_ORIENTATION_ANGLE,
		inlineObject: ^IInlineObject,
		isSideways: BOOL,
		isRightToLeft: BOOL,
		clientDrawingEffect: ^IUnknown,
	) -> HRESULT,
}


ITextFormat1_UUID_STRING := "5f174b49-0d8b-4cfb-8bca-f1cce9d06c67"
ITextFormat1_UUID := win32.IID{0x5f174b49, 0x0d8b, 0x4cfb, {0x8b, 0xca, 0xf1, 0xcc, 0xe9, 0xd0, 0x6c, 0x67}}
ITextFormat1 :: struct #raw_union {
	#subtype itextformat:      ITextFormat,
	using itextformat1_vtable: ITextFormat1_VTable,
}
ITextFormat1_VTable :: struct {
	using itextformat_vtable:    ITextFormat_VTable,
	SetVerticalGlyphOrientation: proc "stdcall" (this: ^ITextFormat1, glyphOrientation: VERTICAL_GLYPH_ORIENTATION) -> HRESULT,
	GetVerticalGlyphOrientation: proc "stdcall" (this: ^ITextFormat1) -> VERTICAL_GLYPH_ORIENTATION,
	SetLastLineWrapping:         proc "stdcall" (this: ^ITextFormat1, isLastLineWrappingEnabled: BOOL) -> HRESULT,
	GetLastLineWrapping:         proc "stdcall" (this: ^ITextFormat1) -> BOOL,
	SetOpticalAlignment:         proc "stdcall" (this: ^ITextFormat1, opticalAlignment: OPTICAL_ALIGNMENT) -> HRESULT,
	GetOpticalAlignment:         proc "stdcall" (this: ^ITextFormat1) -> OPTICAL_ALIGNMENT,
	SetFontFallback:             proc "stdcall" (this: ^ITextFormat1, fontFallback: ^IFontFallback) -> HRESULT,
	GetFontFallback:             proc "stdcall" (this: ^ITextFormat1, fontFallback: ^^IFontFallback) -> HRESULT,
}


ITextLayout2_UUID_STRING := "1093c18f-8d5e-43f0-b064-0917311b525e"
ITextLayout2_UUID := win32.IID{0x1093c18f, 0x8d5e, 0x43f0, {0xb0, 0x64, 0x09, 0x17, 0x31, 0x1b, 0x52, 0x5e}}
ITextLayout2 :: struct #raw_union {
	#subtype itextlayout1:     ITextLayout1,
	using itextlayout2_vtable: ITextLayout2_VTable,
}
ITextLayout2_VTable :: struct {
	using itextlayout1_vtable:   ITextLayout1_VTable,
	GetMetrics2:                 proc "stdcall" (this: ^ITextLayout2, textMetrics: ^TEXT_METRICS1) -> HRESULT,
	SetVerticalGlyphOrientation: proc "stdcall" (this: ^ITextLayout2, glyphOrientation: VERTICAL_GLYPH_ORIENTATION) -> HRESULT,
	GetVerticalGlyphOrientation: proc "stdcall" (this: ^ITextLayout2) -> VERTICAL_GLYPH_ORIENTATION,
	SetLastLineWrapping:         proc "stdcall" (this: ^ITextLayout2, isLastLineWrappingEnabled: BOOL) -> HRESULT,
	GetLastLineWrapping:         proc "stdcall" (this: ^ITextLayout2) -> BOOL,
	SetOpticalAlignment:         proc "stdcall" (this: ^ITextLayout2, opticalAlignment: OPTICAL_ALIGNMENT) -> HRESULT,
	GetOpticalAlignment:         proc "stdcall" (this: ^ITextLayout2) -> OPTICAL_ALIGNMENT,
	SetFontFallback:             proc "stdcall" (this: ^ITextLayout2, fontFallback: ^IFontFallback) -> HRESULT,
	GetFontFallback:             proc "stdcall" (this: ^ITextLayout2, fontFallback: ^^IFontFallback) -> HRESULT,
}


ITextAnalyzer2_UUID_STRING := "553a9ff3-5693-4df7-b52b-74806f7f2eb9"
ITextAnalyzer2_UUID := win32.IID{0x553a9ff3, 0x5693, 0x4df7, {0xb5, 0x2b, 0x74, 0x80, 0x6f, 0x7f, 0x2e, 0xb9}}
ITextAnalyzer2 :: struct #raw_union {
	#subtype itextanalyzer1:     ITextAnalyzer1,
	using itextanalyzer2_vtable: ITextAnalyzer2_VTable,
}
ITextAnalyzer2_VTable :: struct {
	using itextanalyzer1_vtable:   ITextAnalyzer1_VTable,
	GetGlyphOrientationTransform2: proc "stdcall" (
		this: ^ITextAnalyzer2,
		glyphOrientationAngle: GLYPH_ORIENTATION_ANGLE,
		isSideways: BOOL,
		originX: f32,
		originY: f32,
		transform: ^MATRIX,
	) -> HRESULT,
	GetTypographicFeatures:        proc "stdcall" (
		this: ^ITextAnalyzer2,
		fontFace: ^IFontFace,
		scriptAnalysis: SCRIPT_ANALYSIS,
		localeName: PWSTR,
		maxTagCount: u32,
		actualTagCount: ^u32,
		tags: [^]FONT_FEATURE_TAG,
	) -> HRESULT,
	CheckTypographicFeature:       proc "stdcall" (
		this: ^ITextAnalyzer2,
		fontFace: ^IFontFace,
		scriptAnalysis: SCRIPT_ANALYSIS,
		localeName: PWSTR,
		featureTag: FONT_FEATURE_TAG,
		glyphCount: u32,
		glyphIndices: [^]u16,
		featureApplies: [^]u8,
	) -> HRESULT,
}


IFontFallback_UUID_STRING := "efa008f9-f7a1-48bf-b05c-f224713cc0ff"
IFontFallback_UUID := win32.IID{0xefa008f9, 0xf7a1, 0x48bf, {0xb0, 0x5c, 0xf2, 0x24, 0x71, 0x3c, 0xc0, 0xff}}
IFontFallback :: struct #raw_union {
	#subtype iunknown:          IUnknown,
	using ifontfallback_vtable: IFontFallback_VTable,
}
IFontFallback_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	MapCharacters:         proc "stdcall" (
		this: ^IFontFallback,
		analysisSource: ^ITextAnalysisSource,
		textPosition: u32,
		textLength: u32,
		baseFontCollection: ^IFontCollection,
		baseFamilyName: PWSTR,
		baseWeight: FONT_WEIGHT,
		baseStyle: FONT_STYLE,
		baseStretch: FONT_STRETCH,
		mappedLength: ^u32,
		mappedFont: ^^IFont,
		scale: ^f32,
	) -> HRESULT,
}


IFontFallbackBuilder_UUID_STRING := "fd882d06-8aba-4fb8-b849-8be8b73e14de"
IFontFallbackBuilder_UUID := win32.IID{0xfd882d06, 0x8aba, 0x4fb8, {0xb8, 0x49, 0x8b, 0xe8, 0xb7, 0x3e, 0x14, 0xde}}
IFontFallbackBuilder :: struct #raw_union {
	#subtype iunknown:                 IUnknown,
	using ifontfallbackbuilder_vtable: IFontFallbackBuilder_VTable,
}
IFontFallbackBuilder_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	AddMapping:            proc "stdcall" (
		this: ^IFontFallbackBuilder,
		ranges: [^]UNICODE_RANGE,
		rangesCount: u32,
		targetFamilyNames: [^]^u16,
		targetFamilyNamesCount: u32,
		fontCollection: ^IFontCollection,
		localeName: PWSTR,
		baseFamilyName: PWSTR,
		scale: f32,
	) -> HRESULT,
	AddMappings:           proc "stdcall" (this: ^IFontFallbackBuilder, fontFallback: ^IFontFallback) -> HRESULT,
	CreateFontFallback:    proc "stdcall" (this: ^IFontFallbackBuilder, fontFallback: ^^IFontFallback) -> HRESULT,
}


IFont2_UUID_STRING := "29748ed6-8c9c-4a6a-be0b-d912e8538944"
IFont2_UUID := win32.IID{0x29748ed6, 0x8c9c, 0x4a6a, {0xbe, 0x0b, 0xd9, 0x12, 0xe8, 0x53, 0x89, 0x44}}
IFont2 :: struct #raw_union {
	#subtype ifont1:     IFont1,
	using ifont2_vtable: IFont2_VTable,
}
IFont2_VTable :: struct {
	using ifont1_vtable: IFont1_VTable,
	IsColorFont:         proc "stdcall" (this: ^IFont2) -> BOOL,
}


IFontFace2_UUID_STRING := "d8b768ff-64bc-4e66-982b-ec8e87f693f7"
IFontFace2_UUID := win32.IID{0xd8b768ff, 0x64bc, 0x4e66, {0x98, 0x2b, 0xec, 0x8e, 0x87, 0xf6, 0x93, 0xf7}}
IFontFace2 :: struct #raw_union {
	#subtype ifontface1:     IFontFace1,
	using ifontface2_vtable: IFontFace2_VTable,
}
IFontFace2_VTable :: struct {
	using ifontface1_vtable:      IFontFace1_VTable,
	IsColorFont:                  proc "stdcall" (this: ^IFontFace2) -> BOOL,
	GetColorPaletteCount:         proc "stdcall" (this: ^IFontFace2) -> u32,
	GetPaletteEntryCount:         proc "stdcall" (this: ^IFontFace2) -> u32,
	GetPaletteEntries:            proc "stdcall" (this: ^IFontFace2, colorPaletteIndex: u32, firstEntryIndex: u32, entryCount: u32, paletteEntries: [^]COLOR_F) -> HRESULT,
	GetRecommendedRenderingMode2: proc "stdcall" (
		this: ^IFontFace2,
		fontEmSize: f32,
		dpiX: f32,
		dpiY: f32,
		transform: ^MATRIX,
		isSideways: BOOL,
		outlineThreshold: OUTLINE_THRESHOLD,
		measuringMode: MEASURING_MODE,
		renderingParams: ^IRenderingParams,
		renderingMode: ^RENDERING_MODE,
		gridFitMode: ^GRID_FIT_MODE,
	) -> HRESULT,
}


COLOR_GLYPH_RUN :: struct {
	glyphRun:            GLYPH_RUN,
	glyphRunDescription: ^GLYPH_RUN_DESCRIPTION,
	baselineOriginX:     f32,
	baselineOriginY:     f32,
	runColor:            COLOR_F,
	paletteIndex:        u16,
}

IColorGlyphRunEnumerator_UUID_STRING := "d31fbe17-f157-41a2-8d24-cb779e0560e8"
IColorGlyphRunEnumerator_UUID := win32.IID{0xd31fbe17, 0xf157, 0x41a2, {0x8d, 0x24, 0xcb, 0x77, 0x9e, 0x05, 0x60, 0xe8}}
IColorGlyphRunEnumerator :: struct #raw_union {
	#subtype iunknown:                     IUnknown,
	using icolorglyphrunenumerator_vtable: IColorGlyphRunEnumerator_VTable,
}
IColorGlyphRunEnumerator_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	MoveNext:              proc "stdcall" (this: ^IColorGlyphRunEnumerator, hasRun: ^BOOL) -> HRESULT,
	GetCurrentRun:         proc "stdcall" (this: ^IColorGlyphRunEnumerator, colorGlyphRun: ^^COLOR_GLYPH_RUN) -> HRESULT,
}


IRenderingParams2_UUID_STRING := "f9d711c3-9777-40ae-87e8-3e5af9bf0948"
IRenderingParams2_UUID := win32.IID{0xf9d711c3, 0x9777, 0x40ae, {0x87, 0xe8, 0x3e, 0x5a, 0xf9, 0xbf, 0x09, 0x48}}
IRenderingParams2 :: struct #raw_union {
	#subtype irenderingparams1:     IRenderingParams1,
	using irenderingparams2_vtable: IRenderingParams2_VTable,
}
IRenderingParams2_VTable :: struct {
	using irenderingparams1_vtable: IRenderingParams1_VTable,
	GetGridFitMode:                 proc "stdcall" (this: ^IRenderingParams2) -> GRID_FIT_MODE,
}


IFactory2_UUID_STRING := "0439fc60-ca44-4994-8dee-3a9af7b732ec"
IFactory2_UUID := win32.IID{0x0439fc60, 0xca44, 0x4994, {0x8d, 0xee, 0x3a, 0x9a, 0xf7, 0xb7, 0x32, 0xec}}
IFactory2 :: struct #raw_union {
	#subtype ifactory1:     IFactory1,
	using ifactory2_vtable: IFactory2_VTable,
}
IFactory2_VTable :: struct {
	using ifactory1_vtable:       IFactory1_VTable,
	GetSystemFontFallback:        proc "stdcall" (this: ^IFactory2, fontFallback: ^^IFontFallback) -> HRESULT,
	CreateFontFallbackBuilder:    proc "stdcall" (this: ^IFactory2, fontFallbackBuilder: ^^IFontFallbackBuilder) -> HRESULT,
	TranslateColorGlyphRun:       proc "stdcall" (
		this: ^IFactory2,
		baselineOriginX: f32,
		baselineOriginY: f32,
		#by_ptr glyphRun: GLYPH_RUN,
		glyphRunDescription: ^GLYPH_RUN_DESCRIPTION,
		measuringMode: MEASURING_MODE,
		worldToDeviceTransform: ^MATRIX,
		colorPaletteIndex: u32,
		colorLayers: ^^IColorGlyphRunEnumerator,
	) -> HRESULT,
	CreateCustomRenderingParams2: proc "stdcall" (
		this: ^IFactory2,
		gamma: f32,
		enhancedContrast: f32,
		grayscaleEnhancedContrast: f32,
		clearTypeLevel: f32,
		pixelGeometry: PIXEL_GEOMETRY,
		renderingMode: RENDERING_MODE,
		gridFitMode: GRID_FIT_MODE,
		renderingParams: ^^IRenderingParams2,
	) -> HRESULT,
	CreateGlyphRunAnalysis2:      proc "stdcall" (
		this: ^IFactory2,
		#by_ptr glyphRun: GLYPH_RUN,
		transform: ^MATRIX,
		renderingMode: RENDERING_MODE,
		measuringMode: MEASURING_MODE,
		gridFitMode: GRID_FIT_MODE,
		antialiasMode: TEXT_ANTIALIAS_MODE,
		baselineOriginX: f32,
		baselineOriginY: f32,
		glyphRunAnalysis: ^^IGlyphRunAnalysis,
	) -> HRESULT,
}


FONT_PROPERTY_ID :: enum i32 {
	NONE                             = 0,
	WEIGHT_STRETCH_STYLE_FAMILY_NAME = 1,
	TYPOGRAPHIC_FAMILY_NAME          = 2,
	WEIGHT_STRETCH_STYLE_FACE_NAME   = 3,
	FULL_NAME                        = 4,
	WIN32_FAMILY_NAME                = 5,
	POSTSCRIPT_NAME                  = 6,
	DESIGN_SCRIPT_LANGUAGE_TAG       = 7,
	SUPPORTED_SCRIPT_LANGUAGE_TAG    = 8,
	SEMANTIC_TAG                     = 9,
	WEIGHT                           = 10,
	STRETCH                          = 11,
	STYLE                            = 12,
	TYPOGRAPHIC_FACE_NAME            = 13,
	TOTAL                            = 13,
	TOTAL_RS3                        = 14,
	PREFERRED_FAMILY_NAME            = 2,
	FAMILY_NAME                      = 1,
	FACE_NAME                        = 3,
}

FONT_PROPERTY :: struct {
	propertyId:    FONT_PROPERTY_ID,
	propertyValue: PWSTR,
	localeName:    PWSTR,
}

LOCALITY :: enum i32 {
	REMOTE,
	PARTIAL,
	LOCAL,
}

RENDERING_MODE1 :: enum i32 {
	DEFAULT,
	ALIASED,
	GDI_CLASSIC,
	GDI_NATURAL,
	NATURAL,
	NATURAL_SYMMETRIC,
	OUTLINE,
	NATURAL_SYMMETRIC_DOWNSAMPLED,
}

IRenderingParams3_UUID_STRING := "b7924baa-391b-412a-8c5c-e44cc2d867dc"
IRenderingParams3_UUID := win32.IID{0xb7924baa, 0x391b, 0x412a, {0x8c, 0x5c, 0xe4, 0x4c, 0xc2, 0xd8, 0x67, 0xdc}}
IRenderingParams3 :: struct #raw_union {
	#subtype irenderingparams2:     IRenderingParams2,
	using irenderingparams3_vtable: IRenderingParams3_VTable,
}
IRenderingParams3_VTable :: struct {
	using irenderingparams2_vtable: IRenderingParams2_VTable,
	GetRenderingMode1:              proc "stdcall" (this: ^IRenderingParams3) -> RENDERING_MODE1,
}


IFactory3_UUID_STRING := "9a1b41c3-d3bb-466a-87fc-fe67556a3b65"
IFactory3_UUID := win32.IID{0x9a1b41c3, 0xd3bb, 0x466a, {0x87, 0xfc, 0xfe, 0x67, 0x55, 0x6a, 0x3b, 0x65}}
IFactory3 :: struct #raw_union {
	#subtype ifactory2:     IFactory2,
	using ifactory3_vtable: IFactory3_VTable,
}
IFactory3_VTable :: struct {
	using ifactory2_vtable:          IFactory2_VTable,
	CreateGlyphRunAnalysis3:         proc "stdcall" (
		this: ^IFactory3,
		#by_ptr glyphRun: GLYPH_RUN,
		transform: ^MATRIX,
		renderingMode: RENDERING_MODE1,
		measuringMode: MEASURING_MODE,
		gridFitMode: GRID_FIT_MODE,
		antialiasMode: TEXT_ANTIALIAS_MODE,
		baselineOriginX: f32,
		baselineOriginY: f32,
		glyphRunAnalysis: ^^IGlyphRunAnalysis,
	) -> HRESULT,
	CreateCustomRenderingParams3:    proc "stdcall" (
		this: ^IFactory3,
		gamma: f32,
		enhancedContrast: f32,
		grayscaleEnhancedContrast: f32,
		clearTypeLevel: f32,
		pixelGeometry: PIXEL_GEOMETRY,
		renderingMode: RENDERING_MODE1,
		gridFitMode: GRID_FIT_MODE,
		renderingParams: ^^IRenderingParams3,
	) -> HRESULT,
	CreateFontFaceReference:         proc "stdcall" (
		this: ^IFactory3,
		fontFile: ^IFontFile,
		faceIndex: u32,
		fontSimulations: FONT_SIMULATIONS,
		fontFaceReference: ^^IFontFaceReference,
	) -> HRESULT,
	CreateFontFaceReference3:        proc "stdcall" (
		this: ^IFactory3,
		filePath: PWSTR,
		lastWriteTime: ^FILETIME,
		faceIndex: u32,
		fontSimulations: FONT_SIMULATIONS,
		fontFaceReference: ^^IFontFaceReference,
	) -> HRESULT,
	GetSystemFontSet:                proc "stdcall" (this: ^IFactory3, fontSet: ^^IFontSet) -> HRESULT,
	CreateFontSetBuilder:            proc "stdcall" (this: ^IFactory3, fontSetBuilder: ^^IFontSetBuilder) -> HRESULT,
	CreateFontCollectionFromFontSet: proc "stdcall" (this: ^IFactory3, fontSet: ^IFontSet, fontCollection: ^^IFontCollection1) -> HRESULT,
	GetSystemFontCollection3:        proc "stdcall" (this: ^IFactory3, includeDownloadableFonts: BOOL, fontCollection: ^^IFontCollection1, checkForUpdates: BOOL) -> HRESULT,
	GetFontDownloadQueue:            proc "stdcall" (this: ^IFactory3, fontDownloadQueue: ^^IFontDownloadQueue) -> HRESULT,
}


IFontSet_UUID_STRING := "53585141-d9f8-4095-8321-d73cf6bd116b"
IFontSet_UUID := win32.IID{0x53585141, 0xd9f8, 0x4095, {0x83, 0x21, 0xd7, 0x3c, 0xf6, 0xbd, 0x11, 0x6b}}
IFontSet :: struct #raw_union {
	#subtype iunknown:     IUnknown,
	using ifontset_vtable: IFontSet_VTable,
}
IFontSet_VTable :: struct {
	using iunknown_vtable:      IUnknown_VTable,
	GetFontCount:               proc "stdcall" (this: ^IFontSet) -> u32,
	GetFontFaceReference:       proc "stdcall" (this: ^IFontSet, listIndex: u32, fontFaceReference: ^^IFontFaceReference) -> HRESULT,
	FindFontFaceReference:      proc "stdcall" (this: ^IFontSet, fontFaceReference: ^IFontFaceReference, listIndex: ^u32, exists: ^BOOL) -> HRESULT,
	FindFontFace:               proc "stdcall" (this: ^IFontSet, fontFace: ^IFontFace, listIndex: ^u32, exists: ^BOOL) -> HRESULT,
	GetPropertyValues_1:        proc "stdcall" (this: ^IFontSet, propertyID: FONT_PROPERTY_ID, values: ^^IStringList) -> HRESULT,
	GetPropertyValues_2:        proc "stdcall" (this: ^IFontSet, propertyID: FONT_PROPERTY_ID, preferredLocaleNames: PWSTR, values: ^^IStringList) -> HRESULT,
	GetPropertyValues_3:        proc "stdcall" (this: ^IFontSet, listIndex: u32, propertyId: FONT_PROPERTY_ID, exists: ^BOOL, values: ^^ILocalizedStrings) -> HRESULT,
	GetPropertyOccurrenceCount: proc "stdcall" (this: ^IFontSet, #by_ptr property: FONT_PROPERTY, propertyOccurrenceCount: ^u32) -> HRESULT,
	GetMatchingFonts_1:         proc "stdcall" (
		this: ^IFontSet,
		familyName: PWSTR,
		fontWeight: FONT_WEIGHT,
		fontStretch: FONT_STRETCH,
		fontStyle: FONT_STYLE,
		filteredSet: ^^IFontSet,
	) -> HRESULT,
	GetMatchingFonts_2:         proc "stdcall" (this: ^IFontSet, properties: [^]FONT_PROPERTY, propertyCount: u32, filteredSet: ^^IFontSet) -> HRESULT,
}


IFontSetBuilder_UUID_STRING := "2f642afe-9c68-4f40-b8be-457401afcb3d"
IFontSetBuilder_UUID := win32.IID{0x2f642afe, 0x9c68, 0x4f40, {0xb8, 0xbe, 0x45, 0x74, 0x01, 0xaf, 0xcb, 0x3d}}
IFontSetBuilder :: struct #raw_union {
	#subtype iunknown:            IUnknown,
	using ifontsetbuilder_vtable: IFontSetBuilder_VTable,
}
IFontSetBuilder_VTable :: struct {
	using iunknown_vtable:  IUnknown_VTable,
	AddFontFaceReference_1: proc "stdcall" (this: ^IFontSetBuilder, fontFaceReference: ^IFontFaceReference, properties: [^]FONT_PROPERTY, propertyCount: u32) -> HRESULT,
	AddFontFaceReference_2: proc "stdcall" (this: ^IFontSetBuilder, fontFaceReference: ^IFontFaceReference) -> HRESULT,
	AddFontSet:             proc "stdcall" (this: ^IFontSetBuilder, fontSet: ^IFontSet) -> HRESULT,
	CreateFontSet:          proc "stdcall" (this: ^IFontSetBuilder, fontSet: ^^IFontSet) -> HRESULT,
}


IFontCollection1_UUID_STRING := "53585141-d9f8-4095-8321-d73cf6bd116c"
IFontCollection1_UUID := win32.IID{0x53585141, 0xd9f8, 0x4095, {0x83, 0x21, 0xd7, 0x3c, 0xf6, 0xbd, 0x11, 0x6c}}
IFontCollection1 :: struct #raw_union {
	#subtype ifontcollection:      IFontCollection,
	using ifontcollection1_vtable: IFontCollection1_VTable,
}
IFontCollection1_VTable :: struct {
	using ifontcollection_vtable: IFontCollection_VTable,
	GetFontSet:                   proc "stdcall" (this: ^IFontCollection1, fontSet: ^^IFontSet) -> HRESULT,
	GetFontFamily1:               proc "stdcall" (this: ^IFontCollection1, index: u32, fontFamily: ^^IFontFamily1) -> HRESULT,
}


IFontFamily1_UUID_STRING := "da20d8ef-812a-4c43-9802-62ec4abd7adf"
IFontFamily1_UUID := win32.IID{0xda20d8ef, 0x812a, 0x4c43, {0x98, 0x02, 0x62, 0xec, 0x4a, 0xbd, 0x7a, 0xdf}}
IFontFamily1 :: struct #raw_union {
	#subtype ifontfamily:      IFontFamily,
	using ifontfamily1_vtable: IFontFamily1_VTable,
}
IFontFamily1_VTable :: struct {
	using ifontfamily_vtable: IFontFamily_VTable,
	GetFontLocality:          proc "stdcall" (this: ^IFontFamily1, listIndex: u32) -> LOCALITY,
	GetFont1:                 proc "stdcall" (this: ^IFontFamily1, listIndex: u32, font: ^^IFont3) -> HRESULT,
	GetFontFaceReference:     proc "stdcall" (this: ^IFontFamily1, listIndex: u32, fontFaceReference: ^^IFontFaceReference) -> HRESULT,
}


IFontList1_UUID_STRING := "da20d8ef-812a-4c43-9802-62ec4abd7ade"
IFontList1_UUID := win32.IID{0xda20d8ef, 0x812a, 0x4c43, {0x98, 0x02, 0x62, 0xec, 0x4a, 0xbd, 0x7a, 0xde}}
IFontList1 :: struct #raw_union {
	#subtype ifontlist:      IFontList,
	using ifontlist1_vtable: IFontList1_VTable,
}
IFontList1_VTable :: struct {
	using ifontlist_vtable: IFontList_VTable,
	GetFontLocality:        proc "stdcall" (this: ^IFontList1, listIndex: u32) -> LOCALITY,
	GetFont1:               proc "stdcall" (this: ^IFontList1, listIndex: u32, font: ^^IFont3) -> HRESULT,
	GetFontFaceReference:   proc "stdcall" (this: ^IFontList1, listIndex: u32, fontFaceReference: ^^IFontFaceReference) -> HRESULT,
}


IFontFaceReference_UUID_STRING := "5e7fa7ca-dde3-424c-89f0-9fcd6fed58cd"
IFontFaceReference_UUID := win32.IID{0x5e7fa7ca, 0xdde3, 0x424c, {0x89, 0xf0, 0x9f, 0xcd, 0x6f, 0xed, 0x58, 0xcd}}
IFontFaceReference :: struct #raw_union {
	#subtype iunknown:               IUnknown,
	using ifontfacereference_vtable: IFontFaceReference_VTable,
}
IFontFaceReference_VTable :: struct {
	using iunknown_vtable:              IUnknown_VTable,
	CreateFontFace:                     proc "stdcall" (this: ^IFontFaceReference, fontFace: ^^IFontFace3) -> HRESULT,
	CreateFontFaceWithSimulations:      proc "stdcall" (this: ^IFontFaceReference, fontFaceSimulationFlags: FONT_SIMULATIONS, fontFace: ^^IFontFace3) -> HRESULT,
	Equals:                             proc "stdcall" (this: ^IFontFaceReference, fontFaceReference: ^IFontFaceReference) -> BOOL,
	GetFontFaceIndex:                   proc "stdcall" (this: ^IFontFaceReference) -> u32,
	GetSimulations:                     proc "stdcall" (this: ^IFontFaceReference) -> FONT_SIMULATIONS,
	GetFontFile:                        proc "stdcall" (this: ^IFontFaceReference, fontFile: ^^IFontFile) -> HRESULT,
	GetLocalFileSize:                   proc "stdcall" (this: ^IFontFaceReference) -> u64,
	GetFileSize:                        proc "stdcall" (this: ^IFontFaceReference) -> u64,
	GetFileTime:                        proc "stdcall" (this: ^IFontFaceReference, lastWriteTime: ^FILETIME) -> HRESULT,
	GetLocality:                        proc "stdcall" (this: ^IFontFaceReference) -> LOCALITY,
	EnqueueFontDownloadRequest:         proc "stdcall" (this: ^IFontFaceReference) -> HRESULT,
	EnqueueCharacterDownloadRequest:    proc "stdcall" (this: ^IFontFaceReference, characters: [^]u8, characterCount: u32) -> HRESULT,
	EnqueueGlyphDownloadRequest:        proc "stdcall" (this: ^IFontFaceReference, glyphIndices: [^]u16, glyphCount: u32) -> HRESULT,
	EnqueueFileFragmentDownloadRequest: proc "stdcall" (this: ^IFontFaceReference, fileOffset: u64, fragmentSize: u64) -> HRESULT,
}


IFont3_UUID_STRING := "29748ed6-8c9c-4a6a-be0b-d912e8538944"
IFont3_UUID := win32.IID{0x29748ed6, 0x8c9c, 0x4a6a, {0xbe, 0x0b, 0xd9, 0x12, 0xe8, 0x53, 0x89, 0x44}}
IFont3 :: struct #raw_union {
	#subtype ifont2:     IFont2,
	using ifont3_vtable: IFont3_VTable,
}
IFont3_VTable :: struct {
	using ifont2_vtable:  IFont2_VTable,
	CreateFontFace3:      proc "stdcall" (this: ^IFont3, fontFace: ^^IFontFace3) -> HRESULT,
	Equals:               proc "stdcall" (this: ^IFont3, font: ^IFont) -> BOOL,
	GetFontFaceReference: proc "stdcall" (this: ^IFont3, fontFaceReference: ^^IFontFaceReference) -> HRESULT,
	HasCharacter3:        proc "stdcall" (this: ^IFont3, unicodeValue: u32) -> BOOL,
	GetLocality:          proc "stdcall" (this: ^IFont3) -> LOCALITY,
}


IFontFace3_UUID_STRING := "d37d7598-09be-4222-a236-2081341cc1f2"
IFontFace3_UUID := win32.IID{0xd37d7598, 0x09be, 0x4222, {0xa2, 0x36, 0x20, 0x81, 0x34, 0x1c, 0xc1, 0xf2}}
IFontFace3 :: struct #raw_union {
	#subtype ifontface2:     IFontFace2,
	using ifontface3_vtable: IFontFace3_VTable,
}
IFontFace3_VTable :: struct {
	using ifontface2_vtable:      IFontFace2_VTable,
	GetFontFaceReference:         proc "stdcall" (this: ^IFontFace3, fontFaceReference: ^^IFontFaceReference) -> HRESULT,
	GetPanose:                    proc "stdcall" (this: ^IFontFace3, panose: ^PANOSE),
	GetWeight:                    proc "stdcall" (this: ^IFontFace3) -> FONT_WEIGHT,
	GetStretch:                   proc "stdcall" (this: ^IFontFace3) -> FONT_STRETCH,
	GetStyle:                     proc "stdcall" (this: ^IFontFace3) -> FONT_STYLE,
	GetFamilyNames:               proc "stdcall" (this: ^IFontFace3, names: ^^ILocalizedStrings) -> HRESULT,
	GetFaceNames:                 proc "stdcall" (this: ^IFontFace3, names: ^^ILocalizedStrings) -> HRESULT,
	GetInformationalStrings:      proc "stdcall" (
		this: ^IFontFace3,
		informationalStringID: INFORMATIONAL_STRING_ID,
		informationalStrings: ^^ILocalizedStrings,
		exists: ^BOOL,
	) -> HRESULT,
	HasCharacter:                 proc "stdcall" (this: ^IFontFace3, unicodeValue: u32) -> BOOL,
	GetRecommendedRenderingMode3: proc "stdcall" (
		this: ^IFontFace3,
		fontEmSize: f32,
		dpiX: f32,
		dpiY: f32,
		transform: ^MATRIX,
		isSideways: BOOL,
		outlineThreshold: OUTLINE_THRESHOLD,
		measuringMode: MEASURING_MODE,
		renderingParams: ^IRenderingParams,
		renderingMode: ^RENDERING_MODE1,
		gridFitMode: ^GRID_FIT_MODE,
	) -> HRESULT,
	IsCharacterLocal:             proc "stdcall" (this: ^IFontFace3, unicodeValue: u32) -> BOOL,
	IsGlyphLocal:                 proc "stdcall" (this: ^IFontFace3, glyphId: u16) -> BOOL,
	AreCharactersLocal:           proc "stdcall" (this: ^IFontFace3, characters: [^]u8, characterCount: u32, enqueueIfNotLocal: BOOL, isLocal: ^BOOL) -> HRESULT,
	AreGlyphsLocal:               proc "stdcall" (this: ^IFontFace3, glyphIndices: [^]u16, glyphCount: u32, enqueueIfNotLocal: BOOL, isLocal: ^BOOL) -> HRESULT,
}


IStringList_UUID_STRING := "cfee3140-1157-47ca-8b85-31bfcf3f2d0e"
IStringList_UUID := win32.IID{0xcfee3140, 0x1157, 0x47ca, {0x8b, 0x85, 0x31, 0xbf, 0xcf, 0x3f, 0x2d, 0x0e}}
IStringList :: struct #raw_union {
	#subtype iunknown:        IUnknown,
	using istringlist_vtable: IStringList_VTable,
}
IStringList_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	GetCount:              proc "stdcall" (this: ^IStringList) -> u32,
	GetLocaleNameLength:   proc "stdcall" (this: ^IStringList, listIndex: u32, length: ^u32) -> HRESULT,
	GetLocaleName:         proc "stdcall" (this: ^IStringList, listIndex: u32, localeName: [^]u8, size: u32) -> HRESULT,
	GetStringLength:       proc "stdcall" (this: ^IStringList, listIndex: u32, length: ^u32) -> HRESULT,
	GetString:             proc "stdcall" (this: ^IStringList, listIndex: u32, stringBuffer: [^]u8, stringBufferSize: u32) -> HRESULT,
}


IFontDownloadListener_UUID_STRING := "b06fe5b9-43ec-4393-881b-dbe4dc72fda7"
IFontDownloadListener_UUID := win32.IID{0xb06fe5b9, 0x43ec, 0x4393, {0x88, 0x1b, 0xdb, 0xe4, 0xdc, 0x72, 0xfd, 0xa7}}
IFontDownloadListener :: struct #raw_union {
	#subtype iunknown:                  IUnknown,
	using ifontdownloadlistener_vtable: IFontDownloadListener_VTable,
}
IFontDownloadListener_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	DownloadCompleted:     proc "stdcall" (this: ^IFontDownloadListener, downloadQueue: ^IFontDownloadQueue, context_: ^IUnknown, downloadResult: HRESULT),
}


IFontDownloadQueue_UUID_STRING := "b71e6052-5aea-4fa3-832e-f60d431f7e91"
IFontDownloadQueue_UUID := win32.IID{0xb71e6052, 0x5aea, 0x4fa3, {0x83, 0x2e, 0xf6, 0x0d, 0x43, 0x1f, 0x7e, 0x91}}
IFontDownloadQueue :: struct #raw_union {
	#subtype iunknown:               IUnknown,
	using ifontdownloadqueue_vtable: IFontDownloadQueue_VTable,
}
IFontDownloadQueue_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	AddListener:           proc "stdcall" (this: ^IFontDownloadQueue, listener: ^IFontDownloadListener, token: ^u32) -> HRESULT,
	RemoveListener:        proc "stdcall" (this: ^IFontDownloadQueue, token: u32) -> HRESULT,
	IsEmpty:               proc "stdcall" (this: ^IFontDownloadQueue) -> BOOL,
	BeginDownload:         proc "stdcall" (this: ^IFontDownloadQueue, context_: ^IUnknown) -> HRESULT,
	CancelDownload:        proc "stdcall" (this: ^IFontDownloadQueue) -> HRESULT,
	GetGenerationCount:    proc "stdcall" (this: ^IFontDownloadQueue) -> u64,
}


IGdiInterop1_UUID_STRING := "4556be70-3abd-4f70-90be-421780a6f515"
IGdiInterop1_UUID := win32.IID{0x4556be70, 0x3abd, 0x4f70, {0x90, 0xbe, 0x42, 0x17, 0x80, 0xa6, 0xf5, 0x15}}
IGdiInterop1 :: struct #raw_union {
	#subtype igdiinterop:      IGdiInterop,
	using igdiinterop1_vtable: IGdiInterop1_VTable,
}
IGdiInterop1_VTable :: struct {
	using igdiinterop_vtable:  IGdiInterop_VTable,
	CreateFontFromLOGFONT1:    proc "stdcall" (this: ^IGdiInterop1, #by_ptr logFont: LOGFONTW, fontCollection: ^IFontCollection, font: ^^IFont) -> HRESULT,
	GetFontSignature_1:        proc "stdcall" (this: ^IGdiInterop1, fontFace: ^IFontFace, fontSignature: ^FONTSIGNATURE) -> HRESULT,
	GetFontSignature_2:        proc "stdcall" (this: ^IGdiInterop1, font: ^IFont, fontSignature: ^FONTSIGNATURE) -> HRESULT,
	GetMatchingFontsByLOGFONT: proc "stdcall" (this: ^IGdiInterop1, #by_ptr logFont: LOGFONTA, fontSet: ^IFontSet, filteredSet: ^^IFontSet) -> HRESULT,
}


LINE_METRICS1 :: struct {
	Base:          LINE_METRICS,
	leadingBefore: f32,
	leadingAfter:  f32,
}

FONT_LINE_GAP_USAGE :: enum i32 {
	DEFAULT,
	DISABLED,
	ENABLED,
}

LINE_SPACING :: struct {
	method:           LINE_SPACING_METHOD,
	height:           f32,
	baseline:         f32,
	leadingBefore:    f32,
	fontLineGapUsage: FONT_LINE_GAP_USAGE,
}

ITextFormat2_UUID_STRING := "f67e0edd-9e3d-4ecc-8c32-4183253dfe70"
ITextFormat2_UUID := win32.IID{0xf67e0edd, 0x9e3d, 0x4ecc, {0x8c, 0x32, 0x41, 0x83, 0x25, 0x3d, 0xfe, 0x70}}
ITextFormat2 :: struct #raw_union {
	#subtype itextformat1:     ITextFormat1,
	using itextformat2_vtable: ITextFormat2_VTable,
}
ITextFormat2_VTable :: struct {
	using itextformat1_vtable: ITextFormat1_VTable,
	SetLineSpacing2:           proc "stdcall" (this: ^ITextFormat2, #by_ptr lineSpacingOptions: LINE_SPACING) -> HRESULT,
	GetLineSpacing2:           proc "stdcall" (this: ^ITextFormat2, lineSpacingOptions: ^LINE_SPACING) -> HRESULT,
}


ITextLayout3_UUID_STRING := "07ddcd52-020e-4de8-ac33-6c953d83f92d"
ITextLayout3_UUID := win32.IID{0x07ddcd52, 0x020e, 0x4de8, {0xac, 0x33, 0x6c, 0x95, 0x3d, 0x83, 0xf9, 0x2d}}
ITextLayout3 :: struct #raw_union {
	#subtype itextlayout2:     ITextLayout2,
	using itextlayout3_vtable: ITextLayout3_VTable,
}
ITextLayout3_VTable :: struct {
	using itextlayout2_vtable: ITextLayout2_VTable,
	InvalidateLayout:          proc "stdcall" (this: ^ITextLayout3) -> HRESULT,
	SetLineSpacing3:           proc "stdcall" (this: ^ITextLayout3, #by_ptr lineSpacingOptions: LINE_SPACING) -> HRESULT,
	GetLineSpacing3:           proc "stdcall" (this: ^ITextLayout3, lineSpacingOptions: ^LINE_SPACING) -> HRESULT,
	GetLineMetrics3:           proc "stdcall" (this: ^ITextLayout3, lineMetrics: [^]LINE_METRICS1, maxLineCount: u32, actualLineCount: ^u32) -> HRESULT,
}


COLOR_GLYPH_RUN1 :: struct {
	Base:             COLOR_GLYPH_RUN,
	glyphImageFormat: GLYPH_IMAGE_FORMATS,
	measuringMode:    MEASURING_MODE,
}

GLYPH_IMAGE_DATA :: struct {
	imageData:             rawptr,
	imageDataSize:         u32,
	uniqueDataId:          u32,
	pixelsPerEm:           u32,
	// pixelSize:             d2d_common.SIZE_U,
	horizontalLeftOrigin:  POINT,
	horizontalRightOrigin: POINT,
	verticalTopOrigin:     POINT,
	verticalBottomOrigin:  POINT,
}

IColorGlyphRunEnumerator1_UUID_STRING := "7c5f86da-c7a1-4f05-b8e1-55a179fe5a35"
IColorGlyphRunEnumerator1_UUID := win32.IID{0x7c5f86da, 0xc7a1, 0x4f05, {0xb8, 0xe1, 0x55, 0xa1, 0x79, 0xfe, 0x5a, 0x35}}
IColorGlyphRunEnumerator1 :: struct #raw_union {
	#subtype icolorglyphrunenumerator:      IColorGlyphRunEnumerator,
	using icolorglyphrunenumerator1_vtable: IColorGlyphRunEnumerator1_VTable,
}
IColorGlyphRunEnumerator1_VTable :: struct {
	using icolorglyphrunenumerator_vtable: IColorGlyphRunEnumerator_VTable,
	GetCurrentRun1:                        proc "stdcall" (this: ^IColorGlyphRunEnumerator1, colorGlyphRun: ^^COLOR_GLYPH_RUN1) -> HRESULT,
}


IFontFace4_UUID_STRING := "27f2a904-4eb8-441d-9678-0563f53e3e2f"
IFontFace4_UUID := win32.IID{0x27f2a904, 0x4eb8, 0x441d, {0x96, 0x78, 0x05, 0x63, 0xf5, 0x3e, 0x3e, 0x2f}}
IFontFace4 :: struct #raw_union {
	#subtype ifontface3:     IFontFace3,
	using ifontface4_vtable: IFontFace4_VTable,
}
IFontFace4_VTable :: struct {
	using ifontface3_vtable: IFontFace3_VTable,
	GetGlyphImageFormats_1:  proc "stdcall" (this: ^IFontFace4, glyphId: u16, pixelsPerEmFirst: u32, pixelsPerEmLast: u32, glyphImageFormats: ^GLYPH_IMAGE_FORMATS) -> HRESULT,
	GetGlyphImageFormats_2:  proc "stdcall" (this: ^IFontFace4) -> GLYPH_IMAGE_FORMATS,
	GetGlyphImageData:       proc "stdcall" (
		this: ^IFontFace4,
		glyphId: u16,
		pixelsPerEm: u32,
		glyphImageFormat: GLYPH_IMAGE_FORMATS,
		glyphData: ^GLYPH_IMAGE_DATA,
		glyphDataContext: ^rawptr,
	) -> HRESULT,
	ReleaseGlyphImageData:   proc "stdcall" (this: ^IFontFace4, glyphDataContext: rawptr),
}


IFactory4_UUID_STRING := "4b0b5bd3-0797-4549-8ac5-fe915cc53856"
IFactory4_UUID := win32.IID{0x4b0b5bd3, 0x0797, 0x4549, {0x8a, 0xc5, 0xfe, 0x91, 0x5c, 0xc5, 0x38, 0x56}}
IFactory4 :: struct #raw_union {
	#subtype ifactory3:     IFactory3,
	using ifactory4_vtable: IFactory4_VTable,
}
IFactory4_VTable :: struct {
	using ifactory3_vtable:  IFactory3_VTable,
	TranslateColorGlyphRun4: proc "stdcall" (
		this: ^IFactory4,
		// baselineOrigin: d2d_common.POINT_2F,
		#by_ptr glyphRun: GLYPH_RUN,
		glyphRunDescription: ^GLYPH_RUN_DESCRIPTION,
		desiredGlyphImageFormats: GLYPH_IMAGE_FORMATS,
		measuringMode: MEASURING_MODE,
		worldAndDpiTransform: ^MATRIX,
		colorPaletteIndex: u32,
		colorLayers: ^^IColorGlyphRunEnumerator1,
	) -> HRESULT,
	ComputeGlyphOrigins_1:   proc "stdcall" (this: ^IFactory4, #by_ptr glyphRun: GLYPH_RUN, baselineOrigin: POINT_2F, glyphOrigins: ^POINT_2F) -> HRESULT,
	ComputeGlyphOrigins_2:   proc "stdcall" (
		this: ^IFactory4,
		#by_ptr glyphRun: GLYPH_RUN,
		measuringMode: MEASURING_MODE,
		baselineOrigin: POINT_2F,
		worldAndDpiTransform: ^MATRIX,
		glyphOrigins: ^POINT_2F,
	) -> HRESULT,
}


IFontSetBuilder1_UUID_STRING := "3ff7715f-3cdc-4dc6-9b72-ec5621dccafd"
IFontSetBuilder1_UUID := win32.IID{0x3ff7715f, 0x3cdc, 0x4dc6, {0x9b, 0x72, 0xec, 0x56, 0x21, 0xdc, 0xca, 0xfd}}
IFontSetBuilder1 :: struct #raw_union {
	#subtype ifontsetbuilder:      IFontSetBuilder,
	using ifontsetbuilder1_vtable: IFontSetBuilder1_VTable,
}
IFontSetBuilder1_VTable :: struct {
	using ifontsetbuilder_vtable: IFontSetBuilder_VTable,
	AddFontFile:                  proc "stdcall" (this: ^IFontSetBuilder1, fontFile: ^IFontFile) -> HRESULT,
}


IAsyncResult_UUID_STRING := "ce25f8fd-863b-4d13-9651-c1f88dc73fe2"
IAsyncResult_UUID := win32.IID{0xce25f8fd, 0x863b, 0x4d13, {0x96, 0x51, 0xc1, 0xf8, 0x8d, 0xc7, 0x3f, 0xe2}}
IAsyncResult :: struct #raw_union {
	#subtype iunknown:         IUnknown,
	using iasyncresult_vtable: IAsyncResult_VTable,
}
IAsyncResult_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	GetWaitHandle:         proc "stdcall" (this: ^IAsyncResult) -> HANDLE,
	GetResult:             proc "stdcall" (this: ^IAsyncResult) -> HRESULT,
}


FILE_FRAGMENT :: struct {
	fileOffset:   u64,
	fragmentSize: u64,
}

IRemoteFontFileStream_UUID_STRING := "4db3757a-2c72-4ed9-b2b6-1ababe1aff9c"
IRemoteFontFileStream_UUID := win32.IID{0x4db3757a, 0x2c72, 0x4ed9, {0xb2, 0xb6, 0x1a, 0xba, 0xbe, 0x1a, 0xff, 0x9c}}
IRemoteFontFileStream :: struct #raw_union {
	#subtype ifontfilestream:           IFontFileStream,
	using iremotefontfilestream_vtable: IRemoteFontFileStream_VTable,
}
IRemoteFontFileStream_VTable :: struct {
	using ifontfilestream_vtable: IFontFileStream_VTable,
	GetLocalFileSize:             proc "stdcall" (this: ^IRemoteFontFileStream, localFileSize: ^u64) -> HRESULT,
	GetFileFragmentLocality:      proc "stdcall" (this: ^IRemoteFontFileStream, fileOffset: u64, fragmentSize: u64, isLocal: ^BOOL, partialSize: ^u64) -> HRESULT,
	GetLocality:                  proc "stdcall" (this: ^IRemoteFontFileStream) -> LOCALITY,
	BeginDownload:                proc "stdcall" (
		this: ^IRemoteFontFileStream,
		#by_ptr downloadOperationID: win32.IID,
		fileFragments: [^]FILE_FRAGMENT,
		fragmentCount: u32,
		asyncResult: ^^IAsyncResult,
	) -> HRESULT,
}


CONTAINER_TYPE :: enum i32 {
	UNKNOWN,
	WOFF,
	WOFF2,
}

IRemoteFontFileLoader_UUID_STRING := "68648c83-6ede-46c0-ab46-20083a887fde"
IRemoteFontFileLoader_UUID := win32.IID{0x68648c83, 0x6ede, 0x46c0, {0xab, 0x46, 0x20, 0x08, 0x3a, 0x88, 0x7f, 0xde}}
IRemoteFontFileLoader :: struct #raw_union {
	#subtype ifontfileloader:           IFontFileLoader,
	using iremotefontfileloader_vtable: IRemoteFontFileLoader_VTable,
}
IRemoteFontFileLoader_VTable :: struct {
	using ifontfileloader_vtable:   IFontFileLoader_VTable,
	CreateRemoteStreamFromKey:      proc "stdcall" (
		this: ^IRemoteFontFileLoader,
		fontFileReferenceKey: rawptr,
		fontFileReferenceKeySize: u32,
		fontFileStream: ^^IRemoteFontFileStream,
	) -> HRESULT,
	GetLocalityFromKey:             proc "stdcall" (this: ^IRemoteFontFileLoader, fontFileReferenceKey: rawptr, fontFileReferenceKeySize: u32, locality: ^LOCALITY) -> HRESULT,
	CreateFontFileReferenceFromUrl: proc "stdcall" (this: ^IRemoteFontFileLoader, factory: ^IFactory, baseUrl: PWSTR, fontFileUrl: PWSTR, fontFile: ^^IFontFile) -> HRESULT,
}


IInMemoryFontFileLoader_UUID_STRING := "dc102f47-a12d-4b1c-822d-9e117e33043f"
IInMemoryFontFileLoader_UUID := win32.IID{0xdc102f47, 0xa12d, 0x4b1c, {0x82, 0x2d, 0x9e, 0x11, 0x7e, 0x33, 0x04, 0x3f}}
IInMemoryFontFileLoader :: struct #raw_union {
	#subtype ifontfileloader:             IFontFileLoader,
	using iinmemoryfontfileloader_vtable: IInMemoryFontFileLoader_VTable,
}
IInMemoryFontFileLoader_VTable :: struct {
	using ifontfileloader_vtable:    IFontFileLoader_VTable,
	CreateInMemoryFontFileReference: proc "stdcall" (
		this: ^IInMemoryFontFileLoader,
		factory: ^IFactory,
		fontData: rawptr,
		fontDataSize: u32,
		ownerObject: ^IUnknown,
		fontFile: ^^IFontFile,
	) -> HRESULT,
	GetFileCount:                    proc "stdcall" (this: ^IInMemoryFontFileLoader) -> u32,
}


IFactory5_UUID_STRING := "958db99a-be2a-4f09-af7d-65189803d1d3"
IFactory5_UUID := win32.IID{0x958db99a, 0xbe2a, 0x4f09, {0xaf, 0x7d, 0x65, 0x18, 0x98, 0x03, 0xd1, 0xd3}}
IFactory5 :: struct #raw_union {
	#subtype ifactory4:     IFactory4,
	using ifactory5_vtable: IFactory5_VTable,
}
IFactory5_VTable :: struct {
	using ifactory4_vtable:       IFactory4_VTable,
	CreateFontSetBuilder5:        proc "stdcall" (this: ^IFactory5, fontSetBuilder: ^^IFontSetBuilder1) -> HRESULT,
	CreateInMemoryFontFileLoader: proc "stdcall" (this: ^IFactory5, newLoader: ^^IInMemoryFontFileLoader) -> HRESULT,
	CreateHttpFontFileLoader:     proc "stdcall" (this: ^IFactory5, referrerUrl: PWSTR, extraHeaders: PWSTR, newLoader: ^^IRemoteFontFileLoader) -> HRESULT,
	AnalyzeContainerType:         proc "stdcall" (this: ^IFactory5, fileData: rawptr, fileDataSize: u32) -> CONTAINER_TYPE,
	UnpackFontFile:               proc "stdcall" (
		this: ^IFactory5,
		containerType: CONTAINER_TYPE,
		fileData: rawptr,
		fileDataSize: u32,
		unpackedFontStream: ^^IFontFileStream,
	) -> HRESULT,
}


FONT_AXIS_VALUE :: struct {
	axisTag: FONT_AXIS_TAG,
	value:   f32,
}

FONT_AXIS_RANGE :: struct {
	axisTag:  FONT_AXIS_TAG,
	minValue: f32,
	maxValue: f32,
}

FONT_FAMILY_MODEL :: enum i32 {
	TYPOGRAPHIC,
	WEIGHT_STRETCH_STYLE,
}

AUTOMATIC_FONT_AXES_Flag :: enum {
	OPTICAL_SIZE = 1,
}
AUTOMATIC_FONT_AXES :: bit_set[AUTOMATIC_FONT_AXES_Flag;u32]

FONT_AXIS_ATTRIBUTES_Flag :: enum {
	VARIABLE = 1,
	HIDDEN   = 2,
}
FONT_AXIS_ATTRIBUTES :: bit_set[FONT_AXIS_ATTRIBUTES_Flag;u32]

IFactory6_UUID_STRING := "f3744d80-21f7-42eb-b35d-995bc72fc223"
IFactory6_UUID := win32.IID{0xf3744d80, 0x21f7, 0x42eb, {0xb3, 0x5d, 0x99, 0x5b, 0xc7, 0x2f, 0xc2, 0x23}}
IFactory6 :: struct #raw_union {
	#subtype ifactory5:     IFactory5,
	using ifactory6_vtable: IFactory6_VTable,
}
IFactory6_VTable :: struct {
	using ifactory5_vtable:           IFactory5_VTable,
	CreateFontFaceReference6:         proc "stdcall" (
		this: ^IFactory6,
		fontFile: ^IFontFile,
		faceIndex: u32,
		fontSimulations: FONT_SIMULATIONS,
		fontAxisValues: [^]FONT_AXIS_VALUE,
		fontAxisValueCount: u32,
		fontFaceReference: ^^IFontFaceReference1,
	) -> HRESULT,
	CreateFontResource:               proc "stdcall" (this: ^IFactory6, fontFile: ^IFontFile, faceIndex: u32, fontResource: ^^IFontResource) -> HRESULT,
	GetSystemFontSet6:                proc "stdcall" (this: ^IFactory6, includeDownloadableFonts: BOOL, fontSet: ^^IFontSet1) -> HRESULT,
	GetSystemFontCollection6:         proc "stdcall" (
		this: ^IFactory6,
		includeDownloadableFonts: BOOL,
		fontFamilyModel: FONT_FAMILY_MODEL,
		fontCollection: ^^IFontCollection2,
	) -> HRESULT,
	CreateFontCollectionFromFontSet6: proc "stdcall" (this: ^IFactory6, fontSet: ^IFontSet, fontFamilyModel: FONT_FAMILY_MODEL, fontCollection: ^^IFontCollection2) -> HRESULT,
	CreateFontSetBuilder6:            proc "stdcall" (this: ^IFactory6, fontSetBuilder: ^^IFontSetBuilder2) -> HRESULT,
	CreateTextFormat6:                proc "stdcall" (
		this: ^IFactory6,
		fontFamilyName: PWSTR,
		fontCollection: ^IFontCollection,
		fontAxisValues: [^]FONT_AXIS_VALUE,
		fontAxisValueCount: u32,
		fontSize: f32,
		localeName: PWSTR,
		textFormat: ^^ITextFormat3,
	) -> HRESULT,
}


IFontFace5_UUID_STRING := "98eff3a5-b667-479a-b145-e2fa5b9fdc29"
IFontFace5_UUID := win32.IID{0x98eff3a5, 0xb667, 0x479a, {0xb1, 0x45, 0xe2, 0xfa, 0x5b, 0x9f, 0xdc, 0x29}}
IFontFace5 :: struct #raw_union {
	#subtype ifontface4:     IFontFace4,
	using ifontface5_vtable: IFontFace5_VTable,
}
IFontFace5_VTable :: struct {
	using ifontface4_vtable: IFontFace4_VTable,
	GetFontAxisValueCount:   proc "stdcall" (this: ^IFontFace5) -> u32,
	GetFontAxisValues:       proc "stdcall" (this: ^IFontFace5, fontAxisValues: [^]FONT_AXIS_VALUE, fontAxisValueCount: u32) -> HRESULT,
	HasVariations:           proc "stdcall" (this: ^IFontFace5) -> BOOL,
	GetFontResource:         proc "stdcall" (this: ^IFontFace5, fontResource: ^^IFontResource) -> HRESULT,
	Equals:                  proc "stdcall" (this: ^IFontFace5, fontFace: ^IFontFace) -> BOOL,
}


IFontResource_UUID_STRING := "1f803a76-6871-48e8-987f-b975551c50f2"
IFontResource_UUID := win32.IID{0x1f803a76, 0x6871, 0x48e8, {0x98, 0x7f, 0xb9, 0x75, 0x55, 0x1c, 0x50, 0xf2}}
IFontResource :: struct #raw_union {
	#subtype iunknown:          IUnknown,
	using ifontresource_vtable: IFontResource_VTable,
}
IFontResource_VTable :: struct {
	using iunknown_vtable:    IUnknown_VTable,
	GetFontFile:              proc "stdcall" (this: ^IFontResource, fontFile: ^^IFontFile) -> HRESULT,
	GetFontFaceIndex:         proc "stdcall" (this: ^IFontResource) -> u32,
	GetFontAxisCount:         proc "stdcall" (this: ^IFontResource) -> u32,
	GetDefaultFontAxisValues: proc "stdcall" (this: ^IFontResource, fontAxisValues: [^]FONT_AXIS_VALUE, fontAxisValueCount: u32) -> HRESULT,
	GetFontAxisRanges:        proc "stdcall" (this: ^IFontResource, fontAxisRanges: [^]FONT_AXIS_RANGE, fontAxisRangeCount: u32) -> HRESULT,
	GetFontAxisAttributes:    proc "stdcall" (this: ^IFontResource, axisIndex: u32) -> FONT_AXIS_ATTRIBUTES,
	GetAxisNames:             proc "stdcall" (this: ^IFontResource, axisIndex: u32, names: ^^ILocalizedStrings) -> HRESULT,
	GetAxisValueNameCount:    proc "stdcall" (this: ^IFontResource, axisIndex: u32) -> u32,
	GetAxisValueNames:        proc "stdcall" (this: ^IFontResource, axisIndex: u32, axisValueIndex: u32, fontAxisRange: ^FONT_AXIS_RANGE, names: ^^ILocalizedStrings) -> HRESULT,
	HasVariations:            proc "stdcall" (this: ^IFontResource) -> BOOL,
	CreateFontFace:           proc "stdcall" (
		this: ^IFontResource,
		fontSimulations: FONT_SIMULATIONS,
		fontAxisValues: [^]FONT_AXIS_VALUE,
		fontAxisValueCount: u32,
		fontFace: ^^IFontFace5,
	) -> HRESULT,
	CreateFontFaceReference:  proc "stdcall" (
		this: ^IFontResource,
		fontSimulations: FONT_SIMULATIONS,
		fontAxisValues: [^]FONT_AXIS_VALUE,
		fontAxisValueCount: u32,
		fontFaceReference: ^^IFontFaceReference1,
	) -> HRESULT,
}


IFontFaceReference1_UUID_STRING := "c081fe77-2fd1-41ac-a5a3-34983c4ba61a"
IFontFaceReference1_UUID := win32.IID{0xc081fe77, 0x2fd1, 0x41ac, {0xa5, 0xa3, 0x34, 0x98, 0x3c, 0x4b, 0xa6, 0x1a}}
IFontFaceReference1 :: struct #raw_union {
	#subtype ifontfacereference:      IFontFaceReference,
	using ifontfacereference1_vtable: IFontFaceReference1_VTable,
}
IFontFaceReference1_VTable :: struct {
	using ifontfacereference_vtable: IFontFaceReference_VTable,
	CreateFontFace1:                 proc "stdcall" (this: ^IFontFaceReference1, fontFace: ^^IFontFace5) -> HRESULT,
	GetFontAxisValueCount:           proc "stdcall" (this: ^IFontFaceReference1) -> u32,
	GetFontAxisValues:               proc "stdcall" (this: ^IFontFaceReference1, fontAxisValues: [^]FONT_AXIS_VALUE, fontAxisValueCount: u32) -> HRESULT,
}


IFontSetBuilder2_UUID_STRING := "ee5ba612-b131-463c-8f4f-3189b9401e45"
IFontSetBuilder2_UUID := win32.IID{0xee5ba612, 0xb131, 0x463c, {0x8f, 0x4f, 0x31, 0x89, 0xb9, 0x40, 0x1e, 0x45}}
IFontSetBuilder2 :: struct #raw_union {
	#subtype ifontsetbuilder1:     IFontSetBuilder1,
	using ifontsetbuilder2_vtable: IFontSetBuilder2_VTable,
}
IFontSetBuilder2_VTable :: struct {
	using ifontsetbuilder1_vtable: IFontSetBuilder1_VTable,
	AddFont:                       proc "stdcall" (
		this: ^IFontSetBuilder2,
		fontFile: ^IFontFile,
		fontFaceIndex: u32,
		fontSimulations: FONT_SIMULATIONS,
		fontAxisValues: [^]FONT_AXIS_VALUE,
		fontAxisValueCount: u32,
		fontAxisRanges: [^]FONT_AXIS_RANGE,
		fontAxisRangeCount: u32,
		properties: [^]FONT_PROPERTY,
		propertyCount: u32,
	) -> HRESULT,
	AddFontFile2:                  proc "stdcall" (this: ^IFontSetBuilder2, filePath: PWSTR) -> HRESULT,
}


IFontSet1_UUID_STRING := "7e9fda85-6c92-4053-bc47-7ae3530db4d3"
IFontSet1_UUID := win32.IID{0x7e9fda85, 0x6c92, 0x4053, {0xbc, 0x47, 0x7a, 0xe3, 0x53, 0x0d, 0xb4, 0xd3}}
IFontSet1 :: struct #raw_union {
	#subtype ifontset:      IFontSet,
	using ifontset1_vtable: IFontSet1_VTable,
}
IFontSet1_VTable :: struct {
	using ifontset_vtable:    IFontSet_VTable,
	GetMatchingFonts:         proc "stdcall" (
		this: ^IFontSet1,
		fontProperty: ^FONT_PROPERTY,
		fontAxisValues: [^]FONT_AXIS_VALUE,
		fontAxisValueCount: u32,
		matchingFonts: ^^IFontSet1,
	) -> HRESULT,
	GetFirstFontResources:    proc "stdcall" (this: ^IFontSet1, filteredFontSet: ^^IFontSet1) -> HRESULT,
	GetFilteredFonts_1:       proc "stdcall" (this: ^IFontSet1, indices: [^]u32, indexCount: u32, filteredFontSet: ^^IFontSet1) -> HRESULT,
	GetFilteredFonts_2:       proc "stdcall" (
		this: ^IFontSet1,
		fontAxisRanges: [^]FONT_AXIS_RANGE,
		fontAxisRangeCount: u32,
		selectAnyRange: BOOL,
		filteredFontSet: ^^IFontSet1,
	) -> HRESULT,
	GetFilteredFonts_3:       proc "stdcall" (this: ^IFontSet1, properties: [^]FONT_PROPERTY, propertyCount: u32, selectAnyProperty: BOOL, filteredFontSet: ^^IFontSet1) -> HRESULT,
	GetFilteredFontIndices_1: proc "stdcall" (
		this: ^IFontSet1,
		fontAxisRanges: [^]FONT_AXIS_RANGE,
		fontAxisRangeCount: u32,
		selectAnyRange: BOOL,
		indices: [^]u32,
		maxIndexCount: u32,
		actualIndexCount: ^u32,
	) -> HRESULT,
	GetFilteredFontIndices_2: proc "stdcall" (
		this: ^IFontSet1,
		properties: [^]FONT_PROPERTY,
		propertyCount: u32,
		selectAnyProperty: BOOL,
		indices: [^]u32,
		maxIndexCount: u32,
		actualIndexCount: ^u32,
	) -> HRESULT,
	GetFontAxisRanges_1:      proc "stdcall" (
		this: ^IFontSet1,
		listIndex: u32,
		fontAxisRanges: [^]FONT_AXIS_RANGE,
		maxFontAxisRangeCount: u32,
		actualFontAxisRangeCount: ^u32,
	) -> HRESULT,
	GetFontAxisRanges_2:      proc "stdcall" (this: ^IFontSet1, fontAxisRanges: [^]FONT_AXIS_RANGE, maxFontAxisRangeCount: u32, actualFontAxisRangeCount: ^u32) -> HRESULT,
	GetFontFaceReference1:    proc "stdcall" (this: ^IFontSet1, listIndex: u32, fontFaceReference: ^^IFontFaceReference1) -> HRESULT,
	CreateFontResource:       proc "stdcall" (this: ^IFontSet1, listIndex: u32, fontResource: ^^IFontResource) -> HRESULT,
	CreateFontFace:           proc "stdcall" (this: ^IFontSet1, listIndex: u32, fontFace: ^^IFontFace5) -> HRESULT,
	GetFontLocality:          proc "stdcall" (this: ^IFontSet1, listIndex: u32) -> LOCALITY,
}


IFontList2_UUID_STRING := "c0763a34-77af-445a-b735-08c37b0a5bf5"
IFontList2_UUID := win32.IID{0xc0763a34, 0x77af, 0x445a, {0xb7, 0x35, 0x08, 0xc3, 0x7b, 0x0a, 0x5b, 0xf5}}
IFontList2 :: struct #raw_union {
	#subtype ifontlist1:     IFontList1,
	using ifontlist2_vtable: IFontList2_VTable,
}
IFontList2_VTable :: struct {
	using ifontlist1_vtable: IFontList1_VTable,
	GetFontSet:              proc "stdcall" (this: ^IFontList2, fontSet: ^^IFontSet1) -> HRESULT,
}


IFontFamily2_UUID_STRING := "3ed49e77-a398-4261-b9cf-c126c2131ef3"
IFontFamily2_UUID := win32.IID{0x3ed49e77, 0xa398, 0x4261, {0xb9, 0xcf, 0xc1, 0x26, 0xc2, 0x13, 0x1e, 0xf3}}
IFontFamily2 :: struct #raw_union {
	#subtype ifontfamily1:     IFontFamily1,
	using ifontfamily2_vtable: IFontFamily2_VTable,
}
IFontFamily2_VTable :: struct {
	using ifontfamily1_vtable: IFontFamily1_VTable,
	GetMatchingFonts2:         proc "stdcall" (this: ^IFontFamily2, fontAxisValues: [^]FONT_AXIS_VALUE, fontAxisValueCount: u32, matchingFonts: ^^IFontList2) -> HRESULT,
	GetFontSet:                proc "stdcall" (this: ^IFontFamily2, fontSet: ^^IFontSet1) -> HRESULT,
}


IFontCollection2_UUID_STRING := "514039c6-4617-4064-bf8b-92ea83e506e0"
IFontCollection2_UUID := win32.IID{0x514039c6, 0x4617, 0x4064, {0xbf, 0x8b, 0x92, 0xea, 0x83, 0xe5, 0x06, 0xe0}}
IFontCollection2 :: struct #raw_union {
	#subtype ifontcollection1:     IFontCollection1,
	using ifontcollection2_vtable: IFontCollection2_VTable,
}
IFontCollection2_VTable :: struct {
	using ifontcollection1_vtable: IFontCollection1_VTable,
	GetFontFamily2:                proc "stdcall" (this: ^IFontCollection2, index: u32, fontFamily: ^^IFontFamily2) -> HRESULT,
	GetMatchingFonts:              proc "stdcall" (
		this: ^IFontCollection2,
		familyName: PWSTR,
		fontAxisValues: [^]FONT_AXIS_VALUE,
		fontAxisValueCount: u32,
		fontList: ^^IFontList2,
	) -> HRESULT,
	GetFontFamilyModel:            proc "stdcall" (this: ^IFontCollection2) -> FONT_FAMILY_MODEL,
	GetFontSet2:                   proc "stdcall" (this: ^IFontCollection2, fontSet: ^^IFontSet1) -> HRESULT,
}


ITextLayout4_UUID_STRING := "05a9bf42-223f-4441-b5fb-8263685f55e9"
ITextLayout4_UUID := win32.IID{0x05a9bf42, 0x223f, 0x4441, {0xb5, 0xfb, 0x82, 0x63, 0x68, 0x5f, 0x55, 0xe9}}
ITextLayout4 :: struct #raw_union {
	#subtype itextlayout3:     ITextLayout3,
	using itextlayout4_vtable: ITextLayout4_VTable,
}
ITextLayout4_VTable :: struct {
	using itextlayout3_vtable: ITextLayout3_VTable,
	SetFontAxisValues:         proc "stdcall" (this: ^ITextLayout4, fontAxisValues: [^]FONT_AXIS_VALUE, fontAxisValueCount: u32, textRange: TEXT_RANGE) -> HRESULT,
	GetFontAxisValueCount:     proc "stdcall" (this: ^ITextLayout4, currentPosition: u32) -> u32,
	GetFontAxisValues:         proc "stdcall" (
		this: ^ITextLayout4,
		currentPosition: u32,
		fontAxisValues: [^]FONT_AXIS_VALUE,
		fontAxisValueCount: u32,
		textRange: ^TEXT_RANGE,
	) -> HRESULT,
	GetAutomaticFontAxes:      proc "stdcall" (this: ^ITextLayout4) -> AUTOMATIC_FONT_AXES,
	SetAutomaticFontAxes:      proc "stdcall" (this: ^ITextLayout4, automaticFontAxes: AUTOMATIC_FONT_AXES) -> HRESULT,
}


ITextFormat3_UUID_STRING := "6d3b5641-e550-430d-a85b-b7bf48a93427"
ITextFormat3_UUID := win32.IID{0x6d3b5641, 0xe550, 0x430d, {0xa8, 0x5b, 0xb7, 0xbf, 0x48, 0xa9, 0x34, 0x27}}
ITextFormat3 :: struct #raw_union {
	#subtype itextformat2:     ITextFormat2,
	using itextformat3_vtable: ITextFormat3_VTable,
}
ITextFormat3_VTable :: struct {
	using itextformat2_vtable: ITextFormat2_VTable,
	SetFontAxisValues:         proc "stdcall" (this: ^ITextFormat3, fontAxisValues: [^]FONT_AXIS_VALUE, fontAxisValueCount: u32) -> HRESULT,
	GetFontAxisValueCount:     proc "stdcall" (this: ^ITextFormat3) -> u32,
	GetFontAxisValues:         proc "stdcall" (this: ^ITextFormat3, fontAxisValues: [^]FONT_AXIS_VALUE, fontAxisValueCount: u32) -> HRESULT,
	GetAutomaticFontAxes:      proc "stdcall" (this: ^ITextFormat3) -> AUTOMATIC_FONT_AXES,
	SetAutomaticFontAxes:      proc "stdcall" (this: ^ITextFormat3, automaticFontAxes: AUTOMATIC_FONT_AXES) -> HRESULT,
}


IFontFallback1_UUID_STRING := "2397599d-dd0d-4681-bd6a-f4f31eaade77"
IFontFallback1_UUID := win32.IID{0x2397599d, 0xdd0d, 0x4681, {0xbd, 0x6a, 0xf4, 0xf3, 0x1e, 0xaa, 0xde, 0x77}}
IFontFallback1 :: struct #raw_union {
	#subtype ifontfallback:      IFontFallback,
	using ifontfallback1_vtable: IFontFallback1_VTable,
}
IFontFallback1_VTable :: struct {
	using ifontfallback_vtable: IFontFallback_VTable,
	MapCharacters1:             proc "stdcall" (
		this: ^IFontFallback1,
		analysisSource: ^ITextAnalysisSource,
		textPosition: u32,
		textLength: u32,
		baseFontCollection: ^IFontCollection,
		baseFamilyName: PWSTR,
		fontAxisValues: [^]FONT_AXIS_VALUE,
		fontAxisValueCount: u32,
		mappedLength: ^u32,
		scale: ^f32,
		mappedFontFace: ^^IFontFace5,
	) -> HRESULT,
}


IFontSet2_UUID_STRING := "dc7ead19-e54c-43af-b2da-4e2b79ba3f7f"
IFontSet2_UUID := win32.IID{0xdc7ead19, 0xe54c, 0x43af, {0xb2, 0xda, 0x4e, 0x2b, 0x79, 0xba, 0x3f, 0x7f}}
IFontSet2 :: struct #raw_union {
	#subtype ifontset1:     IFontSet1,
	using ifontset2_vtable: IFontSet2_VTable,
}
IFontSet2_VTable :: struct {
	using ifontset1_vtable: IFontSet1_VTable,
	GetExpirationEvent:     proc "stdcall" (this: ^IFontSet2) -> HANDLE,
}


IFontCollection3_UUID_STRING := "a4d055a6-f9e3-4e25-93b7-9e309f3af8e9"
IFontCollection3_UUID := win32.IID{0xa4d055a6, 0xf9e3, 0x4e25, {0x93, 0xb7, 0x9e, 0x30, 0x9f, 0x3a, 0xf8, 0xe9}}
IFontCollection3 :: struct #raw_union {
	#subtype ifontcollection2:     IFontCollection2,
	using ifontcollection3_vtable: IFontCollection3_VTable,
}
IFontCollection3_VTable :: struct {
	using ifontcollection2_vtable: IFontCollection2_VTable,
	GetExpirationEvent:            proc "stdcall" (this: ^IFontCollection3) -> HANDLE,
}


IFactory7_UUID_STRING := "35d0e0b3-9076-4d2e-a016-a91b568a06b4"
IFactory7_UUID := win32.IID{0x35d0e0b3, 0x9076, 0x4d2e, {0xa0, 0x16, 0xa9, 0x1b, 0x56, 0x8a, 0x06, 0xb4}}
IFactory7 :: struct #raw_union {
	#subtype ifactory6:     IFactory6,
	using ifactory7_vtable: IFactory7_VTable,
}
IFactory7_VTable :: struct {
	using ifactory6_vtable:   IFactory6_VTable,
	GetSystemFontSet7:        proc "stdcall" (this: ^IFactory7, includeDownloadableFonts: BOOL, fontSet: ^^IFontSet2) -> HRESULT,
	GetSystemFontCollection7: proc "stdcall" (this: ^IFactory7, includeDownloadableFonts: BOOL, fontFamilyModel: FONT_FAMILY_MODEL, fontCollection: ^^IFontCollection3) -> HRESULT,
}


FONT_SOURCE_TYPE :: enum i32 {
	UNKNOWN,
	PER_MACHINE,
	PER_USER,
	APPX_PACKAGE,
	REMOTE_FONT_PROVIDER,
}

IFontSet3_UUID_STRING := "7c073ef2-a7f4-4045-8c32-8ab8ae640f90"
IFontSet3_UUID := win32.IID{0x7c073ef2, 0xa7f4, 0x4045, {0x8c, 0x32, 0x8a, 0xb8, 0xae, 0x64, 0x0f, 0x90}}
IFontSet3 :: struct #raw_union {
	#subtype ifontset2:     IFontSet2,
	using ifontset3_vtable: IFontSet3_VTable,
}
IFontSet3_VTable :: struct {
	using ifontset2_vtable:  IFontSet2_VTable,
	GetFontSourceType:       proc "stdcall" (this: ^IFontSet3, fontIndex: u32) -> FONT_SOURCE_TYPE,
	GetFontSourceNameLength: proc "stdcall" (this: ^IFontSet3, listIndex: u32) -> u32,
	GetFontSourceName:       proc "stdcall" (this: ^IFontSet3, listIndex: u32, stringBuffer: [^]u8, stringBufferSize: u32) -> HRESULT,
}


IFontFace6_UUID_STRING := "c4b1fe1b-6e84-47d5-b54c-a597981b06ad"
IFontFace6_UUID := win32.IID{0xc4b1fe1b, 0x6e84, 0x47d5, {0xb5, 0x4c, 0xa5, 0x97, 0x98, 0x1b, 0x06, 0xad}}
IFontFace6 :: struct #raw_union {
	#subtype ifontface5:     IFontFace5,
	using ifontface6_vtable: IFontFace6_VTable,
}
IFontFace6_VTable :: struct {
	using ifontface5_vtable: IFontFace5_VTable,
	GetFamilyNames6:         proc "stdcall" (this: ^IFontFace6, fontFamilyModel: FONT_FAMILY_MODEL, names: ^^ILocalizedStrings) -> HRESULT,
	GetFaceNames6:           proc "stdcall" (this: ^IFontFace6, fontFamilyModel: FONT_FAMILY_MODEL, names: ^^ILocalizedStrings) -> HRESULT,
}