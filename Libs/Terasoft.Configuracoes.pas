unit Terasoft.Configuracoes;

interface

uses
  Data.DB,
  System.SysUtils,
  Vcl.Dialogs,
  FireDAC.Comp.Client,
  System.StrUtils,
  Terasoft.Types,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

  {$i FuncoesConfigSCI.inc}

  type
    TerasoftConfiguracoes = class;

    ITerasoftConfiguracoes = IObject<TerasoftConfiguracoes>;

    TerasoftConfiguracoes = class
    private
      [unsafe] mySelf: ITerasoftConfiguracoes;
      [weak]vIConexao        : IConexao;
      vPerfil          : String;
      vmtConfiguracoes : IFDDataset;

      procedure preparaTabela;
      procedure carregarConfiguracoes;

    public
      function valorTag(tag: String; ValorPadrao: Variant; tipoValor: TTipoValorConfiguracao = tvString; pPerfil: String = ''): Variant;
      function VerificaPermissaoAcesso(pTag, pPerfil : String): Boolean;
      function verificaPerfil(pTag : String): Boolean;

      constructor _Create(pIConexao : IConexao);
      destructor Destroy; override;

      class function getNewIface(pIConexao: IConexao): ITerasoftConfiguracoes;

    end;

implementation

uses
  Terasoft.Framework.LOG,
  Terasoft.Utils, ConfiguracoesModel, System.Variants;

{ TerasoftSistemaConfigura }

procedure TerasoftConfiguracoes.carregarConfiguracoes;
var
  lConfiguracoesModel,
  lModel               : ITConfiguracoesModel;
begin
  logaByTagSeNivel(TAGLOG_CONDICIONAL, 'TerasoftConfiguracoes.carregarConfiguracoes: Criando TConfiguracoesModel',LOG_LEVEL_DEBUG);
  lConfiguracoesModel := TConfiguracoesModel.getNewIface(vIConexao);
  try
    logaByTagSeNivel(TAGLOG_CONDICIONAL, 'TerasoftConfiguracoes.carregarConfiguracoes: TConfiguracoesModel.obterLista',LOG_LEVEL_DEBUG);
    lConfiguracoesModel.objeto.obterLista;

    logaMemoriaEmUso;
    logaByTagSeNivel(TAGLOG_CONDICIONAL, Format('TerasoftConfiguracoes.carregarConfiguracoes: Atribuindo [%d] registros para vmtConfiguracoes',[lConfiguracoesModel.objeto.ConfiguracoessLista.Count]),LOG_LEVEL_DEBUG);
    for lModel in lConfiguracoesModel.objeto.ConfiguracoessLista do
    begin
      vmtConfiguracoes.objeto.Append;
      vmtConfiguracoes.objeto.FieldByName('ID').Value             := IIF(lModel.objeto.ID             = '', Unassigned, lModel.objeto.ID);
      vmtConfiguracoes.objeto.FieldByName('TAG').Value            := IIF(lModel.objeto.TAG            = '', Unassigned, lModel.objeto.TAG);
      vmtConfiguracoes.objeto.FieldByName('PERFIL_ID').Value      := IIF(lModel.objeto.PERFIL_ID      = '', Unassigned, lModel.objeto.PERFIL_ID);
      vmtConfiguracoes.objeto.FieldByName('VALORINTEIRO').Value   := IIF(lModel.objeto.VALORINTEIRO   = '', Unassigned, lModel.objeto.VALORINTEIRO);
      vmtConfiguracoes.objeto.FieldByName('VALORSTRING').Value    := IIF(lModel.objeto.VALORSTRING    = '', Unassigned, lModel.objeto.VALORSTRING);
      vmtConfiguracoes.objeto.FieldByName('VALORNUMERICO').Value  := IIF(lModel.objeto.VALORNUMERICO  = '', Unassigned, lModel.objeto.VALORNUMERICO);
      vmtConfiguracoes.objeto.FieldByName('VALORCHAR').Value      := IIF(lModel.objeto.VALORCHAR      = '', Unassigned, lModel.objeto.VALORCHAR);
      vmtConfiguracoes.objeto.FieldByName('VALORDATA').Value      := IIF(lModel.objeto.VALORDATA      = '', Unassigned, lModel.objeto.VALORDATA);
      vmtConfiguracoes.objeto.FieldByName('VALORHORA').Value      := IIF(lModel.objeto.VALORHORA      = '', Unassigned, lModel.objeto.VALORHORA);
      vmtConfiguracoes.objeto.FieldByName('VALORDATAHORA').Value  := IIF(lModel.objeto.VALORDATAHORA  = '', Unassigned, lModel.objeto.VALORDATAHORA);
      vmtConfiguracoes.objeto.FieldByName('VALORMEMO').Value      := IIF(lModel.objeto.VALORMEMO      = '', Unassigned, lModel.objeto.VALORMEMO);
      vmtConfiguracoes.objeto.CheckBrowseMode;
    end;
    logaByTagSeNivel(TAGLOG_CONDICIONAL, format('[%d] Registros atribuidos para vmtConfiguracoes',[lConfiguracoesModel.objeto.ConfiguracoessLista.Count]),LOG_LEVEL_DEBUG);
    logaMemoriaEmUso;

  finally
    lConfiguracoesModel:=nil;
  end;
end;

constructor TerasoftConfiguracoes._Create(pIConexao : IConexao);
begin
  logaByTagSeNivel(TAGLOG_CONDICIONAL, 'TerasoftConfiguracoes._Create: Criando Configurações',LOG_LEVEL_DEBUG);
  vIConexao        := pIConexao;
  if(vIConexao.terasoftConfiguracoes=nil) then
    vIConexao.terasoftConfiguracoes := myself;

  logaByTagSeNivel(TAGLOG_CONDICIONAL, 'TerasoftConfiguracoes._Create: Crianto vmtConfiguracoes',LOG_LEVEL_DEBUG);
  vmtConfiguracoes := criaIFDDataset(TFDMemTable.Create(nil));

  preparaTabela;
  carregarConfiguracoes;
end;

destructor TerasoftConfiguracoes.Destroy;
begin
  vmtConfiguracoes := nil;
  vIConexao := nil;
  inherited;
end;

class function TerasoftConfiguracoes.getNewIface(pIConexao: IConexao): ITerasoftConfiguracoes;
begin
  Result := TImplObjetoOwner<TerasoftConfiguracoes>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

procedure TerasoftConfiguracoes.preparaTabela;
begin
  logaByTagSeNivel(TAGLOG_CONDICIONAL, 'TerasoftConfiguracoes.preparaTabela:',LOG_LEVEL_DEBUG);
  with TFDMemTable(vmtConfiguracoes.objeto).FieldDefs do begin
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

    vmtConfiguracoes.objeto.Open;
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

  vmtConfiguracoes.objeto.First;

  if pPerfil <> '' then
  begin
    if not vmtConfiguracoes.objeto.Locate('TAG;PERFIL_ID', VarArrayOf([tag, pPerfil]), []) then
    begin
      Result := valorPadrao;
      exit;
    end;
  end
  else
  begin
    if not vmtConfiguracoes.objeto.Locate('TAG', tag, []) then
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

  lField := vmtConfiguracoes.objeto.FindField(lNomeCampo);

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
