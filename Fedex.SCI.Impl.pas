
{$i definicoes.inc}

unit Fedex.SCI.Impl;

interface
  uses
    Terasoft.Framework.Types,
    Fedex.API.Iface;

  function criaFedexApiSCI: IFedexAPI;

implementation
  uses
    FuncoesConfig;

function criaFedexApiSCI: IFedexAPI;
  var
    fedex: IFedexAPI;
begin
  fedex := createFedexAPI;
  fedex.parameters.modoProducao := true;
  fedex.parameters.urlWS := 'https://internet.rapidaocometa.com.br:6060/soap-new?service=WMS10_GENERIC';
  fedex.parameters.diretorioLock := 'c:\temp\Fedex\Lock';
  fedex.parameters.diretorioArquivos := 'c:\temp\Fedex\WMS\';
  fedex.parameters.diretorioLDB := DEF_DIRETORIO_LB;
  fedex.parameters.portaSSH := FEDEX_PORTASSH;
  fedex.parameters.hostSSH := FEDEX_HOSTSSH;
  fedex.parameters.senhaSSH := FEDEX_PASSSSH;
  fedex.parameters.usuarioSSH := FEDEX_USERSSH;
  fedex.parameters.diretorioLDB := FEDEX_PATHSSH;
  fedex.parameters.diretorioLocal := 'c:\temp\Fedex\LDB';


  ForceDirectories(fedex.parameters.diretorioLock);
  depositante := fedex.parameters.depositante;
  depositante.codigo := DEPOSITANTE_MB13;
  depositante.cnpj := '78614278002866';
  depositante.nome := 'COMERCIAL DE MOVEIS BRASILIA LTDA';
  fedex.parameters.depositante.auth.usuario := FEDEX_USUARIO_WMS;
  fedex.parameters.depositante.auth.senha   := FEDEX_SENHA_WMS;
  fedex.parameters.depositante.chave := FEDEX_CHAVE_ACESSO;

  Result := fedex;

end;


end.
