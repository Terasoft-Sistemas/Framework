unit Terasoft.PIX.Types;
interface
  uses
    SysUtils,Classes,
    Terasoft.Framework.SimpleTypes,
    Terasoft.Framework.ListaSimples;
type
  TResumoDataTipo = (dtemissao, dtrecebimento, dtvencimento);
  IPIXPDV_Parametros = interface
  ['{52575BCC-E5F9-455C-ABEA-740806C1A7F8}']
    function getCNPJ: TipoWideStringFramework;
    function getDataFim: TDate;
    function getDataInicio: TDate;
    function getDataTipo: TResumoDataTipo;
    function getId: TipoWideStringFramework;
    function getMensagem: TipoWideStringFramework;
    function getSecretKey: TipoWideStringFramework;
    function getTempo: Integer;
    function getToken: TipoWideStringFramework;
    function getValor: Extended;

    procedure setCNPJ(const Value: TipoWideStringFramework);
    procedure setDataFim(const Value: TDate);
    procedure setDataInicio(const Value: TDate);
    procedure setDataTipo(const Value: TResumoDataTipo);
    procedure setId(const Value: TipoWideStringFramework);
    procedure setMensagem(const Value: TipoWideStringFramework);
    procedure setSecretkey(const Value: TipoWideStringFramework);
    procedure setTempo(const Value: Integer);
    procedure setToken(const Value: TipoWideStringFramework);
    procedure setValor(const Value: Extended);

    procedure setDocumento(const value: TipoWideStringFramework);
    function getDocumento: TipoWideStringFramework;

    procedure setPagador_Nome(const value: TipoWideStringFramework);
    function getPagador_Nome: TipoWideStringFramework;

    procedure setPagador_Cpf_Cnpj(const value: TipoWideStringFramework);
    function getPagador_Cpf_Cnpj: TipoWideStringFramework;

    procedure setPagador_Endereco(const value: TipoWideStringFramework);
    function getPagador_Endereco: TipoWideStringFramework;

    procedure setPagador_Cidade(const value: TipoWideStringFramework);
    function getPagador_Cidade: TipoWideStringFramework;

    procedure setPagador_Estado(const value: TipoWideStringFramework);
    function getPagador_Estado: TipoWideStringFramework;

    procedure setPagador_CEP(const value: TipoWideStringFramework);
    function getPagador_CEP: TipoWideStringFramework;

    procedure setVencimento(const value: TDate);
    function getVencimento: TDate;

    procedure setDesconto_Data(const value: TDate);
    function getDesconto_Data: TDate;

    procedure setMulta_Valor(const value: Extended);
    function getMulta_Valor: Extended;

    procedure setDesconto_Valor(const value: Extended);
    function getDesconto_Valor: Extended;

    procedure setJuros_Valor(const value: Extended);
    function getJuros_Valor: Extended;

    procedure setJuros_Tipo(const value: Integer);
    function getJuros_Tipo: Integer;

    procedure setMulta_Tipo(const value: Integer);
    function getMulta_Tipo: Integer;

    procedure setDesconto_Tipo(const value: Integer);
    function getDesconto_Tipo: Integer;

    procedure setExpira(const value: Integer);
    function getExpira: Integer;

    property cnpj: TipoWideStringFramework read getCNPJ write setCNPJ;
    property token: TipoWideStringFramework read getToken write setToken;
    property secretKey: TipoWideStringFramework read getSecretKey write setSecretkey;
    property mensagem: TipoWideStringFramework read getMensagem write setMensagem;
    property id: TipoWideStringFramework read getId write setId;
    property valor: Extended read getValor write setValor;
    property tempo: Integer read getTempo write setTempo;
    property dataInicio: TDate read getDataInicio write setDataInicio;
    property dataFim: TDate read getDataFim write setDataFim;
    property dataTipo: TResumoDataTipo read getDataTipo write setDataTipo;
    property documento: TipoWideStringFramework read getDocumento write setDocumento;
    property pagador_Nome: TipoWideStringFramework read getPagador_Nome write setPagador_Nome;
    property pagador_Cpf_Cnpj: TipoWideStringFramework read getPagador_Cpf_Cnpj write setPagador_Cpf_Cnpj;
    property pagador_Endereco: TipoWideStringFramework read getPagador_Endereco write setPagador_Endereco;
    property pagador_Cidade: TipoWideStringFramework read getPagador_Cidade write setPagador_Cidade;
    property pagador_Estado: TipoWideStringFramework read getPagador_Estado write setPagador_Estado;
    property pagador_CEP: TipoWideStringFramework read getPagador_CEP write setPagador_CEP;
    property vencimento: TDate read getVencimento write setVencimento;
    property desconto_Data: TDate read getDesconto_Data write setDesconto_Data;
    property multa_Valor: Extended read getMulta_Valor write setMulta_Valor;
    property desconto_Valor: Extended read getDesconto_Valor write setDesconto_Valor;
    property juros_Valor: Extended read getJuros_Valor write setJuros_Valor;
    property juros_Tipo: Integer read getJuros_Tipo write setJuros_Tipo;
    property multa_Tipo: Integer read getMulta_Tipo write setMulta_Tipo;
    property desconto_Tipo: Integer read getDesconto_Tipo write setDesconto_Tipo;
    property expira: Integer read getExpira write setExpira;
  end;


