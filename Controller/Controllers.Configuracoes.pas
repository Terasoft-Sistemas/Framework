unit Controllers.Configuracoes;

interface

  uses
    FireDAC.Comp.Client,
    System.Variants,
    Terasoft.Utils,
    Terasoft.Types,
    Interfaces.Conexao,
    Interfaces.Configuracoes,
    ConfiguracoesModel;

  type
    ControllersConfiguracoes = class(TInterfacedObject, IConfiguracoes)

      private
        vIConexao           : IConexao;
        vmtConfiguracoes    : TFDMemTable;
        vConfiguracoesModel : TConfiguracoesModel;

        function carregarConfiguracoes : IConfiguracoes;
        function valorTag(tag: String; ValorPadrao: Variant; tipoValor: TTipoValorConfiguracao = tvString; pPerfil: String = '')  : Variant;

        procedure preparaTabela;

      public
        Constructor Create(pIConexao : IConexao);
        Destructor Destroy; override;
        Class function New(pIConexao : IConexao) : IConfiguracoes;

    end;

implementation

uses
  Data.DB;

{ ControllersConfiguracoes }

function ControllersConfiguracoes.carregarConfiguracoes: IConfiguracoes;
var
  lModel : TConfiguracoesModel;
begin
  vConfiguracoesModel.obterLista;

  for lModel in vConfiguracoesModel.ConfiguracoessLista do
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
    vmtConfiguracoes.Post;
  end;
end;

constructor ControllersConfiguracoes.Create(pIConexao : IConexao);
begin
  vIConexao           := pIConexao;
  vmtConfiguracoes    := TFDMemTable.Create(nil);
  vConfiguracoesModel := TConfiguracoesModel.Create(vIConexao);

  preparaTabela;
end;

destructor ControllersConfiguracoes.Destroy;
begin

  inherited;
end;

class function ControllersConfiguracoes.New(pIConexao : IConexao): IConfiguracoes;
begin
  Result := Self.Create(pIConexao);
end;

procedure ControllersConfiguracoes.preparaTabela;
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

    vmtConfiguracoes.Open;
  end;
end;

function ControllersConfiguracoes.valorTag(tag: String; ValorPadrao: Variant; tipoValor: TTipoValorConfiguracao; pPerfil: String): Variant;
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

end.
