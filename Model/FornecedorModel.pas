unit FornecedorModel;

interface

uses
  Terasoft.Types,
  FornecedorDao,
  FireDAC.Comp.Client,
  Interfaces.Conexao;

type
  TFornecedorModel = class

  private
    vIConexao : IConexao;
  public

  	constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function ObterLista(pFornecedor_Parametros: TFornecedor_Parametros): TFDMemTable;

  end;

implementation

uses
  System.SysUtils;

{ TFornecedorModel }

constructor TFornecedorModel.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TFornecedorModel.Destroy;
begin

  inherited;
end;

function TFornecedorModel.ObterLista(pFornecedor_Parametros: TFornecedor_Parametros): TFDMemTable;
var
  lFornecedorDao: TFornecedorDao;
  lFornecedor_Parametros: TFornecedor_Parametros;
begin
  lFornecedorDao := TFornecedorDao.Create(vIConexao);

  try
    lFornecedor_Parametros.Fornecedores := pFornecedor_Parametros.Fornecedores;

    Result := lFornecedorDao.ObterLista(lFornecedor_Parametros);

  finally
    lFornecedorDao.Free;
  end;
end;

end.
