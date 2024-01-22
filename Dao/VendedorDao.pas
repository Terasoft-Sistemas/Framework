unit VendedorDao;

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
  TVendedorDao = class

  private

  public
    constructor Create;
    destructor Destroy; override;

    function ObterLista(pVendedor_Parametros: TVendedor_Parametros): TFDMemTable;

end;

implementation

uses
  Data.DB;

{ TPCG }

constructor TVendedorDao.Create;
begin

end;

destructor TVendedorDao.Destroy;
begin
  inherited;
end;

function TVendedorDao.ObterLista(pVendedor_Parametros: TVendedor_Parametros): TFDMemTable;
var
  lQry: TFDQuery;
  lSQL:String;
  lConexao: TConexao;
  lMemTable: TFDMemTable;
begin
  try
    lConexao := TConexao.Create;

    lMemTable := TFDMemTable.Create(nil);

    lSQL := 'Select CODIGO_FUN,      ' + #13 +
            '       NOME_FUN         ' + #13 +
            'From Funcionario        ' + #13 +
            'Where TIPO_VEN = ''S''  ' + #13 +
            'Order by NOME_FUN       ' + #13;

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
                              lQry.FieldByName('CODIGO_FUN').AsString,
                              lQry.FieldByName('NOME_FUN').AsString
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
