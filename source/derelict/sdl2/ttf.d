/*

Boost Software License - Version 1.0 - August 17th, 2003

Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license (the "Software") to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:

The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

*/
module derelict.sdl2.ttf;

private {
    import core.stdc.config;

    import derelict.util.loader;
    import derelict.util.system;
    import derelict.sdl2.types;
    import derelict.sdl2.functions;

    static if( Derelict_OS_Windows )
        enum libNames = "SDL2_ttf.dll";
    else static if( Derelict_OS_Mac )
        enum libNames = "../Frameworks/SDL2_ttf.framework/SDL2_ttf, /Library/Frameworks/SDL2_ttf.framework/SDL2_ttf, /System/Library/Frameworks/SDL2_ttf.framework/SDL2_ttf";
    else static if( Derelict_OS_Posix )
        enum libNames = "libSDL2_ttf.so, libSDL2_ttf-2.0.so, libSDL2_ttf-2.0.so.0, /usr/local/lib/libSDL2_ttf-2.0.so, /usr/local/lib/libSDL2_ttf-2.0.so.0";
    else
        static assert( 0, "Need to implement SDL2_ttf libNames for this operating system." );
}

enum : Uint8 {
    SDL_TTF_MAJOR_VERSION = 2,
    SDL_TTF_MINOR_VERSION = 0,
    SDL_TTF_PATCHLEVEL    = 12,
}
alias TTF_MAJOR_VERSION = SDL_TTF_MAJOR_VERSION;
alias TTF_MINOR_VERSION = SDL_TTF_MINOR_VERSION;
alias TTF_PATCHLEVEL = SDL_TTF_PATCHLEVEL;

enum {
    UNICODE_BOM_NATIVE = 0xFEFF,
    UNICODE_BOM_SWAPPED = 0xFFFE,
    TTF_STYLE_NORMAL = 0x00,
    TTF_STYLE_BOLD = 0x01,
    TTF_STYLE_ITALIC = 0x02,
    TTF_STYLE_UNDERLINE = 0x04,
    TTF_STYLE_STRIKETHROUGH = 0x08,
}

enum {
    TTF_HINTING_NORMAL = 0,
    TTF_HINTING_LIGHT = 1,
    TTF_HINTING_MONO = 2,
    TTF_HINTING_NONE = 3,
}

alias TTF_SetError = SDL_SetError;
alias TTF_GetError = SDL_GetError;

struct TTF_Font;

nothrow void SDL_TTF_VERSION( SDL_version* X ) {
    X.major = SDL_TTF_MAJOR_VERSION;
    X.minor = SDL_TTF_MINOR_VERSION;
    X.patch = SDL_TTF_PATCHLEVEL;
}

nothrow void TTF_VERSION( SDL_version* X ) { SDL_TTF_VERSION( X ); }

