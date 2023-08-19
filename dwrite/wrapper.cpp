#include "wrapper.h"
#include <cstdio>

#ifdef __cplusplus
extern "C"
{
#endif

HRESULT dwDWriteCreateFactory(enum DWRITE_FACTORY_TYPE type, IUnknown ** factory)
{
    printf("Enum Value: %d\n", type);
    printf("Pointer to Pointer to IUnknown: %p\n", (void*)factory);
	HRESULT error = DWriteCreateFactory(type, __uuidof(IDWriteFactory), factory);
	printf("HResult Value: %d\n", error);
	return error;
}

HRESULT dwRegisterFontFileLoader(IUnknown* factory, IUnknown* fontFileLoader) {
	printf("Factory pointer: %p\n", factory);
	printf("FontFileLoader pointer: %p\n", fontFileLoader);
	HRESULT error = static_cast<IDWriteFactory *>(factory)->RegisterFontFileLoader(static_cast<IDWriteFontFileLoader *>(fontFileLoader));
	printf("HResult Value: %d\n", error);
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