package dwrite_wrapper

import "core:fmt"

import win32 "core:sys/windows"
import "vendor:directx/dxgi"

foreign import Dwrite "system:Dwrite.lib"

@(default_calling_convention="stdcall")
foreign Dwrite {
	DWriteCreateFactory :: proc(factoryType: FACTORY_TYPE, iid: win32.REFIID, factory: ^^IUnknown) -> win32.HRESULT ---
}



POINT_2F :: struct {
	x: f32,
	y: f32,
}


LF_FACESIZE :: 32

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

BOOL :: win32.BOOL
HDC :: win32.HDC
HMONITOR :: win32.HMONITOR
RECT :: win32.RECT
PWSTR :: win32.wstring
FILETIME :: win32.FILETIME
SIZE :: win32.SIZE

MEASURING_MODE :: enum i32 {
	NATURAL,
	GDI_CLASSIC,
	GDI_NATURAL,
}

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

FONT_FACE_TYPE :: enum win32.DWORD {
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

FONT_SIMULATIONS_Flag :: enum win32.DWORD {
	BOLD    = 1,
	OBLIQUE = 2,
}
FONT_SIMULATIONS :: bit_set[FONT_SIMULATIONS_Flag;win32.DWORD]

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
	using ifontfileloader_vtable: ^IFontFileLoader_VTable,
}
IFontFileLoader_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	CreateStreamFromKey:   proc "stdcall" (this: ^IFontFileLoader, fontFileReferenceKey: rawptr, fontFileReferenceKeySize: u32, fontFileStream: ^^IFontFileStream) -> win32.HRESULT,
}

IFontFileStream_UUID_STRING := "6d4865fe-0ab8-4d91-8f62-5dd6be34a3e0"
IFontFileStream_UUID := win32.IID{0x6d4865fe, 0x0ab8, 0x4d91, {0x8f, 0x62, 0x5d, 0xd6, 0xbe, 0x34, 0xa3, 0xe0}}
IFontFileStream :: struct #raw_union {
	#subtype iunknown:            IUnknown,
	using ifontfilestream_vtable: ^IFontFileStream_VTable,
}
IFontFileStream_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	ReadFileFragment:      proc "stdcall" (this: ^IFontFileStream, fragmentStart: ^rawptr, fileOffset: u64, fragmentSize: u64, fragmentContext: ^rawptr) -> win32.HRESULT,
	ReleaseFileFragment:   proc "stdcall" (this: ^IFontFileStream, fragmentContext: rawptr),
	GetFileSize:           proc "stdcall" (this: ^IFontFileStream, fileSize: ^u64) -> win32.HRESULT,
	GetLastWriteTime:      proc "stdcall" (this: ^IFontFileStream, lastWriteTime: ^u64) -> win32.HRESULT,
}


IFontFile_UUID_STRING := "739d886a-cef5-47dc-8769-1a8b41bebbb0"
IFontFile_UUID := win32.IID{0x739d886a, 0xcef5, 0x47dc, {0x87, 0x69, 0x1a, 0x8b, 0x41, 0xbe, 0xbb, 0xb0}}
IFontFile :: struct #raw_union {
	#subtype iunknown:      IUnknown,
	using ifontfile_vtable: ^IFontFile_VTable,
}
IFontFile_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	GetReferenceKey:       proc "stdcall" (this: ^IFontFile, fontFileReferenceKey: ^rawptr, fontFileReferenceKeySize: ^u32) -> win32.HRESULT,
	GetLoader:             proc "stdcall" (this: ^IFontFile, fontFileLoader: ^^IFontFileLoader) -> win32.HRESULT,
	Analyze:               proc "stdcall" (
		this: ^IFontFile,
		isSupportedFontType: ^BOOL,
		fontFileType: ^FONT_FILE_TYPE,
		fontFaceType: ^FONT_FACE_TYPE,
		numberOfFaces: ^u32,
	) -> win32.HRESULT,
}


PIXEL_GEOMETRY :: enum win32.DWORD {
	FLAT,
	RGB,
	BGR,
}

RENDERING_MODE :: enum win32.DWORD {
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
	using irenderingparams_vtable: ^IRenderingParams_VTable,
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
	using ifontface_vtable: ^IFontFace_VTable,
}
IFontFace_VTable :: struct {
	using iunknown_vtable:        IUnknown_VTable,
	GetType:                      proc "stdcall" (this: ^IFontFace) -> FONT_FACE_TYPE,
	GetFiles:                     proc "stdcall" (this: ^IFontFace, numberOfFiles: ^u32, fontFiles: [^]^IFontFile) -> win32.HRESULT,
	GetIndex:                     proc "stdcall" (this: ^IFontFace) -> u32,
	GetSimulations:               proc "stdcall" (this: ^IFontFace) -> FONT_SIMULATIONS,
	IsSymbolFont:                 proc "stdcall" (this: ^IFontFace) -> BOOL,
	GetMetrics:                   proc "stdcall" (this: ^IFontFace, fontFaceMetrics: ^FONT_METRICS),
	GetGlyphCount:                proc "stdcall" (this: ^IFontFace) -> u16,
	GetDesignGlyphMetrics:        proc "stdcall" (this: ^IFontFace, glyphIndices: [^]u16, glyphCount: u32, glyphMetrics: [^]GLYPH_METRICS, isSideways: BOOL) -> win32.HRESULT,
	GetGlyphIndices:              proc "stdcall" (this: ^IFontFace, codePoints: [^]u32, codePointCount: u32, glyphIndices: [^]u16) -> win32.HRESULT,
	TryGetFontTable:              proc "stdcall" (this: ^IFontFace, openTypeTableTag: u32, tableData: ^rawptr, tableSize: ^u32, tableContext: ^rawptr, exists: ^BOOL) -> win32.HRESULT,
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
		geometrySink: ^ISimplifiedGeometrySink,
	) -> win32.HRESULT,
	GetRecommendedRenderingMode:  proc "stdcall" (
		this: ^IFontFace,
		emSize: f32,
		pixelsPerDip: f32,
		measuringMode: MEASURING_MODE,
		renderingParams: ^IRenderingParams,
		renderingMode: ^RENDERING_MODE,
	) -> win32.HRESULT,
	GetGdiCompatibleMetrics:      proc "stdcall" (this: ^IFontFace, emSize: f32, pixelsPerDip: f32, transform: ^MATRIX, fontFaceMetrics: ^FONT_METRICS) -> win32.HRESULT,
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
	) -> win32.HRESULT,
}


