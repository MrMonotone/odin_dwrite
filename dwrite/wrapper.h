#ifndef DWRITEWRAPPER_H
#define DWRITEWRAPPER_H

#include <dwrite_1.h>

#pragma comment(lib, "dwrite")

#ifdef __cplusplus
extern "C"
{
#endif

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


#ifdef __cplusplus
}
#endif

#endif