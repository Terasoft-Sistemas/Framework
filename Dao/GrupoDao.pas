unit GrupoDao;

interface

uses
  Terasoft.Utils,
  FireDAC.Comp.Client,
  System.SysUtils,
  System.StrUtils,
  System.Variants,
  Terasoft.Types,
  Terasoft.FuncoesTexto,
  Interfaces.Conexao;

type
  TGrupoDao = class

  private
    vIConexao : IConexao;
  public
    constructor Create(pIConexao : IConexao);
    destructor Destroy; override;

    function ObterLista(pGrupo_Parametros: TGrupo_Parametros): TFDMemTable;

end;

implementation

uses
  Data.DB;

{ TPCG }

constructor TGrupoDao.Create(pIConexao : IConexao);
begin
  vIConexao := pIConexao;
end;

destructor TGrupoDao.Destroy;
begin
  inherited;
end;

function TGrupoDao.ObterLista(pGrupo_Parametros: TGrupo_Parametros): TFDMemTable;
var
  lQry: TFDQuery;
  lSQL:String;
  lMemTable: TFDMemTable;
begin
  try
    lMemTable := TFDMemTable.Create(nil);

    lSQL := 'Select CODIGO_GRU,       ' + #13 +
            '       NOME_GRU         ' + #13 +
            'From GRUPOPRODUTO        ' + #13 +
            'Order by NOME_GRU       ' + #13;

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
                              lQry.FieldByName('CODIGO_GRU').AsString,
                              lQry.FieldByName('NOME_GRU').AsString
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