extern ( C ) nothrow {
    alias da_TTF_Linked_Version = SDL_version* function();
    alias da_TTF_ByteSwappedUNICODE = void function( int );
    alias da_TTF_Init = int function();
    alias da_TTF_OpenFont = TTF_Font * function ( const( char )*, int );
    alias da_TTF_OpenFontIndex = TTF_Font * function ( const( char )*, int, c_long  );
    alias da_TTF_OpenFontRW = TTF_Font * function ( SDL_RWops*, int, int );
    alias da_TTF_OpenFontIndexRW = TTF_Font * function ( SDL_RWops*, int, int, c_long );
    alias da_TTF_GetFontStyle = int function ( const( TTF_Font )* );
    alias da_TTF_SetFontStyle = void function ( const( TTF_Font )*, int style );
    alias da_TTF_GetFontOutline = int function( const( TTF_Font )* );
    alias da_TTF_SetFontOutline = void function( TTF_Font*, int );
    alias da_TTF_GetFontHinting = int function( const( TTF_Font )* );
    alias da_TTF_SetFontHinting = void function( TTF_Font*, int );
    alias da_TTF_FontHeight = int function( const( TTF_Font )* );
    alias da_TTF_FontAscent = int function( const( TTF_Font )* );
    alias da_TTF_FontDescent = int function( const( TTF_Font )* );
    alias da_TTF_FontLineSkip = int function( const( TTF_Font )* );
    alias da_TTF_GetFontKerning = int function( const( TTF_Font )* );
    alias da_TTF_SetFontKerning = void function( TTF_Font*, int );
    alias da_TTF_FontFaces = int function( const( TTF_Font )* );
    alias da_TTF_FontFaceIsFixedWidth = int function( const( TTF_Font )* );
    alias da_TTF_FontFaceFamilyName = char* function( const( TTF_Font )* );
    alias da_TTF_FontFaceStyleName = char* function( const( TTF_Font )* );
    alias da_TTF_GlyphIsProvided = int function( const( TTF_Font )*, Uint16 );
    alias da_TTF_GlyphMetrics = int function ( TTF_Font*, Uint16, int*, int*, int*, int*, int* );
    alias da_TTF_SizeText = int function ( TTF_Font*, const( char )*, int*, int* );
    alias da_TTF_SizeUTF8 = int function ( TTF_Font*, const( char )*, int*, int* );
    alias da_TTF_SizeUNICODE = int function ( TTF_Font*, Uint16*, int*, int* );
    alias da_TTF_RenderText_Solid = SDL_Surface* function ( TTF_Font*, const( char )*, SDL_Color );
    alias da_TTF_RenderUTF8_Solid = SDL_Surface* function ( TTF_Font*, const( char )*, SDL_Color );
    alias da_TTF_RenderUNICODE_Solid = SDL_Surface* function ( TTF_Font*, const( Uint16 )*, SDL_Color );
    alias da_TTF_RenderGlyph_Solid = SDL_Surface* function ( TTF_Font*, Uint16, SDL_Color );
    alias da_TTF_RenderText_Shaded = SDL_Surface* function ( TTF_Font*, const( char )*, SDL_Color, SDL_Color );
    alias da_TTF_RenderUTF8_Shaded = SDL_Surface* function ( TTF_Font*, const( char )*, SDL_Color, SDL_Color );
    alias da_TTF_RenderUNICODE_Shaded = SDL_Surface* function ( TTF_Font*, const( Uint16 )*, SDL_Color, SDL_Color );
    alias da_TTF_RenderGlyph_Shaded = SDL_Surface* function ( TTF_Font*, Uint16, SDL_Color, SDL_Color );
    alias da_TTF_RenderText_Blended = SDL_Surface* function ( TTF_Font*, const( char )*, SDL_Color );
    alias da_TTF_RenderUTF8_Blended = SDL_Surface* function ( TTF_Font*, const( char )*, SDL_Color );
    alias da_TTF_RenderUNICODE_Blended = SDL_Surface* function ( TTF_Font*, const( Uint16 )*, SDL_Color );
    alias da_TTF_RenderGlyph_Blended = SDL_Surface* function ( TTF_Font*, Uint16, SDL_Color );
    alias da_TTF_CloseFont = void function ( TTF_Font* );
    alias da_TTF_Quit = void function ();
    alias da_TTF_WasInit = int function ();
    alias da_TTF_GetFontKerningSize = int function( TTF_Font*,int,int );
}

