package main
import "core:fmt"
import win32 "core:sys/windows"
import "core:slice"
import "core:os"
import "core:runtime"
import "core:mem"
import "core:mem/virtual"
import "dwrite"

S_OK :: win32.HRESULT(0)

FONT_PATH :: "C:\\Windows\\Fonts\\arial.ttf"

fkey: int = 1
first_free_stream: ^Font_File_Stream
file_data: []byte

data_from_hash :: proc() -> []byte {
    if (file_data == nil) {
        ok: bool
        fd, err := os.open(FONT_PATH)
        if err != 0 {
            panic("couldnt open file yo")
        }

        file_data, ok = os.read_entire_file_from_handle(fd)
        if !ok {
            panic("couldnt open file yo")
        }
        // perhaps we need this?
        // virtual.protect(&file_data, size_of(file_data), { .Read })
    }
    return file_data
}

font_file_stream_ReadFileFragment :: proc "std" (this_ptr: ^dwrite.IFontFileStream, fragment_start: ^rawptr, off: u64, size: u64, fragment_ctx_out: ^rawptr) -> win32.HRESULT {
    context = runtime.default_context()
    data := data_from_hash()

    // Check if the requested fragment is within the file bounds
    if (off + size > cast(u64)len(data)) {
        err := 0x80070057 // E_INVALIDARG
        // Return an error if the fragment is out of bounds
        return cast(win32.HRESULT)err
    }
    // test := uintptr(data.data) + uintptr(off)
    // fmt.println(&(data^))
    fragment_start^ = raw_data(data[off:])
    fragment_ctx_out^ = nil
    return S_OK
}


Font_File_Stream :: struct {
    using _: dwrite.IFontFileStream,
    // next: ^Font_File_Stream,
    ref_count: u32,
}

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
    context = runtime.default_context()
    this := cast(^Font_File_Stream)this_ptr
    this.ref_count -= 1
    if this.ref_count == 0 {
        panic("nope")
        // this.next = first_free_stream
        // first_free_stream = this
    }
    // fmt.println("ref count: ", this.ref_count)
    return this.ref_count
}

font_file_stream_ReleaseFileFragment :: proc "std" (this_ptr: ^dwrite.IFontFileStream, fragment_ctx: rawptr) {
    context = runtime.default_context()
    // fmt.println("NO OP")
}

font_file_stream_GetFileSize :: proc "std" (this_ptr: ^dwrite.IFontFileStream, out_file_size: ^u64) -> win32.HRESULT {
    context = runtime.default_context()
    data := data_from_hash()
    out_file_size^ = cast(u64)len(data)
    fmt.println("Size: ", len(data))
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
    // assert(key_size == size_of(int))
    // fmt.println(&(cast(^int)key)^ == &fkey)
    stream := first_free_stream
    if stream == nil {
        stream = new(Font_File_Stream)
    } else {
        panic("Reuse stream?")
    }
    stream.ifontfilestream_vtable = &font_file_stream_vtable
    stream.ref_count = 1
    out_stream^ = stream
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

// Hash :: struct {
//     _u64: [2]u64,
// }


// Has to be a problem with RegisterFontFileLoader / CreateCustomFontFileReference /
// CreateFontFace works with CreateFontFileReference...
// The problem is probably with ReadFileFragment and how that data is operated on... aka pointer and memory stuff...
main :: proc() {
    works()
    no_works()
}

no_works :: proc() {
    factory: ^dwrite.IFactory
    base_rendering_params: ^dwrite.IRenderingParams
    rendering_params: ^dwrite.IRenderingParams
    gdi_interop: ^dwrite.IGdiInterop
    error: win32.HRESULT

    //- rjf: make dwrite factory
    error = dwrite.DWriteCreateFactory(.ISOLATED, &dwrite.IFactory_UUID, cast(^^dwrite.IUnknown)&factory)
    
    //- rjf: register font file loader
    error = factory->RegisterFontFileLoader(cast(^dwrite.IFontFileLoader)&font_file_loader)

    //- rjf: make a "font file reference"... oh boy x2...
    font_file: ^dwrite.IFontFile
    error = factory->CreateCustomFontFileReference(&fkey, size_of(fkey) * 50, cast(^dwrite.IFontFileLoader)&font_file_loader, &font_file)
    if error != S_OK {
        panic("help")
    }


    // See the font file loaded?
    {
        fileType: dwrite.FONT_FILE_TYPE
        faceType: dwrite.FONT_FACE_TYPE
        numberOfFaces: win32.UINT32
        isSupported: win32.BOOL
        error = font_file->Analyze(&isSupported,&fileType, &faceType, &numberOfFaces)
        if error != S_OK {
            panic("help")
        }
        fmt.println("isSupported ", isSupported, "fileType ", fileType, "faceType ", faceType, "numberOfFaces ", numberOfFaces)

        hash2: rawptr
        size: u32
        error = font_file->GetReferenceKey(&hash2, &size)
        if error != S_OK {
            panic("help")
        }
        fmt.println((cast(^int)hash2)^)
    }

    //- rjf: make dwrite font face
    font_face: ^dwrite.IFontFace
    error = factory->CreateFontFace(.UNKNOWN, 1, &font_file, 0, { }, &font_face)

    if error != S_OK {
        fmt.println(error)
        panic("help")
    }
    fmt.println("PLEASE WORK!")
}

works :: proc() {
    factory: ^dwrite.IFactory
    base_rendering_params: ^dwrite.IRenderingParams
    rendering_params: ^dwrite.IRenderingParams
    gdi_interop: ^dwrite.IGdiInterop
    error: win32.HRESULT

    //- rjf: make dwrite factory
    error = dwrite.DWriteCreateFactory(.ISOLATED, &dwrite.IFactory_UUID, cast(^^dwrite.IUnknown)&factory)

    //- rjf: make a "font file reference"... oh boy x2...
    font_file: ^dwrite.IFontFile
    error = factory->CreateFontFileReference(win32.L(FONT_PATH), nil, &font_file)
    if error != S_OK {
        panic("help")
    }
    // test : =
    //- rjf: make dwrite font face
    font_face: ^dwrite.IFontFace
    error = factory->CreateFontFace(.UNKNOWN, 1, &font_file, 0, { }, &font_face)

    if error != S_OK {
        fmt.println(error)
        panic("help")
    }
    fmt.println(font_face)
}