IFontCollectionLoader_UUID_STRING := "cca920e4-52f0-492b-bfa8-29c72ee0a468"
IFontCollectionLoader_UUID := win32.IID{0xcca920e4, 0x52f0, 0x492b, {0xbf, 0xa8, 0x29, 0xc7, 0x2e, 0xe0, 0xa4, 0x68}}
IFontCollectionLoader :: struct #raw_union {
	#subtype iunknown:                  IUnknown,
	using ifontcollectionloader_vtable: ^IFontCollectionLoader_VTable,
}
IFontCollectionLoader_VTable :: struct {
	using iunknown_vtable:   IUnknown_VTable,
	CreateEnumeratorFromKey: proc "stdcall" (
		this: ^IFontCollectionLoader,
		factory: ^IFactory,
		collectionKey: rawptr,
		collectionKeySize: u32,
		fontFileEnumerator: ^^IFontFileEnumerator,
	) -> win32.HRESULT,
}


IFontFileEnumerator_UUID_STRING := "72755049-5ff7-435d-8348-4be97cfa6c7c"
IFontFileEnumerator_UUID := win32.IID{0x72755049, 0x5ff7, 0x435d, {0x83, 0x48, 0x4b, 0xe9, 0x7c, 0xfa, 0x6c, 0x7c}}
IFontFileEnumerator :: struct #raw_union {
	#subtype iunknown:                IUnknown,
	using ifontfileenumerator_vtable: ^IFontFileEnumerator_VTable,
}
IFontFileEnumerator_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	MoveNext:              proc "stdcall" (this: ^IFontFileEnumerator, hasCurrentFile: ^BOOL) -> win32.HRESULT,
	GetCurrentFontFile:    proc "stdcall" (this: ^IFontFileEnumerator, fontFile: ^^IFontFile) -> win32.HRESULT,
}


ILocalizedStrings_UUID_STRING := "08256209-099a-4b34-b86d-c22b110e7771"
ILocalizedStrings_UUID := win32.IID{0x08256209, 0x099a, 0x4b34, {0xb8, 0x6d, 0xc2, 0x2b, 0x11, 0x0e, 0x77, 0x71}}
ILocalizedStrings :: struct #raw_union {
	#subtype iunknown:              IUnknown,
	using ilocalizedstrings_vtable: ^ILocalizedStrings_VTable,
}
ILocalizedStrings_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	GetCount:              proc "stdcall" (this: ^ILocalizedStrings) -> u32,
	FindLocaleName:        proc "stdcall" (this: ^ILocalizedStrings, localeName: PWSTR, index: ^u32, exists: ^BOOL) -> win32.HRESULT,
	GetLocaleNameLength:   proc "stdcall" (this: ^ILocalizedStrings, index: u32, length: ^u32) -> win32.HRESULT,
	GetLocaleName:         proc "stdcall" (this: ^ILocalizedStrings, index: u32, localeName: [^]u8, size: u32) -> win32.HRESULT,
	GetStringLength:       proc "stdcall" (this: ^ILocalizedStrings, index: u32, length: ^u32) -> win32.HRESULT,
	GetString:             proc "stdcall" (this: ^ILocalizedStrings, index: u32, stringBuffer: [^]u8, size: u32) -> win32.HRESULT,
}


IFontCollection_UUID_STRING := "a84cee02-3eea-4eee-a827-87c1a02a0fcc"
IFontCollection_UUID := win32.IID{0xa84cee02, 0x3eea, 0x4eee, {0xa8, 0x27, 0x87, 0xc1, 0xa0, 0x2a, 0x0f, 0xcc}}
IFontCollection :: struct #raw_union {
	#subtype iunknown:            IUnknown,
	using ifontcollection_vtable: ^IFontCollection_VTable,
}
IFontCollection_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	GetFontFamilyCount:    proc "stdcall" (this: ^IFontCollection) -> u32,
	GetFontFamily:         proc "stdcall" (this: ^IFontCollection, index: u32, fontFamily: ^^IFontFamily) -> win32.HRESULT,
	FindFamilyName:        proc "stdcall" (this: ^IFontCollection, familyName: PWSTR, index: ^u32, exists: ^BOOL) -> win32.HRESULT,
	GetFontFromFontFace:   proc "stdcall" (this: ^IFontCollection, fontFace: ^IFontFace, font: ^^IFont) -> win32.HRESULT,
}


IFontList_UUID_STRING := "1a0d8438-1d97-4ec1-aef9-a2fb86ed6acb"
IFontList_UUID := win32.IID{0x1a0d8438, 0x1d97, 0x4ec1, {0xae, 0xf9, 0xa2, 0xfb, 0x86, 0xed, 0x6a, 0xcb}}
IFontList :: struct #raw_union {
	#subtype iunknown:      IUnknown,
	using ifontlist_vtable: ^IFontList_VTable,
}
IFontList_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	GetFontCollection:     proc "stdcall" (this: ^IFontList, fontCollection: ^^IFontCollection) -> win32.HRESULT,
	GetFontCount:          proc "stdcall" (this: ^IFontList) -> u32,
	GetFont:               proc "stdcall" (this: ^IFontList, index: u32, font: ^^IFont) -> win32.HRESULT,
}


