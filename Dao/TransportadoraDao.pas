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
  Terasoft.Framework.ObjectIface,
  TransportadoraModel;

type
  TTransportadoraDao = class;
  ITTransportadoraDao=IObject<TTransportadoraDao>;

  TTransportadoraDao = class
  private
    [unsafe] mySelf: ITTransportadoraDao;
    vIConexao : IConexao;
    vConstrutor : IConstrutorDao;

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
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITTransportadoraDao;

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

    function incluir(pTransportadoraModel: ITTransportadoraModel): String;
    function alterar(pTransportadoraModel: ITTransportadoraModel): String;
    function excluir(pTransportadoraModel: ITTransportadoraModel): String;

    function carregaClasse(pCodigo : String): ITTransportadoraModel;

    function obterLista: IFDDataset;

    procedure setParams(var pQry: TFDQuery; pTransportadoraModel: ITTransportadoraModel);

end;

implementation

uses
  System.Rtti, Data.DB;

{ TTransportadora }

function TTransportadoraDao.alterar(pTransportadoraModel: ITTransportadoraModel): String;
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

    Result := pTransportadoraModel.objeto.CODIGO_TRA;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TTransportadoraDao.carregaClasse(pCodigo: String): ITTransportadoraModel;
var
  lQry: TFDQuery;
  lModel: ITTransportadoraModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TTransportadoraModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from TRANSPORTADORA where CODIGO_TRA = ' +pCodigo);

    if lQry.IsEmpty then
      Exit;

      lModel.objeto.CODIGO_TRA         := lQry.FieldByName('CODIGO_TRA').AsString;
      lModel.objeto.ENDERECO_TRA       := lQry.FieldByName('ENDERECO_TRA').AsString;
      lModel.objeto.BAIRRO_TRA         := lQry.FieldByName('BAIRRO_TRA').AsString;
      lModel.objeto.CIDADE_TRA         := lQry.FieldByName('CIDADE_TRA').AsString;
      lModel.objeto.UF_TRA             := lQry.FieldByName('UF_TRA').AsString;
      lModel.objeto.TELEFONE_TRA       := lQry.FieldByName('TELEFONE_TRA').AsString;
      lModel.objeto.TELEFONE2_TRA      := lQry.FieldByName('TELEFONE2_TRA').AsString;
      lModel.objeto.FAX_TRA            := lQry.FieldByName('FAX_TRA').AsString;
      lModel.objeto.CONTATO_TRA        := lQry.FieldByName('CONTATO_TRA').AsString;
      lModel.objeto.CELULARCONTATO_TRA := lQry.FieldByName('CELULARCONTATO_TRA').AsString;
      lModel.objeto.EMAIL_TRA          := lQry.FieldByName('EMAIL_TRA').AsString;
      lModel.objeto.URL_TRA            := lQry.FieldByName('URL_TRA').AsString;
      lModel.objeto.CEP_TRA            := lQry.FieldByName('CEP_TRA').AsString;
      lModel.objeto.CNPJ_CPF_TRA       := lQry.FieldByName('CNPJ_CPF_TRA').AsString;
      lModel.objeto.INSCRICAO_RG_TRA   := lQry.FieldByName('INSCRICAO_RG_TRA').AsString;
      lModel.objeto.FANTASIA_TRA       := lQry.FieldByName('FANTASIA_TRA').AsString;
      lModel.objeto.RAZAO_TRA          := lQry.FieldByName('RAZAO_TRA').AsString;
      lModel.objeto.OBSERVACAO_TRA     := lQry.FieldByName('OBSERVACAO_TRA').AsString;
      lModel.objeto.USUARIO_ENT        := lQry.FieldByName('USUARIO_ENT').AsString;
      lModel.objeto.ID                 := lQry.FieldByName('ID').AsString;
      lModel.objeto.SUFRAMA            := lQry.FieldByName('SUFRAMA').AsString;
      lModel.objeto.NUMERO_END         := lQry.FieldByName('NUMERO_END').AsString;
      lModel.objeto.COMPLEMENTO        := lQry.FieldByName('COMPLEMENTO').AsString;
      lModel.objeto.PLACA              := lQry.FieldByName('PLACA').AsString;
      lModel.objeto.RNTC               := lQry.FieldByName('RNTC').AsString;
      lModel.objeto.RASTREIO           := lQry.FieldByName('RASTREIO').AsString;
      lModel.objeto.CODIGO_ANTERIOR    := lQry.FieldByName('CODIGO_ANTERIOR').AsString;
      lModel.objeto.SYSTIME            := lQry.FieldByName('SYSTIME').AsString;
      lModel.objeto.STATUS             := lQry.FieldByName('STATUS').AsString;
      lModel.objeto.NOME_ECOMMERCE     := lQry.FieldByName('NOME_ECOMMERCE').AsString;
      lModel.objeto.FRENET_COD         := lQry.FieldByName('FRENET_COD').AsString;
      lModel.objeto.TIPO_FRETE         := lQry.FieldByName('TIPO_FRETE').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;
constructor TTransportadoraDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TTransportadoraDao.Destroy;
begin
  inherited;
end;

function TTransportadoraDao.excluir(pTransportadoraModel: ITTransportadoraModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from TRANSPORTADORA where CODIGO_TRA = :CODIGO_TRA' ,[pTransportadoraModel.objeto.ID]);
   lQry.ExecSQL;
   Result := pTransportadoraModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TTransportadoraDao.getNewIface(pIConexao: IConexao): ITTransportadoraDao;
begin
  Result := TImplObjetoOwner<TTransportadoraDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TTransportadoraDao.incluir(pTransportadoraModel: ITTransportadoraModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('TRANSPORTADORA', 'CODIGO_TRA', true);

  try
    lQry.SQL.Add(lSQL);
    pTransportadoraModel.objeto.CODIGO_TRA := vIConexao.Generetor('GEN_TRANSPORTADORA');
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

procedure TTransportadoraDao.setParams(var pQry: TFDQuery; pTransportadoraModel: ITTransportadoraModel);
begin
  vConstrutor.setParams('TRANSPORTADORA',pQry,pTransportadoraModel.objeto);
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
