package main
import "core:fmt"
import win32 "core:sys/windows"
import "core:os"
import "core:runtime"
import "core:mem"
import "core:mem/virtual"
import "dwrite"

FONT_PATH :: ".\\Roboto.ttf"

S_OK :: win32.HRESULT(0)

first_free_stream: ^Font_File_Stream

file_data_test_b := #load("./Roboto.ttf")
file_data_test_s := #load("./tiny.regular.ttf")
file_data_test := file_data_test_s

Font_File_Stream :: struct {
    lpVtbl: ^dwrite.IFontFileStream_VTable,
    next: ^Font_File_Stream,
    ref_count: u32,
}

// @(link_section="rodata")
font_file_stream_vtable : dwrite.IFontFileStream_VTable = {
    QueryInterface = font_file_stream_QueryInterface,
    AddRef = font_file_stream_AddRef,
    Release = font_file_stream_Release,
    ReadFileFragment = font_file_stream_ReadFileFragment,
    ReleaseFileFragment = font_file_stream_ReleaseFileFragment,
    GetFileSize = font_file_stream_GetFileSize,
    GetLastWriteTime = font_file_stream_GetLastWriteTime,
}

font_file_stream_QueryInterface :: proc "std" (this_ptr: ^dwrite.IUnknown, riid: ^win32.IID , ppvObject:^rawptr) -> win32.HRESULT {
    // context = runtime.default_context()
    res := S_OK
    ppvObject^ = this_ptr
    return res
}

font_file_stream_AddRef :: proc "std" (this_ptr: ^dwrite.IUnknown) -> win32.ULONG {
    this_ptr := cast(^Font_File_Stream)this_ptr
    this_ptr.ref_count += 1;
    return this_ptr.ref_count
}


font_file_stream_Release :: proc "std" (this_ptr: ^dwrite.IUnknown) -> win32.ULONG {
    // context = runtime.default_context()
    this := cast(^Font_File_Stream)this_ptr
    this.ref_count -= 1
    if this.ref_count == 0 {
        // content.scope_close(this.scope) no_op currently
        this.next= first_free_stream
        first_free_stream = this
    }
    // fmt.println("ref count: ", this.ref_count)
    return this.ref_count
}

// data_from_hash :: proc() -> (^[]byte) {
//     if (file_data == nil) {
//         ok: bool
//         fd, err := os.open(FONT_PATH)
//         if err != 0 {
//             panic("couldnt open file yo")
//         }
        
//         file_data, ok = os.read_entire_file_from_handle(fd)
//         if !ok {
//             panic("couldnt open file yo")
//         }
//         // virtual.protect(&file_data, size_of(file_data), { .Read })
//     }
//     return &file_data
// }

font_file_stream_ReadFileFragment :: proc "stdcall" (this_ptr: ^dwrite.IFontFileStream, fragment_start: ^rawptr, off: u64, size: u64, fragment_ctx_out: ^rawptr) -> win32.HRESULT {
    // context = runtime.default_context()
    // this := cast(^Font_File_Stream)this_ptr
    fragment_start^ = raw_data(file_data_test[off:])
    fragment_ctx_out^ = nil
    return S_OK
}

font_file_stream_ReleaseFileFragment :: proc "std" (this_ptr: ^dwrite.IFontFileStream, fragment_ctx: rawptr) {
    context = runtime.default_context()
    // fmt.println("NO OP")
}

font_file_stream_GetFileSize :: proc "std" (this_ptr: ^dwrite.IFontFileStream, out_file_size: ^u64) -> win32.HRESULT {
    // context = runtime.default_context()
    this := cast(^Font_File_Stream)this_ptr
    // fmt.println("data size: ",len(file_data_test))

    out_file_size^ = cast(u64)len(file_data_test)
    return S_OK
}

font_file_stream_GetLastWriteTime :: proc "std" (this_ptr: ^dwrite.IFontFileStream, out_time: ^u64) -> win32.HRESULT {
    // context = runtime.default_context()s
    out_time^ = 0
    return S_OK
}

Font_File_Loader :: struct {
    lpVtbl: ^dwrite.IFontFileLoader_VTable,
}

font_file_loader := Font_File_Loader {
    lpVtbl = &font_file_loader_vtable,
}

@(link_section="rodata")
font_file_loader_vtable : dwrite.IFontFileLoader_VTable = {
    QueryInterface = font_file_loader_QueryInterface,
    AddRef = font_file_loader_AddRef,
    Release = font_file_loader_Release,
    CreateStreamFromKey = font_file_loader_CreateStreamFromKey,
}


font_file_loader_QueryInterface:: proc "std" (this_ptr: ^dwrite.IUnknown, riid: ^win32.IID, ppvObject: ^rawptr) -> win32.HRESULT {
    res := S_OK
    ppvObject^ = &font_file_loader
    return res
}

font_file_loader_AddRef :: proc "std" (this_ptr: ^dwrite.IUnknown) -> win32.ULONG {
    context = runtime.default_context()
    return 1;
}

font_file_loader_Release :: proc "std" (this_ptr: ^dwrite.IUnknown) -> win32.ULONG {
    context = runtime.default_context()
    // fmt.println("WE should finish after this...")
    return 1;
}
// scope_open :: proc() -> (res:^Scope) {
//     // res = &Scope {
//     //     _u64 = {1},
//     // }
//     return
// }

font_file_loader_CreateStreamFromKey :: proc "std" (this_ptr: ^dwrite.IFontFileLoader, key: rawptr, key_size: win32.UINT32, out_stream: ^^dwrite.IFontFileStream) -> win32.HRESULT {
    context = runtime.default_context()
    assert(key_size == size_of(Hash))
    stream := first_free_stream
    if stream == nil {
        stream = new(Font_File_Stream)
    } else {
        if first_free_stream != nil {
            first_free_stream = first_free_stream.next
        }
    }
    mem.zero_item(stream)
    stream.lpVtbl = &font_file_stream_vtable
    stream.ref_count = 1
    out_stream^ = cast(^dwrite.IFontFileStream)stream
    // fmt.println("Create Stream")
    return S_OK
}

Hash :: struct {
    _u64: [2]u64,
}

main :: proc() {
    factory: ^dwrite.IFactory
    rendering_params: ^dwrite.IRenderingParams
    gdi_interop: ^dwrite.IGdiInterop
    win_err: win32.HRESULT
    hash := Hash { _u64 = {0, 0}} // Fake Hash
    //- rjf: make dwrite factory
    win_err = dwrite.create_factory(.ISOLATED, &factory)
    if win_err != S_OK {
        panic("help")
    }
     
    //- rjf: register font file loader
    win_err = dwrite.register_font_file_loader(factory, cast(^dwrite.IFontFileLoader)&font_file_loader)
    if win_err != S_OK {
        panic("help")
    }
    //- mono: create custom rendering params
    win_err = dwrite.create_custom_rendering_params(factory, &rendering_params)
    if win_err != S_OK {
        panic("help")
    }
    //- rjf: setup dwrite/gdi interop
    win_err = dwrite.get_gdi_interop(factory, &gdi_interop)
    if win_err != S_OK {
        panic("help")
    }
    win_err = dwrite.test(factory, &hash, size_of(hash), cast(^dwrite.IFontFileLoader)&font_file_loader)
    if win_err != S_OK {
        panic("help")
    }
    fmt.println("PLEASE WORK!")
}