unit CurvaABCModel;

interface

uses
  Terasoft.Types,
  Terasoft.Framework.Texto,
  CurvaABCDao,
  FireDAC.Comp.Client,
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TCurvaABCModel = class;
  ITCurvaABCModel=IObject<TCurvaABCModel>;

  TCurvaABCModel = class
  private
    [unsafe] mySelf: ITCurvaABCModel;
    vIConexao : IConexao;
  protected
      fResultadoOperacao: IResultadoOperacao;

    //property resultadoOperacao getter/setter
      function getResultadoOperacao: IResultadoOperacao;
      procedure setResultadoOperacao(const pValue: IResultadoOperacao);

  public

  	constructor _Create(pIConexao : IConexao);
    destructor Destroy; override;

    class function getNewIface(pIConexao: IConexao): ITCurvaABCModel;

    function ObterCurvaABC(pCurvaABC_Parametros: TCurvaABC_Parametros): IFDDataset;

    property resultadoOperacao: IResultadoOperacao read getResultadoOperacao write setResultadoOperacao;

  end;

implementation

uses
  System.SysUtils;

{ TCurvaABCModel }

constructor TCurvaABCModel._Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TCurvaABCModel.Destroy;
begin

  inherited;
end;

{ TCurvaABCModel }

procedure TCurvaABCModel.setResultadoOperacao(const pValue: IResultadoOperacao);
begin
  fResultadoOperacao := pValue;
end;

function TCurvaABCModel.getResultadoOperacao: IResultadoOperacao;
begin
  Result := checkResultadoOperacao(fResultadoOperacao);
end;

class function TCurvaABCModel.getNewIface(pIConexao: IConexao): ITCurvaABCModel;
begin
  Result := TImplObjetoOwner<TCurvaABCModel>.CreateOwner(self._Create(pIConexao));
  Result.objeto.myself := Result;
end;

function TCurvaABCModel.ObterCurvaABC(pCurvaABC_Parametros: TCurvaABC_Parametros): IFDDataset;
var
  lCurvaABCDao: ITCurvaABCDao;
  lCurvaABC_Parametros: TCurvaABC_Parametros;
begin
  lCurvaABCDao := TCurvaABCDao.getNewIface(vIConexao);

  try
    fResultadoOperacao := nil;
    lCurvaABC_Parametros.TipoData                := pCurvaABC_Parametros.TipoData;
    lCurvaABC_Parametros.DataInicio              := pCurvaABC_Parametros.DataInicio;
    lCurvaABC_Parametros.DataFim                 := pCurvaABC_Parametros.DataFim;
    lCurvaABC_Parametros.TipoAnalise             := pCurvaABC_Parametros.TipoAnalise;
    lCurvaABC_Parametros.ClassificarPor          := pCurvaABC_Parametros.ClassificarPor;
    lCurvaABC_Parametros.SomarST                 := pCurvaABC_Parametros.SomarST;
    lCurvaABC_Parametros.SomarACrescimo          := pCurvaABC_Parametros.SomarACrescimo;
    lCurvaABC_Parametros.SomarIPI                := pCurvaABC_Parametros.SomarIPI;
    lCurvaABC_Parametros.SomarFrete              := pCurvaABC_Parametros.SomarFrete;
    lCurvaABC_Parametros.Produto                 := pCurvaABC_Parametros.Produto;
    lCurvaABC_Parametros.Fornecedor              := pCurvaABC_Parametros.Fornecedor;
    lCurvaABC_Parametros.Grupo                   := pCurvaABC_Parametros.Grupo;
    lCurvaABC_Parametros.SubGrupo                := pCurvaABC_Parametros.SubGrupo;
    lCurvaABC_Parametros.Marca                   := pCurvaABC_Parametros.Marca;
    lCurvaABC_Parametros.Grade                   := pCurvaABC_Parametros.Grade;
    lCurvaABC_Parametros.Lojas                   := pCurvaABC_Parametros.Lojas;
    lCurvaABC_Parametros.Atividade               := pCurvaABC_Parametros.Atividade;
    lCurvaABC_Parametros.TipoSaida               := pCurvaABC_Parametros.TipoSaida;
    lCurvaABC_Parametros.Cliente                 := pCurvaABC_Parametros.Cliente;
    lCurvaABC_Parametros.Vendedor                := pCurvaABC_Parametros.Vendedor;
    lCurvaABC_Parametros.Gerente                 := pCurvaABC_Parametros.Gerente;
    lCurvaABC_Parametros.Cidade                  := pCurvaABC_Parametros.Cidade;
    lCurvaABC_Parametros.UF                      := pCurvaABC_Parametros.UF;
    lCurvaABCDao.objeto.resultadoOperacao := getResultadoOperacao;

    Result := lCurvaABCDao.objeto.ObterCurvaABC(lCurvaABC_Parametros);

  finally
    lCurvaABCDao:=nil;
  end;
end;

end.
