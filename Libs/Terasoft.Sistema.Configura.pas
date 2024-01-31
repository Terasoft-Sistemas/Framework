unit Terasoft.Sistema.Configura;

interface

uses
  Data.DB,
  System.SysUtils,
  Vcl.Dialogs,
  FireDAC.Comp.Client,
  System.StrUtils,
  Terasoft.Types,
  Interfaces.Configuracoes;

  type
    TerasoftSistemaConfigura = class

    private
      vIConfiguracoes : IConfiguracoes;
    public
      function valorTag(tag: String; ValorPadrao: Variant; tipoValor: TTipoValorConfiguracao = tvString; pPerfil: String = ''): Variant;
      function VerificaPermissaoAcesso(pTag, pPerfil : String): Boolean;
      function verificaPerfil(pTag, pPerfil : String): Boolean;

      constructor Create(pIConfiguracoes : IConfiguracoes);
      destructor Destroy; override;
    end;

implementation

uses
  Terasoft.Utils;

{ TerasoftSistemaConfigura }

constructor TerasoftSistemaConfigura.Create(pIConfiguracoes : IConfiguracoes);
begin
  vIConfiguracoes := pIConfiguracoes;
end;

destructor TerasoftSistemaConfigura.Destroy;
begin

  inherited;
end;

function TerasoftSistemaConfigura.valorTag(tag: String; ValorPadrao: Variant; tipoValor: TTipoValorConfiguracao; pPerfil: String): Variant;
begin
  Result := vIConfiguracoes.valorTag(tag, ValorPadrao, tipoValor, pPerfil);
end;

function TerasoftSistemaConfigura.verificaPerfil(pTag, pPerfil: String): Boolean;
begin
  Result := VerificaPermissaoAcesso(pTag, pPerfil);
end;

function TerasoftSistemaConfigura.VerificaPermissaoAcesso(pTag, pPerfil: String): Boolean;
begin
  if (pPerfil = '000000') or (pPerfil = '000001') then
  begin
    Result := true;
    exit;
  end;

  Result := IIF(valorTag(pTag, 'N', tvChar, pPerfil) = 'S', True, False);
end;

end.
