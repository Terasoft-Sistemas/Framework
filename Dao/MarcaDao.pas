unit MarcaDao;

interface

uses

  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  Terasoft.Types,
  Terasoft.Framework.ListaSimples.Impl,
  Terasoft.Framework.ListaSimples,
  Terasoft.Framework.SimpleTypes,
  Interfaces.Conexao,
  Terasoft.Framework.ObjectIface,
  Terasoft.FuncoesTexto,
  System.Generics.Collections,
  Terasoft.ConstrutorDao,
  MarcaModel;

type
  TMarcaDao = class

  private
    vIConexao : IConexao;

    vConstrutor : TConstrutorDao;

    FLengthPageView: String;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FIDRecordView: String;
    procedure obterTotalRegistros;
    procedure SetCountView(const Value: String);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: String);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    function where: String;

    var
      vConstrutorDao : TConstrutorDao;

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

    function incluir(pMarcaModel: TMarcaModel): String;
    function alterar(pMarcaModel: TMarcaModel): String;
    function excluir(pMarcaModel: TMarcaModel): String;
    function carregaClasse(pID : String): TMarcaModel;

    procedure setParams(var pQry: TFDQuery; pMarcaModel: TMarcaModel);
    function ObterLista(pMarca_Parametros: TMarca_Parametros): IFDDataset; overload;
    function ObterLista: IFDDataset; overload;

end;

implementation

uses
  Data.DB, System.Rtti;

{ TPCG }

function TMarcaDao.carregaClasse(pID: String): TMarcaModel;
var
  lQry: TFDQuery;
  lModel: TMarcaModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TMarcaModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from MARCAPRODUTO where CODIGO_MAR = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.CODIGO_MAR       := lQry.FieldByName('CODIGO_MAR').AsString;
    lModel.NOME_MAR         := lQry.FieldByName('NOME_MAR').AsString;
    lModel.USUARIO_MAR      := lQry.FieldByName('USUARIO_MAR').AsString;
    lModel.ID               := lQry.FieldByName('ID').AsString;
    lModel.SIGLA            := lQry.FieldByName('SIGLA').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TMarcaDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TMarcaDao.Destroy;
begin
  inherited;
end;

function TMarcaDao.ObterLista(pMarca_Parametros: TMarca_Parametros): IFDDataset;
var
  lQry: TFDQuery;
  lSQL:String;
  lMemTable: IFDDataset;
begin
  try

    lMemTable := TImplObjetoOwner<TDataset>.CreateOwner(TFDMemTable.Create(nil));

    lSQL := ' Select CODIGO_MAR,         ' + #13 +
            '        NOME_MAR            ' + #13 +
            '   From MARCAPRODUTO        ' + #13 +
            '  Order by NOME_MAR         ' + #13;

    with TFDMemTable(lMemTable.objeto).IndexDefs.AddIndexDef do
    begin
      Name := 'OrdenacaoRazao';
      Fields := 'RAZAO';
      Options := [TIndexOption.ixCaseInsensitive];
    end;

    TFDMemTable(lMemTable.objeto).IndexName := 'OrdenacaoRazao';

    TFDMemTable(lMemTable.objeto).FieldDefs.Add('CODIGO', ftString, 6);
    TFDMemTable(lMemTable.objeto).FieldDefs.Add('RAZAO', ftString, 40);
    TFDMemTable(lMemTable.objeto).CreateDataSet;

    lQry := vIConexao.CriarQuery;
    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      lMemTable.objeto.InsertRecord([
                              lQry.FieldByName('CODIGO_MAR').AsString,
                              lQry.FieldByName('NOME_MAR').AsString
                             ]);

      lQry.Next;
    end;

    lMemTable.objeto.Open;

    Result := lMemTable;

  finally
    lQry.Free;
  end;
end;

function TMarcaDao.incluir(pMarcaModel: TMarcaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('MARCAPRODUTO', 'CODIGO_MAR');

  try
    lQry.SQL.Add(lSQL);
    pMarcaModel.CODIGO_MAR := vIConexao.Generetor('GEN_MARCAPRODUTO');
    setParams(lQry, pMarcaModel);
    lQry.Open;

    Result := lQry.FieldByName('CODIGO_MAR').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TMarcaDao.ObterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry       := vIConexao.CriarQuery;
  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + ' ';

    lSQL := 'select '+lPaginacao+' * from MARCAPRODUTO where 1=1 ';

    lSQL := lSQL + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    Result := vConstrutorDao.atribuirRegistros(lQry);
    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

function TMarcaDao.alterar(pMarcaModel: TMarcaModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('MARCAPRODUTO','CODIGO_MAR');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pMarcaModel);
    lQry.ExecSQL;

    Result := pMarcaModel.CODIGO_MAR;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TMarcaDao.excluir(pMarcaModel: TMarcaModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from MARCAPRODUTO where ID = :ID' ,[pMarcaModel.CODIGO_MAR]);
   lQry.ExecSQL;
   Result := pMarcaModel.CODIGO_MAR;

  finally
    lQry.Free;
  end;
end;

function TMarcaDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> ''  then
    lSQL := lSQL + ' and CODIGO_MAR = '+QuotedStr(FIDRecordView);

  Result := lSQL;
end;

procedure TMarcaDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From MARCAPRODUTO where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;


procedure TMarcaDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TMarcaDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TMarcaDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TMarcaDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TMarcaDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TMarcaDao.setParams(var pQry: TFDQuery; pMarcaModel: TMarcaModel);
var
  lTabela : IFDDataset;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('MARCAPRODUTO');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TMarcaModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pMarcaModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pMarcaModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TMarcaDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TMarcaDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TMarcaDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
