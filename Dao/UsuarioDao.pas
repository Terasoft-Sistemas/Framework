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
  Terasoft.Framework.ObjectIface,
  Terasoft.ConstrutorDao,
  Spring.Collections,
  Terasoft.Utils;

type
  TUsuarioDao = class;
  ITUsuarioDao=IObject<TUsuarioDao>;

  TUsuarioDao=class
  private
    [weak] mySelf: ITUsuarioDao;
    vIConexao   : IConexao;
    vConstrutor : TConstrutorDao;

    FUsuariosLista: IList<ITUsuarioModel>;
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
    procedure SetUsuariosLista(const Value: IList<ITUsuarioModel>);
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

    procedure setParams(var pQry: TFDQuery; pUsuarioModel: ITUsuarioModel);

  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITUsuarioDao;

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
    property UsuariosLista: IList<ITUsuarioModel> read FUsuariosLista write SetUsuariosLista;

    function incluir(pUsuarioModel: ITUsuarioModel): String;
    function alterar(pUsuarioModel: ITUsuarioModel): String;
    function excluir(pUsuarioModel: ITUsuarioModel): String;

    function vendedorUsuario(pIdUsuario: String): String;
    function nomeUsuario(pIdUsuario: String): String;
    function sincronizarDados(pUsuarioModel : ITUsuarioModel): String;

    function carregaClasse(pID: String): ITUsuarioModel;
    procedure validaLogin(user,pass: String);
    procedure obterLista;
end;

implementation

uses
  System.Rtti, LojasModel;

{ TUsuarioDao }

function TUsuarioDao.carregaClasse(pID: String): ITUsuarioModel;
var
  lQry: TFDQuery;
  lModel: ITUsuarioModel;
  lSQL: String;
begin
  lQry     := vIConexao.CriarQuery;
  lModel   := TUsuarioModel.getNewIface(vIConexao);
  Result   := lModel;

  try

    lSQL :=
    ' select                                        '+sLineBreak+
    '     u.*,                                      '+sLineBreak+
    '     f.codigo_fun,                             '+sLineBreak+
    '     f.tipo_ven                                '+sLineBreak+
    '                                               '+sLineBreak+
    ' from USUARIO u                                '+sLineBreak+
    '                                               '+sLineBreak+
    ' left join funcionario f on f.cod_user = u.id  '+sLineBreak+
    '                                               '+sLineBreak+
    ' where u.id = ' + QuotedStr(pID);


    lQry.Open(lSQL);

    if lQry.IsEmpty then
      Exit;

    lModel.objeto.ID                    := lQry.FieldByName('ID').AsString;
    lModel.objeto.STATUS                := lQry.FieldByName('STATUS').AsString;
    lModel.objeto.FANTASIA              := lQry.FieldByName('FANTASIA').AsString;
    lModel.objeto.SENHA                 := lQry.FieldByName('SENHA').AsString;
    lModel.objeto.NOME                  := lQry.FieldByName('NOME').AsString;
    lModel.objeto.DPTO                  := lQry.FieldByName('DPTO').AsString;
    lModel.objeto.PERFIL_NEW_ID         := lQry.FieldByName('PERFIL_NEW_ID').AsString;
    lModel.objeto.CODIGO_FUNCIONARIO    := lQry.FieldByName('codigo_fun').AsString;
    lModel.objeto.TIPO_VENDEDOR         := lQry.FieldByName('tipo_ven').AsString;
    lModel.objeto.PORCENTAGEM_ZOOM_TELA := lQry.FieldByName('PORCENTAGEM_ZOOM_TELA').AsString;
    lModel.objeto.USUARIO_WINDOWS       := lQry.FieldByName('USUARIO_WINDOWS').AsString;
    lModel.objeto.SENHA_WINDOWS         := lQry.FieldByName('SENHA_WINDOWS').AsString;
    lModel.objeto.URL_WINDOWS           := lQry.FieldByName('URL_WINDOWS').AsString;
    lModel.objeto.LOJA_ID               := lQry.FieldByName('LOJA_ID').AsString;

    Result := lModel;

  finally
    lQry.Free;
  end;
end;

constructor TUsuarioDao._Create(pIConexao : IConexao);
begin
  vIConexao   := pIConexao;
  vConstrutor := TConstrutorDao.Create(vIConexao);
end;

destructor TUsuarioDao.Destroy;
begin
  FUsuariosLista:=nil;
  FreeAndNil(vConstrutor);
  vIConexao   := nil;
  inherited;
