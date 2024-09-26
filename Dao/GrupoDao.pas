unit GrupoDao;

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
  GrupoModel;

type
  TGrupoDao = class;
  ITGrupoDao=IObject<TGrupoDao>;

  TGrupoDao = class
  private
    [unsafe] mySelf: ITGrupoDao;
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

    class function getNewIface(pIConexao: IConexao): ITGrupoDao;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView : String read FIDRecordView write SetIDRecordView;

    function incluir(pGrupoModel: ITGrupoModel): String;
    function alterar(pGrupoModel: ITGrupoModel): String;
    function excluir(pGrupoModel: ITGrupoModel): String;

    function carregaClasse(pID : String): ITGrupoModel;

    function ObterLista(pGrupo_Parametros: TGrupo_Parametros): IFDDataset; overload;
    function ObterLista: IFDDataset; overload;

    procedure setParams(var pQry: TFDQuery; pGrupoModel: ITGrupoModel);

end;

implementation

uses
  System.Rtti, Data.DB;

{ TGrupo }

function TGrupoDao.alterar(pGrupoModel: ITGrupoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('GRUPOPRODUTO','CODIGO_GRU');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pGrupoModel);
    lQry.ExecSQL;

    Result := pGrupoModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TGrupoDao.carregaClasse(pID: String): ITGrupoModel;
var
  lQry: TFDQuery;
  lModel: ITGrupoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TGrupoModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from GRUPOPRODUTO where CODIGO_GRU = ' +pId);

    if lQry.IsEmpty then
      Exit;

      lModel.objeto.CODIGO_GRU             := lQry.FieldByName('CODIGO_GRU').AsString;
      lModel.objeto.NOME_GRU               := lQry.FieldByName('NOME_GRU').AsString;
      lModel.objeto.USUARIO_GRU            := lQry.FieldByName('USUARIO_GRU').AsString;
      lModel.objeto.LOJA                   := lQry.FieldByName('LOJA').AsString;
      lModel.objeto.ECF                    := lQry.FieldByName('ECF').AsString;
      lModel.objeto.ICMS                   := lQry.FieldByName('ICMS').AsString;
      lModel.objeto.REDUTOR_ICMS_ST        := lQry.FieldByName('REDUTOR_ICMS_ST').AsString;
      lModel.objeto.ID                     := lQry.FieldByName('ID').AsString;
      lModel.objeto.ARREDONDAMENTO         := lQry.FieldByName('ARREDONDAMENTO').AsString;
      lModel.objeto.DESTAQUE_PRE_VENDA     := lQry.FieldByName('DESTAQUE_PRE_VENDA').AsString;
      lModel.objeto.IMAGEM                 := lQry.FieldByName('IMAGEM').AsString;
      lModel.objeto.SIGLA                  := lQry.FieldByName('SIGLA').AsString;
      lModel.objeto.REFERENCIA             := lQry.FieldByName('REFERENCIA').AsString;
      lModel.objeto.COR                    := lQry.FieldByName('COR').AsString;
      lModel.objeto.ORDEM                  := lQry.FieldByName('ORDEM').AsString;
      lModel.objeto.MARGEM_IMPOSTO         := lQry.FieldByName('MARGEM_IMPOSTO').AsString;
      lModel.objeto.MARGERM_PRODUTO        := lQry.FieldByName('MARGERM_PRODUTO').AsString;
      lModel.objeto.ID_ECOMMERCE           := lQry.FieldByName('ID_ECOMMERCE').AsString;
      lModel.objeto.DESCRICAO_ECOMMERCE    := lQry.FieldByName('DESCRICAO_ECOMMERCE').AsString;
      lModel.objeto.STATUS                 := lQry.FieldByName('STATUS').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;
constructor TGrupoDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TGrupoDao.Destroy;
begin
  inherited;
end;

function TGrupoDao.excluir(pGrupoModel: ITGrupoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from GRUPOPRODUTO where CODIGO_GRU = :CODIGO_GRU' ,[pGrupoModel.objeto.CODIGO_GRU]);
   lQry.ExecSQL;
   Result := pGrupoModel.objeto.CODIGO_GRU;

  finally
    lQry.Free;
  end;
end;

class function TGrupoDao.getNewIface(pIConexao: IConexao): ITGrupoDao;
begin
  Result := TImplObjetoOwner<TGrupoDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TGrupoDao.incluir(pGrupoModel: ITGrupoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('GRUPOPRODUTO', 'CODIGO_GRU');

  try
    lQry.SQL.Add(lSQL);
    pGrupoModel.objeto.CODIGO_GRU := vIConexao.Generetor('GEN_GRUPOPRODUTO');
    setParams(lQry, pGrupoModel);
    lQry.Open;

    Result := lQry.FieldByName('CODIGO_GRU').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TGrupoDao.ObterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := ' select '+lPaginacao+'                                                         '+SLineBreak+
              '         grupoproduto.CODIGO_GRU,                                              '+SLineBreak+
              '         grupoproduto.NOME_GRU,                                                '+SLineBreak+
              '         grupoproduto.STATUS                                                   '+SLineBreak+
              '    from grupoproduto                                                          '+SLineBreak+
              '   where 1=1                                                                   '+SLineBreak;

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

function TGrupoDao.ObterLista(pGrupo_Parametros: TGrupo_Parametros): IFDDataset;
var
  lQry: TFDQuery;
  lSQL:String;
  lMemTable: IFDDataset;
begin
  try
    lMemTable := TImplObjetoOwner<TDataset>.CreateOwner(TFDMemTable.Create(nil));

    lSQL := 'Select CODIGO_GRU,       ' + #13 +
            '       NOME_GRU         ' + #13 +
            'From GRUPOPRODUTO        ' + #13 +
            'Order by NOME_GRU       ' + #13;

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
                                                  
    lQry := vIConexao.CriarQuery;
    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      lMemTable.objeto.InsertRecord([
                              lQry.FieldByName('CODIGO_GRU').AsString,
                              lQry.FieldByName('NOME_GRU').AsString
                             ]);

      lQry.Next;
    end;

    lMemTable.objeto.Open;

    Result := lMemTable;

  finally
    lQry.Free;
  end;
end;


procedure TGrupoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From GRUPOPRODUTO where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TGrupoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TGrupoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TGrupoDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TGrupoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TGrupoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TGrupoDao.setParams(var pQry: TFDQuery; pGrupoModel: ITGrupoModel);
begin
  vConstrutor.setParams('ANEXO',pQry,pGrupoModel.objeto);
end;

procedure TGrupoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TGrupoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TGrupoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

function TGrupoDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> ''  then
    lSQL := lSQL + ' and CODIGO_GRU = ' + QuotedStr(FIDRecordView);

  Result := lSQL;
end;

end.
