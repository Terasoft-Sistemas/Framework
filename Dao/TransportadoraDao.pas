unit TransportadoraDao;

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
  TransportadoraModel;

type
  TTransportadoraDao = class

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
    FIDUsuarioView: String;
    FIDTipoVendaView: String;
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
    procedure SetIDTipoVendaView(const Value: String);
    procedure SetIDUsuarioView(const Value: String);

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
    property IDUsuarioView : String read FIDUsuarioView write SetIDUsuarioView;
    property IDTipoVendaView : String read FIDTipoVendaView write SetIDTipoVendaView;

    function incluir(pTransportadoraModel: TTransportadoraModel): String;
    function alterar(pTransportadoraModel: TTransportadoraModel): String;
    function excluir(pTransportadoraModel: TTransportadoraModel): String;

    function carregaClasse(pCodigo : String): TTransportadoraModel;

    function obterLista: IFDDataset;

    procedure setParams(var pQry: TFDQuery; pTransportadoraModel: TTransportadoraModel);

end;

implementation

uses
  System.Rtti, Data.DB;

{ TTransportadora }

function TTransportadoraDao.alterar(pTransportadoraModel: TTransportadoraModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('TRANSPORTADORA','CODIGO_TRA');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pTransportadoraModel);
    lQry.ExecSQL;

    Result := pTransportadoraModel.CODIGO_TRA;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TTransportadoraDao.carregaClasse(pCodigo: String): TTransportadoraModel;
var
  lQry: TFDQuery;
  lModel: TTransportadoraModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TTransportadoraModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from TRANSPORTADORA where CODIGO_TRA = ' +pCodigo);

    if lQry.IsEmpty then
      Exit;

      lModel.CODIGO_TRA         := lQry.FieldByName('CODIGO_TRA').AsString;
      lModel.ENDERECO_TRA       := lQry.FieldByName('ENDERECO_TRA').AsString;
      lModel.BAIRRO_TRA         := lQry.FieldByName('BAIRRO_TRA').AsString;
      lModel.CIDADE_TRA         := lQry.FieldByName('CIDADE_TRA').AsString;
      lModel.UF_TRA             := lQry.FieldByName('UF_TRA').AsString;
      lModel.TELEFONE_TRA       := lQry.FieldByName('TELEFONE_TRA').AsString;
      lModel.TELEFONE2_TRA      := lQry.FieldByName('TELEFONE2_TRA').AsString;
      lModel.FAX_TRA            := lQry.FieldByName('FAX_TRA').AsString;
      lModel.CONTATO_TRA        := lQry.FieldByName('CONTATO_TRA').AsString;
      lModel.CELULARCONTATO_TRA := lQry.FieldByName('CELULARCONTATO_TRA').AsString;
      lModel.EMAIL_TRA          := lQry.FieldByName('EMAIL_TRA').AsString;
      lModel.URL_TRA            := lQry.FieldByName('URL_TRA').AsString;
      lModel.CEP_TRA            := lQry.FieldByName('CEP_TRA').AsString;
      lModel.CNPJ_CPF_TRA       := lQry.FieldByName('CNPJ_CPF_TRA').AsString;
      lModel.INSCRICAO_RG_TRA   := lQry.FieldByName('INSCRICAO_RG_TRA').AsString;
      lModel.FANTASIA_TRA       := lQry.FieldByName('FANTASIA_TRA').AsString;
      lModel.RAZAO_TRA          := lQry.FieldByName('RAZAO_TRA').AsString;
      lModel.OBSERVACAO_TRA     := lQry.FieldByName('OBSERVACAO_TRA').AsString;
      lModel.USUARIO_ENT        := lQry.FieldByName('USUARIO_ENT').AsString;
      lModel.ID                 := lQry.FieldByName('ID').AsString;
      lModel.SUFRAMA            := lQry.FieldByName('SUFRAMA').AsString;
      lModel.NUMERO_END         := lQry.FieldByName('NUMERO_END').AsString;
      lModel.COMPLEMENTO        := lQry.FieldByName('COMPLEMENTO').AsString;
      lModel.PLACA              := lQry.FieldByName('PLACA').AsString;
      lModel.RNTC               := lQry.FieldByName('RNTC').AsString;
      lModel.RASTREIO           := lQry.FieldByName('RASTREIO').AsString;
      lModel.CODIGO_ANTERIOR    := lQry.FieldByName('CODIGO_ANTERIOR').AsString;
      lModel.SYSTIME            := lQry.FieldByName('SYSTIME').AsString;
      lModel.STATUS             := lQry.FieldByName('STATUS').AsString;
      lModel.NOME_ECOMMERCE     := lQry.FieldByName('NOME_ECOMMERCE').AsString;
      lModel.FRENET_COD         := lQry.FieldByName('FRENET_COD').AsString;
      lModel.TIPO_FRETE         := lQry.FieldByName('TIPO_FRETE').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;
