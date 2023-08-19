package main
import "core:fmt"
import win32 "core:sys/windows"
import "core:runtime"
import "dwrite"

S_OK :: win32.HRESULT(0)

font_file_loader : dwrite.IFontFileLoader = {
    ifontfileloader_vtable = &font_file_loader_vtable,
}

font_file_loader_vtable : dwrite.IFontFileLoader_VTable = {
    QueryInterface = font_file_loader_QueryInterface,
    AddRef = font_file_loader_AddRef,
    Release = font_file_loader_Release,
    CreateStreamFromKey = font_file_loader_CreateStreamFromKey,
}


font_file_loader_QueryInterface:: proc "stdcall" (this_ptr: ^dwrite.IUnknown, riid: ^win32.IID, ppvObject: ^rawptr) -> (res:win32.HRESULT) {
    context = runtime.default_context()
    res = S_OK
    ppvObject^ = &font_file_loader
    return
}

font_file_loader_AddRef :: proc "stdcall" (this_ptr: ^dwrite.IUnknown) -> win32.ULONG
{
    return 1;
}

font_file_loader_Release :: proc "stdcall" (this_ptr: ^dwrite.IUnknown) -> win32.ULONG {
    return 1;
}

font_file_loader_CreateStreamFromKey :: proc "stdcall" (this_ptr: ^dwrite.IFontFileLoader, key: rawptr, key_size: win32.UINT32, out_stream: ^^dwrite.IFontFileStream) -> (res: win32.HRESULT) {
    context = runtime.default_context()
    res = S_OK
    return
}

main :: proc() {
    factory: ^dwrite.IFactory
    win_err: win32.HRESULT

    win_err = dwrite.create_factory(.ISOLATED, &factory)
    fmt.println("Factory Error ", win32.GetLastError())
    
    win_err = dwrite.register_font_file_loader(factory, &font_file_loader)
    fmt.println("Register Error", win32.GetLastError())
}
    
    
