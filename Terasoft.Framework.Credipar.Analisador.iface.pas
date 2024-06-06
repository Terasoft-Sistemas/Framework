
{$i Credipar.inc}

unit Terasoft.Framework.Credipar.Analisador.iface;

interface
  uses
    Terasoft.Framework.Types;

  type
    ICredipar_Proposta = interface
    ['{7BFA61DA-E339-44BB-9AE1-BCDD55FBDF47}']

    //property proposta getter/setter
      procedure setProposta(const pValue: TipoWideStringFramework);
      function getProposta: TipoWideStringFramework;

    //property loja getter/setter
      function getLoja: Integer;
      procedure setLoja(const pValue: Integer);

    //property qt_parcela getter/setter
      function getQt_parcela: Integer;
      procedure setQt_parcela(const pValue: Integer);

    //property cd_pedido getter/setter
      function getCd_pedido: Integer;
      procedure setCd_pedido(const pValue: Integer);

    //property idtabela getter/setter
      function getIdtabela: Integer;
      procedure setIdtabela(const pValue: Integer);

    //property cd_tipo_financ getter/setter
      function getCd_tipo_financ: Integer;
      procedure setCd_tipo_financ(const pValue: Integer);

    //property id_lj_tabela getter/setter
      function getId_lj_tabela: Integer;
      procedure setId_lj_tabela(const pValue: Integer);

    //property cd_empresa getter/setter
      function getCd_empresa: Integer;
      procedure setCd_empresa(const pValue: Integer);

      property cd_empresa: Integer read getCd_empresa write setCd_empresa;
      property id_lj_tabela: Integer read getId_lj_tabela write setId_lj_tabela;
      property cd_tipo_financ: Integer read getCd_tipo_financ write setCd_tipo_financ;
      property idtabela: Integer read getIdtabela write setIdtabela;
      property cd_pedido: Integer read getCd_pedido write setCd_pedido;
      property qt_parcela: Integer read getQt_parcela write setQt_parcela;
      property loja: Integer read getLoja write setLoja;
      property proposta: TipoWideStringFramework read getProposta write setProposta;


    end;

implementation

end.