{  TParametrosPixCobranca = record
    CNPJ,
    Token,
    SecretKey,
    Mensagem,
    Documento,
    Pagador_Nome,
    Pagador_Cpf_Cnpj,
    Pagador_Endereco,
    Pagador_Cidade,
    Pagador_Estado,
    Pagador_CEP: TipoWideStringFramework;
    Vencimento,
    Desconto_Data: TDate;
    Multa_Valor,
    Desconto_Valor,
    Valor,
    Juros_Valor: Extended;
    Juros_Tipo,
    Multa_Tipo,
    Desconto_Tipo,
    Expira: Integer;
  end;}



  IPIXPDV_RetornoGenericoPix = interface
  ['{5DBE5303-4E23-4ECD-AA9B-1F1E92796D23}']
    function getEndToEndId: TipoWideStringFramework;
    function getErro: TipoWideStringFramework;
    function getIdentificadorId: TipoWideStringFramework;
    function getTransacaoId: TipoWideStringFramework;
    function getSender_Cpf_Cnpj: TipoWideStringFramework;
    function getData: TDateTime;
    function getSender_Nome: TipoWideStringFramework;
    function getTransacaoTipo:TipoWideStringFramework;
    function getValor: Extended;
    function getStatus: TipoWideStringFramework;
    function getExpired_Data:TDateTime;
    function getTipo:TipoWideStringFramework;
    function getDescricao:TipoWideStringFramework;
    function getDados:TipoWideStringFramework;
    function getSaldoTotal:Extended;
    function getSaldoDisponivel:Extended;
    function getSaldoBloqueado:Extended;
    function getPspId:TipoWideStringFramework;
    function getPspNome:TipoWideStringFramework;
    function getAgencia: TipoWideStringFramework;

    procedure setEndToEnd(const Value: TipoWideStringFramework);
    procedure setErro(const Value: TipoWideStringFramework);
    procedure setIdentificadorId(const Value: TipoWideStringFramework);
    procedure setTransacaoId(const Value: TipoWideStringFramework);
    procedure setSatus(const Value: TipoWideStringFramework);
    procedure setSender_Cpf_Cnpj(const Value: TipoWideStringFramework);
    procedure setData(const Value: TDateTime);
    procedure setSender_Nome(const Value: TipoWideStringFramework);
    procedure setTransacaoTipo(const Value: TipoWideStringFramework);
    procedure setValor(const Value: Extended);
    procedure setExpired_Data(const Value: TDateTime);
    procedure setTipo(const Value: TipoWideStringFramework);
    procedure setDescricao(const Value: TipoWideStringFramework);
    procedure setDados(const Value: TipoWideStringFramework);
    procedure setSaldoTotal(const Value: Extended);
    procedure setSaldoDisponivel(const Value: Extended);
    procedure setSaldoBloqueado(const Value: Extended);
    procedure setPspId(const Value: TipoWideStringFramework);
    procedure setPspNome(const Value: TipoWideStringFramework);
    procedure setAgencia(const Value: TipoWideStringFramework);

    procedure setContaNome(const value: TipoWideStringFramework);
    function getContaNome: TipoWideStringFramework;

    procedure setContaTipo(const value: TipoWideStringFramework);
    function getContaTipo: TipoWideStringFramework;

    procedure setConta(const value: TipoWideStringFramework);
    function getConta: TipoWideStringFramework;

    procedure setUrl(const value: TipoWideStringFramework);
    function getUrl: TipoWideStringFramework;

    property erro: TipoWideStringFramework read getErro write setErro;
    property status:  TipoWideStringFramework read getStatus write setSatus;
    property endToEndId: TipoWideStringFramework read getEndToEndId write setEndToEnd;
    property transacaoId: TipoWideStringFramework read getTransacaoId write setTransacaoId;
    property identificadorId: TipoWideStringFramework read getIdentificadorId write setIdentificadorId;
    property transacaoTipo: TipoWideStringFramework read getTransacaoTipo write setTransacaoTipo;
    property tipo: TipoWideStringFramework read getTipo write setTipo;
    property sender_Nome: TipoWideStringFramework read getSender_Nome write setSender_Nome;
    property sender_Cpf_Cnpj: TipoWideStringFramework read getSender_Cpf_Cnpj write setSender_Cpf_Cnpj;
    property data: TDateTime read getData write setData;
    property valor: Extended read getValor write setValor;
    property expired_Data: TDateTime read getExpired_Data write setExpired_Data;
    property descricao: TipoWideStringFramework read getDescricao write setDescricao;
    property dados: TipoWideStringFramework read getDados write setDados;

    property saldoTotal: Extended read getSaldoTotal write setSaldoTotal;
    property saldoDisponivel: Extended read getSaldoDisponivel write setSaldoDisponivel;
    property saldoBloqueado: Extended read getSaldoBloqueado write setSaldoBloqueado;

    property pspId: TipoWideStringFramework read getPspId write setPspId;
    property pspNome: TipoWideStringFramework read getPspNome write setPspNome;
    property agencia: TipoWideStringFramework read getAgencia write setAgencia;
    property conta: TipoWideStringFramework read getConta write setConta;
    property contaNome: TipoWideStringFramework read getContaNome write setContaNome;
    property contaTipo: TipoWideStringFramework read getContaTipo write setContaTipo;

    property url: TipoWideStringFramework read getUrl write setUrl;


  end;

  TListaRetornoGenericoPix = IListaSimples<IPIXPDV_RetornoGenericoPix>;

  IPixPdv = interface
  ['{1FD72F71-FC4C-473E-9F4D-F364F9CFFCAB}']
      function GerarPixCobranca(pParametros: IPIXPDV_Parametros): IPIXPDV_RetornoGenericoPix; stdcall;
      function ConsultaPixIndividual(pParametros: IPIXPDV_Parametros): IPIXPDV_RetornoGenericoPix; stdcall;
      function ConsultaPixLote(pParametros: IPIXPDV_Parametros): TListaRetornoGenericoPix; stdcall;
      function Saldo(pParametros: IPIXPDV_Parametros): IPIXPDV_RetornoGenericoPix; stdcall;
      function Retirada(pParametros: IPIXPDV_Parametros): IPIXPDV_RetornoGenericoPix; stdcall;
      function Extrato(pParametros: IPIXPDV_Parametros): TListaRetornoGenericoPix; stdcall;
      function gerarPIX(pParametros: IPIXPDV_Parametros): IPIXPDV_RetornoGenericoPix; stdcall;
      function ConsultarPIX(pParametros: IPIXPDV_Parametros): TipoWideStringFramework; stdcall;
      procedure recria(pParametros: IPIXPDV_Parametros);
  end;

  {$if not defined(__DLL__)}
    function createPIXPDV(pParametros: IPIXPDV_Parametros): IPixPdv; stdcall;
  {$ifend}

  function getIPIXPDV_RetornoGenericoPix(iface: IUnknown=nil): IPIXPDV_RetornoGenericoPix;
  function getIPIXPDV_Parametros(iface: IUnknown=nil): IPIXPDV_Parametros;

