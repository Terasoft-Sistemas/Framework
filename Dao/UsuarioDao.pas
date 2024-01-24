unit UsuarioDao;

interface

uses
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  Terasoft.FuncoesTexto,
  UsuarioModel,
  System.Generics.Collections,
  Interfaces.Conexao,
  Terasoft.ConstrutorDao,
  Terasoft.Utils;

type
  TUsuarioDao = class

  private
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FUsuariosLista: TObjectList<TUsuarioModel>;
    FLengthPageView: String;
    FIDRecordView: Integer;
    FStartRecordView: String;
    FCountView: String;
    FOrderView: String;
    FWhereView: String;
    FTotalRecords: Integer;
    FStatus: String;
    FID: String;
    FPerfil: Variant;
    procedure SetUsuariosLista(const Value: TObjectList<TUsuarioModel>);
    procedure SetCountView(const Value: String);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetOrderView(const Value: String);
    procedure SetStartRecordView(const Value: String);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure obterTotalRegistros;
    procedure SetStatus(const Value: String);
    procedure SetID(const Value: String);

    function where: String;
    procedure SetPerfil(const Value: Variant);

    procedure setParams(var pQry: TFDQuery; pUsuarioModel: TUsuarioModel);

  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    property ID: String read FID write SetID;
    property Status: String read FStatus write SetStatus;
    property Perfil: Variant read FPerfil write SetPerfil;
    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;
    property UsuariosLista: TObjectList<TUsuarioModel> read FUsuariosLista write SetUsuariosLista;

    function incluir(pUsuarioModel: TUsuarioModel): String;
    function alterar(pUsuarioModel: TUsuarioModel): String;
    function excluir(pUsuarioModel: TUsuarioModel): String;

    function vendedorUsuario(pIdUsuario: String): String;
    function nomeUsuario(pIdUsuario: String): String;

    function carregaClasse(ID: String): TUsuarioModel;
    procedure validaLogin(user,pass: String);
    procedure obterLista;
end;

implementation

uses
  System.Rtti;

{ TUsuarioDao }

function TUsuarioDao.carregaClasse(ID: String): TUsuarioModel;
var
  lQry: TFDQuery;
  lModel: TUsuarioModel;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TUsuarioModel.Create(vIConexao);
  Result   := lModel;

  try
    lQry.Open('select * from Usuario where id = ' + ID);

    if lQry.IsEmpty then
      Exit;

    lModel.ID             := lQry.FieldByName('ID').AsString;
    lModel.STATUS         := lQry.FieldByName('STATUS').AsString;
    lModel.FANTASIA       := lQry.FieldByName('FANTASIA').AsString;
    lModel.SENHA          := lQry.FieldByName('SENHA').AsString;
    lModel.NOME           := lQry.FieldByName('NOME').AsString;
    lModel.DPTO           := lQry.FieldByName('DPTO').AsString;
    lModel.PERFIL_NEW_ID  := lQry.FieldByName('PERFIL_NEW_ID').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TUsuarioDao.Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TUsuarioDao.Destroy;
begin
  inherited;

end;

