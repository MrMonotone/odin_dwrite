#include "wrapper.h"
#include <cstdio>

#ifdef __cplusplus
extern "C"
{
#endif

HRESULT dwCreateFactory(enum DWRITE_FACTORY_TYPE type, IUnknown** factory)
{
    // printf("Enum Value: %d\n", type);
    // printf("Pointer to Pointer to IUnknown: %p\n", (void*)factory);
	HRESULT error = ::DWriteCreateFactory(type, __uuidof(IDWriteFactory), factory);
	// printf("Pointer to Pointer to IUnknown: %p\n", (void*)factory);
	// printf("HResult Value: %d\n", error);
	return error;
}

HRESULT dwRegisterFontFileLoader(IUnknown* factory, IUnknown* fontFileLoader) {
	IDWriteFactory* dwFactor = static_cast<IDWriteFactory*>(factory);
	IDWriteFontFileLoader* dwFFL = static_cast<IDWriteFontFileLoader*>(fontFileLoader);
	HRESULT error = dwFactor->RegisterFontFileLoader(dwFFL);
	return error;
}

HRESULT dwCreateRenderingParams(IUnknown* factory, IUnknown** renderingParams) {
	IDWriteFactory* dwFactor = static_cast<IDWriteFactory*>(factory);
	IDWriteRenderingParams** dwRParams = reinterpret_cast<IDWriteRenderingParams **>(renderingParams);
	HRESULT error = dwFactor->CreateRenderingParams(dwRParams);
	return error;
}

FLOAT dwRenderingParamsGamma(IUnknown* renderingParams) {
	IDWriteRenderingParams* dwRenderParams = static_cast<IDWriteRenderingParams*>(renderingParams);

	FLOAT error = dwRenderParams->GetGamma();
	return error;
}

HRESULT dwCreateCustomRenderingParams(IUnknown* factory, IUnknown** renderingParams) {
	IDWriteFactory* dwFactory = static_cast<IDWriteFactory*>(factory);
	IDWriteRenderingParams** pdwRParams = reinterpret_cast<IDWriteRenderingParams **>(renderingParams);
	HRESULT error = dwFactory->CreateRenderingParams(pdwRParams);
	IDWriteRenderingParams* dwRParams = *pdwRParams;
	FLOAT gamma = dwRParams->GetGamma();
	FLOAT enhanced_contrast = dwRParams->GetEnhancedContrast();
	FLOAT clear_type_level = dwRParams->GetClearTypeLevel();
   	error = dwFactory->CreateCustomRenderingParams(
						gamma,
						enhanced_contrast,
						clear_type_level,
						DWRITE_PIXEL_GEOMETRY_FLAT,
						DWRITE_RENDERING_MODE_DEFAULT,
						pdwRParams);
	return error;
}

HRESULT dwGetGdiInterop(IUnknown* factory, IUnknown** gdiInterop) {
	HRESULT error = 0;
	IDWriteFactory* dwFactory = static_cast<IDWriteFactory*>(factory);
	IDWriteGdiInterop** pgdiInterop = reinterpret_cast<IDWriteGdiInterop **>(gdiInterop);
	error = dwFactory->GetGdiInterop(pgdiInterop);
	printf("GetGdiInterop error: %d\n", error);
	return error;
}

HRESULT dwCreateCustomFontFileReference(IUnknown* factory, void const* fontFileReferenceKey, UINT32 fontFileReferenceKeySize,IUnknown * fontFileLoader, IUnknown ** fontFile) {
	IDWriteFactory* dwFactory = static_cast<IDWriteFactory*>(factory);
	IDWriteFontFile ** dwFontFile = reinterpret_cast<IDWriteFontFile **>(fontFile);
	IDWriteFontFileLoader * dwFontFileLoader = reinterpret_cast<IDWriteFontFileLoader *>(fontFileLoader);
	HRESULT error = dwFactory->CreateCustomFontFileReference(
		fontFileReferenceKey,
		fontFileReferenceKeySize,
		dwFontFileLoader,
		dwFontFile
	);
	if (FAILED(error)) {
		printf("CreateCustomFontFileReference FAILED \n");
	}
	// IDWriteFontFileLoader** loader = NULL;
	// HRESULT error1 = (*dwFontFile)->GetLoader(loader);
	// printf("GOT LOADER?: %d\n", error1);
	// printf("Pointer to Pointer to IUnknown: %p\n", (void*)factory);
	// // printf("fontFileReferenceKey: %p\n", (void*)fontFileReferenceKey);
	// // printf("Pointer: %p\n", (void*)fontFileLoader);
	// printf("here");
	// printf("Pointer to Pointer: %p\n", (void*)fontFile);
	return error;
}

HRESULT dwTest(
	IUnknown* factory,
	void* fontFileReferenceKey,
	UINT32 fontFileReferenceKeySize,
	void *fontFileLoader
) {
	HRESULT error = 0;
	C_Hash* key = static_cast<C_Hash*>(fontFileReferenceKey);
	printf("Hash: %llu, %llu\n", key->u64[0], key->u64[1]);
	IDWriteFactory* dwFactory = static_cast<IDWriteFactory*>(factory);
	IDWriteFontFileLoader* dwFontFileLoader = static_cast<IDWriteFontFileLoader*>(fontFileLoader);
	//- rjf: make a "font file reference"... oh boy x2...
	IDWriteFontFile *font_file = 0;
	error = dwFactory->CreateCustomFontFileReference(key, fontFileReferenceKeySize, dwFontFileLoader, &font_file);
	printf("CreateCustomFontFileReference error: %d\n", error);
	// printf("%d",font_file == 0);
	//- rjf: make dwrite font face
	IDWriteFontFace *font_face = 0;
	error = dwFactory->CreateFontFace(DWRITE_FONT_FACE_TYPE_UNKNOWN, 1, &font_file, 0, DWRITE_FONT_SIMULATIONS_NONE, &font_face);
	printf("CreateFontFace error: %d\n", error);
	return error;
}

HRESULT dwCreateFontFace(
		IUnknown* factory, 
		DWRITE_FONT_FACE_TYPE fontFaceType,
        UINT32 numberOfFiles,
        IUnknown** fontFiles,
        UINT32 faceIndex,
        DWRITE_FONT_SIMULATIONS fontFaceSimulationFlags, 
		IUnknown ** fontFace
) {
	IDWriteFactory* dwFactory = static_cast<IDWriteFactory*>(factory);
	IDWriteFontFile** dwFontFiles = reinterpret_cast<IDWriteFontFile**>(fontFiles);
	IDWriteFontFace ** dwFontFace = reinterpret_cast<IDWriteFontFace **>(fontFace);
	printf("hi\n");
	// HRESULT error = 0;
	HRESULT error = dwFactory->CreateFontFace(
		fontFaceType,
		numberOfFiles,
		dwFontFiles,
		faceIndex,
		fontFaceSimulationFlags,
		dwFontFace
	);
	printf("%d what123123\n", error);
	return error;
}

void dwFontRelease(
		IUnknown* font_face,
		IUnknown* font_file
) {
	IDWriteFontFace* dwFace = static_cast<IDWriteFontFace*>(font_face);
	IDWriteFontFile* dwFile = static_cast<IDWriteFontFile*>(font_file);
	dwFace->Release();
	dwFile->Release();
}

void dwFontFaceGetMetrics(
		IUnknown* font_face,
		DWRITE_FONT_METRICS* fontFaceMetrics
) {
	IDWriteFontFace* dwFace = static_cast<IDWriteFontFace*>(font_face);
	dwFace->GetMetrics(fontFaceMetrics);
}

HRESULT dwFontFaceGetGlyphIndices(
		IUnknown* font_face,
		DWRITE_FONT_METRICS* fontFaceMetrics
) {
	HRESULT error = 0;
	// IDWriteFontFace* dwFace = static_cast<IDWriteFontFace*>(font_face);
	// error = dwFace->GetGlyphIndices(fontFaceMetrics);
	return error;
}


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
)
{
	return static_cast<IDWriteFactory *>(factory)->CreateTextFormat(
		fontFamilyName,
		static_cast<IDWriteFontCollection *>(fontCollection),
		fontWeight,
		fontStyle,
		fontStretch,
		fontSize,
		localeName,
		reinterpret_cast<IDWriteTextFormat **>(textFormat)
	);
}

HRESULT dwTFmtSetTextAlignment(
	IUnknown * txtFmt,
	enum DWRITE_TEXT_ALIGNMENT txtAlignment
)
{
	return static_cast<IDWriteTextFormat *>(txtFmt)->SetTextAlignment(txtAlignment);
}


#ifdef __cplusplus
}
#endif