implementation
  {$if not defined(__DLL__)}
    function createPIXPDV(pParametros: IPIXPDV_Parametros): IPixPdv; stdcall; external 'PIXPDV_DLL' name 'createPIXPDV' delayed;
  {$ifend}
  type
    TPIXPDV_RetornoGenericoPix = class(TInterfacedObject, IPIXPDV_RetornoGenericoPix)
    protected
      fErro,
      fStatus,
      fEndToEndId,
      fIdentificadorId,
      fSender_Nome,
      fTransacaoTipo,
      fTransacaoId,
      fTipo,
      fDescricao,
      fDados,
      fPspId,
      fPspNome,
      fAgencia,
      fConta,
      fContaNome,
      fContaTipo,
      fURL,
      fSender_Cpf_Cnpj: TipoWideStringFramework;
      fData, fExpired_Data: TDateTime;
      fSaldoBloqueado,fSaldoDisponivel,fSaldoTotal,fValor: Extended;
      function getDados:TipoWideStringFramework;
      function getTRansacaoId: TipoWideStringFramework;
      function getEndToEndId: TipoWideStringFramework;
      function getErro: TipoWideStringFramework;
      function getIdentificadorId: TipoWideStringFramework;
      function getSender_Cpf_Cnpj: TipoWideStringFramework;
      function getData: TDateTime;
      function getTransacaoTipo:TipoWideStringFramework;
      function getSender_Nome: TipoWideStringFramework;
      function getValor: Extended;
      function getStatus: TipoWideStringFramework;
      function getExpired_Data:TDateTime;
      function getTipo:TipoWideStringFramework;
      function getDescricao:TipoWideStringFramework;
      function getSaldoTotal:Extended;
      function getSaldoDisponivel:Extended;
      function getSaldoBloqueado:Extended;
      function getPspId:TipoWideStringFramework;
      function getPspNome:TipoWideStringFramework;
      function getAgencia: TipoWideStringFramework;

      procedure setTransacaoId(const Value: TipoWideStringFramework);
      procedure setExpired_Data(const Value: TDateTime);
      procedure setEndToEnd(const Value: TipoWideStringFramework);
      procedure setErro(const Value: TipoWideStringFramework);
      procedure setIdentificadorId(const Value: TipoWideStringFramework);
      procedure setTipo(const Value: TipoWideStringFramework);
      procedure setSatus(const Value: TipoWideStringFramework);
      procedure setSender_Cpf_Cnpj(const Value: TipoWideStringFramework);
      procedure setData(const Value: TDateTime);
      procedure setSender_Nome(const Value: TipoWideStringFramework);
      procedure setTransacaoTipo(const Value: TipoWideStringFramework);
      procedure setValor(const Value: Extended);
      procedure setDescricao(const Value: TipoWideStringFramework);
      procedure setDados(const Value: TipoWideStringFramework);
      procedure setSaldoTotal(const Value: Extended);
      procedure setSaldoDisponivel(const Value: Extended);
      procedure setSaldoBloqueado(const Value: Extended);
      procedure setPspId(const Value: TipoWideStringFramework);
      procedure setPspNome(const Value: TipoWideStringFramework);
      procedure setAgencia(const Value: TipoWideStringFramework);

      procedure setContaNome(const value: TipoWideStringFramework);
      function getContaNome: TipoWideStringFramework;

      procedure setContaTipo(const value: TipoWideStringFramework);
      function getContaTipo: TipoWideStringFramework;

      procedure setConta(const value: TipoWideStringFramework);
      function getConta: TipoWideStringFramework;

      procedure setUrl(const value: TipoWideStringFramework);
      function getUrl: TipoWideStringFramework;

    end;

    TPIXPDV_Parametros = class(TInterfacedObject, IPIXPDV_Parametros)
    protected
      fCNPJ,
      fToken,
      fSecretKey,
      fMensagem,
      fDocumento,
      fPagador_Nome,
      fPagador_Cpf_Cnpj,
      fPagador_Endereco,
      fPagador_Cidade,
      fPagador_Estado,
      fPagador_CEP,
      fId: TipoWideStringFramework;

      fMulta_Valor,
      fDesconto_Valor,
      fJuros_Valor,
      fValor: Extended;

      fJuros_Tipo,
      fMulta_Tipo,
      fDesconto_Tipo,
      fExpira,
      fTempo: Integer;

      fDesconto_Data,
      fVencimento,
      fDataInicio,
      fDataFim: TDate;

      fDataTipo: TResumoDataTipo;

      function getCNPJ: TipoWideStringFramework;
      function getDataFim: TDate;
      function getDataInicio: TDate;
      function getDataTipo: TResumoDataTipo;
      function getId: TipoWideStringFramework;
      function getMensagem: TipoWideStringFramework;
      function getSecretKey: TipoWideStringFramework;
      function getTempo: Integer;
      function getToken: TipoWideStringFramework;
      function getValor: Extended;

      procedure setCNPJ(const Value: TipoWideStringFramework);
      procedure setDataFim(const Value: TDate);
      procedure setDataInicio(const Value: TDate);
      procedure setDataTipo(const Value: TResumoDataTipo);
      procedure setId(const Value: TipoWideStringFramework);
      procedure setMensagem(const Value: TipoWideStringFramework);
      procedure setSecretkey(const Value: TipoWideStringFramework);
      procedure setTempo(const Value: Integer);
      procedure setToken(const Value: TipoWideStringFramework);
      procedure setValor(const Value: Extended);

      procedure setDocumento(const value: TipoWideStringFramework);
      function getDocumento: TipoWideStringFramework;

      procedure setPagador_Nome(const value: TipoWideStringFramework);
      function getPagador_Nome: TipoWideStringFramework;

      procedure setPagador_Cpf_Cnpj(const value: TipoWideStringFramework);
      function getPagador_Cpf_Cnpj: TipoWideStringFramework;

      procedure setPagador_Endereco(const value: TipoWideStringFramework);
      function getPagador_Endereco: TipoWideStringFramework;

      procedure setPagador_Cidade(const value: TipoWideStringFramework);
      function getPagador_Cidade: TipoWideStringFramework;

      procedure setPagador_Estado(const value: TipoWideStringFramework);
      function getPagador_Estado: TipoWideStringFramework;

      procedure setPagador_CEP(const value: TipoWideStringFramework);
      function getPagador_CEP: TipoWideStringFramework;

      procedure setVencimento(const value: TDate);
      function getVencimento: TDate;

      procedure setDesconto_Data(const value: TDate);
      function getDesconto_Data: TDate;

      procedure setMulta_Valor(const value: Extended);
      function getMulta_Valor: Extended;

      procedure setDesconto_Valor(const value: Extended);
      function getDesconto_Valor: Extended;

      procedure setJuros_Valor(const value: Extended);
      function getJuros_Valor: Extended;

      procedure setJuros_Tipo(const value: Integer);
      function getJuros_Tipo: Integer;

      procedure setMulta_Tipo(const value: Integer);
      function getMulta_Tipo: Integer;

      procedure setDesconto_Tipo(const value: Integer);
      function getDesconto_Tipo: Integer;

      procedure setExpira(const value: Integer);
      function getExpira: Integer;

    end;

