unit AdmCartaoDao;

interface

uses
  AdmCartaoModel,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Generics.Collections,
  System.Variants,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao,
  Terasoft.ConstrutorDao,
  Terasoft.Framework.ObjectIface,
  Spring.Collections,
  Terasoft.Types,
  Terasoft.Utils;

type
  TAdmCartaoDao = class;

  ITAdmCartaoDao = IObject<TAdmCartaoDao>;

  TAdmCartaoDao = class

  private
    [weak] myself : ITAdmCartaoDao;
    vIConexao     : IConexao;
    vConstrutor   : IConstrutorDao;

    FAdmCartaosLista: IList<ITAdmCartaoModel>;
    FLengthPageView: String;
    FIDRecordView: String;
    FStartRecordView: String;
    FID: Variant;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    procedure SetCountView(const Value: String);
    procedure SetAdmCartaosLista(const Value: IList<ITAdmCartaoModel>);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: String);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);

    function where: String;

  public
    constructor Create(pIConexao: IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITAdmCartaoDao;

    property AdmCartaosLista: IList<ITAdmCartaoModel> read FAdmCartaosLista write SetAdmCartaosLista;
    property ID :Variant read FID write SetID;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: String read FIDRecordView write SetIDRecordView;

    function incluir(AAdmCartaoModel: ITAdmCartaoModel): String;
    function alterar(AAdmCartaoModel: ITAdmCartaoModel): String;
    function excluir(AAdmCartaoModel: ITAdmCartaoModel): String;

    function sincronizarDados(AAdmCartaoModel: ITAdmCartaoModel): String;

	  procedure obterTotalRegistros;
    procedure obterLista;
    procedure setParams(var pQry: TFDQuery; pAdmCartaoModel: ITAdmCartaoModel);

    function carregaClasse(pId: String): ITAdmCartaoModel;

end;

implementation

uses
  System.Rtti, LojasModel, Terasoft.Configuracoes;

{ TAdmCartao }

function TAdmCartaoDao.carregaClasse(pId: String): ITAdmCartaoModel;
var
  lQry: TFDQuery;
  lModel: ITAdmCartaoModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TAdmCartaoModel.getNewIface(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from admcartao where id = '+QuotedStr(pId));

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID                    := lQry.FieldByName('ID').AsString;
    lModel.objeto.NOME_ADM              := lQry.FieldByName('NOME_ADM').AsString;
    lModel.objeto.CREDITO_ADM           := lQry.FieldByName('CREDITO_ADM').AsString;
    lModel.objeto.DEBITO_ADM            := lQry.FieldByName('DEBITO_ADM').AsString;
    lModel.objeto.PARCELADO_ADM         := lQry.FieldByName('PARCELADO_ADM').AsString;
    lModel.objeto.STATUS                := lQry.FieldByName('STATUS').AsString;
    lModel.objeto.COMISSAO_ADM          := lQry.FieldByName('COMISSAO_ADM').AsString;
    lModel.objeto.LOJA                  := lQry.FieldByName('LOJA').AsString;
    lModel.objeto.GERENCIADOR           := lQry.FieldByName('GERENCIADOR').AsString;
    lModel.objeto.VENCIMENTO_DIA_SEMANA := lQry.FieldByName('VENCIMENTO_DIA_SEMANA').AsString;
    lModel.objeto.PORTADOR_ID           := lQry.FieldByName('PORTADOR_ID').AsString;
    lModel.objeto.IMAGEM                := lQry.FieldByName('IMAGEM').AsString;
    lModel.objeto.TAXA                  := lQry.FieldByName('TAXA').AsString;
    lModel.objeto.SYSTIME               := lQry.FieldByName('SYSTIME').AsString;
    lModel.objeto.NOME_WEB              := lQry.FieldByName('NOME_WEB').AsString;
    lModel.objeto.CONCILIADORA_ID       := lQry.FieldByName('CONCILIADORA_ID').AsString;

    Result := lModel;
  finally
    lQry.Free;
  end;
end;

constructor TAdmCartaoDao.Create(pIConexao: IConexao);
begin
  vIConexao  := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TAdmCartaoDao.Destroy;
begin
  FAdmCartaosLista := nil;
  vConstrutor:=nil;
  vIConexao := nil;
  inherited;
end;

class function TAdmCartaoDao.getNewIface(pIConexao: IConexao): ITAdmCartaoDao;
begin
  Result := TImplObjetoOwner<TAdmCartaoDao>.CreateOwner(self.Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TAdmCartaoDao.incluir(AAdmCartaoModel: ITAdmCartaoModel): String;
var
  lQry : TFDQuery;
  lSQL : String;
  lConfiguracoes : ITerasoftConfiguracoes;
begin
  lQry := vIConexao.CriarQuery;
  lSQL := vConstrutor.gerarInsert('ADMCARTAO', 'ID', true);

  try
//    Supports(vIConexao.getTerasoftConfiguracoes, ITerasoftConfiguracoes, lConfiguracoes);

    lQry.SQL.Add(lSQL);
    AAdmCartaoModel.objeto.ID := vIConexao.Generetor('GEN_ADMCARTAO', true);
    setParams(lQry, AAdmCartaoModel);
    lQry.Open;

//    if lConfiguracoes.objeto.valorTag('ENVIA_SINCRONIZA', 'N', tvBool) = 'S' then
//      sincronizarDados(AAdmCartaoModel);

    Result := lQry.FieldByName('ID').AsString;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TAdmCartaoDao.alterar(AAdmCartaoModel: ITAdmCartaoModel): String;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('ADMCARTAO', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, AAdmCartaoModel);
    lQry.ExecSQL;

    Result := AAdmCartaoModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TAdmCartaoDao.excluir(AAdmCartaoModel: ITAdmCartaoModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  try
   lQry.ExecSQL('delete from admcartao where ID = :ID',[AAdmCartaoModel.objeto.ID]);
   lQry.ExecSQL;
   Result := AAdmCartaoModel.objeto.ID;

  finally
    lQry.Free;
  end;
end;

function TAdmCartaoDao.where: String;
var
  lSQL : String;
begin
  lSQL := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> ''  then
    lSQL := lSQL + ' and admcartao.id = '+ FIDRecordView;

  Result := lSQL;
end;

procedure TAdmCartaoDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  try
    lQry := vIConexao.CriarQuery;

    lSql := 'select count(*) records From admcartao where 1=1 ';

    lSql := lSql + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TAdmCartaoDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  modelo: ITAdmCartaoModel;
begin
  lQry := vIConexao.CriarQuery;

  FAdmCartaosLista := TCollections.CreateList<ITAdmCartaoModel>;

  try

    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView
    else
      lSql := 'select ';

    lSQL := lSQL +
      '       admcartao.*       '+
	    '  from admcartao         '+
      ' where 1=1               ';

    lSql := lSql + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by '+FOrderView;

    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      modelo := TAdmCartaoModel.getNewIface(vIConexao);
      FAdmCartaosLista.Add(modelo);

      modelo.objeto.ID                    := lQry.FieldByName('ID').AsString;
      modelo.objeto.NOME_ADM              := lQry.FieldByName('NOME_ADM').AsString;
      modelo.objeto.CREDITO_ADM           := lQry.FieldByName('CREDITO_ADM').AsString;
      modelo.objeto.DEBITO_ADM            := lQry.FieldByName('DEBITO_ADM').AsString;
      modelo.objeto.PARCELADO_ADM         := lQry.FieldByName('PARCELADO_ADM').AsString;
      modelo.objeto.STATUS                := lQry.FieldByName('STATUS').AsString;
      modelo.objeto.COMISSAO_ADM          := lQry.FieldByName('COMISSAO_ADM').AsString;
      modelo.objeto.LOJA                  := lQry.FieldByName('LOJA').AsString;
      modelo.objeto.GERENCIADOR           := lQry.FieldByName('GERENCIADOR').AsString;
      modelo.objeto.VENCIMENTO_DIA_SEMANA := lQry.FieldByName('VENCIMENTO_DIA_SEMANA').AsString;
      modelo.objeto.PORTADOR_ID           := lQry.FieldByName('PORTADOR_ID').AsString;
      modelo.objeto.IMAGEM                := lQry.FieldByName('IMAGEM').AsString;
      modelo.objeto.TAXA                  := lQry.FieldByName('TAXA').AsString;
      modelo.objeto.SYSTIME               := lQry.FieldByName('SYSTIME').AsString;
      modelo.objeto.NOME_WEB              := lQry.FieldByName('NOME_WEB').AsString;
      modelo.objeto.CONCILIADORA_ID       := lQry.FieldByName('CONCILIADORA_ID').AsString;

      lQry.Next;
    end;

    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TAdmCartaoDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TAdmCartaoDao.SetAdmCartaosLista;
begin
  FAdmCartaosLista := Value;
end;

procedure TAdmCartaoDao.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TAdmCartaoDao.SetIDRecordView(const Value: String);
begin
  FIDRecordView := Value;
end;

procedure TAdmCartaoDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TAdmCartaoDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TAdmCartaoDao.setParams(var pQry: TFDQuery; pAdmCartaoModel: ITAdmCartaoModel);
begin
  vConstrutor.setParams('ADMCARTAO',pQry,pAdmCartaoModel.objeto);
end;

procedure TAdmCartaoDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TAdmCartaoDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TAdmCartaoDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

function TAdmCartaoDao.sincronizarDados(AAdmCartaoModel: ITAdmCartaoModel): String;
var
  lLojasModel,
  lLojas      : ITLojasModel;
  lQry        : TFDQuery;
  lSQL        : String;
begin

  lLojasModel := TLojasModel.getNewIface(vIConexao);

  try
    lLojasModel.objeto.obterHosts;

    lSQL := vConstrutor.gerarUpdateOrInsert('ADMCARTAO','ID', 'ID', true);

    for lLojas in lLojasModel.objeto.LojassLista do
    begin
      if lLojas.objeto.LOJA <> vIConexao.getEmpresa.LOJA then
      begin
        vIConexao.ConfigConexaoExterna('', lLojas.objeto.STRING_CONEXAO);
        lQry := vIConexao.criarQueryExterna;

        lQry.SQL.Clear;
        lQry.Open('select ID from admcartao a where a.nome_adm = ' + QuotedStr(AAdmCartaoModel.objeto.NOME_ADM) + ' and a.id <> ' + AAdmCartaoModel.objeto.ID);

        if lQry.recordCount = 0 then
        begin
          lQry.SQL.Clear;
          lQry.SQL.Add(lSQL);
          setParams(lQry, AAdmCartaoModel);
          lQry.Open;

          Result := lQry.FieldByName('ID').AsString;
        end;
      end;
    end;

  finally
    lLojasModel := nil;
    lQry.Free;
  end;
end;

end.
