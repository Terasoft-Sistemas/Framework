unit FornecedorDao;

interface

uses
  FornecedorModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.ConstrutorDao;

type
  TFornecedorDao = class

  private
    vIConexao 	: IConexao;
    vConstrutor : TConstrutorDao;

    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FCNPJCPFRecordView: Variant;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);


    procedure SetCNPJCPFRecordView(const Value: Variant);

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
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property CNPJCPFRecordView : Variant read FCNPJCPFRecordView write SetCNPJCPFRecordView;
    function incluir(pFornecedorModel: TFornecedorModel): String;
    function alterar(pFornecedorModel: TFornecedorModel): String;
    function excluir(pFornecedorModel: TFornecedorModel): String;
    function where: String;
    function carregaClasse(pID : String): TFornecedorModel;
    function obterLista: TFDMemTable;

    procedure setParams(var pQry: TFDQuery; pFornecedorModel: TFornecedorModel);

end;

implementation

uses
  System.Rtti;

{ TFornecedor }

function TFornecedorDao.carregaClasse(pID : String): TFornecedorModel;
var
  lQry: TFDQuery;
  lModel: TFornecedorModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TFornecedorModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from FORNECEDOR where CODIGO_FOR = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.CODIGO_FOR                   := lQry.FieldByName('CODIGO_FOR').AsString;
    lModel.ENDERECO_FOR                 := lQry.FieldByName('ENDERECO_FOR').AsString;
    lModel.BAIRRO_FOR                   := lQry.FieldByName('BAIRRO_FOR').AsString;
    lModel.CIDADE_FOR                   := lQry.FieldByName('CIDADE_FOR').AsString;
    lModel.UF_FOR                       := lQry.FieldByName('UF_FOR').AsString;
    lModel.TELEFONE_FOR                 := lQry.FieldByName('TELEFONE_FOR').AsString;
    lModel.TELEFONE2_FOR                := lQry.FieldByName('TELEFONE2_FOR').AsString;
    lModel.FAX_FOR                      := lQry.FieldByName('FAX_FOR').AsString;
    lModel.CONTATO_FOR                  := lQry.FieldByName('CONTATO_FOR').AsString;
    lModel.CELULARCONTATO_FOR           := lQry.FieldByName('CELULARCONTATO_FOR').AsString;
    lModel.EMAIL_FOR                    := lQry.FieldByName('EMAIL_FOR').AsString;
    lModel.URL_FOR                      := lQry.FieldByName('URL_FOR').AsString;
    lModel.CEP_FOR                      := lQry.FieldByName('CEP_FOR').AsString;
    lModel.CNPJ_CPF_FOR                 := lQry.FieldByName('CNPJ_CPF_FOR').AsString;
    lModel.INSCRICAO_RG_FOR             := lQry.FieldByName('INSCRICAO_RG_FOR').AsString;
    lModel.FANTASIA_FOR                 := lQry.FieldByName('FANTASIA_FOR').AsString;
    lModel.RAZAO_FOR                    := lQry.FieldByName('RAZAO_FOR').AsString;
    lModel.BANCO_FOR                    := lQry.FieldByName('BANCO_FOR').AsString;
    lModel.AGENCIA_FOR                  := lQry.FieldByName('AGENCIA_FOR').AsString;
    lModel.CONTA_FOR                    := lQry.FieldByName('CONTA_FOR').AsString;
    lModel.OBSERVACAO_FOR               := lQry.FieldByName('OBSERVACAO_FOR').AsString;
    lModel.LIMITE_CREDITO_FOR           := lQry.FieldByName('LIMITE_CREDITO_FOR').AsString;
    lModel.TIPO_FOR                     := lQry.FieldByName('TIPO_FOR').AsString;
    lModel.USUARIO_ENT                  := lQry.FieldByName('USUARIO_ENT').AsString;
    lModel.LOJA                         := lQry.FieldByName('LOJA').AsString;
    lModel.DESCRICAO                    := lQry.FieldByName('DESCRICAO').AsString;
    lModel.FAVORECIDO                   := lQry.FieldByName('FAVORECIDO').AsString;
    lModel.COD_MUNICIPIO                := lQry.FieldByName('COD_MUNICIPIO').AsString;
    lModel.TELEFONE_EXTERIOR            := lQry.FieldByName('TELEFONE_EXTERIOR').AsString;
    lModel.PAIS                         := lQry.FieldByName('PAIS').AsString;
    lModel.BANCO_EXTERIOR               := lQry.FieldByName('BANCO_EXTERIOR').AsString;
    lModel.SWIFT_CODE                   := lQry.FieldByName('SWIFT_CODE').AsString;
    lModel.CONTA_EXTERIOR               := lQry.FieldByName('CONTA_EXTERIOR').AsString;
    lModel.FAVORECIDO_EXTERIOR          := lQry.FieldByName('FAVORECIDO_EXTERIOR').AsString;
    lModel.MODALIDADECONTA              := lQry.FieldByName('MODALIDADECONTA').AsString;
    lModel.OPERACAOBANCO                := lQry.FieldByName('OPERACAOBANCO').AsString;
    lModel.CELULARCONTATO_FOR2          := lQry.FieldByName('CELULARCONTATO_FOR2').AsString;
    lModel.ID                           := lQry.FieldByName('ID').AsString;
    lModel.SUFRAMA                      := lQry.FieldByName('SUFRAMA').AsString;
    lModel.NUMERO_END                   := lQry.FieldByName('NUMERO_END').AsString;
    lModel.COMPLEMENTO                  := lQry.FieldByName('COMPLEMENTO').AsString;
    lModel.CONDICOES_PAG                := lQry.FieldByName('CONDICOES_PAG').AsString;
    lModel.STATUS                       := lQry.FieldByName('STATUS').AsString;
    lModel.TRANSPORTADORA_ID            := lQry.FieldByName('TRANSPORTADORA_ID').AsString;
    lModel.TIPO_MOVIMENTO               := lQry.FieldByName('TIPO_MOVIMENTO').AsString;
    lModel.TIPO_APURACAO                := lQry.FieldByName('TIPO_APURACAO').AsString;
    lModel.CREDITO_IMPOSTO              := lQry.FieldByName('CREDITO_IMPOSTO').AsString;
    lModel.COMPRA_PRAZO                 := lQry.FieldByName('COMPRA_PRAZO').AsString;
    lModel.COMPRA_MINIMO                := lQry.FieldByName('COMPRA_MINIMO').AsString;
    lModel.CONTA_ID                     := lQry.FieldByName('CONTA_ID').AsString;
    lModel.CODIGO_CONTABIL              := lQry.FieldByName('CODIGO_CONTABIL').AsString;
    lModel.NASCIMENTO_FOR               := lQry.FieldByName('NASCIMENTO_FOR').AsString;
    lModel.PERIODICIDADE                := lQry.FieldByName('PERIODICIDADE').AsString;
    lModel.PREVISAO_ENTREGA             := lQry.FieldByName('PREVISAO_ENTREGA').AsString;
    lModel.MATRIZ_FORNECEDOR_ID         := lQry.FieldByName('MATRIZ_FORNECEDOR_ID').AsString;
    lModel.VINCULAR_PRODUTOS_ENTRADA    := lQry.FieldByName('VINCULAR_PRODUTOS_ENTRADA').AsString;
    lModel.CODIGO_ANTERIOR              := lQry.FieldByName('CODIGO_ANTERIOR').AsString;
    lModel.SYSTIME                      := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TFornecedorDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TFornecedorDao.Destroy;
