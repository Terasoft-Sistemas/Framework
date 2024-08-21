unit UsuarioModel;

interface

uses
  Terasoft.Types,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.Generics.Collections,
  Spring.Collections,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao,
  System.Variants;

type
  TUsuarioModel = class;
  ITUsuarioModel = IObject<TUsuarioModel>;

  TUsuarioModel = class
  private
    [weak] mySelf: ITUsuarioModel;
    vIConexao : IConexao;
    FUsuariosLista:IList<ITUsuarioModel>;
    FAcao: TAcao;
    FDESCONTO: Variant;
    FFANTASIA: Variant;
    FLengthPageView: String;
    FDPTO: Variant;
    FIDRecordView: Integer;
    FPRECO_ID: Variant;
    FStartRecordView: String;
    FSENHA_PEDIDO: Variant;
    FCAIXA: Variant;
    FID: Variant;
    FCountView: String;
    FSTATUS: Variant;
    FNIVEL: Variant;
    FOrderView: String;
    FPERFIL_NEW_ID: Variant;
    FSENHA: Variant;
    FLOJA_ID: Variant;
    FWhereView: String;
    FTotalRecords: Integer;
    FOTP: Variant;
    FNOME: Variant;
    FHASH: Variant;
    FCODIGO_ANTERIOR: Variant;
    FUUID: Variant;
    FPEDIDO_WEB: Variant;
    FSENHA_WINDOWS: Variant;
    FSQL_PRODUTO_FC: Variant;
    FURL_WINDOWS: Variant;
    FUSUARIO_WINDOWS: Variant;
    FSYSTIME: Variant;
    FPAGINA_INICIAL_WEB: Variant;
    FATALHOS_WEB: Variant;
    FUUIDALTERACAO: Variant;
    FADM_PEDIDO_WEB: Variant;
    FMENU_OCULTO_WEB: Variant;
    FDATA_INC: Variant;
    FPORCENTAGEM_ZOOM_TELA: Variant;
    FIMAGEM: Variant;
    FPERFIL_ID: Variant;
    FCODIGO_FUNCIONARIO: Variant;
    FTIPO_VENDEDOR: Variant;
    procedure SetAcao(const Value: TAcao);
    procedure SetCAIXA(const Value: Variant);
    procedure SetCountView(const Value: String);
    procedure SetDESCONTO(const Value: Variant);
    procedure SetDPTO(const Value: Variant);
    procedure SetFANTASIA(const Value: Variant);
    procedure SetID(const Value: Variant);
    procedure SetIDRecordView(const Value: Integer);
    procedure SetLengthPageView(const Value: String);
    procedure SetLOJA_ID(const Value: Variant);
    procedure SetNIVEL(const Value: Variant);
    procedure SetNOME(const Value: Variant);
    procedure SetOrderView(const Value: String);
    procedure SetOTP(const Value: Variant);
    procedure SetPERFIL_NEW_ID(const Value: Variant);
    procedure SetPRECO_ID(const Value: Variant);
    procedure SetSENHA(const Value: Variant);
    procedure SetSENHA_PEDIDO(const Value: Variant);
    procedure SetStartRecordView(const Value: String);
    procedure SetSTATUS(const Value: Variant);
    procedure SetTotalRecords(const Value: Integer);
    procedure SetWhereView(const Value: String);
    procedure SetADM_PEDIDO_WEB(const Value: Variant);
    procedure SetATALHOS_WEB(const Value: Variant);
    procedure SetCODIGO_ANTERIOR(const Value: Variant);
    procedure SetDATA_INC(const Value: Variant);
    procedure SetHASH(const Value: Variant);
    procedure SetMENU_OCULTO_WEB(const Value: Variant);
    procedure SetPAGINA_INICIAL_WEB(const Value: Variant);
    procedure SetPEDIDO_WEB(const Value: Variant);
    procedure SetSENHA_WINDOWS(const Value: Variant);
    procedure SetSQL_PRODUTO_FC(const Value: Variant);
    procedure SetSYSTIME(const Value: Variant);
    procedure SetURL_WINDOWS(const Value: Variant);
    procedure SetUSUARIO_WINDOWS(const Value: Variant);
    procedure SetUUID(const Value: Variant);
    procedure SetUUIDALTERACAO(const Value: Variant);
    procedure SetPORCENTAGEM_ZOOM_TELA(const Value: Variant);
    procedure SetIMAGEM(const Value: Variant);
    procedure SetPERFIL_ID(const Value: Variant);
    procedure SetCODIGO_FUNCIONARIO(const Value: Variant);
    procedure SetTIPO_VENDEDOR(const Value: Variant);

  public

    property ID                  : Variant read FID write SetID;
    property STATUS              : Variant read FSTATUS write SetSTATUS;
    property SENHA               : Variant read FSENHA write SetSENHA;
    property NOME                : Variant read FNOME write SetNOME;
    property FANTASIA            : Variant read FFANTASIA write SetFANTASIA;
    property DPTO                : Variant read FDPTO write SetDPTO;
    property NIVEL               : Variant read FNIVEL write SetNIVEL;
    property DESCONTO            : Variant read FDESCONTO write SetDESCONTO;
    property CAIXA               : Variant read FCAIXA write SetCAIXA;
    property PERFIL_NEW_ID       : Variant read FPERFIL_NEW_ID write SetPERFIL_NEW_ID;
    property SENHA_PEDIDO        : Variant read FSENHA_PEDIDO write SetSENHA_PEDIDO;
    property PRECO_ID            : Variant read FPRECO_ID write SetPRECO_ID;
    property LOJA_ID             : Variant read FLOJA_ID write SetLOJA_ID;
    property OTP                 : Variant read FOTP write SetOTP;
    property DATA_INC            : Variant read FDATA_INC write SetDATA_INC;
    property HASH                : Variant read FHASH write SetHASH;
    property ADM_PEDIDO_WEB      : Variant read FADM_PEDIDO_WEB write SetADM_PEDIDO_WEB;
    property SQL_PRODUTO_FC      : Variant read FSQL_PRODUTO_FC write SetSQL_PRODUTO_FC;
    property UUID                : Variant read FUUID write SetUUID;
    property UUIDALTERACAO       : Variant read FUUIDALTERACAO write SetUUIDALTERACAO;
    property CODIGO_ANTERIOR     : Variant read FCODIGO_ANTERIOR write SetCODIGO_ANTERIOR;
    property SYSTIME             : Variant read FSYSTIME write SetSYSTIME;
    property ATALHOS_WEB         : Variant read FATALHOS_WEB write SetATALHOS_WEB;
    property MENU_OCULTO_WEB     : Variant read FMENU_OCULTO_WEB write SetMENU_OCULTO_WEB;
    property PEDIDO_WEB          : Variant read FPEDIDO_WEB write SetPEDIDO_WEB;
    property USUARIO_WINDOWS     : Variant read FUSUARIO_WINDOWS write SetUSUARIO_WINDOWS;
    property SENHA_WINDOWS       : Variant read FSENHA_WINDOWS write SetSENHA_WINDOWS;
    property URL_WINDOWS         : Variant read FURL_WINDOWS write SetURL_WINDOWS;
    property PAGINA_INICIAL_WEB  : Variant read FPAGINA_INICIAL_WEB write SetPAGINA_INICIAL_WEB;
    property PORCENTAGEM_ZOOM_TELA : Variant read FPORCENTAGEM_ZOOM_TELA write SetPORCENTAGEM_ZOOM_TELA;
    property PERFIL_ID             : Variant read FPERFIL_ID write SetPERFIL_ID;
    property IMAGEM                : Variant read FIMAGEM write SetIMAGEM;
    property CODIGO_FUNCIONARIO    : Variant read FCODIGO_FUNCIONARIO write SetCODIGO_FUNCIONARIO;
    property TIPO_VENDEDOR         : Variant read FTIPO_VENDEDOR write SetTIPO_VENDEDOR;

    property Acao          : TAcao                      read FAcao          write SetAcao;
    property UsuariosLista : IList<ITUsuarioModel> read FUsuariosLista write FUsuariosLista;

    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITUsuarioModel;

    function vendedorUsuario(pIdUsuario: String): String;
    function nomeUsuario(pIdUsuario: String): String;
    function carregaClasse(ID: String): ITUsuarioModel;
    function Incluir     : String;
    function Alterar(pID : String) : ITUsuarioModel;
    function Excluir(pID : String) : String;
    function Salvar      : String;
    function validaLogin(user,pass: String): Boolean;
    function verificaServicoNuvem: Boolean;
    function alterarSenha(pIDUsuario, pSenhaAtual, pNovaSenha : String) : Boolean;

    procedure obterLista;
  end;