IFontFamily_UUID_STRING := "da20d8ef-812a-4c43-9802-62ec4abd7add"
IFontFamily_UUID := win32.IID{0xda20d8ef, 0x812a, 0x4c43, {0x98, 0x02, 0x62, 0xec, 0x4a, 0xbd, 0x7a, 0xdd}}
IFontFamily :: struct #raw_union {
	#subtype ifontlist:       IFontList,
	using ifontfamily_vtable: ^IFontFamily_VTable,
}
IFontFamily_VTable :: struct {
	using ifontlist_vtable: IFontList_VTable,
	GetFamilyNames:         proc "stdcall" (this: ^IFontFamily, names: ^^ILocalizedStrings) -> win32.HRESULT,
	GetFirstMatchingFont:   proc "stdcall" (this: ^IFontFamily, weight: FONT_WEIGHT, stretch: FONT_STRETCH, style: FONT_STYLE, matchingFont: ^^IFont) -> win32.HRESULT,
	GetMatchingFonts:       proc "stdcall" (this: ^IFontFamily, weight: FONT_WEIGHT, stretch: FONT_STRETCH, style: FONT_STYLE, matchingFonts: ^^IFontList) -> win32.HRESULT,
}


IFont_UUID_STRING := "acd16696-8c14-4f5d-877e-fe3fc1d32737"
IFont_UUID := win32.IID{0xacd16696, 0x8c14, 0x4f5d, {0x87, 0x7e, 0xfe, 0x3f, 0xc1, 0xd3, 0x27, 0x37}}
IFont :: struct #raw_union {
	#subtype iunknown:  IUnknown,
	using ifont_vtable: ^IFont_VTable,
}
IFont_VTable :: struct {
	using iunknown_vtable:   IUnknown_VTable,
	GetFontFamily:           proc "stdcall" (this: ^IFont, fontFamily: ^^IFontFamily) -> win32.HRESULT,
	GetWeight:               proc "stdcall" (this: ^IFont) -> FONT_WEIGHT,
	GetStretch:              proc "stdcall" (this: ^IFont) -> FONT_STRETCH,
	GetStyle:                proc "stdcall" (this: ^IFont) -> FONT_STYLE,
	IsSymbolFont:            proc "stdcall" (this: ^IFont) -> BOOL,
	GetFaceNames:            proc "stdcall" (this: ^IFont, names: ^^ILocalizedStrings) -> win32.HRESULT,
	GetInformationalStrings: proc "stdcall" (this: ^IFont, informationalStringID: INFORMATIONAL_STRING_ID, informationalStrings: ^^ILocalizedStrings, exists: ^BOOL) -> win32.HRESULT,
	GetSimulations:          proc "stdcall" (this: ^IFont) -> FONT_SIMULATIONS,
	GetMetrics:              proc "stdcall" (this: ^IFont, fontMetrics: ^FONT_METRICS),
	HasCharacter:            proc "stdcall" (this: ^IFont, unicodeValue: u32, exists: ^BOOL) -> win32.HRESULT,
	CreateFontFace:          proc "stdcall" (this: ^IFont, fontFace: ^^IFontFace) -> win32.HRESULT,
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
	using itextformat_vtable: ^ITextFormat_VTable,
}
ITextFormat_VTable :: struct {
	using iunknown_vtable:   IUnknown_VTable,
	SetTextAlignment:        proc "stdcall" (this: ^ITextFormat, textAlignment: TEXT_ALIGNMENT) -> win32.HRESULT,
	SetParagraphAlignment:   proc "stdcall" (this: ^ITextFormat, paragraphAlignment: PARAGRAPH_ALIGNMENT) -> win32.HRESULT,
	SetWordWrapping:         proc "stdcall" (this: ^ITextFormat, wordWrapping: WORD_WRAPPING) -> win32.HRESULT,
	SetReadingDirection:     proc "stdcall" (this: ^ITextFormat, readingDirection: READING_DIRECTION) -> win32.HRESULT,
	SetFlowDirection:        proc "stdcall" (this: ^ITextFormat, flowDirection: FLOW_DIRECTION) -> win32.HRESULT,
	SetIncrementalTabStop:   proc "stdcall" (this: ^ITextFormat, incrementalTabStop: f32) -> win32.HRESULT,
	SetTrimming:             proc "stdcall" (this: ^ITextFormat, #by_ptr trimmingOptions: TRIMMING, trimmingSign: ^IInlineObject) -> win32.HRESULT,
	SetLineSpacing:          proc "stdcall" (this: ^ITextFormat, lineSpacingMethod: LINE_SPACING_METHOD, lineSpacing: f32, baseline: f32) -> win32.HRESULT,
	GetTextAlignment:        proc "stdcall" (this: ^ITextFormat) -> TEXT_ALIGNMENT,
	GetParagraphAlignment:   proc "stdcall" (this: ^ITextFormat) -> PARAGRAPH_ALIGNMENT,
	GetWordWrapping:         proc "stdcall" (this: ^ITextFormat) -> WORD_WRAPPING,
	GetReadingDirection:     proc "stdcall" (this: ^ITextFormat) -> READING_DIRECTION,
	GetFlowDirection:        proc "stdcall" (this: ^ITextFormat) -> FLOW_DIRECTION,
	GetIncrementalTabStop:   proc "stdcall" (this: ^ITextFormat) -> f32,
	GetTrimming:             proc "stdcall" (this: ^ITextFormat, trimmingOptions: ^TRIMMING, trimmingSign: ^^IInlineObject) -> win32.HRESULT,
	GetLineSpacing:          proc "stdcall" (this: ^ITextFormat, lineSpacingMethod: ^LINE_SPACING_METHOD, lineSpacing: ^f32, baseline: ^f32) -> win32.HRESULT,
	GetFontCollection:       proc "stdcall" (this: ^ITextFormat, fontCollection: ^^IFontCollection) -> win32.HRESULT,
	GetFontFamilyNameLength: proc "stdcall" (this: ^ITextFormat) -> u32,
	GetFontFamilyName:       proc "stdcall" (this: ^ITextFormat, fontFamilyName: [^]u8, nameSize: u32) -> win32.HRESULT,
	GetFontWeight:           proc "stdcall" (this: ^ITextFormat) -> FONT_WEIGHT,
	GetFontStyle:            proc "stdcall" (this: ^ITextFormat) -> FONT_STYLE,
	GetFontStretch:          proc "stdcall" (this: ^ITextFormat) -> FONT_STRETCH,
	GetFontSize:             proc "stdcall" (this: ^ITextFormat) -> f32,
	GetLocaleNameLength:     proc "stdcall" (this: ^ITextFormat) -> u32,
	GetLocaleName:           proc "stdcall" (this: ^ITextFormat, localeName: [^]u8, nameSize: u32) -> win32.HRESULT,
}


ITypography_UUID_STRING := "55f1112b-1dc2-4b3c-9541-f46894ed85b6"
ITypography_UUID := win32.IID{0x55f1112b, 0x1dc2, 0x4b3c, {0x95, 0x41, 0xf4, 0x68, 0x94, 0xed, 0x85, 0xb6}}
ITypography :: struct #raw_union {
	#subtype iunknown:        IUnknown,
	using itypography_vtable: ^ITypography_VTable,
}
ITypography_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	AddFontFeature:        proc "stdcall" (this: ^ITypography, fontFeature: FONT_FEATURE) -> win32.HRESULT,
	GetFontFeatureCount:   proc "stdcall" (this: ^ITypography) -> u32,
	GetFontFeature:        proc "stdcall" (this: ^ITypography, fontFeatureIndex: u32, fontFeature: ^FONT_FEATURE) -> win32.HRESULT,
}