function getIPIXPDV_RetornoGenericoPix(iface: IUnknown=nil): IPIXPDV_RetornoGenericoPix;
begin
  if not Supports(iface,IPIXPDV_RetornoGenericoPix,Result) then
    Result := TPIXPDV_RetornoGenericoPix.Create;
end;

function getIPIXPDV_Parametros(iface: IUnknown=nil): IPIXPDV_Parametros;
begin
  if not Supports(iface,IPIXPDV_Parametros,Result) then
    Result := TPIXPDV_Parametros.Create;
end;

{ TPIXPDV_RetornoConsultaPixIndividual }

function TPIXPDV_RetornoGenericoPix.getDescricao: TipoWideStringFramework;
begin
  Result := fDescricao;
end;

function TPIXPDV_RetornoGenericoPix.getEndToEndId: TipoWideStringFramework;
begin
  Result := fEndToEndId;
end;

function TPIXPDV_RetornoGenericoPix.getErro: TipoWideStringFramework;
begin
  Result := fErro;
end;

function TPIXPDV_RetornoGenericoPix.getExpired_Data: TDateTime;
begin
  Result := fExpired_Data;
end;

function TPIXPDV_RetornoGenericoPix.getIdentificadorId: TipoWideStringFramework;
begin
  Result := fIdentificadorId;
