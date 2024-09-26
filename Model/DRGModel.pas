unit DRGModel;

interface

uses
  Terasoft.Types,
  FireDAC.Comp.Client,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TDRGModel = class;
  ITDRGModel=IObject<TDRGModel>;

  TDRGModel = class
  private
    [unsafe] mySelf:ITDRGModel;
    vIConexao : IConexao;
  public
    constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITDRGModel;

    function ObterLista(pDRG_Parametros: TDRG_Parametros): IFDDataset;
    function ObterListaDetalhes(pDRG_Detalhes_Parametros: TDRG_Detalhes_Parametros): IFDDataset;

  end;

implementation

uses
  DRGDao, System.SysUtils, Data.DB;

{ TDRGModel }

constructor TDRGModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TDRGModel.Destroy;
begin

  inherited;
end;

class function TDRGModel.getNewIface(pIConexao: IConexao): ITDRGModel;
begin
  Result := TImplObjetoOwner<TDRGModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TDRGModel.ObterLista(pDRG_Parametros: TDRG_Parametros): IFDDataset;
var
  lDRGDao: ITDRGDao;
  lDRG_Parametros: TDRG_Parametros;
begin
  lDRGDao := TDRGDao.getNewIface(vIConexao);

  try
    lDRG_Parametros.DataInicio              := pDRG_Parametros.DataInicio;
    lDRG_Parametros.DataFim                 := pDRG_Parametros.DataFim;
    lDRG_Parametros.MesAno                  := pDRG_Parametros.MesAno;
    lDRG_Parametros.Ano                     := pDRG_Parametros.Ano;
    lDRG_Parametros.Nivel                   := pDRG_Parametros.Nivel;
    lDRG_Parametros.ApresentarContasZeradas := pDRG_Parametros.ApresentarContasZeradas;
    lDRG_Parametros.ListarCMV               := True;
    lDRG_Parametros.ListarDevolucao         := True;
    lDRG_Parametros.ConsiderarDesconto      := True;
    lDRG_Parametros.VisializarGrupoProduto  := False;
    lDRG_Parametros.SomarST                 := False;
    lDRG_Parametros.SomarACrescimo          := False;
    lDRG_Parametros.SomarIPI                := False;
    lDRG_Parametros.SomarFrete              := False;
    lDRG_Parametros.TipoAnalise             := pDRG_Parametros.TipoAnalise;
    lDRG_Parametros.NivelVisualizacao       := pDRG_Parametros.NivelVisualizacao;
    lDRG_Parametros.FiltroGrupo             := pDRG_Parametros.FiltroGrupo;
    lDRG_Parametros.FiltroSubGrupo          := pDRG_Parametros.FiltroSubGrupo;
    lDRG_Parametros.Lojas                   := pDRG_Parametros.Lojas;
    lDRG_Parametros.ValorPrincipal          := pDRG_Parametros.ValorPrincipal;
    lDRG_Parametros.DataPadrao              := pDRG_Parametros.DataPadrao;

    Result := lDRGDao.objeto.obterLista(lDRG_Parametros);

  finally
    lDRGDao:=nil;
  end;
end;


function TDRGModel.ObterListaDetalhes(pDRG_Detalhes_Parametros: TDRG_Detalhes_Parametros): IFDDataset;
var
  lDRGDao: ITDRGDao;
  lDRG_Detalhes_Parametros: TDRG_Detalhes_Parametros;
begin
  lDRGDao := TDRGDao.getNewIface(vIConexao);

  try
    lDRG_Detalhes_Parametros.DataInicio              := pDRG_Detalhes_Parametros.DataInicio;
    lDRG_Detalhes_Parametros.DataFim                 := pDRG_Detalhes_Parametros.DataFim;
    lDRG_Detalhes_Parametros.MesAno                  := pDRG_Detalhes_Parametros.MesAno;
    lDRG_Detalhes_Parametros.Ano                     := pDRG_Detalhes_Parametros.Ano;
    lDRG_Detalhes_Parametros.Conta                   := pDRG_Detalhes_Parametros.Conta;
    lDRG_Detalhes_Parametros.Lojas                   := pDRG_Detalhes_Parametros.Lojas;

    Result := lDRGDao.objeto.ObterDRG_Detalhes(lDRG_Detalhes_Parametros);

  finally
    lDRGDao:=nil;
  end;
end;

end.
