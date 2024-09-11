unit GrupoFiliaisDao;

interface

uses
  GrupoFiliaisModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Interfaces.Conexao,
  Terasoft.Utils,
  Terasoft.Framework.ObjectIface,
  Terasoft.ConstrutorDao;

type
  TGrupoFiliaisDao = class;
  ITGrupoFiliaisDao=IObject<TGrupoFiliaisDao>;

  TGrupoFiliaisDao = class
  private
    [weak] mySelf : ITGrupoFiliaisDao;
    vIConexao 	  : IConexao;
    vConstrutor   : IConstrutorDao;

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
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;

  public

    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITGrupoFiliaisDao;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pGrupoFiliaisModel: ITGrupoFiliaisModel): String;
    function alterar(pGrupoFiliaisModel: ITGrupoFiliaisModel): String;
    function excluir(pGrupoFiliaisModel: ITGrupoFiliaisModel): String;

    function carregaClasse(pID : String): ITGrupoFiliaisModel;
    function obterLista: IFDDataset;
    function obterListaComFiliais: IFDDataset;

    procedure setParams(var pQry: TFDQuery; pGrupoFiliaisModel: ITGrupoFiliaisModel);

end;

implementation

uses
  System.Rtti, Data.DB;

{ TGrupoFiliais }

function TGrupoFiliaisDao.carregaClasse(pID : String): ITGrupoFiliaisModel;
var
  lQry: TFDQuery;
  lModel: ITGrupoFiliaisModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TGrupoFiliaisModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from GRUPO_FILIAIS where ID = ' +pID);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID               := lQry.FieldByName('ID').AsString;
    lModel.objeto.DESCRICAO        := lQry.FieldByName('DESCRICAO').AsString;
    lModel.objeto.DATA_CADASTRO    := lQry.FieldByName('DATA_CADASTRO').AsString;
    lModel.objeto.SYSTIME          := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TGrupoFiliaisDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TGrupoFiliaisDao.Destroy;
begin
  inherited;
end;

function TGrupoFiliaisDao.incluir(pGrupoFiliaisModel: ITGrupoFiliaisModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('GRUPO_FILIAIS', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pGrupoFiliaisModel);
    lQry.Open;
    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TGrupoFiliaisDao.alterar(pGrupoFiliaisModel: ITGrupoFiliaisModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('GRUPO_FILIAIS','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pGrupoFiliaisModel);
    lQry.ExecSQL;

    Result := pGrupoFiliaisModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TGrupoFiliaisDao.excluir(pGrupoFiliaisModel: ITGrupoFiliaisModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from GRUPO_FILIAIS where ID = :ID' ,[pGrupoFiliaisModel.objeto.ID]);
   lQry.ExecSQL;
   Result := pGrupoFiliaisModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TGrupoFiliaisDao.getNewIface(pIConexao: IConexao): ITGrupoFiliaisDao;
begin
  Result := TImplObjetoOwner<TGrupoFiliaisDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TGrupoFiliaisDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and ID = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TGrupoFiliaisDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records from GRUPO_FILIAIS where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TGrupoFiliaisDao.obterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

    lSQL := 'select '+lPaginacao+'          '+sLineBreak+
            '       id,                     '+sLineBreak+
            '       data_cadastro,          '+sLineBreak+
            '       systime,                '+sLineBreak+
            '       descricao,              '+sLineBreak+
            '       status                  '+sLineBreak+
            '  from grupo_filiais           '+sLineBreak+
            ' where 1=1                     '+sLineBreak;

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

function TGrupoFiliaisDao.obterListaComFiliais: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
  lMemTable  : IFDDataset;
  lDescrAnt  : String;
  lLojas     : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSQL := 'Select gf.descricao, gfi.loja                                   ' +
            'From grupo_filiais_itens gfi                                    ' +
            '     left join grupo_filiais gf on gf.id = gfi.grupo_filiais_id ' +
            'Order by gf.descricao, gfi.loja                                 ';

    lQry.Open(lSQL);

    lMemTable := criaIFDDataset(TFDMemTable.Create(nil));

    with TFDMemTable(lMemTable.objeto).IndexDefs.AddIndexDef do
    begin
      Name := 'OrdenacaoDescricao';
      Fields := 'descricao';
      Options := [TIndexOption.ixCaseInsensitive];
    end;

    TFDMemTable(lMemTable.objeto).IndexName := 'OrdenacaoDescricao';

    TFDMemTable(lMemTable.objeto).FieldDefs.Add('DESCRICAO', ftString, 100);
    TFDMemTable(lMemTable.objeto).FieldDefs.Add('LOJAS',     ftString, 400);
    TFDMemTable(lMemTable.objeto).CreateDataSet;

    lLojas := '';

    lQry.first;
    lDescrAnt := lQry.FieldByName('descricao').AsString;
    while not lQry.Eof do
    begin
      if lDescrAnt <> lQry.FieldByName('descricao').AsString then
      begin
        lMemTable.objeto.InsertRecord([ lDescrAnt, lLojas ]);
        lLojas := '';
        lDescrAnt := lQry.FieldByName('descricao').AsString;
      end;

      if lLojas <> '' then
        lLojas := lLojas + ',';

      lLojas := lLojas + lQry.FieldByName('loja').AsString;

      lQry.Next;
    end;

    if lLojas <> '' then
    begin
      lMemTable.objeto.InsertRecord([ lDescrAnt, lLojas ]);
      lLojas := '';
    end;

    lMemTable.objeto.Open;

    Result := lMemTable;

  finally
    lQry.Free;

  end;
end;

procedure TGrupoFiliaisDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TGrupoFiliaisDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TGrupoFiliaisDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TGrupoFiliaisDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TGrupoFiliaisDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TGrupoFiliaisDao.setParams(var pQry: TFDQuery; pGrupoFiliaisModel: ITGrupoFiliaisModel);
begin
  vConstrutor.setParams('GRUPO_FILIAIS',pQry,pGrupoFiliaisModel.objeto);
end;

procedure TGrupoFiliaisDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TGrupoFiliaisDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TGrupoFiliaisDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
