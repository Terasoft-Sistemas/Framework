unit AnexoDao;

interface

uses
  AnexoModel,
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
  TAnexoDao = class;
  ITAnexoDao=IObject<TAnexoDao>;

  TAnexoDao = class
  private
    [weak] mySelf: ITAnexoDao;
    vIConexao 	: IConexao;
    vConstrutor : TConstrutorDao;

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

    class function getNewIface(pIConexao: IConexao): ITAnexoDao;

    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    function incluir(pAnexoModel: ITAnexoModel): String;
    function alterar(pAnexoModel: ITAnexoModel): String;
    function excluir(pAnexoModel: ITAnexoModel): String;

    function carregaClasse(pID : String): ITAnexoModel;

    function obterLista: IFDDataset;

    function sincronizarDados(pAnexoModel: ITAnexoModel): String;

    procedure setParams(var pQry: TFDQuery; pAnexoModel: ITAnexoModel);

end;

implementation

uses
  System.Rtti, Terasoft.Configuracoes, Terasoft.Types, LojasModel;

{ TAnexo }

function TAnexoDao.carregaClasse(pID : String): ITAnexoModel;
var
  lQry: TFDQuery;
  lModel: ITAnexoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TAnexoModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from ANEXO where ID = ' +pId);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID               := lQry.FieldByName('ID').AsString;
    lModel.objeto.TABELA           := lQry.FieldByName('TABELA').AsString;
    lModel.objeto.REGISTRO_ID      := lQry.FieldByName('REGISTRO_ID').AsString;
    lModel.objeto.DOCUMENTO_ID     := lQry.FieldByName('DOCUMENTO_ID').AsString;
    lModel.objeto.SYSTIME          := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.EXTENSAO         := lQry.FieldByName('EXTENSAO').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TAnexoDao._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
  vConstrutor := TConstrutorDAO.Create(vIConexao);
end;

destructor TAnexoDao.Destroy;
begin
  inherited;
end;

function TAnexoDao.incluir(pAnexoModel: ITAnexoModel): String;
var
  lQry   : TFDQuery;
  lSQL   : String;
  lConfiguracoes : ITerasoftConfiguracoes;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarInsert('ANEXO', 'ID', true);

  try
    Supports(vIConexao.getTerasoftConfiguracoes, ITerasoftConfiguracoes, lConfiguracoes);

    lQry.SQL.Add(lSQL);
    pAnexoModel.objeto.ID := vIConexao.Generetor('GEN_ANEXO');
    setParams(lQry, pAnexoModel);
    lQry.Open;

    if lConfiguracoes.objeto.valorTag('ENVIA_SINCRONIZA', 'N', tvBool) = 'S' then
      sincronizarDados(pAnexoModel);

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TAnexoDao.alterar(pAnexoModel: ITAnexoModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
  lConfiguracoes : ITerasoftConfiguracoes;
begin
  lQry := vIConexao.CriarQuery;

  lSQL :=  vConstrutor.gerarUpdate('ANEXO','ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pAnexoModel);
    lQry.ExecSQL;

    Supports(vIConexao.getTerasoftConfiguracoes, ITerasoftConfiguracoes, lConfiguracoes);

    if lConfiguracoes.objeto.valorTag('ENVIA_SINCRONIZA', 'N', tvBool) = 'S' then
     sincronizarDados(pAnexoModel);

    Result := pAnexoModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TAnexoDao.excluir(pAnexoModel: ITAnexoModel): String;
var
  lQry : TFDQuery;
  lConfiguracoes : ITerasoftConfiguracoes;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from ANEXO where ID = :ID' ,[pAnexoModel.objeto.ID]);
   lQry.ExecSQL;

   Supports(vIConexao.getTerasoftConfiguracoes, ITerasoftConfiguracoes, lConfiguracoes);

   if lConfiguracoes.objeto.valorTag('ENVIA_SINCRONIZA', 'N', tvBool) = 'S' then
     sincronizarDados(pAnexoModel);

   Result := pAnexoModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

class function TAnexoDao.getNewIface(pIConexao: IConexao): ITAnexoDao;
begin
  Result := TImplObjetoOwner<TAnexoDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TAnexoDao.where: String;
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

procedure TAnexoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From ANEXO where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

function TAnexoDao.obterLista: IFDDataset;
var
  lQry       : TFDQuery;
  lSQL       : String;
  lPaginacao : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lPaginacao := ' first ' + LengthPageView + ' SKIP ' + StartRecordView + '';

      lSQL := '  select '+lPaginacao+' anexo.*,                                  '+SLineBreak+
              '          documento.nome documento_nome                           '+SLineBreak+
              '          from anexo                                              '+SLineBreak+
              '     left join documento on documento.id = anexo.documento_id     '+SLineBreak+
              '    where 1=1                                                     '+SLineBreak;


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

procedure TAnexoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TAnexoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TAnexoDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TAnexoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TAnexoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TAnexoDao.setParams(var pQry: TFDQuery; pAnexoModel: ITAnexoModel);
begin
  vConstrutor.setParams('ANEXO',pQry,pAnexoModel.objeto);
end;

procedure TAnexoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TAnexoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TAnexoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

function TAnexoDao.sincronizarDados(pAnexoModel: ITAnexoModel): String;
var
  lLojasModel,
  lLojas      : ITLojasModel;
  lQry        : TFDQuery;
  lSQL        : String;
begin
  lLojasModel := TLojasModel.getNewIface(vIConexao);
  try
    lLojasModel.objeto.obterHosts;

    if pAnexoModel.objeto.Acao in [tacIncluir, tacAlterar] then
      lSQL := vConstrutor.gerarUpdateOrInsert('ANEXO','ID', 'ID', true)

    else if pAnexoModel.objeto.Acao in [tacExcluir] then
      lSQL := ('delete from ANEXO where ID = :ID');

    for lLojas in lLojasModel.objeto.LojassLista do
    begin
      if lLojas.objeto.LOJA <> vIConexao.getEmpresa.LOJA then
      begin
        vIConexao.ConfigConexaoExterna('', lLojas.objeto.STRING_CONEXAO);
        lQry := vIConexao.criarQueryExterna;

        if pAnexoModel.objeto.Acao = tacExcluir then
        begin
          lQry.ExecSQL(lSQL, [pAnexoModel.objeto.ID]);
          lQry.ExecSQL;
        end
        else
        begin
          lQry.SQL.Clear;
          lQry.SQL.Add(lSQL);
          setParams(lQry, pAnexoModel);
          lQry.Open(lSQL);
        end;

      end;
    end;

  finally
    lLojasModel:=nil;
    lQry.Free;
  end;
end;

end.
