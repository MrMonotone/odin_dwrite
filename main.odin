package main
import "core:fmt"
import win32 "core:sys/windows"
import "core:os"
import "core:runtime"
import "core:mem"
import "core:mem/virtual"
import "dwrite"

S_OK :: win32.HRESULT(0)

file_data_test_b := #load("./Roboto.ttf")
file_data_test_s := #load("./tiny.regular.ttf")
file_data_test : []byte = file_data_test_b
hash: Hash

first_free_stream: ^Font_File_Stream

Font_File_Stream :: struct {
    using _: dwrite.IFontFileStream,
    next: ^Font_File_Stream,
    hash: Hash,
    ref_count: u32,
}

@(link_section="rodata")
font_file_stream_vtable : dwrite.IFontFileStream_VTable = {
    QueryInterface = font_file_stream_QueryInterface,
    AddRef = font_file_stream_AddRef,
    Release = font_file_stream_Release,
    ReadFileFragment = font_file_stream_ReadFileFragment,
    ReleaseFileFragment = font_file_stream_ReleaseFileFragment,
    GetFileSize = font_file_stream_GetFileSize,
    GetLastWriteTime = font_file_stream_GetLastWriteTime,
}

font_file_loader := Font_File_Loader {
    ifontfileloader_vtable = &font_file_loader_vtable,
}

Font_File_Loader :: struct {
    using _: dwrite.IFontFileLoader,
}

@(link_section="rodata")
font_file_loader_vtable : dwrite.IFontFileLoader_VTable = {
    QueryInterface = font_file_loader_QueryInterface,
    AddRef = font_file_loader_AddRef,
    Release = font_file_loader_Release,
    CreateStreamFromKey = font_file_loader_CreateStreamFromKey,
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
        this.next= first_free_stream
        first_free_stream = this
    }
    // fmt.println("ref count: ", this.ref_count)
    return this.ref_count
}

font_file_stream_ReadFileFragment :: proc "stdcall" (this_ptr: ^dwrite.IFontFileStream, fragment_start: ^rawptr, off: u64, size: u64, fragment_ctx_out: ^rawptr) -> win32.HRESULT {
    context = runtime.default_context()
    this := cast(^Font_File_Stream)this_ptr
    test := raw_data(file_data_test[off:])
    test2 := rawptr(cast(uintptr)&file_data_test[0] + uintptr(off) * size_of(file_data_test[0]))
    fmt.println(this.hash)
    fragment_start^ = test
    fragment_ctx_out^ = nil
    return S_OK
}

font_file_stream_ReleaseFileFragment :: proc "std" (this_ptr: ^dwrite.IFontFileStream, fragment_ctx: rawptr) {
    context = runtime.default_context()
    // fmt.println("NO OP")
}

font_file_stream_GetFileSize :: proc "std" (this_ptr: ^dwrite.IFontFileStream, out_file_size: ^u64) -> win32.HRESULT {
    context = runtime.default_context()
    fmt.println("data size: ",len(file_data_test))

    out_file_size^ = cast(u64)len(file_data_test)
    return S_OK
}

font_file_stream_GetLastWriteTime :: proc "std" (this_ptr: ^dwrite.IFontFileStream, out_time: ^u64) -> win32.HRESULT {
    context = runtime.default_context()
    out_time^ = 0
    return S_OK
}

font_file_loader_QueryInterface:: proc "std" (this_ptr: ^dwrite.IUnknown, riid: ^win32.IID, ppvObject: ^rawptr) -> win32.HRESULT {
    res := S_OK
    ppvObject^ = &font_file_loader
    return res
}

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
    stream.ifontfilestream_vtable = &font_file_stream_vtable
    mem.copy(&stream.hash, key, size_of(Hash));
    stream.ref_count = 1
    out_stream^ = stream
    // fmt.println("Create Stream")
    return S_OK
}

font_file_loader_AddRef :: proc "std" (this_ptr: ^dwrite.IUnknown) -> win32.ULONG {
    context = runtime.default_context()
    return 1;
}

font_file_loader_Release :: proc "std" (this_ptr: ^dwrite.IUnknown) -> win32.ULONG {
    context = runtime.default_context()
    return 1;
}

Hash :: struct {
    _u64: [2]u64,
}

main :: proc() {
    factory: ^dwrite.IFactory
    base_rendering_params: ^dwrite.IRenderingParams
    rendering_params: ^dwrite.IRenderingParams
    gdi_interop: ^dwrite.IGdiInterop
    error: win32.HRESULT
    hash._u64 = {123123, 11231231} // Fake Hash
    //- rjf: make dwrite factory
    error = dwrite.DWriteCreateFactory(.ISOLATED, &dwrite.IFactory_UUID, cast(^^dwrite.IUnknown)&factory)
    
    //- rjf: register font file loader
    error = factory->RegisterFontFileLoader(cast(^dwrite.IFontFileLoader)&font_file_loader)
    
    //- rjf: make dwrite base rendering params
    error = factory->CreateRenderingParams(&base_rendering_params);
    
    //- rjf: make dwrite rendering params
    gamma := base_rendering_params->GetGamma()
    enhanced_contrast := base_rendering_params->GetEnhancedContrast()
    clear_type_level := base_rendering_params->GetClearTypeLevel()
    error = factory->CreateCustomRenderingParams(gamma,
                                                enhanced_contrast,
                                                clear_type_level,
                                                .FLAT,
                                                .DEFAULT,
                                                &rendering_params)
    if error != S_OK {
        panic("help")
    }
    
    //- rjf: setup dwrite/gdi interop
    error = factory->GetGdiInterop(&gdi_interop)
    if error != S_OK {
        panic("help")
    }

    //- rjf: make a "font file reference"... oh boy x2...
    font_file: ^dwrite.IFontFile
    error = factory->CreateCustomFontFileReference(&hash, size_of(hash), cast(^dwrite.IFontFileLoader)&font_file_loader, &font_file)
    if error != S_OK {
        panic("help")
    }
    fileType: dwrite.FONT_FILE_TYPE
    faceType: dwrite.FONT_FACE_TYPE
    numberOfFaces: win32.UINT32
    isSupported: win32.BOOL
    error = font_file->Analyze(&isSupported,&fileType, &faceType, &numberOfFaces)
    if error != S_OK {
        panic("help")
    }


    fmt.println("here")
    //- rjf: make dwrite font face
    font_face: ^dwrite.IFontFace = nil
    error = factory->CreateFontFace(.UNKNOWN, 1, &font_file, 0, { }, &font_face)

    if error != S_OK {
        panic("help")
    }
    fmt.println("PLEASE WORK!")
}