SCRIPT_SHAPES_Flag :: enum {
	DEFAULT   = 0,
	NO_VISUAL = 1,
}
SCRIPT_SHAPES :: bit_set[SCRIPT_SHAPES_Flag;win32.DWORD]

SCRIPT_ANALYSIS :: struct {
	script: u16,
	shapes: SCRIPT_SHAPES,
}

BREAK_CONDITION :: enum win32.DWORD {
	NEUTRAL,
	CAN_BREAK,
	MAY_NOT_BREAK,
	MUST_BREAK,
}

LINE_BREAKPOINT :: struct {
	_bitfield: u8,
}

NUMBER_SUBSTITUTION_METHOD :: enum win32.DWORD {
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
	using inumbersubstitution_vtable: ^INumberSubstitution_VTable,
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
	using itextanalysissource_vtable: ^ITextAnalysisSource_VTable,
}
ITextAnalysisSource_VTable :: struct {
	using iunknown_vtable:        IUnknown_VTable,
	GetTextAtPosition:            proc "stdcall" (this: ^ITextAnalysisSource, textPosition: u32, textString: ^[^]u16, textLength: ^u32) -> win32.HRESULT,
	GetTextBeforePosition:        proc "stdcall" (this: ^ITextAnalysisSource, textPosition: u32, textString: ^[^]u16, textLength: ^u32) -> win32.HRESULT,
	GetParagraphReadingDirection: proc "stdcall" (this: ^ITextAnalysisSource) -> READING_DIRECTION,
	GetLocaleName:                proc "stdcall" (this: ^ITextAnalysisSource, textPosition: u32, textLength: ^u32, localeName: ^[^]u16) -> win32.HRESULT,
	GetNumberSubstitution:        proc "stdcall" (this: ^ITextAnalysisSource, textPosition: u32, textLength: ^u32, numberSubstitution: ^^INumberSubstitution) -> win32.HRESULT,
}


ITextAnalysisSink_UUID_STRING := "5810cd44-0ca0-4701-b3fa-bec5182ae4f6"
ITextAnalysisSink_UUID := win32.IID{0x5810cd44, 0x0ca0, 0x4701, {0xb3, 0xfa, 0xbe, 0xc5, 0x18, 0x2a, 0xe4, 0xf6}}
ITextAnalysisSink :: struct #raw_union {
	#subtype iunknown:              IUnknown,
	using itextanalysissink_vtable: ^ITextAnalysisSink_VTable,
}
ITextAnalysisSink_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	SetScriptAnalysis:     proc "stdcall" (this: ^ITextAnalysisSink, textPosition: u32, textLength: u32, #by_ptr scriptAnalysis: SCRIPT_ANALYSIS) -> win32.HRESULT,
	SetLineBreakpoints:    proc "stdcall" (this: ^ITextAnalysisSink, textPosition: u32, textLength: u32, lineBreakpoints: [^]LINE_BREAKPOINT) -> win32.HRESULT,
	SetBidiLevel:          proc "stdcall" (this: ^ITextAnalysisSink, textPosition: u32, textLength: u32, explicitLevel: u8, resolvedLevel: u8) -> win32.HRESULT,
	SetNumberSubstitution: proc "stdcall" (this: ^ITextAnalysisSink, textPosition: u32, textLength: u32, numberSubstitution: ^INumberSubstitution) -> win32.HRESULT,
}