implementation

uses
  UsuarioDao,
  Terasoft.Utils,
  Terasoft.Configuracoes,
  EmpresaModel,
  ConfiguracoesModel;

{ TUsuarioModel }

function TUsuarioModel.Alterar(pID: String): ITUsuarioModel;
var
  lUsuarioModel : ITUsuarioModel;
begin
  lUsuarioModel := TUsuarioModel.getNewIface(vIConexao);
  try
    lUsuarioModel       := lUsuarioModel.objeto.carregaClasse(pID);
    lUsuarioModel.objeto.Acao  := tacAlterar;
    Result              := lUsuarioModel;
  finally

  end;
end;

function TUsuarioModel.Excluir(pID: String): String;
begin
  self.FID  := pID;
  self.Acao := tacExcluir;
  Result    := self.Salvar;
end;

class function TUsuarioModel.getNewIface(pIConexao: IConexao): ITUsuarioModel;
begin
  Result := TImplObjetoOwner<TUsuarioModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TUsuarioModel.Incluir: String;
begin
  self.Acao := tacIncluir;
  Result    := self.Salvar;
end;

function TUsuarioModel.alterarSenha(pIDUsuario, pSenhaAtual, pNovaSenha: String): Boolean;
var
  lUsuarioModel  : ITUsuarioModel;
  lUsuarioDao    : ITUsuarioDao;
  lConfiguracoes : ITerasoftConfiguracoes;
