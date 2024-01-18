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
  Terasoft.ConstrutorDao;

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
    lQry.ParamByName('id').Value := vIConexao.Generetor('GEN_VENDACARTAO');
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
    lQry.ParamByName('id').Value := ifThen(pUsuarioModel.ID = '', Unassigned, pUsuarioModel.ID);
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
begin
  pQry.ParamByName('status').Value                := ifThen(pUsuarioModel.STATUS               = '', Unassigned, pUsuarioModel.STATUS);
  pQry.ParamByName('data_inc').Value              := ifThen(pUsuarioModel.DATA_INC             = '', Unassigned, pUsuarioModel.DATA_INC);
  pQry.ParamByName('senha').Value                 := ifThen(pUsuarioModel.SENHA                = '', Unassigned, pUsuarioModel.SENHA);
  pQry.ParamByName('hash').Value                  := ifThen(pUsuarioModel.HASH                 = '', Unassigned, pUsuarioModel.HASH);
  pQry.ParamByName('nome').Value                  := ifThen(pUsuarioModel.NOME                 = '', Unassigned, pUsuarioModel.NOME);
  pQry.ParamByName('fantasia').Value              := ifThen(pUsuarioModel.FANTASIA             = '', Unassigned, pUsuarioModel.FANTASIA);
  pQry.ParamByName('dpto').Value                  := ifThen(pUsuarioModel.DPTO                 = '', Unassigned, pUsuarioModel.DPTO);
  pQry.ParamByName('nivel').Value                 := ifThen(pUsuarioModel.NIVEL                = '', Unassigned, pUsuarioModel.NIVEL);
  pQry.ParamByName('desconto').Value              := ifThen(pUsuarioModel.DESCONTO             = '', Unassigned, pUsuarioModel.DESCONTO);
  pQry.ParamByName('caixa').Value                 := ifThen(pUsuarioModel.CAIXA                = '', Unassigned, pUsuarioModel.CAIXA);
  pQry.ParamByName('perfil_new_id').Value         := ifThen(pUsuarioModel.PERFIL_NEW_ID        = '', Unassigned, pUsuarioModel.PERFIL_NEW_ID);
  pQry.ParamByName('senha_pedido').Value          := ifThen(pUsuarioModel.SENHA_PEDIDO         = '', Unassigned, pUsuarioModel.SENHA_PEDIDO);
  pQry.ParamByName('adm_pedido_web').Value        := ifThen(pUsuarioModel.ADM_PEDIDO_WEB       = '', Unassigned, pUsuarioModel.ADM_PEDIDO_WEB);
  pQry.ParamByName('sql_produto_fc').Value        := ifThen(pUsuarioModel.SQL_PRODUTO_FC       = '', Unassigned, pUsuarioModel.SQL_PRODUTO_FC);
  pQry.ParamByName('preco_id').Value              := ifThen(pUsuarioModel.PRECO_ID             = '', Unassigned, pUsuarioModel.PRECO_ID);
  pQry.ParamByName('loja_id').Value               := ifThen(pUsuarioModel.LOJA_ID              = '', Unassigned, pUsuarioModel.LOJA_ID);
  pQry.ParamByName('uuid').Value                  := ifThen(pUsuarioModel.UUID                 = '', Unassigned, pUsuarioModel.UUID);
  pQry.ParamByName('uuidalteracao').Value         := ifThen(pUsuarioModel.UUIDALTERACAO        = '', Unassigned, pUsuarioModel.UUIDALTERACAO);
  pQry.ParamByName('otp').Value                   := ifThen(pUsuarioModel.OTP                  = '', Unassigned, pUsuarioModel.OTP);
  pQry.ParamByName('codigo_anterior').Value       := ifThen(pUsuarioModel.CODIGO_ANTERIOR      = '', Unassigned, pUsuarioModel.CODIGO_ANTERIOR);
  pQry.ParamByName('systime').Value               := ifThen(pUsuarioModel.SYSTIME              = '', Unassigned, pUsuarioModel.SYSTIME);
  pQry.ParamByName('atalhos_web').Value           := ifThen(pUsuarioModel.ATALHOS_WEB          = '', Unassigned, pUsuarioModel.ATALHOS_WEB);
  pQry.ParamByName('menu_oculto_web').Value       := ifThen(pUsuarioModel.MENU_OCULTO_WEB      = '', Unassigned, pUsuarioModel.MENU_OCULTO_WEB);
  pQry.ParamByName('pedido_web').Value            := ifThen(pUsuarioModel.PEDIDO_WEB           = '', Unassigned, pUsuarioModel.PEDIDO_WEB);
  pQry.ParamByName('usuario_windows').Value       := ifThen(pUsuarioModel.USUARIO_WINDOWS      = '', Unassigned, pUsuarioModel.USUARIO_WINDOWS);
  pQry.ParamByName('senha_windows').Value         := ifThen(pUsuarioModel.SENHA_WINDOWS        = '', Unassigned, pUsuarioModel.SENHA_WINDOWS);
  pQry.ParamByName('url_windows').Value           := ifThen(pUsuarioModel.URL_WINDOWS          = '', Unassigned, pUsuarioModel.URL_WINDOWS);
  pQry.ParamByName('pagina_inicial_web').Value    := ifThen(pUsuarioModel.PAGINA_INICIAL_WEB   = '', Unassigned, pUsuarioModel.PAGINA_INICIAL_WEB);
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
  lQry: TFDQuery;
  lSQL:String;
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