end;

function TPIXPDV_RetornoGenericoPix.getPspId: TipoWideStringFramework;
begin
  Result := fPspId;
end;

function TPIXPDV_RetornoGenericoPix.getPspNome: TipoWideStringFramework;
begin
  Result := fPspNome;
end;

function TPIXPDV_RetornoGenericoPix.getSaldoBloqueado: Extended;
begin
  Result := fSaldoBloqueado
end;

function TPIXPDV_RetornoGenericoPix.getSaldoDisponivel: Extended;
begin
  Result := fSaldoDisponivel;
end;

function TPIXPDV_RetornoGenericoPix.getSaldoTotal: Extended;
begin
  Result := fSaldoTotal;
end;

function TPIXPDV_RetornoGenericoPix.getSender_Cpf_Cnpj: TipoWideStringFramework;
begin
  Result := fSender_Cpf_Cnpj;
end;

function TPIXPDV_RetornoGenericoPix.getAgencia: TipoWideStringFramework;
begin
  Result := fAgencia;
end;

function TPIXPDV_RetornoGenericoPix.getDados: TipoWideStringFramework;
begin
  Result := fDados;
end;

function TPIXPDV_RetornoGenericoPix.getData: TDateTime;
begin
  Result := fData;
end;


function TPIXPDV_RetornoGenericoPix.getSender_Nome: TipoWideStringFramework;
begin
  Result := fSender_Nome;
