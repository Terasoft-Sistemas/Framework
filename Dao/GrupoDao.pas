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
  GrupoModel;

type
  TGrupoDao = class

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

    function incluir(pGrupoModel: TGrupoModel): String;
    function alterar(pGrupoModel: TGrupoModel): String;
    function excluir(pGrupoModel: TGrupoModel): String;

    function carregaClasse(pID : String): TGrupoModel;

    function ObterLista(pGrupo_Parametros: TGrupo_Parametros): TFDMemTable; overload;
    function ObterLista: TFDMemTable; overload;

    procedure setParams(var pQry: TFDQuery; pGrupoModel: TGrupoModel);

end;

implementation

uses
  System.Rtti, Data.DB;

{ TGrupo }

function TGrupoDao.alterar(pGrupoModel: TGrupoModel): String;
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

    Result := pGrupoModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TGrupoDao.carregaClasse(pID: String): TGrupoModel;
var
  lQry: TFDQuery;
  lModel: TGrupoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TGrupoModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from GRUPOPRODUTO where CODIGO_GRU = ' +pId);

    if lQry.IsEmpty then
      Exit;

      lModel.CODIGO_GRU             := lQry.FieldByName('CODIGO_GRU').AsString;
      lModel.NOME_GRU               := lQry.FieldByName('NOME_GRU').AsString;
      lModel.USUARIO_GRU            := lQry.FieldByName('USUARIO_GRU').AsString;
      lModel.LOJA                   := lQry.FieldByName('LOJA').AsString;
      lModel.ECF                    := lQry.FieldByName('ECF').AsString;
      lModel.ICMS                   := lQry.FieldByName('ICMS').AsString;
      lModel.REDUTOR_ICMS_ST        := lQry.FieldByName('REDUTOR_ICMS_ST').AsString;
      lModel.ID                     := lQry.FieldByName('ID').AsString;
      lModel.ARREDONDAMENTO         := lQry.FieldByName('ARREDONDAMENTO').AsString;
      lModel.DESTAQUE_PRE_VENDA     := lQry.FieldByName('DESTAQUE_PRE_VENDA').AsString;
      lModel.IMAGEM                 := lQry.FieldByName('IMAGEM').AsString;
      lModel.SIGLA                  := lQry.FieldByName('SIGLA').AsString;
      lModel.REFERENCIA             := lQry.FieldByName('REFERENCIA').AsString;
      lModel.COR                    := lQry.FieldByName('COR').AsString;
      lModel.ORDEM                  := lQry.FieldByName('ORDEM').AsString;
      lModel.MARGEM_IMPOSTO         := lQry.FieldByName('MARGEM_IMPOSTO').AsString;
      lModel.MARGERM_PRODUTO        := lQry.FieldByName('MARGERM_PRODUTO').AsString;
      lModel.ID_ECOMMERCE           := lQry.FieldByName('ID_ECOMMERCE').AsString;
      lModel.DESCRICAO_ECOMMERCE    := lQry.FieldByName('DESCRICAO_ECOMMERCE').AsString;
      lModel.STATUS                 := lQry.FieldByName('STATUS').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;
constructor TGrupoDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TGrupoDao.Destroy;
begin
  inherited;
end;

function TGrupoDao.excluir(pGrupoModel: TGrupoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from GRUPOPRODUTO where CODIGO_GRU = :CODIGO_GRU' ,[pGrupoModel.CODIGO_GRU]);
   lQry.ExecSQL;
   Result := pGrupoModel.CODIGO_GRU;

  finally
    lQry.Free;
  end;
end;
function TGrupoDao.incluir(pGrupoModel: TGrupoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('GRUPOPRODUTO', 'CODIGO_GRU');

  try
    lQry.SQL.Add(lSQL);
    pGrupoModel.CODIGO_GRU := vIConexao.Generetor('GEN_GRUPOPRODUTO');
    setParams(lQry, pGrupoModel);
    lQry.Open;

    Result := lQry.FieldByName('CODIGO_GRU').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TGrupoDao.ObterLista: TFDMemTable;
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

function TGrupoDao.ObterLista(pGrupo_Parametros: TGrupo_Parametros): TFDMemTable;
var
  lQry: TFDQuery;
  lSQL:String;
  lMemTable: TFDMemTable;
begin
  try
    lMemTable := TFDMemTable.Create(nil);

    lSQL := 'Select CODIGO_GRU,       ' + #13 +
            '       NOME_GRU         ' + #13 +
            'From GRUPOPRODUTO        ' + #13 +
            'Order by NOME_GRU       ' + #13;

    with lMemTable.IndexDefs.AddIndexDef do
    begin
      Name := 'OrdenacaoRazao';
      Fields := 'RAZAO';
      Options := [TIndexOption.ixCaseInsensitive];
    end;

    lMemTable.IndexName := 'OrdenacaoRazao';

    lMemTable.FieldDefs.Add('CODIGO', ftString, 6);
    lMemTable.FieldDefs.Add('RAZAO', ftString, 40);
    lMemTable.CreateDataSet;
                                                  
    lQry := vIConexao.CriarQuery;
    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      lMemTable.InsertRecord([
                              lQry.FieldByName('CODIGO_GRU').AsString,
                              lQry.FieldByName('NOME_GRU').AsString
                             ]);

      lQry.Next;
    end;

    lMemTable.Open;

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

procedure TGrupoDao.setParams(var pQry: TFDQuery; pGrupoModel: TGrupoModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('ANEXO');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TGrupoModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pGrupoModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pGrupoModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
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
