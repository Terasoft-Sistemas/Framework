unit ClientesEnderecoDao;

interface

uses
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.Types,
  Terasoft.Framework.ListaSimples.Impl,
  Terasoft.FuncoesTexto,
  Terasoft.Framework.ListaSimples,
  Terasoft.Framework.SimpleTypes,
  Interfaces.Conexao,
  Terasoft.ConstrutorDao,
  ClientesEnderecoModel;

type
  TClientesEnderecoDao = class

  private
    vIConexao : IConexao;
    vConstrutor : TConstrutorDao;

    FLengthPageView: String;
    FIDRecordView: String;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetIDRecordView(const Value: String);

    function where: String;

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView : String read FIDRecordView write SetIDRecordView;

    function incluir(pClientesEnderecoModel: TClientesEnderecoModel): String;
    function alterar(pClientesEnderecoModel: TClientesEnderecoModel): String;
    function excluir(pClientesEnderecoModel: TClientesEnderecoModel): String;

    function sincronizarDados(pClientesEnderecoModel: TClientesEnderecoModel): String;

    function carregaClasse(pID : String): TClientesEnderecoModel;

    function obterLista: IFDDataset;

    procedure setParams(var pQry: TFDQuery; pClientesEnderecoModel: TClientesEnderecoModel);

end;

implementation

uses
  System.Rtti, Data.DB, Terasoft.Configuracoes, LojasModel;

{ TClientesEndereco }

