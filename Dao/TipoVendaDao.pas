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
  Terasoft.FuncoesTexto;

type
  TTipoVendaDao = class

  private
     vConexao : IConexao;
  public
    constructor Create(pConexao : IConexao);
    destructor Destroy; override;

    function ObterLista(pTipoVenda_Parametros: TTipoVenda_Parametros): TFDMemTable;

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

function TTipoVendaDao.ObterLista(pTipoVenda_Parametros: TTipoVenda_Parametros): TFDMemTable;
var
  lQry: TFDQuery;
  lSQL:String;
  lMemTable: TFDMemTable;
begin
  try

    lMemTable := TFDMemTable.Create(nil);

    lSQL := 'Select CODIGO_TV,      ' + #13 +
            '       NOME_TV         ' + #13 +
            'From TIPOVENDA          ' + #13 +
            'Order by NOME_TV       ' + #13;

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

    lQry := vConexao.CriarQuery;
    lQry.Open(lSQL);

    lQry.First;
    while not lQry.Eof do
    begin
      lMemTable.InsertRecord([
                              lQry.FieldByName('CODIGO_TV').AsString,
                              lQry.FieldByName('NOME_TV').AsString
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
