unit TipoEstoqueDao;

interface

uses
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  Terasoft.Types,
  Terasoft.Framework.ListaSimples.Impl,
  Terasoft.Framework.ListaSimples,
  Terasoft.Framework.SimpleTypes,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao;

type
  TTipoEstoqueDao = class

  private
    vIConexao : IConexao;
  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function ObterLista(pTipoEstoque_Parametros: TTipoEstoque_Parametros): TFDMemTable;

end;

implementation

uses
  Data.DB;

{ TPCG }

constructor TTipoEstoqueDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TTipoEstoqueDao.Destroy;
begin
  inherited;
end;

function TTipoEstoqueDao.ObterLista(pTipoEstoque_Parametros: TTipoEstoque_Parametros): TFDMemTable;
var
  lQry: TFDQuery;
  lSQL:String;
  lMemTable: TFDMemTable;
begin
  try
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

    lQry := vIConexao.CriarQuery;
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
  end;
end;


end.
