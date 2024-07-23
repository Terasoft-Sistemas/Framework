unit VendedorDao;

interface

uses
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  Terasoft.Types,
  Terasoft.Framework.ObjectIface,
  Terasoft.Framework.ListaSimples.Impl,
  Terasoft.Framework.ListaSimples,
  Terasoft.Framework.SimpleTypes,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao;

type
  TVendedorDao = class

  private
    vIConexao : IConexao;
  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function ObterLista(pVendedor_Parametros: TVendedor_Parametros): IFDDataset;

end;

implementation

uses
  Data.DB;

{ TPCG }

constructor TVendedorDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TVendedorDao.Destroy;
begin
  inherited;
end;

function TVendedorDao.ObterLista(pVendedor_Parametros: TVendedor_Parametros): IFDDataset;
var
  lQry: TFDQuery;
  lSQL:String;
  lMemTable: IFDDataset;
begin
  try
    lMemTable := TImplObjetoOwner<TDataset>.CreateOwner(TFDMemTable.Create(nil));

    lSQL := 'Select CODIGO_FUN,      ' + #13 +
            '       NOME_FUN         ' + #13 +
            'From Funcionario        ' + #13 +
            'Where TIPO_VEN = ''S''  ' + #13 +
            'Order by NOME_FUN       ' + #13;

    with TFDMemTable(lMemTable.objeto).IndexDefs.AddIndexDef do
    begin
      Name := 'OrdenacaoRazao';
      Fields := 'RAZAO';
      Options := [TIndexOption.ixCaseInsensitive];
    end;

    TFDMemTable(lMemTable.objeto).IndexName := 'OrdenacaoRazao';

    TFDMemTable(lMemTable.objeto).FieldDefs.Add('CODIGO', ftString, 6);
    TFDMemTable(lMemTable.objeto).FieldDefs.Add('RAZAO', ftString, 40);
    TFDMemTable(lMemTable.objeto).CreateDataSet;

    lQry := vIConexao.CriarQuery;
    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      lMemTable.objeto.InsertRecord([
                              lQry.FieldByName('CODIGO_FUN').AsString,
                              lQry.FieldByName('NOME_FUN').AsString
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
