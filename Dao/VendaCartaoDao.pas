unit VendaCartaoDao;

interface

uses
  VendaCartaoModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao,
  Terasoft.ConstrutorDao,
  Terasoft.Utils;

type
  TVendaCartaoDao = class;
  ITVendaCartaoDao=IObject<TVendaCartaoDao>;

  TVendaCartaoDao = class
  private
    [weak] mySelf: ITVendaCartaoDao;
    vIConexao   : IConexao;
    vConstrutor : IConstrutorDao;

    FVendaCartaosLista: IList<ITVendaCartaoModel>;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetVendaCartaosLista(const Value: IList<ITVendaCartaoModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function montaCondicaoQuery: String;

    procedure setParams(var pQry: TFDQuery; pVendaCartaoModel: ITVendaCartaoModel);

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITVendaCartaoDao;

    property VendaCartaosLista: IList<ITVendaCartaoModel> read FVendaCartaosLista write SetVendaCartaosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(AVendaCartaoModel: ITVendaCartaoModel): String;
    function alterar(AVendaCartaoModel: ITVendaCartaoModel): String;
    function excluir(AVendaCartaoModel: ITVendaCartaoModel): String;

    function carregaClasse(pID : String) : ITVendaCartaoModel;

    procedure obterLista;

end;

implementation

uses
  System.Rtti;

{ TVendaCartao }

function TVendaCartaoDao.carregaClasse(pID: String): ITVendaCartaoModel;
var
  lQry: TFDQuery;
  lModel: ITVendaCartaoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TVendaCartaoModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from VENDACARTAO where ID = '+pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID                   := lQry.FieldByName('ID').AsString;
    lModel.objeto.NUMERO_CAR           := lQry.FieldByName('NUMERO_CAR').AsString;
    lModel.objeto.AUTORIZACAO_CAR      := lQry.FieldByName('AUTORIZACAO_CAR').AsString;
    lModel.objeto.PARCELA_CAR          := lQry.FieldByName('PARCELA_CAR').AsString;
    lModel.objeto.PARCELAS_CAR         := lQry.FieldByName('PARCELAS_CAR').AsString;
    lModel.objeto.VALOR_CAR            := lQry.FieldByName('VALOR_CAR').AsString;
    lModel.objeto.CODIGO_CLI           := lQry.FieldByName('CODIGO_CLI').AsString;
    lModel.objeto.ADM_CAR              := lQry.FieldByName('ADM_CAR').AsString;
    lModel.objeto.VENDA_CAR            := lQry.FieldByName('VENDA_CAR').AsString;
    lModel.objeto.PARCELADO_CAR        := lQry.FieldByName('PARCELADO_CAR').AsString;
    lModel.objeto.VENCIMENTO_CAR       := lQry.FieldByName('VENCIMENTO_CAR').AsString;
    lModel.objeto.NUMERO_VENDA         := lQry.FieldByName('NUMERO_VENDA').AsString;
    lModel.objeto.LOJA                 := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.NUMERO_OS            := lQry.FieldByName('NUMERO_OS').AsString;
    lModel.objeto.FATURA_ID            := lQry.FieldByName('FATURA_ID').AsString;
    lModel.objeto.CANCELAMENTO_DATA    := lQry.FieldByName('CANCELAMENTO_DATA').AsString;
    lModel.objeto.CANCELAMENTO_CODIGO  := lQry.FieldByName('CANCELAMENTO_CODIGO').AsString;
    lModel.objeto.SYSTIME              := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.TAXA                 := lQry.FieldByName('TAXA').AsString;
    lModel.objeto.PARCELA_TEF          := lQry.FieldByName('PARCELA_TEF').AsString;
    lModel.objeto.PARCELAS_TEF         := lQry.FieldByName('PARCELAS_TEF').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TVendaCartaoDao._Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TVendaCartaoDao.Destroy;
begin
  FVendaCartaosLista:=nil;
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

function TVendaCartaoDao.incluir(AVendaCartaoModel: ITVendaCartaoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('VENDACARTAO', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    AVendaCartaoModel.objeto.id := vIConexao.Generetor('GEN_VENDACARTAO');
    setParams(lQry, AVendaCartaoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TVendaCartaoDao.alterar(AVendaCartaoModel: ITVendaCartaoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('VENDACARTAO', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AVendaCartaoModel);
    lQry.ExecSQL;

    Result := AVendaCartaoModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TVendaCartaoDao.excluir(AVendaCartaoModel: ITVendaCartaoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from vendacartao where ID = :ID',[AVendaCartaoModel.objeto.ID]);
   lQry.ExecSQL;
   Result := AVendaCartaoModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TVendaCartaoDao.getNewIface(pIConexao: IConexao): ITVendaCartaoDao;
begin
  Result := TImplObjetoOwner<TVendaCartaoDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TVendaCartaoDao.montaCondicaoQuery: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and vendacartao.id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TVendaCartaoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From vendacartao where 1=1 ';

    lSql := lSql + montaCondicaoQuery;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TVendaCartaoDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: ITVendaCartaoModel;
begin
  lQry := vIConexao.CriarQuery;

  FVendaCartaosLista := TCollections.CreateList<ITVendaCartaoModel>;

  try

    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       vendacartao.*            '+
	    '  from vendacartao              '+
      ' where 1=1                      ';

    lSql := lSql + montaCondicaoQuery;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TVendaCartaoModel.getNewIface(vIConexao);
      FVendaCartaosLista.Add(modelo);

      modelo.objeto.ID                  := lQry.FieldByName('ID').AsString;
      modelo.objeto.NUMERO_CAR          := lQry.FieldByName('NUMERO_CAR').AsString;
      modelo.objeto.AUTORIZACAO_CAR     := lQry.FieldByName('AUTORIZACAO_CAR').AsString;
      modelo.objeto.PARCELA_CAR         := lQry.FieldByName('PARCELA_CAR').AsString;
      modelo.objeto.PARCELAS_CAR        := lQry.FieldByName('PARCELAS_CAR').AsString;
      modelo.objeto.VALOR_CAR           := lQry.FieldByName('VALOR_CAR').AsString;
      modelo.objeto.CODIGO_CLI          := lQry.FieldByName('CODIGO_CLI').AsString;
      modelo.objeto.ADM_CAR             := lQry.FieldByName('ADM_CAR').AsString;
      modelo.objeto.VENDA_CAR           := lQry.FieldByName('VENDA_CAR').AsString;
      modelo.objeto.PARCELADO_CAR       := lQry.FieldByName('PARCELADO_CAR').AsString;
      modelo.objeto.VENCIMENTO_CAR      := lQry.FieldByName('VENCIMENTO_CAR').AsString;
      modelo.objeto.NUMERO_VENDA        := lQry.FieldByName('NUMERO_VENDA').AsString;
      modelo.objeto.LOJA                := lQry.FieldByName('LOJA').AsString;
      modelo.objeto.NUMERO_OS           := lQry.FieldByName('NUMERO_OS').AsString;
      modelo.objeto.FATURA_ID           := lQry.FieldByName('FATURA_ID').AsString;
      modelo.objeto.CANCELAMENTO_DATA   := lQry.FieldByName('CANCELAMENTO_DATA').AsString;
      modelo.objeto.CANCELAMENTO_CODIGO := lQry.FieldByName('CANCELAMENTO_CODIGO').AsString;
      modelo.objeto.SYSTIME             := lQry.FieldByName('SYSTIME').AsString;
      modelo.objeto.TAXA                := lQry.FieldByName('TAXA').AsString;
      modelo.objeto.PARCELA_TEF         := lQry.FieldByName('PARCELA_TEF').AsString;
      modelo.objeto.PARCELAS_TEF        := lQry.FieldByName('PARCELAS_TEF').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TVendaCartaoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TVendaCartaoDao.SetVendaCartaosLista;
begin
  FVendaCartaosLista := Value;
end;

procedure TVendaCartaoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TVendaCartaoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TVendaCartaoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TVendaCartaoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TVendaCartaoDao.setParams(var pQry: TFDQuery; pVendaCartaoModel: ITVendaCartaoModel);
begin
  vConstrutor.setParams('VENDACARTAO',pQry,pVendaCartaoModel.objeto);
end;

procedure TVendaCartaoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TVendaCartaoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TVendaCartaoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