begin
  lUsuarioDao := TUsuarioDao.getNewIface(vIConexao.NovaConexao(vIConexao.getEmpresa.LOJA));
  Supports(vIConexao.getTerasoftConfiguracoes, ITerasoftConfiguracoes, lConfiguracoes);
  try
    Result := False;

    if pIDUsuario = '' then
      CriaException('ID do usuário não informado.');

    if pSenhaAtual = '' then
      CriaException('Senha atual não informada.');

    if pNovaSenha = '' then
      CriaException('Nova senha não informada.');

    lUsuarioModel := lUsuarioDao.objeto.carregaClasse(pIDUsuario);

    if lUsuarioModel.objeto.SENHA = pSenhaAtual then
    begin
      lUsuarioModel.objeto.FAcao := tacAlterar;
      lUsuarioModel.objeto.SENHA := pNovaSenha;
      lUsuarioModel.objeto.Salvar;

      if lConfiguracoes.objeto.valorTag('ENVIA_SINCRONIZA', 'N', tvBool) = 'S' then
        lUsuarioDao.objeto.sincronizarDados(lUsuarioModel);

      Result := True;

    end;

  finally
    lUsuarioDao := nil;
    lUsuarioModel := nil;
  end;
end;

function TUsuarioModel.carregaClasse(ID: String): ITUsuarioModel;
var
  lUsuarioModel: ITUsuarioDao;
begin
  lUsuarioModel := TUsuarioDao.getNewIface(vIConexao);
  try
    Result := lUsuarioModel.objeto.carregaClasse(ID);
  finally
    lUsuarioModel := nil;
  end;
end;

constructor TUsuarioModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TUsuarioModel.Destroy;
begin
  FUsuariosLista := nil;
  vIConexao := nil;
  inherited;
end;

function TUsuarioModel.nomeUsuario(pIdUsuario: String): String;
var
  lUsuarioDao: ITUsuarioDao;
begin
  lUsuarioDao := TUsuarioDao.getNewIface(vIConexao);
  try
    Result := lUsuarioDao.objeto.nomeUsuario(pIdUsuario);
  finally
    lUsuarioDao := nil;
  end;
end;

procedure TUsuarioModel.obterLista;
var
  lUsuariosLista: ITUsuarioDao;
begin
  lUsuariosLista := TUsuarioDao.getNewIface(vIConexao);

  try

    lUsuariosLista.objeto.WhereView       := FWhereView;
    lUsuariosLista.objeto.CountView       := FCountView;
    lUsuariosLista.objeto.OrderView       := FOrderView;
    lUsuariosLista.objeto.StartRecordView := FStartRecordView;
    lUsuariosLista.objeto.LengthPageView  := FLengthPageView;
    lUsuariosLista.objeto.IDRecordView    := FIDRecordView;

    lUsuariosLista.objeto.obterLista;

    FTotalRecords  := lUsuariosLista.objeto.TotalRecords;
    FUsuariosLista := lUsuariosLista.objeto.UsuariosLista;

  finally
    lUsuariosLista := nil;
  end;
