unit GrupoDao;

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
  Terasoft.FuncoesTexto;

type
  TGrupoDao = class

  private

  public
    constructor Create;
    destructor Destroy; override;

    function ObterLista(pGrupo_Parametros: TGrupo_Parametros): TFDMemTable;

end;

implementation

uses
  Data.DB;

{ TPCG }

constructor TGrupoDao.Create;
begin

end;

destructor TGrupoDao.Destroy;
begin
  inherited;
end;

function TGrupoDao.ObterLista(pGrupo_Parametros: TGrupo_Parametros): TFDMemTable;
var
  lQry: TFDQuery;
  lSQL:String;
  lConexao: TConexao;
  lMemTable: TFDMemTable;
begin
  try
    lConexao := TConexao.Create;

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

    lQry := lConexao.CriarQuery;
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
    lConexao.Free;
  end;
end;


end.