begin
  inherited;
end;

function TFornecedorDao.incluir(pFornecedorModel: TFornecedorModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('FORNECEDOR', 'CODIGO_FOR');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pFornecedorModel);
    lQry.Open;

    Result := lQry.FieldByName('CODIGO_FOR').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TFornecedorDao.alterar(pFornecedorModel: TFornecedorModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('FORNECEDOR','CODIGO_FOR');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pFornecedorModel);
    lQry.ExecSQL;

    Result := pFornecedorModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TFornecedorDao.excluir(pFornecedorModel: TFornecedorModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from FORNECEDOR where CODIGO_FOR = :CODIGO_FOR' ,[pFornecedorModel.CODIGO_FOR]);
   lQry.ExecSQL;
   Result := pFornecedorModel.ID;

  finally
    lQry.Free;
  end;
end;

function TFornecedorDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and CODIGO_FOR = ' +IntToStr(FIDRecordView);

  if FCNPJCPFRecordView <> ''  then
    lSQL := lSQL + ' and CNPJ_CPF_FOR = ' +QuotedStr(FCNPJCPFRecordView);

  Result := lSQL;
end;

procedure TFornecedorDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From FORNECEDOR where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TFornecedorDao.obterLista: TFDMemTable;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := 'select * From FORNECEDOR where 1=1 ';


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

procedure TFornecedorDao.SetCNPJCPFRecordView(const Value: Variant);
begin
  FCNPJCPFRecordView := Value;
end;

procedure TFornecedorDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TFornecedorDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TFornecedorDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TFornecedorDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TFornecedorDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TFornecedorDao.setParams(var pQry: TFDQuery; pFornecedorModel: TFornecedorModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('FORNECEDOR');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TFornecedorModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pFornecedorModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pFornecedorModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TFornecedorDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TFornecedorDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TFornecedorDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
