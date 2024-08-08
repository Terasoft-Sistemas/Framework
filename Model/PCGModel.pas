unit PCGModel;

interface

uses
  Terasoft.Types,
  PCGDao,
  FireDAC.Comp.Client,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TPCGModel = class;
  ITPCGModel=IObject<TPCGModel>;

  TPCGModel = class
  private
    [weak] mySelf: ITPCGModel;
    vIConexao : IConexao;
  public

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITPCGModel;

    function ObterVendasResultado1(pPCG_Parametros: TPCG_Parametros): IFDDataset;
    function ObterVendasResultado2(pPCG_Parametros: TPCG_Parametros): IFDDataset;
    function ObterEstoqueResultado1(pPCG_Parametros: TPCG_Parametros): IFDDataset;

  end;

implementation

uses
  System.SysUtils;

{ TPCGModel }

constructor TPCGModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TPCGModel.Destroy;
begin

  inherited;
end;

class function TPCGModel.getNewIface(pIConexao: IConexao): ITPCGModel;
begin
  Result := TImplObjetoOwner<TPCGModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TPCGModel.ObterVendasResultado1(pPCG_Parametros: TPCG_Parametros): IFDDataset;
var
  lPCGDao: ITPCGDao;
  lPCG_Parametros: TPCG_Parametros;
begin
  lPCGDao := TPCGDao.getNewIface(vIConexao);

  try
    lPCG_Parametros.TipoData                := pPCG_Parametros.TipoData;
    lPCG_Parametros.DataInicio              := pPCG_Parametros.DataInicio;
    lPCG_Parametros.DataFim                 := pPCG_Parametros.DataFim;
    lPCG_Parametros.Vendedor                := pPCG_Parametros.Vendedor;
    lPCG_Parametros.Fornecedor              := pPCG_Parametros.Fornecedor;
    lPCG_Parametros.Grupo                   := pPCG_Parametros.Grupo;
    lPCG_Parametros.SubGrupo                := pPCG_Parametros.SubGrupo;
    lPCG_Parametros.Marca                   := pPCG_Parametros.Marca;
    lPCG_Parametros.Tipo                    := pPCG_Parametros.Tipo;
    lPCG_Parametros.Lojas                   := pPCG_Parametros.Lojas;
    lPCG_Parametros.FiliaisPor              := pPCG_Parametros.FiliaisPor;
    lPCG_Parametros.TipoAnalise             := pPCG_Parametros.TipoAnalise;
    lPCG_Parametros.SomarST                 := pPCG_Parametros.SomarST;
    lPCG_Parametros.SomarACrescimo          := pPCG_Parametros.SomarACrescimo;
    lPCG_Parametros.SomarIPI                := pPCG_Parametros.SomarIPI;
    lPCG_Parametros.SomarFrete              := pPCG_Parametros.SomarFrete;
    lPCG_Parametros.ColunaOrdenacao         := pPCG_Parametros.ColunaOrdenacao;
    lPCG_Parametros.ColunaOrdenacaoOrdem    := pPCG_Parametros.ColunaOrdenacaoOrdem;

    Result := lPCGDao.objeto.ObterVendasResultado1(lPCG_Parametros);

  finally
    lPCGDao:=nil;
  end;
end;

function TPCGModel.ObterVendasResultado2(pPCG_Parametros: TPCG_Parametros): IFDDataset;
var
  lPCGDao: ITPCGDao;
  lPCG_Parametros: TPCG_Parametros;
begin
  lPCGDao := TPCGDao.getNewIface(vIConexao);

  try
    lPCG_Parametros.TipoData                := pPCG_Parametros.TipoData;
    lPCG_Parametros.DataInicio              := pPCG_Parametros.DataInicio;
    lPCG_Parametros.DataFim                 := pPCG_Parametros.DataFim;
    lPCG_Parametros.Vendedor                := pPCG_Parametros.Vendedor;
    lPCG_Parametros.Fornecedor              := pPCG_Parametros.Fornecedor;
    lPCG_Parametros.Grupo                   := pPCG_Parametros.Grupo;
    lPCG_Parametros.SubGrupo                := pPCG_Parametros.SubGrupo;
    lPCG_Parametros.Marca                   := pPCG_Parametros.Marca;
    lPCG_Parametros.Tipo                    := pPCG_Parametros.Tipo;
    lPCG_Parametros.Lojas                   := pPCG_Parametros.Lojas;
    lPCG_Parametros.FiliaisPor              := pPCG_Parametros.FiliaisPor;
    lPCG_Parametros.TipoAnalise             := pPCG_Parametros.TipoAnalise;
    lPCG_Parametros.SomarST                 := pPCG_Parametros.SomarST;
    lPCG_Parametros.SomarACrescimo          := pPCG_Parametros.SomarACrescimo;
    lPCG_Parametros.SomarIPI                := pPCG_Parametros.SomarIPI;
    lPCG_Parametros.SomarFrete              := pPCG_Parametros.SomarFrete;
    lPCG_Parametros.ColunaOrdenacao         := pPCG_Parametros.ColunaOrdenacao;
    lPCG_Parametros.ColunaOrdenacaoOrdem    := pPCG_Parametros.ColunaOrdenacaoOrdem;

    Result := lPCGDao.objeto.ObterVendasResultado2(lPCG_Parametros);

  finally
    lPCGDao:=nil;
  end;
end;

function TPCGModel.ObterEstoqueResultado1(pPCG_Parametros: TPCG_Parametros): IFDDataset;
var
  lPCGDao: ITPCGDao;
  lPCG_Parametros: TPCG_Parametros;
begin
  lPCGDao := TPCGDao.getNewIface(vIConexao);

  try
    lPCG_Parametros.TipoData                := pPCG_Parametros.TipoData;
    lPCG_Parametros.DataInicio              := pPCG_Parametros.DataInicio;
    lPCG_Parametros.DataFim                 := pPCG_Parametros.DataFim;
    lPCG_Parametros.Vendedor                := pPCG_Parametros.Vendedor;
    lPCG_Parametros.Fornecedor              := pPCG_Parametros.Fornecedor;
    lPCG_Parametros.Grupo                   := pPCG_Parametros.Grupo;
    lPCG_Parametros.SubGrupo                := pPCG_Parametros.SubGrupo;
    lPCG_Parametros.Marca                   := pPCG_Parametros.Marca;
    lPCG_Parametros.Tipo                    := pPCG_Parametros.Tipo;
    lPCG_Parametros.Lojas                   := pPCG_Parametros.Lojas;
    lPCG_Parametros.FiliaisPor              := pPCG_Parametros.FiliaisPor;
    lPCG_Parametros.TipoAnaliseEstoque      := pPCG_Parametros.TipoAnaliseEstoque;
    lPCG_Parametros.SomarST                 := pPCG_Parametros.SomarST;
    lPCG_Parametros.SomarACrescimo          := pPCG_Parametros.SomarACrescimo;
    lPCG_Parametros.SomarIPI                := pPCG_Parametros.SomarIPI;
    lPCG_Parametros.SomarFrete              := pPCG_Parametros.SomarFrete;
    lPCG_Parametros.ColunaOrdenacao         := pPCG_Parametros.ColunaOrdenacao;
    lPCG_Parametros.ColunaOrdenacaoOrdem    := pPCG_Parametros.ColunaOrdenacaoOrdem;

    Result := lPCGDao.objeto.ObterEstoqueResultado1(lPCG_Parametros);

  finally
    lPCGDao:=nil;
  end;
end;

end.
