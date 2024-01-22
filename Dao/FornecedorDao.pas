unit FornecedorDao;

interface

uses
  Conexao,
  SistemaControl, 
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  Terasoft.Web.Types,
  Terasoft.Framework.ListaSimples.Impl,
  Terasoft.Framework.ListaSimples,
  Terasoft.Framework.SimpleTypes,
  Terasoft.FuncoesTexto;

type
  TFornecedorDao = class

  private

  public
    constructor Create;
    destructor Destroy; override;

    function ObterLista(pFornecedor_Parametros: TFornecedor_Parametros): TFDMemTable;

end;

implementation

uses
  Data.DB;

{ TPCG }

constructor TFornecedorDao.Create;
begin

end;

destructor TFornecedorDao.Destroy;
begin
  inherited;
end;

function TFornecedorDao.ObterLista(pFornecedor_Parametros: TFornecedor_Parametros): TFDMemTable;
var
  lQry: TFDQuery;
  lSQL:String;
  lConexao: TConexao;
  lMemTable: TFDMemTable;
begin
  try
    lConexao := TConexao.Create;

    lMemTable := TFDMemTable.Create(nil);

    lSQL := 'Select CODIGO_FOR,       ' + #13 +
            '       RAZAO_FOR         ' + #13 +
            'From FORNECEDOR          ' + #13 +
            'Order by RAZAO_FOR       ' + #13;

    with lMemTable.IndexDefs.AddIndexDef do
    begin
      Name := 'OrdenacaoRazao';
      Fields := 'RAZAO';
      Options := [TIndexOption.ixCaseInsensitive];
    end;

    lMemTable.IndexName := 'OrdenacaoRazao';

    lMemTable.FieldDefs.Add('CODIGO', ftString, 6);
    lMemTable.FieldDefs.Add('RAZAO', ftString, 40);
    lMemTable.CreateDataSet;

    lQry := lConexao.CriarQuery;
    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      lMemTable.InsertRecord([
                              lQry.FieldByName('CODIGO_FOR').AsString,
                              lQry.FieldByName('RAZAO_FOR').AsString
                             ]);

      lQry.Next;
    end;

    lMemTable.Open;

    Result := lMemTable;

  finally
    lQry.Free;
    lConexao.Free;
  end;
end;


end.