function TUsuarioDao.incluir(pUsuarioModel: TUsuarioModel): String;
var
  lQry : TFDQuery;
  lSql : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSql := vConstrutor.gerarInsert('USUARIO', 'ID', true);

    lQry.SQL.Add(lSQL);
    pUsuarioModel.id := vIConexao.Generetor('GEN_VENDACARTAO');
    setParams(lQry, pUsuarioModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;
    Result := pUsuarioModel.ID;
  finally
     lQry.Free;
  end;
end;

function TUsuarioDao.where: String;
var
  lSql: String;
begin
  lSql := '';

  if not FWhereView.IsEmpty then
    lSQL := lSQL + FWhereView;

  if FIDRecordView <> 0  then
    lSQL := lSQL + ' and usuario.id = '+IntToStr(FIDRecordView);

  Result := lSql;
end;

function TUsuarioDao.nomeUsuario(pIdUsuario: String): String;
var
  lConexao: TFDConnection;
begin
  lConexao := vIConexao.getConnection;
  Result   := lConexao.ExecSQLScalar('select u.fantasia from usuario u where u.id = '+ QuotedStr(pIdUsuario));
end;

function TUsuarioDao.alterar(pUsuarioModel: TUsuarioModel): String;
var
  lQry : TFDQuery;
  lSql : String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('VENDACARTAO', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pUsuarioModel);
    lQry.ExecSQL;

    Result := pUsuarioModel.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TUsuarioDao.excluir(pUsuarioModel: TUsuarioModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  Result := '';

  try
    lQry.ExecSQL('delete from Usuario where id = :id', [pUsuarioModel.ID]);

    Result := pUsuarioModel.ID;
  finally
    lQry.Free;
  end;
end;

procedure TUsuarioDao.obterTotalRegistros;
var
  lQry: TFDQuery;
  lSQL:String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := ' select count(*) records ' +
          ' from Usuario ' +
          '     left join PERFIL_NEW on PERFIL_NEW.id = usuario.PERFIL_NEW_ID ' +
          ' where 1=1 ';
  try
    lSQL := lSQL + where;

    lQry.Open(lSQL);

    FTotalRecords := lQry.FieldByName('records').AsInteger;

  finally
    lQry.Free;
  end;
end;

procedure TUsuarioDao.obterLista;
var
  lQry: TFDQuery;
  lSQL:String;
  i: INteger;
begin
  lQry := vIConexao.CriarQuery;

  FUsuariosLista := TObjectList<TUsuarioModel>.Create;

  try
    if (StrToIntDef(LengthPageView, 0) > 0) or (StrToIntDef(StartRecordView, 0) > 0) then
      lSql := 'select first ' + LengthPageView + ' SKIP ' + StartRecordView + ' usuario.*, PERFIL_NEW.nome perfil_nome From usuario'
    else
      lSql := 'select usuario.*, PERFIL_NEW.nome perfil_nome From usuario';


    lSql := lSQL + ' left join PERFIL_NEW on PERFIL_NEW.id = usuario.PERFIL_NEW_ID ';

    lSql := lSQL + '  where 1=1 ';

    lSQL := lSQL + where;

    if not FOrderView.IsEmpty then
      lSQL := lSQL + ' order by ' + FOrderView;
    lQry.Open(lSQL);

    i := 0;
    lQry.First;
    while not lQry.Eof do
    begin
      FUsuariosLista.Add(TUsuarioModel.Create(vIConexao));

      i := FUsuariosLista.Count -1;

      FUsuariosLista[i].ID             := lQry.FieldByName('ID').AsString;
      FUsuariosLista[i].STATUS         := lQry.FieldByName('STATUS').AsString;
      FUsuariosLista[i].FANTASIA       := lQry.FieldByName('FANTASIA').AsString;
      FUsuariosLista[i].SENHA          := lQry.FieldByName('SENHA').AsString;
      FUsuariosLista[i].NOME           := lQry.FieldByName('NOME').AsString;
      FUsuariosLista[i].DPTO           := lQry.FieldByName('DPTO').AsString;
      FUsuariosLista[i].PERFIL_NEW_ID  := lQry.FieldByName('PERFIL_NEW_ID').AsString;

      lQry.Next;
    end;
    obterTotalRegistros;

  finally
    lQry.Free;
  end;
end;

procedure TUsuarioDao.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TUsuarioDao.SetID(const Value: String);
begin
  FID := Value;
end;

procedure TUsuarioDao.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TUsuarioDao.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TUsuarioDao.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TUsuarioDao.setParams(var pQry: TFDQuery; pUsuarioModel: TUsuarioModel);
var
  lTabela : TFDMemTable;
  lCtx    : TRttiContext;
  lProp   : TRttiProperty;
  i       : Integer;
begin
  lTabela := vConstrutor.getColumns('USUARIO');

  lCtx := TRttiContext.Create;
  try
    for i := 0 to pQry.Params.Count - 1 do
    begin
      lProp := lCtx.GetType(TUsuarioModel).GetProperty(pQry.Params[i].Name);

      if Assigned(lProp) then
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pUsuarioModel).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela, pQry.Params[i].Name, lProp.GetValue(pUsuarioModel).AsString))
    end;
  finally
    lCtx.Free;
  end;
end;

procedure TUsuarioDao.SetPerfil(const Value: Variant);
begin
  FPerfil := Value;
end;

procedure TUsuarioDao.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TUsuarioDao.SetStatus(const Value: String);
begin
  FStatus := Value;
end;

procedure TUsuarioDao.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TUsuarioDao.SetUsuariosLista(const Value: TObjectList<TUsuarioModel>);
begin
  FUsuariosLista := Value;
end;

procedure TUsuarioDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

procedure TUsuarioDao.validaLogin(user, pass: String);
var
  lQry : TFDQuery;
  lSQL : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSQL := ' Select ID, FANTASIA, NOME, SENHA, STATUS, PERFIL_NEW_ID From Usuario Where FANTASIA = ' + QuotedStr(user) + ' and SENHA = ' + QuotedStr(pass);

    lQry.Open(lSQL);

    if lQry.FieldByName('ID').IsNull then
    begin
      FID      := '0';
      FStatus  := '0';
      FPerfil  := '';
    end
    else
    begin
      FID      := lQry.FieldByName('ID').Value;
      FStatus  := lQry.FieldByName('STATUS').Value;
      FPerfil  := lQry.FieldByName('PERFIL_NEW_ID').Value;
    end;

  finally
    lQry.Free;
  end;
end;


function TUsuarioDao.vendedorUsuario(pIdUsuario: String): String;
var
  lConexao: TFDConnection;
begin
  lConexao := vIConexao.getConnection;
  Result   := lConexao.ExecSQLScalar('select codigo_fun from funcionario where tipo_ven = '+QuotedStr('S')+' and cod_user = '+ QuotedStr(pIdUsuario));
end;

end.
