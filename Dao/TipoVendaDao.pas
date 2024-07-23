unit TipoVendaDao;

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
  Terasoft.Framework.ObjectIface,
  Terasoft.FuncoesTexto;

type
  TTipoVendaDao = class

  private
     vConexao : IConexao;
  public
    constructor Create(pConexao : IConexao);
    destructor Destroy; override;

    function ObterLista(pTipoVenda_Parametros: TTipoVenda_Parametros): IFDDataset;

end;

implementation

uses
  Data.DB;

{ TPCG }

constructor TTipoVendaDao.Create(pConexao : IConexao);
begin
  vConexao := pConexao;
end;

destructor TTipoVendaDao.Destroy;
begin
  inherited;
end;

function TTipoVendaDao.ObterLista(pTipoVenda_Parametros: TTipoVenda_Parametros): IFDDataset;
var
  lQry: TFDQuery;
  lSQL:String;
  lMemTable: IFDDataset;
begin
  try

    lMemTable := TImplObjetoOwner<TDataset>.CreateOwner(TFDMemTable.Create(nil));

    lSQL := 'Select CODIGO_TV,      ' + #13 +
            '       NOME_TV         ' + #13 +
            'From TIPOVENDA          ' + #13 +
            'Order by NOME_TV       ' + #13;

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

    lQry := vConexao.CriarQuery;
    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      lMemTable.objeto.InsertRecord([
                              lQry.FieldByName('CODIGO_TV').AsString,
                              lQry.FieldByName('NOME_TV').AsString
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
