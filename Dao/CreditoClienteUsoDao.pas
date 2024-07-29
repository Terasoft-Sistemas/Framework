unit CreditoClienteUsoDao;

interface

uses
  CreditoClienteUsoModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  Spring.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Terasoft.ConstrutorDao,
  Terasoft.Utils,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TCreditoClienteUsoDao = class;
  ITCreditoClienteUsoDao=IObject<TCreditoClienteUsoDao>;

  TCreditoClienteUsoDao = class
  private
    [weak] mySelf: ITCreditoClienteUsoDao;
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FCreditoClienteUsosLista: IList<ITCreditoClienteUsoModel>;
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
    procedure SetCreditoClienteUsosLista(const Value: IList<ITCreditoClienteUsoModel>);
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

    class function getNewIface(pIConexao: IConexao): ITCreditoClienteUsoDao;

    property CreditoClienteUsosLista: IList<ITCreditoClienteUsoModel> read FCreditoClienteUsosLista write SetCreditoClienteUsosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function where: String;
    function incluir(ACreditoClienteUsoModel: ITCreditoClienteUsoModel): String;
    function alterar(ACreditoClienteUsoModel: ITCreditoClienteUsoModel): String;
    function excluir(ACreditoClienteUsoModel: ITCreditoClienteUsoModel): String;
	  function carregaClasse(pID : String) : ITCreditoClienteUsoModel;
    procedure obterLista;
    procedure setParams(var pQry: TFDQuery; pCreditoClienteUsoModel: ITCreditoClienteUsoModel);

end;

implementation

uses
  System.Rtti;

{ TCreditoClienteUso }

function TCreditoClienteUsoDao.carregaClasse(pID: String): ITCreditoClienteUsoModel;
var
  lQry: TFDQuery;
  lModel: ITCreditoClienteUsoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TCreditoClienteUsoModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from CREDITO_CLIENTE_USO where ID = ' + ID);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID                 := lQry.FieldByName('ID').AsString;
    lModel.objeto.CREDITO_CLIENTE_ID := lQry.FieldByName('CREDITO_CLIENTE_ID').AsString;
    lModel.objeto.DATA               := lQry.FieldByName('DATA').AsString;
    lModel.objeto.VALOR              := lQry.FieldByName('VALOR').AsString;
    lModel.objeto.PARCELA            := lQry.FieldByName('PARCELA').AsString;
    lModel.objeto.RECEBER_ID         := lQry.FieldByName('RECEBER_ID').AsString;
    lModel.objeto.LOCAL              := lQry.FieldByName('LOCAL').AsString;
    lModel.objeto.USUARIO_ID         := lQry.FieldByName('USUARIO_ID').AsString;
    lModel.objeto.DATAHORA           := lQry.FieldByName('DATAHORA').AsString;
    lModel.objeto.SYSTIME            := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TCreditoClienteUsoDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TCreditoClienteUsoDao.Destroy;
begin
  FCreditoClienteUsosLista:=nil;
  FreeAndNil(vConstrutor);
  vIConexao := nil;
  inherited;
end;

function TCreditoClienteUsoDao.incluir(ACreditoClienteUsoModel: ITCreditoClienteUsoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin

  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('CREDITO_CLIENTE_USO','ID', True);

  try
    lQry.SQL.Add(lSQL);
    ACreditoClienteUsoModel.objeto.ID := vIConexao.Generetor('GEN_CREDITO_CLIENTE_USO', true);
    setParams(lQry, ACreditoClienteUsoModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TCreditoClienteUsoDao.alterar(ACreditoClienteUsoModel: ITCreditoClienteUsoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('CREDITO_CLIENTE_USO','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, ACreditoClienteUsoModel);
    lQry.ExecSQL;

    Result := ACreditoClienteUsoModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TCreditoClienteUsoDao.excluir(ACreditoClienteUsoModel: ITCreditoClienteUsoModel): String;
var
  lQry: TFDQuery;
begin

  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from CREDITO_CLIENTE_USO where ID = :ID',[ACreditoClienteUsoModel.objeto.ID]);
   lQry.ExecSQL;
   Result := ACreditoClienteUsoModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TCreditoClienteUsoDao.getNewIface(pIConexao: IConexao): ITCreditoClienteUsoDao;
begin
  Result := TImplObjetoOwner<TCreditoClienteUsoDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TCreditoClienteUsoDao.where: String;
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

procedure TCreditoClienteUsoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try

    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From CREDITO_CLIENTE_USO where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TCreditoClienteUsoDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: ITCreditoClienteUsoModel;
begin

  lQry := vIConexao.CriarQuery;

  FCreditoClienteUsosLista := TCollections.CreateList<ITCreditoClienteUsoModel>;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       credito_cliente_uso.*    '+
	    '  from credito_cliente_uso      '+
      ' where 1=1                      ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TCreditoClienteUsoModel.getNewIface(vIConexao);
      FCreditoClienteUsosLista.Add(modelo);

      modelo.objeto.ID                  := lQry.FieldByName('ID').AsString;
      modelo.objeto.CREDITO_CLIENTE_ID  := lQry.FieldByName('CREDITO_CLIENTE_ID').AsString;
      modelo.objeto.DATA                := lQry.FieldByName('DATA').AsString;
      modelo.objeto.VALOR               := lQry.FieldByName('VALOR').AsString;
      modelo.objeto.PARCELA             := lQry.FieldByName('PARCELA').AsString;
      modelo.objeto.RECEBER_ID          := lQry.FieldByName('RECEBER_ID').AsString;
      modelo.objeto.LOCAL               := lQry.FieldByName('LOCAL').AsString;
      modelo.objeto.USUARIO_ID          := lQry.FieldByName('USUARIO_ID').AsString;
      modelo.objeto.DATAHORA            := lQry.FieldByName('DATAHORA').AsString;
      modelo.objeto.SYSTIME             := lQry.FieldByName('SYSTIME').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TCreditoClienteUsoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TCreditoClienteUsoDao.SetCreditoClienteUsosLista;
begin
  FCreditoClienteUsosLista := Value;
end;

procedure TCreditoClienteUsoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TCreditoClienteUsoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TCreditoClienteUsoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TCreditoClienteUsoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TCreditoClienteUsoDao.setParams(var pQry: TFDQuery; pCreditoClienteUsoModel: ITCreditoClienteUsoModel);
begin
  vConstrutor.setParams('CREDITO_CLIENTE_USO',pQry,pCreditoClienteUsoModel.objeto);
end;

procedure TCreditoClienteUsoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TCreditoClienteUsoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TCreditoClienteUsoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
