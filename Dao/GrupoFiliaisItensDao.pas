unit GrupoFiliaisItensDao;

interface

uses
  GrupoFiliaisItensModel,
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
  TGrupoFiliaisItensDao = class;
  ITGrupoFiliaisItensDao=IObject<TGrupoFiliaisItensDao>;

  TGrupoFiliaisItensDao = class
  private
    [weak] mySelf: ITGrupoFiliaisItensDao;
    vIConexao 	: IConexao;
    vConstrutor : IConstrutorDao;

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

    class function getNewIface(pIConexao: IConexao): ITGrupoFiliaisItensDao;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pGrupoFiliaisItensModel: ITGrupoFiliaisItensModel): String;
    function alterar(pGrupoFiliaisItensModel: ITGrupoFiliaisItensModel): String;
    function excluir(pGrupoFiliaisItensModel: ITGrupoFiliaisItensModel): String;

    function carregaClasse(pID : String): ITGrupoFiliaisItensModel;
    function obterLista: IFDDataset;

    procedure setParams(var pQry: TFDQuery; pGrupoFiliaisItensModel: ITGrupoFiliaisItensModel);

end;

implementation

uses
  System.Rtti;

{ TGrupoFiliaisItens }

function TGrupoFiliaisItensDao.carregaClasse(pID : String): ITGrupoFiliaisItensModel;
var
  lQry: TFDQuery;
  lModel: ITGrupoFiliaisItensModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TGrupoFiliaisItensModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from GRUPO_FILIAIS_ITENS where ID = ' +pID);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID                := lQry.FieldByName('ID').AsString;
	  lModel.objeto.GRUPO_FILIAIS_ID  := lQry.FieldByName('GRUPO_FILIAIS_ID').AsString;
    lModel.objeto.LOJA              := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.DATA_CADASTRO     := lQry.FieldByName('DATA_CADASTRO').AsString;
    lModel.objeto.SYSTIME           := lQry.FieldByName('SYSTIME').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TGrupoFiliaisItensDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TGrupoFiliaisItensDao.Destroy;
begin
  inherited;
end;

function TGrupoFiliaisItensDao.incluir(pGrupoFiliaisItensModel: ITGrupoFiliaisItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('GRUPO_FILIAIS_ITENS', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pGrupoFiliaisItensModel);
    lQry.Open;
    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TGrupoFiliaisItensDao.alterar(pGrupoFiliaisItensModel: ITGrupoFiliaisItensModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('GRUPO_FILIAIS_ITENS','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pGrupoFiliaisItensModel);
    lQry.ExecSQL;

    Result := pGrupoFiliaisItensModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TGrupoFiliaisItensDao.excluir(pGrupoFiliaisItensModel: ITGrupoFiliaisItensModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from GRUPO_FILIAIS_ITENS where ID = :ID' ,[pGrupoFiliaisItensModel.objeto.ID]);
   lQry.ExecSQL;
   Result := pGrupoFiliaisItensModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TGrupoFiliaisItensDao.getNewIface(pIConexao: IConexao): ITGrupoFiliaisItensDao;
begin
  Result := TImplObjetoOwner<TGrupoFiliaisItensDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TGrupoFiliaisItensDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and g.id = '+IntToStr(FIDRecordView);

  Result := lSQL;
end;

procedure TGrupoFiliaisItensDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records from GRUPO_FILIAIS_ITENS G where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TGrupoFiliaisItensDao.obterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

    lSQL := ' select '+lPaginacao+'                                            '+SLineBreak+
            '        g.id,                                                     '+SLineBreak+
            '        g.descricao,                                              '+SLineBreak+
            '        g.status,                                                 '+SLineBreak+
            '        gi.id id_item,                                            '+SLineBreak+
            '        gi.loja,                                                  '+SLineBreak+
            '        gi.grupo_filiais_id,                                      '+SLineBreak+
            '        gi.data_cadastro,                                         '+SLineBreak+
            '        l.descricao as nome_loja                                  '+SLineBreak+
            '   from grupo_filiais_itens gi                                    '+SLineBreak+
            '   left join grupo_filiais g on gi.grupo_filiais_id = g.id        '+SLineBreak+
            '   left join loja2 l on l.loja = gi.loja                          '+SLineBreak+
            '  where 1=1                                                       '+SLineBreak;

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by g.id desc '+FOrderView;

    lQry.Open(lSQL);

    Result := vConstrutor.atribuirRegistros(lQry);

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TGrupoFiliaisItensDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TGrupoFiliaisItensDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TGrupoFiliaisItensDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TGrupoFiliaisItensDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TGrupoFiliaisItensDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TGrupoFiliaisItensDao.setParams(var pQry: TFDQuery; pGrupoFiliaisItensModel: ITGrupoFiliaisItensModel);
begin
  vConstrutor.setParams('GRUPO_FILIAIS_ITENS',pQry,pGrupoFiliaisItensModel.objeto);
end;

procedure TGrupoFiliaisItensDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TGrupoFiliaisItensDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TGrupoFiliaisItensDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
