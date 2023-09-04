#ifndef DWRITEWRAPPER_H
#define DWRITEWRAPPER_H

#include <dwrite_1.h>
#include <stdint.h>

#pragma comment(lib, "dwrite")

typedef struct C_Hash C_Hash;
struct C_Hash
{
 uint64_t u64[2];
};


#ifdef __cplusplus
extern "C"
{
#endif
// Wrapper for a couple of different calls
HRESULT dwCreateCustomRenderingParams(IUnknown* factory, IUnknown** renderingParams);

HRESULT dwDWriteCreateFactory(enum DWRITE_FACTORY_TYPE type, IUnknown ** factory);

HRESULT dwFactoryCreateTextFormat(
	IUnknown * factory,
	const WCHAR * fontFamilyName,
	IUnknown * fontCollection,
	enum DWRITE_FONT_WEIGHT fontWeight,
	enum DWRITE_FONT_STYLE fontStyle,
	enum DWRITE_FONT_STRETCH fontStretch,
	FLOAT fontSize,
	const WCHAR * localeName,
	IUnknown ** textFormat
);

HRESULT dwTFmtSetTextAlignment(
	IUnknown * txtFmt,
	enum DWRITE_TEXT_ALIGNMENT txtAlignment
);

HRESULT dwRegisterFontFileLoader(IUnknown* factory, IUnknown* fontFileLoader);

HRESULT dwCreateRenderingParams(IUnknown* factory, IUnknown** renderingParams);

FLOAT dwRenderingParamsGamma(IUnknown* renderingParams);

HRESULT dwGetGdiInterop(IUnknown* factory, IUnknown** gdiInterop);

HRESULT dwCreateCustomFontFileReference(IUnknown* factory, void const* fontFileReferenceKey, UINT32 fontFileReferenceKeySize,IUnknown * fontFileLoader, IUnknown ** fontFile);
HRESULT dwCreateFontFace(
		IUnknown* factory, 
		DWRITE_FONT_FACE_TYPE fontFaceType,
        UINT32 numberOfFiles,
        IUnknown** fontFiles,
        UINT32 faceIndex,
        DWRITE_FONT_SIMULATIONS fontFaceSimulationFlags, 
		IUnknown ** fontFace
);

void dwFontRelease(
		IUnknown* font_face,
		IUnknown* font_file
);

void dwFontFaceGetMetrics(
		IUnknown* font_face,
		DWRITE_FONT_METRICS* fontFaceMetrics
);

HRESULT dwTest(
	IUnknown* factory,
	void * fontFileReferenceKey,
	UINT32 fontFileReferenceKeySize,
	void *fontFileLoader
);
#ifdef __cplusplus
}
#endif
#endif