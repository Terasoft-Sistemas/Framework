
{$i definicoes.inc}

unit Terasoft.Framework.SimpleTypes;

interface
  uses
    SysUtils,Classes;

  type
    TipoVariantJS = Variant;

    TipoOleString = OleVariant;

    TipoAnsiStringFramework = AnsiString;

    {$if defined(DXE_UP)}
      TipoStringFramework = UnicodeString;
    {$else}
      TipoStringFramework = WideString;
    {$ifend}

    TipoWideStringFramework = WideString;

implementation

end.