end;


function TPIXPDV_RetornoGenericoPix.getValor: Extended;
begin
  Result := fValor;
end;

function TPIXPDV_RetornoGenericoPix.getStatus: TipoWideStringFramework;
begin
  Result := fStatus;
end;

function TPIXPDV_RetornoGenericoPix.getTipo: TipoWideStringFramework;
begin
  Result := fTipo;
end;

function TPIXPDV_RetornoGenericoPix.getTRansacaoId: TipoWideStringFramework;
begin
  Result := fTransacaoId;
end;

function TPIXPDV_RetornoGenericoPix.getTransacaoTipo: TipoWideStringFramework;
begin
  Result := fTransacaoTipo;
end;

procedure TPIXPDV_RetornoGenericoPix.setEndToEnd(
  const Value: TipoWideStringFramework);
begin
  fEndToEndId := value;
end;

procedure TPIXPDV_RetornoGenericoPix.setErro(
  const Value: TipoWideStringFramework);
begin
  fErro := value;
end;

procedure TPIXPDV_RetornoGenericoPix.setExpired_Data(const Value: TDateTime);
begin
  fExpired_Data := value;
end;

procedure TPIXPDV_RetornoGenericoPix.setIdentificadorId(
  const Value: TipoWideStringFramework);
begin
  fIdentificadorId := value;
end;

procedure TPIXPDV_RetornoGenericoPix.setPspId(
  const Value: TipoWideStringFramework);
begin
  fPspId := value;
end;

procedure TPIXPDV_RetornoGenericoPix.setPspNome(
  const Value: TipoWideStringFramework);
begin
  fPspNome := value;
end;

procedure TPIXPDV_RetornoGenericoPix.setSaldoBloqueado(const Value: Extended);
begin
  fSaldoBloqueado := value;
end;

procedure TPIXPDV_RetornoGenericoPix.setSaldoDisponivel(const Value: Extended);
begin
  fSaldoDisponivel := value;
end;

procedure TPIXPDV_RetornoGenericoPix.setSaldoTotal(const Value: Extended);
begin
  fSaldoTotal := value;
end;

procedure TPIXPDV_RetornoGenericoPix.setSatus(
  const Value: TipoWideStringFramework);
begin
  fStatus := Value;
end;

procedure TPIXPDV_RetornoGenericoPix.setSender_Cpf_Cnpj(
  const Value: TipoWideStringFramework);
begin
  fSender_Cpf_Cnpj := value;
end;

procedure TPIXPDV_RetornoGenericoPix.setAgencia(
  const Value: TipoWideStringFramework);
begin
  fAgencia := value;
end;

procedure TPIXPDV_RetornoGenericoPix.setContaNome(const value: TipoWideStringFramework);
begin
   fContaNome := value;
end;

function TPIXPDV_RetornoGenericoPix.getContaNome: TipoWideStringFramework;
begin
   Result := fContaNome;
end;

procedure TPIXPDV_RetornoGenericoPix.setContaTipo(const value: TipoWideStringFramework);
begin
   fContaTipo := value;
end;

function TPIXPDV_RetornoGenericoPix.getContaTipo: TipoWideStringFramework;
begin
   Result := fContaTipo;