ITextAnalyzer_UUID_STRING := "b7e6163e-7f46-43b4-84b3-e4e6249c365d"
ITextAnalyzer_UUID := win32.IID{0xb7e6163e, 0x7f46, 0x43b4, {0x84, 0xb3, 0xe4, 0xe6, 0x24, 0x9c, 0x36, 0x5d}}
ITextAnalyzer :: struct #raw_union {
	#subtype iunknown:          IUnknown,
	using itextanalyzer_vtable: ^ITextAnalyzer_VTable,
}
ITextAnalyzer_VTable :: struct {
	using iunknown_vtable:           IUnknown_VTable,
	AnalyzeScript:                   proc "stdcall" (
		this: ^ITextAnalyzer,
		analysisSource: ^ITextAnalysisSource,
		textPosition: u32,
		textLength: u32,
		analysisSink: ^ITextAnalysisSink,
	) -> win32.HRESULT,
	AnalyzeBidi:                     proc "stdcall" (
		this: ^ITextAnalyzer,
		analysisSource: ^ITextAnalysisSource,
		textPosition: u32,
		textLength: u32,
		analysisSink: ^ITextAnalysisSink,
	) -> win32.HRESULT,
	AnalyzeNumberSubstitution:       proc "stdcall" (
		this: ^ITextAnalyzer,
		analysisSource: ^ITextAnalysisSource,
		textPosition: u32,
		textLength: u32,
		analysisSink: ^ITextAnalysisSink,
	) -> win32.HRESULT,
	AnalyzeLineBreakpoints:          proc "stdcall" (
		this: ^ITextAnalyzer,
		analysisSource: ^ITextAnalysisSource,
		textPosition: u32,
		textLength: u32,
		analysisSink: ^ITextAnalysisSink,
	) -> win32.HRESULT,
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
	) -> win32.HRESULT,
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
	) -> win32.HRESULT,
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
	) -> win32.HRESULT,
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
	using iinlineobject_vtable: ^IInlineObject_VTable,
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
	) -> win32.HRESULT,
	GetMetrics:            proc "stdcall" (this: ^IInlineObject, metrics: ^INLINE_OBJECT_METRICS) -> win32.HRESULT,
	GetOverhangMetrics:    proc "stdcall" (this: ^IInlineObject, overhangs: ^OVERHANG_METRICS) -> win32.HRESULT,
	GetBreakConditions:    proc "stdcall" (this: ^IInlineObject, breakConditionBefore: ^BREAK_CONDITION, breakConditionAfter: ^BREAK_CONDITION) -> win32.HRESULT,
}


IPixelSnapping_UUID_STRING := "eaf3a2da-ecf4-4d24-b644-b34f6842024b"
IPixelSnapping_UUID := win32.IID{0xeaf3a2da, 0xecf4, 0x4d24, {0xb6, 0x44, 0xb3, 0x4f, 0x68, 0x42, 0x02, 0x4b}}
IPixelSnapping :: struct #raw_union {
	#subtype iunknown:           IUnknown,
	using ipixelsnapping_vtable: ^IPixelSnapping_VTable,
}
IPixelSnapping_VTable :: struct {
	using iunknown_vtable:   IUnknown_VTable,
	IsPixelSnappingDisabled: proc "stdcall" (this: ^IPixelSnapping, clientDrawingContext: rawptr, isDisabled: ^BOOL) -> win32.HRESULT,
	GetCurrentTransform:     proc "stdcall" (this: ^IPixelSnapping, clientDrawingContext: rawptr, transform: ^MATRIX) -> win32.HRESULT,
	GetPixelsPerDip:         proc "stdcall" (this: ^IPixelSnapping, clientDrawingContext: rawptr, pixelsPerDip: ^f32) -> win32.HRESULT,
}


ITextRenderer_UUID_STRING := "ef8a8135-5cc6-45fe-8825-c5a0724eb819"
ITextRenderer_UUID := win32.IID{0xef8a8135, 0x5cc6, 0x45fe, {0x88, 0x25, 0xc5, 0xa0, 0x72, 0x4e, 0xb8, 0x19}}
ITextRenderer :: struct #raw_union {
	#subtype ipixelsnapping:    IPixelSnapping,
	using itextrenderer_vtable: ^ITextRenderer_VTable,
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
	) -> win32.HRESULT,
	DrawUnderline:               proc "stdcall" (
		this: ^ITextRenderer,
		clientDrawingContext: rawptr,
		baselineOriginX: f32,
		baselineOriginY: f32,
		#by_ptr underline: UNDERLINE,
		clientDrawingEffect: ^IUnknown,
	) -> win32.HRESULT,
	DrawStrikethrough:           proc "stdcall" (
		this: ^ITextRenderer,
		clientDrawingContext: rawptr,
		baselineOriginX: f32,
		baselineOriginY: f32,
		#by_ptr strikethrough: STRIKETHROUGH,
		clientDrawingEffect: ^IUnknown,
	) -> win32.HRESULT,
	DrawInlineObject:            proc "stdcall" (
		this: ^ITextRenderer,
		clientDrawingContext: rawptr,
		originX: f32,
		originY: f32,
		inlineObject: ^IInlineObject,
		isSideways: BOOL,
		isRightToLeft: BOOL,
		clientDrawingEffect: ^IUnknown,
	) -> win32.HRESULT,
}


