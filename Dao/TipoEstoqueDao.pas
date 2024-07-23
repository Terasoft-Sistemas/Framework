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
  Terasoft.Framework.ObjectIface,
  Interfaces.Conexao;

type
  TTipoEstoqueDao = class

  private
    vIConexao : IConexao;
  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function ObterLista(pTipoEstoque_Parametros: TTipoEstoque_Parametros): IFDDataset;

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

function TTipoEstoqueDao.ObterLista(pTipoEstoque_Parametros: TTipoEstoque_Parametros): IFDDataset;
var
  lQry: TFDQuery;
  lSQL:String;
  lMemTable: IFDDataset;
begin
  try
    lMemTable := TImplObjetoOwner<TDataset>.CreateOwner(TFDMemTable.Create(nil));

    lSQL := 'Select ID, NOME   ' + #13 +
            'From PRODUTO_TIPO ' + #13 +
            'Order by NOME     ' + #13;

    with TFDMemTable(lMemTable.objeto).IndexDefs.AddIndexDef do
    begin
      Name := 'OrdenacaoNome';
      Fields := 'NOME';
      Options := [TIndexOption.ixCaseInsensitive];
    end;

    TFDMemTable(lMemTable.objeto).IndexName := 'OrdenacaoNome';

    TFDMemTable(lMemTable.objeto).FieldDefs.Add('CODIGO', ftString, 6);
    TFDMemTable(lMemTable.objeto).FieldDefs.Add('NOME', ftString, 40);
    TFDMemTable(lMemTable.objeto).CreateDataSet;

    lQry := vIConexao.CriarQuery;
    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      lMemTable.objeto.InsertRecord([
                              lQry.FieldByName('ID').AsString,
                              lQry.FieldByName('NOME').AsString
                             ]);

      lQry.Next;
    end;

    lMemTable.objeto.Open;

    Result := lMemTable;

  finally
    lQry.Free;
  end;
end;


end.
