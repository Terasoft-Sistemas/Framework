unit Terasoft.Configuracoes;

interface

uses
  Data.DB,
  System.SysUtils,
  Vcl.Dialogs,
  FireDAC.Comp.Client,
  System.StrUtils,
  Terasoft.Types,
  Interfaces.Conexao;

  {$i FuncoesConfigSCI.inc}

  type
    TerasoftConfiguracoes = class

    private
      vIConexao        : IConexao;
      vPerfil          : String;
      vmtConfiguracoes : TFDMemTable;

      procedure preparaTabela;
      procedure carregarConfiguracoes;

    public
      function valorTag(tag: String; ValorPadrao: Variant; tipoValor: TTipoValorConfiguracao = tvString; pPerfil: String = ''): Variant;
      function VerificaPermissaoAcesso(pTag, pPerfil : String): Boolean;
      function verificaPerfil(pTag : String): Boolean;

      constructor Create(pIConexao : IConexao);
      destructor Destroy; override;
    end;

implementation

uses
  Terasoft.Utils, ConfiguracoesModel, System.Variants;

{ TerasoftSistemaConfigura }

procedure TerasoftConfiguracoes.carregarConfiguracoes;
var
  lConfiguracoesModel,
  lModel               : TConfiguracoesModel;
begin
  lConfiguracoesModel := TConfiguracoesModel.Create(vIConexao);
  try
    lConfiguracoesModel.obterLista;

    for lModel in lConfiguracoesModel.ConfiguracoessLista do
    begin
      vmtConfiguracoes.Append;
      vmtConfiguracoes.FieldByName('ID').Value             := IIF(lModel.ID             = '', Unassigned, lModel.ID);
      vmtConfiguracoes.FieldByName('TAG').Value            := IIF(lModel.TAG            = '', Unassigned, lModel.TAG);
      vmtConfiguracoes.FieldByName('PERFIL_ID').Value      := IIF(lModel.PERFIL_ID      = '', Unassigned, lModel.PERFIL_ID);
      vmtConfiguracoes.FieldByName('VALORINTEIRO').Value   := IIF(lModel.VALORINTEIRO   = '', Unassigned, lModel.VALORINTEIRO);
      vmtConfiguracoes.FieldByName('VALORSTRING').Value    := IIF(lModel.VALORSTRING    = '', Unassigned, lModel.VALORSTRING);
      vmtConfiguracoes.FieldByName('VALORNUMERICO').Value  := IIF(lModel.VALORNUMERICO  = '', Unassigned, lModel.VALORNUMERICO);
      vmtConfiguracoes.FieldByName('VALORCHAR').Value      := IIF(lModel.VALORCHAR      = '', Unassigned, lModel.VALORCHAR);
      vmtConfiguracoes.FieldByName('VALORDATA').Value      := IIF(lModel.VALORDATA      = '', Unassigned, lModel.VALORDATA);
      vmtConfiguracoes.FieldByName('VALORHORA').Value      := IIF(lModel.VALORHORA      = '', Unassigned, lModel.VALORHORA);
      vmtConfiguracoes.FieldByName('VALORDATAHORA').Value  := IIF(lModel.VALORDATAHORA  = '', Unassigned, lModel.VALORDATAHORA);
      vmtConfiguracoes.FieldByName('VALORMEMO').Value      := IIF(lModel.VALORMEMO      = '', Unassigned, lModel.VALORMEMO);
      vmtConfiguracoes.Post;
    end;
  finally
    lConfiguracoesModel.Free;
  end;
end;

constructor TerasoftConfiguracoes.Create(pIConexao : IConexao);
begin
  vIConexao        := pIConexao;
  vmtConfiguracoes := TFDMemTable.Create(nil);

  preparaTabela;
  carregarConfiguracoes;
end;

destructor TerasoftConfiguracoes.Destroy;
begin

  inherited;
end;