ITextLayout_UUID_STRING := "53737037-6d14-410b-9bfe-0b182bb70961"
ITextLayout_UUID := win32.IID{0x53737037, 0x6d14, 0x410b, {0x9b, 0xfe, 0x0b, 0x18, 0x2b, 0xb7, 0x09, 0x61}}
ITextLayout :: struct #raw_union {
	#subtype itextformat:     ITextFormat,
	using itextlayout_vtable: ^ITextLayout_VTable,
}
ITextLayout_VTable :: struct {
	using itextformat_vtable:  ITextFormat_VTable,
	SetMaxWidth:               proc "stdcall" (this: ^ITextLayout, maxWidth: f32) -> win32.HRESULT,
	SetMaxHeight:              proc "stdcall" (this: ^ITextLayout, maxHeight: f32) -> win32.HRESULT,
	SetFontCollection:         proc "stdcall" (this: ^ITextLayout, fontCollection: ^IFontCollection, textRange: TEXT_RANGE) -> win32.HRESULT,
	SetFontFamilyName:         proc "stdcall" (this: ^ITextLayout, fontFamilyName: PWSTR, textRange: TEXT_RANGE) -> win32.HRESULT,
	SetFontWeight:             proc "stdcall" (this: ^ITextLayout, fontWeight: FONT_WEIGHT, textRange: TEXT_RANGE) -> win32.HRESULT,
	SetFontStyle:              proc "stdcall" (this: ^ITextLayout, fontStyle: FONT_STYLE, textRange: TEXT_RANGE) -> win32.HRESULT,
	SetFontStretch:            proc "stdcall" (this: ^ITextLayout, fontStretch: FONT_STRETCH, textRange: TEXT_RANGE) -> win32.HRESULT,
	SetFontSize:               proc "stdcall" (this: ^ITextLayout, fontSize: f32, textRange: TEXT_RANGE) -> win32.HRESULT,
	SetUnderline:              proc "stdcall" (this: ^ITextLayout, hasUnderline: BOOL, textRange: TEXT_RANGE) -> win32.HRESULT,
	SetStrikethrough:          proc "stdcall" (this: ^ITextLayout, hasStrikethrough: BOOL, textRange: TEXT_RANGE) -> win32.HRESULT,
	SetDrawingEffect:          proc "stdcall" (this: ^ITextLayout, drawingEffect: ^IUnknown, textRange: TEXT_RANGE) -> win32.HRESULT,
	SetInlineObject:           proc "stdcall" (this: ^ITextLayout, inlineObject: ^IInlineObject, textRange: TEXT_RANGE) -> win32.HRESULT,
	SetTypography:             proc "stdcall" (this: ^ITextLayout, typography: ^ITypography, textRange: TEXT_RANGE) -> win32.HRESULT,
	SetLocaleName:             proc "stdcall" (this: ^ITextLayout, localeName: PWSTR, textRange: TEXT_RANGE) -> win32.HRESULT,
	GetMaxWidth:               proc "stdcall" (this: ^ITextLayout) -> f32,
	GetMaxHeight:              proc "stdcall" (this: ^ITextLayout) -> f32,
	GetFontCollection_1:       proc "stdcall" (this: ^ITextLayout, currentPosition: u32, fontCollection: ^^IFontCollection, textRange: ^TEXT_RANGE) -> win32.HRESULT,
	GetFontFamilyNameLength_1: proc "stdcall" (this: ^ITextLayout, currentPosition: u32, nameLength: ^u32, textRange: ^TEXT_RANGE) -> win32.HRESULT,
	GetFontFamilyName_1:       proc "stdcall" (this: ^ITextLayout, currentPosition: u32, fontFamilyName: [^]u8, nameSize: u32, textRange: ^TEXT_RANGE) -> win32.HRESULT,
	GetFontWeight_1:           proc "stdcall" (this: ^ITextLayout, currentPosition: u32, fontWeight: ^FONT_WEIGHT, textRange: ^TEXT_RANGE) -> win32.HRESULT,
	GetFontStyle_1:            proc "stdcall" (this: ^ITextLayout, currentPosition: u32, fontStyle: ^FONT_STYLE, textRange: ^TEXT_RANGE) -> win32.HRESULT,
	GetFontStretch_1:          proc "stdcall" (this: ^ITextLayout, currentPosition: u32, fontStretch: ^FONT_STRETCH, textRange: ^TEXT_RANGE) -> win32.HRESULT,
	GetFontSize_1:             proc "stdcall" (this: ^ITextLayout, currentPosition: u32, fontSize: ^f32, textRange: ^TEXT_RANGE) -> win32.HRESULT,
	GetUnderline:              proc "stdcall" (this: ^ITextLayout, currentPosition: u32, hasUnderline: ^BOOL, textRange: ^TEXT_RANGE) -> win32.HRESULT,
	GetStrikethrough:          proc "stdcall" (this: ^ITextLayout, currentPosition: u32, hasStrikethrough: ^BOOL, textRange: ^TEXT_RANGE) -> win32.HRESULT,
	GetDrawingEffect:          proc "stdcall" (this: ^ITextLayout, currentPosition: u32, drawingEffect: ^^IUnknown, textRange: ^TEXT_RANGE) -> win32.HRESULT,
	GetInlineObject:           proc "stdcall" (this: ^ITextLayout, currentPosition: u32, inlineObject: ^^IInlineObject, textRange: ^TEXT_RANGE) -> win32.HRESULT,
	GetTypography:             proc "stdcall" (this: ^ITextLayout, currentPosition: u32, typography: ^^ITypography, textRange: ^TEXT_RANGE) -> win32.HRESULT,
	GetLocaleNameLength_1:     proc "stdcall" (this: ^ITextLayout, currentPosition: u32, nameLength: ^u32, textRange: ^TEXT_RANGE) -> win32.HRESULT,
	GetLocaleName_1:           proc "stdcall" (this: ^ITextLayout, currentPosition: u32, localeName: [^]u8, nameSize: u32, textRange: ^TEXT_RANGE) -> win32.HRESULT,
	Draw:                      proc "stdcall" (this: ^ITextLayout, clientDrawingContext: rawptr, renderer: ^ITextRenderer, originX: f32, originY: f32) -> win32.HRESULT,
	GetLineMetrics:            proc "stdcall" (this: ^ITextLayout, lineMetrics: [^]LINE_METRICS, maxLineCount: u32, actualLineCount: ^u32) -> win32.HRESULT,
	GetMetrics:                proc "stdcall" (this: ^ITextLayout, textMetrics: ^TEXT_METRICS) -> win32.HRESULT,
	GetOverhangMetrics:        proc "stdcall" (this: ^ITextLayout, overhangs: ^OVERHANG_METRICS) -> win32.HRESULT,
	GetClusterMetrics:         proc "stdcall" (this: ^ITextLayout, clusterMetrics: [^]CLUSTER_METRICS, maxClusterCount: u32, actualClusterCount: ^u32) -> win32.HRESULT,
	DetermineMinWidth:         proc "stdcall" (this: ^ITextLayout, minWidth: ^f32) -> win32.HRESULT,
	HitTestPoint:              proc "stdcall" (this: ^ITextLayout, pointX: f32, pointY: f32, isTrailingHit: ^BOOL, isInside: ^BOOL, hitTestMetrics: ^HIT_TEST_METRICS) -> win32.HRESULT,
	HitTestTextPosition:       proc "stdcall" (this: ^ITextLayout, textPosition: u32, isTrailingHit: BOOL, pointX: ^f32, pointY: ^f32, hitTestMetrics: ^HIT_TEST_METRICS) -> win32.HRESULT,
	HitTestTextRange:          proc "stdcall" (
		this: ^ITextLayout,
		textPosition: u32,
		textLength: u32,
		originX: f32,
		originY: f32,
		hitTestMetrics: [^]HIT_TEST_METRICS,
		maxHitTestMetricsCount: u32,
		actualHitTestMetricsCount: ^u32,
	) -> win32.HRESULT,
}


