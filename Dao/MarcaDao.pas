unit MarcaDao;

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
  Interfaces.Conexao,
  Terasoft.FuncoesTexto;

type
  TMarcaDao = class

  private
    vIConexao : IConexao;
  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function ObterLista(pMarca_Parametros: TMarca_Parametros): TFDMemTable;

end;

implementation

uses
  Data.DB;

{ TPCG }

constructor TMarcaDao.Create(pIConexao : IConexao);
begin
    vIConexao := pIConexao;
end;

destructor TMarcaDao.Destroy;
begin
  inherited;
end;

function TMarcaDao.ObterLista(pMarca_Parametros: TMarca_Parametros): TFDMemTable;
var
  lQry: TFDQuery;
  lSQL:String;
  lMemTable: TFDMemTable;
begin
  try


    lMemTable := TFDMemTable.Create(nil);

    lSQL := 'Select CODIGO_MAR,       ' + #13 +
            '       NOME_MAR         ' + #13 +
            'From MARCAPRODUTO        ' + #13 +
            'Order by NOME_MAR       ' + #13;

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

    lQry := vIConexao.CriarQuery;
    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      lMemTable.InsertRecord([
                              lQry.FieldByName('CODIGO_MAR').AsString,
                              lQry.FieldByName('NOME_MAR').AsString
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