constructor TTransportadoraDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TTransportadoraDao.Destroy;
begin
  inherited;
end;

function TTransportadoraDao.excluir(pTransportadoraModel: TTransportadoraModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from TRANSPORTADORA where CODIGO_TRA = :CODIGO_TRA' ,[pTransportadoraModel.ID]);
   lQry.ExecSQL;
   Result := pTransportadoraModel.ID;

  finally
    lQry.Free;
  end;
end;
function TTransportadoraDao.incluir(pTransportadoraModel: TTransportadoraModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('TRANSPORTADORA', 'CODIGO_TRA', true);

  try
    lQry.SQL.Add(lSQL);
    pTransportadoraModel.CODIGO_TRA := vIConexao.Generetor('GEN_TRANSPORTADORA');
    setParams(lQry, pTransportadoraModel);
    lQry.Open;

    Result := lQry.FieldByName('CODIGO_TRA').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TTransportadoraDao.ObterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := ' select '+lPaginacao+'                                                          '+SLineBreak+
              '         CODIGO_TRA,                                                            '+SlineBreak+
              '         ENDERECO_TRA,                                                          '+SlineBreak+
              '         BAIRRO_TRA,                                                            '+SlineBreak+
              '         CIDADE_TRA,                                                            '+SlineBreak+
              '         UF_TRA,                                                                '+SlineBreak+
              '         TELEFONE_TRA,                                                          '+SlineBreak+
              '         TELEFONE2_TRA,                                                         '+SlineBreak+
              '         CONTATO_TRA,                                                           '+SlineBreak+
              '         CELULARCONTATO_TRA,                                                    '+SlineBreak+
              '         EMAIL_TRA,                                                             '+SlineBreak+
              '         URL_TRA,                                                               '+SlineBreak+
              '         CEP_TRA,                                                               '+SlineBreak+
              '         CNPJ_CPF_TRA,                                                          '+SlineBreak+
              '         INSCRICAO_RG_TRA,                                                      '+SlineBreak+
              '         FANTASIA_TRA,                                                          '+SlineBreak+
              '         RAZAO_TRA,                                                             '+SlineBreak+
              '         OBSERVACAO_TRA,                                                        '+SlineBreak+
              '         USUARIO_ENT,                                                           '+SlineBreak+
              '         ID,                                                                    '+SlineBreak+
              '         NUMERO_END,                                                            '+SlineBreak+
              '         COMPLEMENTO,                                                           '+SlineBreak+
              '         SYSTIME,                                                               '+SlineBreak+
              '         STATUS                                                                 '+SlineBreak+
              '    from TRANSPORTADORA                                                         '+SLineBreak+
              '   where 1=1                                                                    '+SLineBreak;

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

procedure TTransportadoraDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From TRANSPORTADORA where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TTransportadoraDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TTransportadoraDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TTransportadoraDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TTransportadoraDao.SetIDTipoVendaView(const Value: String);
begin
  FIDTipoVendaView := Value;
end;

procedure TTransportadoraDao.SetIDUsuarioView(const Value: String);
begin
  FIDUsuarioView := Value;
end;

procedure TTransportadoraDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TTransportadoraDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TTransportadoraDao.setParams(var pQry: TFDQuery; pTransportadoraModel: TTransportadoraModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('TRANSPORTADORA');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TTransportadoraModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pTransportadoraModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pTransportadoraModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TTransportadoraDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TTransportadoraDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TTransportadoraDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

function TTransportadoraDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> ''  then
    lSQL := lSQL + ' and CODIGO_TRA = ' + QuotedStr(FIDRecordView);

  Result := lSQL;
end;

end.