IBitmapRenderTarget_UUID_STRING := "5e5a32a3-8dff-4773-9ff6-0696eab77267"
IBitmapRenderTarget_UUID := win32.IID{0x5e5a32a3, 0x8dff, 0x4773, {0x9f, 0xf6, 0x06, 0x96, 0xea, 0xb7, 0x72, 0x67}}
IBitmapRenderTarget :: struct #raw_union {
	#subtype iunknown:                IUnknown,
	using ibitmaprendertarget_vtable: ^IBitmapRenderTarget_VTable,
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
	) -> win32.HRESULT,
	GetMemoryDC:           proc "stdcall" (this: ^IBitmapRenderTarget) -> HDC,
	GetPixelsPerDip:       proc "stdcall" (this: ^IBitmapRenderTarget) -> f32,
	SetPixelsPerDip:       proc "stdcall" (this: ^IBitmapRenderTarget, pixelsPerDip: f32) -> win32.HRESULT,
	GetCurrentTransform:   proc "stdcall" (this: ^IBitmapRenderTarget, transform: ^MATRIX) -> win32.HRESULT,
	SetCurrentTransform:   proc "stdcall" (this: ^IBitmapRenderTarget, transform: ^MATRIX) -> win32.HRESULT,
	GetSize:               proc "stdcall" (this: ^IBitmapRenderTarget, size: ^SIZE) -> win32.HRESULT,
	Resize:                proc "stdcall" (this: ^IBitmapRenderTarget, width: u32, height: u32) -> win32.HRESULT,
}


IGdiInterop_UUID_STRING := "1edd9491-9853-4299-898f-6432983b6f3a"
IGdiInterop_UUID := win32.IID{0x1edd9491, 0x9853, 0x4299, {0x89, 0x8f, 0x64, 0x32, 0x98, 0x3b, 0x6f, 0x3a}}
IGdiInterop :: struct #raw_union {
	#subtype iunknown:        IUnknown,
	using igdiinterop_vtable: ^IGdiInterop_VTable,
}
IGdiInterop_VTable :: struct {
	using iunknown_vtable:    IUnknown_VTable,
	CreateFontFromLOGFONT:    proc "stdcall" (this: ^IGdiInterop, #by_ptr logFont: LOGFONTW, font: ^^IFont) -> win32.HRESULT,
	ConvertFontToLOGFONT:     proc "stdcall" (this: ^IGdiInterop, font: ^IFont, logFont: ^LOGFONTW, isSystemFont: ^BOOL) -> win32.HRESULT,
	ConvertFontFaceToLOGFONT: proc "stdcall" (this: ^IGdiInterop, font: ^IFontFace, logFont: ^LOGFONTW) -> win32.HRESULT,
	CreateFontFaceFromHdc:    proc "stdcall" (this: ^IGdiInterop, hdc: HDC, fontFace: ^^IFontFace) -> win32.HRESULT,
	CreateBitmapRenderTarget: proc "stdcall" (this: ^IGdiInterop, hdc: HDC, width: u32, height: u32, renderTarget: ^^IBitmapRenderTarget) -> win32.HRESULT,
}


TEXTURE_TYPE :: enum win32.DWORD {
	ALIASED_1x1,
	CLEARTYPE_3x1,
}

IGlyphRunAnalysis_UUID_STRING := "7d97dbf7-e085-42d4-81e3-6a883bded118"
IGlyphRunAnalysis_UUID := win32.IID{0x7d97dbf7, 0xe085, 0x42d4, {0x81, 0xe3, 0x6a, 0x88, 0x3b, 0xde, 0xd1, 0x18}}
IGlyphRunAnalysis :: struct #raw_union {
	#subtype iunknown:              IUnknown,
	using iglyphrunanalysis_vtable: ^IGlyphRunAnalysis_VTable,
}
IGlyphRunAnalysis_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	GetAlphaTextureBounds: proc "stdcall" (this: ^IGlyphRunAnalysis, textureType: TEXTURE_TYPE, textureBounds: ^RECT) -> win32.HRESULT,
	CreateAlphaTexture:    proc "stdcall" (this: ^IGlyphRunAnalysis, textureType: TEXTURE_TYPE, #by_ptr textureBounds: RECT, alphaValues: ^u8, bufferSize: u32) -> win32.HRESULT,
	GetAlphaBlendParams:   proc "stdcall" (
		this: ^IGlyphRunAnalysis,
		renderingParams: ^IRenderingParams,
		blendGamma: ^f32,
		blendEnhancedContrast: ^f32,
		blendClearTypeLevel: ^f32,
	) -> win32.HRESULT,
}


