unit Terasoft.PIX.Types;

interface

  uses
    SysUtils,Classes,
    Terasoft.Framework.SimpleTypes,
    Terasoft.Framework.ListaSimples;

type

  TResumoDataTipo = (dtemissao, dtrecebimento, dtvencimento);

  TRetornoConsultaPixIndividual = record
    erro: TipoWideStringFramework;
    Status,
    EndToEndId,
    IdentificadorId,
    Sender_Nome,
    Sender_Cpf_Cnpj: TipoWideStringFramework;
    Sender_Data: TDate;
    Sender_Valor: Real;
  end;

  TRetornoConsultaPixLote = record
    erro: TipoWideStringFramework;
    TransacaoId,
    TransacaoTipo,
    Status,
    EndToEndId,
    IdentificadorId,
    Sender_Nome,
    Sender_Cpf_Cnpj: TipoWideStringFramework;
    Sender_Data,
    Expired_Data: TDate;
    Sender_Valor: Real;
  end;

  TListaRetornoConsultaPixLote = IListaSimples<TRetornoConsultaPixLote>;

  TRetornoExtrato = record
    erro: TipoWideStringFramework;
    valido: boolean;
    TransacaoId,
    TransacaoTipo,
    Descricao,
    Data,
    Valor,
    Tipo: Variant;
  end;

  TListaRetornoExtrato = IListaSimples<TRetornoExtrato>;

  TRetornoPixRecebimento = record
     erro  : TipoWideStringFramework;
     valido: boolean;
     id,
     data  : TipoWideStringFramework;
  end;

  TRetornoSaldo = record
    erro: TipoWideStringFramework;
    SaldoTotal,
    SaldoDisponivel,
    SaldoBloqueado: Real;
  end;

  TRetornoRetirada = record
    erro  : TipoWideStringFramework;
    valido: boolean;
    TransacaoId,
    EndToEndId,
    PspId,
    PspNome,
    Agencia,
    Conta,
    ContaNome,
    ContaTipo: TipoWideStringFramework;
  end;

  TRetornoPixCobranca = record
     erro,
     id,
     URL,
     data : TipoWideStringFramework;
  end;

  TParametros = record
     CNPJ,
     Token,
     SecretKey,
     Mensagem,
     ID         : TipoWideStringFramework;
     Valor      : Real;
     Tempo      : Integer;
     DataInicio,
     DataFim    : TDate;
     DataTipo   : TResumoDataTipo;
  end;

  TParametrosPixCobranca = record
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
    Juros_Valor: Real;
    Juros_Tipo,
    Multa_Tipo,
    Desconto_Tipo,
    Expira: Integer;
  end;


  IPixPdv = interface
  ['{1FD72F71-FC4C-473E-9F4D-F364F9CFFCAB}']
      function GerarPixCobranca(pParametros: TParametrosPixCobranca): TRetornoPixCobranca; stdcall;
      function ConsultaPixIndividual(pParametros: TParametros):TRetornoConsultaPixIndividual; stdcall;
      function ConsultaPixLote(pParametros: TParametros): TListaRetornoConsultaPixLote; stdcall;
      function Saldo(pParametros: TParametros): TRetornoSaldo; stdcall;
      function Retirada(pParametros: TParametros): TRetornoRetirada; stdcall;
      function Extrato(pParametros: TParametros): TListaRetornoExtrato; stdcall;
      function gerarPIX(pParametros: TParametros): TRetornoPixRecebimento; stdcall;
      function ConsultarPIX(pParametros: TParametros): TipoWideStringFramework; stdcall;
      procedure recria(pParametros: TParametrosPixCobranca);
  end;

  {$if not defined(__DLL__)}
    function createPIXPDV(pParametros: TParametros): IPixPdv; stdcall;
  {$ifend}



implementation


  {$if not defined(__DLL__)}
    function createPIXPDV(pParametros: TParametros): IPixPdv; stdcall; external 'PIXPDV_DLL' name 'createPIXPDV' delayed;
  {$ifend}

end.