end;

function TUsuarioModel.validaLogin(user, pass: String): Boolean;
var
  lUsuarioDao   : ITUsuarioDao;
  lEmpresaModel : ITEmpresaModel;
begin
  try
    lUsuarioDao   := TUsuarioDao.getNewIface(vIConexao);
    lEmpresaModel := TEmpresaModel.getNewIface(vIConexao);

    lUsuarioDao.objeto.validaLogin(user,pass);

    if lUsuarioDao.objeto.Status <> 'S' then
      CriaException('Não foi possível efetuar seu login, entre em contato com o admistrador do sistema.');

    lEmpresaModel.objeto.Carregar;

    if not VarIsNull(lUsuarioDao.objeto.LOJA_ID) and (lUsuarioDao.objeto.LOJA_ID <> '') and (lUsuarioDao.objeto.LOJA_ID <> lEmpresaModel.objeto.LOJA) then
      CriaException('Usuário vinculado a loja '+lUsuarioDao.objeto.LOJA_ID+', não está autorizado para logar na loja '+lEmpresaModel.objeto.LOJA);

    self.verificaServicoNuvem;

    FID            := lUsuarioDao.objeto.ID;
    FPERFIL_NEW_ID := lUsuarioDao.objeto.Perfil;
    FLOJA_ID       := lUsuarioDao.objeto.LOJA_ID;
    Result := true;

  finally
    lUsuarioDao := nil;
    lEmpresaModel := nil;
  end;
end;

function TUsuarioModel.vendedorUsuario(pIdUsuario: String): String;
var
  lUsuarioDao: ITUsuarioDao;
begin
  lUsuarioDao := TUsuarioDao.getNewIface(vIConexao);
  try
    Result := lUsuarioDao.objeto.vendedorUsuario(pIdUsuario);
  finally
    lUsuarioDao := nil;
  end;
end;

function TUsuarioModel.verificaServicoNuvem: Boolean;
var
  lConfiguracoesModel : ITConfiguracoesModel;
begin
  Result := true;

  lConfiguracoesModel := TConfiguracoesModel.getNewIface(vIConexao);
  try
    lConfiguracoesModel.objeto.WhereView := 'AND CONFIGURACOES.TAG = ''USA_SERVICO_NUVEM'' ';
    lConfiguracoesModel.objeto.obterLista;

    for lConfiguracoesModel in lConfiguracoesModel.objeto.ConfiguracoessLista do begin

      if lConfiguracoesModel.objeto.VALORCHAR = 'S' then
      begin
        if (self.FUSUARIO_WINDOWS = '') and (self.FID <> '000001') then begin
          CriaException('Este usuário não possui licença de acesso ao sistema em nuvem. Contate o administrador do sistema para liberar seu acesso.');
          Result := false;
        end;
      end;

    end;

  finally
    lConfiguracoesModel := nil;
  end;
end;

function TUsuarioModel.Salvar: String;
var
  lUsuarioDao: ITUsuarioDao;
begin
  lUsuarioDao := TUsuarioDao.getNewIface(vIConexao);

  Result := '';

  try

    case FAcao of
      Terasoft.Types.tacIncluir: Result := lUsuarioDao.objeto.incluir(mySelf);
      Terasoft.Types.tacAlterar: Result := lUsuarioDao.objeto.alterar(mySelf);
      Terasoft.Types.tacExcluir: Result := lUsuarioDao.objeto.excluir(mySelf);
    end;

  finally
    lUsuarioDao := nil;
  end;
end;

procedure TUsuarioModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TUsuarioModel.SetADM_PEDIDO_WEB(const Value: Variant);
begin
  FADM_PEDIDO_WEB := Value;
end;

procedure TUsuarioModel.SetATALHOS_WEB(const Value: Variant);
begin
  FATALHOS_WEB := Value;
end;

procedure TUsuarioModel.SetCAIXA(const Value: Variant);
begin
  FCAIXA := Value;
end;