function TClientesEnderecoDao.alterar(pClientesEnderecoModel: TClientesEnderecoModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
  lConfiguracoes : ITerasoftConfiguracoes;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('CLIENTES_ENDERECO','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pClientesEnderecoModel);
    lQry.ExecSQL;

    Supports(vIConexao.getTerasoftConfiguracoes, ITerasoftConfiguracoes, lConfiguracoes);

    if lConfiguracoes.objeto.valorTag('ENVIA_SINCRONIZA', 'N', tvBool) = 'S' then
      sincronizarDados(pClientesEnderecoModel);

    Result := pClientesEnderecoModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TClientesEnderecoDao.carregaClasse(pID: String): TClientesEnderecoModel;
var
  lQry: TFDQuery;
  lModel: TClientesEnderecoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TClientesEnderecoModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from CLIENTES_ENDERECO where ID = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.ID            := lQry.FieldByName('ID').AsString;
    lModel.CLIENTE_ID    := lQry.FieldByName('CLIENTE_ID').AsString;
    lModel.ENDERECO      := lQry.FieldByName('ENDERECO').AsString;
    lModel.NUMERO        := lQry.FieldByName('NUMERO').AsString;
    lModel.COMPLEMENTO   := lQry.FieldByName('COMPLEMENTO').AsString;
    lModel.BAIRRO        := lQry.FieldByName('BAIRRO').AsString;
    lModel.CIDADE        := lQry.FieldByName('CIDADE').AsString;
    lModel.UF            := lQry.FieldByName('UF').AsString;
    lModel.CEP           := lQry.FieldByName('CEP').AsString;
    lModel.COD_MUNICIPIO := lQry.FieldByName('COD_MUNICIPIO').AsString;
    lModel.OBS           := lQry.FieldByName('OBS').AsString;
    lModel.TIPO          := lQry.FieldByName('TIPO').AsString;
    lModel.REGIAO_ID     := lQry.FieldByName('REGIAO_ID').AsString;
    lModel.TELEFONE      := lQry.FieldByName('TELEFONE').AsString;
    lModel.CONTATO       := lQry.FieldByName('CONTATO').AsString;
    lModel.SYSTIME       := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;
constructor TClientesEnderecoDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TClientesEnderecoDao.Destroy;
begin
  inherited;
end;

function TClientesEnderecoDao.excluir(pClientesEnderecoModel: TClientesEnderecoModel): String;
var
  lQry : TFDQuery;
  lConfiguracoes : ITerasoftConfiguracoes;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from CLIENTES_ENDERECO where ID = :ID' ,[pClientesEnderecoModel.ID]);
   lQry.ExecSQL;

   Supports(vIConexao.getTerasoftConfiguracoes, ITerasoftConfiguracoes, lConfiguracoes);

   if lConfiguracoes.objeto.valorTag('ENVIA_SINCRONIZA', 'N', tvBool) = 'S' then
     sincronizarDados(pClientesEnderecoModel);

   Result := pClientesEnderecoModel.ID;

  finally
    lQry.Free;
  end;
end;
function TClientesEnderecoDao.incluir(pClientesEnderecoModel: TClientesEnderecoModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
  lConfiguracoes : ITerasoftConfiguracoes;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('CLIENTES_ENDERECO', 'ID', true);

  try
    Supports(vIConexao.getTerasoftConfiguracoes, ITerasoftConfiguracoes, lConfiguracoes);

    lQry.SQL.Add(lSQL);
    pClientesEnderecoModel.ID := vIConexao.Generetor('GEN_CLIENTES_ENDERECO');
    setParams(lQry, pClientesEnderecoModel);
    lQry.Open;

    if lConfiguracoes.objeto.valorTag('ENVIA_SINCRONIZA', 'N', tvBool) = 'S' then
      sincronizarDados(pClientesEnderecoModel);

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TClientesEnderecoDao.ObterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := ' select '+lPaginacao+'                                           '+SLineBreak+
              '  CLIENTES_ENDERECO.ID,                                          '+SLineBreak+
              '  CLIENTES_ENDERECO.CLIENTE_ID,                                  '+SLineBreak+
              '  CLIENTES_ENDERECO.ENDERECO,                                    '+SLineBreak+
              '  CLIENTES_ENDERECO.NUMERO,                                      '+SLineBreak+
              '  CLIENTES_ENDERECO.COMPLEMENTO,                                 '+SLineBreak+
              '  CLIENTES_ENDERECO.BAIRRO,                                      '+SLineBreak+
              '  CLIENTES_ENDERECO.CIDADE,                                      '+SLineBreak+
              '  CLIENTES_ENDERECO.UF,                                          '+SLineBreak+
              '  CLIENTES_ENDERECO.CEP,                                         '+SLineBreak+
              '  CLIENTES_ENDERECO.COD_MUNICIPIO,                               '+SLineBreak+
              '  CLIENTES_ENDERECO.OBS,                                         '+SLineBreak+
              '  CLIENTES_ENDERECO.TIPO                                         '+SLineBreak+
              '  from CLIENTES_ENDERECO                                         '+SLineBreak+
              ' where 1=1                                                       '+SLineBreak;

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TClientesEnderecoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From CLIENTES_ENDERECO where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TClientesEnderecoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TClientesEnderecoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TClientesEnderecoDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TClientesEnderecoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TClientesEnderecoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TClientesEnderecoDao.setParams(var pQry: TFDQuery; pClientesEnderecoModel: TClientesEnderecoModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('CLIENTES_ENDERECO');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TClientesEnderecoModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pClientesEnderecoModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pClientesEnderecoModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TClientesEnderecoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TClientesEnderecoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TClientesEnderecoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

function TClientesEnderecoDao.sincronizarDados(pClientesEnderecoModel: TClientesEnderecoModel): String;
var
  lLojasModel,
  lLojas      : ITLojasModel;
  lQry        : TFDQuery;
  lSQL        : String;
begin

  lLojasModel := TLojasModel.getNewIface(vIConexao);

  try
    lLojasModel.objeto.obterHosts;

    if pClientesEnderecoModel.Acao in [tacIncluir, tacAlterar] then
      lSQL := vConstrutor.gerarUpdateOrInsert('CLIENTES_ENDERECO','ID', 'ID', true)

    else if pClientesEnderecoModel.Acao in [tacExcluir] then
      lSQL := ('delete from CLIENTES_ENDERECO where ID = :ID');

    for lLojas in lLojasModel.objeto.LojassLista do
    begin

      if lLojas.objeto.LOJA <> vIConexao.getEmpresa.LOJA then
      begin

        vIConexao.ConfigConexaoExterna('', lLojas.objeto.STRING_CONEXAO);
        lQry := vIConexao.criarQueryExterna;

        if pClientesEnderecoModel.Acao = tacExcluir then
        begin
          lQry.ExecSQL(lSQL, [pClientesEnderecoModel.ID]);
          lQry.ExecSQL;
        end
        else
        begin
          lQry.SQL.Clear;
          lQry.SQL.Add(lSQL);
          setParams(lQry, pClientesEnderecoModel);
          lQry.Open(lSQL);
        end;

      end;
    end;

  finally
    lLojasModel := nil;
    lQry.Free;
  end;
end;

function TClientesEnderecoDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> ''  then
    lSQL := lSQL + ' and ID = ' + QuotedStr(FIDRecordView);

  Result := lSQL;
end;

end.
