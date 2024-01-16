unit UsuarioModel;

interface

uses
  Terasoft.Enumerado,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.Generics.Collections;

type
  TUsuarioModel = class

  private
    FUsuariosLista: TObjectList<TUsuarioModel>;
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

  public

    property ID            :Variant read FID write SetID;
    property STATUS        :Variant read FSTATUS write SetSTATUS;
    property SENHA         :Variant read FSENHA write SetSENHA;
    property NOME          :Variant read FNOME write SetNOME;
    property FANTASIA      :Variant read FFANTASIA write SetFANTASIA;
    property DPTO          :Variant read FDPTO write SetDPTO;
    property NIVEL         :Variant read FNIVEL write SetNIVEL;
    property DESCONTO      :Variant read FDESCONTO write SetDESCONTO;
    property CAIXA         :Variant read FCAIXA write SetCAIXA;
    property PERFIL_NEW_ID :Variant read FPERFIL_NEW_ID write SetPERFIL_NEW_ID;
    property SENHA_PEDIDO  :Variant read FSENHA_PEDIDO write SetSENHA_PEDIDO;
    property PRECO_ID      :Variant read FPRECO_ID write SetPRECO_ID;
    property LOJA_ID       :Variant read FLOJA_ID write SetLOJA_ID;
    property OTP           :Variant read FOTP write SetOTP;

    property Acao          :TAcao   read FAcao write SetAcao;
    property UsuariosLista: TObjectList<TUsuarioModel> read FUsuariosLista write FUsuariosLista;

    property TotalRecords: Integer read FTotalRecords write SetTotalRecords;
    property WhereView: String read FWhereView write SetWhereView;
    property CountView: String read FCountView write SetCountView;
    property OrderView: String read FOrderView write SetOrderView;
    property StartRecordView: String read FStartRecordView write SetStartRecordView;
    property LengthPageView: String read FLengthPageView write SetLengthPageView;
    property IDRecordView: Integer read FIDRecordView write SetIDRecordView;

    constructor Create;
    destructor Destroy; override;

    function vendedorUsuario(pIdUsuario: String): String;
    function nomeUsuario(pIdUsuario: String): String;

    function carregaClasse(ID: String): TUsuarioModel;
    procedure obterLista;
    function Salvar: String;
    function validaLogin(user,pass: String): Boolean;
  end;

implementation

uses UsuarioDao, Conexao, VariaveisGlobais;

{ TUsuarioModel }

function TUsuarioModel.carregaClasse(ID: String): TUsuarioModel;
var
  lUsuarioLista: TUsuarioDao;
begin
  lUsuarioLista := TUsuarioDao.Create;
  try
    Result := lUsuarioLista.carregaClasse(ID);
  finally
    lUsuarioLista.Free;
  end;
end;

constructor TUsuarioModel.Create;
begin

end;

destructor TUsuarioModel.Destroy;
begin

  inherited;
end;

function TUsuarioModel.nomeUsuario(pIdUsuario: String): String;
var
  lUsuarioDao: TUsuarioDao;
begin
  lUsuarioDao := TUsuarioDao.Create;
  try
    Result := lUsuarioDao.nomeUsuario(pIdUsuario);
  finally
    lUsuarioDao.Free;
  end;
end;

procedure TUsuarioModel.obterLista;
var
  lUsuariosLista: TUsuarioDao;
begin
  lUsuariosLista := TUsuarioDao.Create;

  try

    lUsuariosLista.WhereView       := FWhereView;
    lUsuariosLista.CountView       := FCountView;
    lUsuariosLista.OrderView       := FOrderView;
    lUsuariosLista.StartRecordView := FStartRecordView;
    lUsuariosLista.LengthPageView  := FLengthPageView;
    lUsuariosLista.IDRecordView    := FIDRecordView;

    lUsuariosLista.obterLista;

    FTotalRecords  := lUsuariosLista.TotalRecords;
    FUsuariosLista := lUsuariosLista.UsuariosLista;

  finally
    lUsuariosLista.Free;
  end;
end;

function TUsuarioModel.validaLogin(user, pass: String): Boolean;
var
  lUsuarioDao: TUsuarioDao;
begin
  try
    lUsuarioDao := TUsuarioDao.Create;
    
    lUsuarioDao.validaLogin(user,pass);

    if lUsuarioDao.Status = 'S' then
    begin
      FID        := lUsuarioDao.ID;
      FPERFIL_NEW_ID := lUsuarioDao.Perfil;

      xConexao.setContextModoSistema('PAF_NFCE');

      Result := true;
    end else
      Result := False;
  finally
    lUsuarioDao.Free;
  end;
end;

function TUsuarioModel.vendedorUsuario(pIdUsuario: String): String;
var
  lUsuarioDao: TUsuarioDao;
begin
  lUsuarioDao := TUsuarioDao.Create;
  try
    Result := lUsuarioDao.vendedorUsuario(pIdUsuario);
  finally
    lUsuarioDao.Free;
  end;
end;

function TUsuarioModel.Salvar: String;
var
  lUsuarioDao: TUsuarioDao;
begin
  lUsuarioDao := TUsuarioDao.Create;

  Result := '';

  try

    case FAcao of
      Terasoft.Enumerado.tacIncluir: Result := lUsuarioDao.incluir(Self);
      Terasoft.Enumerado.tacAlterar: Result := lUsuarioDao.alterar(Self);
      Terasoft.Enumerado.tacExcluir: Result := lUsuarioDao.excluir(Self);
    end;

  finally
    lUsuarioDao.Free;
  end;
end;

procedure TUsuarioModel.SetAcao(const Value: TAcao);
begin
  FAcao := Value;
end;

procedure TUsuarioModel.SetCAIXA(const Value: Variant);
begin
  FCAIXA := Value;
end;

procedure TUsuarioModel.SetCountView(const Value: String);
begin
  FCountView := Value;
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

procedure TUsuarioModel.SetID(const Value: Variant);
begin
  FID := Value;
end;

procedure TUsuarioModel.SetIDRecordView(const Value: Integer);
begin
  FIDRecordView := Value;
end;

procedure TUsuarioModel.SetLengthPageView(const Value: String);
begin
  FLengthPageView := Value;
end;

procedure TUsuarioModel.SetLOJA_ID(const Value: Variant);
begin
  FLOJA_ID := Value;
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

procedure TUsuarioModel.SetPERFIL_NEW_ID(const Value: Variant);
begin
  FPERFIL_NEW_ID := Value;
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

procedure TUsuarioModel.SetStartRecordView(const Value: String);
begin
  FStartRecordView := Value;
end;

procedure TUsuarioModel.SetSTATUS(const Value: Variant);
begin
  FSTATUS := Value;
end;

procedure TUsuarioModel.SetTotalRecords(const Value: Integer);
begin
  FTotalRecords := Value;
end;

procedure TUsuarioModel.SetWhereView(const Value: String);
begin
  FWhereView := Value;
end;

end.