__gshared {
    da_TTF_Linked_Version TTF_Linked_Version;
    da_TTF_ByteSwappedUNICODE TTF_ByteSwappedUNICODE;
    da_TTF_Init TTF_Init;
    da_TTF_OpenFont TTF_OpenFont;
    da_TTF_OpenFontIndex TTF_OpenFontIndex;
    da_TTF_OpenFontRW TTF_OpenFontRW;
    da_TTF_OpenFontIndexRW TTF_OpenFontIndexRW;
    da_TTF_GetFontStyle TTF_GetFontStyle;
    da_TTF_SetFontStyle TTF_SetFontStyle;
    da_TTF_GetFontOutline TTF_GetFontOutline;
    da_TTF_SetFontOutline TTF_SetFontOutline;
    da_TTF_GetFontHinting TTF_GetFontHinting;
    da_TTF_SetFontHinting TTF_SetFontHinting;
    da_TTF_FontHeight TTF_FontHeight;
    da_TTF_FontAscent TTF_FontAscent;
    da_TTF_FontDescent TTF_FontDescent;
    da_TTF_FontLineSkip TTF_FontLineSkip;
    da_TTF_GetFontKerning TTF_GetFontKerning;
    da_TTF_SetFontKerning TTF_SetFontKerning;
    da_TTF_FontFaces TTF_FontFaces;
    da_TTF_FontFaceIsFixedWidth TTF_FontFaceIsFixedWidth;
    da_TTF_FontFaceFamilyName TTF_FontFaceFamilyName;
    da_TTF_FontFaceStyleName TTF_FontFaceStyleName;
    da_TTF_GlyphIsProvided TTF_GlyphIsProvided;
    da_TTF_GlyphMetrics TTF_GlyphMetrics;
    da_TTF_SizeText TTF_SizeText;
    da_TTF_SizeUTF8 TTF_SizeUTF8;
    da_TTF_SizeUNICODE TTF_SizeUNICODE;
    da_TTF_RenderText_Solid TTF_RenderText_Solid;
    da_TTF_RenderUTF8_Solid TTF_RenderUTF8_Solid;
    da_TTF_RenderUNICODE_Solid TTF_RenderUNICODE_Solid;
    da_TTF_RenderGlyph_Solid TTF_RenderGlyph_Solid;
    da_TTF_RenderText_Shaded TTF_RenderText_Shaded;
    da_TTF_RenderUTF8_Shaded TTF_RenderUTF8_Shaded;
    da_TTF_RenderUNICODE_Shaded TTF_RenderUNICODE_Shaded;
    da_TTF_RenderGlyph_Shaded TTF_RenderGlyph_Shaded;
    da_TTF_RenderText_Blended TTF_RenderText_Blended;
    da_TTF_RenderUTF8_Blended TTF_RenderUTF8_Blended;
    da_TTF_RenderUNICODE_Blended TTF_RenderUNICODE_Blended;
    da_TTF_RenderGlyph_Blended TTF_RenderGlyph_Blended;
    da_TTF_CloseFont TTF_CloseFont;
    da_TTF_Quit TTF_Quit;
    da_TTF_WasInit TTF_WasInit;
    da_TTF_GetFontKerningSize TTF_GetFontKerningSize;
}

alias TTF_RenderText = TTF_RenderText_Shaded;
alias TTF_RenderUTF8 = TTF_RenderUTF8_Shaded;
alias TTF_RenderUNICODE = TTF_RenderUNICODE_Shaded;

class DerelictSDL2ttfLoader : SharedLibLoader {
    public this() {
        super( libNames );
    }