end;

function TUsuarioDao.incluir(pUsuarioModel: ITUsuarioModel): String;
var
  lQry : TFDQuery;
  lSql : String;
begin
  lQry := vIConexao.CriarQuery;

  try
    lSql := vConstrutor.gerarInsert('USUARIO', 'ID', true);

    lQry.SQL.Add(lSQL);
    pUsuarioModel.objeto.id := vIConexao.Generetor('GEN_VENDACARTAO');
    setParams(lQry, pUsuarioModel);
    lQry.Open;

    Result := lQry.FieldByName('ID').AsString;
    Result := pUsuarioModel.objeto.ID;
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

function TUsuarioDao.alterar(pUsuarioModel: ITUsuarioModel): String;
var
  lQry : TFDQuery;
  lSql : String;
begin
  lQry := vIConexao.CriarQuery;

  lSQL := vConstrutor.gerarUpdate('USUARIO', 'ID');

  try
    lQry.SQL.Add(lSQL);
    setParams(lQry, pUsuarioModel);
    lQry.ExecSQL;

    Result := pUsuarioModel.objeto.ID;

  finally
    lSQL := '';
    lQry.Free;
  end;
end;

function TUsuarioDao.excluir(pUsuarioModel: ITUsuarioModel): String;
var
  lQry: TFDQuery;
begin
  lQry := vIConexao.CriarQuery;

  Result := '';

  try
    lQry.ExecSQL('delete from Usuario where id = :id', [pUsuarioModel.objeto.ID]);

    Result := pUsuarioModel.objeto.ID;
  finally
    lQry.Free;
  end;
end;

class function TUsuarioDao.getNewIface(pIConexao: IConexao): ITUsuarioDao;
begin
  Result := TImplObjetoOwner<TUsuarioDao>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
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
  modelo: ITUsuarioModel;
begin
  lQry := vIConexao.CriarQuery;

  FUsuariosLista := TCollections.CreateList<ITUsuarioModel>;

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
      modelo := TUsuarioModel.getNewIface(vIConexao);
      FUsuariosLista.Add(modelo);

      modelo.objeto.ID             := lQry.FieldByName('ID').AsString;
      modelo.objeto.STATUS         := lQry.FieldByName('STATUS').AsString;
      modelo.objeto.FANTASIA       := lQry.FieldByName('FANTASIA').AsString;
      modelo.objeto.SENHA          := lQry.FieldByName('SENHA').AsString;
      modelo.objeto.NOME           := lQry.FieldByName('NOME').AsString;
      modelo.objeto.DPTO           := lQry.FieldByName('DPTO').AsString;
      modelo.objeto.PERFIL_NEW_ID  := lQry.FieldByName('PERFIL_NEW_ID').AsString;

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

procedure TUsuarioDao.setParams(var pQry: TFDQuery; pUsuarioModel: ITUsuarioModel);
var
  lTabela : IFDDataset;
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
        pQry.ParamByName(pQry.Params[i].Name).Value := IIF(lProp.GetValue(pUsuarioModel.objeto).AsString = '',
        Unassigned, vConstrutor.getValue(lTabela.objeto, pQry.Params[i].Name, lProp.GetValue(pUsuarioModel).AsString))
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

procedure TUsuarioDao.SetUsuariosLista;
begin
  FUsuariosLista := Value;
end;

procedure TUsuarioDao.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

function TUsuarioDao.sincronizarDados(pUsuarioModel: ITUsuarioModel): String;
var
  lLojasModel,
  lLojas      : TLojasModel;
  lQry        : TFDQuery;
  lSQL        : String;
begin
  lLojasModel := TLojasModel.Create(vIConexao);
  try
    lLojasModel.obterHosts;

    lSQL := vConstrutor.gerarUpdateOrInsert('USUARIO', 'ID', 'ID', true);

    for lLojas in lLojasModel.LojassLista do
    begin
      if lLojas.LOJA <> vIConexao.getEmpresa.LOJA then
      begin
        vIConexao.ConfigConexaoExterna('', lLojas.STRING_CONEXAO);
        lQry := vIConexao.criarQueryExterna;

        lQry.SQL.Clear;
        lQry.SQL.Add(lSQL);
        setParams(lQry, pUsuarioModel);
        lQry.Open(lSQL);

        Result := lQry.FieldByName('ID').AsString;
      end;
    end;

  finally
    lLojasModel.Free;
    lQry.Free;
  end;
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