procedure TerasoftConfiguracoes.preparaTabela;
begin
  with vmtConfiguracoes.FieldDefs do begin
    with AddFieldDef do begin
      Name      := 'ID';
      DataType  := ftString;
      Size      := 20;
    end;

    with AddFieldDef do begin
      Name      := 'TAG';
      DataType  := ftString;
      Size      := 100;
    end;

    with AddFieldDef do begin
      Name      := 'PERFIL_ID';
      DataType  := ftString;
      Size      := 6;
    end;

    with AddFieldDef do begin
      Name      := 'VALORINTEIRO';
      DataType  := ftInteger;
    end;

    with AddFieldDef do begin
      Name      := 'VALORSTRING';
      DataType  := ftString;
      Size      := 255;
    end;

    with AddFieldDef do begin
      Name      := 'VALORNUMERICO';
      DataType  := ftString;
      Size      := 10;
    end;

    with AddFieldDef do begin
      Name      := 'VALORCHAR';
      DataType  := ftString;
      Size      := 1;
    end;

    with AddFieldDef do begin
      Name      := 'VALORDATA';
      DataType  := ftDate;
    end;

    with AddFieldDef do begin
      Name      := 'VALORHORA';
      DataType  := ftTime;
    end;

    with AddFieldDef do begin
      Name      := 'VALORDATAHORA';
      DataType  := ftDateTime;
    end;

    with AddFieldDef do begin
      Name      := 'VALORMEMO';
      DataType  := ftMemo;
    end;

    vmtConfiguracoes.Open;
  end;
end;

function TerasoftConfiguracoes.valorTag(tag: String; ValorPadrao: Variant; tipoValor: TTipoValorConfiguracao; pPerfil: String): Variant;
var
  lNomeCampo : String;
  lField     : TField;
  lSql       : String;
  lQry       : TFDQuery;
begin

  if tipoValor = tvEmpresa then
  begin
    lQry := vIConexao.CriarQuery;

    try
      lSQL := ' select first 1 '+tag+' from empresa ';

      lQry.Open(lSQL);

      lField := lQry.FindField(tag);

      if lField.IsNull then
        Result := ValorPadrao
      else
        Result := lField.Value;

    finally
      lQry.Free;
    end;

    exit;
  end;

  vmtConfiguracoes.First;

  if pPerfil <> '' then
  begin
    if not vmtConfiguracoes.Locate('TAG;PERFIL_ID', VarArrayOf([tag, pPerfil]), []) then
    begin
      Result := valorPadrao;
      exit;
    end;
  end
  else
  begin
    if not vmtConfiguracoes.Locate('TAG', tag, []) then
    begin
      Result := valorPadrao;
      exit;
    end;
  end;

  case tipoValor of
    tvInteiro   : lNomeCampo := 'VALORINTEIRO';
    tvNumero    : lNomeCampo := 'VALORNUMERICO';
    tvString    : lNomeCampo := 'VALORSTRING';
    tvMemo      : lNomeCampo := 'VALORMEMO';
    tvData      : lNomeCampo := 'VALORDATA';
    tvHora      : lNomeCampo := 'VALORHORA';
    tvDataHora  : lNomeCampo := 'VALORDATAHORA';
    tvChar      : lNomeCampo := 'VALORCHAR';
    tvBool      : lNomeCampo := 'VALORCHAR';
    tvEmpresa   : lNomeCampo := tag;
  end;

  lField := vmtConfiguracoes.FindField(lNomeCampo);

  if lField.IsNull then
    Result := ValorPadrao
  else
    Result := lField.Value;
end;

function TerasoftConfiguracoes.verificaPerfil(pTag : String): Boolean;
begin
  Result := VerificaPermissaoAcesso(pTag, vIConexao.getUSer.PERFIL);
end;

function TerasoftConfiguracoes.VerificaPermissaoAcesso(pTag, pPerfil: String): Boolean;
begin
  if (pPerfil = '000000') or (pPerfil = '000001') then
  begin
    Result := true;
    exit;
  end;

  Result := IIF(valorTag(pTag, 'N', tvChar, pPerfil) = 'S', True, False);
end;

end.