    protected override void loadSymbols() {
        bindFunc( cast( void** )&TTF_Linked_Version, "TTF_Linked_Version" );
        bindFunc( cast( void** )&TTF_ByteSwappedUNICODE, "TTF_ByteSwappedUNICODE" );
        bindFunc( cast( void** )&TTF_Init, "TTF_Init" );
        bindFunc( cast( void** )&TTF_OpenFont, "TTF_OpenFont" );
        bindFunc( cast( void** )&TTF_OpenFontIndex, "TTF_OpenFontIndex" );
        bindFunc( cast( void** )&TTF_OpenFontRW, "TTF_OpenFontRW" );
        bindFunc( cast( void** )&TTF_OpenFontIndexRW, "TTF_OpenFontIndexRW" );
        bindFunc( cast( void** )&TTF_GetFontStyle, "TTF_GetFontStyle" );
        bindFunc( cast( void** )&TTF_SetFontStyle, "TTF_SetFontStyle" );
        bindFunc( cast( void** )&TTF_GetFontOutline, "TTF_GetFontOutline" );
        bindFunc( cast( void** )&TTF_SetFontOutline, "TTF_SetFontOutline" );
        bindFunc( cast( void** )&TTF_GetFontHinting, "TTF_GetFontHinting" );
        bindFunc( cast( void** )&TTF_SetFontHinting, "TTF_SetFontHinting" );
        bindFunc( cast( void** )&TTF_FontHeight, "TTF_FontHeight" );
        bindFunc( cast( void** )&TTF_FontAscent, "TTF_FontAscent" );
        bindFunc( cast( void** )&TTF_FontDescent, "TTF_FontDescent" );
        bindFunc( cast( void** )&TTF_FontLineSkip, "TTF_FontLineSkip" );
        bindFunc( cast( void** )&TTF_GetFontKerning, "TTF_GetFontKerning" );
        bindFunc( cast( void** )&TTF_SetFontKerning, "TTF_SetFontKerning" );
        bindFunc( cast( void** )&TTF_FontFaces, "TTF_FontFaces" );
        bindFunc( cast( void** )&TTF_FontFaceIsFixedWidth, "TTF_FontFaceIsFixedWidth" );
        bindFunc( cast( void** )&TTF_FontFaceFamilyName, "TTF_FontFaceFamilyName" );
        bindFunc( cast( void** )&TTF_FontFaceStyleName, "TTF_FontFaceStyleName" );
        bindFunc( cast( void** )&TTF_GlyphIsProvided, "TTF_GlyphIsProvided" );
        bindFunc( cast( void** )&TTF_GlyphMetrics, "TTF_GlyphMetrics" );
        bindFunc( cast( void** )&TTF_SizeText, "TTF_SizeText" );
        bindFunc( cast( void** )&TTF_SizeUTF8, "TTF_SizeUTF8" );
        bindFunc( cast( void** )&TTF_SizeUNICODE, "TTF_SizeUNICODE" );
        bindFunc( cast( void** )&TTF_RenderText_Solid, "TTF_RenderText_Solid" );
        bindFunc( cast( void** )&TTF_RenderUTF8_Solid, "TTF_RenderUTF8_Solid" );
        bindFunc( cast( void** )&TTF_RenderUNICODE_Solid, "TTF_RenderUNICODE_Solid" );
        bindFunc( cast( void** )&TTF_RenderGlyph_Solid, "TTF_RenderGlyph_Solid" );
        bindFunc( cast( void** )&TTF_RenderText_Shaded, "TTF_RenderText_Shaded" );
        bindFunc( cast( void** )&TTF_RenderUTF8_Shaded, "TTF_RenderUTF8_Shaded" );
        bindFunc( cast( void** )&TTF_RenderUNICODE_Shaded, "TTF_RenderUNICODE_Shaded" );
        bindFunc( cast( void** )&TTF_RenderGlyph_Shaded, "TTF_RenderGlyph_Shaded" );
        bindFunc( cast( void** )&TTF_RenderText_Blended, "TTF_RenderText_Blended" );
        bindFunc( cast( void** )&TTF_RenderUTF8_Blended, "TTF_RenderUTF8_Blended" );
        bindFunc( cast( void** )&TTF_RenderUNICODE_Blended, "TTF_RenderUNICODE_Blended" );
        bindFunc( cast( void** )&TTF_RenderGlyph_Blended, "TTF_RenderGlyph_Blended" );
        bindFunc( cast( void** )&TTF_CloseFont, "TTF_CloseFont" );
        bindFunc( cast( void** )&TTF_Quit, "TTF_Quit" );
        bindFunc( cast( void** )&TTF_WasInit, "TTF_WasInit" );
        bindFunc( cast( void** )&TTF_GetFontKerningSize, "TTF_GetFontKerningSize" );
    }
}

__gshared DerelictSDL2ttfLoader DerelictSDL2ttf;

shared static this() {
    DerelictSDL2ttf = new DerelictSDL2ttfLoader();
}