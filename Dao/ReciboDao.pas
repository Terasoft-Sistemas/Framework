unit ReciboDao;

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
  ReciboModel;

type
  TReciboDao = class;
  ITReciboDao=IObject<TReciboDao>;

  TReciboDao = class
  private
    [unsafe] mySelf: ITReciboDao;
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
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITReciboDao;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView : String read FIDRecordView write SetIDRecordView;

    function incluir(pReciboModel: ITReciboModel): String;
    function alterar(pReciboModel: ITReciboModel): String;
    function excluir(pReciboModel: ITReciboModel): String;

    function carregaClasse(pID : String): ITReciboModel;

    function obterLista: IFDDataset;

    procedure setParams(var pQry: TFDQuery; pReciboModel: ITReciboModel);

end;

implementation

uses
  System.Rtti, Data.DB;

{ TRecibo }

function TReciboDao.alterar(pReciboModel: ITReciboModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('RECIBO','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pReciboModel);
    lQry.ExecSQL;

    Result := pReciboModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TReciboDao.carregaClasse(pID: String): ITReciboModel;
var
  lQry: TFDQuery;
  lModel: ITReciboModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TReciboModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from RECIBO where ID = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID             := lQry.FieldByName('ID').AsString;
    lModel.objeto.VALOR          := lQry.FieldByName('VALOR').AsString;
    lModel.objeto.CLIENTE_ID     := lQry.FieldByName('CLIENTE_ID').AsString;
    lModel.objeto.REFERENTE      := lQry.FieldByName('REFERENTE').AsString;
    lModel.objeto.DOCUMENTO_ID   := lQry.FieldByName('DOCUMENTO_ID').AsString;
    lModel.objeto.TIPO_DOCUMENTO := lQry.FieldByName('TIPO_DOCUMENTO').AsString;
    lModel.objeto.DATA           := lQry.FieldByName('DATA').AsString;
    lModel.objeto.MATRICIAL      := lQry.FieldByName('MATRICIAL').AsString;
    lModel.objeto.SYSTIME        := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;
constructor TReciboDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TReciboDao.Destroy;
begin
  inherited;
end;

function TReciboDao.excluir(pReciboModel: ITReciboModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from RECIBO where ID = :ID' ,[pReciboModel.objeto.ID]);
   lQry.ExecSQL;
   Result := pReciboModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TReciboDao.getNewIface(pIConexao: IConexao): ITReciboDao;
begin
  Result := TImplObjetoOwner<TReciboDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TReciboDao.incluir(pReciboModel: ITReciboModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('RECIBO', 'ID', true);

  try
    lQry.SQL.Add(lSQL);
    pReciboModel.objeto.ID := vIConexao.Generetor('GEN_RECIBO');
    setParams(lQry, pReciboModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TReciboDao.ObterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := ' select '+lPaginacao+'                                     '+SLineBreak+
              '         RECIBO.ID,                                        '+SLineBreak+
              '         RECIBO.VALOR,                                     '+SLineBreak+
              '         RECIBO.CLIENTE_ID,                                '+SLineBreak+
              '         RECIBO.REFERENTE,                                 '+SLineBreak+
              '         RECIBO.DOCUMENTO_ID,                              '+SLineBreak+
              '         RECIBO.TIPO_DOCUMENTO,                            '+SLineBreak+
              '         RECIBO.DATA,                                      '+SLineBreak+
              '         RECIBO.MATRICIAL,                                 '+SLineBreak+
              '         CLIENTES.FANTASIA_CLI,                            '+SLineBreak+
              '         CLIENTES.ENDERECO_CLI,                            '+SLineBreak+
              '         CLIENTES.CIDADE_CLI,                              '+SLineBreak+
              '         CLIENTES.UF_CLI                                   '+SLineBreak+
              '    from RECIBO                                            '+SLineBreak+
              '    left join CLIENTES                                     '+SLineBreak+
              '    on CLIENTES.CODIGO_CLI = RECIBO.CLIENTE_ID             '+SLineBreak+
              '   where 1=1                                               '+SLineBreak;

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

procedure TReciboDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From RECIBO            '+
            '    left join CLIENTES                         '+
            '    on CLIENTES.CODIGO_CLI = RECIBO.CLIENTE_ID '+
            'where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TReciboDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TReciboDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TReciboDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TReciboDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TReciboDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TReciboDao.setParams(var pQry: TFDQuery; pReciboModel: ITReciboModel);
begin
  vConstrutor.setParams('RECIBO',pQry,pReciboModel.objeto);
end;

procedure TReciboDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TReciboDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TReciboDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

function TReciboDao.where: String;
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
