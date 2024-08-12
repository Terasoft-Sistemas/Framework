unit CreditoClienteDao;

interface

uses
  CreditoClienteModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Terasoft.Framework.ObjectIface,
  Terasoft.ConstrutorDao,
  Terasoft.Utils,
  Interfaces.Conexao;

type
  TCreditoClienteDao = class;
  ITCreditoClienteDao=IObject<TCreditoClienteDao>;
  TCreditoClienteDao = class
  private
    [weak] mySelf: ITCreditoClienteDao;
    vIConexao   : IConexao;
    vConstrutor : IConstrutorDao;

    FCreditoClientesLista: IList<ITCreditoClienteModel>;
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
    procedure SetCreditoClientesLista(const Value: IList<ITCreditoClienteModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITCreditoClienteDao;

    property CreditoClientesLista: IList<ITCreditoClienteModel> read FCreditoClientesLista write SetCreditoClientesLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(ACreditoClienteModel: ITCreditoClienteModel): String;
    function alterar(ACreditoClienteModel: ITCreditoClienteModel): String;
    function excluir(ACreditoClienteModel: ITCreditoClienteModel): String;
    function carregaClasse(pID : String) : ITCreditoClienteModel;
    function where: String;

    procedure obterLista;
    procedure creditosAbertos(pCliente : String);
    procedure setParams(var pQry: TFDQuery; pCreditoClienteModel: ITCreditoClienteModel);

end;

implementation

uses
  System.Rtti;

{ TCreditoCliente }

function TCreditoClienteDao.carregaClasse(pID: String): ITCreditoClienteModel;
var
  lQry: TFDQuery;
  lModel: ITCreditoClienteModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TCreditoClienteModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from CREDITO_CLIENTE where ID = ' + ID);

    if lQry.IsEmpty then
      Exit;

      lModel.objeto.ID                   := lQry.FieldByName('ID').AsString;
      lModel.objeto.CLIENTE_ID           := lQry.FieldByName('CLIENTE_ID').AsString;
      lModel.objeto.DEVOLUCAO_ID         := lQry.FieldByName('DEVOLUCAO_ID').AsString;
      lModel.objeto.DATA                 := lQry.FieldByName('DATA').AsString;
      lModel.objeto.VALOR                := lQry.FieldByName('VALOR').AsString;
      lModel.objeto.TIPO                 := lQry.FieldByName('TIPO').AsString;
      lModel.objeto.OBS                  := lQry.FieldByName('OBS').AsString;
      lModel.objeto.ENTRADA_ID           := lQry.FieldByName('ENTRADA_ID').AsString;
      lModel.objeto.FORNECEDOR_ID        := lQry.FieldByName('FORNECEDOR_ID').AsString;
      lModel.objeto.FATURA_ID            := lQry.FieldByName('FATURA_ID').AsString;
      lModel.objeto.SYSTIME              := lQry.FieldByName('SYSTIME').AsString;
      lModel.objeto.PEDIDO_SITE          := lQry.FieldByName('PEDIDO_SITE').AsString;
      lModel.objeto.CONTACORRENTE_ID     := lQry.FieldByName('CONTACORRENTE_ID').AsString;
      lModel.objeto.CLIENTE_ANTERIOR_ID  := lQry.FieldByName('CLIENTE_ANTERIOR_ID').AsString;
      lModel.objeto.VENDA_CASADA         := lQry.FieldByName('VENDA_CASADA').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TCreditoClienteDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

procedure TCreditoClienteDao.creditosAbertos(pCliente: String);
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: ITCreditoClienteModel;
begin

  lQry := vIConexao.CriarQuery;

  FCreditoClientesLista := TCollections.CreateList<ITCreditoClienteModel>;

  try
    lSQL := '  select c.*,                                                                                '+
            '         c.valor - coalesce((select sum(u.valor)                                             '+
            '                               from credito_cliente_uso u                                    '+
            '                              where u.credito_cliente_id = c.id), 0) valor_aberto            '+
            '    from credito_cliente c                                                                   '+
            '   where c.cliente_id = ' + QuotedStr(pCliente)                                               +
            '     and c.tipo = ''C''                                                                      '+
            '     and c.valor - coalesce((select sum(u.valor)                                             '+
            '                              from credito_cliente_uso u                                     '+
            '                             where u.credito_cliente_id = c.id), 0) > 0                      ';

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TCreditoClienteModel.getNewIface(vIConexao);
      FCreditoClientesLista.Add(modelo);

      modelo.objeto.ID                  := lQry.FieldByName('ID').AsString;
      modelo.objeto.CLIENTE_ID          := lQry.FieldByName('CLIENTE_ID').AsString;
      modelo.objeto.DEVOLUCAO_ID        := lQry.FieldByName('DEVOLUCAO_ID').AsString;
      modelo.objeto.DATA                := lQry.FieldByName('DATA').AsString;
      modelo.objeto.VALOR               := lQry.FieldByName('VALOR').AsString;
      modelo.objeto.TIPO                := lQry.FieldByName('TIPO').AsString;
      modelo.objeto.OBS                 := lQry.FieldByName('OBS').AsString;
      modelo.objeto.ENTRADA_ID          := lQry.FieldByName('ENTRADA_ID').AsString;
      modelo.objeto.FORNECEDOR_ID       := lQry.FieldByName('FORNECEDOR_ID').AsString;
      modelo.objeto.FATURA_ID           := lQry.FieldByName('FATURA_ID').AsString;
      modelo.objeto.SYSTIME             := lQry.FieldByName('SYSTIME').AsString;
      modelo.objeto.PEDIDO_SITE         := lQry.FieldByName('PEDIDO_SITE').AsString;
      modelo.objeto.CONTACORRENTE_ID    := lQry.FieldByName('CONTACORRENTE_ID').AsString;
      modelo.objeto.CLIENTE_ANTERIOR_ID := lQry.FieldByName('CLIENTE_ANTERIOR_ID').AsString;
      modelo.objeto.VENDA_CASADA        := lQry.FieldByName('VENDA_CASADA').AsString;
      modelo.objeto.VALOR_ABERTO        := lQry.FieldByName('VALOR_ABERTO').AsString;

      lQry.Next;
    end;

  finally
    lQry.Free;
  end;
end;

destructor TCreditoClienteDao.Destroy;
begin
  FCreditoClientesLista := nil;
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

function TCreditoClienteDao.incluir(ACreditoClienteModel: ITCreditoClienteModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin

  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('CREDITO_CLIENTE','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, ACreditoClienteModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;

  end;
end;

function TCreditoClienteDao.alterar(ACreditoClienteModel: ITCreditoClienteModel): String;
var
  lQry: TFDQuery;
  lSQL:String;

begin

  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('CREDITO_CLIENTE','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, ACreditoClienteModel);
    lQry.ExecSQL;

    Result := ACreditoClienteModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TCreditoClienteDao.excluir(ACreditoClienteModel: ITCreditoClienteModel): String;
var
  lQry: TFDQuery;
begin

  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from CREDITO_CLIENTE where ID = :ID',[ACreditoClienteModel.objeto.ID]);
   lQry.ExecSQL;
   Result := ACreditoClienteModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TCreditoClienteDao.getNewIface(pIConexao: IConexao): ITCreditoClienteDao;
begin
  Result := TImplObjetoOwner<TCreditoClienteDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TCreditoClienteDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TCreditoClienteDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try

    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From CREDITO_CLIENTE where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TCreditoClienteDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo : ITCreditoClienteModel;
begin
  lQry := vIConexao.CriarQuery;

  FCreditoClientesLista := TCollections.CreateList<ITCreditoClienteModel>;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       credito_cliente.*        '+
	    '  from credito_cliente          '+
      ' where 1=1                      ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TCreditoClienteModel.getNewIface(vIConexao);
      FCreditoClientesLista.Add(modelo);

      modelo.objeto.ID                  := lQry.FieldByName('ID').AsString;
      modelo.objeto.CLIENTE_ID          := lQry.FieldByName('CLIENTE_ID').AsString;
      modelo.objeto.DEVOLUCAO_ID        := lQry.FieldByName('DEVOLUCAO_ID').AsString;
      modelo.objeto.DATA                := lQry.FieldByName('DATA').AsString;
      modelo.objeto.VALOR               := lQry.FieldByName('VALOR').AsString;
      modelo.objeto.TIPO                := lQry.FieldByName('TIPO').AsString;
      modelo.objeto.OBS                 := lQry.FieldByName('OBS').AsString;
      modelo.objeto.ENTRADA_ID          := lQry.FieldByName('ENTRADA_ID').AsString;
      modelo.objeto.FORNECEDOR_ID       := lQry.FieldByName('FORNECEDOR_ID').AsString;
      modelo.objeto.FATURA_ID           := lQry.FieldByName('FATURA_ID').AsString;
      modelo.objeto.SYSTIME             := lQry.FieldByName('SYSTIME').AsString;
      modelo.objeto.PEDIDO_SITE         := lQry.FieldByName('PEDIDO_SITE').AsString;
      modelo.objeto.CONTACORRENTE_ID    := lQry.FieldByName('CONTACORRENTE_ID').AsString;
      modelo.objeto.CLIENTE_ANTERIOR_ID := lQry.FieldByName('CLIENTE_ANTERIOR_ID').AsString;
      modelo.objeto.VENDA_CASADA        := lQry.FieldByName('VENDA_CASADA').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TCreditoClienteDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TCreditoClienteDao.SetCreditoClientesLista;
begin
  FCreditoClientesLista := Value;
end;

procedure TCreditoClienteDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TCreditoClienteDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TCreditoClienteDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TCreditoClienteDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TCreditoClienteDao.setParams(var pQry: TFDQuery; pCreditoClienteModel: ITCreditoClienteModel);
begin
  vConstrutor.setParams('CREDITO_CLIENTE',pQry,pCreditoClienteModel.objeto);
end;

procedure TCreditoClienteDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TCreditoClienteDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TCreditoClienteDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
