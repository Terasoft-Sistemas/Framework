unit FornecedorModel;

interface

uses
  Terasoft.Enumerado,
  Terasoft.Web.Types,
  FornecedorDao,
  FireDAC.Comp.Client;

type
  TFornecedorModel = class

  private

 public

  	constructor Create;
    destructor Destroy; override;

    function ObterLista(pFornecedor_Parametros: TFornecedor_Parametros): TFDMemTable;

  end;

implementation

uses
  System.SysUtils;

{ TFornecedorModel }

constructor TFornecedorModel.Create;
begin

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
  lFornecedorDao := TFornecedorDao.Create;

  try
    lFornecedor_Parametros.Fornecedores := pFornecedor_Parametros.Fornecedores;

    Result := lFornecedorDao.ObterLista(lFornecedor_Parametros);

  finally
    lFornecedorDao.Free;
  end;
end;

end.