end;

procedure TPIXPDV_RetornoGenericoPix.setConta(const value: TipoWideStringFramework);
begin
   fConta := value;
end;

function TPIXPDV_RetornoGenericoPix.getConta: TipoWideStringFramework;
begin
   Result := fConta;
end;

procedure TPIXPDV_RetornoGenericoPix.setUrl(const value: TipoWideStringFramework);
begin
   fUrl := value;
end;

function TPIXPDV_RetornoGenericoPix.getUrl: TipoWideStringFramework;
begin
   Result := fUrl;
end;

procedure TPIXPDV_RetornoGenericoPix.setDados(
  const Value: TipoWideStringFramework);
begin
  fDados := value;
end;

procedure TPIXPDV_RetornoGenericoPix.setData(
  const Value: TDateTime);
begin
  fData := value;
end;

procedure TPIXPDV_RetornoGenericoPix.setDescricao(
  const Value: TipoWideStringFramework);
begin
  fDescricao := value;
end;

procedure TPIXPDV_RetornoGenericoPix.setSender_Nome(
  const Value: TipoWideStringFramework);
begin
  fSender_Nome := value;
end;

procedure TPIXPDV_RetornoGenericoPix.setValor(
  const Value: Extended);
begin
    fValor := value;
end;

procedure TPIXPDV_RetornoGenericoPix.setTipo(
  const Value: TipoWideStringFramework);
begin
  fTipo := value;
end;

procedure TPIXPDV_RetornoGenericoPix.setTransacaoId(
  const Value: TipoWideStringFramework);
begin
  fTransacaoId := value;
end;

procedure TPIXPDV_RetornoGenericoPix.setTransacaoTipo(
  const Value: TipoWideStringFramework);
begin
  fTransacaoTipo := value;
end;

{ TPIXPDV_Parametros }

function TPIXPDV_Parametros.getCNPJ: TipoWideStringFramework;
begin
  Result := fCNPJ;
end;

function TPIXPDV_Parametros.getDataFim: TDate;
begin
  Result := fDataFim;
end;

function TPIXPDV_Parametros.getDataInicio: TDate;
begin
  Result := fDataInicio;
end;

function TPIXPDV_Parametros.getDataTipo: TResumoDataTipo;
begin
  Result := fDataTipo;
end;

function TPIXPDV_Parametros.getId: TipoWideStringFramework;
begin
  Result := fId;
end;

function TPIXPDV_Parametros.getMensagem: TipoWideStringFramework;
begin
  Result := fMensagem;
end;

function TPIXPDV_Parametros.getSecretKey: TipoWideStringFramework;
begin
  Result := fSecretKey;
end;

function TPIXPDV_Parametros.getTempo: Integer;
begin
  Result := fTempo;
end;

function TPIXPDV_Parametros.getToken: TipoWideStringFramework;
begin
  Result := fToken;
end;

function TPIXPDV_Parametros.getValor: Extended;
begin
  Result := fValor;
end;

procedure TPIXPDV_Parametros.setCNPJ(const Value: TipoWideStringFramework);
begin
  fCNPJ := value;
end;

procedure TPIXPDV_Parametros.setDataFim(const Value: TDate);
begin
  fDataFim := value;
end;

procedure TPIXPDV_Parametros.setDataInicio(const Value: TDate);
begin
  fDataInicio := value;
end;

procedure TPIXPDV_Parametros.setDataTipo(const Value: TResumoDataTipo);
begin
  fDataTipo := value;
end;

procedure TPIXPDV_Parametros.setId(const Value: TipoWideStringFramework);
begin
  fId := value;
end;

procedure TPIXPDV_Parametros.setMensagem(const Value: TipoWideStringFramework);
begin
  fMensagem := value;
end;

procedure TPIXPDV_Parametros.setSecretkey(const Value: TipoWideStringFramework);
begin
  fSecretKey := value;
end;

procedure TPIXPDV_Parametros.setTempo(const Value: Integer);
begin
  fTempo := value;
end;

procedure TPIXPDV_Parametros.setToken(const Value: TipoWideStringFramework);
begin
  fToken := value;
end;

procedure TPIXPDV_Parametros.setValor(const Value: Extended);
begin
  fValor := value;
end;