IFactory_UUID_STRING := "b859ee5a-d838-4b5b-a2e8-1adc7d93db48"
IFactory_UUID := win32.IID{0xb859ee5a, 0xd838, 0x4b5b, {0xa2, 0xe8, 0x1a, 0xdc, 0x7d, 0x93, 0xdb, 0x48}}
IFactory :: struct #raw_union {
	#subtype iunknown:     IUnknown,
	using ifactory_vtable: ^IFactory_VTable,
}
IFactory_VTable :: struct {
	using iunknown_vtable:          IUnknown_VTable,
	GetSystemFontCollection:        proc "stdcall" (this: ^IFactory, fontCollection: ^^IFontCollection, checkForUpdates: BOOL) -> win32.HRESULT,
	CreateCustomFontCollection:     proc "stdcall" (
		this: ^IFactory,
		collectionLoader: ^IFontCollectionLoader,
		collectionKey: rawptr,
		collectionKeySize: u32,
		fontCollection: ^^IFontCollection,
	) -> win32.HRESULT,
	RegisterFontCollectionLoader:   proc "stdcall" (this: ^IFactory, fontCollectionLoader: ^IFontCollectionLoader) -> win32.HRESULT,
	UnregisterFontCollectionLoader: proc "stdcall" (this: ^IFactory, fontCollectionLoader: ^IFontCollectionLoader) -> win32.HRESULT,
	CreateFontFileReference:        proc "stdcall" (this: ^IFactory, filePath: PWSTR, lastWriteTime: ^FILETIME, fontFile: ^^IFontFile) -> win32.HRESULT,
	CreateCustomFontFileReference:  proc "stdcall" (
		this: ^IFactory,
		fontFileReferenceKey: rawptr,
		fontFileReferenceKeySize: u32,
		fontFileLoader: ^IFontFileLoader,
		fontFile: ^^IFontFile,
	) -> win32.HRESULT,
	CreateFontFace: proc "stdcall" (
		this: ^IFactory,
		fontFaceType: FONT_FACE_TYPE,
		numberOfFiles: u32,
		fontFiles: [^]^IFontFile,
		faceIndex: u32,
		fontFaceSimulationFlags: FONT_SIMULATIONS,
		fontFace: ^^IFontFace,
	) -> win32.HRESULT,
	CreateRenderingParams:          proc "stdcall" (this: ^IFactory, renderingParams: ^^IRenderingParams) -> win32.HRESULT,
	CreateMonitorRenderingParams:   proc "stdcall" (this: ^IFactory, monitor: HMONITOR, renderingParams: ^^IRenderingParams) -> win32.HRESULT,
	CreateCustomRenderingParams:    proc "stdcall" (
		this: ^IFactory,
		gamma: f32,
		enhancedContrast: f32,
		clearTypeLevel: f32,
		pixelGeometry: PIXEL_GEOMETRY,
		renderingMode: RENDERING_MODE,
		renderingParams: ^^IRenderingParams,
	) -> win32.HRESULT,
	RegisterFontFileLoader:         proc "stdcall" (this: ^IFactory, fontFileLoader: ^IFontFileLoader) -> win32.HRESULT,
	UnregisterFontFileLoader:       proc "stdcall" (this: ^IFactory, fontFileLoader: ^IFontFileLoader) -> win32.HRESULT,
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
	) -> win32.HRESULT,
	CreateTypography:               proc "stdcall" (this: ^IFactory, typography: ^^ITypography) -> win32.HRESULT,
	GetGdiInterop:                  proc "stdcall" (this: ^IFactory, gdiInterop: ^^IGdiInterop) -> win32.HRESULT,
	CreateTextLayout:               proc "stdcall" (
		this: ^IFactory,
		string: [^]win32.WCHAR,
		stringLength: win32.UINT32,
		textFormat: ^ITextFormat,
		maxWidth: f32,
		maxHeight: f32,
		textLayout: ^^ITextLayout,
	) -> win32.HRESULT,
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
	) -> win32.HRESULT,
	CreateEllipsisTrimmingSign:     proc "stdcall" (this: ^IFactory, textFormat: ^ITextFormat, trimmingSign: ^^IInlineObject) -> win32.HRESULT,
	CreateTextAnalyzer:             proc "stdcall" (this: ^IFactory, textAnalyzer: ^^ITextAnalyzer) -> win32.HRESULT,
	CreateNumberSubstitution:       proc "stdcall" (
		this: ^IFactory,
		substitutionMethod: NUMBER_SUBSTITUTION_METHOD,
		localeName: win32.PCWSTR,
		ignoreUserOverride: BOOL,
		numberSubstitution: ^^INumberSubstitution,
	) -> win32.HRESULT,
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
	) -> win32.HRESULT,
}

ISimplifiedGeometrySink_UUID_STRING := "2cd9069e-12e2-11dc-9fed-001143a055f9"
ISimplifiedGeometrySink_UUID := win32.IID{0x2cd9069e, 0x12e2, 0x11dc, {0x9f, 0xed, 0x00, 0x11, 0x43, 0xa0, 0x55, 0xf9}}
ISimplifiedGeometrySink :: struct #raw_union {
	#subtype iunknown:                    IUnknown,
	using isimplifiedgeometrysink_vtable: ^ISimplifiedGeometrySink_VTable,
}
ISimplifiedGeometrySink_VTable :: struct {
	using iunknown_vtable: IUnknown_VTable,
	SetFillMode:           proc "stdcall" (this: ^ISimplifiedGeometrySink, fillMode: FILL_MODE),
	SetSegmentFlags:       proc "stdcall" (this: ^ISimplifiedGeometrySink, vertexFlags: PATH_SEGMENT),
	BeginFigure:           proc "stdcall" (this: ^ISimplifiedGeometrySink, startPoint: POINT_2F, figureBegin: FIGURE_BEGIN),
	AddLines:              proc "stdcall" (this: ^ISimplifiedGeometrySink, points: [^]POINT_2F, pointsCount: u32),
	AddBeziers:            proc "stdcall" (this: ^ISimplifiedGeometrySink, beziers: [^]BEZIER_SEGMENT, beziersCount: u32),
	EndFigure:             proc "stdcall" (this: ^ISimplifiedGeometrySink, figureEnd: FIGURE_END),
	Close:                 proc "stdcall" (this: ^ISimplifiedGeometrySink) -> win32.HRESULT,
}

PATH_SEGMENT_Flag :: enum {
	FORCE_UNSTROKED       = 1,
	FORCE_ROUND_LINE_JOIN = 2,
}
PATH_SEGMENT :: bit_set[PATH_SEGMENT_Flag;u32]

FILL_MODE :: enum u32 {
	ALTERNATE,
	WINDING,
}

FIGURE_BEGIN :: enum u32 {
	FILLED,
	HOLLOW,
}

FIGURE_END :: enum u32 {
	OPEN,
	CLOSED,
}

BEZIER_SEGMENT :: struct {
	point1: POINT_2F,
	point2: POINT_2F,
	point3: POINT_2F,
}

SIZE_U :: struct {
	width:  u32,
	height: u32,
}
