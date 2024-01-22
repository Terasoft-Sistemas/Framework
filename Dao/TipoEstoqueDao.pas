unit TipoEstoqueDao;

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
  TTipoEstoqueDao = class

  private

  public
    constructor Create;
    destructor Destroy; override;

    function ObterLista(pTipoEstoque_Parametros: TTipoEstoque_Parametros): TFDMemTable;

end;

implementation

uses
  Data.DB;

{ TPCG }

constructor TTipoEstoqueDao.Create;
begin

end;

destructor TTipoEstoqueDao.Destroy;
begin
  inherited;
end;

function TTipoEstoqueDao.ObterLista(pTipoEstoque_Parametros: TTipoEstoque_Parametros): TFDMemTable;
var
  lQry: TFDQuery;
  lSQL:String;
  lConexao: TConexao;
  lMemTable: TFDMemTable;
begin
  try
    lConexao := TConexao.Create;

    lMemTable := TFDMemTable.Create(nil);

    lSQL := 'Select ID, NOME   ' + #13 +
            'From PRODUTO_TIPO ' + #13 +
            'Order by NOME     ' + #13;

    with lMemTable.IndexDefs.AddIndexDef do
    begin
      Name := 'OrdenacaoNome';
      Fields := 'NOME';
      Options := [TIndexOption.ixCaseInsensitive];
    end;

    lMemTable.IndexName := 'OrdenacaoNome';

    lMemTable.FieldDefs.Add('CODIGO', ftString, 6);
    lMemTable.FieldDefs.Add('NOME', ftString, 40);
    lMemTable.CreateDataSet;

    lQry := lConexao.CriarQuery;
    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      lMemTable.InsertRecord([
                              lQry.FieldByName('ID').AsString,
                              lQry.FieldByName('NOME').AsString
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