procedure TUsuarioModel.SetCODIGO_ANTERIOR(const Value: Variant);
begin
  FCODIGO_ANTERIOR := Value;
end;

procedure TUsuarioModel.SetCODIGO_FUNCIONARIO(const Value: Variant);
begin
  FCODIGO_FUNCIONARIO := Value;
end;

procedure TUsuarioModel.SetCountView(const Value: String);
begin
  FCountView := Value;
end;

procedure TUsuarioModel.SetDATA_INC(const Value: Variant);
begin
  FDATA_INC := Value;
end;

procedure TUsuarioModel.SetDESCONTO(const Value: Variant);
begin
  FDESCONTO := Value;
end;

procedure TUsuarioModel.SetDPTO(const Value: Variant);
begin
  FDPTO := Value;
end;

procedure TUsuarioModel.SetFANTASIA(const Value: Variant);
begin
  FFANTASIA := Value;
end;

procedure TUsuarioModel.SetHASH(const Value: Variant);
begin
  FHASH := Value;
end;

procedure TUsuarioModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TUsuarioModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TUsuarioModel.SetIMAGEM(const Value: Variant);
begin
  FIMAGEM := Value;
end;

procedure TUsuarioModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TUsuarioModel.SetLOJA_ID(const Value: Variant);
begin
  FLOJA_ID := Value;
end;

procedure TUsuarioModel.SetMENU_OCULTO_WEB(const Value: Variant);
begin
  FMENU_OCULTO_WEB := Value;
end;

procedure TUsuarioModel.SetNIVEL(const Value: Variant);
begin
  FNIVEL := Value;
end;

procedure TUsuarioModel.SetNOME(const Value: Variant);
begin
  FNOME := Value;
end;

procedure TUsuarioModel.SetOrderView(const Value: String);
begin
  FOrderView := Value;
end;

procedure TUsuarioModel.SetOTP(const Value: Variant);
begin
  FOTP := Value;
end;

procedure TUsuarioModel.SetPAGINA_INICIAL_WEB(const Value: Variant);
begin
  FPAGINA_INICIAL_WEB := Value;
end;

procedure TUsuarioModel.SetPEDIDO_WEB(const Value: Variant);
begin
  FPEDIDO_WEB := Value;
end;

procedure TUsuarioModel.SetPERFIL_ID(const Value: Variant);
begin
  FPERFIL_ID := Value;
end;

procedure TUsuarioModel.SetPERFIL_NEW_ID(const Value: Variant);
begin
  FPERFIL_NEW_ID := Value;
end;

procedure TUsuarioModel.SetPORCENTAGEM_ZOOM_TELA(const Value: Variant);
begin
  FPORCENTAGEM_ZOOM_TELA := Value;
end;

procedure TUsuarioModel.SetPRECO_ID(const Value: Variant);
begin
  FPRECO_ID := Value;
end;

procedure TUsuarioModel.SetSENHA(const Value: Variant);
begin
  FSENHA := Value;
end;

procedure TUsuarioModel.SetSENHA_PEDIDO(const Value: Variant);
begin
  FSENHA_PEDIDO := Value;
end;

procedure TUsuarioModel.SetSENHA_WINDOWS(const Value: Variant);
begin
  FSENHA_WINDOWS := Value;
end;

procedure TUsuarioModel.SetSQL_PRODUTO_FC(const Value: Variant);
begin
  FSQL_PRODUTO_FC := Value;
end;

procedure TUsuarioModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TUsuarioModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TUsuarioModel.SetSYSTIME(const Value: Variant);
begin
  FSYSTIME := Value;
end;

procedure TUsuarioModel.SetTIPO_VENDEDOR(const Value: Variant);
begin
  FTIPO_VENDEDOR := Value;
end;

procedure TUsuarioModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TUsuarioModel.SetURL_WINDOWS(const Value: Variant);
begin
  FURL_WINDOWS := Value;
end;

procedure TUsuarioModel.SetUSUARIO_WINDOWS(const Value: Variant);
begin
  FUSUARIO_WINDOWS := Value;
end;

procedure TUsuarioModel.SetUUID(const Value: Variant);
begin
  FUUID := Value;
end;

procedure TUsuarioModel.SetUUIDALTERACAO(const Value: Variant);
begin
  FUUIDALTERACAO := Value;
end;

procedure TUsuarioModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