procedure TPIXPDV_Parametros.setDocumento(const value: TipoWideStringFramework);
begin
   fDocumento := value;
end;

function TPIXPDV_Parametros.getDocumento: TipoWideStringFramework;
begin
   Result := fDocumento;
end;

procedure TPIXPDV_Parametros.setPagador_Nome(const value: TipoWideStringFramework);
begin
   fPagador_Nome := value;
end;

function TPIXPDV_Parametros.getPagador_Nome: TipoWideStringFramework;
begin
   Result := fPagador_Nome;
end;

procedure TPIXPDV_Parametros.setPagador_Cpf_Cnpj(const value: TipoWideStringFramework);
begin
   fPagador_Cpf_Cnpj := value;
end;

function TPIXPDV_Parametros.getPagador_Cpf_Cnpj: TipoWideStringFramework;
begin
   Result := fPagador_Cpf_Cnpj;
end;

procedure TPIXPDV_Parametros.setPagador_Endereco(const value: TipoWideStringFramework);
begin
   fPagador_Endereco := value;
end;

function TPIXPDV_Parametros.getPagador_Endereco: TipoWideStringFramework;
begin
   Result := fPagador_Endereco;
end;

procedure TPIXPDV_Parametros.setPagador_Cidade(const value: TipoWideStringFramework);
begin
   fPagador_Cidade := value;
end;

function TPIXPDV_Parametros.getPagador_Cidade: TipoWideStringFramework;
begin
   Result := fPagador_Cidade;
end;

procedure TPIXPDV_Parametros.setPagador_Estado(const value: TipoWideStringFramework);
begin
   fPagador_Estado := value;
end;

function TPIXPDV_Parametros.getPagador_Estado: TipoWideStringFramework;
begin
   Result := fPagador_Estado;
end;

procedure TPIXPDV_Parametros.setPagador_CEP(const value: TipoWideStringFramework);
begin
   fPagador_CEP := value;
end;

function TPIXPDV_Parametros.getPagador_CEP: TipoWideStringFramework;
begin
   Result := fPagador_CEP;
end;

procedure TPIXPDV_Parametros.setVencimento(const value: TDate);
begin
   fVencimento := value;
end;

function TPIXPDV_Parametros.getVencimento: TDate;
begin
   Result := fVencimento;
end;

procedure TPIXPDV_Parametros.setDesconto_Data(const value: TDate);
begin
   fDesconto_Data := value;
end;

function TPIXPDV_Parametros.getDesconto_Data: TDate;
begin
   Result := fDesconto_Data;
end;

procedure TPIXPDV_Parametros.setMulta_Valor(const value: Extended);
begin
   fMulta_Valor := value;
end;

function TPIXPDV_Parametros.getMulta_Valor: Extended;
begin
   Result := fMulta_Valor;
end;

procedure TPIXPDV_Parametros.setDesconto_Valor(const value: Extended);
begin
   fDesconto_Valor := value;
end;

function TPIXPDV_Parametros.getDesconto_Valor: Extended;
begin
   Result := fDesconto_Valor;
end;

procedure TPIXPDV_Parametros.setJuros_Valor(const value: Extended);
begin
   fJuros_Valor := value;
end;

function TPIXPDV_Parametros.getJuros_Valor: Extended;
begin
   Result := fJuros_Valor;
end;

procedure TPIXPDV_Parametros.setJuros_Tipo(const value: Integer);
begin
   fJuros_Tipo := value;
end;

function TPIXPDV_Parametros.getJuros_Tipo: Integer;
begin
   Result := fJuros_Tipo;
end;

procedure TPIXPDV_Parametros.setMulta_Tipo(const value: Integer);
begin
   fMulta_Tipo := value;
end;

function TPIXPDV_Parametros.getMulta_Tipo: Integer;
begin
   Result := fMulta_Tipo;
end;

procedure TPIXPDV_Parametros.setDesconto_Tipo(const value: Integer);
begin
   fDesconto_Tipo := value;
end;

function TPIXPDV_Parametros.getDesconto_Tipo: Integer;
begin
   Result := fDesconto_Tipo;
end;

procedure TPIXPDV_Parametros.setExpira(const value: Integer);
begin
   fExpira := value;
end;

function TPIXPDV_Parametros.getExpira: Integer;
begin
   Result := fExpira;
end;

end.
